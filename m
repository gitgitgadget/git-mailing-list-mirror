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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70124C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 14:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D61B6124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 14:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhFUODs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFUODr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 10:03:47 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BA9C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 07:01:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r16so7512101oiw.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJbBqeoquxv3VC0D03Uu3kcnHzHCYHU5uZPyYBfD944=;
        b=TIyHRwIjAv3zbGhwMDBlbw+3aQFt9hZ4hXBR6QMoVlsc67l4OXFWQzRY1V7Ztu6N2b
         1FcmcaVbMXP1oHQJrCntRXQS1c//j+Xn8s9bUEBrj1GSLbHE6Gfhg9Jm/hY4VXAri6UJ
         zsFQrjSRGDtcOjC050R0tnlKrai3f4GYr/cLQqdMgj1zykES65diddaiadSC2R8mS4Po
         0NeC7+n9HlTP51ke6+M2vIeO9GyXo8tbJyQts6NvXwN153xdfEyvSZ6s7TTsJj/TYIgw
         RZtvNYCIQk0VhaSVlnSNghNkvZhavHLl+WxE/Np79sTMGDFbeb2qhcPXPydF0S/xQzy4
         KLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJbBqeoquxv3VC0D03Uu3kcnHzHCYHU5uZPyYBfD944=;
        b=oKThzixxHsRLBTPkLgdoJf24wlbLN4pwtJdaedcGBmKbKrtCUSSsGLTQGG+eT+a9e3
         Qzm0a5wl1zSb/NdK9mrdprwGniid+IQssqGa8PzE0w2suo+J6xSYko8VVbBCg0euU8OJ
         wSENqWkTZKOLX0nIxLI3FaxMyKkErMXnqVspBtcZy4d5mnDDpI5BfmDnjQbXKCyyJqrK
         DLGTSdtN1d/rIF6pEq7Pf/uA+gMr8jvRuC+5EYVZ4zPyo6nA4GM/c9OLJvEXk9s0XJBP
         6ZaMiEWEzci5xoJP6SEn+UztuWYBhM8Rt3Vr84RZg8Oh4L7h8NXvFdtvD5Rk33/LhfWF
         qD8w==
X-Gm-Message-State: AOAM533vgMZGlj/VBdLQsB58x4anzgpj8d95zclT7EjbnCs8FvSIWSnX
        fBuoSgld1gOBFCHmWQbWlBKtRxjckmxJc4HurkZE4AradS9p4Q==
X-Google-Smtp-Source: ABdhPJx44m5re5tmui32izbBknNlhNNr53v81jM4sLdhSln8LQnSadqBOomKTT7GS5LzK/zRDb7vs/z6uy2xoJIFbWg=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr24004421oib.39.1624284091926;
 Mon, 21 Jun 2021 07:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-6-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-6-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 07:01:20 -0700
Message-ID: <CABPp-BHvr1Y0XxXfEavhOKkrSf9s6S5H8dXBZy0kR5CTohmuUQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] diffcore-rename: move old_dir/new_dir definition to
 plug leak
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
> old_dir/new_dir are free()'d at the end of update_dir_rename_counts,
> however if we return early we'll never free those strings. Therefore
> we should move all new allocations after the possible early return,
> avoiding a leak.
>
> This seems like a fairly recent leak, that started happening since the
> early-return was added in:
>   1ad69eb0dc (diffcore-rename: compute dir_rename_counts in stages, 2021-02-27)

The entire function was added relatively recently, just a few commits
before that one at
  0c4fd732f0 ("Move computation of dir_rename_count from merge-ort to
diffcore-rename", 2021-02-27)

> LSAN output from t0022:
>
> Direct leak of 7 byte(s) in 1 object(s) allocated from:
>     #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
>     #1 0xa71e48 in xstrdup wrapper.c:29:14
>     #2 0x7db9c7 in update_dir_rename_counts diffcore-rename.c:464:12
>     #3 0x7db6ae in find_renames diffcore-rename.c:1062:3
>     #4 0x7d76c3 in diffcore_rename_extended diffcore-rename.c:1472:18
>     #5 0x7b4cfc in diffcore_std diff.c:6705:4
>     #6 0x855e46 in log_tree_diff_flush log-tree.c:846:2
>     #7 0x856574 in log_tree_diff log-tree.c:955:3
>     #8 0x856574 in log_tree_commit log-tree.c:986:10
>     #9 0x9a9c67 in print_commit_summary sequencer.c:1329:7
>     #10 0x52e623 in cmd_commit builtin/commit.c:1862:3
>     #11 0x4ce83e in run_builtin git.c:475:11
>     #12 0x4ccafe in handle_builtin git.c:729:3
>     #13 0x4cb01c in run_argv git.c:818:4
>     #14 0x4cb01c in cmd_main git.c:949:19
>     #15 0x6b3f3d in main common-main.c:52:11
>     #16 0x7fe397c7a349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> Direct leak of 7 byte(s) in 1 object(s) allocated from:
>     #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
>     #1 0xa71e48 in xstrdup wrapper.c:29:14
>     #2 0x7db9bc in update_dir_rename_counts diffcore-rename.c:463:12
>     #3 0x7db6ae in find_renames diffcore-rename.c:1062:3
>     #4 0x7d76c3 in diffcore_rename_extended diffcore-rename.c:1472:18
>     #5 0x7b4cfc in diffcore_std diff.c:6705:4
>     #6 0x855e46 in log_tree_diff_flush log-tree.c:846:2
>     #7 0x856574 in log_tree_diff log-tree.c:955:3
>     #8 0x856574 in log_tree_commit log-tree.c:986:10
>     #9 0x9a9c67 in print_commit_summary sequencer.c:1329:7
>     #10 0x52e623 in cmd_commit builtin/commit.c:1862:3
>     #11 0x4ce83e in run_builtin git.c:475:11
>     #12 0x4ccafe in handle_builtin git.c:729:3
>     #13 0x4cb01c in run_argv git.c:818:4
>     #14 0x4cb01c in cmd_main git.c:949:19
>     #15 0x6b3f3d in main common-main.c:52:11
>     #16 0x7fe397c7a349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 14 byte(s) leaked in 2 allocation(s).

I ran this code under valgrind with specific tests, but apparently not
under enough different cases.  Thanks for catching this.

> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  diffcore-rename.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 3375e24659..f7c728fe47 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -455,9 +455,9 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
>                                      const char *oldname,
>                                      const char *newname)
>  {
> -       char *old_dir = xstrdup(oldname);
> -       char *new_dir = xstrdup(newname);
> -       char new_dir_first_char = new_dir[0];
> +       char *old_dir;
> +       char *new_dir;
> +       const char new_dir_first_char = newname[0];
>         int first_time_in_loop = 1;
>
>         if (!info->setup)
> @@ -482,6 +482,10 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
>                  */
>                 return;
>
> +
> +       old_dir = xstrdup(oldname);
> +       new_dir = xstrdup(newname);
> +
>         while (1) {
>                 int drd_flag = NOT_RELEVANT;
>
> --
> 2.26.2

The patch is correct.
