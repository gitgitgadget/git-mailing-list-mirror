From: "Roger Leigh" <rleigh@whinlatter.ukfsn.org>
Subject: git-cvsimport produces different (broken) repos when using pserver
	or local repo access
Date: Mon, 27 Oct 2008 00:25:40 +0000
Message-ID: <20081027002539.GB3399@codelibre.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 01:27:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuFwt-0003hd-5w
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 01:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbYJ0AZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 20:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYJ0AZz
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 20:25:55 -0400
Received: from nagini.codelibre.net ([80.68.93.164]:3918 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbYJ0AZy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 20:25:54 -0400
Received: by nagini.codelibre.net (Postfix, from userid 107)
	id DF7417C1B1; Mon, 27 Oct 2008 00:25:50 +0000 (GMT)
Received: from whinlatter.ukfsn.org (78-105-115-105.zone3.bethere.co.uk [78.105.115.105])
	by nagini.codelibre.net (Postfix) with ESMTPSA id 6FAAF7C012
	for <git@vger.kernel.org>; Mon, 27 Oct 2008 00:25:44 +0000 (GMT)
Received: by whinlatter.ukfsn.org (sSMTP sendmail emulation); Mon, 27 Oct 2008 00:25:40 +0000
Content-Disposition: inline
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 11:31:31 up 7 min,  1 user,  load average: 1.43, 1.09, 0.51
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99194>


--HG+GLK89HZ1zG0kk
Content-Type: multipart/mixed; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've noticed that git-cvsimport can under some circumstances produce broken
repositories.  This appears to only occur when using pserver access to the =
CVS
repo; running with a local repo is apparently fine, with all tested versions
giving the same repo (master head has same hash for the last commit).
In all cases cvsps version 2.1 was used.

Repo source:
pserver :pserver:anonymous@gimp-print.cvs.sourceforge.net:/cvsroot/gimp-pri=
nt
local   rsync -av 'rsync://gimp-print.cvs.sourceforge.net/cvsroot/gimp-prin=
t/*' cvs-backup

I've tested with a number of git versions, including git.git as of yesterda=
y:

git version                repo     last commit  URI
1.5.5.GIT                  local    a51c479826   git://git.debian.org/git/u=
sers/rleigh/gutenprint-upstream.git
1.5.5.GIT (2 failures)     pserver  bfa6f8248a   git://git.debian.org/git/u=
sers/rleigh/gutenprint-upstream-broken.git
1.5.5.GIT (no failure)     pserver  bfa6f8248a   git://git.debian.org/git/u=
sers/rleigh/gutenprint-upstream-pserver.git
1.5.6.5                    local    a51c479826   git://git.debian.org/git/u=
sers/rleigh/gutenprint-upstream-git1.5.6.5-local.git
1.5.6.5                    pserver  6f0950c097   git://git.debian.org/git/u=
sers/rleigh/gutenprint-upstream-git1.5.6.5-pserver.git
git.git 1.6.0.3.517.g759a  local    a51c479826   git://git.debian.org/git/u=
sers/rleigh/gutenprint-upstream-git1.6-local.git
git.git 1.6.0.3.517.g759a  pserver  6f0950c097   git://git.debian.org/git/u=
sers/rleigh/gutenprint-upstream-git1.6-pserver.git

With git 1.5.5 I'm tracking the CVS repo running git-cvsimport every 20 mins
=66rom a cron job.  A few months ago it managed to botch, resulting in a br=
oken
repo (it didn't delete files deleted from CVS).  I think this occurs when
git-cvsimport fails (I get a perl error, though I'm afraid I don't have the=
 log
anymore); running again results in successful completion, but the repo is
screwed, I think due to that commit being incomplete or something.  This
occured twice during the import in the second line in the above table, in t=
his
case resulting in missing files (src/cups/i18n.*).  Again, I'm afraid I don=
't
have the logs, but I can repeat again if this is not an already known/fixed
issue.  The repo is quite big, taking several hours to import, so it might
possibly be a network connection problem and it's not handling that correct=
ly
on failure.  However, even when the import comples successfully (line 3), t=
he
hash is still the same as line 2 where it failed twice and needed restartin=
g.

So, it looks like depending on if I use a local repo directly or remove via
pserver, I get a different repo.  1.5.5 using pserver is different to later
versions, presumably this is a buggy version because it's broken whether or=
 not
I get a failure.  Later versions always completed without failure; while the
local and pserver using repos differ, they do both seem OK.  However, I wou=
ld
have expected identical results, given that they are all created from the
same data.

The script I used to do the import is attached.


Regards,
Roger

--=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gutenprint-bootstrap

#!/bin/bash

CVSROOT=:pserver:anonymous@gimp-print.cvs.sourceforge.net:/cvsroot/gimp-print
CVSMODULE=print
HOME=/home/users/rleigh
GIT_DIR=/var/lib/gforge/chroot/home/users/rleigh/public_git/gutenprint-upstream.git
LOGDIR=${HOME}/log
LOCKFILE=${HOME}/gutenprint-cvs.lock
AUTHORS=${HOME}/gutenprint-auth

#date -R

lockfile -2 -r 2 ${LOCKFILE}

# If we managed to lock the file
if [ $? -eq 0 ]; then
#	echo "Running git-cvsimport"
	export GIT_DIR
	export CVSROOT
	git-cvsimport -A $AUTHORS -i -v print
	rm -f ${LOCKFILE}
else
	echo "Couldn't get lock for cvssuck"
fi

#date -R


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gutenprint-auth

andystewart=Andy Stewart <andystewart@attbi.com>
anikin=Eugene Anikin <eugene@anikin.com>
cpbs=Charles Briscoe-Smith <cpbs@debian.org>
daberti=Daniele Berti <daberti@users.sourceforge.net>
davehill=Dave Hill <dave@minnie.demon.co.uk>
degger=Daniel Egger <degger@users.sourceforge.net>
doctormo=Martin Owens <doctormo@users.sourceforge.net>
dpace=David Pace <dpace@echo-on.net>
easysw=Mike Sweet <msweet@apple.com>
faust3=Sascha Sommer <saschasommer@freenet.de>
gandy=Andy Thaller <thaller@ph.tum.de>
gtaylor=Grant Taylor <gtaylor@users.sourceforge.net>
iay=Ian Young <ian@iay.org.uk>
jmv=Jean-Marc Verbavatz <verbavatz@ifrance.fr>
julianbradfield=Julian Bradfield <julianbradfield@users.sourceforge.net>
khk=Karl Heinz Kremer <khk@khk.net>
m0m=Michael Mraka <michael.mraka@linux.cz>
mbroughtn=mbroughtn <mbroughtn@users.sourceforge.net>
menthos=Christian Rose <menthos@users.sourceforge.net>
mitsch=Michael Natterer <mitschel@cs.tu-berlin.de>
mtomlinson=Mark Tomlinson <mark.tomlinson@xtra.co.nz>
nestordi=nestor di <nestordi@users.sourceforge.net>
nicholas=nicholas <nicholas@users.sourceforge.net>
peter_missel=Peter Missel <peter_missel@users.sourceforge.net>
rblancha=Richard Blanchard <rblancha@users.sourceforge.net>
rleigh=Roger Leigh <rleigh@debian.org>
rlk=Robert Krawitz <rlk@alum.mit.edu>
rwisi=Richard Wisenoecker <Richard.Wisenoecker@gmx.at>
sharkey=Eric Sharkey <sharkey@debian.org>
smiller=Steve Miller <smiller@rni.net>
spa=Salvador Abreu <spa@users.sourceforge.net>
stevek=Steve Kann <stevek@stevek.com>
tillkamppeter=Till Kamppeter <till.kamppeter@gmail.com>
ttonino=Thomas Tonino <ttonino@bio.vu.nl>
tylerb=Tyler Blessing <tylerb@users.sourceforge.net>
uid21630=uid21630 <uid21630@users.sourceforge.net>
wiz=Joseph S. Wisniewski <wiz@users.sourceforge.net>
wollvieh=Wolfgang Bauer <wollvieh@users.sourceforge.net>
zoopa =Pete Parks <zoopa@users.sourceforge.net>

--vGgW1X5XWziG23Ko--

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkFCoMACgkQVcFcaSW/uEh6UQCg8xsNdnYMRpc7e7cz5zRqzkjg
jisAnRuMC5JB7bb3wxDssLsTsN2QWh2K
=cn+r
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
