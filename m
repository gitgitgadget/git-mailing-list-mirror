Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E3DC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbjELRPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbjELRPh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:15:37 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED715BBB
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1ab0f01ce43so97528895ad.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683911735; x=1686503735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=frkXVvp6yG2x745+Lt+a4pQaSaIgvbG38H+8YGuxcbk=;
        b=dP/uockKVD3Hfphd0gDrPer7y9HyTRUc/aDCMbsTOUuImP3odvuxhNzxy7osWPNUEc
         uyymn48Wjq6XRXnRsSsEYgVz95+KgDCgNuTzj2pmQTVSKjxzRfIry1og2LbngiqbVkp9
         72XGVN/7bqxAXtPUNF0H+ww+HsHgy+bph4ZBIGvOeYc1b2ytfvyAvCmisy4BlkXeGdyX
         Y1kI3SjLSZu+9M+IVkjY7Fj+M+cwgs9H9LgTWaRcg99oPq86bYkcDMLAgovv7DoTNZD3
         kbhPz/obcxF7UXxQxcubIe7PV3Z8Wzj5XP+234Hp7rZItkOXpVqD423LXf0Ws1Y0wNCJ
         tz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911735; x=1686503735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frkXVvp6yG2x745+Lt+a4pQaSaIgvbG38H+8YGuxcbk=;
        b=a004u8iXU8d+vMt+0Ho9ItKFtj7WLyW+TbIQ7RHTDDlf7R59FqJQXo+kprZ7BbuhS7
         no45KPnXl+DSb6hJXRq+2MOPhgLLWlrMIE0jZMrAyk4cNQf6GfHh5kughND/j4J9uQPu
         Yfr3I6ophJgpHB0YuGI6e88TT+qIOUJ1DAcmvtVnHkBQ8rtLH9jXRrty1rDtijVtmzhN
         To3XMUTOsW2FMMXgqt6eOjccZj/JF1wVbT7GaGigGyCzCBtYXPBQL81Wu+b/WPGiBKKk
         9zQQKDZxHJNB97Uk0rEhNbUCb1JCme9wjid21B/M4kBTVyJV/Sfvo8wp3wVkO1ktl4bY
         /KvA==
X-Gm-Message-State: AC+VfDy2CcuRSxw0DfeegnfZAR6OZY7ZiyXUZJsAhr1R2P/IbzJvH+mq
        +ILq7LoTA1dVd6LnvwLUl1rJnY9d1wu8SQ4beUpixU97XSF8kRWkx132eXUj7UNmcVq8pQ53VK1
        RL6xaHUMREholGB9QuGRDVfnx4I0TbFbi6noYB44nVg64jUyrPEfSsOq+mAnJ2cnN5A==
X-Google-Smtp-Source: ACHHUZ752AyhdQbJlWKakI/uullT/zRwqxVhyxY0GScMtnh0VpTTHs5if+N5dyHSVhXmSTVz05+HVGVJh3b0d1I=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:32c4:b0:1ad:c749:9c9f with SMTP
 id i4-20020a17090332c400b001adc7499c9fmr2209539plr.9.1683911735200; Fri, 12
 May 2023 10:15:35 -0700 (PDT)
Date:   Fri, 12 May 2023 17:15:14 +0000
In-Reply-To: <20230512171429.2202982-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230512171429.2202982-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512171516.2203472-5-calvinwan@google.com>
Subject: [PATCH v6 5/7] path: move related function to path
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move path-related function from strbuf.[ch] to path.[ch] so that strbuf
is focused on string manipulation routines with minimal dependencies.

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
2.40.1.606.ga4b1b128d6-goog

