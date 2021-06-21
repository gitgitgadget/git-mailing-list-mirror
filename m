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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E89C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EB36023F
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhFUVMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVMj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 17:12:39 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D9C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:10:23 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id b24-20020a4a34180000b029024b199e7d4dso4511270ooa.4
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFtMSbL96bMmph6JFMFRGL2xQ7tI3uITXVrWqUuL5x8=;
        b=np5fyFWNz/ImClluegskLezmEd5VrHwGg7xwm8jkFfWqJnsGL7eUTrg6BboPQMn7JZ
         +ag0ffSTxUnhpb71P2+E6Ghxpb5ioY7YZfls43xV/Wi11/Ea30ESM+rsGMDlgPmSiyWg
         n6+DPVuU+8YnAscx3Asnm2jq1JulfmTmfTSlWAECte4P9NIPijg0/+bnyc6opSL/SMYb
         vqFUPqktKABJ+4aA09RLjWGHaVtodyi9RjESyheLeYRFp9tnia2UwPhAs5ISnjtPgapq
         lAeUjeq9VwQaai7V3+cqRMBN4uiOwK/CIUDsfOvAptgtPk1pGOFaXkH1LVAMA0YiC/9Y
         JZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFtMSbL96bMmph6JFMFRGL2xQ7tI3uITXVrWqUuL5x8=;
        b=bWtGfHwmugf6TR0+iFR+9sPPf6ALdfUcB9KxCbyd1yi4qelNXuVejvGuXGxPFcwwQD
         2/mb5vr1wqjGNiflZ/MsRvqL5gkUG4vIfrFKTt2TmoUi7Aq0orTYtZTP+WFbjSB+Z7im
         phvLIkPTkBezxpLN5rQAyRYlNrH3hQ7jryCX5+vW48FjuyTGmewPZpgJJz98/Yg7i2zL
         y2Z3ATB/N3PQBjDx0D6zBfo3EX0XAUr68FDmJIlOAgNMQIVWjgLlQjp9eeRRQBLmJi03
         Q/1w/PB9nT2iiQPhjDSKQMChpFmiDnJzd3y47pHBBFEX/oZcQSoU1NKoxWgs3imm7xzA
         Cwqw==
X-Gm-Message-State: AOAM532rFgth7Ck9mgph2mDk9JR2/LUTqs6uGbHGLgqg48alglUxHMtN
        DnXI9P2R3u+a75auGVuGVmzemWV0csthyVY7Adk=
X-Google-Smtp-Source: ABdhPJyAxRjupvPb8VIpY2NylcVqasREMMup7KUlhKL5khAbyB90W5ziggOxI+X9ju6UkGJP3K4dbf+FCWDWsJ6SAOo=
X-Received: by 2002:a4a:d312:: with SMTP id g18mr105310oos.7.1624309823164;
 Mon, 21 Jun 2021 14:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-7-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-7-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 14:10:12 -0700
Message-ID: <CABPp-BFwufgAc6C5b-_jM1cXnCWXm9KGBEr_B0cDwBSbeCFy8g@mail.gmail.com>
Subject: Re: [PATCH 06/12] ref-filter: also free head for ATOM_HEAD to avoid leak
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
> u.head is populated using resolve_refdup(), which returns a newly
> allocated string - hence we also need to free() it.
>
> Found while running t0041 with LSAN:
>
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
>     #1 0xa8be98 in xstrdup wrapper.c:29:14
>     #2 0x9481db in head_atom_parser ref-filter.c:549:17
>     #3 0x9408c7 in parse_ref_filter_atom ref-filter.c:703:30
>     #4 0x9400e3 in verify_ref_format ref-filter.c:974:8
>     #5 0x4f9e8b in print_ref_list builtin/branch.c:439:6
>     #6 0x4f9e8b in cmd_branch builtin/branch.c:757:3
>     #7 0x4ce83e in run_builtin git.c:475:11
>     #8 0x4ccafe in handle_builtin git.c:729:3
>     #9 0x4cb01c in run_argv git.c:818:4
>     #10 0x4cb01c in cmd_main git.c:949:19
>     #11 0x6bdc2d in main common-main.c:52:11
>     #12 0x7f96edf86349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  ref-filter.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 4db0e40ff4..f8bfd25ae4 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2225,8 +2225,12 @@ void ref_array_clear(struct ref_array *array)
>         FREE_AND_NULL(array->items);
>         array->nr = array->alloc = 0;
>
> -       for (i = 0; i < used_atom_cnt; i++)
> -               free((char *)used_atom[i].name);
> +       for (i = 0; i < used_atom_cnt; i++) {
> +               struct used_atom *atom = &used_atom[i];
> +               if (atom->atom_type == ATOM_HEAD)
> +                       free(atom->u.head);
> +               free((char *)atom->name);
> +       }
>         FREE_AND_NULL(used_atom);
>         used_atom_cnt = 0;
>
> --
> 2.26.2

Makes sense.  I think builtin/branch.c and builtin/show-branch.c may
have similar problems with resolve_refdup() calls from a few greps.
You don't need to include those in this series, but if you want to
also tackle those, it would be nice.
