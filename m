From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: gitweb on shared hosting
Date: Sun, 3 Jun 2007 17:35:42 +0200
Message-ID: <20070603153541.GA32145@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: dev.list@mircea.bardac.net
X-From: git-owner@vger.kernel.org Sun Jun 03 17:36:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hus7e-0007gd-CR
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 17:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbXFCPfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 3 Jun 2007 11:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbXFCPfr
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 11:35:47 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60095 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbXFCPfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 11:35:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 727EB84520B5;
	Sun,  3 Jun 2007 17:35:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bO8RpnKqSFLx; Sun,  3 Jun 2007 17:35:42 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0829B84520B4; Sun,  3 Jun 2007 17:35:42 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49008>

> I don't know if this is possible or not, but I'm trying with no resul=
ts.
>=20
> Is it possible to install gitweb on a shared hosting system, with no =
root=20
> access. Reading the INSTALL document reveals only information for=20
> configuration on build-time/install as root.

It is possible to install gitweb without root access, if you have:
1) A system to compile C programs for the hosting system
2) A directory to copy the binaries to on the hosting system. I would n=
ot make it accessible via the webserver.
3) A directory published by the webserver for static files
4) A directory which supports running perl cgis

If the requirements are met, do the following:
a) Extract git sources
b) Change in the Makefile PREFIX to the directories for the binaries
c) run make
d) If you compile on the hosting system, simple run make install. If
not, create a directory with the same patch as the binary directory on
the hosting system, run make install and copy the content of binary
directory to the hosting system (preserving the x-bits).
e) Copy gitweb/git-favicon.png, gitweb/git-logo.png and gitweb/gitweb.c=
ss onto your webserver.
f) Install gitweb/gitweb.cgi as perl CGI program. gitweb.cgi needs some=
 configuration. You can
specify them either in a seperate configuration file or change the defa=
ult settings in gitweb.cgi.

You should check the following options:
our $GIT =3D "/homes/user/bin/git"; #  path to the git binary=20
our $projectroot =3D "/pub/git"; # path to the directoriy containing al=
l git repositories
our @stylesheets =3D ("gitweb.css"); # URL to stylesheet
our $logo =3D "git-logo.png"; # URL to image
our $favicon =3D "git-favicon.png"; # URL to image

If the webserver has read (and execute for the binaries) rights on all
files (including the repositories), gitweb should work.

mfg Martin K=F6gler
