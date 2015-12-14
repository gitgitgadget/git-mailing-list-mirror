From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] rebase: fix preserving commits with --keep-empty
Date: Mon, 14 Dec 2015 16:39:45 +0100
Message-ID: <20151214153945.GA1414@pks-xps.fritz.box>
References: <1448021080-4994-1-git-send-email-ps@pks.im>
 <1448021080-4994-3-git-send-email-ps@pks.im>
 <CAO2U3QiFXaOCb114NMgGxDOV3FqHN6HyNDJBWT6ZeqTvQ+i0Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Cc: Git List <git@vger.kernel.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 16:40:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8VEC-0002Me-Ry
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 16:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbbLNPjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 10:39:49 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53674 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751700AbbLNPjr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 10:39:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 118B9212DB
	for <git@vger.kernel.org>; Mon, 14 Dec 2015 10:39:47 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 14 Dec 2015 10:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=UjR/ZpCCJh4uOTYAiMf6kfC48gU=; b=i4GLM
	3Az6l4VRoRU1v+0jpeqow22oRMxDYfg4Zyj85uz93epNfUzJsTQErT1nN6ZTchfG
	oPKcL7+qIO6F8WJvrRG/RPL64caeCfxPvu4tX0Gyg+H4umBlTF0s4aItFRcrhQs7
	KRtjgiBkyoMRmIfh17BSHjkyRQH33Hq+JHGn0c=
X-Sasl-enc: VhGygvCgShCT9qzf5M01WYnzwGNZM8a0GtCvC+d9xLt/ 1450107586
Received: from localhost (p5dc155a9.dip0.t-ipconnect.de [93.193.85.169])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9303BC016DB;
	Mon, 14 Dec 2015 10:39:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAO2U3QiFXaOCb114NMgGxDOV3FqHN6HyNDJBWT6ZeqTvQ+i0Zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282366>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2015 at 02:58:06PM -0800, Michael Blume wrote:
> This test does not seem to pass on my mac.
>=20
> I've placed the verbose output here:
> https://gist.github.com/MichaelBlume/db7ba222be001d502e57
>=20
> On Fri, Nov 20, 2015 at 4:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> > When rebasing commits where one or several commits are redundant
> > to commits on the branch that is being rebased upon we error out.
> > This is due to the usage of `--allow-empty` for the invoked
> > cherry-pick command, which will only cause _empty_ commits to be
> > picked instead of also allowing redundant commits. As
> > git-rebase(1) mentions, though, we also want to keep commits that
> > do not change anything from its parents, that is also redundant
> > commits.
> >
> > Fix this by invoking `git cherry-pick --keep-redundant-commits`
> > instead, which will cause redundant commits to be rebased
> > correctly.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  git-rebase--am.sh | 2 +-
> >  t/t3400-rebase.sh | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> > index 9ae898b..ea7b897 100644
> > --- a/git-rebase--am.sh
> > +++ b/git-rebase--am.sh
> > @@ -44,7 +44,7 @@ then
> >         # empty commits and even if it didn't the format doesn't really=
 lend
> >         # itself well to recording empty patches.  fortunately, cherry-=
pick
> >         # makes this easy
> > -       git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty \
> > +       git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --keep-redunda=
nt-commits \
> >                 --right-only "$revisions" \
> >                 ${restrict_revision+^$restrict_revision}
> >         ret=3D$?
> > diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> > index 6cca319..f43b202 100755
> > --- a/t/t3400-rebase.sh
> > +++ b/t/t3400-rebase.sh
> > @@ -255,7 +255,7 @@ test_expect_success 'rebase commit with an ancient =
timestamp' '
> >         grep "author .* 34567 +0600$" actual
> >  '
> >
> > -test_expect_failure 'rebase duplicated commit with --keep-empty' '
> > +test_expect_success 'rebase duplicated commit with --keep-empty' '
> >         git reset --hard &&
> >         git checkout master &&
> >
> > --
> > 2.6.3

Thanks for letting me know. I'll keep this in mind when there is
some consensus reached wether this option actually makes any
sense. Until then I'll just leave it as is.

Patrick

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWbuLBAAoJEBF8Z7aeq/EsX3oP/jonZnIV9Dp/TCgnQtMu++tl
XZVBCkcEguzyg/KFfQSrAYCKGsSwstTypvfbvKfUE5afGpmDKzCVG6hsPWp2cWxd
Ex/cQMvJMz4TXGw1gJ5ownW2LvHmpycVKU/LcOaKzGR2owsEtbMu6Ixa03kOCcxC
WqaxyKdSR2U6kNRa6loAYoFknSz6ua6aOIpGpSCvrnkxK351dC1LtvCGKBQpfzoP
yJssh3BmprcdphWpZo9pWD6DRKDjGKE8UmHI086EtAAzT3rcI5SEXvxIg5ffHf0J
2YvmKg4KcJ0IkJhfFDEp+YlF6jUJM27CtIHlVJho1WqcOt18D445lAT1Kdp0eBEW
l0o6kUT3bZyd83hiPKjtvYS7kzTQ9oN27nBYip7ubOpdQqfkNtpKjkg1cqP2icVp
1NL0ONRLygNrXqQIoEkqzj5NmhnuoDgtjLTAG+cMjYK3HEWqjYG8YpJiZyIpL8FS
hEznhrIN0wpcWQiQjZ48EXwlUBeVAxqZJ2Qcz8oq1MC14zEK3h/tLjHMzVQ/PoVd
4zDeKfG8o5g8m7SswOEe3JkOJZfjXCrmTsq3CW/4zApXhQygH4+UB1bH8JI4BLtt
MANAHeedmXwp+oq/s0rscuaXb+hQltrCYzv7e8xW6Eld0Kl6UJkmcezhA7IRTS3e
epzTcz8wqkNIdbRPAPNj
=xVXm
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
