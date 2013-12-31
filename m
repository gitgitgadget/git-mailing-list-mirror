From: Benny Siegert <bsiegert@herc.mirbsd.org>
Subject: [PATCH] Add MirBSD support to the build system.
Date: Tue, 31 Dec 2013 14:36:45 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1312311431300.24632@herc.mirbsd.org>
Reply-To: bsiegert@gmail.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 31 16:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vy0yR-0004QT-Dk
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 16:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab3LaPKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 10:10:50 -0500
Received: from eurynome.mirbsd.org ([81.169.181.30]:23149 "EHLO
	eurynome.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab3LaPKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Dec 2013 10:10:49 -0500
X-Greylist: delayed 1956 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Dec 2013 10:10:47 EST
Received: from herc.mirbsd.org (root@herc.mirbsd.org [IPv6:2a01:198:25d:0:202:b3ff:feb7:54e8])
	by eurynome.mirbsd.org (8.14.5.Beta0/8.14.3) with ESMTP id rBVEc3NW003416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Tue, 31 Dec 2013 14:38:09 GMT
Received: from herc.mirbsd.org (bsiegert@localhost [IPv6:::1])
	by herc.mirbsd.org (8.14.5/8.14.5) with ESMTP id rBVEakYY028820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 31 Dec 2013 14:36:51 GMT
Received: from localhost (bsiegert@localhost)
	by herc.mirbsd.org (8.14.5/8.14.5/Submit) with ESMTP id rBVEakSn012536
	for <git@vger.kernel.org>; Tue, 31 Dec 2013 14:36:46 GMT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239840>

Add an entry into the table of supported OSes. Do not set _XOPEN_SOURCE
(contrary to OpenBSD) because that disables the u_short and u_long
typedefs, which are used unconditionally in various other header files.

Signed-off-by: Benny Siegert <bsiegert@gmail.com>
---
 config.mak.uname  | 7 +++++++
 git-compat-util.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 82d549e..7d31fad 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -198,6 +198,13 @@ ifeq ($(uname_S),OpenBSD)
 	BASIC_LDFLAGS += -L/usr/local/lib
 	HAVE_PATHS_H = YesPlease
 endif
+ifeq ($(uname_S),MirBSD)
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+	USE_ST_TIMESPEC = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	HAVE_PATHS_H = YesPlease
+endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
 		NEEDS_LIBICONV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 7776f12..9e202dd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -75,7 +75,7 @@
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
       !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
-      !defined(__TANDEM) && !defined(__QNX__)
+      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-- 
1.8.5.1
