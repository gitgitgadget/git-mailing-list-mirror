From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] Debian: build-depend on "bc", conflict with "git-scm"
Date: Fri, 16 Sep 2005 13:54:10 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.16.11.54.07.595747@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 16 13:59:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGEqJ-0000UV-6C
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 13:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbVIPL5U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 07:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVIPL5U
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 07:57:20 -0400
Received: from main.gmane.org ([80.91.229.2]:230 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932650AbVIPL5T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 07:57:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EGEoi-00005L-R3
	for git@vger.kernel.org; Fri, 16 Sep 2005 13:55:44 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 13:55:44 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 13:55:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8679>

Build systems should run tests. This patch adds the necessary
debian/control and debian/rules bits ("bc" was missing,
t/t4002-diff-basic.sh wants it).

It also makes the new Debian package conflict with the "git-scm" package
that somebody else seems to have built independently.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
--- 

diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -41,7 +44,7 @@ MAN_DESTDIR := $(DESTDIR)/$(MANDIR)
 build: debian/build-stamp
 debian/build-stamp:
 	dh_testdir
-	$(MAKE) prefix=$(PREFIX) PYTHON_PATH=/usr/bin/python2.4 all doc
+	$(MAKE) prefix=$(PREFIX) PYTHON_PATH=/usr/bin/python2.4 all doc test
 	touch debian/build-stamp
 
 debian-clean:
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -2,7 +2,7 @@ Source: git-core
 Section: devel
 Priority: optional
 Maintainer: Junio C Hamano <junkio@cox.net>
-Build-Depends-Indep: libz-dev, libssl-dev, libcurl3-dev, asciidoc (>= 6.0.3), xmlto, debhelper (>= 4.0.0)
+Build-Depends-Indep: libz-dev, libssl-dev, libcurl3-dev, asciidoc (>= 6.0.3), xmlto, debhelper (>= 4.0.0), bc
 Standards-Version: 3.6.1
 
 Package: git-core
@@ -10,7 +10,8 @@ Architecture: any
 Depends: ${shlibs:Depends}, ${perl:Depends}, ${misc:Depends}, patch, rcs
 Recommends: rsync, curl, ssh, libmail-sendmail-perl, libemail-valid-perl, python (>= 2.4.0), less
 Suggests: cogito
-Conflicts: git, cogito (<< 0.13)
+Conflicts: git, cogito (<< 0.13), git-scm
+Replaces: git-scm
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
  and flexible filesystem-based database designed to store directory trees

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"You and I as individuals can, by borrowing, live beyond our means, but
only for a limited period of time.  Why should we think that collectively,
as a nation, we are not bound by that same limitation?"
-- Ronald Reagan
