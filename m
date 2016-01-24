From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 13/19] mingw: outsmart MSYS2's path substitution in t1508
Date: Sun, 24 Jan 2016 16:45:09 +0100 (CET)
Message-ID: <1a4477f951edc9f58a24163d3935a7b35a3f14b2.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Thomas Braun <thomas.braun@byte-physics.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:45:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMqt-0001LY-5D
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbcAXPpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:45:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:64793 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbcAXPpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:45:13 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LZynd-1ZgaK32FUz-00lkrx; Sun, 24 Jan 2016 16:45:10
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ADU9XjULfSlguYpu3pCfDGT8ZpZem5Z6xmOMQhNLPkuKIldkSWm
 PI2RTeCOCbojWSSEvJeypBvdMql6DNxTi8ezhfUL988rbOVPUh2L+x43utkMPKcvsN1DXWu
 O9wUPCdIHg7GfXA+S9WWymREHnRc1Ic8DzrDiQ1TgCYngFi9qoKdWlJK2iXBQeZcTxu3lL9
 XjVzyNnWuIf+894nJmMIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pBfFsN8gLuI=:25HYyfIbXstRRBI0qWwvF/
 P0TwWJS0kCjd6YeTS84IZ1iCbvDiZYgiU8oiWr7rpYDprs7WvoQEqiXaObMQXwgZfwoPt/kJr
 OcWvLortS9AJqwlrEOUlTZmzlt2H2NQCDFKfmEXwq3Q/cm/IN1g7KEtEjWWMVdCINEZIG/n3+
 DCk6Mx39Wu5mC03T4iV8YwftlTlosbhqf3WPAtgLeN1AjLUhhIgFVQrv3ORp9eLx8Y13VJ14n
 aWr3z6s6pCPBVXDDd0rYq3E5GNviLWqX/aKTfDTD+51GD7VPS6mq7Xzm7THUSBNJKZosCqxm/
 R4kbhcq/BrSTgDScUTPtO0wnnPC5L8G7+QO4NAoExwcTI8t93RKm1ZhOVj3GJ+KYenFKUMnW+
 oVM7dW85gxOiln4iBsfVo+QLbPB32kj68dJt4Yov6VG4DJEwnWm3qtyQz1nZplPyD1A8ZgA0Z
 Z+m2v/CqWb1CsDRMBYQwHr/6NUgJMvhXt7Q9Af6FxgsLbyMpvN1GInUZ9NDmbxeWuJxmYo3SE
 ckzyDTKbaWBG1td0fnjbGdo8V4B/+1gEnQcOsRb9HpGhszCZOHeowbXu03c10p2d1TvzeE1uO
 w4fjD+SXiyLlSFcx5qmDeb58+685c1R/x+TZfSaIz4NzYijM7s2EHv4Ha/8/XhEJbUoEVdIxM
 oExGj3WdiMD1Jpcerb1f3pCj6KSmutvgBy7mpY9kzRYRf0Ro/hgfb6hKRqknm2L8CUGZQmhKi
 088G1dlbN0TA1SgU559oSdLJ9phPhKzqh9Lqm2U0qlRVstXzSbSuPTnLAUtJVAR0UVq8HwPv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284677>

From: Thomas Braun <thomas.braun@byte-physics.de>

A string of the form "@/abcd" is considered a file path
by the msys layer and therefore translated to a Windows path.

Here the trick is to double the slashes.

The MSYS2 patch translation can be studied by calling

	test-path-utils print_path <path>

Signed-off-by: Thomas Braun <thomas.braun@byte-physics.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1508-at-combinations.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 078e119..1d9fd7b 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -29,13 +29,22 @@ fail() {
 	"$@" failure
 }
 
+if test_have_prereq MINGW
+then
+	# MSYS2 interprets `@/abc` to be a file list, and wants to substitute
+	# the Unix-y path with a Windows one (e.g. @C:\msys64\abc)
+	AT_SLASH=@//at-test
+else
+	AT_SLASH=@/at-test
+fi
+
 test_expect_success 'setup' '
 	test_commit master-one &&
 	test_commit master-two &&
 	git checkout -b upstream-branch &&
 	test_commit upstream-one &&
 	test_commit upstream-two &&
-	git checkout -b @/at-test &&
+	git checkout -b $AT_SLASH &&
 	git checkout -b @@/at-test &&
 	git checkout -b @at-test &&
 	git checkout -b old-branch &&
@@ -64,7 +73,7 @@ check "@{-1}@{u}@{1}" commit master-one
 check "@" commit new-two
 check "@@{u}" ref refs/heads/upstream-branch
 check "@@/at-test" ref refs/heads/@@/at-test
-check "@/at-test" ref refs/heads/@/at-test
+check "$AT_SLASH" ref refs/heads/@/at-test
 check "@at-test" ref refs/heads/@at-test
 nonsense "@{u}@{-1}"
 nonsense "@{0}@{0}"
-- 
2.7.0.windows.1.7.g55a05c8
