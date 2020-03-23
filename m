Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68F6C4332E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A473E205ED
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABIVUK/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCWSkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:40:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42250 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgCWSkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:40:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id e4so2270068oig.9
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WeNmzYSVBofa2bCF1XiG/HDKA6LSwYnxdUZYUzn9Cr0=;
        b=ABIVUK/LW1sQY+W5g36X2xGErOv2Yqys+V3W1HU+W2nJn5ci3Y8JSBAIHeU7tctxVs
         JRhAWichGKjeFr47P4rZKaEChu5+zSJvJ+FuliadQhbAbmghg31jTL5Iy7xKyqh7OVg6
         8Zma65W9sbAy9Gf7jA1Ny05zKylrRy18prgbT/N2Fvi9dSePZGrBLxRnFy4ygl+qJGdk
         o7cw5wbm/wIp2p538yTOWGRCaTSz7i77CPgrX2f8PCeGM4eGH/LULCpZQQKM/vD3seq2
         noac8jf+i5Le60CPYfJt44tiOPCO6UhKjUAvT+ABMzDo/mb8vgE610D/vAyZMYgw5Fxi
         ew7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WeNmzYSVBofa2bCF1XiG/HDKA6LSwYnxdUZYUzn9Cr0=;
        b=VvryLlHplSGZ+MqwNwiODebMq5Y84K8v3TxnbFeeBkvPkNvJ2Mb6Ii2mL4rj6wC2ZF
         zrB0dcgAzR6EPjqiFWc+DSPTTcKsTI7ygWOkoOrnInfzsMiM6o7xGMovIFF+2zvptSPz
         W9X1ExWVGLG6nWq+wku/uIxoiJNW/waKPEz2c7apSSeJcXOFJoUOY2zFwBZY77qxO0zU
         m5drRddWqWamHEJpakxBPMWyGlPHc0Ru3bcpjoi92ZCgTugOc33Itb8GEn6oZuN291xx
         jHnR/uMaX52pCwpttscCGHr16oY6GLCpzHbtr9QHe3FqZ2FxMSQH2PBiZpnMWBwHigtR
         sBTA==
X-Gm-Message-State: ANhLgQ0Mno3PEnt+SKELaZ/pyH3ZV7UeGg5CWAypmhokmDa6PmveogdT
        mJirFD1G+TdsMiLITtnWRU225XMatLQ=
X-Google-Smtp-Source: ADFU+vsLGUs56YD4Nt/2ZA4R/hUq4D6qJvbhosYAU9GNcN+8yIVCBgJ8zxK/QQUvUyowj/4gwTVSyg==
X-Received: by 2002:aca:ddc5:: with SMTP id u188mr569536oig.8.1584988808428;
        Mon, 23 Mar 2020 11:40:08 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 18sm2659593oiy.31.2020.03.23.11.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:40:07 -0700 (PDT)
Subject: Re: [PATCH v2 18/18] sparse-checkout: provide a new reapply
 subcommand
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
 <5730f7d250a2025ae62edaf8779ff39bfbaa5ad6.1584813609.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0394a965-892b-6fb1-ca95-17d88913d656@gmail.com>
Date:   Mon, 23 Mar 2020 14:40:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <5730f7d250a2025ae62edaf8779ff39bfbaa5ad6.1584813609.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2020 2:00 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> If commands like merge or rebase materialize files as part of their work,
> or a previous sparse-checkout command failed to update individual files
> due to dirty changes, users may want a command to simply 'reapply' the
> sparsity rules.  Provide one.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-sparse-checkout.txt | 10 ++++++++++
>  builtin/sparse-checkout.c             | 10 +++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index c0342e53938..1a3ace60820 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -70,6 +70,16 @@ C-style quoted strings.
>  	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
>  	as directory names as in the 'set' subcommand.
>  
> +'reapply::
> +	Reapply the sparsity pattern rules to paths in the working tree.
> +	Commands like merge or rebase can materialize paths to do their
> +	work (e.g. in order to show you a conflict), and other
> +	sparse-checkout commands might fail to sparsify an individual file
> +	(e.g. because it has unstaged changes or conflicts).  In such
> +	cases, it can make sense to run `git sparse-checkout reapply` later
> +	after cleaning up affected paths (e.g. resolving conflicts, undoing
> +	or committing changes, etc.).
> +
>  'disable'::
>  	Disable the `core.sparseCheckout` config setting, and restore the
>  	working directory to include all files. Leaves the sparse-checkout
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index aa81199f85d..95d08824172 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -18,7 +18,7 @@
>  static const char *empty_base = "";
>  
>  static char const * const builtin_sparse_checkout_usage[] = {
> -	N_("git sparse-checkout (init|list|set|add|disable) <options>"),
> +	N_("git sparse-checkout (init|list|set|add|reapply|disable) <options>"),
>  	NULL
>  };
>  
> @@ -554,6 +554,12 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
>  	return modify_pattern_list(argc, argv, m);
>  }
>  
> +static int sparse_checkout_reapply(int argc, const char **argv)
> +{
> +	repo_read_index(the_repository);
> +	return update_working_directory(NULL);
> +}
> +
>  static int sparse_checkout_disable(int argc, const char **argv)
>  {
>  	struct pattern_list pl;
> @@ -603,6 +609,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>  			return sparse_checkout_set(argc, argv, prefix, REPLACE);
>  		if (!strcmp(argv[0], "add"))
>  			return sparse_checkout_set(argc, argv, prefix, ADD);
> +		if (!strcmp(argv[0], "reapply"))
> +			return sparse_checkout_reapply(argc, argv);
>  		if (!strcmp(argv[0], "disable"))
>  			return sparse_checkout_disable(argc, argv);
>  	}

I feel it necessary to commend you for how simple this patch is.
You did all the hard work in earlier patches to make this one
extremely simple.

Nice!
-Stolee

