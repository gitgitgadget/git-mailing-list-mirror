Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B60AC7EE21
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjEBVP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjEBVPS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:15:18 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A63172E
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:15:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5187bd3d365so3671702a12.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683062113; x=1685654113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=blPuy068KbCa/kBlsh1bbC+7NivqEcNJMDd5EPhUY9Y=;
        b=a6AAC151CMJta71W7pzGJ/cjvSUd01sKvayd6rQBvZeo7ZsuVrbxXl/FocxdxK2JMh
         cKV5R71ro4tsHJtMZwNDC4AkBbLPajRIEN1ADd2OqRxZ+X6yyxuv7r/Gb1skBpLgaWQg
         51M9e/Q/GAzbjlJOU/vQfhis5JAfNS1jkYX7H9BjWggxOLBGCx2lWkWLiBcXeC7UAk5w
         kKAHGDCe3tZi1kjcEnv+FmxQQCdgkpz7cV2Y2jAN8bz+WDhEJEDQVneTaxDgyjzRXMAE
         ZiJ3uweKRlgUabB0ESRlaKuX+TUxFh/P7kgimfp0BN+W8U1K/WYc1dJ/UHpoxrRrsBI0
         UO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062113; x=1685654113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blPuy068KbCa/kBlsh1bbC+7NivqEcNJMDd5EPhUY9Y=;
        b=NwhIno2bWZ7ygmDM8R2Yeas3egn/99T3aCeyt+kvuxp0uwPrt7jXXZs5ZgCNLAjZ+r
         NZbgJzGjk8mXcBzQiz3JUKukHEkG6TbIvMIUC2vGROqCManNrKcB8ep52vmsE0JCnPyR
         icnmw5r2vNMfvESNHa88ElxMd+XybyQG62bvyVYY3x8QqY7lTNnrryAhIJaW2ht93/TQ
         eIK9KNxioXe9Sept/DDBHa9L8GA5HCAP+9lvUG6YzxwrayS4C9ZUdYTKDlzpe86YkZ3h
         6mPIHCObuDQFPwPaQHlhui+LH/JoRwqP1O+GD6pZY2KXW9Bz0+hR3bJStmb2LRybAjrq
         yw1A==
X-Gm-Message-State: AC+VfDy38cvddi2bT5qrZy4bKPfR9FHtydG+gQeHU/Zrqan8XvRYAvkn
        vrb8+G4yefHkqAjeYUmBV+YdnBXvL/FswX4TPA5lOS9czQDj8fxwbTSAMFz98u/4yKVXMMvnk3a
        WalHSkxbWKFU6MCecA2MwPYYA4ZoxPjUj5EJn/APYGBFYR7b00KoNZsL67+7SzzcIdQ==
X-Google-Smtp-Source: ACHHUZ6XpsqtehgMgi6mHYBTKVSS6Nf/pD66CM8B6pKe00TJuh6B8glVpzUPI+triX/PpqkwxqyIEnFEgAWUM6c=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:2884:0:b0:51f:e94:f15a with SMTP id
 bs126-20020a632884000000b0051f0e94f15amr4713397pgb.5.1683062113103; Tue, 02
 May 2023 14:15:13 -0700 (PDT)
Date:   Tue,  2 May 2023 21:14:52 +0000
In-Reply-To: <20230502211454.1673000-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502211454.1673000-5-calvinwan@google.com>
Subject: [PATCH 4/6] path: move related function to path
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move path-related function from strbuf.[ch] to path.[ch] since it does
not belong in a low-level library.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 path.c   | 20 ++++++++++++++++++++
 path.h   |  5 +++++
 strbuf.c | 20 --------------------
 3 files changed, 25 insertions(+), 20 deletions(-)

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
index 6533559e95..178d75f250 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1088,26 +1088,6 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
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
2.40.1.495.gc816e09b53d-goog

