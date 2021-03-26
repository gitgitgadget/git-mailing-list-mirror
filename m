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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6CC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE3861A0A
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCZTM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 15:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCZTMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 15:12:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6D5C0613B1
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:12:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so5434467wmd.4
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fv5nGzpLYHBZEOxzEU5r40MRGAXCxX6gBAQ6oQCO0Rg=;
        b=mh2Y8/bHX6Ftvr9T0LFNG0G93hWHtLljAyfnBA/WeDNbXdcjRUM+ROEm/Sdtfu6Fti
         0zNq2KmO5q7vnJBQTsozEYYnAgQAtr9mJROxOU9vMXIfBzlXTjU+XJ2eWYYzD6sY/YQH
         FfT0BGXjaq9VsEdfFQJrO2R2hstXCUwWpZ6kjL9r2aRUnC6/hFjOrJ+1geAXYf7YZwZc
         J6hX6hB4UuyPPbVxdMf9hqs33B3ZXqI6+Labj+VHMkLUu6kIPZIsJLyhPsHgW5SAqIly
         mgX4ER8UBtvpaVYNTC96miAvSvaEr4/apl+OAqqNxqIlh54kcg9xflXG56TjqCCPVui7
         xoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fv5nGzpLYHBZEOxzEU5r40MRGAXCxX6gBAQ6oQCO0Rg=;
        b=JH4zc/z7rWfVEwOoNeDVZzKKkxngZ0FhcrzS41WzNS+gByE1wHabC2NpT2tWJtarA3
         LEVy2SJQ6NLxiUbhEJ80NHocpMOt5dzX+nYPih6X898fUIFK1Ugv0FK/st39sH8x5AFd
         ibAhTBR0JE5rBHtIsgsfJNX7F1487Wf1NLstPwbzukxwR51+80BJiV+76lJ9JaTAqtWs
         wjkRCB43cW0k8Mz5bpnCtQA7CyaDXhp51PMe924A2pai+u/SfCxc9eadqsq2vzA4NMri
         DByaz12sxLKYp/z6cMRHEcTLyG5zcQO7ZQneCvYgznURZd7xQiyhzhf1wJwGCJ2xT7Vs
         H/dg==
X-Gm-Message-State: AOAM533hU9AWEmqASJgvulxvo7sS79JIcY/abHswDF5fviLuYBbGl+zy
        K71tW7CNpHNs9OhifiqKMoBZx7eGORs=
X-Google-Smtp-Source: ABdhPJx7D8WDb50MhHYBjcp+hww5E4xfF0BnSyQGtL1ejqDSL+MauoNDkDMegOTQTjHedxsnfXcWnw==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr14253795wmq.141.1616785931862;
        Fri, 26 Mar 2021 12:12:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm13169384wrs.68.2021.03.26.12.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:12:11 -0700 (PDT)
Message-Id: <e2d5a8dc919be7d4529157032bc6cd5e61482c9b.1616785928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.git.1616785928.gitgitgadget@gmail.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 19:12:07 +0000
Subject: [PATCH 3/3] read-cache: delete unused hashing methods
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
index b9916350f331..3f3f2e01b9a2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2467,46 +2467,6 @@ int repo_index_has_changes(struct repository *repo,
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
 static int write_index_ext_header(struct hashfile *f, unsigned int ext, unsigned int sz)
 {
 	hashwrite_be32(f, ext);
@@ -2514,30 +2474,6 @@ static int write_index_ext_header(struct hashfile *f, unsigned int ext, unsigned
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
