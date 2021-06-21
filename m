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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED997C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A9661289
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhFUUvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhFUUvb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:51:31 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F85C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:49:16 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso9900516otp.8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykEuhw0Z/Y7MqO4BhnyLQGnmykEwZ4BMcY4S4rn/xkw=;
        b=CG4s16Hd9pMOqBvTsJ/V4HopbqGW1bd+b4O63uKJio34dtYVTa3WAxBxpGnrHtYFDj
         n2euGFNXAZyz9iO8GMKl2nb4KUk+Iho93L62iZ3PktGY1qIbszLbzb2raXxTE4Q2+8u6
         bKmE8bVwNALriXX2gNHKfENAneWQUKH3ijjy6V06YqxjoSuF8/zqZRMfrOdVrBAOsB2k
         apMyq8tHtTII5PwbaWXF8lGuqbuFYGAfauNadZ3146Wx1xW2kEgcCf2iMB1fX7YWcI+G
         0CTnAtkvlPcsVQSGtec+j4SyA8IBVBEHcqsFaiXyG9AINRmAgcq77wGmtPYlxmBuVUCd
         J2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykEuhw0Z/Y7MqO4BhnyLQGnmykEwZ4BMcY4S4rn/xkw=;
        b=rkXjsXriupkpP1igEdK9Y68Y0Ohw3h1AS9+I4PR9zfN70/whDyZENV2vsUhF1K4Aqh
         aHo8+49QjX3B+bbQRpOUURdFutbprCuFBqtKirdab3D0SBSeuX9tlQg1mQZM9Kq4uasB
         JGd2I8f3UryH3ppX4pCmXGfhdCldx0kcBdQRd4yp/r7PP9Ok/4ho9Nu8WHzHR3/ujT7v
         XuE8u2XbfZOtxsFLFXVO10ridcmyyRORibGn+NRTVJT6zigE1LJcAexaV3P3cPAxyRev
         yxDDzU4GZH4kW8RYiIFOG+kv2tFnFjDsOfVKFMXJWWCzYFHmoqOLdUo5johRk+xMkRdG
         rYiA==
X-Gm-Message-State: AOAM531KjtslDOK3rNuWfpp3AM0DZAZdSsPDR0a+9RlEpZ+poAbsP2oc
        aiykuzIURyUo8vSe0/35Rzcf6Aw1+K7iKZEEgFU=
X-Google-Smtp-Source: ABdhPJx+d2wgmGUNxm46YDTe8IWHfAC32dI/q2CS0Y5jT14dl5GzRy9Y4XuInJii9Se9WqSd81sPHYVSEuckJHLFKak=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr289072otn.345.1624308555490;
 Mon, 21 Jun 2021 13:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-3-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-3-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 13:49:04 -0700
Message-ID: <CABPp-BGFH787gsw-yd3BpLt_rDe2zDoSFP6mMx6PSQfy1Ct4vw@mail.gmail.com>
Subject: Re: [PATCH 02/12] environment: move strbuf into block to plug leak
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 8:14 AM <andrzej@ahunt.org> wrote:
>
> From: Andrzej Hunt <ajrhunt@google.com>
>
> realpath is only populated if we execute the git_work_tree_initialized
> block. However that block also causes us to return early, meaning we
> never actually release the strbuf in the case where we populated it.
> Therefore we move all strbuf related code into the block to guarantee
> that we can't leak it.
>
> LSAN output from t0095:
>
> Direct leak of 129 byte(s) in 1 object(s) allocated from:
>     #0 0x49a9b9 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0x78f585 in xrealloc wrapper.c:126:8
>     #2 0x713ff4 in strbuf_grow strbuf.c:98:2
>     #3 0x713ff4 in strbuf_getcwd strbuf.c:597:3
>     #4 0x4f0c18 in strbuf_realpath_1 abspath.c:99:7
>     #5 0x5ae4a4 in set_git_work_tree environment.c:259:3
>     #6 0x6fdd8a in setup_discovered_git_dir setup.c:931:2
>     #7 0x6fdd8a in setup_git_directory_gently setup.c:1235:12
>     #8 0x4cb50d in get_bloom_filter_for_commit t/helper/test-bloom.c:41:2
>     #9 0x4cb50d in cmd__bloom t/helper/test-bloom.c:95:3
>     #10 0x4caa1f in cmd_main t/helper/test-tool.c:124:11
>     #11 0x4caded in main common-main.c:52:11
>     #12 0x7f0869f02349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 129 byte(s) leaked in 1 allocation(s).
>
> It looks like this leak has existed since realpath was first added to
> set_git_work_tree() in:
>   3d7747e318 (real_path: remove unsafe API, 2020-03-10)

Looking at that commit, it appears to have introduced other problems.
For example, the documentation for read_gitfile_gently() claims it
returns a value from a shared buffer, but that commit got rid of the
shared buffer so the documentation is no longer accurate.  The thing
that is returned is either the path that was passed in, or some newly
allocated path that differs, in which case the caller would be
responsible to free() it, but it looks like the callers aren't doing
so.  There may be others; as I didn't read the whole old patch, but it
looks like even this example could get messy.

I don't think you need to address the whole mess, fixing one of the
issues from it is fine and...

>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  environment.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 2f27008424..d6b22ede7e 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -249,25 +249,24 @@ static int git_work_tree_initialized;
>  /*
>   * Note.  This works only before you used a work tree.  This was added
>   * primarily to support git-clone to work in a new repository it just
>   * created, and is not meant to flip between different work trees.
>   */
>  void set_git_work_tree(const char *new_work_tree)
>  {
> -       struct strbuf realpath = STRBUF_INIT;
> -
>         if (git_work_tree_initialized) {
> +               struct strbuf realpath = STRBUF_INIT;
> +
>                 strbuf_realpath(&realpath, new_work_tree, 1);
>                 new_work_tree = realpath.buf;
>                 if (strcmp(new_work_tree, the_repository->worktree))
>                         die("internal error: work tree has already been set\n"
>                             "Current worktree: %s\nNew worktree: %s",
>                             the_repository->worktree, new_work_tree);
> +               strbuf_release(&realpath);
>                 return;
>         }
>         git_work_tree_initialized = 1;
>         repo_set_worktree(the_repository, new_work_tree);
> -
> -       strbuf_release(&realpath);
>  }
>
>  const char *get_git_work_tree(void)
> --
> 2.26.2

This patch looks simple and correct.
