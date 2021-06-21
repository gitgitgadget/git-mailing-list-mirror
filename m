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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB3C48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05110601FE
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhFUVra (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhFUVr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 17:47:27 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A33C06175F
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:45:10 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id l12so21472815oig.2
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKLu4VpzoJyBwNM9g8TmKO6bLVYFbwsW6E28kUprMxI=;
        b=sDYwH6S3ZlveYtDLp6x7rJqLHtE86GAtvmyP1h1j3ZAhE9WWjd2Muk+R3aiYEaGy/P
         rrzg0fH4VYmOZ52cBzrx0eVF1G5kQZo1pvp1yFdAVdpMhOyWpgHBIfIkPGvhwU0fNm0Z
         NLxs5mr77hVboPaHUegZ/gtSDIEORjqa9kiqderHtT1cJAXCQcHGbLpnI9I5T96zyJ3t
         qwzAixhYt/4Lh5jOQcaxSS9ZSxI/l1gosqifQbP0p8cDoxxJZYwWjqUuSZEuKMqvU3fG
         UVkIUOJ2ZGYis2sWA6au/k6O/FfogxZHpf8kU1nTif2FsNLVC6zKA+0vr+h43jWAVACs
         kOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKLu4VpzoJyBwNM9g8TmKO6bLVYFbwsW6E28kUprMxI=;
        b=Qb8xyIbVAtgCBQDyW0O9D4B+DrBk4v5LmvIajxn7gnq5Jcz03YIKoj0IwLzTP3nOSP
         trJDFpzmIx0h7+dNoa8XLPR4Uh7FqF2hiSSYaarLBqGGGG7Yp7bCuBMutDXJpegNZxCQ
         CDTTa+zjJ/Rq0jcq69RWeMQ7Vn9stPG+8KV/tszEzpnrZYohvcQB31m+HGotcxgCoDT8
         q7yNM42diwmsjnhD+fkpar+Qkj5j27PLmYDaJnrOShwsca5ki3HQlKenaS4gdoJULVcL
         BKVARBfkkHJUP8Eozm+8Clqg1ZYUZyP044PSmxg8nRyRFHHdTHFZB6rWaDuaJwm+NMqP
         mp4w==
X-Gm-Message-State: AOAM530U0H10gulJVb4R4MrkhAM0K+Bpyo5KDQ+kCttWGvzQlhR0ynhO
        fTZnNHWen8jGa4t+vDKiArBp109nYLrjSgshahY=
X-Google-Smtp-Source: ABdhPJxGQXASuTh7HDdMOb6oZSRICcwC0jaPwRZwzxcopqc0gqpP9A3Mz+pJoqfy1HOHHgrr5tmGTzPX/B+VeVuAI4M=
X-Received: by 2002:aca:f482:: with SMTP id s124mr401300oih.167.1624311910246;
 Mon, 21 Jun 2021 14:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-13-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-13-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 14:44:58 -0700
Message-ID: <CABPp-BH23-c9cFvMw==WUukcoswne7Qc9H65Nuk5Km5Coco2vA@mail.gmail.com>
Subject: Re: [PATCH 12/12] reset: clear_unpack_trees_porcelain to plug leak
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 8:15 AM <andrzej@ahunt.org> wrote:
>
> From: Andrzej Hunt <ajrhunt@google.com>
>
> setup_unpack_trees_porcelain() populates various fields on
> unpack_tree_opts, we need to call clear_unpack_trees_porcelain() to
> avoid leaking them. Specifically, we used to leak
> unpack_tree_opts.msgs_to_free.
>
> We have to do this in leave_reset_head because there are multiple
> scenarios where unpack_tree_opts has already been configured, followed
> by a 'goto leave_reset_head'. But we can also 'goto leave_reset_head'
> prior to having initialised unpack_tree_opts via memset(..., 0, ...).
> Therefore we also move unpack_tree_opts initialisation to the start of
> reset_head(), and convert it to use brace initialisation - which
> guarantees that we can never clear an unitialised unpack_tree_opts.

I think you mean either "uninitialized" or "uninitialised" (missing an
'in' in the spelling)

> clear_unpack_tree_opts() is always safe to call as long as
> unpack_tree_opts is at least zero-initialised, i.e. it does not depend
> on a previous call to setup_unpack_trees_porcelain().
>
> LSAN output from t0021:
>
> Direct leak of 192 byte(s) in 1 object(s) allocated from:
>     #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xa721e5 in xrealloc wrapper.c:126:8
>     #2 0x9f7861 in strvec_push_nodup strvec.c:19:2
>     #3 0x9f7861 in strvec_pushf strvec.c:39:2
>     #4 0xa43e14 in setup_unpack_trees_porcelain unpack-trees.c:129:3
>     #5 0x97e011 in reset_head reset.c:53:2
>     #6 0x61dfa5 in cmd_rebase builtin/rebase.c:1991:9
>     #7 0x4ce83e in run_builtin git.c:475:11
>     #8 0x4ccafe in handle_builtin git.c:729:3
>     #9 0x4cb01c in run_argv git.c:818:4
>     #10 0x4cb01c in cmd_main git.c:949:19
>     #11 0x6b3f3d in main common-main.c:52:11
>     #12 0x7fa8addf3349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> Indirect leak of 147 byte(s) in 1 object(s) allocated from:
>     #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xa721e5 in xrealloc wrapper.c:126:8
>     #2 0x9e8d54 in strbuf_grow strbuf.c:98:2
>     #3 0x9e8d54 in strbuf_vaddf strbuf.c:401:3
>     #4 0x9f7774 in strvec_pushf strvec.c:36:2
>     #5 0xa43e14 in setup_unpack_trees_porcelain unpack-trees.c:129:3
>     #6 0x97e011 in reset_head reset.c:53:2
>     #7 0x61dfa5 in cmd_rebase builtin/rebase.c:1991:9
>     #8 0x4ce83e in run_builtin git.c:475:11
>     #9 0x4ccafe in handle_builtin git.c:729:3
>     #10 0x4cb01c in run_argv git.c:818:4
>     #11 0x4cb01c in cmd_main git.c:949:19
>     #12 0x6b3f3d in main common-main.c:52:11
>     #13 0x7fa8addf3349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> Indirect leak of 134 byte(s) in 1 object(s) allocated from:
>     #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xa721e5 in xrealloc wrapper.c:126:8
>     #2 0x9e8d54 in strbuf_grow strbuf.c:98:2
>     #3 0x9e8d54 in strbuf_vaddf strbuf.c:401:3
>     #4 0x9f7774 in strvec_pushf strvec.c:36:2
>     #5 0xa43fe4 in setup_unpack_trees_porcelain unpack-trees.c:168:3
>     #6 0x97e011 in reset_head reset.c:53:2
>     #7 0x61dfa5 in cmd_rebase builtin/rebase.c:1991:9
>     #8 0x4ce83e in run_builtin git.c:475:11
>     #9 0x4ccafe in handle_builtin git.c:729:3
>     #10 0x4cb01c in run_argv git.c:818:4
>     #11 0x4cb01c in cmd_main git.c:949:19
>     #12 0x6b3f3d in main common-main.c:52:11
>     #13 0x7fa8addf3349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> Indirect leak of 130 byte(s) in 1 object(s) allocated from:
>     #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xa721e5 in xrealloc wrapper.c:126:8
>     #2 0x9e8d54 in strbuf_grow strbuf.c:98:2
>     #3 0x9e8d54 in strbuf_vaddf strbuf.c:401:3
>     #4 0x9f7774 in strvec_pushf strvec.c:36:2
>     #5 0xa43f20 in setup_unpack_trees_porcelain unpack-trees.c:150:3
>     #6 0x97e011 in reset_head reset.c:53:2
>     #7 0x61dfa5 in cmd_rebase builtin/rebase.c:1991:9
>     #8 0x4ce83e in run_builtin git.c:475:11
>     #9 0x4ccafe in handle_builtin git.c:729:3
>     #10 0x4cb01c in run_argv git.c:818:4
>     #11 0x4cb01c in cmd_main git.c:949:19
>     #12 0x6b3f3d in main common-main.c:52:11
>     #13 0x7fa8addf3349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 603 byte(s) leaked in 4 allocation(s).
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  reset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/reset.c b/reset.c
> index 4bea758053..79310ae071 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -21,7 +21,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>         struct object_id head_oid;
>         struct tree_desc desc[2] = { { NULL }, { NULL } };
>         struct lock_file lock = LOCK_INIT;
> -       struct unpack_trees_options unpack_tree_opts;
> +       struct unpack_trees_options unpack_tree_opts = { 0 };
>         struct tree *tree;
>         const char *reflog_action;
>         struct strbuf msg = STRBUF_INIT;
> @@ -49,7 +49,6 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>         if (refs_only)
>                 goto reset_head_refs;
>
> -       memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
>         setup_unpack_trees_porcelain(&unpack_tree_opts, action);
>         unpack_tree_opts.head_idx = 1;
>         unpack_tree_opts.src_index = r->index;
> @@ -134,6 +133,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>  leave_reset_head:
>         strbuf_release(&msg);
>         rollback_lock_file(&lock);
> +       clear_unpack_trees_porcelain(&unpack_tree_opts);
>         while (nr)
>                 free((void *)desc[--nr].buffer);
>         return ret;
> --
> 2.26.2

Nice catch, and nice explanation.  I think we probably have several
similar problems throughout the code base; a quick grep (`git grep -e
struct.unpack_trees_options -e clear_unpack_trees_porcelain`) suggests
there are several places that clear_unpack_trees_porcelain() is
probably missing and which could likely use your struct initialization
trick as well.
