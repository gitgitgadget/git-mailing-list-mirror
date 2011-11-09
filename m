From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] gitk: use "gitk: repo-top-level-dir" as window title
Date: Wed,  9 Nov 2011 17:28:28 +0100
Message-ID: <1320856108-25233-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, Doug Maxey <dwm@enoyolf.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 09 17:53:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROBOZ-0003VR-Ds
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 17:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518Ab1KIQw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Nov 2011 11:52:56 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:40020 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab1KIQwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 11:52:55 -0500
X-Greylist: delayed 1452 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Nov 2011 11:52:55 EST
Received: from 86-85-n1.aster.pl ([85.222.86.85] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1ROB0x-0002c8-CB; Wed, 09 Nov 2011 17:28:39 +0100
X-Mailer: git-send-email 1.7.8.rc0.251.gccd63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185161>

Previously, when run in a subdirectory, gitk would show the name
of this subdirectory as title, which was misleading. When run with
GIT_DIR set, it would show the cwd, which is even more misleading.

In case of non-bare repos, the .git suffix in the path is skipped.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 gitk-git/gitk |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..2eaf901 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -18,6 +18,14 @@ proc gitdir {} {
     }
 }
=20
+proc reponame {} {
+    set n [file normalize [gitdir]]
+    if {[string match "*/.git" $n]} {
+	set n [string range $n 0 end-5]
+    }
+    return [file tail $n]
+}
+
 # A simple scheduler for compute-intensive stuff.
 # The aim is to make sure that event handlers for GUI actions can
 # run at least every 50-100 ms.  Unfortunately fileevent handlers are
@@ -11592,6 +11600,8 @@ if {[package vcompare $git_version "1.6.6.2"] >=
=3D 0} {
     set show_notes "--show-notes"
 }
=20
+set appname "gitk"
+
 set runq {}
 set history {}
 set historyindex 0
@@ -11656,7 +11666,7 @@ catch {
 }
 # wait for the window to become visible
 tkwait visibility .
-wm title . "[file tail $argv0]: [file tail [pwd]]"
+wm title . "$appname: [reponame]"
 update
 readrefs
=20
--=20
1.7.8.rc0.251.gccd63
