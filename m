Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21E420188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758036AbdENDQL (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33961 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757481AbdENDQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:09 -0400
Received: by mail-oi0-f67.google.com with SMTP id w10so14325619oif.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8OzXG1WUkzOO+wsLafgPawOgPKG/UZXhRigvFQLvSPQ=;
        b=fH/L4ahVBmZb++f+Qr0Ott2WQ4IueWXPBByst2c9SPEC0idM2QXAHtJd8w2mdw6sej
         qaCrUtdyCKxRx1H4rYEJIoy6QjlDtGcFpD0MlXp2Qjx6Q7G9xP9EQpM2+NwBmW5fvjLU
         7PMroCdtKiz08h+/or4X/NuXua01SnWfN+WToXW36ajVQ0w83O325edDkznnD2DZ2A74
         XM6e3co9zl2UjdVtkNlCbofuz/T6+UcGkuraTIk1mOkDo6n3LDV+3vFu+MRAC/m1ik7Y
         rCfsjWKCuYuFgZJD0Jz2RAPtRuyHVXwAu3vk2vv1PA0pYaNSzu0nV1B7FtoRtR5LlL1T
         7yUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8OzXG1WUkzOO+wsLafgPawOgPKG/UZXhRigvFQLvSPQ=;
        b=mkG6rfcHpR0DYl29K/6ZKKVt5Zjcr2a946SqRX0gQNpqVeP86bFAK+SQaxoH88n+2l
         JQmVHK3hW+J0oqMiKOjH1vx7CFjG2K5M+FYZZUc+RfmV/axVFF+9Hpavlm3Bf9f4kDQ8
         dPJ6WPGoVoyXq0Xf3Me1Kx+BzPJcY/yscEWG9PBqdpWP6oQkWa/v/nEDsSJoryrCgCZ9
         XrkMjOLcz7XXXJiGGnj2fKZL1pQMzeA2DudMlXqm0+ymdxvcDid/FkRBHTaDcYDayxsU
         j+d6NbOTEl8jvugn2b6YmHhPiBpHeo34R1lEmloGrS5Aw3rm1oRwBlukgVtGbvPcKAOr
         M3OA==
X-Gm-Message-State: AODbwcCFgR+lHsA3cnLOYqk7CTXNp+XCtIjbskIAEUnHjzu5egAB6tlo
        lBEmvDo9mSg2lw==
X-Received: by 10.157.37.72 with SMTP id j8mr6590613otd.27.1494731768186;
        Sat, 13 May 2017 20:16:08 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:07 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 02/22] blame: move textconv_object with related functions
Date:   Sat, 13 May 2017 22:14:53 -0500
Message-Id: <20170514031513.9042-3-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
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
index 42c56eb..c419981 100644
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

