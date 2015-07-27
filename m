From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] clone: fix repo name when cloning a server's root
Date: Mon, 27 Jul 2015 14:59:23 +0200
Message-ID: <20150727125923.GA800@pks-xps>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <CACsJy8C0xzTvxMo7=pLFJyu8Yaqm_nz1qVXMFFo9ubQE-dYYSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 14:59:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJi0D-0006bD-3g
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 14:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbbG0M73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 08:59:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55285 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752235AbbG0M70 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2015 08:59:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7877520816
	for <git@vger.kernel.org>; Mon, 27 Jul 2015 08:59:25 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 27 Jul 2015 08:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=/fYvVRSm/JIfJ25NDZGST89Gyso=; b=rcH3e
	eJFpjzazjtk9qqsnmuCiRXEM5GCm70wfu645KUgwYYfC6+iw21RPSFlegQFmH/Xq
	Ck4DpepChn+l4wFy1Q/8Hkfvo2z2tYGIFSuy68ZqJResytAVJSeqUJGMUPS+wjVZ
	0bSB2bw0oIW+9cdf6/G27zbbPAU/eu8LrtOdwM=
X-Sasl-enc: KBxbKcH9zNLSqJFLNDnsOJY1Zu+OUVN+4/v2GqD4rnKP 1438001965
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 14059C00021;
	Mon, 27 Jul 2015 08:59:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8C0xzTvxMo7=pLFJyu8Yaqm_nz1qVXMFFo9ubQE-dYYSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274677>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 07:51:30PM +0700, Duy Nguyen wrote:
> On Mon, Jul 27, 2015 at 6:48 PM, Patrick Steinhardt <ps@pks.im> wrote:
> > When cloning a repository from a server's root, that is the URL's
> > path component is a '/' only, we fail to generate a sensible
> > repository name when the URL contains authentication data. This
> > is especially bad when cloning URLs like
> > 'ssh://user:passwd@example.com/', which results in a repository
> > 'passwd@example.com' being created.
> >
> > Improve the behavior by also regarding '@'-signs as a separator
> > when scanning the URL. In the mentioned case this would instead
> > result in a directory 'example.com' being created.
>=20
> My initial reaction was, if you put password on the command line, you
> deserve it. However, as we improve this heuristics, perhaps it's
> better to export parse_connect_url() from connect.c and use it here?
> We would have more robust parsing. You can create a repo named
> example.com given the url ssh://user:pass@example.com:123/. Maybe it's
> overkill?

Sure, specifying passwords on command line should not be done
easily. Still those heuristics fail for everything that does
not include an additional [:/] when the URL's path is empty. So I
guess using parse_connect_url() would be the most sane solution
for this, as it will also fix the case when you specify a port,
which would currently use the port as directory name. I'll whip
up a new version that uses parse_connect_url().

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > I was not able to come by with a useful test as that would
> > require being able to clone a root directory. I couldn't find
> > anything in the current tests that looks like what I want to do.
> > Does anybody have an idea on how to achieve this?
>=20
> There's t/t1509/prepare-chroot.sh that will prepare a chroot for this
> purpose. You'll need linux, busybox and chroot permission.

Thanks for the hint.

Patrick

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVtisrAAoJEBF8Z7aeq/EskNkQAImAPDQNE6Yq5qP+Tetu/XUI
3ujTBdvi9uwekfcAUL+q5J9F9duQM/KL22weDFV3i2KxXULEcb0igTh/yBeSxjJ6
DKjbR6cXkr4MxlW9DhHDh9wnuJu+DJikfQbOZSlaPQp0xD+NfbLpQYwZUMXubSFn
yk43ytHsOUg/gxmPYInL8OyD2CFZf7vxFFZuP1zj5h7zG0AGHXfOBGsg6RKlWCsl
FKsk2kXm2JrNPtD0SGqdjg4Vxl+563BDBvHfUxiLix2sHwr279HnOmEYsG+h4Xtk
iTyoWuxK2rIifnlPes7e2jf5+jiMv0RZb/wsukVqlWn9nFNjanUP1rXxeRBZ533v
QqByfoZSx0VPYZ4PanG7ihlsbjgavQZTZSpufLx6RzJh3FHxcS9Hj1OPHEQim8dx
i1R8Rze7xWy9/KYfOkqQG9eb63u5hzmktJQ1tJXJAG1LrFr/Ot0yt4Tnudo2+0+P
0fhPDu/dhyMaonTFZHEuisqabls2GXcTf4/JWD3uqgI0nciLXvqc8hm8hWJZBXt5
ta1K2Q8Y/ByCLmeTMSrOaNhhNmBvRDPUdaT36wUDsZMUwK2/Xopmr+2uD6UIWz/U
GdG2ruLX2fvZMyuk6ud+MopOfm7+aaR3DxSSCDZXT7xO03W/WkNjqTAHxLEK9dSq
tC1ayAifsCR1os6zlQ8h
=F0Zq
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
