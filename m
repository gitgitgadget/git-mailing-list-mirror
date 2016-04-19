From: santiago@nyu.edu
Subject: [PATCH v7 5/6] verify-tag: move tag verification code to tag.c
Date: Tue, 19 Apr 2016 13:47:20 -0400
Message-ID: <1461088041-19264-6-git-send-email-santiago@nyu.edu>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:48:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZkh-0002SY-LS
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167AbcDSRri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:47:38 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36296 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844AbcDSRrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:47:31 -0400
Received: by mail-qg0-f51.google.com with SMTP id f52so13561146qga.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DfBfl95RtIcRFsWNZ8H0anQsqk7l9QDRGMlPNOzCvYc=;
        b=w92Su5IaZ5fsmV1Osi3E+qfV2eHYg7dgiNtSemT4o+QTWQ/vBae5sQ3VvkBbAYgUwo
         Aepnvwn0GYalkJocvKnWyMgY/AZp4jlbh/ml7Pfl9lWOwP3L4fk+bc3uJ0QezJU+pVep
         aYeIOHiM9P4+8f+x8/Laly0qnTZlcIzKuC3XTSoSpZvEv8XikzY9IAsKvRPpD0PpM1Cl
         bnIYdz5AT1A7sBWMlh8IcYLXSZsqoxpyp2jy2i7fE2xI3DRK7emzGvPUrzjSbVeJCtwC
         hU/eL+wlSl4tQupy/h85Mer5M5Hchu8UXpMqUWYJQ78cbLhCqJzWSO92nhEM3UQw3xcb
         DJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DfBfl95RtIcRFsWNZ8H0anQsqk7l9QDRGMlPNOzCvYc=;
        b=OjSxXy1twUPVQB7F67LNl7hCyL8ooxGp65hMiFXYuOgZzWPTTrYdIUWRg565BpqGh+
         Pqz5B3GksFat7RfgASjyFY5j+koQylj3mPHAoRK/JxBreTdGy+rGfDTa9qQLLfnVEnRf
         WceemtM8biOsmQiKBh5xT+YPAgVgGYh2t4xvHfhg4nKeSSADv2pecOX0WZYgrSleCuDM
         wpI23S1BstohqZEs6XX56tE3nmb9AJtWzT3A+ZNJmVBhHsj2GY1ns2IPny68KDQ4gNxa
         GL5T4DGrFOKrsLogeDt2xos8yiRqEaDpmF9kH/v9+JRO8bSmy+SlNJNWDX0xKxBhGMbL
         FFJw==
X-Gm-Message-State: AOPr4FWVA2lGJnbRAfepC1AoHwVYXtMGFPVFl0b00Y8pYXZG7ATFIG1wesCDBKll2J7e3vkU
X-Received: by 10.140.94.106 with SMTP id f97mr5122985qge.95.1461088050309;
        Tue, 19 Apr 2016 10:47:30 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id w184sm11073374qkw.4.2016.04.19.10.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 10:47:29 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291890>

From: Santiago Torres <santiago@nyu.edu>

The PGP verification routine for tags could be accessed by other modules
that require to do so.

Publish the verify_tag function in tag.c and rename it to gpg_verify_tag
so it does not conflict with builtin/mktag's static function.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 55 +---------------------------------------------------
 tag.c                | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tag.h                |  2 ++
 3 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 01e956f..714c899 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -18,59 +18,6 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
-{
-	struct signature_check sigc;
-	size_t payload_size;
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
-static int verify_tag(const unsigned char *sha1, const char *name_to_report,
-			unsigned flags)
-{
-	enum object_type type;
-	char *buf;
-	unsigned long size;
-	int ret;
-
-	type = sha1_object_info(sha1, NULL);
-	if (type != OBJ_TAG)
-		return error("%s: cannot verify a non-tag object of type %s.",
-				name_to_report ?
-				name_to_report :
-				find_unique_abbrev(sha1, DEFAULT_ABBREV),
-				typename(type));
-
-	buf = read_sha1_file(sha1, &type, &size);
-	if (!buf)
-		return error("%s: unable to read file.",
-				name_to_report ?
-				name_to_report :
-				find_unique_abbrev(sha1, DEFAULT_ABBREV));
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
@@ -105,7 +52,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		name = argv[i++];
 		if (get_sha1(name, sha1))
 			had_error = !!error("tag '%s' not found.", name);
-		else if (verify_tag(sha1, name, flags))
+		else if (gpg_verify_tag(sha1, name, flags))
 			had_error = 1;
 	}
 	return had_error;
diff --git a/tag.c b/tag.c
index d72f742..ace619a 100644
--- a/tag.c
+++ b/tag.c
@@ -6,6 +6,59 @@
 
 const char *tag_type = "tag";
 
+static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
+{
+	struct signature_check sigc;
+	size_t payload_size;
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
+extern int gpg_verify_tag(const unsigned char *sha1,
+		const char *name_to_report, unsigned flags)
+{
+	enum object_type type;
+	char *buf;
+	unsigned long size;
+	int ret;
+
+	type = sha1_object_info(sha1, NULL);
+	if (type != OBJ_TAG)
+		return error("%s: cannot verify a non-tag object of type %s.",
+				name_to_report ?
+				name_to_report :
+				find_unique_abbrev(sha1, DEFAULT_ABBREV),
+				typename(type));
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("%s: unable to read file.",
+				name_to_report ?
+				name_to_report :
+				find_unique_abbrev(sha1, DEFAULT_ABBREV));
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
index f4580ae..a5721b6 100644
--- a/tag.h
+++ b/tag.h
@@ -17,5 +17,7 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
+extern int gpg_verify_tag(const unsigned char *sha1,
+		const char *name_to_report, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.8.0
