From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix t9200 on case insensitive file systems
Date: Sun, 28 Oct 2012 07:10:53 -0400
Message-ID: <20121028111053.GC11434@sigill.intra.peff.net>
References: <201210261818.25620.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bdwalton@gmail.com, bosch@adacore.com,
	brian@gernhardtsoftware.com, robin.rosenberg@dewire.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 12:11:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSQlo-0005kF-0W
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 12:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772Ab2J1LK4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Oct 2012 07:10:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41264 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab2J1LKz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 07:10:55 -0400
Received: (qmail 7934 invoked by uid 107); 28 Oct 2012 11:11:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Oct 2012 07:11:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Oct 2012 07:10:53 -0400
Content-Disposition: inline
In-Reply-To: <201210261818.25620.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208538>

On Fri, Oct 26, 2012 at 06:18:24PM +0200, Torsten B=C3=B6gershausen wro=
te:

> t9200 defines $CVSROOT where cvs should init its repository
> $CVSROOT is set to $PWD/cvsroot.
> cvs init is supposed to create the repository inside $PWD/cvsroot/CVS=
ROOT
>=20
> "cvs init" (e.g. version  1.11.23) checks if the last element of the =
path is
> "CVSROOT", and if a directory with e.g. $PWD/cvsroot/CVSROOT already =
exists.
>=20
> For such a $CVSROOT cvs refuses to init a repository here:
> "Cannot initialize repository under existing CVSROOT:
>=20
> On a case insenstive file system cvsroot and CVSROOT are the same dir=
ectories
> and t9200 fails.
>=20
> Solution: use $PWD/tmp/cvsroot instead of cvsroot $PWD/cvsroot

Wouldn't tmp/cvsroot have the same problem, since the basename is still
cvsroot?

> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportco=
mmit.sh
> index b59be9a..69934b2 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -19,7 +19,7 @@ then
>      test_done
>  fi
> =20
> -CVSROOT=3D$PWD/cvsroot
> +CVSROOT=3D$PWD/tmpcvsroot

Ah, but here you do something different, which makes sense. Should I
tweak the commit message?

-Peff
