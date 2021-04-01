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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C43C001B3
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504FD610A2
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhDABup (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhDABuS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5BBC061761
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo75257wmq.4
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CJjXReyOnuxiS+rkr7b3ZvpKZ1VCS6UDhvoKhleGnNw=;
        b=ecLhslrSl3bH/hqP8Iowj17+AkMdI77L5YAVO+jAD/6FjjFgn0jmKvbCH28yUufgmV
         HVaJdYzjkNQCyuYiZN1KxIIMWKrWp1Q2w/cGU2GeLr69fzOnNw4uO1vufghF21ccFr0t
         07EWjM+TAnm69/fcW8E0AcgembMd6fLi9B37+T36ofRYXLHdJjHcQ/+MM76V30bFJSCg
         oS2B06rJHYBxPT+/AoHbGTt0JiiIB91t2GYD3k99GIgPLTfnbuJ8M7NtfXCdtOTRDH+v
         PTvWOOYrVII+9PoPaT3+0i70Zl4YSGRoJ8JLM2/Bzlbm/uYRyDjv7TKvHYh9jP2pWemb
         8zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CJjXReyOnuxiS+rkr7b3ZvpKZ1VCS6UDhvoKhleGnNw=;
        b=kmH+2MxqYy9BHqDg1R5rkKkWe9daRCV5Ud/IlY08q2FhpwhGDre3XZjkhVyCTmInPc
         t0Si1hcQqNdSp/5u5pKuaznnwwEwwAVQODfTspJMvbyTBjgGJfQI9amWDJpmRPaC08Ht
         hBsTJCxXxTGcAvHZyc1GmXknoj+YkyM9E5D5lO99tKW63ZSMdBHZGwWE93UU5a2lO/01
         VNraSqGkqCdvUy28RJ7UjbGYyqpMzKo6QjDZXA7857vRExlVeyvHuo/vMEARntkNwfqu
         s5RgyHWcnKVxFWPywo4+eYX5WeZzVjQBCwIADpffKoL7jrqxM7a9cu6Lb0Tpf6iz3X/1
         fVTw==
X-Gm-Message-State: AOAM530ZHl3fQ2RauZuWOffv4HfdSqdotn/AgF004EKGi8CX8iZ1vJ3P
        pt6kGn2M8eWHSg4Iipq5aAlp/QnCxCs=
X-Google-Smtp-Source: ABdhPJx6894ZIDqn/smOfu7uSGp8oCTH206akrRxwGPB/buwlvdGdTr7LUP3oes5hlZZ2ullkWjlFw==
X-Received: by 2002:a1c:e041:: with SMTP id x62mr5438656wmg.95.1617241811859;
        Wed, 31 Mar 2021 18:50:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm8644859wmm.5.2021.03.31.18.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:11 -0700 (PDT)
Message-Id: <73684141fcff4d9c0df45e4bbc8d37729bd14ffb.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:50 +0000
Subject: [PATCH v2 13/25] merge-index: ensure full index
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

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full one to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/merge-index.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 38ea6ad6ca25..c0383fe9df9a 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -58,6 +58,8 @@ static void merge_one_path(const char *path)
 static void merge_all(void)
 {
 	int i;
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
@@ -80,6 +82,9 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 
 	read_cache();
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
+
 	i = 1;
 	if (!strcmp(argv[i], "-o")) {
 		one_shot = 1;
-- 
gitgitgadget

