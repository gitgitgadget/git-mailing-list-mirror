Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C0C33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557F520715
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jikb4ll4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgAGOnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:43:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38836 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGOnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:43:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so54251421wrh.5
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XtGmrLY1P11xBlcI31UsosbpWI+MWVhQh52cIOw71SU=;
        b=jikb4ll4ZgJAH/Kb0MoMJwSk8PB25e/k+mfg7YMp89qPUrs2N/z1Y3N6FojQukXe+Z
         lDNI1wtbYMPRpX+ZMaLkrkC8aX+mbxSVKWM+fmxbMjSqLMVFZTqvWc6MsFwW7m/xNFYi
         rDdrdi0vnqKmrAnAhsbaEgHtR2ZjFYc4dg8QZFGF7z4Ej5ocrNwr5uS36EXTDnaLysXs
         jE2OG+RUVmNq/5K90KsIdVZjTNVh8cgsM8jtHlYLup3EB1kfJk0xOzFPZcrI5iGxDtja
         nFHCvdXypDXw0tBpiYklniA2NVRJbKEkkhtSVrXLdONuf8J3vDmg6n+zYqkdQiHZZSEN
         OH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XtGmrLY1P11xBlcI31UsosbpWI+MWVhQh52cIOw71SU=;
        b=WYIL3IpEPbE8ZjzgfKmWYcCYD/qKHy0GNgDI5vWL1TK2sLLECBiRKCLbHvaQ7DHfAT
         t+jRGnPWfdO9TXPupbuj2X9JfQaxSuLE1gS3tAonTkbvLnzTc2JpaeHgn+3o+1ivHePC
         rSl+lh7gP2Mc1EUDCFwKDIJgV/MPdt4zp46B1PZXYB8zaQZo9DBsp1sjJ4zNrgQvzYXZ
         EXWYOWmL+E5Bdj7JHgT3qmrd297kYGYOS+F4m+LzXS01poCGJHldqISQhODZsIg2AJOu
         Pe087hUMfDb1O6MOJk1PhpH+TXT/3S/AACZEQF2NTw8WzgL/SNI8kMqOkwKCHNrQIngm
         BOzw==
X-Gm-Message-State: APjAAAXieEc0oNUquY9ss1OM9BJjvslaRAzEwSJH3dlpZCoOs102QyeX
        E8oEMokEiHtl8PkkSQRNxjA757uu
X-Google-Smtp-Source: APXvYqwJhn4woyRQPrJJcTI3nLEfhBwjNVjD78gOmoHpeN5/OuBR+fkCgczBTMXT2MzppEm90ogmDw==
X-Received: by 2002:adf:82a7:: with SMTP id 36mr115168733wrc.203.1578408215086;
        Tue, 07 Jan 2020 06:43:35 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-7-145.as13285.net. [92.22.7.145])
        by smtp.gmail.com with ESMTPSA id i10sm82532wru.16.2020.01.07.06.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 06:43:34 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/15] rebase: add an --am option
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <1df11f0b5105b1f602fdd723e0f74565e436faba.1577217299.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8f2fa083-114a-011f-1480-ae0ebd67d814@gmail.com>
Date:   Tue, 7 Jan 2020 14:43:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1df11f0b5105b1f602fdd723e0f74565e436faba.1577217299.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 24/12/2019 19:54, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Currently, this option doesn't do anything except error out if any
> options requiring the interactive-backend are also passed.  However,
> when we make the default backend configurable later in this series, this
> flag will provide a way to override the config setting.

I wonder if we really want to add a new option that we know we don't 
want to keep in the long term. Could we not just default to the 
interactive backend and fallback to the am backend if the user passes 
any of the am-based options on the commandline? i.e. reverse the current 
situation of defaulting to the am backend and selecting the interactive 
backend when the user passes certain options.

Best Wishes

Phillip


> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   Documentation/git-rebase.txt | 11 ++++++++++-
>   builtin/rebase.c             | 18 +++++++++++++++++-
>   2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f1ace07c38..cf1ac2e359 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -258,6 +258,13 @@ See also INCOMPATIBLE OPTIONS below.
>   	original branch. The index and working tree are also left
>   	unchanged as a result.
>   
> +--am:
> +	Use git-am internally to rebase.  This option may become a
> +	no-op in the future once the interactive backend handles
> +	everything the am one does.
> ++
> +See also INCOMPATIBLE OPTIONS below.
> +
>   --empty={drop,keep,ask}::
>   	How to handle commits that become empty (because they contain a
>   	subset of already upstream changes) or start empty.  With drop
> @@ -372,7 +379,7 @@ See also INCOMPATIBLE OPTIONS below.
>   	Ensure at least <n> lines of surrounding context match before
>   	and after each change.  When fewer lines of surrounding
>   	context exist they all must match.  By default no context is
> -	ever ignored.
> +	ever ignored.  Implies --am.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> @@ -417,6 +424,7 @@ with `--keep-base` in order to drop those commits from your branch.
>   --whitespace=<option>::
>   	This flag is passed to the 'git apply' program
>   	(see linkgit:git-apply[1]) that applies the patch.
> +	Implies --am.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> @@ -567,6 +575,7 @@ INCOMPATIBLE OPTIONS
>   
>   The following options:
>   
> + * --am
>    * --whitespace
>    * -C
>   
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index d2b99e9908..b7915fc0cb 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1361,6 +1361,18 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
>   	return res && is_linear_history(onto, head);
>   }
>   
> +static int parse_opt_am(const struct option *opt, const char *arg, int unset)
> +{
> +	struct rebase_options *opts = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(arg);
> +
> +	opts->type = REBASE_AM;
> +
> +	return 0;
> +}
> +
>   /* -i followed by -m is still -i */
>   static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
>   {
> @@ -1546,6 +1558,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		OPT_CMDMODE(0, "show-current-patch", &action,
>   			    N_("show the patch file being applied or merged"),
>   			    ACTION_SHOW_CURRENT_PATCH),
> +		{ OPTION_CALLBACK, 0, "am", &options, NULL,
> +			N_("use apply-mail strategies to rebase"),
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> +			parse_opt_am },
>   		{ OPTION_CALLBACK, 'm', "merge", &options, NULL,
>   			N_("use merging strategies to rebase"),
>   			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> @@ -1906,7 +1922,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (isatty(2) && options.flags & REBASE_NO_QUIET)
>   		strbuf_addstr(&options.git_format_patch_opt, " --progress");
>   
> -	if (options.git_am_opts.argc) {
> +	if (options.git_am_opts.argc || options.type == REBASE_AM) {
>   		/* all am options except -q are compatible only with --am */
>   		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
>   			if (strcmp(options.git_am_opts.argv[i], "-q"))
> 
