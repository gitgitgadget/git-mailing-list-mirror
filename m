Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF501FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbdFHXl6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:58 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35071 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdFHXl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:56 -0400
Received: by mail-pf0-f174.google.com with SMTP id l89so22167306pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zt1czjqBBEA8Y59vO4kTFg+rc8FfupG9yyuxz2MwbPQ=;
        b=U5dZ2KwLdtLAh4hAlCGgi0deHkYjg4JzDNPFIUgugw2zKubG00epyWQCtbprE/XqaN
         sEWEOqz8ymy2iNwszzVbRjVIfQV6wQPpNGHfD6Li32KPEwwE0OzvcKwx+OPTVrhQbkra
         nabtrdOq/rlmFbT3o9jzpKWvRF2tMS5vQgYAh9tDB6brNvb73qUvEo8eYhgkKp53hY9M
         nPUHda0qcqm8zP52zaV290f4Pj+yIsNc4VqF/iU7bLz2WVBdypYethbsGsH0eqzuOnOM
         AFS6yhP0n0GBTeebvgQGGjPpWMssCV4IRZqfMDuDBDiSddcyjq/PTJ+boi47m831Behe
         6KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zt1czjqBBEA8Y59vO4kTFg+rc8FfupG9yyuxz2MwbPQ=;
        b=V0IjywXMIVK2TPJk7DqvVIxNI4vp7I3Ohlg9eIPykvc4Ph+TirZxG2pIjZOrl4ycfX
         YJCMoFi92se331fiZ3N0wDnDH7JtBvc0lY7N7MBh3LKwE9Xdju9DdzPcR2c8iDi8jVCy
         Vge+SaISFuKRSIa6Z8Ve1j/U8SnQKKABBWBeKRvxRlGlu87UeuaR6W2xOBfFT8aWZV3w
         75+cDvOerXCeBR6SKjbQ39UZ99ScUepcNwLK56i7Pl9lXg0Kr7GLwvPbVa8DyYqcKhf7
         LyL86WX0ngqFf2eBKD4g5d65EWB3vTCnIfD5+DHzjQxzK4eUjAKQH84IdvEz/2GlwBKM
         ZD9g==
X-Gm-Message-State: AODbwcD+hxANEDuAQrzrzDf5t7ATt1iUZpEfleVLVGyFlQW9qst1Yq2r
        vTsIZagB69bivb1fbElpQA==
X-Received: by 10.84.217.221 with SMTP id d29mr38507337plj.276.1496965307790;
        Thu, 08 Jun 2017 16:41:47 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:46 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 20/32] convert: convert renormalize_buffer to take an index
Date:   Thu,  8 Jun 2017 16:40:48 -0700
Message-Id: <20170608234100.188529-21-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
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
2.13.1.508.gb3defc5cc-goog

