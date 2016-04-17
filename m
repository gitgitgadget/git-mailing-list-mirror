From: santiago@nyu.edu
Subject: [PATCH v6 5/6] verify-tag: move verification code to tag.c
Date: Sun, 17 Apr 2016 18:27:00 -0400
Message-ID: <1460932021-27633-6-git-send-email-santiago@nyu.edu>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:27:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arvA2-000518-77
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 00:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbcDQW1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 18:27:17 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34623 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcDQW1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 18:27:16 -0400
Received: by mail-qg0-f53.google.com with SMTP id c6so107580960qga.1
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGXsSYUfBDsf+8xWDJRt5RC77qe6WfVqBctbW/r/FLQ=;
        b=d8wtTTJJBeB37fxybxjpK9MbZvsnmGWblMvsFuE4eXnikJn+N0/TIKC/Vu/IH0zQgz
         kMzlDjwZO0mwMB589O05IJ0aSPdM5yr3CumWjuWPTHWlkIuFtoEse7MbkJaEO1dGW6i8
         8CFbkWTrbBs9TU4ZVGVCAjQc0Jyn8iVzI0YqbTdOaCjBdeOyx3Y9eaB0kehI7HLeBugb
         icrHnhtZdSg+jfBvwgIqeX2d+h6GFVb0ntOGteKuNs6Epa0eeDuw2f5CRBxcVXxjkLjn
         Ro7LmMgxkOECDYt27fInAuXHfRVc+FODZHI8ak8LxzOxKGOQqsjTAxFFwjw+qCOY8ijn
         nKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vGXsSYUfBDsf+8xWDJRt5RC77qe6WfVqBctbW/r/FLQ=;
        b=cGyZVnRv0DUAXVS5lGmVNmK7W0yHQ1BA0DPgVTfLW43qU9A37B+bX6+8kY3BSbTSVQ
         RAb2LRRekq4IDJvUXG4bbLoieNuVNOOaNcrv9iOGGwsgtzULKzUlVCfg89OPpNtKdKI7
         J8EavgSHZbVKOwewyNv310spc9BjIh7Kf52qq+kziPBJbnQnlUiEOgab5Irb210fRlva
         RbuRWLXb2KTQSoOs9r4TxJ0EEqT44YDG2cGxz0KNFKeBgLhhrH3CJJCnOp3rvtrxMRng
         fFbMhXBXO7CrKzaQ3cfFdWIdwMAXJwPIoF+d+aTmrDuHjRYIzkwEcyNP4XJY5vhVl+m/
         zkgQ==
X-Gm-Message-State: AOPr4FUZwae7RoyQAQJWglhZZJa0VnkxHbueQDiB9fw3ylvZJ7j3DDPXwtA6NG6e38nwFPeN
X-Received: by 10.140.99.80 with SMTP id p74mr38158127qge.97.1460932035130;
        Sun, 17 Apr 2016 15:27:15 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id j75sm5120767qgd.19.2016.04.17.15.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Apr 2016 15:27:14 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291778>

From: Santiago Torres <santiago@nyu.edu>

The PGP verification routine for tags could be accessed by other modules
that require to do so.

Publish the verify_tag function in tag.c and rename it to gpg_verify_tag
so it does not conflict with builtin/mktag's static function.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 51 +--------------------------------------------------
 tag.c                | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 tag.h                |  3 ++-
 3 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 1d1c5c2..4e3b643 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -18,55 +18,6 @@ static const char * const verify_tag_usage[] = {
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
-static int verify_tag(const unsigned char *sha1, const char *report_name,
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
-				report_name ? report_name : find_unique_abbrev(sha1, DEFAULT_ABBREV),
-				typename(type));
-
-	buf = read_sha1_file(sha1, &type, &size);
-	if (!buf)
-		return error("%s: unable to read file.",
-				report_name ? report_name : find_unique_abbrev(sha1, DEFAULT_ABBREV));
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
@@ -103,7 +54,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 			error("tag '%s' not found.", name);
 			had_error = 1;
 		}
-		else if (verify_tag(sha1, name, flags))
+		else if (gpg_verify_tag(sha1, name, flags))
 			had_error = 1;
 	}
 	return had_error;
diff --git a/tag.c b/tag.c
index d72f742..e7f22c6 100644
--- a/tag.c
+++ b/tag.c
@@ -6,6 +6,55 @@
 
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
+int gpg_verify_tag(const unsigned char *sha1, const char *report_name,
+			unsigned flags)
+{
+	enum object_type type;
+	char *buf;
+	unsigned long size;
+	int ret;
+
+	type = sha1_object_info(sha1, NULL);
+	if (type != OBJ_TAG)
+		return error("%s: cannot verify a non-tag object of type %s.",
+				report_name ? report_name : find_unique_abbrev(sha1, DEFAULT_ABBREV),
+				typename(type));
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("%s: unable to read file.",
+				report_name ? report_name : find_unique_abbrev(sha1, DEFAULT_ABBREV));
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
index f4580ae..1a8d123 100644
--- a/tag.h
+++ b/tag.h
@@ -17,5 +17,6 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
-
+extern int gpg_verify_tag(const unsigned char *sha1, const char *report_name,
+			unsigned flags);
 #endif /* TAG_H */
-- 
2.8.0
