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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D2C43460
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A006128B
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhDYORK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhDYORH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E01C061761
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c4so14212963wrt.8
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Cly6c+pVEn0MrqzZoU7qCjU5jWrqrApZjLclDmdUlc=;
        b=OprIiKCXlBRR5rl2VsXhDAomCd7VAM5kzuo1nZ3yLG/rwnY1UgNtOlx+Y2JCv3udSM
         yHempRyoMlfu6MjqOmBhgYxdebq4xiwmN8XpzFWZnzvPrbvR/nM/E9hSsSIh5fkNi5jA
         EdeLjUt8NSWLpBwlHmlLSRzuLYdi3VIAyODCXIyoqSCNsuP2Gnq2Gv19Z/Fsu1R5Y9E1
         UWtNHscF3DpQnMqZr3WtNEkRWEMWtb9F3RGhPpgPKTHTaRLXGDABkIyyPSpsIFdTUqi4
         B2TFQuaNrwUCK8CA4+K29jq6UtbkgAl7bRwerB/HAqdCxAv7hL1ftNe23oz2cXABYQa6
         YMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Cly6c+pVEn0MrqzZoU7qCjU5jWrqrApZjLclDmdUlc=;
        b=VzbpyS/fYduP+FIJMe/ZmgafiEoJ7tK0E0p7m30F44zExworpI13Fw0F8qPQ7jxGUw
         6Gu+wfevz7qRY2zsGU9yx2tqbQWhxNW2WoMEq8qKLL6d090238sKLj+TFV5ULi0toYwA
         9P42TNp+e0UMOfE2624T13rO+2rKNqXlha+Mt/nMvK7aXPjs/ux7mU8DgoAc2wWzg4pe
         vkNFI14CohWm1ycLsIKs062KkT0g1Ktt371DhS+82jw3gH8/JXQvyEOsfOshC90rNjAm
         M4c7ApU0IQvUEIaiJdtNQgWv4mePW7M/+EJhDG/XoPhOZCtqBneS62weCPs1XylTz4oa
         f9uA==
X-Gm-Message-State: AOAM532yV9ZteXvocFkgpJE5H6vOXE4otp7meoVhm0VlLbFl/kb43Xkt
        +DQLKXgS3Qa14TQ4vc+Xebk6LOaPr3g=
X-Google-Smtp-Source: ABdhPJzMMjMV1Kc45kdYJWetA5jIWny1bGBKegXSui2SDLZk3VJ8xhLqcy+IwaOeg0/0511AMM0buA==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr17398995wru.157.1619360185794;
        Sun, 25 Apr 2021 07:16:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm15114876wrp.66.2021.04.25.07.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:25 -0700 (PDT)
Message-Id: <693ea82490df68a013582a1f3e4aa8920bfa0cee.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:14 +0000
Subject: [PATCH v2 07/12] builtin/check-ignore: clear_pathspec before
 returning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
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

