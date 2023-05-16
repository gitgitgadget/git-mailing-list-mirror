Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3612DC77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjEPRJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjEPRJw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:09:52 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D0B3A99
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2532c2c41f7so470660a91.0
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684256991; x=1686848991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3vT97uSeoH935qNYgrw0g8pV/dI3A84VsaaxyWqLok=;
        b=QA2/Omif02pTdRt6+ii7KyR9TOxSNeIbTg6NWsmZW529cwN3FWZbp6aRX3xnOTtK+Y
         hjihn1/kyrYKjyVVCPiMLKUyZnmSD0ewPWrXmj7Pc5psvRBH1ATy8dddjOsm88lWocer
         2zG4FXKSz6AJvZ7kKJVDggm+yrohu1BDIWWFJOrbCoBs+BOQN1ZcPdSBKa2wig5RDfht
         GvljNNpJ4dczdUNUCT6/vXMsX8bHcZYuG51acHv/m03xdt3BILH28oryRYCSfmAepBer
         AzNsUyVuXBnZOtr7c2ZnuRKQCQumOlaGptNhiwL17xvepX8d2zX1g27sznXbkgU2mdhn
         tD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684256991; x=1686848991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3vT97uSeoH935qNYgrw0g8pV/dI3A84VsaaxyWqLok=;
        b=kHLQRIRgo6nbNd9KOF3IaHQUjlZaPcHBadDkeZZCGJbcqzDAhonlcC72bUM+xRRONn
         M1bOslEDgbYvdMzNbBh+HuEFhgrkximqwi2KwoEne3XQxIRmKlktx1YpGskvdAD7/P/y
         8BNW/7xSkAt3gh8c418WnGP0Why5/flGXltzn6qPT7TWO+8MlebAXn1StFabQc9C0/Sd
         8snZMuY+L2qb0iPsHnTYXY1lktAndK8d55qnj9ouJs09KZxCTGp/jZjxNui2FPbguDex
         jtqOan0vTW4R2J1oK8nMFC1J7S+oLH+Kx/mIlpm+NVIjn1Q2deT2qsE4PW7FBhCLgop7
         Lj/w==
X-Gm-Message-State: AC+VfDxhhQ3WGIFEaD+E5/k0uPGASEsEskFN2XNuWLIGfcLfJlvX2uFO
        YlrNXK/YjJWkhLJX0RV+l1rOjAidssFFFk3GtQQvE74PkmTrvtJudtpdvI7Q+HcGDUbmgA1VGTq
        /tBYE/QL3akBS326WqSNBwlT6rHfxpsokYzb45SKgk6uGzP5U6hXOQ3xoXF8/OfikGQ==
X-Google-Smtp-Source: ACHHUZ4WPkP5jSmP5rHc0jDQsI9Zd/RYs7mPsYDc5hfRSJrE6c0HZDbADhn19o8+0BFbM/qNVgCPOKGZOGxqYbY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:fa8b:b0:24e:4c73:e732 with SMTP
 id cu11-20020a17090afa8b00b0024e4c73e732mr10761697pjb.0.1684256990674; Tue,
 16 May 2023 10:09:50 -0700 (PDT)
Date:   Tue, 16 May 2023 17:09:26 +0000
In-Reply-To: <20230516170932.1358685-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230516170932.1358685-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516170932.1358685-2-calvinwan@google.com>
Subject: [PATCH 1/6] strbuf.h: move declarations for strbuf.c functions from git-compat-util.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While functions like starts_with() probably should not belong in the
boundaries of the strbuf library, this commit focuses on first splitting
out headers from git-compat-util.h.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 git-compat-util.h | 32 --------------------------------
 strbuf.h          | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5b2b99c17c..51af0a53aa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -679,9 +679,6 @@ void set_warn_routine(report_fn routine);
 report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
-int starts_with(const char *str, const char *prefix);
-int istarts_with(const char *str, const char *prefix);
-
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
  * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
@@ -710,29 +707,6 @@ static inline int skip_prefix(const char *str, const char *prefix,
 	return 0;
 }
 
-/*
- * If the string "str" is the same as the string in "prefix", then the "arg"
- * parameter is set to the "def" parameter and 1 is returned.
- * If the string "str" begins with the string found in "prefix" and then a
- * "=" sign, then the "arg" parameter is set to "str + strlen(prefix) + 1"
- * (i.e., to the point in the string right after the prefix and the "=" sign),
- * and 1 is returned.
- *
- * Otherwise, return 0 and leave "arg" untouched.
- *
- * When we accept both a "--key" and a "--key=<val>" option, this function
- * can be used instead of !strcmp(arg, "--key") and then
- * skip_prefix(arg, "--key=", &arg) to parse such an option.
- */
-int skip_to_optional_arg_default(const char *str, const char *prefix,
-				 const char **arg, const char *def);
-
-static inline int skip_to_optional_arg(const char *str, const char *prefix,
-				       const char **arg)
-{
-	return skip_to_optional_arg_default(str, prefix, arg, "");
-}
-
 /*
  * Like skip_prefix, but promises never to read past "len" bytes of the input
  * buffer, and returns the remaining number of bytes in "out" via "outlen".
@@ -777,12 +751,6 @@ static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
 	return strip_suffix_mem(str, len, suffix);
 }
 
-static inline int ends_with(const char *str, const char *suffix)
-{
-	size_t len;
-	return strip_suffix(str, suffix, &len);
-}
-
 #define SWAP(a, b) do {						\
 	void *_swap_a_ptr = &(a);				\
 	void *_swap_b_ptr = &(b);				\
diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c..5e6f7f3d8e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -727,4 +727,36 @@ char *xstrvfmt(const char *fmt, va_list ap);
 __attribute__((format (printf, 1, 2)))
 char *xstrfmt(const char *fmt, ...);
 
+int starts_with(const char *str, const char *prefix);
+int istarts_with(const char *str, const char *prefix);
+
+/*
+ * If the string "str" is the same as the string in "prefix", then the "arg"
+ * parameter is set to the "def" parameter and 1 is returned.
+ * If the string "str" begins with the string found in "prefix" and then a
+ * "=" sign, then the "arg" parameter is set to "str + strlen(prefix) + 1"
+ * (i.e., to the point in the string right after the prefix and the "=" sign),
+ * and 1 is returned.
+ *
+ * Otherwise, return 0 and leave "arg" untouched.
+ *
+ * When we accept both a "--key" and a "--key=<val>" option, this function
+ * can be used instead of !strcmp(arg, "--key") and then
+ * skip_prefix(arg, "--key=", &arg) to parse such an option.
+ */
+int skip_to_optional_arg_default(const char *str, const char *prefix,
+				 const char **arg, const char *def);
+
+static inline int skip_to_optional_arg(const char *str, const char *prefix,
+				       const char **arg)
+{
+	return skip_to_optional_arg_default(str, prefix, arg, "");
+}
+
+static inline int ends_with(const char *str, const char *suffix)
+{
+	size_t len;
+	return strip_suffix(str, suffix, &len);
+}
+
 #endif /* STRBUF_H */
-- 
2.40.1.606.ga4b1b128d6-goog

