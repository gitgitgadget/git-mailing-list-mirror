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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADE1C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D23161056
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhDISsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbhDISrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0516C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s7so6454526wru.6
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Cly6c+pVEn0MrqzZoU7qCjU5jWrqrApZjLclDmdUlc=;
        b=h3zxrfnZl/hQ8oJLeyctmgQ7LfZUoWXA7e/VBpm74mwEeD9gnzH0WYZs+V/QgExhKu
         uiUSaSVMRHMa54X0UGeG/noFFZc7RtnPCK8CPAaiU/qx7DYjJ9HPXsi97GhFKY7Ss0IO
         iaOcXDIY9DD1BQoRkmyI2ckSdN+iSuiI/PS5n/dCJ//4Z8r4ztwnKsB1YdOlOc+/rglK
         0bbNT4hMnhcpDhf2T9Sh8TIYwIrATiXfUqZVNnRfdKIx3ZbopnLykMslnJTPHhafrse5
         s1IHuE+d6LOtERx7KVABNVjcbHuSNTxoS8NJO+CWGNlFB/WmUkCD01i5E474PE9ZV1pv
         v4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Cly6c+pVEn0MrqzZoU7qCjU5jWrqrApZjLclDmdUlc=;
        b=RnWox69MpRkxhZzDWkrBUt3IkrQKdRYYyDk8salCPsGJSyJv3fcGBdrQbadJIjw4+u
         5NicZ0vRFTGcU0+yemuP3C2ZzD70bk9hrfr/7WQ9cAeA5BBUBkEEzMFsMp+fB9ygA7en
         KZ692i0ADiN+CzkVU2s1/b1KguY+lBmKDYjpoBzZszDLGPnRcTCwCu2Rg1sLqh+EOCKT
         dNiBzteGMvb1xA6Sw6AzjkRzA8QWxNuDk4RI92NqP1TAfuncZdUXQPpH5JmSrQ6aPeDJ
         nOgRKNfcJ2JmCVNemJnST2nsyTWwQT9VsDv7vSSpV/SbHUXtjrBVs+IgOIJZBEfMHQha
         nGFA==
X-Gm-Message-State: AOAM531n7VzePr+HyUShxZ5rX1ZZY4V/M2byWc8Gqoc/uUMaPvsbM6oS
        9sOec3IvzlIDbQIsrUKP+0LiSckrgUY=
X-Google-Smtp-Source: ABdhPJyKw0iIAJpNKBzIkr87KEcZsbyXpkqlYzmSc8wWQdirIRdYndutf405JUjoKon5DS6GeWeXFQ==
X-Received: by 2002:adf:cf0f:: with SMTP id o15mr18664051wrj.91.1617994057541;
        Fri, 09 Apr 2021 11:47:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm5029803wmq.29.2021.04.09.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:37 -0700 (PDT)
Message-Id: <563264af39c3103014fc2eb277ddd32ed78f10cf.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:26 +0000
Subject: [PATCH 07/12] builtin/check-ignore: clear_pathspec before returning
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

parse_pathspec() allocates new memory into pathspec, therefore we need
to free it when we're done.

An UNLEAK would probably be just as good here - but clear_pathspec() is
not much more work so we might as well use it. check_ignore() is either
called once directly from cmd_check_ignore() (in which case the leak
really doesnt matter), or it can be called multiple times in a loop from
check_ignore_stdin_paths(), in which case we're potentially leaking
multiple times - but even in this scenario the leak is so small as to
have no real consequence.

Found while running t0008:

Direct leak of 112 byte(s) in 1 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9aca44 in do_xmalloc wrapper.c:41:8
    #2 0x9aca1a in xmalloc wrapper.c:62:9
    #3 0x873c17 in parse_pathspec pathspec.c:582:2
    #4 0x503eb8 in check_ignore builtin/check-ignore.c:90:2
    #5 0x5038af in cmd_check_ignore builtin/check-ignore.c:190:17
    #6 0x4cd91d in run_builtin git.c:467:11
    #7 0x4cb5f3 in handle_builtin git.c:719:3
    #8 0x4ccf47 in run_argv git.c:808:4
    #9 0x4caf49 in cmd_main git.c:939:19
    #10 0x69e43e in main common-main.c:52:11
    #11 0x7f18bb0dd349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 65 byte(s) in 1 object(s) allocated from:
    #0 0x49ab79 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9acc46 in xrealloc wrapper.c:126:8
    #2 0x93baed in strbuf_grow strbuf.c:98:2
    #3 0x93d696 in strbuf_vaddf strbuf.c:392:3
    #4 0x9400c6 in xstrvfmt strbuf.c:979:2
    #5 0x940253 in xstrfmt strbuf.c:989:8
    #6 0x92b72a in prefix_path_gently setup.c:115:15
    #7 0x87442d in init_pathspec_item pathspec.c:439:11
    #8 0x873cef in parse_pathspec pathspec.c:589:3
    #9 0x503eb8 in check_ignore builtin/check-ignore.c:90:2
    #10 0x5038af in cmd_check_ignore builtin/check-ignore.c:190:17
    #11 0x4cd91d in run_builtin git.c:467:11
    #12 0x4cb5f3 in handle_builtin git.c:719:3
    #13 0x4ccf47 in run_argv git.c:808:4
    #14 0x4caf49 in cmd_main git.c:939:19
    #15 0x69e43e in main common-main.c:52:11
    #16 0x7f18bb0dd349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 2 byte(s) in 1 object(s) allocated from:
    #0 0x486834 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0x9ac9e8 in xstrdup wrapper.c:29:14
    #2 0x874542 in init_pathspec_item pathspec.c:468:20
    #3 0x873cef in parse_pathspec pathspec.c:589:3
    #4 0x503eb8 in check_ignore builtin/check-ignore.c:90:2
    #5 0x5038af in cmd_check_ignore builtin/check-ignore.c:190:17
    #6 0x4cd91d in run_builtin git.c:467:11
    #7 0x4cb5f3 in handle_builtin git.c:719:3
    #8 0x4ccf47 in run_argv git.c:808:4
    #9 0x4caf49 in cmd_main git.c:939:19
    #10 0x69e43e in main common-main.c:52:11
    #11 0x7f18bb0dd349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 179 byte(s) leaked in 3 allocation(s).

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/check-ignore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 3c652748d58c..467e92cc7b80 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -118,6 +118,7 @@ static int check_ignore(struct dir_struct *dir,
 			num_ignored++;
 	}
 	free(seen);
+	clear_pathspec(&pathspec);
 
 	return num_ignored;
 }
-- 
gitgitgadget

