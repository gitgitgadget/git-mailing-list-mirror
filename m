From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] git-gui: fix detection of Cygwin
Date: Fri, 30 Oct 2015 20:09:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510302009510.31610@s15462909.onlinehome-server.info>
References: <cover.1443619795.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Fri Oct 30 20:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsF43-0005V2-DL
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760476AbbJ3TKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:10:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:55554 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760163AbbJ3TKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:10:08 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LnxVE-1aP7yX36Ai-00fyHt;
 Fri, 30 Oct 2015 20:09:57 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1443619795.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:yUgzs0E9zHISCOXfy7D+dyeAXTyS0bG7QFRw17EwdQ7TP+yyhUA
 MKoResd2lC52QYojijhiD146fWyH1zOm/4S5YjRABwpw6ydexhNwoNR97e0G+lwRX0fOw9L
 omSpeSTrg8e+3EMaXXEyeOgm+z+7zmpD6JNDHce/EnndKzbpDl9nYeptHMywJDFJanO4IZv
 slFFjV9tpiNf9VjQ2/QGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qCENGlgj5xI=:bRNkJOnr9cuMUr1tP0eB+9
 xAwetbAXIyu2YpX8VKsm27EXmr2zCWp1rI7B+y90QDh34iL0TzbEYtfb0EFHd/aL4yca1whx9
 Wg8vuDUwZjxQyXqjWuX6iLZ4Y8KTLyA0/hlNWzxLbkn4VrG53nkHuwMY++0xiifgvk4eNbxhg
 n17tt+aYdf25frR6+PTDELxdu2lUl9CfiyqtobhI6iDFrS7wVwZgfWEhY2khWWeBOKmrhDctu
 gJLW/w69VN5//+kL96pPd3hmNvesc3cxeBVpniUY0xHbITXqQdzoBBiNzFS+2iuWBoaeXo/Ki
 9z8N8sHKVjLho3cmajqIwjvIy9Xli9AzEyX6A8TJlBmyQ26baCXPCwF9ARpQIAKuJsWleoqZU
 Jye+tD6+ByZok6QYNEUNhs6CHZIaMAwXILtd0uLO7Wb1G7+sLDgdHWjVKpv7WD1i2gUpHD5T9
 7YpmXm3/9Wbdyb+V8tikpbMcSYFnKvwTye71Rt2E2yNAQTzcedxN7K7bhBKuv4OKnf+vs8ohB
 9voAqYQ0y99xrF7PrdKLBT10eEnjTtPuuYIVHcQsu86xUgyHfDBNrBtaPnbkmya1aDwnRiEZD
 ClY2P8rWCd1yd+wVk3yYxo07YvQU1Jg5LJwkQSfvEETbBae3W0YehYIWYRp/VdF4VRUl39iFh
 tM4kNO9B+2kUlzIguwpSPm3SHdvGLJUHSJHDdjcRgpz2bY0cyBu7a6zMKEvfy55m6tvsCHnrN
 0As1AZiqsFl0oFsouKz+G7TdJ+9tA343U1bq7FHJ4Mqn1M53u7ruxK3JaJ0W70qQ/E6Zasv0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280525>

MSys2 might *look* like Cygwin, but it is *not* Cygwin... Unless it
is run with `MSYSTEM=MSYS`, that is.

This change is backwards-compatible because MSys also used the
MSYSTEM variable to determine whether to run in MSys or in MinGW
mode. The only difference is that MSys does not support running
in 64-bit mode at all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 11048c7..9038a4c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -270,12 +270,10 @@ proc is_Windows {} {
 proc is_Cygwin {} {
 	global _iscygwin
 	if {$_iscygwin eq {}} {
-		if {$::tcl_platform(platform) eq {windows}} {
-			if {[catch {set p [exec cygpath --windir]} err]} {
-				set _iscygwin 0
-			} else {
-				set _iscygwin 1
-			}
+		if {$::tcl_platform(platform) eq {windows} &&
+				(![info exists ::env(MSYSTEM)] ||
+				 $::env(MSYSTEM) ne {MSYS})} {
+			set _iscygwin 1
 		} else {
 			set _iscygwin 0
 		}
-- 
2.5.3.windows.1.3.gc322723
