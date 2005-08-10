From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 00:11:27 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.10.22.11.25.242201@smurf.noris.de>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net> <pan.2005.08.10.21.15.41.143251@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 11 00:15:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2yps-0000oU-31
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 00:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVHJWNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 18:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVHJWNq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 18:13:46 -0400
Received: from main.gmane.org ([80.91.229.2]:16102 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932503AbVHJWNp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 18:13:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E2yoI-0000eb-3K
	for git@vger.kernel.org; Thu, 11 Aug 2005 00:12:30 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 00:12:30 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 00:12:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Debian packaging fixes for 0.99.4:

- Add a debian/changelog entry.
- Split gitk off to its own package;
  it needs tk installed, but nothing else does.
- Refer to GPL properly, don't install COPYING.
- Fix maintainer.
- Use dh_movefiles instead of dh_install;
  we don't want to list everything *except* gitk.

---
More Lintian warnings (not fixed by this patch):

W: git-core: binary-without-manpage git-LOTS
W: git-tk: binary-without-manpage gitk

Debian *really* dislikes exec tricks:
E: git-tk: shell-script-fails-syntax-check ./usr/bin/gitk

git-parse-remote is not an executable script and therefore
does *not* belong in /usr/bin:
W: git-core: executable-not-elf-or-script ./usr/bin/git-parse-remote

Do we need any newer features of diff? If not => drop from Depends:.
E: git-core: depends-on-essential-package-without-using-version depends: diff

---
diff --git a/debian/changelog b/debian/changelog
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,9 @@
+git-core (0.99.4-1) unstable; urgency=low
+
+  * Lots and lots of changes.
+
+ -- Matthias Urlichs <smurf@debian.org>  Wed, 10 Aug 2005 23:18:34 +0200
+
 git-core (0.99-2) unstable; urgency=low
 
   * Conflict with the GNU Interactive Tools package, which also installs
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -1,7 +1,7 @@
 Source: git-core
 Section: devel
 Priority: optional
-Maintainer: Linus Torvalds <torvalds@osdl.org>
+Maintainer: Junio C Hamano <junkio@cox.net>
 Build-Depends-Indep: libz-dev, libssl-dev, libcurl3-dev, asciidoc > 6.0.3, xmlto, debhelper (>= 4.0.0)
 Standards-Version: 3.6.1
 
@@ -15,5 +15,11 @@ Description: The git content addressable
  and flexible filesystem-based database designed to store directory trees
  with regard to their history. The top layer is a SCM-like tool which
  enables human beings to work with the database in a manner to a degree
- similar to other SCM tools (like CVS, BitKeeper or Monotone).
+ similar to other SCM tools.
+
+Package: git-tk
+Architecture: any
+Depends: ${shlibs:Depends}, ${misc:Depends}, git-core, tk8.4
+Description: The git content addressable filesystem, GUI add-on
+ This package contains 'gitk', the git revision tree visualizer
 
diff --git a/debian/copyright b/debian/copyright
--- a/debian/copyright
+++ b/debian/copyright
@@ -1,3 +1,19 @@
-License: 
+This package was downloaded from ftp.kernel.org:/INSERT_PATH_HERE
 
-GPL v2 (see COPYING for details)
+Upstream Author: Linus Torvalds and many others
+
+Copyright:
+
+ Copyright 2005, Linus Torvalds and others.
+ 
+ This file is free software; as a special exception the author gives
+ unlimited permission to copy and/or distribute it, with or without
+ modifications, as long as this notice is preserved.
+ 
+ This file is distributed in the hope that it will be useful, but
+ WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
+ implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+
+This program is free-software released under the terms of the GNU Public
+License, version 2.0. Please check /usr/share/common-licenses/GPL for
+more information.
diff --git a/debian/docs b/debian/docs
--- a/debian/docs
+++ b/debian/docs
@@ -1,3 +1 @@
 README
-COPYING
-
diff --git a/debian/git-core.files b/debian/git-core.files
new file mode 100644
--- /dev/null
+++ b/debian/git-core.files
@@ -0,0 +1 @@
+/usr
diff --git a/debian/git-core.install b/debian/git-core.install
deleted file mode 100644
--- a/debian/git-core.install
+++ /dev/null
@@ -1 +0,0 @@
-*
diff --git a/debian/git-tk.files b/debian/git-tk.files
new file mode 100644
--- /dev/null
+++ b/debian/git-tk.files
@@ -0,0 +1 @@
+/usr/bin/gitk
diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -61,7 +61,9 @@ install: build
 	mkdir -p $(DOC_DESTDIR)
 	find $(DOC) '(' -name '*.txt' -o -name '*.html' ')' -exec install {} $(DOC_DESTDIR) ';'
 
-	dh_install --list-missing --sourcedir=$(DESTDIR)
+	dh_movefiles -p git-tk
+	dh_movefiles -p git-core
+	find debian/tmp -type d -o -print | sed -e 's/^/? /'
 
 binary: build install
 	dh_testdir

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Any false value is gonna be fairly boring in Perl, mathematicians
notwithstanding.
             -- Larry Wall in <199707300650.XAA05515@wall.org>
