From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI)] git-gui: Add the Show SSH Key item to the clone dialog.
Date: Sun, 9 Nov 2008 18:51:16 +0300
Organization: HOME
Message-ID: <200811091851.16208.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 16:54:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzCcZ-0001Mb-Pe
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 16:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbYKIPxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 10:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbYKIPxS
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 10:53:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:7522 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbYKIPxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 10:53:18 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1880947fgg.17
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 07:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hxCWV54PbQKSr4u6YBFBMEpGzpAAn90tpv1wgr3j2vw=;
        b=HW7WxvjoKetXNw2gGrcmCOardAx9PP+JsvDqH8Tmu+tS+uw1A2BayWj1SSG/j9EVXD
         P6HtDZZ1E98+XUVyyaIY42ChxmAR5qUQ5WPpn7EkfYriHL5wOeNvo9IekIDWtCp6mEvv
         7dp5i4LrbZdbofZ4g3IbqzPxpJT57/LzgsHlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=NW7WrcJaEh+UMVcqtwBOi9ETlqPvG9abRGHGAkJGsVQ3VrsvzYanWY1iRfCKmpJbUn
         9Zm4OWwoAiS3TVzWRWXd2rkMSD4R55RTmBsnzKpxEFCSecUkA9Kjp+5dej4nG5e5/6uu
         n0okWZyHJmB9bwHEMyXwMyivQl9NIAXMMPMow=
Received: by 10.187.210.3 with SMTP id m3mr1352125faq.59.1226245996139;
        Sun, 09 Nov 2008 07:53:16 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id d13sm8618997fka.19.2008.11.09.07.53.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 07:53:15 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100452>

The user might need to see the key before cloning a repository.
This patch makes the relevant menu item available in the Select
Repository/Clone dialog.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh                |   20 +++++++++++---------
 lib/choose_repository.tcl |    6 ++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 12b496b..cf9ef6e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -999,6 +999,17 @@ citool {
 
 ######################################################################
 ##
+## execution environment
+
+set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
+
+# Suggest our implementation of askpass, if none is set
+if {![info exists env(SSH_ASKPASS)]} {
+	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
+}
+
+######################################################################
+##
 ## repository setup
 
 set picked 0
@@ -1073,15 +1084,6 @@ set selected_commit_type new
 set nullid "0000000000000000000000000000000000000000"
 set nullid2 "0000000000000000000000000000000000000001"
 
-set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
-
-######################################################################
-
-# Suggest our implementation of askpass, if none is set
-if {![info exists env(SSH_ASKPASS)]} {
-	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
-}
-
 ######################################################################
 ##
 ## task management
diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 9091316..f9ff62a 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -43,12 +43,18 @@ constructor pick {} {
 			$w.mbar.apple add command \
 				-label [mc "About %s" [appname]] \
 				-command do_about
+			$w.mbar.apple add command \
+				-label [mc "Show SSH Key"] \
+				-command do_ssh_key
 		} else {
 			$w.mbar add cascade -label [mc Help] -menu $w.mbar.help
 			menu $w.mbar.help
 			$w.mbar.help add command \
 				-label [mc "About %s" [appname]] \
 				-command do_about
+			$w.mbar.help add command \
+				-label [mc "Show SSH Key"] \
+				-command do_ssh_key
 		}
 
 		wm protocol $top WM_DELETE_WINDOW exit
-- 
1.6.0.3.15.gb8d36
