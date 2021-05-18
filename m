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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA52C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD65861285
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351609AbhERSeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351629AbhERSeM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 14:34:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97564C06175F
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso1441301wmg.2
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jm8DwKKeRwrgmlPJOYqnlTtvUko/WwlTnENBi71vOBs=;
        b=Ic+M9d/73rAbzv0YRVvSYWp7PPaP1yX7d13bqtqi9DpUijMx9OC8Qi4ZSBnhfLAG9v
         xXK9CMCppes069HsCT7lKz0w9tTmYj2BJqfv+FSxQCy4vV6spazG5Vo986NUDL3EfHeD
         rwcJN5OiTZ3FP5H//DGeo9flveMjlu3f6oaQaZicHF5RpmW8fYTptSi1PJgjAE7dCSFj
         9HquENt04dj/ppmgQynRJXVUFwheX1Db51/hbmK5625U0MiW9A/9bZkhSntU6KqA5asY
         uF14pwxmKWNqT1aJIsfj99NFcFOu0tsYaYMPkoMNTIZCQ4V3SOFBNeN8rUCOFYCOlzNl
         z/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jm8DwKKeRwrgmlPJOYqnlTtvUko/WwlTnENBi71vOBs=;
        b=VIdGR1okMYqaMnmSttVKTQpChlZHC4CXZsyOCjnBdn4n1Eyzd1r6nij6vPnUjcAfee
         YdvAOeNjpzS9MTVzi6GgN79LsuL2bEgMnpse8dRLeQyRFvqWBk19v/1eiNNdJFo1o10r
         OZhUyCKce0cH4kLEGZGTm9Bk9lmNP3/lL8iQ+UNWj9BRHfz5oK/NpgeWHC/jDavsb1qJ
         jcN/k/lSy8RqrYY3yR2hpX2vTUwiZ8ERo00tmPBlGm5lK6GdLv+RyUORfWVLhEOGrl0Y
         utoETqfa/BwzfeAIV6GNSDjjrXUEcS9VKlf5BuZjiJFHqwZiu1hV2/gzPm9+TvwZlNKj
         +x0Q==
X-Gm-Message-State: AOAM530B5ID6Hhh7bSiQwXj8LffxKFN2bKU6gIKTJ8gBdmuTI+KmRgwJ
        juCu/cpxMpanzMZp1b89swzPZKyZk8I=
X-Google-Smtp-Source: ABdhPJzA4hlHhl5m0EIvbBuHLW01H2okP8W2Cyi0Yw3lW7aj5Y5G8v0CB4gezCygwl7vg/cp+BanMQ==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr6377881wmq.137.1621362772381;
        Tue, 18 May 2021 11:32:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c22sm18745062wmb.10.2021.05.18.11.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:32:52 -0700 (PDT)
Message-Id: <42fb10fb29982fa828c1ae819a9a1379b41cbd5e.1621362768.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.v3.git.1621362768.gitgitgadget@gmail.com>
References: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
        <pull.916.v3.git.1621362768.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 May 2021 18:32:48 +0000
Subject: [PATCH v3 4/4] read-cache: delete unused hashing methods
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

These methods were marked as MAYBE_UNUSED in the previous change to
avoid a complicated diff. Delete them entirely, since we now use the
hashfile API instead of this custom hashing code.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c | 64 ----------------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1c0bda81e7e7..aa6751c6a092 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2516,46 +2516,6 @@ int repo_index_has_changes(struct repository *repo,
 	}
 }
 
-#define WRITE_BUFFER_SIZE (128 * 1024)
-static unsigned char write_buffer[WRITE_BUFFER_SIZE];
-static unsigned long write_buffer_len;
-
-MAYBE_UNUSED
-static int ce_write_flush(git_hash_ctx *context, int fd)
-{
-	unsigned int buffered = write_buffer_len;
-	if (buffered) {
-		the_hash_algo->update_fn(context, write_buffer, buffered);
-		if (write_in_full(fd, write_buffer, buffered) < 0)
-			return -1;
-		write_buffer_len = 0;
-	}
-	return 0;
-}
-
-MAYBE_UNUSED
-static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
-{
-	while (len) {
-		unsigned int buffered = write_buffer_len;
-		unsigned int partial = WRITE_BUFFER_SIZE - buffered;
-		if (partial > len)
-			partial = len;
-		memcpy(write_buffer + buffered, data, partial);
-		buffered += partial;
-		if (buffered == WRITE_BUFFER_SIZE) {
-			write_buffer_len = buffered;
-			if (ce_write_flush(context, fd))
-				return -1;
-			buffered = 0;
-		}
-		write_buffer_len = buffered;
-		len -= partial;
-		data = (char *) data + partial;
-	}
-	return 0;
-}
-
 static int write_index_ext_header(struct hashfile *f,
 				  git_hash_ctx *eoie_f,
 				  unsigned int ext,
@@ -2573,30 +2533,6 @@ static int write_index_ext_header(struct hashfile *f,
 	return 0;
 }
 
-MAYBE_UNUSED
-static int ce_flush(git_hash_ctx *context, int fd, unsigned char *hash)
-{
-	unsigned int left = write_buffer_len;
-
-	if (left) {
-		write_buffer_len = 0;
-		the_hash_algo->update_fn(context, write_buffer, left);
-	}
-
-	/* Flush first if not enough space for hash signature */
-	if (left + the_hash_algo->rawsz > WRITE_BUFFER_SIZE) {
-		if (write_in_full(fd, write_buffer, left) < 0)
-			return -1;
-		left = 0;
-	}
-
-	/* Append the hash signature at the end */
-	the_hash_algo->final_fn(write_buffer + left, context);
-	hashcpy(hash, write_buffer + left);
-	left += the_hash_algo->rawsz;
-	return (write_in_full(fd, write_buffer, left) < 0) ? -1 : 0;
-}
-
 static void ce_smudge_racily_clean_entry(struct index_state *istate,
 					 struct cache_entry *ce)
 {
-- 
gitgitgadget
