Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601DDC433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiBWSbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243877AbiBWSbl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352974B430
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y5so3845615wmi.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xe4mMWm75qppTGdTaj8uVSs0xTobaeCr6mEjy+hpChU=;
        b=D2tdb/dmSY9JFZcducWPpFSXHqHLQB7iG58LQSuMNmnPhyaPuv1iC2TdLDROvUHutS
         BAM+YIZMMIUvW9oZTaiD8BMVsXyfEpfDw3CakG4nQF8QVPcZhiozIJMOrExol8euV1FP
         noZr4ATcfWXJA8ysrqwIcnouIhJG7eUr81VQ4IqBFnLqof5V1+dhYVDvR1dMigbCAAI4
         5EiktS0LrAoIkIp4in4zyXDbZrgzFeiArBktyJ2LtYNIEzPzRkR1XMVOx/M301myonkZ
         WM7dW16dFj4qWMvuAySF2ih+WV9F//ZZZ7qxZCzfAl5mVQ7eb9zgyocwA0tXpfU7DrcF
         kY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xe4mMWm75qppTGdTaj8uVSs0xTobaeCr6mEjy+hpChU=;
        b=h6qJrhlX5Yl6j2U4u8aoogIUnMHPXaMSUM5wSsXP9mJd+ozSjazwhIE0RomYpuyAAk
         esFugLNoD2jJ4+0YZYQHDdHCkZYpesnf6UNHYx7TBWFqka55g4oEzM+OAmrel/30tpn7
         Xcbfr4zaUqNZY8NXP29dpzubWiVEc4NOJr2mrKOxVe1QGp4SajLb08s4RfnGJJ0JGn8q
         l/QQ4BwogzdhGQkCfqnT9UR/QyBqBf3E/UsO+bvRFQUxmcGvR/i+E6gC8hfjfu1A544u
         AxWlcA9s2lURW9vkrSwkiIdxQwyZNitZcvFmUFTwiW+iKAeKMQaeZbk4GYqyEryVCkFc
         BWKQ==
X-Gm-Message-State: AOAM531A1N5nX8bk4+AdKJAOEJx8UAiLfkM5B+h5Me7YSwzmLM9xtyO+
        4K1P6CGuQaghfNcZXKQ6Pl3RHL9PG10=
X-Google-Smtp-Source: ABdhPJzDonKwzWh6hntzNBdwZdnJKSHJGXdZqGE71SLxh7LBzveHPffb43zIYqERQ/OgAYc3APqxGQ==
X-Received: by 2002:a1c:4b09:0:b0:37c:522:c736 with SMTP id y9-20020a1c4b09000000b0037c0522c736mr757387wma.145.1645641071453;
        Wed, 23 Feb 2022 10:31:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16-20020a7bc7d0000000b00381004c643asm453535wmk.30.2022.02.23.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:11 -0800 (PST)
Message-Id: <0e19607d5d96308d07ae8df65d48d7f29be0ea50.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:44 +0000
Subject: [PATCH 06/25] http: make http_get_file() external
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This method will be used in an upcoming extension of git-remote-curl to
download a single file over HTTP(S) by request.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 http.c | 4 ++--
 http.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 229da4d1488..04e73149357 100644
--- a/http.c
+++ b/http.c
@@ -1945,8 +1945,8 @@ int http_get_strbuf(const char *url,
  * If a previous interrupted download is detected (i.e. a previous temporary
  * file is still around) the download is resumed.
  */
-static int http_get_file(const char *url, const char *filename,
-			 struct http_get_options *options)
+int http_get_file(const char *url, const char *filename,
+		  struct http_get_options *options)
 {
 	int ret;
 	struct strbuf tmpfile = STRBUF_INIT;
diff --git a/http.h b/http.h
index df1590e53a4..ba303cfb372 100644
--- a/http.h
+++ b/http.h
@@ -163,6 +163,15 @@ struct http_get_options {
  */
 int http_get_strbuf(const char *url, struct strbuf *result, struct http_get_options *options);
 
+/*
+ * Downloads a URL and stores the result in the given file.
+ *
+ * If a previous interrupted download is detected (i.e. a previous temporary
+ * file is still around) the download is resumed.
+ */
+int http_get_file(const char *url, const char *filename,
+		  struct http_get_options *options);
+
 int http_fetch_ref(const char *base, struct ref *ref);
 
 /* Helpers for fetching packs */
-- 
gitgitgadget

