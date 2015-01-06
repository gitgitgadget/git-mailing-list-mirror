From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] git-gui.sh: support Tcl 8.4
Date: Tue,  6 Jan 2015 02:41:21 -0800
Message-ID: <97e448e7908a1f959a7294e389553b5@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 06 11:43:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8RZs-0006zU-JY
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 11:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbbAFKl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 05:41:28 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:59850 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbbAFKl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 05:41:27 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so30656033pab.14
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 02:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rQFCYXk0K9BsMsCUCvgaJrMVRxHnhUerp2Ol1YqGzVI=;
        b=1Fz8v2XKmmUxW2I+k83LJ+8Gp5KIKmUj0sDh8CVlZSlAhAoWgMQSlkMCD6cv6UdUbT
         ctaatiHPwYxrEcBtbfrjQfBxD1MRfVUwOBiDs68wSH6/IbPpn2NscYpeylKrAGLp177h
         KWCZ22ph9MYb28YJoMB3YOIaS0RavFcKYtVTq5MUMaGq0qvhxgTUKXsI4QHnsBl8jrX9
         GLfefhnArh+h8OYS/HTvkgpjaphpL5b03+DMfAyWaMBvg2/Aq5SYST9qQqsTyKZ9ujx9
         ip6hrTQwYay5ICn5YGAL9nUn/x7pYQ44+QkEAio/5XphLsKJ+yqgGf2iJowqHzs2t1Mb
         gg3g==
X-Received: by 10.70.46.137 with SMTP id v9mr106505602pdm.70.1420540887140;
        Tue, 06 Jan 2015 02:41:27 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ul5sm57041482pab.36.2015.01.06.02.41.26
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 02:41:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262055>

Tcl 8.5 introduced an extended vsatisfies syntax that is not
supported by Tcl 8.4.

Since only Tcl 8.4 is required this presents a problem.

The extended syntax was used starting with Git 2.0.0 in
commit b3f0c5c0 so that a major version change would still
satisfy the condition.

However, what we really want is just a basic version compare,
so use vcompare instead to restore compatibility with Tcl 8.4.

Signed-off-by: Kyle J. McKay
---
 git-gui/git-gui.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index b186329d..a1a23b56 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1283,7 +1283,7 @@ load_config 0
 apply_config
 
 # v1.7.0 introduced --show-toplevel to return the canonical work-tree
-if {[package vsatisfies $_git_version 1.7.0-]} {
+if {[package vcompare $_git_version 1.7.0] >= 0} {
 	if { [is_Cygwin] } {
 		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
 	} else {
@@ -1539,7 +1539,7 @@ proc rescan_stage2 {fd after} {
 		close $fd
 	}
 
-	if {[package vsatisfies $::_git_version 1.6.3-]} {
+	if {[package vcompare $::_git_version 1.6.3] >= 0} {
 		set ls_others [list --exclude-standard]
 	} else {
 		set ls_others [list --exclude-per-directory=.gitignore]
-- 
2.1.4
