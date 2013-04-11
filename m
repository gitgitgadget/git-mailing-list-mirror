From: Mike Galbraith <bitbucket@online.de>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 05:39:43 +0200
Message-ID: <1365651583.19620.8.camel@marge.simpson.net>
References: <1365572015.4658.51.camel@marge.simpson.net>
	 <20130410135605.GB4694@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Apr 11 05:40:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ8Me-0001vJ-T1
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 05:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936304Ab3DKDjs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 23:39:48 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:62319 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758624Ab3DKDjq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Apr 2013 23:39:46 -0400
Received: from [192.168.178.27] (p4FE190B6.dip0.t-ipconnect.de [79.225.144.182])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0M7z2j-1Umb6911mr-00vXb9; Thu, 11 Apr 2013 05:39:45 +0200
In-Reply-To: <20130410135605.GB4694@odin.tremily.us>
X-Mailer: Evolution 3.2.3 
X-Provags-ID: V02:K0:9IR4WiWnrOUjhGMOdEwwrtxUaQeRqExoIziU2nltrQL
 md3fHMsfOLyfWR3zThqoW1/t16BTK/ljo6kRjGkE8H43V7QgxN
 U+w+aDYAZ4xFBfctGjGBRNT9yjopbWKljMOB6rFMMYEL7tIqdH
 nIybrFyWTN6ly5yvwnrJoW4/7qN7q2cS+WAtSkPERAiBFjoxTH
 Y4XJrpTTkVv7tZV9RjmL5iMScnOnVjGfdx/Gn06RuqNghASzJF
 2Xzy2vgm5y8NXQc1pAitWJJKHVTRg4yh184bTlFcQo9h7rFMOW
 0k1YZk3/AQ62IhBIlk242fBf00pkkzBBwOlgJ4cSP9F9/82rQs
 sPTjS1vMmtyUC4cSHP7w9qBAC/R4hpuANTAc1naFVhE3EnHe8s
 uQEJ7uY4k2FDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220813>

On Wed, 2013-04-10 at 09:56 -0400, W. Trevor King wrote:=20
> On Wed, Apr 10, 2013 at 07:33:35AM +0200, Mike Galbraith wrote:
> > /usr/lib/git/git-daemon --syslog --detach --reuseaddr --user=3Dgit =
--group=3Ddaemon --pid-file=3D/var/run/git-daemon.pid --export-all --us=
er-path --enable=3Dreceive-pack
> >=20
> > Try to pull as root or normal user results in:
> >=20
> > [pid 26786] access("/root/.config/git/config", R_OK) =3D -1 EACCES =
(Permission denied)
> > [pid 26786] write(2, "fatal: unable to access '/root/."..., 70) =3D=
 70
> > [pid 26785] <... read resumed> "fatal: unable to access '/root/."..=
=2E, 4096) =3D 70
> > [pid 26786] exit_group(128)
> >=20
> > Bisection fingered this commit, though it looks like it's really du=
e to
> > not forgetting who it was at birth.  It's not root, so has no busin=
ess
> > rummaging around in /root.  It used to not care, but this commit ma=
de
> > "go away" while looking for non-existent config file terminal.
>=20
> I ran into this too, although I'm running git-daemon via spawn-fcgi.
> In order to convince newer Gits that you know what you're doing, you
> just need to set HOME to somewhere Git can look.  For example:
>=20
>   HOME=3D/ /usr/lib/git/git-daemon =E2=80=A6
>=20
> should work.  On Gentoo, I added the following to
> /etc/conf.d/spawn-fcgi.fcgiwrap:
>=20
>   ALLOWED_ENV=3D"PATH HOME"
>   HOME=3D/

I can work around it by changing the init script to use su - git -c "bl=
a
bla" to launch the thing, instead of using --user=3Dgit --group=3Ddaemo=
n,
but that's just a bandaid for the busted environment setup those
switches were supposed to make happen, no?

-Mike
