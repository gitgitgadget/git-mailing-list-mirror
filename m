From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 11:54:04 -0500
Message-ID: <20121201165404.GD4823@odin.tremily.us>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
 <20121130175309.GA718@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=wLAMOaPNJ0fu1fTG
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 17:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeqKx-0005w4-Ue
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 17:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab2LAQyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 11:54:21 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:49515 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab2LAQyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 11:54:12 -0500
Received: from odin.tremily.us ([unknown] [72.68.81.98])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MED00JL42Y4BJ60@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 10:54:05 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 440416E3CB7; Sat,
 01 Dec 2012 11:54:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354380844; bh=NGvCedeu6MCvBWZ8bwgG9nrOWwNVoBPYORFNwSAPiNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hZa+w9nGnrrFCxWSAlJ9N82toVy3kYsgOCBQgZ0LQGBL9JSPEbdjY42H59ET2/0PV
 AaQq94hPn1gU/GNwGN7psLZqOVwYB/8gDOwKGHhEw0VP9WRZY3GJPSHl5X+U9FJEpM
 mmFNA/ATkXjRAOG42uwjfQCiLt0gtMdLfUebIucA=
Content-disposition: inline
In-reply-to: <20121130175309.GA718@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210980>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm currently stuck with adding a commit-less existing repository as a
submodule (which happens in t7400-submodule-basic.sh, ../bar/a/b/c
works with relative local path):

  $ mkdir -p super/sub
  $ cd super
  $ git init
  $ (cd sub && git init)
  $ git submodule add ./ sub
  $ git status
  # On branch master
  #
  # Initial commit
  #
  # Changes to be committed:
  #   (use "git rm --cached <file>..." to unstage)
  #
  #       new file:   .gitmodules
  #

What I'm missing is a gitlink form sub for 'Subproject commit
00000...' or some such.  When the subproject has an actual commit,
things work as expected:

  $ mkdir -p super/sub
  $ cd super
  $ git init
  $ (cd sub && git init && echo line-1 > file && git add file && git commit=
 -m file)
  $ git submodule add ./ sub
  $ git status
  # On branch master
  #
  # Initial commit
  #
  # Changes to be committed:
  #   (use "git rm --cached <file>..." to unstage)
  #
  #       new file:   .gitmodules
  #       new file:   sub
  #

This means that module_list isn't aware of the empty submodule, when
the user has just explicitly added it.  Fixing this would seem to need
either 'Subproject commit 00000...' as I suggested earlier, or an
adjustment to module_list that also spits out submodules that are in
=2Egitmodules but not in the index.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQujYqAAoJEEUbTsx0l5OMbWsP+wWLYetn3q4N3GNdqgUqknRI
Da1/F5ZZxQV3H9JbV/jja7b7g1HRHoj81RqN41JgBf3XWxBSKHw8RjWQR32ZM4fK
0zI6XOJNAh8AT50o3mpuOcaa5pn/ekQHqX6tZuVs+IHIN2x5p5E8wywg6UOUlsJv
0cmo5kmqKvQBQTqD+NyWG0mPKX6h30gSgG8Ir2Xr4JnpLn7DBWt+LhBk0Aos0BVc
U9zkeC7CPB3DI9YyWeVvcXqYcjWcR9oxdnqV6OUClwAKBCmBsH0s3B9w+270ZGR3
tMFFtoRAjScIo1VmTodp3i/iKtVwlAMI0nAkaoGdUi/GzF49gHN3G2BnH0A+TTvL
1cOayvob4GJ0NTzWPfKPZivbdV3ttA4wUsaz3rT62GVanYNvnQafs9E3ICPkiCPT
0l11NUbmCONBw1ooXouvv2XcasCn2ZHdJtO3jF3gHrqJX7Rlo2oZRg797a1PJ+k6
2v2CZn87MNWkDibRCrbYJJq2f/bLizbwrtaRzgLpuIURRnW2/LcUqKnsUNz3AYW8
14J3u4lgdkZUKK6602ptxLiRmZq7V/FvSy6RUJIWsIlb7QFoNN06gMb6QpAQHGMF
Kv50lE6EIyBJ5rK/S7m6+MH+JZvOZLMjUCdJCtDOjvAQUH77J3KccIGN7qi2u9T3
4WmVr11GoAHHRkV9TrjN
=pWTV
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
