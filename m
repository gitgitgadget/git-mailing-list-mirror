Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA676C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8228661166
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbhDSLis (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbhDSLic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679DC06138A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e5so4998327wrg.7
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=74UCjTszC/JW9ZVjbpc5onRZS13S1spFDA7Rwrv0XpE=;
        b=rMrgzUMx4/VOZmgSM74H+Y+QmK4TnlNWHcopOt4G+KHKFSFaFsNf+aUREWkNCkHTqo
         i9kKm1nSVQN2Pm5wl0a4uk1X3VVlGiP8uabUaWA8A6WIJtnbeJqk6Ox5kVzyag8/8hAd
         dHTw/meftUoo5aICgpc6fyl9HPfTlB7/6B8EaCAjE25eN6ElWtT72L7VkADrblov8sSm
         9+loTKgjSg7TtbqMnemH2jxdrzY6sBYSz4eTHMLMFhNiW+xH75ty7mmh5Mahm8hn7mUa
         vtGH8jtVFPqR6DpgoLjNlk/0U0cxUm+QnKSo2oyShW4YkfbYiK5gl43U4a6/5Acb9tpJ
         2xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=74UCjTszC/JW9ZVjbpc5onRZS13S1spFDA7Rwrv0XpE=;
        b=SVBNmpEFB50J5IgKJ47MhpP7ahlT2caUHqpPy4d8XDjz2gTXVaHPVSLJSaipuqguc8
         CrHOzGvGJwB4R7poGDgYrp+gen59EQP9WzLjzjd7qbHeVtOVF6RNAL0SQf8DquUuX8n1
         1yaGwDbki8fvu7pBMgGiL87i3earxgG4tRFz9OfBdDmEhXf4rPukV11kgZq1we+wZYo+
         To+xy9UrOwEN5JcdHbfLt2u9q71nl3hC9AmUBf7DY/tWRlJURmSalPHTiYgGW6KyH/dW
         5kfmzcT78k4JMLqt+8QA91BBga83GmJ4j/ze4RX8n8U/zhuRqpCA6FTGmsjoqdlK6uxj
         WtTA==
X-Gm-Message-State: AOAM530zXNUuWhs3t8kZYNhAO6GpSnBm+yPe8GPfoPycWK44GEaouj4k
        /eul7BUs076/q5niWoviYkwU3FVt7zw=
X-Google-Smtp-Source: ABdhPJzJgd3AXDec2WNy+zWCoVOd4NHJ2AtZMocoyiQWXQwNqRZBnZMWf+TV2y416yTu6Lao91Zp8w==
X-Received: by 2002:a5d:4b12:: with SMTP id v18mr14035687wrq.45.1618832281770;
        Mon, 19 Apr 2021 04:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12sm23572695wru.47.2021.04.19.04.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:01 -0700 (PDT)
Message-Id: <f0216ae20b6988514bdb60d8fff96e18c2ce9f1d.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:32 +0000
Subject: [PATCH v7 04/28] hash.h: provide constants for the hash IDs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will simplify referencing them from code that is not deeply integrated with
Git, in particular, the reftable library.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 hash.h        | 6 ++++++
 object-file.c | 6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hash.h b/hash.h
index 3fb0c3d4005a..b17fb2927711 100644
--- a/hash.h
+++ b/hash.h
@@ -161,12 +161,18 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 	return p - hash_algos;
 }
 
+/* "sha1", big-endian */
+#define GIT_SHA1_HASH_ID 0x73686131
+
 /* The length in bytes and in hex digits of an object name (SHA-1 value). */
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
 /* The block size of SHA-1. */
 #define GIT_SHA1_BLKSZ 64
 
+/* "s256", big-endian */
+#define GIT_SHA256_HASH_ID 0x73323536
+
 /* The length in bytes and in hex digits of an object name (SHA-256 value). */
 #define GIT_SHA256_RAWSZ 32
 #define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
diff --git a/object-file.c b/object-file.c
index 624af408cdcd..5af384a8cfc4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -146,8 +146,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 	{
 		"sha1",
-		/* "sha1", big-endian */
-		0x73686131,
+		GIT_SHA1_HASH_ID,
 		GIT_SHA1_RAWSZ,
 		GIT_SHA1_HEXSZ,
 		GIT_SHA1_BLKSZ,
@@ -160,8 +159,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 	{
 		"sha256",
-		/* "s256", big-endian */
-		0x73323536,
+		GIT_SHA256_HASH_ID,
 		GIT_SHA256_RAWSZ,
 		GIT_SHA256_HEXSZ,
 		GIT_SHA256_BLKSZ,
-- 
gitgitgadget

