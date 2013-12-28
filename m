From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 01/10] Rename READ_SHA1_FILE_REPLACE flag to
 LOOKUP_REPLACE_OBJECT
Date: Sat, 28 Dec 2013 12:00:06 +0100
Message-ID: <20131228110016.2272.85613.chriscool@tuxfamily.org>
References: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 12:01:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwrdw-0007j1-Ne
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095Ab3L1LAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:00:49 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:34551 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab3L1LAr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:47 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 5F72955;
	Sat, 28 Dec 2013 12:00:46 +0100 (CET)
X-git-sha1: 643dfd1605ab6c92fc6acf1dfcbdc2b1c7d9435d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239772>

The READ_SHA1_FILE_REPLACE flag is more related to using the
lookup_replace_object() function rather than the
read_sha1_file() function.

We also need such a flag to be used with sha1_object_info()
instead of read_sha1_file().

The name LOOKUP_REPLACE_OBJECT is therefore better for this
flag.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     | 4 ++--
 sha1_file.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index ce377e1..873a6b5 100644
--- a/cache.h
+++ b/cache.h
@@ -760,11 +760,11 @@ int daemon_avoid_alias(const char *path);
 int offset_1st_component(const char *path);
 
 /* object replacement */
-#define READ_SHA1_FILE_REPLACE 1
+#define LOOKUP_REPLACE_OBJECT 1
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
-	return read_sha1_file_extended(sha1, type, size, READ_SHA1_FILE_REPLACE);
+	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
 }
 extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
 static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
diff --git a/sha1_file.c b/sha1_file.c
index daacc0c..76e9f32 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2591,7 +2591,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 	void *data;
 	char *path;
 	const struct packed_git *p;
-	const unsigned char *repl = (flag & READ_SHA1_FILE_REPLACE)
+	const unsigned char *repl = (flag & LOOKUP_REPLACE_OBJECT)
 		? lookup_replace_object(sha1) : sha1;
 
 	errno = 0;
-- 
1.8.4.1.616.g07f5c81
