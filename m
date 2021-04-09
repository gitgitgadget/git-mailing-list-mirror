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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D6C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A81610FC
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhDISsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbhDISrx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54861C061764
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e12so6553293wro.11
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1nKP0yaXjr4MwVeYdNA48ZKHdlQ2SyIoLZPfwwX2iB4=;
        b=ssPeJZsp8xHSagzrQVznncb+D/GEN7I74vchjVL4LOZHClguGzZf2J7DCeDuDSNNji
         r8hr5wVkJMQjNKgJhcswVNi2U+tJO2/ypIvvuggdNAQwyxh3YXZH8wuPiw+P69FhZ+Iz
         1IRsjtqU1hlyaGVfln3zbU1jMnukKuCfyeItk03skn87jH2YxHm2XwJ04+CdrfSrU3TJ
         ZIa/OKmWZHadtigQbHN10keQut3MrfuVztq8Ymf9PFk3+jJMPpgWWe0xszs+vFkfCXXQ
         2Yvg7/6IRMK+KIp/5LiFZ/eZ7RAcG5ZcZHf4c/2rPiBj99zlKELnhrjSaJJkwoBzcz8p
         oCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1nKP0yaXjr4MwVeYdNA48ZKHdlQ2SyIoLZPfwwX2iB4=;
        b=O6uT7bYGF0kDZMOfx95T7av4eQh+WNi0S9JUUL2G6QL+Q9wEuHiccWBYk+IhR+xcNt
         jQN50NEcm8S599AZaks1uyFIpr/Ht4QJ53OLOUxZjyRJdpbnoQb/2m4rNJ1C9RAZrEMc
         8qtegEfl7e4TF8upw3FRMpuXKrfVf9hfFDMX3r9OGF+bctVOObKmn4qidkTvOZX053Fs
         48ZxPXPjcClJxBYMmdxGdpHd/c1znwjgV1sik0DaU2ivU6Zu/SMBLQK069tv4i7facOP
         fsLyC9k04QM5hljG3nx7qiL9cwWkfjssxId+JSTidGIkX/BHIW1uMrthmvYSXHNHUKXf
         rjGA==
X-Gm-Message-State: AOAM531JWhsFwO8UbocF3O8eiaZXxNohhazTTaxbnXQDkmokcjqGJVzV
        U/4Ncp96HD+gqv1TZWewZmtU3CV22hw=
X-Google-Smtp-Source: ABdhPJwIMjLQmcSLPBXn+tzjZWCXKsEIlzxLWe9W259Oy1biSvJflChchNXkEA3nkNQ60KkhOPYzHA==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr19637060wrw.235.1617994059121;
        Fri, 09 Apr 2021 11:47:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm6093784wrf.39.2021.04.09.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:38 -0700 (PDT)
Message-Id: <8f2374ee899da808ce42f55a5aacc5fe54ad38ed.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:29 +0000
Subject: [PATCH 10/12] builtin/for-each-ref: free filter and UNLEAK sorting.
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

sorting might be a list allocated in ref_default_sorting() (in this case
it's a fixed single item list, which has nevertheless been xcalloc'd),
or it might be a list allocated in parse_opt_ref_sorting(). In either
case we could free these lists - but instead we UNLEAK as we're at the
end of cmd_for_each_ref. (There's no existing implementation of
clear_ref_sorting(), and writing a loop to free the list seems more
trouble than it's worth.)

filter.with_commit/no_commit are populated via
OPT_CONTAINS/OPT_NO_CONTAINS, both of which create new entries via
parse_opt_commits(), and also need to be free'd or UNLEAK'd. Because
free_commit_list() already exists, we choose to use that over an UNLEAK.

LSAN output from t0041:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x49a9d2 in calloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x9ac252 in xcalloc wrapper.c:140:8
    #2 0x8a4a55 in ref_default_sorting ref-filter.c:2486:32
    #3 0x56c6b1 in cmd_for_each_ref builtin/for-each-ref.c:72:13
    #4 0x4cd91d in run_builtin git.c:467:11
    #5 0x4cb5f3 in handle_builtin git.c:719:3
    #6 0x4ccf47 in run_argv git.c:808:4
    #7 0x4caf49 in cmd_main git.c:939:19
    #8 0x69dabe in main common-main.c:52:11
    #9 0x7f2bdc570349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9abf54 in do_xmalloc wrapper.c:41:8
    #2 0x9abf2a in xmalloc wrapper.c:62:9
    #3 0x717486 in commit_list_insert commit.c:540:33
    #4 0x8644cf in parse_opt_commits parse-options-cb.c:98:2
    #5 0x869bb5 in get_value parse-options.c:181:11
    #6 0x8677dc in parse_long_opt parse-options.c:378:10
    #7 0x8659bd in parse_options_step parse-options.c:817:11
    #8 0x867fcd in parse_options parse-options.c:870:10
    #9 0x56c62b in cmd_for_each_ref builtin/for-each-ref.c:59:2
    #10 0x4cd91d in run_builtin git.c:467:11
    #11 0x4cb5f3 in handle_builtin git.c:719:3
    #12 0x4ccf47 in run_argv git.c:808:4
    #13 0x4caf49 in cmd_main git.c:939:19
    #14 0x69dabe in main common-main.c:52:11
    #15 0x7f2bdc570349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/for-each-ref.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index cb9c81a04606..84efb71f82fc 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -83,5 +83,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < maxcount; i++)
 		show_ref_array_item(array.items[i], &format);
 	ref_array_clear(&array);
+	free_commit_list(filter.with_commit);
+	free_commit_list(filter.no_commit);
+	UNLEAK(sorting);
 	return 0;
 }
-- 
gitgitgadget

