Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0919020401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbdFLWO3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:29 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34090 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbdFLWO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:27 -0400
Received: by mail-pg0-f45.google.com with SMTP id v18so50788496pgb.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PbE9FmjLkzgv3HsRpljpwLnxR3nU8xBWOEObMDShVew=;
        b=s06yaVcQzwnEc52Pf4Ig+rk5EXQAqsLl68sNzC+sl4GKJxkqWYgEnWzD/4/KFOGmVl
         A6AnVuj3CeL8Jdo4xG6c8V2ucy4xRYS5b1+OoRtMkA8ZdLeu6O268C8OlJjxJtNkyzZq
         aTcy/JUKEZuejvnKpByGfGkWQh6bSho08KUrRZcQx4DIvTtQegwaTRWSw2fMZ8+Asc9h
         Xe7iLfXI949d4DrtMiRx+YpCa9cz8r7zsgSP9tHRS/ejN4aUkAFL2IAoQGfpqBtMcYMe
         9JNG2iUyPaji7mm70pKcAJWrIQVY4wdxvUjXofjOHZ/YIH7YdwcIDUCoWkX4V8gaUoAZ
         djew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PbE9FmjLkzgv3HsRpljpwLnxR3nU8xBWOEObMDShVew=;
        b=ihsivqQTYmVoWI9LUYURQVg3IfDuv/5iZDXppJbVwPUvzgC92Hxu4gbS9sAbWGjxUi
         OoJOaloOV8Wf6V+8A2NfCMjeGkabJ7Yv7px++o71+pf0zFxPQAnPULlhyMfkIzDa79zN
         1zIpWzQJkapnv5v1XR0iMwWjs05k1mfFlOIuwTZSKMzCUY6Ey+WPBTJfUYIoOJDzoPcd
         le3hx/+n4SfihcqMrRz7VnNCv+DPlQoGy67vHgUMXU24UnxihT+JwbeWN360mkrGAcwc
         Cw6beCGhCdf1O9tHNS4YODN/RAcC96novOwgS1ckBfUViahMa8Kq7QriE8gu6BBn0XVA
         JnGQ==
X-Gm-Message-State: AODbwcAOCr7rsGQJAZ9JIAD8+yEnbxaUjd8TxK9dIaZ5dGHAyxOJksV0
        ZGfIv5+NFv6dhol5hpO5OA==
X-Received: by 10.84.232.130 with SMTP id i2mr59732608plk.251.1497305665587;
        Mon, 12 Jun 2017 15:14:25 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:24 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 05/17] convert: convert renormalize_buffer to take an index
Date:   Mon, 12 Jun 2017 15:13:56 -0700
Message-Id: <20170612221408.173876-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 convert.c         | 6 ++++--
 convert.h         | 3 ++-
 ll-merge.c        | 2 +-
 merge-recursive.c | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 600d11e73..4097f521f 100644
--- a/convert.c
+++ b/convert.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "attr.h"
 #include "run-command.h"
@@ -1165,14 +1166,15 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 	return convert_to_working_tree_internal(path, src, len, dst, 0);
 }
 
-int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
+int renormalize_buffer(const struct index_state *istate, const char *path,
+		       const char *src, size_t len, struct strbuf *dst)
 {
 	int ret = convert_to_working_tree_internal(path, src, len, dst, 1);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(&the_index, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
 }
 
 /*****************************************************************
diff --git a/convert.h b/convert.h
index 60cb41d6a..cecf59d1a 100644
--- a/convert.h
+++ b/convert.h
@@ -46,7 +46,8 @@ extern int convert_to_git(const struct index_state *istate,
 			  struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
-extern int renormalize_buffer(const char *path, const char *src, size_t len,
+extern int renormalize_buffer(const struct index_state *istate,
+			      const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
 static inline int would_convert_to_git(const struct index_state *istate,
 				       const char *path)
diff --git a/ll-merge.c b/ll-merge.c
index ac0d4a5d7..d7eafb61a 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -339,7 +339,7 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 static void normalize_file(mmfile_t *mm, const char *path)
 {
 	struct strbuf strbuf = STRBUF_INIT;
-	if (renormalize_buffer(path, mm->ptr, mm->size, &strbuf)) {
+	if (renormalize_buffer(&the_index, path, mm->ptr, mm->size, &strbuf)) {
 		free(mm->ptr);
 		mm->size = strbuf.len;
 		mm->ptr = strbuf_detach(&strbuf, NULL);
diff --git a/merge-recursive.c b/merge-recursive.c
index ae5238d82..eac12d488 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1639,8 +1639,8 @@ static int blob_unchanged(struct merge_options *opt,
 	 * performed.  Comparison can be skipped if both files are
 	 * unchanged since their sha1s have already been compared.
 	 */
-	if (renormalize_buffer(path, o.buf, o.len, &o) |
-	    renormalize_buffer(path, a.buf, a.len, &a))
+	if (renormalize_buffer(&the_index, path, o.buf, o.len, &o) |
+	    renormalize_buffer(&the_index, path, a.buf, a.len, &a))
 		ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
 
 error_return:
-- 
2.13.1.518.g3df882009-goog

