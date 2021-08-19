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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7EAC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD68610A0
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhHSUyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhHSUyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:54:39 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D691C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:54:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so10415147oti.0
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVbugsjrPmcjbsNTOTEfp5lFZitoj2IcSfrm20Ju0nc=;
        b=I15xaoABJ3VK9/TMgyWimwprdmGm8yhAE8+70gRT0l4EkGrmM+KqKUqkg0QpHxF5CN
         +IgHT/ktkpMfa41cilErMTa8e/HbIpGiyhKyWTiERpfPOVY8GIdde+k+n3bsJs+mvBP/
         Ijt8cQb9sMv2yZOvobzfiSfCft3RreC5fikAoiBVCqvgr2z2r4gAn5FiBvvnxRXpEQWM
         swtUzOlEF/9t4alZ605eTklB7VQzdmybAkjJVrQr9/iCgQbFPLbJa0BWkADYVX7LUWDS
         amtRVDgnRvN8gAuDDK5Glyotd8ES8+NWH6XpTH0MAUTXNBK9Ro58e4zpZPsz5AYN7gyZ
         WAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVbugsjrPmcjbsNTOTEfp5lFZitoj2IcSfrm20Ju0nc=;
        b=t9EHvsdarZbjqdKAWVr/FUcDd92L6uESyf5ryGX3xePKonbxeI2s+wOsuF5f2RW5g5
         xjYGHWJKSaDUz/G5hHxsxSLd5yzSXklFNHOTgKhZ0eGOTaua5GZHWelaFyOsr0L7Ry7n
         /kAcPjz3aNwjOVRaSVjzBzFsYWIXLoKoBznTvTgFpd8Qm4r3coxulJVkvIThzdv98XZx
         /Kn9jKGochW2x12CzXgidbU8zB1iXg3qM1EotfQ/z38od7nk1eBT4gnoSPsFAokb5sla
         Bod3sUscmK/DffgulJL5dnfujPcd36G3k4TfIaQ6mnA04l7BO5D6uqsJSr1At9l/Ayjc
         wOCQ==
X-Gm-Message-State: AOAM5334TNUUPpxyDugiJJP/T/FKUL09A9gQBfU4sVpHktOG5poH4oSw
        GH/R8AoUei+0HyzJuUmeQF9dEmHw16b3leBRStY=
X-Google-Smtp-Source: ABdhPJxsaBwD+9Y0nQcrkgoRw2xxizuWY5wlQucEi89C2WEc+MVgH/Yvmv4PxkKfd365BBV5tIV3vwdHtPXEX7hSqNA=
X-Received: by 2002:a05:6830:1da:: with SMTP id r26mr13367384ota.162.1629406442248;
 Thu, 19 Aug 2021 13:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <c9e100e68f80196a35a37b5d0aad74e8e1174766.1629206603.git.gitgitgadget@gmail.com>
In-Reply-To: <c9e100e68f80196a35a37b5d0aad74e8e1174766.1629206603.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Aug 2021 13:53:51 -0700
Message-ID: <CABPp-BHqTSv7MkS8-nq3Qg3CA3pLxSD9TOVvL_8R1-eF3Rn7pQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] attr: be careful about sparse directories
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 6:23 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  attr.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/attr.c b/attr.c
> index d029e681f28..a1009f78029 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -14,6 +14,7 @@
>  #include "utf8.h"
>  #include "quote.h"
>  #include "thread-utils.h"
> +#include "dir.h"
>
>  const char git_attr__true[] = "(builtin)true";
>  const char git_attr__false[] = "\0(builtin)false";
> @@ -744,6 +745,19 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
>         if (!istate)
>                 return NULL;
>
> +       /*
> +        * In the case of cone-mode sparse-checkout, getting the
> +        * .gitattributes file from a directory is meaningless: all
> +        * contained paths will be sparse if the .gitattributes is also
> +        * sparse. In the case of a sparse index, it is critical that we
> +        * don't go looking for one as it will expand the index.
> +        */

"all contained paths will be sparse if the .gitattributes is also sparse"?

Do you mean something more like "the .gitattributes only applies for
files under the given directory, and if the directory is sparse, then
neither the .gitattributes file or any other file under that directory
will be present" ?

Also, out of curiosity, I was suggesting in the past we do something
like this for .gitignore files, for the same reason.  Do we have such
logic in place, or is that another area of the code that hasn't been
handled yet?

> +       init_sparse_checkout_patterns(istate);
> +       if (istate->sparse_checkout_patterns &&
> +           istate->sparse_checkout_patterns->use_cone_patterns &&
> +           path_in_sparse_checkout(path, istate) == NOT_MATCHED)
> +               return NULL;
> +
>         buf = read_blob_data_from_index(istate, path, NULL);
>         if (!buf)
>                 return NULL;
> --
> gitgitgadget

Though the code appears correct, I too am curious about the questions
Dscho asked about the code in this patch.
