Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BA5C7EE24
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjEHQ7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjEHQ7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:59:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7D75FE2
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:59:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba2b9ecf90aso3012328276.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683565188; x=1686157188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEQNl5dMg2xRh6C9SxOl+it4k4XCRhsP1yoUSnxmOcI=;
        b=FBn4rILQqlvGsc/n6x+6o/L/PBiC35XE1BCwY2PDYd5vWhItRrcIKuHfqcqsS4R/pp
         qXQn73Pp7p6GHfoIrtpqa2Z/Q3uji80P8DPdUo8M/Re1Pq02rpqr4j3PgB5jOH3rI9EW
         QlIGljjIq9WYeRLBSn20g8+0ei6QYMQy3WAuajs2isyWJvPx/tuC8brCMrrUxHp89hXY
         VoKSfthMJpmu5ePJa5FiliEYnU17R05KUmeyKjILIE1dz/k9J11fvmbWFUUUJRvZDjnS
         MWOGvho1W7BtmXjnwyZGb3IWf+3bmAcDJFxWyweQC6dXres8LjygOFvRplZxrQSTTSBU
         kJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565188; x=1686157188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEQNl5dMg2xRh6C9SxOl+it4k4XCRhsP1yoUSnxmOcI=;
        b=Wzy6qHgi6VRIYWDMMh3lDaxf6oH8jiY5gWcJTA9SFDcFh1O25Toeq+mEcEnWXWroZb
         4Bt3XRzXbXneuvGs1ZO47W9cUg9ejYSJneshjlwCW/vLmnJaQmHfoUEn7Cy9x4LtVx9T
         f3/7Ng1CByqrZYVDZW/WQqnZXwcNdNH6PmNG8kSTKWswRI3t+fhNFleFaUKCH0Ec7+pl
         V7DBNYW5Oc73rUxOw+iSQewLw2wltg6J8btvAlKtM8NZOKtjdA6XkxuePO963+1MVp0P
         yMhhk35Sgws8YDgNqHTJc52pGlemVdGgUtPfGZaoLxJMW0iFf2kO8f0QOwOLoN291Ajz
         LsHQ==
X-Gm-Message-State: AC+VfDyWXIhPApcIzMOAmv/w94bOCt6zFPj4AIqx7ZaNUIbE9vipecc+
        Wd/c9qKHxsCAev9A8hO2XZjHGwh5ClaK0RQ5rvqNOwUOW8Z0ejlUc5G1SvM3O0mIH1XFZh/qBMG
        mY8Ovmip2YF+ai4f/oE1gv/8msj41rP4Y7rSNQ/xtGQoskE82onBKIGzj2ugycR4gbw==
X-Google-Smtp-Source: ACHHUZ6pwzAP1rfYT1I3boOB0He43Q5tqc7OoGtoNJtP/QnpMcdOre3vixhAd/QyuRVMIsFH6lSAkwyuOvJc9yA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:9bc1:0:b0:b9d:b399:64b0 with SMTP id
 w1-20020a259bc1000000b00b9db39964b0mr6806250ybo.10.1683565188152; Mon, 08 May
 2023 09:59:48 -0700 (PDT)
Date:   Mon,  8 May 2023 16:59:06 +0000
In-Reply-To: <20230508165728.525603-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230508165728.525603-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230508165908.526247-5-calvinwan@google.com>
Subject: [PATCH v4 5/7] path: move related function to path
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
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
2.40.1.521.gf1e218fcd8-goog

