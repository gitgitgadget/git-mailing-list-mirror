From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/5] config.mak.uname: supporting 64-bit MSys2
Date: Thu, 14 Jan 2016 17:51:49 +0100 (CET)
Message-ID: <a54e0357d8f274c7ffa49daa2c91ba371fa501ab.1452790142.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de> <cover.1452790142.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:52:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJl7x-0004yz-6v
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbcANQv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:51:57 -0500
Received: from mout.gmx.net ([212.227.15.18]:59904 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbcANQv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:51:56 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LrvWY-1aBLi51dcc-013ifW; Thu, 14 Jan 2016 17:51:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452790142.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gJgv/JVmr79dQEjzxeXwEMGHSOSTbS2gdK2nTw7qrC0oHLsKQ+s
 xJXr02WshAxywg++baDah55JXcIveJROyMP159xyWqLpeschjVfThBL+p/aY+byo84p6BBY
 9AINLUBSyZbHx++xsPomEZNWavCzCGq3oro9rJVQLu1ik79bpDm16G3qhlta7QrjD2vV10j
 fFTSlB7nufFBr32m4tQbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FlGBatMPJik=:lIJ9xXXMNbgvovGJrj1TPz
 F1uXoidc2s9EBNoZ0juPoaT7G/HDrhTrJZQ4rpajoXdWhHx0Qe5vbkl/mkjO6lkTdo0B0rL9w
 CLaZevumY8psGl8h18xsGsjXW6/xTUVwpFB2Ah/fOV4B62RMwHkIErRiGnG7vxAYZiV4ylyQ9
 FZ8dzSOiy+rWCrWFWelqr7HFyheJ4S/jWFUOz0jqQpVTp7F+Vem4HQmkxTJUukN1O+QYwu9nB
 LF/sxiExdEqE6S/n7J28Ze251rueUZrIWQ4oyYKFikQmsZnS08vlNqjKWUzgyyTtOLFpl2m4I
 6EWHKg6YFXMbH6dM8fHwyzTdjxFdeuz0DpHEq9KJiGNASJ+mBi3gK223S/kN8ZU8RW2GVu/lC
 YBOTt+u4SMOZGqYNN4xiEoGanECz8SB9jIxdy+zuzFZZxjHo0yH22/T83OaBX5EsFNPuqfnyk
 MTXUmYn6t+n6CrjEHOvSOdNWYguwoPrukpfUJtaVu11J7ZrC1x9US6z+VfJ/A6uJmqZ9OO1IV
 v59NY5Bb+poMfK5G22dGq2w6XxtRbqzeNxunHXZEtwsQeEAtWjhu8VkH7yF2XmHihfBjOsr55
 vLEe/ptFhyVjqJkq3EmMcIxzW/cpX+hSn7zvNz5K191T70HlSxnyN5FDMGp3c4p2dnASOJFBG
 RbvBsU5vCZbqgkgqSN7sOv03jnQ6O+Q8sDZUhRYKKYxCHq3sN9YXXVi+BkQ4LYH+h3nWkZyXR
 1LF0Qm7RJpxb6EKbb76Io1rH30f2Ole/rEmdMth03UH7jJzc8cTlf0qaCIhXWWc4JqY1o6Lj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284062>

This just makes things compile, the test suite needs extra tender loving
care in addition to this change. We will address these issues in later
commits.

While at it, also allow building MSys2 Git (i.e. a Git that uses MSys2's
POSIX emulation layer).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index b0592c1..4b2e1b8 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -518,13 +518,12 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
-	COMPAT_CFLAGS += -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
 	BASIC_CFLAGS += -DPROTECT_NTFS_DEFAULT=1
-	BASIC_LDFLAGS += -Wl,--large-address-aware
 	EXTLIBS += -lws2_32
 	GITLIBS += git.res
 	PTHREAD_LIBS =
@@ -545,8 +544,17 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 else
 	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
 		# MSys2
+		prefix = /usr/
+		ifeq (MINGW32,$(MSYSTEM))
+			prefix = /mingw32
+		endif
+		ifeq (MINGW64,$(MSYSTEM))
+			prefix = /mingw64
+		else
+			COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
+			BASIC_LDFLAGS += -Wl,--large-address-aware
+		endif
 		CC = gcc
-		prefix = /mingw32
 		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0
 		INSTALL = /bin/install
 		NO_R_TO_GCC_LINKER = YesPlease
-- 
2.7.0.windows.1.7.g55a05c8
