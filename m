Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82E01FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdEaVpO (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:14 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35277 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdEaVpI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:08 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so18565022pfb.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xLiidYTsua6BAPRgNc37tf2QhyIS+vd6G8N5xMwBbx8=;
        b=f0gSWFRo3ZKpV49GkWjmz1djdWJhVl83IhlG0UqnkMRBmiQD5EJ0riuM0IeondyGam
         D2CwOLu4fLVNcwJ/zvNMYlgnHtCFYF6rRTXAVDclBAc4XwzQvSdCWBL+4ICrUYS+2psB
         jZXbroDUTyJb1AJbRXEQhvoqbS7/P+PaSuPKjoHeNkgjoJQxZQ3Qt7mJMyxq3YKWLnrA
         4FRHOg7mHPUGItte14N4UppZCDfRwN+f1g2vuM1EAye6ImZ2+C6l0g9fF7m0nbIcyXD8
         guH/wObsYBHtf8TzfW8DTAZtnw+ZTmmiVaL1WBouKY0YusYpgecOFFgwMkHqutkYT5N1
         UQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xLiidYTsua6BAPRgNc37tf2QhyIS+vd6G8N5xMwBbx8=;
        b=dpZoODEAS6HJ34RvUiybGG37SspIU04JrUBmnqYzit6CGlGziKY1QZHc5mci5weBUD
         JLFIXv3J9OXoEk+dN/b0pMPGKVYegSGzYumZeLbl3KAu3HNDoBp3v9TOFQ1A3pIV06GA
         o6BVaL/yQcqVw3caN0ZnLxdkhUEvs3qTniCGAIYtsZYy5Kw6lXFBg23bR04aAqun9t2C
         ER89gXd7TlDItOjXGZ0kK9mtfnC7L9IVsQGy+43u+lmFesf/YpW/54oj3K9qScKNghTS
         Nrc7cV9QZ8hApKHfUk6ClIQcIQObBCuoxulrmz6hIUmpkQd9qmHMKy7M+uK9X5m8KeMD
         8hkw==
X-Gm-Message-State: AODbwcBF4rMjHYykvFVNDzS7a2Emis/5BQrI4r63oCQJb4jqf1ckkjNH
        yBpeNgAnp7E6qO5azAeAXQ==
X-Received: by 10.99.149.70 with SMTP id t6mr28196250pgn.168.1496267102758;
        Wed, 31 May 2017 14:45:02 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 19/31] convert: convert renormalize_buffer to take an index
Date:   Wed, 31 May 2017 14:44:05 -0700
Message-Id: <20170531214417.38857-20-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
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
index 5af6fdf3f..7d2a519da 100644
--- a/convert.c
+++ b/convert.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "attr.h"
@@ -1166,14 +1167,15 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
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
index 24ff94e1d..b9576efe9 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -340,7 +340,7 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 static void normalize_file(mmfile_t *mm, const char *path)
 {
 	struct strbuf strbuf = STRBUF_INIT;
-	if (renormalize_buffer(path, mm->ptr, mm->size, &strbuf)) {
+	if (renormalize_buffer(&the_index, path, mm->ptr, mm->size, &strbuf)) {
 		free(mm->ptr);
 		mm->size = strbuf.len;
 		mm->ptr = strbuf_detach(&strbuf, NULL);
diff --git a/merge-recursive.c b/merge-recursive.c
index c2494f34f..a4b3858d0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1640,8 +1640,8 @@ static int blob_unchanged(struct merge_options *opt,
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
2.13.0.506.g27d5fe0cd-goog

