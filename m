Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF1EC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0DC61285
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhEQM0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 08:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbhEQM0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 08:26:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F0C06175F
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k5-20020a05600c4785b0290174b7945d7eso3057530wmo.2
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jm8DwKKeRwrgmlPJOYqnlTtvUko/WwlTnENBi71vOBs=;
        b=fiifZaShk11BhD/62LOhBKg6kaJ+t2kedz5bPf5QfsuL4uPU8ACIX2hhRJZQCcds0r
         wKbHUilf1ssJmT8DeGDOqtyHDXakdVATBEkcvmWpYemtEIPYyqHMdIAxEBzCDSDUW4/o
         MYyzFKpJF6L4aWQL0N1gaL7MCmwK13xZLT2cEQdI/I1ZmKydlm4v8mPCDGZmnClmXKPa
         nkAvPvG7MTGL5WTJ8DeXD2eF5L8n7Z7hdI+TXT6DYVm3nWozgnTb6Dt6N+Q/SQzoqAg5
         TUWEc1wVbrT6Wqa3fSigi8yJwuGOjJmFoOTtMQlx16M/eclyqxznSFwuHuEfEYyaGEC+
         hgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jm8DwKKeRwrgmlPJOYqnlTtvUko/WwlTnENBi71vOBs=;
        b=NGlCLMkdRHMcG7Y/z65gIZAmn2W40/AgfaMmim8lh17gHgXS+sokVSDyStCRADqt3t
         s3AwUA/PQs7cnigbBVgIsw4E/Fr5XRscOdmDPatz2hiUBFSzKU0wyhjCGD+HUAuM1a1+
         kFIqDL4f+7f8S08tT88GIx4ZDu1KXdZZ8W7xq7nV3ruCzkCXPJbEL6EtIfbswuFQ9WDt
         ozrjQTIW3fQ5+XLcbD+FrQilA8myNXBOUsYGqkIGYu0bB52EzaJVN9iFdIPiUjb0Pf8+
         PopbXkNwfgihnACCuZWJNYawoUqj38SK3zJUgvbeEyf2fTMIZDgPChy8qerLy952+E7T
         jFqQ==
X-Gm-Message-State: AOAM533Ncdq4qKtyFoNyBhfU41QfHP4BjMZSEaFs7UxXa+ovgHlVz8So
        IkK8zaeeTD9BuxjOG2BkPJU1kSGWzSQ=
X-Google-Smtp-Source: ABdhPJzs4zr+NazYTd8NwuvmKLQ/6bmddIAo70UeyVzsC6/c8rr/B+xrfqGzvhPW48N0LWrQCRhNbA==
X-Received: by 2002:a1c:b002:: with SMTP id z2mr63889147wme.26.1621254295981;
        Mon, 17 May 2021 05:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm9815701wmj.23.2021.05.17.05.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:24:55 -0700 (PDT)
Message-Id: <4b3814eb4c80617d3b180dd576348a3b2f26b35e.1621254292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
        <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 May 2021 12:24:52 +0000
Subject: [PATCH v2 4/4] read-cache: delete unused hashing methods
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
