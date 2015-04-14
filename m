From: Luke Mewburn <luke@mewburn.net>
Subject: Re: [PATCH] reduce progress updates in background
Date: Tue, 14 Apr 2015 21:08:14 +1000
Message-ID: <20150414110814.GF23475@mewburn.net>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
 <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EEx6GiKZGZ1wKUra"
Cc: Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 13:08:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhyhY-0005ub-LV
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 13:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbbDNLIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 07:08:17 -0400
Received: from home.mewburn.net ([121.127.199.9]:38166 "EHLO home.mewburn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbbDNLIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 07:08:15 -0400
Received: by home.mewburn.net (Postfix, from userid 1001)
	id A6F3461565; Tue, 14 Apr 2015 21:08:14 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267129>


--EEx6GiKZGZ1wKUra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 11:01:04AM -0400, Nicolas Pitre wrote:
  | > That's what happens; the suppression only occurs if the process is
  | > currently background.  If I start a long-running operation (such as "=
git
  | > fsck"), the progress is displayed. I then suspend & background, and t=
he
  | > progress is suppressed.  If I resume the process in the foreground, t=
he
  | > progress starts to display again at the appropriate point.
  |=20
  | I agree. I was just comenting on your suggestion about caching the=20
  | in_progress_fd() result which would prevent that.

Ahh.  My suggestion about is_foreground_fd() result caching within
struct progress was only about caching the getpgid(0) portion of the
test (as that's not expected to change for the life of the process), and
not the tcgetpgrp(fd) portion.  I.e, add 'int curpgid' to struct
progress, set that to getpgid(0) in start_progress_display(), and
compare tcgetpgrp(fd) against progress->curpgid.

In any case, I think it's a micro optimisation not worth worrying about
at this point, given is_foreground_fd() is only called each time the
output would change, per your feedback.

regards,
Luke.

--EEx6GiKZGZ1wKUra
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlUs9R4ACgkQpBhtmn8zJHJMVwCgpadeI0AcQqjBTY8u3KLYfpYH
6mgAn2B9KI3JtaxjbSF/7hLxu8vbdv6d
=jnB0
-----END PGP SIGNATURE-----

--EEx6GiKZGZ1wKUra--
