From: Simon Hausmann <simon@lst.de>
Subject: Yet another git perforce integration
Date: Tue, 8 May 2007 10:23:38 +0200
Message-ID: <200705081023.38810.simon@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1559077.Xr02yaSAcz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 10:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlKzC-0002Aa-IF
	for gcvg-git@gmane.org; Tue, 08 May 2007 10:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbXEHIXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 04:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbXEHIXs
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 04:23:48 -0400
Received: from verein.lst.de ([213.95.11.210]:35983 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012AbXEHIXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 04:23:47 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l488NipX022069
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 8 May 2007 10:23:45 +0200
User-Agent: KMail/1.9.6
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46551>

--nextPart1559077.Xr02yaSAcz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Integrations of Git with Perforce seem to be fashion these days, so I'd lik=
e=20
to chip in and announce another one :)

I've written a Python script called git-p4 that allows (incremental) import=
s=20
from Perforce as well as submitting changes back from git into a Perforce=20
depot.

It is currently part of the fast-export repository that Chris Lee started at

=A0=A0=A0=A0=A0=A0=A0=A0http://repo.or.cz/w/fast-export.git

I've been using it now for about a month for my everyday work (which requir=
es=20
Perforce), so it seems to work reasonably stable at least in my setup :)

The usage is pretty simple:

=A0=A0=A0=A0=A0=A0=A0=A0git-p4 clone //depot/path/my/project

Syncing:

=A0=A0=A0=A0=A0=A0=A0=A0git-p4 sync

or just

=A0=A0=A0=A0=A0=A0=A0=A0git-p4 rebase

to sync and automatically rebase into the current branch (much like git-svn=
=20
rebase :)

=A0=A0=A0=A0=A0=A0=A0=A0git-p4 submit

is used to submit changes back into Perforce (use at your own risk! :)

The import itself uses git-fast-import, so it's very fast. There is also no=
=20
need to have the imported Perforce projects in the Perforce client view as =
it=20
just uses "p4 changes //depot/path" and "p4=20
print //depot/path/file#revision", which I find very convenient and still=20
fast enough for use (since of course only changed files are printed).

It also doesn't require any additional meta-data. Instead every import comm=
it=20
has a line added to the log message that contains the Perforce path the=20
changeset comes from as well as the change number. git-p4=20
sync/rebase "parses" this on the last commit in the "p4" git branch to find=
=20
out where to continue importing for incremental imports.


What's still missing is a bit of cleanup. For example I'd like to put the=20
import branch into refs/remotes instead of refs/heads, but I've had some=20
problems with fast-import when trying that. Also the support for Perforce=20
branches isn't quite working yet. I'd ideally like to for example map a=20
structure like

//depot/project/main
//depot/project/branch1
//depot/project/branch2

into

remotes/p4/main
remotes/p4/branch1
remotes/p4/branch2

in git and still support incremental commits. But that isn't working yet ;(

Also I've never tried it on Windows and I expect problems as the script use=
s=20
pipes, calls "patch", etc.

Nevertheless I hope that this tool may be interesting for others as well.
Maybe there's a possibility of including it in git/contrib/fast-import?


Simon

--nextPart1559077.Xr02yaSAcz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGQDOKWXvMThJCpvIRAhgHAJ9hZEFFt8FFMDHYMNleESAtvOq5DwCgwNom
MmGIhLgSubOFvFM9+VcgDAQ=
=GwNB
-----END PGP SIGNATURE-----

--nextPart1559077.Xr02yaSAcz--
