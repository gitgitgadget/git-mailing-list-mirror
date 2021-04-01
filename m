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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61764C4360C
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52514610A1
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhDABue (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhDABuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434D0C061761
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j18so198867wra.2
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zERwEV3I5iAUQNSYAsx1jxOMzyYF1N8NzKg79Kbu40c=;
        b=XYbWCF5VixSPpdVkZ5uosSKvSbYDJJQSVP87GF1jdPIfDu8CpMwAv4U7LD+ANYUpv4
         a951OTzRNNKkrosIwWx/FET9srYsTkucfUDcqQDIg/wk/pzYySSyhGDaB5yJcyRxgala
         mq/kGuQSAm9LkpYlHHRG8WXvlrypYcVvghvgZ70vkq0J7QDatWgnyHvek7tSlINBXLDj
         /iLB7KB42Y/noO/6t7g/7cnDYf8e5Gk7B1FyOrHPzFQqFRVDHLlKqPhTWKiBYKGLdZs0
         v1jyrnvFSudDod3UfwqzTu4GCjg3O0JgCAm0nL4IufENM/5zuFV9f9EWufg0bby9pmRd
         vzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zERwEV3I5iAUQNSYAsx1jxOMzyYF1N8NzKg79Kbu40c=;
        b=h03pEQzs8/wjBvmWDAFtOvtQodNFcz/RZlAm2jizrE0Sfj4WNBAfaCSnHICRgtUPvc
         sYKOKRFOtwHTef9qnv6pAvguIiPqjdhUcw3jnwpMkl+8J19/dSiwBqT4Oy2O7pL7Olzg
         frAYoKprxu1FZ6i1ACpxnUz0M+0tDfMHDGSphkYQgc1F8Jc+Zngisr6QAMnfcd9fC7fb
         JsGFo4c2KVVT9OowZeSv2E+qpnjCNdTBj7NnZmuzsIV1S+YO0AnG74INi7J8mlo2sKNg
         E5oA3FWdUN0dQlW1zpTs/cf1HhxOMbQdogQxpsMrAWfkSV+w2n3vbIJ8cnViQA6hQwK4
         CLqg==
X-Gm-Message-State: AOAM531J1CKnWYRbmLWLVXIBR4hnt8K/1B8DiTekVL7QIZb2HLyxlmy0
        6YUZ87clFMSsrT2hAYAZ9NbLTSOn0ko=
X-Google-Smtp-Source: ABdhPJzZD8lXfG8P+xeuaw/YSUO8kf/7gLzCtrikSqdQ5zRBJY4WRdxqCMZKslUPoHN+DNQQC8lnqg==
X-Received: by 2002:adf:c752:: with SMTP id b18mr6626282wrh.233.1617241809123;
        Wed, 31 Mar 2021 18:50:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm6743955wrn.5.2021.03.31.18.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:08 -0700 (PDT)
Message-Id: <65704f39edc971a2f866d6a526d04ea2ed1927ae.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:45 +0000
Subject: [PATCH v2 08/25] commit: ensure full index
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

These two loops iterate over all cache entries, so ensure that a sparse
index is expanded to a full index before we do so.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..cf0c36d1dcb2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -251,6 +251,8 @@ static int list_paths(struct string_list *list, const char *with_tree,
 		free(max_prefix);
 	}
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		struct string_list_item *item;
@@ -931,6 +933,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (get_oid(parent, &oid)) {
 			int i, ita_nr = 0;
 
+			/* TODO: audit for interaction with sparse-index. */
+			ensure_full_index(&the_index);
 			for (i = 0; i < active_nr; i++)
 				if (ce_intent_to_add(active_cache[i]))
 					ita_nr++;
-- 
gitgitgadget

