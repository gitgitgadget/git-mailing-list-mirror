From: Matthias Lederhofer <matled@gmx.net>
Subject: script to create debian package
Date: Fri, 5 May 2006 22:53:09 +0200
Message-ID: <E1Fc7IT-0003tv-Va@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
X-From: git-owner@vger.kernel.org Fri May 05 22:53:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc7IZ-000294-9r
	for gcvg-git@gmane.org; Fri, 05 May 2006 22:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWEEUxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 16:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWEEUxM
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 16:53:12 -0400
Received: from moooo.ath.cx ([85.116.203.178]:56474 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751002AbWEEUxM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 16:53:12 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19645>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I wrote a script similar to the script in scripts/package/builddeb in
the kernel tree for git. Is there any interest to integrate it into
the git source tree? I've attached the script.

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-deb-build

#!/bin/sh
tmpdir="`pwd`/debian/tmp"

make prefix=/usr all doc
make prefix="$tmpdir/usr" install install-doc

version="`cat GIT-VERSION-FILE | cut -d ' ' -f 3`"
name="git debian package script <`id -nu`@`hostname -f`>"

mkdir -p "$tmpdir/DEBIAN"

cat <<EOF > debian/control
Source: git
Section: devel
Priority: optional
Maintainer: $name
Standards-Version: 3.6.1

Package: git
Conflicts: git-arch, git-core, git-cvs, git-doc, git-email, git-svn, gitk
Provides: git-arch, git-core, git-cvs, git-doc, git-email, git-svn, gitk
Architecture: any
Description: git, version $version
 This package contains git version $version.
EOF

cat <<EOF > debian/changelog
git ($version-1) unstable; urgency=low

  * A standard release

 -- $name  `date -R`
EOF

chmod -R og-w debian/tmp
dpkg-gencontrol -isp
fakeroot dpkg --build "$tmpdir" ..

--XsQoSWH+UP9D9v3l--
