From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: handle non UTF-8 text
Date: Tue, 29 May 2007 11:21:11 +0200
Message-ID: <200705291121.12119.jnareb@gmail.com>
References: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at> <20070528232139.GU4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>
To: Petr Baudis <pasky@suse.cz>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue May 29 14:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht0pO-0000Aa-Df
	for gcvg-git@gmane.org; Tue, 29 May 2007 14:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbXE2M3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 May 2007 08:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbXE2M3X
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 08:29:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:9185 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbXE2M3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 08:29:22 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1846884ugf
        for <git@vger.kernel.org>; Tue, 29 May 2007 05:29:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=IG9CqiHuq0WJpOKmEDCtL0Q/dge98kHQXh6s2iqh/UzOJx7QCpbbwHJKpKrDQAoN3MW1uEKOSCi/tSdXJBTdFE7W2Bx+dIEqvgyXp5b3owdcXMPz+7qtRr364jh511uWMlgHL58iXibeQkYzO+0XdRDsSOMM4Og7HgdAZKZP4Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=g6zvRxTe+n+4gZ+lIje64KJJlqsofSrFcA3T6RSqQb8XbdOtsbFmDfXGa+u7/VMs1WX2ddLqAYKFMhdxo43zFQO6XZSVIwWeOPfzknYrdTLviOcCXxjcBinWwCyTFTFu36nuFv58+wlnF72PCZbkv402+MsrmmuNwAbBuLuolPU=
Received: by 10.66.220.17 with SMTP id s17mr6007706ugg.1180441761085;
        Tue, 29 May 2007 05:29:21 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id o1sm7432772uge.2007.05.29.05.29.17;
        Tue, 29 May 2007 05:29:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070528232139.GU4489@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48688>

[Cc: authors of git-cvsserver]

On Tue, 29 May 2007, Petr Baudis wrote:
> On Mon, May 28, 2007 at 10:47:34PM CEST, Martin Koegler wrote:

>> gitweb assumes, that everything is in UTF-8. If a text contains inva=
lid
>> UTF-8 character sequences, the text must be in a different encoding.

But it doesn't tell us _what_ is the encoding. For commit messages,
with reasonable new git, we have 'encoding' header if git known that
commit message was not in utf-8.

By the way, I winder why we don't have such header for tag objects
(i18n.tagEncoding ;-)...
=20
>> This patch interprets such a text as latin1.

Meaning that it tries to recode text from latin1 (iso-8859-1) to utf-8
(not changing gitweb output encoding, which is utf-8).

It would be much better, and much easier at least for commit message
to add --encoding=3Dutf-8 to git-rev-list / git-log invocation.

>> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
>> ---
>> For correct UTF-8, the patch does not change anything.
>>=20
>> If commit/blob/... is not in UTF-8, it displays the text
>> with a very high probability correct.=20

It is commit (with its 'encoding' header, and `--encoding' option
we can use instead of doing it in gitweb, provided that git was
compiled with iconv support), tag (similar to commit, but IIRC
without 'encoding' header, and `--encoding' option), blob (with
no place to store encoding) and pathname in tree (which can be
different from blob encoding).

And I doubt very much about this "very high probability to be
correct".

>> As git itself is not aware of any encoding, I know no better
>> possibility to handle non UTF-8 text in gitweb.
>=20
> I don't think this is a reasonable approach; I actually dispute the h=
igh
> probability - in western Europe it's obvious to assume latin1, but do=
es
> majority of users using non-ascii characters come from there? Or rath=
er
> from central Europe (like me, Petr Baudi=C5=A1? ;-))? Somewhere else?

I also don't think that hardcoding latin1 (iso-8859-1) as default
alternate encoding is a good idea. I don't think using iso-8859-1
(outside us-ascii) is _nowadays_ that common. On the other hand I think
that not all users of koi8r, eucjp or iso-2022-jp converted (and can
convert) to utf-8; latin1 users can.

And using latin1 (other encoding) _only_ when there is an invalid utf-8
sequence is not a good idea either; I think that that there are some
latin1 sequences outside us-ascii which are valid utf-8 sequences. That
kind of magic is wrong, wrong, wrong...

> If we do something like this, we should do it properly and look at
> configured i18n.commitEncoding for the project. (But as config lookup
> may be expensive, probably do it only when we need it.)

I think it would be best to make it into %feature, overridable
or not (which would look at i18n.commitEncoding instead of at
gitweb.commitEncoding, but still a feature).

About config lookup: we can either "borrow" config reading code in Perl
from git-cvsserver, perhaps via putting it into Git.pm. Or we can
implement at last core git support for dumping whole config in
unambiguous machine parseable output: "git config --dump", e.g.
  key <LF> value <NUL>
or
  key <NUL>
(the second for "boolean" variables without set value).

Having alternate (read-only) config parser has its advantages and
disadvantages. Advantage is that we avoid fork+exec (performance),
and having two implementations is always good for having format
standarized. Disadvantage is that is yet another code to maintain,
and that config parsing (even read-only config parsing) is a bit tricky
with current git config file format.

--=20
Jakub Narebski
Poland
