From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and tar options
Date: Fri, 15 Jul 2011 22:59:46 +0200
Message-ID: <4E20AA42.7000003@lsrfire.ath.cx>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net> <7vei1s36bl.fsf@alter.siamese.dyndns.org> <20110714212502.GA29848@sigill.intra.peff.net> <7vwrfk1lv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Neal Kreitzinger <neal@rsss.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:00:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhpUQ-0005ac-FB
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab1GOU74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jul 2011 16:59:56 -0400
Received: from india601.server4you.de ([85.25.151.105]:34968 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab1GOU7z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 16:59:55 -0400
Received: from [192.168.2.106] (p4FFD9307.dip.t-dialin.net [79.253.147.7])
	by india601.server4you.de (Postfix) with ESMTPSA id CEFB62F802E;
	Fri, 15 Jul 2011 22:59:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7vwrfk1lv3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177228>

Am 15.07.2011 01:30, schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>=20
>>> Why?
>>>
>>> The tree you are writing out that way look very different from what=
 is
>>> recorded in the commit object. What's the point of introducing conf=
usion
>>> by allowing many tarballs with different contents written from the =
same
>>> commits with such tweaks all labelled with the same pax header?
>>
>> See my later message. I think it depends on how the embedded id is u=
sed.
>> Is it to say "this represents the tree of this git commit"? Or is it=
 to
>> help people who later have a tarball and have no clue which commit i=
t
>> might have come from?
>=20
> People, who have no clue which part of the subtree was extract and wh=
at
> leading path was added, would still have to wonder where the tree cam=
e
> from even with the embedded id. Without your patch, if the tarball ha=
s an
> embedded id, wouldn't they at least be able to assume it is the whole
> thing of that commit? If you label a randomly mutated tree with the s=
ame
> label, you cannot tell the genuine one from manipulated ones.
>=20
> Not that I have strong opinions on this, either, but that is what I m=
eant
> by "_introducing_" confusion.

When we started to write the ID into generated archives, there was only
git-tar-tree and no <rev>:<path> syntax.  It would write the ID only if
it was given a commit and not if it got a tree or if the user started i=
t
from a subdirectory.  The result was that only the full tree of a commi=
t
was branded with the commit ID.

Now we have git archive, a more flexible command line syntax all around=
,
path limiting as well as attributes that can affect the contents of the
files in the archive.  Back then the commmit ID was sufficient as a
concise and canonical label of the archive contents, but now things are
a bit more complicated.

Which use cases are we aiming for?  Do we want to include all of the
command line arguments (with revs resolved to SHA1-IDs)?  Only those
that modify archive contents?  And any applied attributes?  Or do we
want to get stricter and only write the commit ID if a full unchanged
tree of a commit is being archived?

Ren=E9
