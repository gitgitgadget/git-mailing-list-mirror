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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04304C11F67
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E2F613B7
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbhGNNPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhGNNPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE35C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso3430251wme.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tfb4ZJoY+6qApfex05pFrbzNryCAs27WBMQoebLkG2E=;
        b=MzwVl+vldgg0DVuq2aPpZG8pjacVsuyVIo58F5AwmSzDoT6gm0MMf7PAD8Pn2OQjNK
         +pRmwjfudHzBKn3QE3MY6rBTQQLf6ccGGc6xw/MW5POR10ATvtSM2HhXKT0nxLVdfqIY
         rt68MteronWnsXoI3R6Fnn6aMnnZWmhOKRoMMnhPCBYWcadOu0dCDygpZ1dsjNf2g3k8
         fa4qhPoEVqG7oGHS4HFE6LKETR4yJntC8l6em6Sm6o/5y3wcD3CG2W4Hrq+fY3ULIwg8
         Dfy7818yw3rq7sv0tizttgan0V5l3OWV51MrsunnZpM7B+SDnyyyxAXe6iELvhmpkuzM
         huSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tfb4ZJoY+6qApfex05pFrbzNryCAs27WBMQoebLkG2E=;
        b=ZMalsPka6t6DjcqJ5OqqMv+h8s48eoxzVijhbUE4L2TGEUgl38ElpWcjJeUtKMFjdb
         D9Y9sOno+R38AiGroWhkxTsF4A6mpXteAkBunC3LkbzfU8Y86616dJw69POwHzcUKWaK
         ukUwGZrqwCAyrMBYCORv/+Zaeluo/cJ50MZUkJ9Ksq9QKO+MhDAAM3UQuBKxyf7uzQq1
         1d2KmF4O0rup0R17cB1uLTIrAvRT6sD4YMT+vA6VxEFgC7kcO6xI3sd8M5SNScddMwrN
         V7wHyG8NGGWu8PPsfYGpYTlVjHJovrGJDmxZQYm+qupNUqc0Hh7oGZDzR58D3oLuXrwp
         PgfA==
X-Gm-Message-State: AOAM530yN4JJye4Es8up//zI3s6ILNNKUwFqNyE6dlYccqAfMamektfg
        mVF6Xtz8GXEgn7ZeUVnjrVZKVc+m5kU=
X-Google-Smtp-Source: ABdhPJxrZ/YphoRW/Db7w4uxjpM8eB4XlXg1HdQcHSuSPPQyOhARtGNlCdvevf1N0tWXumVces4e5g==
X-Received: by 2002:a05:600c:2105:: with SMTP id u5mr6810027wml.18.1626268364010;
        Wed, 14 Jul 2021 06:12:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm2585647wrx.17.2021.07.14.06.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:43 -0700 (PDT)
Message-Id: <f3de9ce7baac9667f5f946bcdf4f0efcddd24c64.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:26 +0000
Subject: [PATCH v9 02/16] sparse-index: include EXTENDED flag when expanding
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When creating a full index from a sparse one, we create cache entries
for every blob within a given sparse directory entry. These are
correctly marked with the CE_SKIP_WORKTREE flag, but the CE_EXTENDED
flag is not included. The CE_EXTENDED flag would exist if we loaded a
full index from disk with these entries marked with CE_SKIP_WORKTREE, so
we can add the flag here to be consistent. This allows us to directly
compare the flags present in cache entries when testing the sparse-index
feature, but has no significance to its correctness in the user-facing
functionality.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 2c695930275..ef53bd2198b 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -213,7 +213,7 @@ static int add_path_to_index(const struct object_id *oid,
 	strbuf_addstr(base, path);
 
 	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
-	ce->ce_flags |= CE_SKIP_WORKTREE;
+	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
 	set_index_entry(istate, istate->cache_nr++, ce);
 
 	strbuf_setlen(base, len);
-- 
gitgitgadget

