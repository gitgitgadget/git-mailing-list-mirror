Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F161C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C9E610CE
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhDLVKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241910AbhDLVIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94EFC061344
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id 12so14339263wrz.7
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=63cgv+d6hF7bJxk9XJMcdXLWzyM+y2aIDW1QZ5VUN1A=;
        b=CaJlVQ8XsDfLToS1PTrzgyp6IP9SWAFmvFjEfmBye8imCRiG3ZEo7S0mFY5CbBxRxS
         04HMHB0DsEzqls8pswJe6C0CkhVFkyrpfwdiLZRo3UgomQHUbkizhP4P26ta6pDCEy81
         if0yXvYBRAhZ5YmNzuiuSCQAqexyX22YSLvjSICEHVED/S3KgebB/cY3fcBqMRmMAz/o
         aYO/rUEK2gcpnHqYy1aEvvjl8tOMlZO4Ds/7QKK16Pt4Pj4v8dQYgcqyDlkpMl47Cuhn
         RdUW99cMiW7ZmCJXkJI38p1WygdHbrgmPbHr2rN1a9hWVl8nzBQA9hG5/YNwHE4Uj3w5
         NFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=63cgv+d6hF7bJxk9XJMcdXLWzyM+y2aIDW1QZ5VUN1A=;
        b=DJNKDWcOmUCRYoPCPOfzC0vPuwLM/Fx5YI3GYhuVrSvm1klagLLGYFOutghSHJpJKV
         +wue/FZDOe/g0tWQvXtvHLh/77My9t4qB85/dYozZVX+O9bv8PfqVIvr2Wvcp64Pfibs
         eZii6FCumdWn1d6a9ujXzNPts7deqSht5a4M4c5zpdL4eoQWEIlsQjoXjpvq1WY+xqrR
         84hHsK7aN7YYt7K7ku7GKO0z4km7nJUK2orVOWCtnvHE56VWZhOyeIE1dBS4g6GL9UAu
         DceWXf11gAPLjjZMqKTVuwOGUPolzpZlBvJCoukmo25O1yWmGwY/gBT7GGGX8tmNtrln
         GnyQ==
X-Gm-Message-State: AOAM532UkmRdhOgwLXyqqhD+AknnvF8p1dCpyLmVhVYVIzrXcT0wBBy1
        aQuwNBOMY3c5Z/OtacnVfJ5P8nJXtNw=
X-Google-Smtp-Source: ABdhPJxUP0iT2/MyJew00b/JItiQW5ecF6/h2rnYFaykMxZFw47JDmq7eHvs6UcYJMxeJKk3L40VLQ==
X-Received: by 2002:a05:6000:18cd:: with SMTP id w13mr32916850wrq.20.1618261705679;
        Mon, 12 Apr 2021 14:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b206sm491352wmc.15.2021.04.12.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:25 -0700 (PDT)
Message-Id: <45b603379422bcf7382ff905a97921e3ca5114a3.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:01 +0000
Subject: [PATCH v3 10/26] fsck: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When verifying all blobs reachable from the index, ensure that a sparse
index has been expanded to a full one to avoid missing some blobs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fsck.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 821e7798c706..4d7f5c63ce0d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -883,6 +883,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
 		read_cache();
+		/* TODO: audit for interaction with sparse-index. */
+		ensure_full_index(&the_index);
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
 			struct blob *blob;
-- 
gitgitgadget

