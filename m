Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEAEC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 20:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF0264EB3
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 20:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBSUNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 15:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSUNx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 15:13:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF3CC061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 12:13:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a207so8720474wmd.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 12:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=x3z26DHJ8CvBkw8gqGJoV6pjtvqBnEYEN/hXMyR1b1Q=;
        b=hAqG9dl18y7DRMO6/iCy3XZh6J8o2ueJf6RJIQfvruTJOLq9YEoYthE3SOo2d26+4S
         pfvQroWNV07T3Hqr+Bt3EvBW+4+9uNV773e3cQCZXBHeJt/cuekutnq0hHcLQibgnqmc
         IdADsjUMfxGn5M1DsCVrbXi/GrEod0+i2YQZ1ltvEQsevcWfnDfr1LLiQrpdKjUIBhPl
         QRWwLlE8hcOds4YX4xYK72y4sMN5uQgisBAXDQkN0di+HMEPx2bJShnAAwCAQokvIv+t
         JB9qU5EZ1yw4JODShhgnF4blAHV2iyLLHwGNsbp3rpfGkhlQP2Wj3+DiUd1MFoAz+vuQ
         f48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x3z26DHJ8CvBkw8gqGJoV6pjtvqBnEYEN/hXMyR1b1Q=;
        b=bpRqEZtz/Qoi+VGY2xWT0O/NDf1Y2AfykgFqPirMQ1ziQI+haPCVgPl4ZvMKhv8gBM
         Ls+JnuHDJKvXomXuVg69C39L6fbAtuhxEQNI4QClA07zilhGvjeIb+yoH9wn0XW4QQOh
         Elyt6fSXTB5G8sXWRWwwZK/XUKpo2tuIdydJ43Y60eGpGZIj86DdvdFIY41i3Pj93X1R
         jOdHaCdyiAelzobmMO3XFbgP+H7bptj/hjU85GjnUvKo49tWM4rqFMTgHTBWnfUEqpsp
         OA2p1HktmvAkIoxh6eDHFW9Kwj0D+uaa8a3HzCCdvCNtVrP3OzNSOv27Q6Caov6JAzbJ
         zzlQ==
X-Gm-Message-State: AOAM533pWu5o+OgbAedkfI7TeARkh45R3gQWGnKixnzizZ3gyNoJZ+kI
        eF0yOtmi03eXMv3k8NqoHuajSggAzho=
X-Google-Smtp-Source: ABdhPJzlAWD6JKsUKPr3dbduXcXfWxgoZi0ZpLw3Ka9/yCcmFyEKIAM5yj7YulpkWLM/cv3hWkUj4g==
X-Received: by 2002:a05:600c:2c50:: with SMTP id r16mr9512288wmg.62.1613765591433;
        Fri, 19 Feb 2021 12:13:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm11760886wmq.1.2021.02.19.12.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 12:13:11 -0800 (PST)
Message-Id: <pull.881.git.1613765590412.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 20:13:10 +0000
Subject: [PATCH] commit-graph: avoid leaking topo_levels slab in
 write_commit_graph()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

write_commit_graph initialises topo_levels using init_topo_level_slab(),
next it calls compute_topological_levels() which can cause the slab to
grow, we therefore need to clear the slab again using
clear_topo_level_slab() when we're done.

First introduced in 72a2bfcaf01860ce8dd6921490d903dc0ad59c89 - which
is currently only in master and not on maint.

LeakSanitizer output:

==1026==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x498ae9 in realloc /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0xafbed8 in xrealloc /src/git/wrapper.c:126:8
    #2 0x7966d1 in topo_level_slab_at_peek /src/git/commit-graph.c:71:1
    #3 0x7965e0 in topo_level_slab_at /src/git/commit-graph.c:71:1
    #4 0x78fbf5 in compute_topological_levels /src/git/commit-graph.c:1472:12
    #5 0x78c5c3 in write_commit_graph /src/git/commit-graph.c:2456:2
    #6 0x535c5f in graph_write /src/git/builtin/commit-graph.c:299:6
    #7 0x5350ca in cmd_commit_graph /src/git/builtin/commit-graph.c:337:11
    #8 0x4cddb1 in run_builtin /src/git/git.c:453:11
    #9 0x4cabe2 in handle_builtin /src/git/git.c:704:3
    #10 0x4cd084 in run_argv /src/git/git.c:771:4
    #11 0x4ca424 in cmd_main /src/git/git.c:902:19
    #12 0x707fb6 in main /src/git/common-main.c:52:11
    #13 0x7fee4249383f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)

Indirect leak of 524256 byte(s) in 1 object(s) allocated from:
    #0 0x498942 in calloc /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0xafc088 in xcalloc /src/git/wrapper.c:140:8
    #2 0x796870 in topo_level_slab_at_peek /src/git/commit-graph.c:71:1
    #3 0x7965e0 in topo_level_slab_at /src/git/commit-graph.c:71:1
    #4 0x78fbf5 in compute_topological_levels /src/git/commit-graph.c:1472:12
    #5 0x78c5c3 in write_commit_graph /src/git/commit-graph.c:2456:2
    #6 0x535c5f in graph_write /src/git/builtin/commit-graph.c:299:6
    #7 0x5350ca in cmd_commit_graph /src/git/builtin/commit-graph.c:337:11
    #8 0x4cddb1 in run_builtin /src/git/git.c:453:11
    #9 0x4cabe2 in handle_builtin /src/git/git.c:704:3
    #10 0x4cd084 in run_argv /src/git/git.c:771:4
    #11 0x4ca424 in cmd_main /src/git/git.c:902:19
    #12 0x707fb6 in main /src/git/common-main.c:52:11
    #13 0x7fee4249383f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)

SUMMARY: AddressSanitizer: 524264 byte(s) leaked in 2 allocation(s).

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
    commit-graph: avoid leaking topo_levels slab in write_commit_graph()
    
    write_commit_graph initialises topo_levels using init_topo_level_slab(),
    next it calls compute_topological_levels() which can cause the slab to
    grow, we therefore need to clear the slab again using
    clear_topo_level_slab() when we're done.
    
    First introduced in 72a2bfcaf01860ce8dd6921490d903dc0ad59c89 - which is
    currently only in master and not on maint.
    
    LeakSanitizer output:
    
    ==1026==ERROR: LeakSanitizer: detected memory leaks
    
    Direct leak of 8 byte(s) in 1 object(s) allocated from: #0 0x498ae9 in
    realloc
    /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3 #1
    0xafbed8 in xrealloc /src/git/wrapper.c:126:8 #2 0x7966d1 in
    topo_level_slab_at_peek /src/git/commit-graph.c:71:1 #3 0x7965e0 in
    topo_level_slab_at /src/git/commit-graph.c:71:1 #4 0x78fbf5 in
    compute_topological_levels /src/git/commit-graph.c:1472:12 #5 0x78c5c3
    in write_commit_graph /src/git/commit-graph.c:2456:2 #6 0x535c5f in
    graph_write /src/git/builtin/commit-graph.c:299:6 #7 0x5350ca in
    cmd_commit_graph /src/git/builtin/commit-graph.c:337:11 #8 0x4cddb1 in
    run_builtin /src/git/git.c:453:11 #9 0x4cabe2 in handle_builtin
    /src/git/git.c:704:3 #10 0x4cd084 in run_argv /src/git/git.c:771:4 #11
    0x4ca424 in cmd_main /src/git/git.c:902:19 #12 0x707fb6 in main
    /src/git/common-main.c:52:11 #13 0x7fee4249383f in __libc_start_main
    (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)
    
    Indirect leak of 524256 byte(s) in 1 object(s) allocated from: #0
    0x498942 in calloc
    /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3 #1
    0xafc088 in xcalloc /src/git/wrapper.c:140:8 #2 0x796870 in
    topo_level_slab_at_peek /src/git/commit-graph.c:71:1 #3 0x7965e0 in
    topo_level_slab_at /src/git/commit-graph.c:71:1 #4 0x78fbf5 in
    compute_topological_levels /src/git/commit-graph.c:1472:12 #5 0x78c5c3
    in write_commit_graph /src/git/commit-graph.c:2456:2 #6 0x535c5f in
    graph_write /src/git/builtin/commit-graph.c:299:6 #7 0x5350ca in
    cmd_commit_graph /src/git/builtin/commit-graph.c:337:11 #8 0x4cddb1 in
    run_builtin /src/git/git.c:453:11 #9 0x4cabe2 in handle_builtin
    /src/git/git.c:704:3 #10 0x4cd084 in run_argv /src/git/git.c:771:4 #11
    0x4ca424 in cmd_main /src/git/git.c:902:19 #12 0x707fb6 in main
    /src/git/common-main.c:52:11 #13 0x7fee4249383f in __libc_start_main
    (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)
    
    SUMMARY: AddressSanitizer: 524264 byte(s) leaked in 2 allocation(s).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-881%2Fahunt%2Fcommit-graph-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-881/ahunt/commit-graph-leak-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/881

 commit-graph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/commit-graph.c b/commit-graph.c
index ed31843fa522..9529ec552139 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2471,6 +2471,7 @@ int write_commit_graph(struct object_directory *odb,
 	free(ctx->graph_name);
 	free(ctx->commits.list);
 	oid_array_clear(&ctx->oids);
+	clear_topo_level_slab(&topo_levels);
 
 	if (ctx->commit_graph_filenames_after) {
 		for (i = 0; i < ctx->num_commit_graphs_after; i++) {

base-commit: 2283e0e9af55689215afa39c03beb2315ce18e83
-- 
gitgitgadget
