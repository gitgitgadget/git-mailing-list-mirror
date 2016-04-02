From: santiago@nyu.edu
Subject: [PATCH v3 3/4] builtin/verify-tag: move verification code to tag.c
Date: Sat,  2 Apr 2016 19:16:14 -0400
Message-ID: <1459638975-17705-4-git-send-email-santiago@nyu.edu>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 01:17:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amUmz-0004ZP-AS
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 01:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcDBXRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 19:17:03 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36285 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcDBXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 19:16:56 -0400
Received: by mail-qk0-f194.google.com with SMTP id e124so6146812qkc.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNXyIuwSHfkSN09qvOuepWgmNDVIQbKJxGhW1uaG+g4=;
        b=mJoMK9+IuiZc7PFyMRFfOEnkogP40wgju+De70o9ZaxyQn7Ca22V5ogbMt7TfzuDNG
         5Se0WksVwrkoZh5ijOqX7fHCTS4vwngZVGpjCwqrxK5h5joG2/gHX4H1m6kgTNkqZSN4
         S/ppYcCoGKqwFBNn3C57GWfsG/u7fdo7XOxENE7t4nkGLkhXVI9+BYc6H1zYhKUe9Dvg
         cxFYXp5/l4rG18/RExKM3whhaR/+c7Q01+di98W4PCGC3EPo9/4ZMmGLo5WLDo3gORf5
         jM7wJuOIM7Mql37i0LK+OsNc+k04NfF03DE8Mo/A68Yl+mXuu+mjmTmDQD3fVXPdoBW3
         UH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DNXyIuwSHfkSN09qvOuepWgmNDVIQbKJxGhW1uaG+g4=;
        b=kOJISzEpF+w9VMHf1ONzTWoRvrSWvV/rXn8vIf0Gk9KINTrJMM8K8BEEf6e8eoYVwl
         zYNUa5cRvV/fU9XNELIVLoA3Bs9WSdYoqL9RSJMvmF/W47F8+MUmIVDX4TEC13wuA2Km
         1F4oBPKGx9iHvGQkHbNOzdT2R2F89Zz5SnKyVStkpqB/oVhJKWhOJWIiO1WMJ9uNPQlD
         KVDbgE85YGSzr4UF2WM1f3RleOkdbUgraCPpBzPNRv/YJSWVDBW96h3mKs8JzwJ2ATtB
         0M6mrAiLtvgcxl337hUkBMfeH3JRPT/CaCGy+MzTrQAg0lOPrMVhhBVUMkvVFgLQ7C3f
         q/uw==
X-Gm-Message-State: AD7BkJJZHdZeWg3PoZZ+9RixR6Sld+A2pRXP6cbyLtsNyI0aj5I0rkjokeF21Z2K5WxjTdMR
X-Received: by 10.55.72.148 with SMTP id v142mr25910571qka.102.1459639015175;
        Sat, 02 Apr 2016 16:16:55 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id l33sm9199788qge.11.2016.04.02.16.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 16:16:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290610>

From: Santiago Torres <santiago@nyu.edu>

The PGP verification routine for tags could be accessed by other
commands that require it. We do this by moving it to the common tag.c
code. We rename the verify_tag() function to pgp_verify_tag() to avoid
conflicts with the mktag.c function.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 51 +--------------------------------------------------
 tag.c                | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tag.h                |  1 +
 3 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 77f070a..f776778 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -18,55 +18,6 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
-{
-	struct signature_check sigc;
-	int len;
-	int ret;
-
-	memset(&sigc, 0, sizeof(sigc));
-
-	len = parse_signature(buf, size);
-
-	if (size == len) {
-		if (flags & GPG_VERIFY_VERBOSE)
-			write_in_full(1, buf, len);
-		return error("no signature found");
-	}
-
-	ret = check_signature(buf, len, buf + len, size - len, &sigc);
-	print_signature_buffer(&sigc, flags);
-
-	signature_check_clear(&sigc);
-	return ret;
-}
-
-static int verify_tag(const char *name, unsigned flags)
-{
-	enum object_type type;
-	unsigned char sha1[20];
-	char *buf;
-	unsigned long size;
-	int ret;
-
-	if (get_sha1(name, sha1))
-		return error("tag '%s' not found.", name);
-
-	type = sha1_object_info(sha1, NULL);
-	if (type != OBJ_TAG)
-		return error("%s: cannot verify a non-tag object of type %s.",
-				name, typename(type));
-
-	buf = read_sha1_file(sha1, &type, &size);
-	if (!buf)
-		return error("%s: unable to read file.", name);
-
-	ret = run_gpg_verify(buf, size, flags);
-
-	free(buf);
-	return ret;
-}
-
 static int git_verify_tag_config(const char *var, const char *value, void *cb)
 {
 	int status = git_gpg_config(var, value, cb);
@@ -96,7 +47,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		flags |= GPG_VERIFY_VERBOSE;
 
 	while (i < argc)
-		if (verify_tag(argv[i++], flags))
+		if (pgp_verify_tag(argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
diff --git a/tag.c b/tag.c
index d72f742..918ae39 100644
--- a/tag.c
+++ b/tag.c
@@ -6,6 +6,56 @@
 
 const char *tag_type = "tag";
 
+static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
+{
+	struct signature_check sigc;
+	int payload_size;
+	int ret;
+
+	memset(&sigc, 0, sizeof(sigc));
+
+	payload_size = parse_signature(buf, size);
+
+	if (size == payload_size) {
+		write_in_full(1, buf, payload_size);
+		return error("No PGP signature found in this tag!");
+	}
+
+	ret = check_signature(buf, payload_size, buf + payload_size,
+			size - payload_size, &sigc);
+	print_signature_buffer(&sigc, flags);
+
+	signature_check_clear(&sigc);
+	return ret;
+}
+
+int pgp_verify_tag(const char *name, unsigned flags)
+{
+
+	enum object_type type;
+	unsigned long size;
+	unsigned char sha1[20];
+	char* buf;
+	int ret;
+
+	if (get_sha1(name, sha1))
+		return error("tag '%s' not found.", name);
+
+	type = sha1_object_info(sha1, NULL);
+	if (type != OBJ_TAG)
+		return error("%s: cannot verify a non-tag object of type %s.",
+				name, typename(type));
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("%s: unable to read file.", name);
+
+	ret = run_gpg_verify(buf, size, flags);
+
+	free(buf);
+	return ret;
+}
+
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
diff --git a/tag.h b/tag.h
index f4580ae..09e71f9 100644
--- a/tag.h
+++ b/tag.h
@@ -17,5 +17,6 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
+extern int pgp_verify_tag(const char *name, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.8.0
