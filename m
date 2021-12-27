Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA94C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 18:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhL0S0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 13:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhL0S0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 13:26:42 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F140CC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 10:26:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso11422332wmd.2
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 10:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P9mej/kRRIUcd6PKw6JIvo57wWGtjT2aoUD3G7u0qsE=;
        b=C02E9Qr1n38YJJT4JTIRN6hgB9rF5yOVm3zIZnpl0J66MJLbPuqV99JNDx6cWw38ez
         ITvKlXHEhND805eYiDq+2rAZ5Wn2N1i5coPbub3QgOfm6S3tY25+lUA5EeLHimfAJT6p
         9hOPtb6xLbU747cMzrPXzuB2IUixyqZoKPQtro7d9q0bzJnEbN/rt69zRWQEPaz1BFSn
         8gsJO8m1DBfo2bQzGLGV17Zp9Do0xH874q0emlPSVyOGZ4SBf4kJkGoxBidnlYBQeQBa
         iBGQzzcO7qg7g3VL2TYUImn4NN6kcmU/Z0H/J3iVbrtQKzpxvyyRu5OD3Nhauz1AqZ6D
         ua4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P9mej/kRRIUcd6PKw6JIvo57wWGtjT2aoUD3G7u0qsE=;
        b=IYkdixCKLIzxy2DWBu0OZzj2s7HGA23s9dI2cIZlh0x2tucDHFIPvnPccIv+ROtXrf
         aEcV8Ll5AiL1L8TxIW1Vo1BTZ/jdauj6IOA0gAgfv08XYern19W0G/NnrvIfKNwTNIiD
         FnX1f9Qw2RzZWevXGtfy5ZTWXEkcVEBPbdoo4GMNjZBKkLyh8EKv273Dhnk8m2CKWDAL
         TJ/lPO2BbclJgStxYHuUsAD4UQAZyonUMsxPeWBZ5TG5PbPnIw5drej0dtq5VKNOKfmT
         knl4OEdFcifZ2cgSr8Ed7wksaYgSVgPZJqLAs77L9pN49NgXcu35lfYnpoPKHDx/6I9E
         1atw==
X-Gm-Message-State: AOAM531tr5jxgOLdZ6bCo9ce4J8hHK3iFWeUkgxL/XEvCO3kHrdaLZWA
        xzCmd7yWZBvxdACfGEwEqcHvXVZr8jI=
X-Google-Smtp-Source: ABdhPJy+FfwiOu5KX7G/wZzI0wG9dpXOG7bZ9rNMG+2ACRPZot+P2sWkuXytdCaMlHinBJFcYBK5fA==
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr14183443wmq.144.1640629600338;
        Mon, 27 Dec 2021 10:26:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm15975440wml.48.2021.12.27.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:26:40 -0800 (PST)
Message-Id: <9465c20d4bd398dacbd7df2c068513c9ec484dd8.1640629598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1125.git.git.1640629598.gitgitgadget@gmail.com>
References: <pull.1125.git.git.1640629598.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 18:26:37 +0000
Subject: [PATCH 1/2] receive-pack.c: consolidate find header logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

There are two functions that have very similar logic of finding a header
value. find_commit_header, and find_header. We can conslidate the logic
by using find_commit_header and replacing the logic in find_header.
This helps clean up the code, as the logic for finding header values can
stay in one place.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/receive-pack.c | 48 ++++++++++++++++++------------------------
 commit.c               |  3 ++-
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4f92e6f059d..939d4b28b7c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -581,32 +581,26 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 	return strbuf_detach(&buf, NULL);
 }
 
-/*
- * NEEDSWORK: reuse find_commit_header() from jk/commit-author-parsing
- * after dropping "_commit" from its name and possibly moving it out
- * of commit.c
- */
-static char *find_header(const char *msg, size_t len, const char *key,
-			 const char **next_line)
+static char *find_header_value(const char *msg, const char *key, const char **next_line)
 {
-	int key_len = strlen(key);
-	const char *line = msg;
-
-	while (line && line < msg + len) {
-		const char *eol = strchrnul(line, '\n');
-
-		if ((msg + len <= eol) || line == eol)
-			return NULL;
-		if (line + key_len < eol &&
-		    !memcmp(line, key, key_len) && line[key_len] == ' ') {
-			int offset = key_len + 1;
-			if (next_line)
-				*next_line = *eol ? eol + 1 : eol;
-			return xmemdupz(line + offset, (eol - line) - offset);
-		}
-		line = *eol ? eol + 1 : NULL;
+	size_t out_len;
+	const char *eol;
+	char *ret;
+
+	const char *val = find_commit_header(msg, key, &out_len);
+	if (val == NULL)
+		return NULL;
+
+	eol = strchrnul(val, '\n');
+	if (next_line) {
+		*next_line = *eol ? eol + 1: eol;
 	}
-	return NULL;
+
+	ret = xmalloc(out_len+1);
+	memcpy(ret, val, out_len);
+	ret[out_len] = '\0';
+
+	return ret;
 }
 
 /*
@@ -625,7 +619,8 @@ static int constant_memequal(const char *a, const char *b, size_t n)
 
 static const char *check_nonce(const char *buf, size_t len)
 {
-	char *nonce = find_header(buf, len, "nonce", NULL);
+	char *nonce = find_header_value(buf, "nonce", NULL);
+
 	timestamp_t stamp, ostamp;
 	char *bohmac, *expect = NULL;
 	const char *retval = NONCE_BAD;
@@ -730,8 +725,7 @@ static int check_cert_push_options(const struct string_list *push_options)
 	if (!len)
 		return 1;
 
-	while ((option = find_header(buf, len, "push-option", &next_line))) {
-		len -= (next_line - buf);
+	while ((option = find_header_value(buf, "push-option", &next_line))) {
 		buf = next_line;
 		options_seen++;
 		if (options_seen > push_options->nr
diff --git a/commit.c b/commit.c
index a348f085b2b..616a6780703 100644
--- a/commit.c
+++ b/commit.c
@@ -1645,7 +1645,8 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 		if (eol - line > key_len &&
 		    !strncmp(line, key, key_len) &&
 		    line[key_len] == ' ') {
-			*out_len = eol - line - key_len - 1;
+			if (out_len != NULL)
+				*out_len = eol - line - key_len - 1;
 			return line + key_len + 1;
 		}
 		line = *eol ? eol + 1 : NULL;
-- 
gitgitgadget

