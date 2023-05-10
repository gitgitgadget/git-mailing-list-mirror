Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F8CC77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 20:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjEJUaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 16:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjEJUaO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 16:30:14 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3784C16
        for <git@vger.kernel.org>; Wed, 10 May 2023 13:30:13 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-18f4a6d2822so46756651fac.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683750613; x=1686342613;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9eDfIn1OLAlJx0E6TJl+agqXctlSGgEqMmp0KAGGWk=;
        b=YOFBG/6fCkAZgx6XGXvIB2Ay/MCmotzX4qlIh51Yap4+5ThjrgDbrWU2mplM3WzYYv
         98YC2xMeReNRHOWUSU7InkTh2oVBFdaSiqII97BNUt4oO4NVNmvfoxyO2BV6LfhJ4af8
         E4+2Epd+HfeAUO3VQ4M+H9k9pyH8Mz0vjBMxhSZOmR9jt0pPowKklx4RJQ2Bl8mD4OoP
         4in9S89declaCDs9RVZYcaE4Gh2d/h4K5ZLDetr5VEUOn5pLNWMgffKzW4u6tLzOgdgU
         ejfFPAcqVtCzEBjXCMna044iAEstM+JzLkv5tJwA5rqAGJAObs1qX3fpO4unpp8xhj03
         /qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683750613; x=1686342613;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L9eDfIn1OLAlJx0E6TJl+agqXctlSGgEqMmp0KAGGWk=;
        b=aIt0/mZR3VwrzWOoC7k9IksnEU9uPlOQXZ12b8sW0FFY8qqLBlq2abzP5ijGibN49o
         GG8nLEozrsMirkNFTunwAfIMwy0i8YrG4hz+y40DPmhWKUK7j7z34GP3B7kSg7NlCHxt
         gtOcuTwmA0OQtiEpimwAbY5ekVRj9pUEKCPlHWjhE3LbI8UKrdta8OMkPPbTklqFPiMD
         oMgB14XLSj5sRJEPvVROkxzZcKo0wfnNnIAshZdYRxnWZb/lGrPPmA5EZqpF1y019tcG
         6HK3nYork0oUonEqK1uWIDis5W9Iah9GdlE6Ev00LROEfGoamBXWVxhuydlLk7GDX3Ew
         2R6g==
X-Gm-Message-State: AC+VfDwY8jYrl88ay8kL5BBzqdsR3P0k+UqyWYr03xk/HKdK0lwOsEDn
        gIDPoLutrZ7P8ZFsVg2b3es=
X-Google-Smtp-Source: ACHHUZ47zvhEwdWhH/HiARhOlKbjmm28ugqbBD+l+KtJrIOSI+NxSam4sTS81mkG6UlyOYrPwsYHGg==
X-Received: by 2002:a05:6830:310a:b0:6ab:3c0:7fe7 with SMTP id b10-20020a056830310a00b006ab03c07fe7mr4233770ots.14.1683750612719;
        Wed, 10 May 2023 13:30:12 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g25-20020a9d6c59000000b006a652d3ad74sm2847649otq.69.2023.05.10.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:30:12 -0700 (PDT)
Date:   Wed, 10 May 2023 14:30:11 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <645bfed357efc_3819294e1@chronos.notmuch>
In-Reply-To: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
Subject: Re: [PATCH] merge-tree: load default git config
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The 'git merge-tree' command handles creating root trees for merges
> without using the worktree. This is a critical operation in many Git
> hosts, as they typically store bare repositories.
> 
> This builtin does not load the default Git config, which can have
> several important ramifications.

For the record, I had already sent a better version of this patch almost 2
years ago [1], not just for `git merge-tree`, but other commands as well.

The obvious fix was completely ignored by the maintainer.

The reason why it should be git_xmerge_config and not git_default_config, is
that merge.conflictstyle would not be parsed if you call git_default_config.

> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index aa8040c2a6a..b8f8a8b5d9f 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -17,6 +17,7 @@
>  #include "merge-blobs.h"
>  #include "quote.h"
>  #include "tree.h"
> +#include "config.h"
>  
>  static int line_termination = '\n';
>  
> @@ -628,6 +629,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  	if (argc != expected_remaining_argc)
>  		usage_with_options(merge_tree_usage, mt_options);
>  
> +	git_config(git_default_config, NULL);

It should be git_xmerge_config.

> +
>  	/* Do the relevant type of merge */
>  	if (o.mode == MODE_REAL)
>  		return real_merge(&o, merge_base, argv[0], argv[1], prefix);

[1] https://lore.kernel.org/git/20210622002714.1720891-3-felipe.contreras@gmail.com/

-- 
Felipe Contreras
