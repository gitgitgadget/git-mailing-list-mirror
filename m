Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FE3C6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 23:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBXXXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBXXXA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 18:23:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F8A1D903
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:22:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53865bdc1b1so13988287b3.16
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQ8QPIRZn2d2beGlY1LEj2TM7jNQzdKf3PokzJQ8Vtw=;
        b=quhYGWIg8y14K5hLpw7y0ub8OakCgbLICCzdaqVXy1b3oTmT58BgHHDr7xSLMJyUbs
         a4IegqXReN67rIfKTom4EM1e4cZMfcH5tYI0X8VVYkmnEZ0xyADxezwh0J46h920UkFe
         zYm3rJEeWPpryqC4mhJeErhv0YEZHgCexWKUYoP7py06HmszpTEV7rg8atMtR7qFO3GJ
         +X7wejENRgDwUI0w6KpnAz74sTXdX61wqsgcGnWXq1zpqw0l/D5Zjv+KaWiLFswhguBD
         ZQwxy5rSOgtArEhhsOb5CpKnthdTmSXmsjtivpnaQXVKbJNuMy8q/gT31/KfnvCatIpb
         BsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ8QPIRZn2d2beGlY1LEj2TM7jNQzdKf3PokzJQ8Vtw=;
        b=A380N/tvd7cBR10PN4sC4S0y+/aJOs0yCuhA2FbXRCBT/SWXSIZnThPZlfcvlh2tJW
         ZwlHS8uragiPfnGpSRLAQjNtcezCOYxUw9gIfo5yCWWaqff4ocwlmHqZGz2V2cUH++cG
         liRXjGaLkBi1FcvBpCGCnt9x4ipxlu83UUT4mSwkUabwycCgNCyRe9Hu1aZlD0PESRx+
         IcFUFQqH+r5mxzrWnzXfXfeB4d0zjMvlbto/9F7u/BwnTtvfp4/EYArA2CJyvcY1KsbK
         ZS1fSZf9gg1aMkG2kJCH30Ax/yW2PlzOJZaNGBbmHU4qkbwZdOuSoaeTWhilw4z5SUEq
         T8Jw==
X-Gm-Message-State: AO0yUKWAtBxc3Z2ACr8K5LX5EA2mOP5cjJTX4pBVeeSWTKTDSaUJ2vE5
        4nDjWG4wUPgrfhc92vaoayMsuPpoDDf6YLATf+N6
X-Google-Smtp-Source: AK7set84Ajuk8z/D8T2NYDSGxScNvIIPyLM9M+f9Q49d+nrbPUFuHrD5n90dQXIbc6lsDJfkhBPBpzAtuBsAQkP2obkD
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:60fb:bc56:6979:1f96])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:ac9:0:b0:a06:55b5:3cdf with SMTP
 id a9-20020a5b0ac9000000b00a0655b53cdfmr4050678ybr.3.1677280978701; Fri, 24
 Feb 2023 15:22:58 -0800 (PST)
Date:   Fri, 24 Feb 2023 15:22:56 -0800
In-Reply-To: <8955b45e35474e5feb826101423470d0b51e5470.1677143700.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224232256.2038749-1-jonathantanmy@google.com>
Subject: Re: [PATCH 06/11] sparse-checkout: avoid using internal API of
 unpack-trees, take 2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Elijah Newren <newren@gmail.com>
> 
> Commit 2f6b1eb794 ("cache API: add a "INDEX_STATE_INIT" macro/function,
> add release_index()", 2023-01-12) mistakenly added some initialization
> of a member of unpack_trees_options that was intended to be
> internal-only.  Further, it served no purpose as it simply duplicated
> the initialization that unpack-trees.c code was already doing.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/sparse-checkout.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 4b7390ce367..8d5ae6f2a60 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -217,7 +217,6 @@ static int update_working_directory(struct pattern_list *pl)
>  	o.head_idx = -1;
>  	o.src_index = r->index;
>  	o.dst_index = r->index;
> -	index_state_init(&o.result, r);
>  	o.skip_sparse_checkout = 0;
>  
>  	setup_work_tree();

The commit message seems to imply that in this code path, there is some
code in unpack-trees.c that runs index_state_init(), but that doesn't
seem to be the case. memset-ting the result field with a junk value
causes valgrind to fail with the following trace:

  ==2035705== Invalid read of size 8
  ==2035705==    at 0x30D982: lazy_init_name_hash (name-hash.c:602)
  ==2035705==    by 0x30DDDA: index_file_exists (name-hash.c:721)
  ==2035705==    by 0x3F71A8: check_ok_to_remove (unpack-trees.c:2430)
  ==2035705==    by 0x3F74EE: verify_absent_1 (unpack-trees.c:2495)
  ==2035705==    by 0x3F75C6: verify_absent_sparse (unpack-trees.c:2523)
  ==2035705==    by 0x3F2A15: apply_sparse_checkout (unpack-trees.c:566)
  ==2035705==    by 0x3F6849: update_sparsity (unpack-trees.c:2147)
  ==2035705==    by 0x1FC105: update_working_directory (sparse-checkout.c:228)

so it might be better to move the init invocation to update_sparsity()
instead of only removing it.
