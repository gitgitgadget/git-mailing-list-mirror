From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: parse_commit_text encoding fix
Date: Fri, 7 Aug 2009 22:31:33 +0200
Message-ID: <200908072231.35707.jnareb@gmail.com>
References: <9ab80d150908010955l3710c54bp9e2716570fd1d5ed@mail.gmail.com> <7viqh43vz3.fsf@alter.siamese.dyndns.org> <9ab80d150908060115q4b56b2e5xb327e09cda7e2b7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?q?Zolt=C3=A1n_F=C3=BCzesi?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:32:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZW6a-0008G6-Ce
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 22:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933758AbZHGUbk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Aug 2009 16:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933749AbZHGUbk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 16:31:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:64459 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932704AbZHGUbj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 16:31:39 -0400
Received: by fg-out-1718.google.com with SMTP id e12so157302fga.17
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=O6U/f+d2c4CeJcM+7meyKw/CO+Nd5O1JhClA4oaivgk=;
        b=qZg5Lq2ZAAzjd/Dth0OE7dN+AFPJIbFFs+bjf3WsHrBksnmfdZGSLEMIkfrIZBTCvg
         YOX3LmxIPWwdB3XnB1Ms3cImyqEmgR7WD/D+JHC+D6MrdouryE1EZK+icrI1jE1bsxuI
         d1N+/CHt6UiOqFC/EXmlISp1gyxOHNfI9pKGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KypmhX6QrMnzHfy5Mm5ZyILoazS49XqTDX/GR3wI30GXsexpQF912yOZjTH5FhLDls
         hlJSgzAAvpkP5b2xhrqhQ+hna+SngicRwsSxr0yAKsmNS1lCyeYQCQDon9fITEMD+0Jg
         aZ42Vb8lKJ9JXFtkCbR8tI0lNvlraGQLIvsz4=
Received: by 10.86.65.1 with SMTP id n1mr1218650fga.38.1249677099219;
        Fri, 07 Aug 2009 13:31:39 -0700 (PDT)
Received: from ?192.168.1.13? (abvf93.neoplus.adsl.tpnet.pl [83.8.203.93])
        by mx.google.com with ESMTPS id l19sm4385214fgb.27.2009.08.07.13.31.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 13:31:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <9ab80d150908060115q4b56b2e5xb327e09cda7e2b7a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125220>

On Thu, 6 Aug 2009, Zolt=C3=A1n F=C3=BCzesi wrote:
> 2009/8/4 Junio C Hamano <gitster@pobox.com>:
> >
> > Thanks, Zolt=C3=A1n.
> >
> > We should be able to set up a script that scrapes the output to tes=
t this
> > kind of thing. =C2=A0We may not want to have a test pattern that ma=
tches too
> > strictly for the current structure and appearance of the output
> > (e.g. counting nested <div>s, presentation styles and such), but if=
 we can
> > robustly scrape off HTML tags (e.g. "elinks -dump") and check the
> > remaining payload, it might be enough.
> >
> > Jakub what do you think? =C2=A0I suspect that scraping approach may=
 turn out to
> > be too fragile for tests to be worth doing, but I am just throwing =
out a
> > thought.
> >
>=20
> This issue comes out when chop_and_escape_str function is called with
> a non-ascii string (like my name :)) without before calling to_utf8 o=
n
> it. "author_name" and "committer_name" are two examples, and
> "author_name" shows up with bad encoding in HTML.
>=20
> Example from one of my repos (little piece from shortlog output):
> <td class=3D"author"><span title=3D"F=C3=83=C2=BCzesi Zolt=C3=83=C2=A1=
n">F=C3=BCzesi Zolt=C3=A1n</span></td>
> After applying the patch:
> <td class=3D"author">F=C3=BCzesi Zolt=C3=A1n</td>
>=20
> This is an "old" (seen in 1.5.6 version too) and (I think) minor issu=
e.
> I haven't spent time on thinking how a test script could show this ye=
t.
> Waiting for Jakub's reaction.

Oh, so the problem is not only to just have correct output (for example
"F=C3=BCzesi Zolt=C3=A1n" somewhere on HTML page produced by gitweb), b=
ut also do
not have incorrect output (for example "F=C3=83=C2=BCzesi Zolt=C3=83=C2=
=A1n").

I think it would be better to leave t9500-gitweb-standalone-no-errors.s=
h
to be only about no Perl errors and no Perl warnings.  So I'd rather
have test checking if gitweb handles non US-ASCII in output correctly
in a separate test, e.g. t9501-gitweb-standalone-i18n.sh.  That would
mean extracting gitweb_init() and gitweb_run() (and perhaps also
gitweb_check_prereq() or something) into common file t/lib-gitweb.sh

We would check e.g. if "start=C3=A1=C4=85end" is present in output (cor=
rect output),
and whether extracting "start[^ ]*end" produces only "start=C3=A1=C4=85=
end" (no
incorrect output).


As for gitweb, we should make sure that everything is stored in Perl
variables and Perl structures _after_ treating with to_utf8().  This
would require some cleanup of the code, and having such test would
help to check if we didn't introduce any regressions.

--=20
Jakub Narebski
Poland
