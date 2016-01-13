From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/5] config.mak.uname: supporting 64-bit MSys2
Date: Wed, 13 Jan 2016 14:31:01 +0100 (CET)
Message-ID: <a54e0357d8f274c7ffa49daa2c91ba371fa501ab.1452691805.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:32:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJLWt-0002tj-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 14:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760610AbcAMNbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 08:31:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:59264 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756487AbcAMNbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 08:31:05 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LikyX-1Zlfit2AIP-00cwSX; Wed, 13 Jan 2016 14:31:02
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452691805.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9GjZ/qqntKaXUVI9HXMFTzmVt3pL7Dw75o6Dwln5WHGMfbrSTwW
 AoqXsuehwjGWVanMdGiKeQjv0nUAcm/JHN13f9OluRzFf+7T4qkOC8BK44Y3OGcGJRCg0dd
 Ic7Gq/7RzE85+0/iP7xdVYEJSNHh4ykwHexA6B1PlVLvmX9bFGZqTJjAJvSTx4Q4p6tLf2e
 BhFO+P2ADwDFR9+P5/xSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gv3Tdo0aGqA=:e7XJHrqE7uVf/FD0Y4bViu
 wP9Tw3drfglaf/iReACpa5/pPNgAS1S3eOsA11zIAAU+wnVXOxXCEz512y1U5uZigL/wfnw00
 ooy3F2T2F3gDKZUv4bw+30zaVYcYiDETLoyEnS8I9V7Q8K9fz7wf+P/ULg0w4glfoDTjujTb1
 DYC6UbU+l6rRfUGajJqOZgEZEHO/Yb3pfBm5ZRRLyrYEyhJLFhFHKaVsKBRnwcUakpJH/KGzf
 LkKN2H+qzmqO+CcA0IvXAod2D64RYWamAzPVn9EceRt7IqQ/liwnKmz82yE4uky+6f48cXSwT
 U2R5a01IsmR38txKZUL+jC9ELkTH/xwTIqrYrM7tu6LgHqOTZJ6X4jLNTimwn5sF7FpVudPzC
 zbzmYze0bLPowXeKopx10JUmGF2VPIENW9xrLFB9hHEEw77K0eV1U37bpV4giz0P/EiiwO0zF
 3jRHjycGrgZFXQdLrebQzg2JCkMg9O3JQ8yoYIg2XEdPXDfu+Pt7sIcWABdJoy2MN0xz7Y+Ac
 TvLm65Skp1J+xzchrJTcBO1cfyCGTV7D+9Uf2fT39RIGuq2wizsobRSC192jIhvfDdjVu7UUH
 AZ4wZidkvfKzgO9bLRs7mheOCk5+WBpCNpOlnI2upWIDIsbjL/tUfloVsyK7BYIc54NH1Fn2A
 wkjPm3KYlsArCZW0Aq5MK9oLUMkRB78TUHyoMr2mlUwrA0A4XU1208I8RwHL2FPDNFIL1lLnA
 f2vOczY2WyNeGnh7kZAZw2r2mfi4lhydOSnZr8H07Q37CV+ZRpmRgNYtjtth0K1ho0LILPHR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283919>

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
2.6.3.windows.1.300.g1c25e49
