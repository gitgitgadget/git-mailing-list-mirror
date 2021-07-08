Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F5C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 23:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2146761457
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 23:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhGHXNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 19:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGHXNA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 19:13:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26DEC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 16:10:16 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t39so34591oiw.6
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuV3CA+5ucXFfP8BgaGkVkpDydZ5/QdzjxAKT+kYNwM=;
        b=XRXLy5RHZLPF/AOB4giPhg/I4t1JSeVhY8POHoG/EXy0YUZmLg1vGfU6ig/FIQ+bLE
         AywbKq5qrjsPxzP9lQYyVIruzsz2ikFkJIFT/1Fp8qhiaG2VDVtH++zzCjQd9rM2Yfr6
         RgzidMLtx2iyWu9UjuWTEAufI2cUsURHQidrBEmPFwJr9EEsS1M4QHAHvDr8hfiKhVTu
         UF1xgYywH/bnDxd8AUiNXQLaQgei0xfuM2FP1z6Ilq5AvdQa5ngx0GMetscedTWrBsV4
         OCRqYHproumdOVZzZeRDsL2JcD1DB9TsJ+y0IcDQb0x7J2cCjkZERy0pXNuMnsR+Kuli
         Z6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuV3CA+5ucXFfP8BgaGkVkpDydZ5/QdzjxAKT+kYNwM=;
        b=Fo2M3g4SkwjPIkH1/yePtmrZAftMiT1EwgPKJPr4pUgJR3B6FUGxdcDKJ7mNUqVLrx
         /9DETBpod9Lfmxze6fNLfk7T2Lv3PLnPyNslLaK3dKmFdQ2/R2LQM6tzQd+0s+NWP6XO
         L3xS6iTctECucCwbqoeK9/acHw+q0YkwytvCzNo1f25uhIvbaSgCsZNUfdLE+hkDBDov
         QtWItXb7uAjcp1Vl1K0lfnaQhNpHYwVR7IVRsWgJBRCvYV7DgNjd4qv9pkO2h/TimE4j
         LrdugjFTtX6+RCAGyu5gWhxEobxfMR18YS6qTw3EAdkCJaFsXeVs24Yd4cZPtC/lYUSq
         JoGQ==
X-Gm-Message-State: AOAM531RfXaA9+fK8szEJ6aVHkKaZN10R3nxyW0VAKlV69vfmq/hOWXX
        IxCpefEJrebzaVvyU3B454DclVN1lojPM90D1ZI=
X-Google-Smtp-Source: ABdhPJwbZ1YhVuRdd8BTGT9bzxRymuOBx86YfL5/HBdicvXLD2S0XJCXLMhaG6Dg7K4s/vRd6vSBnzXpFRBKl6iBcAM=
X-Received: by 2002:aca:d547:: with SMTP id m68mr15405850oig.31.1625785815812;
 Thu, 08 Jul 2021 16:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com> <f83aa08ff6b0fd18d6f9f3ce5ee993523a7f1759.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <f83aa08ff6b0fd18d6f9f3ce5ee993523a7f1759.1624932294.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Jul 2021 16:10:04 -0700
Message-ID: <CABPp-BFaWxuBTgztpmso9zCOz3AC62HQuAi5XVAEwsfevYv8gw@mail.gmail.com>
Subject: Re: [PATCH v7 12/16] diff-lib: handle index diffs with sparse dirs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> While comparing an index to a tree, we may see a sparse directory entry.
> In this case, we should compare that portion of the tree to the tree
> represented by that entry. This could include a new tree which needs to
> be expanded to a full list of added files. It could also include an
> existing tree, in which case all of the changes inside are important to
> describe, including the modifications, additions, and deletions. Note
> that the case where the tree has a path and the index does not remains
> identical to before: the lack of a cache entry is the same with a sparse
> index.
>
> Use diff_tree_oid() appropriately to compute the diff.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  diff-lib.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index c2ac9250fe9..3f32f038371 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -325,6 +325,11 @@ static void show_new_file(struct rev_info *revs,
>         unsigned dirty_submodule = 0;
>         struct index_state *istate = revs->diffopt.repo->index;
>
> +       if (new_file && S_ISSPARSEDIR(new_file->ce_mode)) {
> +               diff_tree_oid(NULL, &new_file->oid, new_file->name, &revs->diffopt);
> +               return;
> +       }
> +
>         /*
>          * New file in the index: it might actually be different in
>          * the working tree.
> @@ -347,6 +352,17 @@ static int show_modified(struct rev_info *revs,
>         unsigned dirty_submodule = 0;
>         struct index_state *istate = revs->diffopt.repo->index;
>
> +       /*
> +        * If both are sparse directory entries, then expand the
> +        * modifications to the file level.
> +        */
> +       if (old_entry && new_entry &&
> +           S_ISSPARSEDIR(old_entry->ce_mode) &&
> +           S_ISSPARSEDIR(new_entry->ce_mode)) {
> +               diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
> +               return 0;
> +       }
> +
>         if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
>                           &dirty_submodule, &revs->diffopt) < 0) {
>                 if (report_missing)

Love the simpler patch.

I'm curious about the case where S_ISSPARSEDIR(old_entry->ce_mode) !=
S_ISSPARSEDIR(new_entry->ce_mode), though; how is that handled?
