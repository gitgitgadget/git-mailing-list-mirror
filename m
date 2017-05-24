Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B70620281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969129AbdEXFQ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35346 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969095AbdEXFQS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id m17so31047210oik.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P9gaN5lGMvW8Qlrn5MwVk0R9QYmPuObQkWhBGTPYNtM=;
        b=IH0EABbE9QjaeRRSDQMnQ69Eiwx1ja7qyNyw6+KkqUQZDq+Y4+bpf+4+7aJ+NbRBnO
         UNhuL/JaYFcLUVd2am/mFWSbzrOvgw2JdtI5zGVeDK4yxh/LNAH5G8JyWF8ps9spvVI3
         6aIgsSgwmXV4d5yv1b2WuaGJekVhBoEMkHIEZFzAcRwByB4M43SC5llK/ywk/1SdntZU
         fqKyahvARLUDfXqLAGtOKj+5C2HAXBNYWMIVYhNVWsMmAKCqpJpx24F5JwYwhPDxbCE7
         jaOi1lyecQqbpgBQTU7QJJ9EccyeN9NmduOVXUonC1fI75y/m9qjiVn/5r177DHsPqx/
         RYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P9gaN5lGMvW8Qlrn5MwVk0R9QYmPuObQkWhBGTPYNtM=;
        b=Qv+SnmW4FDnmzyjoTgiyBBDbiphMulm4bA8VoBUe7enXr+DMU9tNAsPzp/u9tGDsLX
         JtcmzimUjyfClGZYXS5dyNH2hgm9t7mZJQaKwra74nq3DygzT3ypHo8T/JXxJkfii9fF
         Rl5s+wJbQ+H7IywDi/Rwnk6qn5ptGZv2FoorG8YHQBZIPVPlizD33FWWbwem8oKdPNJk
         tcZULRWTqmLl/n+wACRvyZ0qRouuS2hQTZ6nQBoWCrF7KMRW0PqPgh1qFH+1AOZZ9Drr
         UEWV0OJKJsLOAHpefQv8QWylHod1DCB2IvhqM+7zYYkwZnFFG5B9vShcVEWzJwpptbCw
         De6g==
X-Gm-Message-State: AODbwcD98AN4O63NX4mOOAQ8VJOhl/1dWJKu+7zOPgWoA7h1cTKuAV/y
        9x95nIqO3gihTw==
X-Received: by 10.157.19.40 with SMTP id f37mr3903730ote.118.1495602978040;
        Tue, 23 May 2017 22:16:18 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:17 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 02/29] blame: move textconv_object with related functions
Date:   Wed, 24 May 2017 00:15:10 -0500
Message-Id: <20170524051537.29978-3-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

textconv_object is used in places other than blame.c and should be moved
to a more appropriate location.  Other textconv related functions are
located in diff.c so that seems as good a place as any.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin.h          |  2 --
 builtin/blame.c    | 28 ----------------------------
 builtin/cat-file.c |  1 +
 diff.c             | 23 +++++++++++++++++++++++
 diff.h             |  7 +++++++
 5 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/builtin.h b/builtin.h
index 9e4a898..498ac80 100644
--- a/builtin.h
+++ b/builtin.h
@@ -25,8 +25,6 @@ struct fmt_merge_msg_opts {
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
 
-extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
-
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
diff --git a/builtin/blame.c b/builtin/blame.c
index d39f6af..fbd757e 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -147,34 +147,6 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
 }
 
 /*
- * Prepare diff_filespec and convert it using diff textconv API
- * if the textconv driver exists.
- * Return 1 if the conversion succeeds, 0 otherwise.
- */
-int textconv_object(const char *path,
-		    unsigned mode,
-		    const struct object_id *oid,
-		    int oid_valid,
-		    char **buf,
-		    unsigned long *buf_size)
-{
-	struct diff_filespec *df;
-	struct userdiff_driver *textconv;
-
-	df = alloc_filespec(path);
-	fill_filespec(df, oid->hash, oid_valid, mode);
-	textconv = get_textconv(df);
-	if (!textconv) {
-		free_filespec(df);
-		return 0;
-	}
-
-	*buf_size = fill_textconv(textconv, df, buf);
-	free_filespec(df);
-	return 1;
-}
-
-/*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1890d7a..79a2c82 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "diff.h"
 #include "parse-options.h"
 #include "userdiff.h"
 #include "streaming.h"
diff --git a/diff.c b/diff.c
index 74283d9..040fb25 100644
--- a/diff.c
+++ b/diff.c
@@ -5270,6 +5270,29 @@ size_t fill_textconv(struct userdiff_driver *driver,
 	return size;
 }
 
+int textconv_object(const char *path,
+		    unsigned mode,
+		    const struct object_id *oid,
+		    int oid_valid,
+		    char **buf,
+		    unsigned long *buf_size)
+{
+	struct diff_filespec *df;
+	struct userdiff_driver *textconv;
+
+	df = alloc_filespec(path);
+	fill_filespec(df, oid->hash, oid_valid, mode);
+	textconv = get_textconv(df);
+	if (!textconv) {
+		free_filespec(df);
+		return 0;
+	}
+
+	*buf_size = fill_textconv(textconv, df, buf);
+	free_filespec(df);
+	return 1;
+}
+
 void setup_diff_pager(struct diff_options *opt)
 {
 	/*
diff --git a/diff.h b/diff.h
index 5be1ee7..52ebd54 100644
--- a/diff.h
+++ b/diff.h
@@ -385,6 +385,13 @@ extern size_t fill_textconv(struct userdiff_driver *driver,
  */
 extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
 
+/*
+ * Prepare diff_filespec and convert it using diff textconv API
+ * if the textconv driver exists.
+ * Return 1 if the conversion succeeds, 0 otherwise.
+ */
+extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
+
 extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
-- 
2.9.3

