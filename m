From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 01/10] Rename READ_SHA1_FILE_REPLACE flag to
 LOOKUP_REPLACE_OBJECT
Date: Wed, 11 Dec 2013 08:46:04 +0100
Message-ID: <20131211074614.11117.80467.chriscool@tuxfamily.org>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 08:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqeWQ-0007lg-ED
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 08:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab3LKHrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 02:47:52 -0500
Received: from [194.158.98.15] ([194.158.98.15]:58223 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751215Ab3LKHrr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 02:47:47 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 42ABC49;
	Wed, 11 Dec 2013 08:47:26 +0100 (CET)
X-git-sha1: 643dfd1605ab6c92fc6acf1dfcbdc2b1c7d9435d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239173>

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
1.8.5.1.102.g090758b
