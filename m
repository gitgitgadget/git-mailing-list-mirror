Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C3C7EE37
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 19:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbjFFTs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbjFFTs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 15:48:57 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CEB10F1
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 12:48:55 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-65297b2ccc6so5299788b3a.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686080935; x=1688672935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlZZ/zhPaT5qoIadbzJMRlj8FQbinMfECChGVXvG4Wg=;
        b=HPfO4FTSJKLl40zvkdm8tInfvqYgpit77UYNPKr6Vqgzq7+orvzxbnrtPfqUfSU015
         /hEHtDE2Jia09usZJlesYD1tT/COeC1EAWv9nkDKqzFP/ydxGYG3YCa1Fii/cj23mRxk
         VcNKB+8vbFvVrP2q3JZwLSuFkCyoNRXdI71F9RPYfcarpft5V8vVcBrlpEPpbxkI6yGQ
         m12i6BYXVYNFnlOEXuJ7mt7eiqtblBdQJk/+moYEk5IZol5r0/oV6VQSVgxAI2QpDXle
         MYBECiQbsSAQWqfUyuxQZ+vwwCv558RZ0RqKD3ntDhiYaKgtGFVsXGX//qIl76J6FKDo
         gHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080935; x=1688672935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlZZ/zhPaT5qoIadbzJMRlj8FQbinMfECChGVXvG4Wg=;
        b=X21ZUHxG3bIMHVOoiQPbX07bL/wfkkPHVJ4SO66FCKcbFDmkeNSzFpW1T7xzRlsN8H
         1s7+f0N4bTnfa0dScOLlqNJE9UlWXZNfSLLxPkK4WCIIMZVp4mDZ11yBRzMDmnY/ln54
         HLcv+n1ecNLlywpRqc3P69jA8sJbLO2bHm9tkiGpdBDU+4Pn4BOokQqixlsrU8oLmQm8
         EIlPbMBpqx4rY2avKcLshZGB6dhyMbDO4LdJkkLYFIwjuRs7y1SPS1fxA0fRCaz7oqQZ
         SO9yrplUg1Y+YVrX58NLEtJro4oAtklcpUbLC69y1FB7aGvPlvZZzSEpeIKG1Cafjzlm
         DS9Q==
X-Gm-Message-State: AC+VfDzI11My937xDqAFOe1YJP6SuB4k8eG05pX70WnlzDlrIn8xTYpJ
        K0/g8J5zl/RO7LNrttQOBvw86Ikg9vRL1KXpSZylr7rEJ9gG1NibZq8JFm5foam6421UHGYGx4t
        ZKJ4LPTb448mDxATY65Oe1w3QTSKQQVJGfGo1qq8OYVXNAWtdcutz4vv39sRvffUq9w==
X-Google-Smtp-Source: ACHHUZ59AduhcgZI9ibxpNOQYpxUDis3x/R30bGs6aHKBj2AqTzQp5HrMQkDblwfw34kYQefGz2+De1zkf19p28=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:13a6:b0:657:f26e:b025 with SMTP
 id t38-20020a056a0013a600b00657f26eb025mr1365867pfg.6.1686080934913; Tue, 06
 Jun 2023 12:48:54 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:48:42 +0000
In-Reply-To: <20230606194720.2053551-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606194720.2053551-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230606194843.2054314-6-calvinwan@google.com>
Subject: [PATCH v7 6/7] path: move related function to path
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move path-related function from strbuf.[ch] to path.[ch] so that strbuf
is focused on string manipulation routines with minimal dependencies.

repository.h is no longer a necessary dependency after moving this
function out.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 path.c   | 20 ++++++++++++++++++++
 path.h   |  5 +++++
 strbuf.c | 21 ---------------------
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/path.c b/path.c
index 7c1cd8182a..e17a2613c5 100644
--- a/path.c
+++ b/path.c
@@ -1213,6 +1213,26 @@ int normalize_path_copy(char *dst, const char *src)
 	return normalize_path_copy_len(dst, src, NULL);
 }
 
+int strbuf_normalize_path(struct strbuf *src)
+{
+	struct strbuf dst = STRBUF_INIT;
+
+	strbuf_grow(&dst, src->len);
+	if (normalize_path_copy(dst.buf, src->buf) < 0) {
+		strbuf_release(&dst);
+		return -1;
+	}
+
+	/*
+	 * normalize_path does not tell us the new length, so we have to
+	 * compute it by looking for the new NUL it placed
+	 */
+	strbuf_setlen(&dst, strlen(dst.buf));
+	strbuf_swap(src, &dst);
+	strbuf_release(&dst);
+	return 0;
+}
+
 /*
  * path = Canonical absolute path
  * prefixes = string_list containing normalized, absolute paths without
diff --git a/path.h b/path.h
index 60e83a49a9..639372edd9 100644
--- a/path.h
+++ b/path.h
@@ -191,6 +191,11 @@ const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
 int normalize_path_copy(char *dst, const char *src);
+/**
+ * Normalize in-place the path contained in the strbuf. If an error occurs,
+ * the contents of "sb" are left untouched, and -1 is returned.
+ */
+int strbuf_normalize_path(struct strbuf *src);
 int longest_ancestor_length(const char *path, struct string_list *prefixes);
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
diff --git a/strbuf.c b/strbuf.c
index 80b7e051cd..d5978fee4e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -3,7 +3,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
@@ -1089,26 +1088,6 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
 	strbuf_setlen(sb, j);
 }
 
-int strbuf_normalize_path(struct strbuf *src)
-{
-	struct strbuf dst = STRBUF_INIT;
-
-	strbuf_grow(&dst, src->len);
-	if (normalize_path_copy(dst.buf, src->buf) < 0) {
-		strbuf_release(&dst);
-		return -1;
-	}
-
-	/*
-	 * normalize_path does not tell us the new length, so we have to
-	 * compute it by looking for the new NUL it placed
-	 */
-	strbuf_setlen(&dst, strlen(dst.buf));
-	strbuf_swap(src, &dst);
-	strbuf_release(&dst);
-	return 0;
-}
-
 void strbuf_strip_file_from_path(struct strbuf *sb)
 {
 	char *path_sep = find_last_dir_sep(sb->buf);
-- 
2.41.0.162.gfafddb0af9-goog

