From: santiago@nyu.edu
Subject: [PATCH v4 3/6] builtin/verify-tag: move verification code to tag.c
Date: Mon,  4 Apr 2016 18:22:12 -0400
Message-ID: <1459808535-8895-4-git-send-email-santiago@nyu.edu>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 00:22:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anCtT-0007kR-0D
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 00:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613AbcDDWWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 18:22:37 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35305 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293AbcDDWW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 18:22:27 -0400
Received: by mail-qg0-f43.google.com with SMTP id y89so165137111qge.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yphAyQekJUDM/nRICMm6p3ap//b2h6v/2+GA/Wbo1es=;
        b=RPi7L1mWMdPV7uX1DMkZo9JlFN+BXjI1Q7fkvB+Xn9pk+g/BCgPhF9Of7QD7LdvIG7
         6O44Tb6mGaniDfnnpWVkSEp4Hu/ESoEbPvpwKWh6u1lMN3fI6dfYfYsGNY+sg6dfWpG2
         x/gRDklnvsZIN2eXNf6Zo8Y9ekiMtnkENS5D3lRBx7dSW7oBBvtLfpfTDY2gHR3xI65D
         xYX4ssYIWD/V5Y9Rk7ETZsIX8qpdOihT6CVpcfqPQyT+2T14Z1iHz2ytc4dZ1Tx7IbCa
         QXFGuuNPolafsZHgTNf6EJvohB6IWbMKWuRpdRA6xfl/MU+NndzP9z7HEYWD4KV2Sz3H
         YyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yphAyQekJUDM/nRICMm6p3ap//b2h6v/2+GA/Wbo1es=;
        b=HprPCthtjeTvHLaR1bp32glc8zqV18Rf1bLAFA4tc3TEvOpKZ5RP9g4x4cs/aYYuT6
         oV5KsYr9KI2rDoFC1jeYIWU6ICrJ6P40ilUzRREywpuAJjM1UvdMORcQDvstQUSkI2bc
         hSIAkCU6Tir1HvGqf40Hn4D+kNmwdnDcPFn2M9LZU+Dhc9Kk37oDYMOhJwdKHRZocjCU
         W1qwlBm4oPTi134gNvbzjPr84KuGA1zvzAqzitWI4v05INwnLtUjOUjHr98bjb361IMG
         0pfwOo92oU51z229qNTj1OwLw8qlt74H+UGF/hi2s3lT/37407d6AGv0alkFWjRWFxSE
         SKEA==
X-Gm-Message-State: AD7BkJKF67U79VC8UX5Qbgq5fNCbx3gY+FBs5Ssa+o9GXbdOXWS88EqXdV1aNd6/eEcbQTfe
X-Received: by 10.140.43.10 with SMTP id d10mr2038384qga.38.1459808546648;
        Mon, 04 Apr 2016 15:22:26 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id h9sm13180670qhh.29.2016.04.04.15.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 15:22:26 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290732>

From: Santiago Torres <santiago@nyu.edu>

The PGP verification routine for tags could be accessed by other
commands that require it. We do this by moving it to the common tag.c
code. We rename the verify_tag() function to gpg_verify_tag() to avoid
conflicts with the mktag.c function.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
	Note: In this version, I just blndly moved code around and renamed
the function's name for ease of review. The following patch only renames
variables.

 builtin/verify-tag.c | 51 +--------------------------------------------------
 tag.c                | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 tag.h                |  1 +
 3 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 77f070a..7e36d53 100644
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
+		if (gpg_verify_tag(argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
diff --git a/tag.c b/tag.c
index d72f742..81e86e6 100644
--- a/tag.c
+++ b/tag.c
@@ -6,6 +6,55 @@
 
 const char *tag_type = "tag";
 
+static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
+{
+	struct signature_check sigc;
+	int len;
+	int ret;
+
+	memset(&sigc, 0, sizeof(sigc));
+
+	len = parse_signature(buf, size);
+
+	if (size == len) {
+		if (flags & GPG_VERIFY_VERBOSE)
+			write_in_full(1, buf, len);
+		return error("no signature found");
+       }
+
+	ret = check_signature(buf, len, buf + len, size - len, &sigc);
+	print_signature_buffer(&sigc, flags);
+
+	signature_check_clear(&sigc);
+	return ret;
+}
+
+int gpg_verify_tag(const char *name, unsigned flags)
+{
+	enum object_type type;
+	unsigned char sha1[20];
+	char *buf;
+	unsigned long size;
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
index f4580ae..877f180 100644
--- a/tag.h
+++ b/tag.h
@@ -17,5 +17,6 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
+extern int gpg_verify_tag(const char *name, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.8.0
