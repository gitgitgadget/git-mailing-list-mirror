From: Junio C Hamano <junkio@cox.net>
Subject: Package split: Debian.
Date: Sat, 05 Nov 2005 03:19:51 -0800
Message-ID: <7v7jbnpciw.fsf_-_@assigned-by-dhcp.cox.net>
References: <43652934.8000308@zytor.com>
	<7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
	<20051031064105.GV8041@shell0.pdx.osdl.net>
	<43663EEA.5050102@zytor.com> <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com>
	<7vpsplcr7l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 05 12:21:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYM6V-0008DD-9f
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 12:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbVKELTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 06:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVKELTx
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 06:19:53 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47808 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751466AbVKELTw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2005 06:19:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051105111925.LWEK9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Nov 2005 06:19:25 -0500
To: git@vger.kernel.org
In-Reply-To: <7vpsplcr7l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 31 Oct 2005 13:27:26 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11177>

This is still WIP (I forgot to split out tla and doc) but I'd
appreciate it if somebody can help me on the RPM side.  An RPM
novice without a test install environment like myself is pretty
much useless for the job X-<.

Not that I am a Debian expert, but at least I do have a chrooted
sarge partition that I can test install and trash.

-- >8 -- cut here -- >8 --

As discussed on the list, split the foreign SCM interoperability
packages from the git-core binary package.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile               |    4 ++--
 debian/changelog       |    7 +++++++
 debian/control         |   25 ++++++++++++++++++++++++-
 debian/git-cvs.files   |    2 ++
 debian/git-email.files |    2 ++
 debian/git-svn.files   |    2 ++
 debian/rules           |    5 ++++-
 7 files changed, 43 insertions(+), 4 deletions(-)
 create mode 100644 debian/git-cvs.files
 create mode 100644 debian/git-email.files
 create mode 100644 debian/git-svn.files

applies-to: 861aaf77ef8cff205f4d8721ce24f3c25d180ca8
0017ffa572ce837d0a73d69014a0f4820b2b80b5
diff --git a/Makefile b/Makefile
index 6064672..76d33b4 100644
--- a/Makefile
+++ b/Makefile
@@ -450,8 +450,8 @@ clean:
 	rm -f git-core.spec *.pyc *.pyo
 	rm -rf $(GIT_TARNAME)
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
-	rm -f git-core_$(GIT_VERSION)-*.deb git-core_$(GIT_VERSION)-*.dsc
-	rm -f git-tk_$(GIT_VERSION)-*.deb
+	rm -f git-core_$(GIT_VERSION)-*.dsc
+	rm -f git-*_$(GIT_VERSION)-*.deb
 	$(MAKE) -C Documentation/ clean
 	$(MAKE) -C templates clean
 	$(MAKE) -C t/ clean
diff --git a/debian/changelog b/debian/changelog
index 5fd31b7..17a4a24 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,10 @@
+git-core (0.99.9-1) unstable; urgency=low
+
+  * Split the git-core binary package into core and foreign SCM
+    interoperability modules.
+
+ -- Junio C Hamano <junkio@cox.net>  Sat, 29 Oct 2005 14:34:30 -0700
+
 git-core (0.99.9-0) unstable; urgency=low
 
   * GIT 0.99.9
diff --git a/debian/control b/debian/control
index 1f45f93..2c1d295 100644
--- a/debian/control
+++ b/debian/control
@@ -8,7 +8,7 @@ Standards-Version: 3.6.1
 Package: git-core
 Architecture: any
 Depends: ${shlibs:Depends}, ${perl:Depends}, ${misc:Depends}, rcs
-Recommends: rsync, curl, ssh, libmail-sendmail-perl, libemail-valid-perl, libsvn-core-perl (>= 1.2.1), python (>= 2.4.0), less
+Recommends: rsync, curl, ssh, python (>= 2.4.0), less
 Suggests: cogito, patch
 Conflicts: git, cogito (<< 0.13)
 Description: The git content addressable filesystem
@@ -24,3 +24,26 @@ Depends: ${shlibs:Depends}, ${misc:Depen
 Description: The git content addressable filesystem, GUI add-on
  This package contains 'gitk', the git revision tree visualizer.
 
+Package: git-svn
+Architecture: all
+Depends: ${shlibs:Depends}, ${misc:Depends}, ${perl:Depends}, git-core, libsvn-core-perl (>= 1.2.1)
+Suggests: subversion
+Description: The git content addressable filesystem, SVN interoperability
+ This package contains 'git-svnimport', to import development history from
+ SVN repositories.
+
+Package: git-cvs
+Architecture: all
+Depends: ${shlibs:Depends}, ${misc:Depends}, ${perl:Depends}, git-core
+Suggests: cvs
+Description: The git content addressable filesystem, CVS interoperability
+ This package contains 'git-cvsimport', to import development history from
+ CVS repositories.
+
+Package: git-email
+Architecture: all
+Depends: ${shlibs:Depends}, ${misc:Depends}, git-core, libmail-sendmail-perl, libemail-valid-perl
+Description: The git content addressable filesystem, e-mail add-on
+ This package contains 'git-send-email', to send a series of patch e-mails.
+
+
diff --git a/debian/git-cvs.files b/debian/git-cvs.files
new file mode 100644
index 0000000..8bf5090
--- /dev/null
+++ b/debian/git-cvs.files
@@ -0,0 +1,2 @@
+/usr/bin/git-cvsimport
+/usr/share/doc/git-core/git-cvsimport.*
diff --git a/debian/git-email.files b/debian/git-email.files
new file mode 100644
index 0000000..236754c
--- /dev/null
+++ b/debian/git-email.files
@@ -0,0 +1,2 @@
+/usr/bin/git-send-email
+/usr/share/doc/git-core/git-send-email.*
diff --git a/debian/git-svn.files b/debian/git-svn.files
new file mode 100644
index 0000000..317b12a
--- /dev/null
+++ b/debian/git-svn.files
@@ -0,0 +1,2 @@
+/usr/bin/git-svnimport
+/usr/share/doc/git-core/git-svnimport.*
diff --git a/debian/rules b/debian/rules
index 568d430..cf33cdf 100755
--- a/debian/rules
+++ b/debian/rules
@@ -41,7 +41,7 @@ MAN_DESTDIR := $(DESTDIR)/$(MANDIR)
 build: debian/build-stamp
 debian/build-stamp:
 	dh_testdir
-	$(MAKE) prefix=$(PREFIX) PYTHON_PATH=/usr/bin/python2.4 all doc test
+	$(MAKE) prefix=$(PREFIX) PYTHON_PATH=/usr/bin/python2.4 all test doc
 	touch debian/build-stamp
 
 debian-clean:
@@ -65,7 +65,10 @@ install: build
 	mkdir -p $(DOC_DESTDIR)
 	find $(DOC) '(' -name '*.txt' -o -name '*.html' ')' -exec install {} $(DOC_DESTDIR) ';'
 
+	dh_movefiles -p git-cvs
+	dh_movefiles -p git-svn
 	dh_movefiles -p git-tk
+	dh_movefiles -p git-email
 	dh_movefiles -p git-core
 	find debian/tmp -type d -o -print | sed -e 's/^/? /'
 
---
0.99.9.GIT
