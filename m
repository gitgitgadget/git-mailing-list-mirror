From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] more Debian packaging fixes
Date: Sat, 13 Aug 2005 02:38:15 +0200
Message-ID: <20050813003814.GN5411@kiste.smurf.noris.de>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net> <pan.2005.08.10.21.15.41.143251@smurf.noris.de> <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <7vd5olqtvp.fsf@assigned-by-dhcp.cox.net> <20050810235436.GW28270@kiste.smurf.noris.de> <7vpssiucss.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 02:40:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3k3u-0003EI-Px
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 02:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVHMAjo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 20:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVHMAjn
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 20:39:43 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:40425 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1751314AbVHMAjn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 20:39:43 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1E3k2S-0002VQ-AY; Sat, 13 Aug 2005 02:38:38 +0200
Received: (nullmailer pid 10998 invoked by uid 501);
	Sat, 13 Aug 2005 00:38:15 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpssiucss.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-tk should be architecture independent.
git-core forgot to depend on perl.

Signed-Off-By: Matthias Urlichs <smurf@debian.org>
---
Hi,

Junio C Hamano:
> Matthias Urlichs <smurf@smurf.noris.de> writes:
> 
> > - Split gitk off to its own package;
> >   it needs tk installed, but nothing else does.
> 
> I just noticed from "dpkg --info" output that the generated
> git-tk has "Architecture: i386".  Shouldn't it read "all" and
> resulting package also named git-tk_${VERSION}_all.deb, instead
> of whatever architecture I happened to build it?
> 
True.


diff --git a/debian/changelog b/debian/changelog
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,6 +1,7 @@
 git-core (0.99.5-0) unstable; urgency=low
 
   * Split off gitk.
+    - ... into an architecture-independent package.
 
  -- Matthias Urlichs <smurf@debian.org>  Thu, 11 Aug 2005 01:43:24 +0200
 
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -7,7 +7,7 @@ Standards-Version: 3.6.1
 
 Package: git-core
 Architecture: any
-Depends: ${shlibs:Depends}, ${misc:Depends}, patch, diff, rcs
+Depends: ${perl:Depends}, ${shlibs:Depends}, ${misc:Depends}, patch, diff, rcs
 Recommends: rsync, curl, ssh, libmail-sendmail-perl, libemail-valid-perl
 Conflicts: git
 Description: The git content addressable filesystem
@@ -18,7 +18,7 @@ Description: The git content addressable
  similar to other SCM tools.
 
 Package: git-tk
-Architecture: any
+Architecture: all
 Depends: ${shlibs:Depends}, ${misc:Depends}, git-core, tk8.4
 Description: The git content addressable filesystem, GUI add-on
  This package contains 'gitk', the git revision tree visualizer
diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -65,33 +65,36 @@ install: build
 	dh_movefiles -p git-core
 	find debian/tmp -type d -o -print | sed -e 's/^/? /'
 
-binary: build install
+binary-arch: build install
 	dh_testdir
 	dh_testroot
-	dh_installchangelogs
-	dh_installdocs
-	dh_installexamples
-#	dh_installmenu
-#	dh_installdebconf	
-#	dh_installlogrotate	
-#	dh_installemacsen
-#	dh_installpam
-#	dh_installmime
-#	dh_installinit
-#	dh_installcron
-#	dh_installinfo
-	dh_installman
-	dh_link
-	dh_strip
-	dh_compress 
-	dh_fixperms
-#	dh_perl
-#	dh_python
-	dh_makeshlibs
-	dh_installdeb
-	dh_shlibdeps
-	dh_gencontrol
-	dh_md5sums
-	dh_builddeb
+	dh_installchangelogs -a
+	dh_installdocs -a
+	dh_strip -a
+	dh_compress  -a
+	dh_fixperms -a
+	dh_perl -a
+	dh_makeshlibs -a
+	dh_installdeb -a
+	dh_shlibdeps -a
+	dh_gencontrol -a
+	dh_md5sums -a
+	dh_builddeb -a
+
+binary-indep: build install
+	dh_testdir
+	dh_testroot
+	dh_installchangelogs -i
+	dh_installdocs -i
+	dh_compress  -i
+	dh_fixperms -i
+	dh_makeshlibs -i
+	dh_installdeb -i
+	dh_shlibdeps -i
+	dh_gencontrol -i
+	dh_md5sums -i
+	dh_builddeb -i
+
+binary: binary-arch binary-indep
 
 .PHONY: build clean binary install clean debian-clean
-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
GUBBISH [a portmanteau of "garbage" and "rubbish"?] n. Garbage; crap;
   nonsense.  "What is all this gubbish?"
				-- From the AI Hackers' Dictionary
