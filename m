From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] cleanups: ensure that git-compat-util.h is included first
Date: Sun, 14 Sep 2014 00:40:45 -0700
Message-ID: <1410680445-84593-2-git-send-email-davvid@gmail.com>
References: <1410680445-84593-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 09:41:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT4Qg-000153-QY
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 09:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbaINHk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 03:40:59 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:58999 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbaINHk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 03:40:58 -0400
Received: by mail-pa0-f44.google.com with SMTP id kx10so4324498pab.17
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=348JnAvuwONuNSPIYXDmxH+u3+MRvtS6S1aeZWk9ESQ=;
        b=uNC88OBthEyXZWLeTo/RwPup4BOZHqUu65nqDsy/yrw0A3DI/9FSRLZ7tQ4pUW65uc
         7W/vSQ/IjEJgSzIdZ5jAsZRa5lMx8JPVR0QJfzhRNFKUF43KoiFJoXZS6NABSLy2vFdq
         KDPIehhWdgnW7HeUX5Di8R4DziIhMhYbhhBNLyL8sTwOcaTKsGIi1Xm9FI4EXKKCHqoH
         5D7ghDNjSBcaxzlT++PVoPNnKTtiAbhuHldPLvyUJvbW3w3NYEreVv212KcmUzToVJuA
         eIoQ/y/Atbr5uVwAqn7lbsaWuGtdxzZHhK9VIYI86ooKD28LqTQZCpCyW17nJ2GKVie/
         DkQw==
X-Received: by 10.66.227.71 with SMTP id ry7mr28281472pac.32.1410680458162;
        Sun, 14 Sep 2014 00:40:58 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dl8sm8157177pdb.65.2014.09.14.00.40.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Sep 2014 00:40:57 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.241.ga16d620
In-Reply-To: <1410680445-84593-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257000>

CodingGuidelines states that the first #include in C files should be
git-compat-util.h or another header file that includes it, such as
cache.h or builtin.h.

Tweak the tiny minority of files that do not follow this advice.
This makes "make check-headers SKIP_HEADER_CHECK=1" happy.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 bulk-checkin.c    | 1 +
 bulk-checkin.h    | 2 --
 http.c            | 1 +
 merge-recursive.c | 2 +-
 sigchain.c        | 2 +-
 test-regex.c      | 2 +-
 test-sigchain.c   | 2 +-
 varint.c          | 1 +
 varint.h          | 2 --
 9 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 98e651c..0c4b8a7 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2011, Google Inc.
  */
+#include "cache.h"
 #include "bulk-checkin.h"
 #include "csum-file.h"
 #include "pack.h"
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 4f599f8..fbd40fc 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -4,8 +4,6 @@
 #ifndef BULK_CHECKIN_H
 #define BULK_CHECKIN_H
 
-#include "cache.h"
-
 extern int index_bulk_checkin(unsigned char sha1[],
 			      int fd, size_t size, enum object_type type,
 			      const char *path, unsigned flags);
diff --git a/http.c b/http.c
index 0adcec4..040f362 100644
--- a/http.c
+++ b/http.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "http.h"
 #include "pack.h"
 #include "sideband.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 8ab944c..df8157b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3,8 +3,8 @@
  * Fredrik Kuivinen.
  * The thieves were Alex Riesen and Johannes Schindelin, in June/July 2006
  */
-#include "advice.h"
 #include "cache.h"
+#include "advice.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "blob.h"
diff --git a/sigchain.c b/sigchain.c
index 1118b99..faa375d 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -1,5 +1,5 @@
-#include "sigchain.h"
 #include "cache.h"
+#include "sigchain.h"
 
 #define SIGCHAIN_MAX_SIGNALS 32
 
diff --git a/test-regex.c b/test-regex.c
index b5bfd54..0dc598e 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,4 +1,4 @@
-#include <git-compat-util.h>
+#include "git-compat-util.h"
 
 int main(int argc, char **argv)
 {
diff --git a/test-sigchain.c b/test-sigchain.c
index 42db234..e499fce 100644
--- a/test-sigchain.c
+++ b/test-sigchain.c
@@ -1,5 +1,5 @@
-#include "sigchain.h"
 #include "cache.h"
+#include "sigchain.h"
 
 #define X(f) \
 static void f(int sig) { \
diff --git a/varint.c b/varint.c
index 4ed7729..409c497 100644
--- a/varint.c
+++ b/varint.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "varint.h"
 
 uintmax_t decode_varint(const unsigned char **bufp)
diff --git a/varint.h b/varint.h
index 0321195..c1c44d9 100644
--- a/varint.h
+++ b/varint.h
@@ -1,8 +1,6 @@
 #ifndef VARINT_H
 #define VARINT_H
 
-#include "git-compat-util.h"
-
 extern int encode_varint(uintmax_t, unsigned char *);
 extern uintmax_t decode_varint(const unsigned char **);
 
-- 
2.1.0.241.ga16d620
