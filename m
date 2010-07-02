From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation: 'cherry' does not cope well with merges
 from upstream
Date: Fri, 02 Jul 2010 09:46:37 +0200
Message-ID: <4C2D995D.2020708@drmicha.warpmail.net>
References: <1278012954-sup-3724@pimlott.net> <20100701210919.GA4283@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>,
	=?UTF-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?QmrDtnJuIFN0ZWluYnJpbms=?= <B.Steinbrink@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 09:52:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUb39-0003Tj-5Q
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 09:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab0GBHr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 03:47:29 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52284 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014Ab0GBHr2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 03:47:28 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DBA4310CA69;
	Fri,  2 Jul 2010 03:47:27 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 02 Jul 2010 03:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Z90z8Ov5Lf5H3HXxPBgaUPJEkCo=; b=D8IouvRYWiwrjIK9/eo1NHal1SzVth6y6KsCwfZbgU/sT1Q9roWYPMCUtpna/NpCf9hRpC1vvlF24hVmK7E6/FyLCXHGO9kEvk5fhyBLooOjm9GN3lIff+2nyi4ZuPmg9k1CvKGwUDg1Z03rHFvrQ9eeOn+dDLcyOgNFh6HR65s=
X-Sasl-enc: sYpL1K8Qb5pdDWL2gNv/sIV1ZeniWXq/KJw0qvHIZt+d 1278056847
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 911C24BB702;
	Fri,  2 Jul 2010 03:47:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <20100701210919.GA4283@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150112>

Jonathan Nieder venit, vidit, dixit 01.07.2010 23:09:
> Although =E2=80=98git cherry=E2=80=99 is advertised simply to list co=
mmits from
> <topic> that have not been merged into <upstream>, internally it
> works by checking for patches in <upstream>..<topic> that do not
> match a patch in <topic>..<upstream>.  This is fast because there

=2E..and it says so in the very first line of the manpage.

> are not many patches to check, and it makes sense semantically
> since even if a new patch patches an old patch from <upstream>,
> it cannot be said to have been merged upstream unless it was
> applied there at some point after the <topic> and <upstream>
> branches diverged.
>=20
> But.  If the <topic> branch later merges from <upstream>, it
> throws a spanner in the works and for such a history =E2=80=98git che=
rry=E2=80=99
> is not very useful at all.

I actually think I've reported this before, but I don't mind :)
I keep (topic) branches for my git.git patches. git cherry is helpful
here. When a patch is applied, I merge the corresponding commit (i.e.
Junio's version) to my topic branch to mark it as applied and to have a
nice way of comparing the applied version to the submitted one. At that
point git cherry stops being useful.

>=20
> Example:
>=20
>  o---o---F---X'---G---U [upstream]
>           \        \
>            X----Y---M---T [topic]
>=20
> Suppose the author of the =E2=80=98topic=E2=80=99 branch starts from =
upstream
> commit F and makes a few changes.  One is applied upstream, and
> additionally there is some other useful upstream change, so he
> performs a merge to include the upstream updates into topic.
> The expected output from =E2=80=98cherry=E2=80=99 is:
>=20
>  + T
>  + Y
>  - X
>=20
> Consider the author of a different branch, also called =E2=80=98topic=
=E2=80=99, but
> this one starts from commit G.  Some infrastructure from an existing=20
> branch is needed, so first she merges that.  Then she adds her own
> commit.  The expected output from =E2=80=98cherry=E2=80=99 is:
>=20
>  + T
>  + Y
>  + X
>=20
> since none of the new commits have been applied upstream since
> the fork point.
>=20
> =E2=80=98cherry=E2=80=99 cannot distinguish between these two cases, =
in part because
> it does not distinguish between parents in a merge commit.
>=20
> Add a BUGS section to explain the problem.

This is not a bug. git cherry works exactly as described.

At worst, it is a misfeature.

git cherry would be more useful if you could specify a "limit" which is
an ancestor of "fork-point", not only descendants.

>=20
> Thoughts?  Improvements?

Allow general "limit" :)

>=20
>  Documentation/git-cherry.txt |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.=
txt
> index fed115a..83e3bdc 100644
> --- a/Documentation/git-cherry.txt
> +++ b/Documentation/git-cherry.txt
> @@ -59,6 +59,21 @@ OPTIONS
>  <limit>::
>  	Do not report commits up to (and including) limit.
> =20
> +BUGS

+DISCUSSION

> +----
> +'git cherry' does not cope well with merges from upstream on the
> +working branch.  Any commits after the original fork point and

=2E..which is the wrong way round anyways ;)

> +before the latest merge from upstream will be reported as not found
> +in <upstream>.
> +
> +                       ____*____*____*_____*__> <upstream>
> +                      /                     \
> +   original fork point                       \
> +                      \__+__+__+__+__+__+__+__*_> <head>
> +
> +While these commits are part of upstream..head, their upstream
> +counterparts are not in head..upstream.

git-cherry(1) never speaks about upstream..head nor head..upstream. It
uses "fork-point", and a merge creates a new "fork-point", i.e.
merge-base. I think it would be good to keep like that in order to avoi=
d
that very misunderstanding. In fact, git cherry is about left and right
commits in upstream...head.

The second paragraph of "DESCRIPTION" may cause confusion when read
without the first one, though.

Michael
