From: santiago@nyu.edu
Subject: [PATCH v5 5/6] builtin/verify-tag: move verification code to tag.c
Date: Tue,  5 Apr 2016 12:07:28 -0400
Message-ID: <1459872449-7537-6-git-send-email-santiago@nyu.edu>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 18:08:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTWc-0000oI-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 18:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759479AbcDEQII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 12:08:08 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:32864 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759450AbcDEQHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 12:07:40 -0400
Received: by mail-qg0-f68.google.com with SMTP id y89so1620172qge.0
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XqwLONBoHMSuwC85by46NI0NGOBLb81ZAqyFFtIktuM=;
        b=s6ESY/885RcVmhNpPFUuqEz4yrpf3ZNIy4cMAjHHTAjAWEKMcmJeUAwOJbjaD+v3ee
         V7QPf0nQVx+Yrh84dmu9bnqx75y+L/Nm+p8n0Oc9L4rcAUj9sHTJQzXflBGqcxHiel20
         4Vgx8OiGMO5BP0T123yicbbhYl3b0yW822Oak+W+T/Q8Tuuo12t5wmNY/4n2XxgaFekd
         CbGWG82rQr+MKBkcrx7r0f+skyuyVstrId81xZ8QfA/x9PgTb8qacGjIA7nkUbbwHG7p
         1gTjLM52H1Sirr5mMFUnscfS8KearRijbDBtof/LeTKZwpqubJGNJb2Ng69bOSgQ19eT
         TJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XqwLONBoHMSuwC85by46NI0NGOBLb81ZAqyFFtIktuM=;
        b=fgUdbCig0YK5e6bldXg4K7iiJCQOkdkhp2FEaMuq6P4n+Y22NLewciRu1FpW9b6qm6
         K/NQWU704/X6giwacK8FM7S4EzzjjFhnt2eRegkHG0jIx9SgHFOgjgf+OUFL1hHrObHm
         DqF5g1UqYDUaSyX3TMA2LpTTFH5LqRzQxTEsSS2DvoGUarfx95j41iuy72HWRj6dqYM5
         YKlB6riaJ2dJGAa/jfg/eMGp8NQLD1BUAhl7dhsy0vLfpF8jRxuCLrBI8Sw598TJaPAj
         lE2ROSmO9wE7fnZKT9aFB2Nub+HCdVlBtHconPX/wcbSCqIBsUFNuVseM5ZYp3MOsAoM
         x8qQ==
X-Gm-Message-State: AD7BkJJHIn4t5xflCkWQE/LDQzfGmNmPm6CasDv46srTFGtGMoarq2HB5X64dNMnnBnsaQ/O
X-Received: by 10.140.43.197 with SMTP id e63mr49157967qga.31.1459872459684;
        Tue, 05 Apr 2016 09:07:39 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id b66sm14671343qhb.48.2016.04.05.09.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 09:07:38 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290796>

From: Santiago Torres <santiago@nyu.edu>

The PGP verification routine for tags could be accessed by other
commands that require it. We do this by moving it to the common tag.c
module. We rename the verify_tag() function to gpg_verify_tag() to avoid
conflicts with the mktag.c function.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 50 +-------------------------------------------------
 tag.c                | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 tag.h                |  1 +
 3 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 7a7c376..e9a2005 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -18,54 +18,6 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
-{
-	struct signature_check sigc;
-	int payload_size;
-	int ret;
-
-	memset(&sigc, 0, sizeof(sigc));
-
-	payload_size = parse_signature(buf, size);
-
-	if (size == payload_size) {
-		if (flags & GPG_VERIFY_VERBOSE)
-			write_in_full(1, buf, payload_size);
-		return error("no signature found");
-	}
-
-	ret = check_signature(buf, payload_size, buf + payload_size,
-				size - payload_size, &sigc);
-	print_signature_buffer(&sigc, flags);
-
-	signature_check_clear(&sigc);
-	return ret;
-}
-
-static int verify_tag(const unsigned char *sha1, unsigned flags)
-{
-	enum object_type type;
-	char *buf;
-	char *hex_sha1;
-	unsigned long size;
-	int ret;
-
-	hex_sha1 = sha1_to_hex(sha1);
-	type = sha1_object_info(sha1, NULL);
-	if (type != OBJ_TAG)
-		return error("%s: cannot verify a non-tag object of type %s.",
-				hex_sha1, typename(type));
-
-	buf = read_sha1_file(sha1, &type, &size);
-	if (!buf)
-		return error("%s: unable to read file.", hex_sha1);
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
@@ -103,7 +55,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 			had_error = 1;
 			continue;
 		}
-		if (verify_tag(sha1, flags))
+		if (gpg_verify_tag(sha1, flags))
 			had_error = 1;
 	}
 	return had_error;
diff --git a/tag.c b/tag.c
index d72f742..3f7669f 100644
--- a/tag.c
+++ b/tag.c
@@ -6,6 +6,54 @@
 
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
+		if (flags & GPG_VERIFY_VERBOSE)
+			write_in_full(1, buf, payload_size);
+		return error("no signature found");
+	}
+
+	ret = check_signature(buf, payload_size, buf + payload_size,
+				size - payload_size, &sigc);
+	print_signature_buffer(&sigc, flags);
+
+	signature_check_clear(&sigc);
+	return ret;
+}
+
+int gpg_verify_tag(const unsigned char *sha1, unsigned flags)
+{
+	enum object_type type;
+	char *buf;
+	char *hex_sha1;
+	unsigned long size;
+	int ret;
+
+	hex_sha1 = sha1_to_hex(sha1);
+	type = sha1_object_info(sha1, NULL);
+	if (type != OBJ_TAG)
+		return error("%s: cannot verify a non-tag object of type %s.",
+				hex_sha1, typename(type));
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("%s: unable to read file.", hex_sha1);
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
index f4580ae..cb643b9 100644
--- a/tag.h
+++ b/tag.h
@@ -17,5 +17,6 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
+extern int gpg_verify_tag(const unsigned char *sha1, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.8.0
