From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 3/3] git-gui (Windows): Change wrapper to execdir 'libexec/git-core'
Date: Sun, 27 Jul 2008 18:49:43 +0200
Message-ID: <1217177383-25272-4-git-send-email-prohaska@zib.de>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de>
 <1217177383-25272-2-git-send-email-prohaska@zib.de>
 <1217177383-25272-3-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 18:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN9TB-0003zM-KB
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 18:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434AbYG0Qu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 12:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757127AbYG0Qu0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 12:50:26 -0400
Received: from mailer.zib.de ([130.73.108.11]:37024 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909AbYG0QuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 12:50:23 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6RGniOA022151;
	Sun, 27 Jul 2008 18:49:53 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6RGnhW3014519;
	Sun, 27 Jul 2008 18:49:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1217177383-25272-3-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90345>

git-gui needs bindir in PATH to be able to run 'git'.  bindir
however is not necessarily in PATH if started directly through a
Windows shortcut.  Therefore, we used to add the directory
git-gui is located in.  But with the new 'libexec/git-core'
layout this directory is no longer identical to bindir.

This commit modifies the wrapper script to discover the bindir
and add it to PATH.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-gui/windows/git-gui.sh |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-gui/windows/git-gui.sh b/git-gui/windows/git-gui.sh
index 98f32c0..53c3a94 100644
--- a/git-gui/windows/git-gui.sh
+++ b/git-gui/windows/git-gui.sh
@@ -8,9 +8,12 @@ if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
 	incr argc -2
 }
 
-set gitguidir [file dirname [info script]]
-regsub -all ";" $gitguidir "\\;" gitguidir
-set env(PATH) "$gitguidir;$env(PATH)"
-unset gitguidir
+set bindir [file dirname \
+            [file dirname \
+             [file dirname [info script]]]]
+set bindir [file join $bindir bin]
+regsub -all ";" $bindir "\\;" bindir
+set env(PATH) "$bindir;$env(PATH)"
+unset bindir
 
 source [file join [file dirname [info script]] git-gui.tcl]
-- 
1.6.0.rc0.79.gb0320
