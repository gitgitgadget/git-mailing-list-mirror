From: Ronny Borchert <rborchert@live.de>
Subject: change to allow cross compile ARM and =?utf-8?b?TUlQU+KAjw==?=
Date: Fri, 4 Dec 2015 22:47:54 +0000 (UTC)
Message-ID: <loom.20151204T234603-742@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 23:48:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4z96-0007VK-Ev
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 23:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbbLDWsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 17:48:04 -0500
Received: from plane.gmane.org ([80.91.229.3]:48167 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbbLDWsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 17:48:03 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1a4z8y-0007Iq-Kg
	for git@vger.kernel.org; Fri, 04 Dec 2015 23:48:00 +0100
Received: from p4FD738BC.dip0.t-ipconnect.de ([79.215.56.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 23:48:00 +0100
Received: from rborchert by p4FD738BC.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 23:48:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.215.56.188 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282015>

I have add an description into INSTALL, that other user have direct an
indicator.

diff --git a/INSTALL b/INSTALL
index ffb071e..5918182 100644
--- a/INSTALL
+++ b/INSTALL
@@ -2,13 +2,13 @@
         Git installation
 
 Normally you can just do "make" followed by "make install", and that
-will install the git programs in your own ~/bin/ directory.  If you want
+will install the git programs in your own ~/bin/ directory. If you want
 to do a global install, you can do
 
     $ make prefix=/usr all doc info ;# as yourself
     # make prefix=/usr install install-doc install-html install-info ;# as root
 
-(or prefix=/usr/local, of course).  Just like any program suite
+(or prefix=/usr/local, of course). Just like any program suite
 that uses $prefix, the built results have some paths encoded,
 which are derived from $prefix, so "make all; make prefix=/usr
 install" would not work.
@@ -25,6 +25,31 @@ set up install paths (via config.mak.autogen), so you can
write instead
     $ make all doc ;# as yourself
     # make install install-doc install-html;# as root
 
+If you want to create a cross build of git, i.e. ARM or MIPS, you
+need to add addtional arguments to configure,
+i.e. for MIPS little endian
+
+        $ ./configure --build=x86_64-linux \
+                      --host=mipsel-oe-linux \
+                      --cache-file=config.cache
+
+i.e. for ARM
+
+        $ ./configure --build=x86_64-linux \
+                      --host=arm-eabi \
+                      --cache-file=config.cache
+
+To make this now work you need to create a config.cache file next to
+the configure. In this file you have to configure architecture
+specific behavior, example content could be
+
+ac_cv_snprintf_returns_bogus=${ac_cv_snprintf_returns_bogus=no}
+ac_cv_fread_reads_directories=${ac_cv_fread_reads_directories=no}
+
+For details about the meaning refer to the source code of the tests
+in the configure.ac by search of the ac_cv_...
+Important is that you assign 'no' or 'yes'.
+
