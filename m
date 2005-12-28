From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] debian/ directory
Date: Wed, 28 Dec 2005 12:20:18 +0100
Message-ID: <20051228112018.19646.qmail@c226d15586b0bf.315fe32.mid.smarden.org>
References: <7v64pbc4fh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 28 12:21:01 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErZMS-0008Hd-Ro
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 12:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVL1LUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 06:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbVL1LUP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 06:20:15 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:42674 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S964789AbVL1LUM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2005 06:20:12 -0500
Received: (qmail 19647 invoked by uid 1000); 28 Dec 2005 11:20:18 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v64pbc4fh.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14096>

On Tue, Dec 27, 2005 at 12:47:14AM -0800, Junio C Hamano wrote:
> Starting from this one I won't be touching debian/ directory,
> nor supplying pre-built Debian binaries anymore.
> The official maintainer seems to be reasonably quick to package
> up things.  The packaging procedure used there seems to be quite

Yes, I'm trying to keep up with your development speed..

> different from what I have, so I'd like to avoid potential
> confusion and reduce work by the official maintainer and myself.

Thanks.  The most notable change is that debhelper isn't used to do the
packaging stuff, and the build-dependency has been dropped; this is
after my personal preference.

Below is the diff for reference, I think though it might be better if
you don't include the debian/ directory in the upstream package at all.
It may well be that I'm not always available immediately if things need
to be changed in debian/, but do as you wish.

Regards, Gerrit.


* don't use debhelper, use implicit rules.
* rename package git-tk to gitk; adjust Build-Depends*, Depends, Recommends,
  Suggests, Section, Description; Replaces: cogito (<< 0.16rc2-0) (ease
  upgrade from previous cogito packages which include git-core); Conflicts:
  git (<< 4.3.20-8) (/usr/bin/git transition).
* build with NO_OPENSSL=1 WITH_SEND_EMAIL=1 WITH_OWN_SUBPROCESS_PY=1
  prefix=/usr, python 2.3; disable t/t6001-rev-list-merge-order.sh (test
  fails with NO_OPENSSL=1).

Signed-off-by: Gerrit Pape <pape@smarden.org>

---

 debian/changelog         |  114 ++++++++++++++----------
 debian/compat            |    1 
 debian/control           |  141 +++++++++++++++++++++---------
 debian/copyright         |   38 ++++----
 debian/docs              |    1 
 debian/git-arch.files    |    2 
 debian/git-core.doc-base |   13 ---
 debian/git-core.docs     |    1 
 debian/git-core.files    |    1 
 debian/git-core.postinst |    5 +
 debian/git-core.prerm    |    5 +
 debian/git-cvs.files     |    2 
 debian/git-doc.docs      |    2 
 debian/git-doc.files     |    4 -
 debian/git-email.files   |    2 
 debian/git-svn.files     |    2 
 debian/git-tk.files      |    2 
 debian/implicit          |   93 ++++++++++++++++++++
 debian/rules             |  215 ++++++++++++++++++++++++++--------------------
 19 files changed, 410 insertions(+), 234 deletions(-)
 delete mode 100644 debian/compat
 delete mode 100644 debian/docs
 delete mode 100644 debian/git-arch.files
 delete mode 100644 debian/git-core.doc-base
 create mode 100644 debian/git-core.docs
 delete mode 100644 debian/git-core.files
 create mode 100755 debian/git-core.postinst
 create mode 100755 debian/git-core.prerm
 delete mode 100644 debian/git-cvs.files
 create mode 100644 debian/git-doc.docs
 delete mode 100644 debian/git-doc.files
 delete mode 100644 debian/git-email.files
 delete mode 100644 debian/git-svn.files
 delete mode 100644 debian/git-tk.files
 create mode 100644 debian/implicit

580d1d4562b44410f2cc5b7c1f81ced6b0b3d646
diff --git a/debian/changelog b/debian/changelog
index d7f7591..1df7491 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,73 +1,93 @@
-git-core (1.0.GIT-0) unstable; urgency=low
+git-core (1.0.5-1) unstable; urgency=low
 
-  * Post GIT 1.0 development track.
+  * new upstream point release.
+  * debian/rules: don't take upstream changelog from upstream
+    debian/changelog.
+  * debian/changelog.upstream: remove again.
 
- -- Junio C Hamano <junkio@cox.net>  Wed, 21 Dec 2005 22:28:33 -0800
+ -- Gerrit Pape <pape@smarden.org>  Tue, 27 Dec 2005 13:25:53 +0000
 
-git-core (1.0.0.GIT-0) unstable; urgency=low
+git-core (1.0.3-1) unstable; urgency=low
 
-  * Post GIT 1.0.0 development track.
+  * new upstream point release.
+  * debian/changelog.upstream: new: upstream changelog taken from upstream
+    debian/changelog.
+  * debian/rules: install debian/changelog.upstream as upstream changelog;
+    remove obsolete VERSION variable.
 
- -- Junio C Hamano <junkio@cox.net>  Wed, 21 Dec 2005 12:12:05 -0800
+ -- Gerrit Pape <pape@smarden.org>  Fri, 23 Dec 2005 14:58:14 +0000
 
-git-core (1.0.4-0) unstable; urgency=low
+git-core (1.0.0-1) unstable; urgency=medium
 
-  * GIT 1.0.4.
+  * new upstream release: GIT 1.0.0.
 
- -- Junio C Hamano <junkio@cox.net>  Sat, 24 Dec 2005 00:01:20 -0800
+ -- Gerrit Pape <pape@smarden.org>  Wed, 21 Dec 2005 16:17:18 +0000
 
-git-core (1.0.3-0) unstable; urgency=low
+git-core (0.99.9n-1) unstable; urgency=low
 
-  * GIT 1.0.3 maintenance release.
+  * new upstream version: GIT 0.99.9n aka 1.0rc6.
+  * debian/rules: rename git program in git-core package to git-scm,
+    handle /usr/bin/git program through update-alternatives (as suggested
+    by Ian Beckwith, see #342363).
+  * debian/control: git-core: Conflicts: git (<< 4.3.20-8) (closes:
+    #342363).
+  * debian/git-core.postinst, debian/git-core.prerm: new: run
+    update-alternatives --install /usr/bin/git git /usr/bin/git-scm with
+    priority 70 on configure, and --remove on remove respectively.
 
- -- Junio C Hamano <junkio@cox.net>  Thu, 22 Dec 2005 18:13:33 -0800
+ -- Gerrit Pape <pape@smarden.org>  Thu, 15 Dec 2005 11:24:51 +0000
 
-git-core (1.0.0b-0) unstable; urgency=low
+git-core (0.99.9m-1) unstable; urgency=low
 
-  * GIT 1.0.0b to include two more fixes.
+  * new upstream version: GIT 0.99.9m aka 1.0rc5.
+    * sets PYTHONPATH for selftests (fixes autobuild test failures).
+  * switch from tarball-in-tarball approach to original upstream tarball.
+  * debian/changelog: add changelog history, Junio C Hamano, Ryan Anderson,
+    Eric Biederman previously were maintaining this package unofficially.
+  * debian/control: Build-Depends: rcs (for selftests); git-core:
+    Recommends: patch, less, Suggests: cogito; git-arch: Suggests: tla,
+    bazzar; git-cvs: Depends: cvsps, Suggests: cvs; git-svn: Depends:
+    libsvn-core-perl (closes:#342617), Suggests: subversion; git-email:
+    Depends: libmail-sendmail-perl, libemail-valod-perl; update short
+    description (lots taken from upstream unofficial package, thx).
+  * debian/git-core.docs, debian/git-doc.docs: adapt.
+  * debian/rules: adapt; remove target unpack; add target patch; adapt
+    target clean.
 
- -- Junio C Hamano <junkio@cox.net>  Wed, 21 Dec 2005 13:50:21 -0800
+ -- Gerrit Pape <pape@smarden.org>  Wed, 14 Dec 2005 19:48:41 +0000
 
-git-core (1.0.0a-0) unstable; urgency=low
+git-core (0.99.9l-1) unstable; urgency=low
 
-  * GIT 1.0.0a to include the following fixes:
-  
-    - Avoid misleading success message on error (Johannes)
-    - objects/info/packs: work around bug in http-fetch.c::fetch_indices()
-    - http-fetch.c: fix objects/info/pack parsing.
-    - An off-by-one bug found by valgrind (Pavel)
+  * new upstream version.
+  * debian/rules: apply diffs with patch -p1.
+  * debian/control, debian/rules: split off git-arch, git-cvs, git-svn,
+    git-email packages, as suggested by upstream:
+    http://article.gmane.org/gmane.comp.version-control.git/13185
+  * debian/git-doc.docs: get docs from temporary install directory;
+    include *.txt docs.
+  * debian/control: git-doc: Section: doc; Suggests: git-core, git-arch,
+    git-cvs, git-svn, git-email, gitk; git-core: Suggests: git-arch,
+    git-cvs, git-svn, git-email, gitk.
 
- -- Junio C Hamano <junkio@cox.net>  Wed, 21 Dec 2005 13:17:17 -0800
+ -- Gerrit Pape <pape@smarden.org>  Mon,  5 Dec 2005 18:04:37 +0000
 
-git-core (1.0.0-0) unstable; urgency=low
+git-core (0.99.9k-1) unstable; urgency=low
 
-  * GIT 1.0.0
+  * new upstream version.
+  * debian/implicit: update to revision 1.11.
+  * debian/git-doc.docs: add git/Documentation/howto,
+    git/Documentation/technical (closes: #341178).
 
- -- Junio C Hamano <junkio@cox.net>  Wed, 21 Dec 2005 00:01:00 -0800
+ -- Gerrit Pape <pape@smarden.org>  Tue, 29 Nov 2005 21:45:53 +0000
 
-git-core (0.99.9n-0) unstable; urgency=low
+git-core (0.99.9j-1) unstable; urgency=low
 
-  * GIT 0.99.9n aka 1.0rc6
+  * initial version.
+  * debian/control: git-core: Replaces: cogito (<< 0.16rc2-0); cogito >=
+    0.16rc2-0 no longer includes the git core components, but depends on
+    the git-core package (see #338789).
 
- -- Junio C Hamano <junkio@cox.net>  Wed, 14 Dec 2005 17:27:08 -0800
-
-git-core (0.99.9m-0) unstable; urgency=low
-
-  * GIT 0.99.9m aka 1.0rc5
-
- -- Junio C Hamano <junkio@cox.net>  Sun, 11 Dec 2005 16:48:06 -0800
-
-git-core (0.99.9l-0) unstable; urgency=low
-
-  * GIT 0.99.9l aka 1.0rc4
-
- -- Junio C Hamano <junkio@cox.net>  Sat,  3 Dec 2005 23:45:23 -0800
-
-git-core (0.99.9k-0) unstable; urgency=low
-
-  * GIT 0.99.9k but not 1.0rc yet.
-
- -- Junio C Hamano <junkio@cox.net>  Fri, 25 Nov 2005 16:33:11 -0800
+ -- Gerrit Pape <pape@smarden.org>  Fri, 18 Nov 2005 22:26:36 +0000
 
 git-core (0.99.9j-0) unstable; urgency=low
 
diff --git a/debian/compat b/debian/compat
deleted file mode 100644
index b8626c4..0000000
--- a/debian/compat
+++ /dev/null
@@ -1 +0,0 @@
-4
diff --git a/debian/control b/debian/control
index ded0a57..33551b5 100644
--- a/debian/control
+++ b/debian/control
@@ -1,63 +1,118 @@
 Source: git-core
 Section: devel
 Priority: optional
-Maintainer: Junio C Hamano <junkio@cox.net>
-Build-Depends-Indep: libz-dev, libssl-dev, libcurl3-dev|libcurl3-gnutls-dev|libcurl3-openssl-dev, asciidoc (>= 7), xmlto, debhelper (>= 4.0.0), bc, libexpat-dev
-Standards-Version: 3.6.1
+Maintainer: Gerrit Pape <pape@smarden.org>
+Build-Depends: libz-dev, libcurl3-gnutls-dev, asciidoc, xmlto, libexpat1-dev, rcs
+Standards-Version: 3.6.2.0
 
 Package: git-core
 Architecture: any
-Depends: ${shlibs:Depends}, ${perl:Depends}, ${misc:Depends}, rcs
-Recommends: rsync, curl, ssh, python (>= 2.4.0), less
-Suggests: cogito, patch
-Conflicts: git, cogito (<< 0.13)
-Description: The git content addressable filesystem
- GIT comes in two layers. The bottom layer is merely an extremely fast
- and flexible filesystem-based database designed to store directory trees
- with regard to their history. The top layer is a SCM-like tool which
- enables human beings to work with the database in a manner to a degree
- similar to other SCM tools.
+Depends: ${shlibs:Depends}, rcs
+Recommends: git-doc, patch, less, rsync, curl, openssh-client, python
+Suggests: git-arch, git-cvs, git-svn, git-email, gitk, cogito
+Replaces: cogito (<< 0.16rc2-0)
+Conflicts: git (<< 4.3.20-8)
+Description: content addressable filesystem
+ This is a stupid (but extremely fast) directory content manager.  It
+ doesn't do a whole lot, but what it 'does' do is track directory
+ contents efficiently.
+ .
+ Amongst other projects, the Linux kernel source tree is managed through
+ the git content manager.
+ .
+ This package provides the git core components.
 
 Package: git-doc
+Section: doc
 Architecture: all
-Depends: ${shlibs:Depends}, ${misc:Depends}, git-core
-Description: The git content addressable filesystem, Documentation
- This package contains documentation for GIT.
-
-Package: git-tk
-Architecture: all
-Depends: ${shlibs:Depends}, ${misc:Depends}, git-core, tk8.4
-Description: The git content addressable filesystem, GUI add-on
- This package contains 'gitk', the git revision tree visualizer.
-
-Package: git-svn
-Architecture: all
-Depends: ${shlibs:Depends}, ${misc:Depends}, ${perl:Depends}, git-core, libsvn-core-perl (>= 1.2.1)
-Suggests: subversion
-Description: The git content addressable filesystem, SVN interoperability
- This package contains 'git-svnimport', to import development history from
- SVN repositories.
+Suggests: git-core, git-arch, git-cvs, git-svn, git-email, gitk
+Description: content addressable filesystem (documentation)
+ This is a stupid (but extremely fast) directory content manager.  It
+ doesn't do a whole lot, but what it 'does' do is track directory
+ contents efficiently.
+ .
+ Amongst other projects, the Linux kernel source tree is managed through
+ the git content manager.
+ .
+ This package provides the documentation.
 
 Package: git-arch
 Architecture: all
-Depends: ${shlibs:Depends}, ${misc:Depends}, ${perl:Depends}, git-core
+Depends: git-core (= ${Source-Version})
+Recommends: git-doc
 Suggests: tla, bazaar
-Description: The git content addressable filesystem, GNUArch interoperability
- This package contains 'git-archimport', to import development history from
- GNUArch repositories.
+Replaces: cogito (<< 0.16rc2-0)
+Description: content addressable filesystem (arch interoperability)
+ This is a stupid (but extremely fast) directory content manager.  It
+ doesn't do a whole lot, but what it 'does' do is track directory
+ contents efficiently.
+ .
+ Amongst other projects, the Linux kernel source tree is managed through
+ the git content manager.
+ .
+ This package provides tools for importing development history from arch
+ repositories.
 
 Package: git-cvs
 Architecture: all
-Depends: ${shlibs:Depends}, ${misc:Depends}, ${perl:Depends}, git-core, cvsps (>= 2.1)
+Depends: git-core (= ${Source-Version}), cvsps
+Recommends: git-doc
 Suggests: cvs
-Description: The git content addressable filesystem, CVS interoperability
- This package contains 'git-cvsimport', to import development history from
- CVS repositories.
+Replaces: cogito (<< 0.16rc2-0)
+Description: content addressable filesystem (cvs interoperability)
+ This is a stupid (but extremely fast) directory content manager.  It
+ doesn't do a whole lot, but what it 'does' do is track directory
+ contents efficiently.
+ .
+ Amongst other projects, the Linux kernel source tree is managed through
+ the git content manager.
+ .
+ This package provides tools for importing development history from cvs
+ repositories.
 
-Package: git-email
+Package: git-svn
 Architecture: all
-Depends: ${shlibs:Depends}, ${misc:Depends}, git-core, libmail-sendmail-perl, libemail-valid-perl
-Description: The git content addressable filesystem, e-mail add-on
- This package contains 'git-send-email', to send a series of patch e-mails.
-
+Depends: git-core (= ${Source-Version}), libsvn-core-perl
+Recommends: git-doc
+Suggests: subversion
+Replaces: cogito (<< 0.16rc2-0)
+Description: content addressable filesystem (svn interoperability)
+ This is a stupid (but extremely fast) directory content manager.  It
+ doesn't do a whole lot, but what it 'does' do is track directory
+ contents efficiently.
+ .
+ Amongst other projects, the Linux kernel source tree is managed through
+ the git content manager.
+ .
+ This package provides tools for importing development history from
+ subversion repositories.
 
+Package: git-email
+Architecture: all
+Depends: git-core (= ${Source-Version}), libmail-sendmail-perl, libemail-valid-perl
+Recommends: git-doc
+Replaces: cogito (<< 0.16rc2-0)
+Description: content addressable filesystem (email add-on)
+ This is a stupid (but extremely fast) directory content manager.  It
+ doesn't do a whole lot, but what it 'does' do is track directory
+ contents efficiently.
+ .
+ Amongst other projects, the Linux kernel source tree is managed through
+ the git content manager.
+ .
+ This package provides tools for sending series of patch emails.
+
+Package: gitk
+Architecture: all
+Depends: git-core (= ${Source-Version}), tk8.4
+Recommends: git-doc
+Replaces: cogito (<< 0.16rc2-0)
+Description: content addressable filesystem (revision tree visualizer)
+ This is a stupid (but extremely fast) directory content manager.  It
+ doesn't do a whole lot, but what it 'does' do is track directory
+ contents efficiently.
+ .
+ Amongst other projects, the Linux kernel source tree is managed through
+ the git content manager.
+ .
+ This package provides the gitk program, a tcl/tk revision tree visualizer.
diff --git a/debian/copyright b/debian/copyright
index ea61eff..d84775a 100644
--- a/debian/copyright
+++ b/debian/copyright
@@ -1,24 +1,24 @@
-This package was downloaded from ftp.kernel.org:/pub/software/scm/git/.
+This package was debianized by Sebastian Kuzminsky <seb@highlab.com>
+on Thu, 5 May 2005 10:27:14 -0600,
+and was adopted by Gerrit Pape <pape@smarden.org>
+on Wed, 16 Nov 2005 19:37:14 +0000.
 
-Upstream Author: Linus Torvalds and many others
+It was downloaded from http://www.kernel.org/pub/software/scm/git/
+
+Upstream authors: Linus Torvalds and many others
 
 Copyright:
 
- Copyright 2005, Linus Torvalds and others.
- 
-   This package is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; version 2 dated June, 1991.
-
-   This package is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this package; if not, write to the Free Software
-   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-   02111-1307, USA.
+This software is copyright (c) 2005, Linus Torvalds and others.
+
+You can redistribute this software and/or modify it under the terms of
+the GNU General Public License as published by the Free Software
+Foundation; version 2 dated June, 1991.
+
+This program is distributed in the hope that it will be useful, but
+WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+General Public License for more details.
 
-On Debian GNU/Linux systems, the complete text of the GNU General
-Public License can be found in `/usr/share/common-licenses/GPL'.
+On Debian systems, the complete text of the GNU General Public License
+can be found in /usr/share/common-licenses/GPL-2 file.
diff --git a/debian/docs b/debian/docs
deleted file mode 100644
index e845566..0000000
--- a/debian/docs
+++ /dev/null
@@ -1 +0,0 @@
-README
diff --git a/debian/git-arch.files b/debian/git-arch.files
deleted file mode 100644
index d744954..0000000
--- a/debian/git-arch.files
+++ /dev/null
@@ -1,2 +0,0 @@
-/usr/bin/git-arch*
-/usr/share/man/*/git-arch*
diff --git a/debian/git-core.doc-base b/debian/git-core.doc-base
deleted file mode 100644
index eff1a95..0000000
--- a/debian/git-core.doc-base
+++ /dev/null
@@ -1,13 +0,0 @@
-Document: git-core
-Title: git reference
-Abstract: This manual describes git
-Section: Devel
-
-Format: HTML
-Index: /usr/share/doc/git-core/git.html
-Files: /usr/share/doc/git-core/*.html
- /usr/share/doc/git-core/*/*.html
-
-Format: text
-Files: /usr/share/doc/git-core/*.txt
- /usr/share/doc/git-core/*/*.txt
diff --git a/debian/git-core.docs b/debian/git-core.docs
new file mode 100644
index 0000000..e845566
--- /dev/null
+++ b/debian/git-core.docs
@@ -0,0 +1 @@
+README
diff --git a/debian/git-core.files b/debian/git-core.files
deleted file mode 100644
index 74e4e23..0000000
--- a/debian/git-core.files
+++ /dev/null
@@ -1 +0,0 @@
-/usr
diff --git a/debian/git-core.postinst b/debian/git-core.postinst
new file mode 100755
index 0000000..230f515
--- /dev/null
+++ b/debian/git-core.postinst
@@ -0,0 +1,5 @@
+#!/bin/sh
+set -e
+
+test "$1" = 'configure' || exit 0
+update-alternatives --install /usr/bin/git git /usr/bin/git-scm 70
diff --git a/debian/git-core.prerm b/debian/git-core.prerm
new file mode 100755
index 0000000..26feff4
--- /dev/null
+++ b/debian/git-core.prerm
@@ -0,0 +1,5 @@
+#!/bin/sh
+set -e
+
+test "$1" = 'remove' || exit 0
+update-alternatives --remove git /usr/bin/git-scm
diff --git a/debian/git-cvs.files b/debian/git-cvs.files
deleted file mode 100644
index a6b40ff..0000000
--- a/debian/git-cvs.files
+++ /dev/null
@@ -1,2 +0,0 @@
-/usr/bin/git-cvs*
-/usr/share/man/*/git-cvs*
diff --git a/debian/git-doc.docs b/debian/git-doc.docs
new file mode 100644
index 0000000..b0a52bc
--- /dev/null
+++ b/debian/git-doc.docs
@@ -0,0 +1,2 @@
+tmp/html/*
+Documentation/technical
diff --git a/debian/git-doc.files b/debian/git-doc.files
deleted file mode 100644
index 0daf545..0000000
--- a/debian/git-doc.files
+++ /dev/null
@@ -1,4 +0,0 @@
-/usr/share/doc/git-core/*.txt
-/usr/share/doc/git-core/*.html
-/usr/share/doc/git-core/*/*.html
-/usr/share/doc/git-core/*/*.txt
diff --git a/debian/git-email.files b/debian/git-email.files
deleted file mode 100644
index 2d6a51f..0000000
--- a/debian/git-email.files
+++ /dev/null
@@ -1,2 +0,0 @@
-/usr/bin/git-send-email
-/usr/share/man/*/git-send-email.*
diff --git a/debian/git-svn.files b/debian/git-svn.files
deleted file mode 100644
index eea8d83..0000000
--- a/debian/git-svn.files
+++ /dev/null
@@ -1,2 +0,0 @@
-/usr/bin/git-svn*
-/usr/share/man/*/git-svn*
diff --git a/debian/git-tk.files b/debian/git-tk.files
deleted file mode 100644
index 478ec94..0000000
--- a/debian/git-tk.files
+++ /dev/null
@@ -1,2 +0,0 @@
-/usr/bin/gitk
-/usr/share/man/man1/gitk.*
diff --git a/debian/implicit b/debian/implicit
new file mode 100644
index 0000000..7a7ee98
--- /dev/null
+++ b/debian/implicit
@@ -0,0 +1,93 @@
+# $Id: implicit,v 1.11 2005/11/29 21:57:55 pape Exp $
+
+.PHONY: deb-checkdir deb-checkuid
+
+deb-checkdir:
+	@test -e debian/control || sh -cx '! : wrong directory'
+deb-checkuid:
+	@test "`id -u`" -eq 0 || sh -cx '! : need root privileges'
+
+%.deb: %.deb-docs %.deb-DEBIAN
+	@rm -f $*.deb $*.deb-checkdir $*.deb-docs $*.deb-docs-base \
+	  $*.deb-docs-docs $*.deb-docs-examples $*.deb-DEBIAN \
+	  $*.deb-DEBIAN-dir $*.deb-DEBIAN-scripts $*.deb-DEBIAN-md5sums
+
+%.udeb: %.deb-DEBIAN
+	@rm -f $*.deb $*.deb-checkdir $*.deb-DEBIAN $*.deb-DEBIAN-dir \
+	  $*.deb-DEBIAN-scripts $*.deb-DEBIAN-md5sums
+
+%.deb-checkdir:
+	@test -d debian/$* || sh -cx '! : directory debian/$* missing'
+	@test "`id -u`" -eq 0 || sh -cx '! : need root privileges'
+
+%.deb-docs-base:
+	: implicit
+	@rm -f debian/$*/usr/share/doc/$*/* || :
+	@install -d -m0755 debian/$*/usr/share/doc/$*
+	: debian/$*/usr/share/doc/$*/
+	@sh -cx 'install -m0644 debian/copyright debian/$*/usr/share/doc/$*/'
+	@sh -cx 'install -m0644 debian/changelog \
+	  debian/$*/usr/share/doc/$*/changelog.Debian'
+	@test ! -r changelog || \
+	  sh -cx 'install -m0644 changelog debian/$*/usr/share/doc/$*/'
+	@test -r debian/$*/usr/share/doc/$*/changelog || \
+	  sh -cx 'mv debian/$*/usr/share/doc/$*/changelog.Debian \
+	    debian/$*/usr/share/doc/$*/changelog'
+	@test -s debian/$*/usr/share/doc/$*/changelog || \
+	  sh -cx 'rm -f debian/$*/usr/share/doc/$*/changelog'
+	@gzip -9 debian/$*/usr/share/doc/$*/changelog*
+%.deb-docs-docs:
+	@for i in `cat debian/$*.docs 2>/dev/null || :`; do \
+	  if test -d $$i; then \
+	    sh -cx "install -d -m0755 debian/$*/usr/share/doc/$*/$${i##*/}" && \
+	    for j in $$i/*; do \
+	      sh -cx "install -m0644 $$j \
+	        debian/$*/usr/share/doc/$*/$${i##*/}/" || exit 1; \
+	    done || exit 1; \
+	    continue; \
+	  fi; \
+	  sh -cx "install -m0644 $$i debian/$*/usr/share/doc/$*/" || exit 1; \
+	done
+	@test ! -r debian/$*.README.Debian || \
+	  sh -cx 'install -m0644 debian/$*.README.Debian \
+	    debian/$*/usr/share/doc/$*/README.Debian'
+	@if test -r debian/$*.NEWS.Debian; then \
+	  sh -cx 'install -m0644 debian/$*.NEWS.Debian \
+	    debian/$*/usr/share/doc/$*/NEWS.Debian && \
+	      gzip -9 debian/$*/usr/share/doc/$*/NEWS.Debian'; \
+	fi
+%.deb-docs-examples:
+	@rm -rf debian/$*/usr/share/doc/$*/examples
+	: debian/$*/usr/share/doc/$*/examples/
+	@test ! -r debian/$*.examples || \
+	  install -d -m0755 debian/$*/usr/share/doc/$*/examples
+	@for i in `cat debian/$*.examples 2>/dev/null || :`; do \
+	  sh -cx "install -m0644 $$i debian/$*/usr/share/doc/$*/examples/" \
+	    || exit 1; \
+	done
+%.deb-docs: %.deb-checkdir %.deb-docs-base %.deb-docs-docs %.deb-docs-examples
+	: debian/$*/usr/share/doc/$*/ ok
+
+%.deb-DEBIAN-base:
+	@rm -rf debian/$*/DEBIAN
+	: debian/$*/DEBIAN/
+	@install -d -m0755 debian/$*/DEBIAN
+	@for i in conffiles shlibs templates; do \
+	  test ! -r debian/$*.$$i || \
+	    sh -cx "install -m0644 debian/$*.$$i debian/$*/DEBIAN/$$i" \
+	      || exit 1; \
+	done
+%.deb-DEBIAN-scripts:
+	@for i in preinst prerm postinst postrm config; do \
+	  test ! -r debian/$*.$$i || \
+	    sh -cx "install -m0755 debian/$*.$$i debian/$*/DEBIAN/$$i" \
+	      || exit 1; \
+	done
+%.deb-DEBIAN-md5sums:
+	: debian/$*/DEBIAN/md5sums
+	@rm -f debian/$*/DEBIAN/md5sums
+	@cd debian/$* && find * -path 'DEBIAN' -prune -o \
+	  -type f -exec md5sum {} >>DEBIAN/md5sums \;
+%.deb-DEBIAN: %.deb-checkdir %.deb-DEBIAN-base %.deb-DEBIAN-scripts \
+	  %.deb-DEBIAN-md5sums
+	: debian/$*/DEBIAN/ ok
diff --git a/debian/rules b/debian/rules
index 4ab221c..b0607ed 100755
--- a/debian/rules
+++ b/debian/rules
@@ -1,109 +1,134 @@
 #!/usr/bin/make -f
-# -*- makefile -*-
 
-# Uncomment this to turn on verbose mode.
-#export DH_VERBOSE=1
+ARCH ?=$(shell dpkg-architecture -qDEB_HOST_ARCH)
 
-CFLAGS = -g -Wall
+CC =gcc
+CFLAGS =-g -Wall
+STRIP =strip
+OPTS =NO_OPENSSL=1 WITH_SEND_EMAIL=1 WITH_OWN_SUBPROCESS_PY=1 prefix=/usr
+
+ifneq (,$(findstring nostrip,$(DEB_BUILD_OPTIONS)))
+  STRIP =: strip
+endif
 ifneq (,$(findstring noopt,$(DEB_BUILD_OPTIONS)))
-       CFLAGS += -O0
+  CFLAGS +=-O0
 else
-       CFLAGS += -O2
+  CFLAGS +=-O2
 endif
-export CFLAGS
-
-#
-# On PowerPC we compile against the hand-crafted assembly, on all
-# other architectures we compile against GPL'ed sha1 code lifted
-# from Mozilla.  OpenSSL is strangely licensed and best avoided
-# in Debian.
-#
-HOST_ARCH=$(shell dpkg-architecture -qDEB_HOST_ARCH)
-ifeq (${HOST_ARCH},powerpc)
-	export PPC_SHA1=YesPlease
+ifeq (powerpc,$(ARCH))
+  OPTS +=PPC_SHA1=1
 else
-	export MOZILLA_SHA1=YesPlease
+ifeq (arm,$(ARCH))
+  OPTS +=ARM_SHA1=1
+endif
 endif
 
-# We do have the requisite perl modules in the mainline, and
-# have no reason to shy away from this script.
-export WITH_SEND_EMAIL=YesPlease
-
-PREFIX := /usr
-MANDIR := /usr/share/man/
-
-SRC    := ./
-DOC    := Documentation/
-DESTDIR  := $(CURDIR)/debian/tmp
-DOC_DESTDIR := $(DESTDIR)/usr/share/doc/git-core/
-MAN_DESTDIR := $(DESTDIR)/$(MANDIR)
-
-build: debian/build-stamp
-debian/build-stamp:
-	dh_testdir
-	$(MAKE) prefix=$(PREFIX) PYTHON_PATH=/usr/bin/python2.4 all test doc
-	touch debian/build-stamp
-
-debian-clean:
-	dh_testdir
-	dh_testroot
-	rm -f debian/build-stamp
-	dh_clean
+TMP =$(shell pwd)/tmp
+GIT =$(shell pwd)/debian/git
 
-clean: debian-clean
-	$(MAKE) clean
+patch: deb-checkdir patch-stamp
+patch-stamp:
+	for i in `ls -t debian/diff/*.diff || :`; do \
+	  patch -p1 <$$i || exit 1; \
+	done
+	touch patch-stamp
+
+build: deb-checkdir build-arch-stamp build-indep-stamp
+build-arch-stamp: patch-stamp
+	-gcc -v
+	# don't run git-rev-list --merge-order tests
+	rm -f t/t6001-rev-list-merge-order.sh
+	$(MAKE) all test CC='$(CC)' CFLAGS='$(CFLAGS)' $(OPTS)
+	$(MAKE) -CDocumentation man
+	touch build-arch-stamp
+build-indep-stamp: build-arch-stamp
+	$(MAKE) -CDocumentation man html
+	touch build-indep-stamp
 
-install: build
-	dh_testdir
-	dh_testroot
-	dh_clean -k 
-	dh_installdirs 
-
-	make DESTDIR=$(DESTDIR) prefix=$(PREFIX) mandir=$(MANDIR) \
-		install install-doc
-
-	make -C Documentation DESTDIR=$(DESTDIR) prefix=$(PREFIX) \
-		WEBDOC_DEST=$(DOC_DESTDIR) install-webdoc
-
-	dh_movefiles -p git-arch
-	dh_movefiles -p git-cvs
-	dh_movefiles -p git-svn
-	dh_movefiles -p git-tk
-	dh_movefiles -p git-email
-	dh_movefiles -p git-doc
-	dh_movefiles -p git-core
-	find debian/tmp -type d -o -print | sed -e 's/^/? /'
-
-binary-arch: build install
-	dh_testdir
-	dh_testroot
-	dh_installchangelogs -a
-	dh_installdocs -a
-	dh_strip -a
-	dh_compress  -a
-	dh_fixperms -a
-	dh_perl -a
-	dh_makeshlibs -a
-	dh_installdeb -a
-	dh_shlibdeps -a
-	dh_gencontrol -a
-	dh_md5sums -a
-	dh_builddeb -a
-
-binary-indep: build install
-	dh_testdir
-	dh_testroot
-	dh_installchangelogs -i
-	dh_installdocs -i
-	dh_compress  -i
-	dh_fixperms -i
-	dh_makeshlibs -i
-	dh_installdeb -i
-	dh_shlibdeps -i
-	dh_gencontrol -i
-	dh_md5sums -i
-	dh_builddeb -i
+clean: deb-checkdir deb-checkuid
+	$(MAKE) clean
+	rm -f git-send-email compat/subprocess.pyc
+	! test -e patch-stamp || \
+	  for i in `ls -tr debian/diff/*.diff || :`; do patch -p1 -R <$$i; done
+	rm -rf '$(TMP)'
+	rm -f patch-stamp build-arch-stamp build-indep-stamp
+	rm -rf '$(GIT)'-core '$(GIT)'-doc '$(GIT)'-arch '$(GIT)'-cvs \
+	  '$(GIT)'-svn '$(GIT)'-email '$(GIT)'k
+	rm -f debian/files debian/substvars changelog
+
+install: install-arch install-indep
+install-arch: deb-checkdir deb-checkuid build-arch-stamp
+	# git-core
+	rm -rf '$(GIT)-core'
+	install -d -m0755 '$(GIT)'-core/usr/bin
+	$(MAKE) install install-doc $(OPTS) DESTDIR='$(GIT)'-core
+	# don't include arch, cvs, svn, email tools, and gitk program
+	for i in git-arch git-cvs git-svn git-send-email; do \
+	  rm -f '$(GIT)'-core/usr/bin/$$i*; \
+	done
+	rm -f '$(GIT)'-core/usr/bin/gitk
+	# handle git program through alternatives mechanism (see #342363), rename
+	# to git-scm
+	mv -f '$(GIT)'-core/usr/bin/git '$(GIT)'-core/usr/bin/git-scm
+	for i in '$(GIT)'-core/usr/bin/*; do \
+	  test "`head -c2 $$i`" = '#!' || $(STRIP) -R .comment -R .note $$i; \
+	done
+	install -d -m0755 '$(GIT)'-core/usr/share
+	mv -f '$(GIT)'-core/usr/man '$(GIT)'-core/usr/share/
+	# don't include arch, cvs, svn, email, and gitk man pages
+	for i in git-arch git-cvs git-svn git-send-email; do \
+	  rm -f '$(GIT)'-core/usr/share/man/man1/$$i*; \
+	done
+	rm -f '$(GIT)'-core/usr/share/man/man1/gitk.1
+	chmod 0644 '$(GIT)'-core/usr/share/man/man?/*.[0-9]
+	gzip -9 '$(GIT)'-core/usr/share/man/man?/*.[0-9]
+	# no upstream changelog
+	cp /dev/null changelog
+install-indep: build-arch-stamp build-indep-stamp
+	rm -rf '$(TMP)'
+	install -d -m0755 '$(TMP)'
+	$(MAKE) install install-doc $(OPTS) DESTDIR='$(TMP)'
+	$(MAKE) -CDocumentation install-webdoc WEBDOC_DEST='$(TMP)'/html \
+	  2>/dev/null
+	# git-doc
+	rm -rf '$(GIT)'-doc
+	install -d -m0755 '$(GIT)'-doc
+	# git-arch, git-cvs, git-svn, git-email
+	for i in arch cvs svn email; do \
+	  rm -rf '$(GIT)'-$$i && \
+	  install -d -m0755 '$(GIT)'-$$i/usr/bin && \
+	  install -m0755 '$(TMP)'/usr/bin/git-*$$i* '$(GIT)'-$$i/usr/bin/ && \
+	  install -d -m0755 '$(GIT)'-$$i/usr/share/man/man1 && \
+	  install -m0644 '$(TMP)'/usr/man/man1/git-*$$i* \
+	    '$(GIT)'-$$i/usr/share/man/man1/ && \
+	  gzip -9 '$(GIT)'-$$i/usr/share/man/man1/*.1 || exit 1; \
+	done
+	# gitk
+	rm -rf '$(GIT)'k
+	install -d -m0755 '$(GIT)'k/usr/bin
+	install -m0755 '$(TMP)'/usr/bin/gitk '$(GIT)'k/usr/bin/gitk
+	install -d -m0755 '$(GIT)'k/usr/share/man/man1
+	install -m0644 '$(TMP)'/usr/man/man1/gitk.1 \
+	  '$(GIT)'k/usr/share/man/man1/
+	gzip -9 '$(GIT)'k/usr/share/man/man1/*.1
+	# no upstream changelog
+	cp /dev/null changelog
 
 binary: binary-arch binary-indep
+binary-arch: install-arch git-core.deb
+	rm -f debian/substvars
+	dpkg-shlibdeps '$(GIT)'-core/usr/bin/*
+	dpkg-gencontrol -isp -pgit-core -P'$(GIT)'-core
+	dpkg -b '$(GIT)'-core ..
+binary-indep: install-indep git-doc.deb git-arch.deb git-cvs.deb git-svn.deb \
+	  git-email.deb gitk.deb
+	rm -f debian/substvars
+	for i in -doc -arch -cvs -svn -email k; do \
+	  dpkg-gencontrol -isp -pgit$$i -P'$(GIT)'$$i && \
+	  dpkg -b '$(GIT)'$$i .. || exit 1; \
+	done
+
+.PHONY: patch build clean install install-arch install-indep binary \
+	  binary-arch binary-indep
 
-.PHONY: build clean binary install clean debian-clean
+include debian/implicit
-- 
1.0.3
