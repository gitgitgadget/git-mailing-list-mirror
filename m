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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B0BC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A5764EBA
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhBYG0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 01:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhBYG0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 01:26:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00377C06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 22:26:00 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a24so2625405plm.11
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 22:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=0pmdnFOqyKmv2ijCoLo4QpMf4PsRmVN1hWUO0iR6/Wk=;
        b=iu3OzkAbTfTQHuJz5CBJ/oS8tbBNQd1oJ8YrbqlBshnD+F2oVGFOz34w1IpcZJoW+7
         oCX+cfznuhIDqcajOWyXwconFO3wyoL2CyTMob3CFi3GRnaeFWsPFWBSHLIQ1O0DSzww
         rlvmM7A9tSIU50XJRGh0eSUUX5InM7NrE7pRC2FNNLMUgdbUgrn4zRmc67oRAfCd4rNV
         y8YIRNzZ0v40g9Kix8B23n6gdZzRlLSH/uL2te6D3aaS7yXycd4/T++J4wIaHvrz0aLp
         FGcy8ptGshvpoMPW5TluoaxeEUKTy0oYS4P020Sk4D3APZctjClfKQuhALEWdDJuzSsu
         fZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=0pmdnFOqyKmv2ijCoLo4QpMf4PsRmVN1hWUO0iR6/Wk=;
        b=PeDDXpq05FC5jMoBFfWdiXHFUNsQ5lDXWGsMDKejqE/PLwr8bgvF+lb2CPBVk4AcWg
         f2OPrLz/ovXV2J+h+AQdGWFyfAz1EJ518v5/SInD/omkdGsauOkjDZxxdonvcVjAi7Yu
         qBYN38JjSAuG8GaZ80ZI1B9JNFQBt7l7crnq6CyQbReanOByNDuMpqPnjAPuXI4U87AU
         t4vTBlVNeSrizBf703ew2op7h4LHwJJpq3iej0So9aSKN9k+pRhDNXmVFxMerU8xikWO
         AIMPn0pfIjO8YKIqCXzTAn+6EJygxgsLuMLM7kz3QwMVVoR+vlD1U42L9IbzDnPKXjP4
         hokg==
X-Gm-Message-State: AOAM532sE5S5LTRMxXMUe7fbe2x6jh7hjVQtt9paYfS1lT9TnVc3Zgkm
        F7uqwh90eajUIh6F+vLg5fzJgkHXWw6Rkw==
X-Google-Smtp-Source: ABdhPJxY4EqoYruXIa9Ixsj2e3zbpuUeIFS7nbW3rvvvSNMnZbOE2PqMlaYBMiZcSXhI8QCKEwMe2Q==
X-Received: by 2002:a17:90a:9b08:: with SMTP id f8mr1764872pjp.31.1614234360426;
        Wed, 24 Feb 2021 22:26:00 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:19a:25c7:4a26:6ea4:88e1:a048])
        by smtp.gmail.com with ESMTPSA id b207sm4796049pfb.68.2021.02.24.22.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 22:25:59 -0800 (PST)
Date:   Thu, 25 Feb 2021 11:56:16 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     ajrhunt@google.com, andrzej@ahunt.org, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: avoid leaking topo_levels slab in
 write_commit_graph()
Message-ID: <YDdDCMMf4Csumeci@Abhishek-Arch>
Reply-To: pull.881.git.1613765590412.gitgitgadget@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Andrzej Hunt <ajrhunt@google.com>
> 
> write_commit_graph initialises topo_levels using init_topo_level_slab(),
> next it calls compute_topological_levels() which can cause the slab to
> grow, we therefore need to clear the slab again using
> clear_topo_level_slab() when we're done.
> 
> First introduced in 72a2bfcaf01860ce8dd6921490d903dc0ad59c89 - which
> is currently only in master and not on maint.
> 

Thanks for identifying and fixing this memory leak!
- Abhishek

> LeakSanitizer output:
> ==1026==ERROR: LeakSanitizer: detected memory leaks

> Direct leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x498ae9 in realloc /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xafbed8 in xrealloc /src/git/wrapper.c:126:8
>     #2 0x7966d1 in topo_level_slab_at_peek /src/git/commit-graph.c:71:1
>     #3 0x7965e0 in topo_level_slab_at /src/git/commit-graph.c:71:1
>     #4 0x78fbf5 in compute_topological_levels /src/git/commit-graph.c:1472:12
>     #5 0x78c5c3 in write_commit_graph /src/git/commit-graph.c:2456:2
>     #6 0x535c5f in graph_write /src/git/builtin/commit-graph.c:299:6
>     #7 0x5350ca in cmd_commit_graph /src/git/builtin/commit-graph.c:337:11
>     #8 0x4cddb1 in run_builtin /src/git/git.c:453:11
>     #9 0x4cabe2 in handle_builtin /src/git/git.c:704:3
>     #10 0x4cd084 in run_argv /src/git/git.c:771:4
>     #11 0x4ca424 in cmd_main /src/git/git.c:902:19
>     #12 0x707fb6 in main /src/git/common-main.c:52:11
>     #13 0x7fee4249383f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)

> Indirect leak of 524256 byte(s) in 1 object(s) allocated from:
>     #0 0x498942 in calloc /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
>     #1 0xafc088 in xcalloc /src/git/wrapper.c:140:8
>     #2 0x796870 in topo_level_slab_at_peek /src/git/commit-graph.c:71:1
>     #3 0x7965e0 in topo_level_slab_at /src/git/commit-graph.c:71:1
>     #4 0x78fbf5 in compute_topological_levels /src/git/commit-graph.c:1472:12
>     #5 0x78c5c3 in write_commit_graph /src/git/commit-graph.c:2456:2
>     #6 0x535c5f in graph_write /src/git/builtin/commit-graph.c:299:6
>     #7 0x5350ca in cmd_commit_graph /src/git/builtin/commit-graph.c:337:11
>     #8 0x4cddb1 in run_builtin /src/git/git.c:453:11
>     #9 0x4cabe2 in handle_builtin /src/git/git.c:704:3
>     #10 0x4cd084 in run_argv /src/git/git.c:771:4
>     #11 0x4ca424 in cmd_main /src/git/git.c:902:19
>     #12 0x707fb6 in main /src/git/common-main.c:52:11
>     #13 0x7fee4249383f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)

> SUMMARY: AddressSanitizer: 524264 byte(s) leaked in 2 allocation(s).

> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>     commit-graph: avoid leaking topo_levels slab in write_commit_graph()
>     
>     write_commit_graph initialises topo_levels using init_topo_level_slab(),
>     next it calls compute_topological_levels() which can cause the slab to
>     grow, we therefore need to clear the slab again using
>     clear_topo_level_slab() when we're done.
>     
>     First introduced in 72a2bfcaf01860ce8dd6921490d903dc0ad59c89 - which is
>     currently only in master and not on maint.
>     
>     LeakSanitizer output:
>     
>     ==1026==ERROR: LeakSanitizer: detected memory leaks
>     
>     Direct leak of 8 byte(s) in 1 object(s) allocated from: #0 0x498ae9 in
>     realloc
>     /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3 #1
>     0xafbed8 in xrealloc /src/git/wrapper.c:126:8 #2 0x7966d1 in
>     topo_level_slab_at_peek /src/git/commit-graph.c:71:1 #3 0x7965e0 in
>     topo_level_slab_at /src/git/commit-graph.c:71:1 #4 0x78fbf5 in
>     compute_topological_levels /src/git/commit-graph.c:1472:12 #5 0x78c5c3
>     in write_commit_graph /src/git/commit-graph.c:2456:2 #6 0x535c5f in
>     graph_write /src/git/builtin/commit-graph.c:299:6 #7 0x5350ca in
>     cmd_commit_graph /src/git/builtin/commit-graph.c:337:11 #8 0x4cddb1 in
>     run_builtin /src/git/git.c:453:11 #9 0x4cabe2 in handle_builtin
>     /src/git/git.c:704:3 #10 0x4cd084 in run_argv /src/git/git.c:771:4 #11
>     0x4ca424 in cmd_main /src/git/git.c:902:19 #12 0x707fb6 in main
>     /src/git/common-main.c:52:11 #13 0x7fee4249383f in __libc_start_main
>     (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)
>     
>     Indirect leak of 524256 byte(s) in 1 object(s) allocated from: #0
>     0x498942 in calloc
>     /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3 #1
>     0xafc088 in xcalloc /src/git/wrapper.c:140:8 #2 0x796870 in
>     topo_level_slab_at_peek /src/git/commit-graph.c:71:1 #3 0x7965e0 in
>     topo_level_slab_at /src/git/commit-graph.c:71:1 #4 0x78fbf5 in
>     compute_topological_levels /src/git/commit-graph.c:1472:12 #5 0x78c5c3
>     in write_commit_graph /src/git/commit-graph.c:2456:2 #6 0x535c5f in
>     graph_write /src/git/builtin/commit-graph.c:299:6 #7 0x5350ca in
>     cmd_commit_graph /src/git/builtin/commit-graph.c:337:11 #8 0x4cddb1 in
>     run_builtin /src/git/git.c:453:11 #9 0x4cabe2 in handle_builtin
>     /src/git/git.c:704:3 #10 0x4cd084 in run_argv /src/git/git.c:771:4 #11
>     0x4ca424 in cmd_main /src/git/git.c:902:19 #12 0x707fb6 in main
>     /src/git/common-main.c:52:11 #13 0x7fee4249383f in __libc_start_main
>     (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)
>     
>     SUMMARY: AddressSanitizer: 524264 byte(s) leaked in 2 allocation(s).

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-881%2Fahunt%2Fcommit-graph-leak-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-881/ahunt/commit-graph-leak-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/881

>  commit-graph.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/commit-graph.c b/commit-graph.c
> index ed31843fa522..9529ec552139 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2471,6 +2471,7 @@ int write_commit_graph(struct object_directory *odb,
>         free(ctx->graph_name);
>         free(ctx->commits.list);
>         oid_array_clear(&ctx->oids);
> +	clear_topo_level_slab(&topo_levels);
>  
>         if (ctx->commit_graph_filenames_after) {
>                 for (i = 0; i < ctx->num_commit_graphs_after; i++) {

> base-commit: 2283e0e9af55689215afa39c03beb2315ce18e83
> -- 
> gitgitgadget
