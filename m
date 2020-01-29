Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4904BC33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1193920716
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeYb1CL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgA2L0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:26:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41157 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2L0S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 06:26:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so19746421wrw.8
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 03:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/IGaKYlqTzftLnJev+den5gnHljhrr1z0W2HMlF5is=;
        b=DeYb1CL70ACt6GBAYoGuxdXIAesVgqlrU1vFrvUem78Y7P64lzoZD6tDCT1ewaZUwZ
         ouUZ9qNehPrCaZ/C/F6VgDGs5usuyz5GDXbS9O2nuUw899XlzgMo6woQvyU2toYElyNz
         LMHPZVuG6jcm3Np3G3+v24BE6cUWagNvOVYxFvLcKuwRe3tDgK8XeZ4+SKfNgOMAYEIV
         Ri+/qw0vvrJ9DD3QzvEZf7yM6t9wQ29ghtWX2K03ju8VrEbQD0/Ie0SSVkyjfcP1ERNK
         UgqZPR/E95MrT0c/IjecCW7OQFDu5H2G8BFQabRzxgb0XqRD98O4YlDpoL9OU1zrR/VS
         RJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/IGaKYlqTzftLnJev+den5gnHljhrr1z0W2HMlF5is=;
        b=gmeUWQus/8hgNUXm0/V5IatJu2osZUkEPVhe+iI7exGOngn2XnsaRTDdBlafxqz9Nu
         iw/fbTDyd5y+sy+kUPNY7somos1hKVqN+UTu6AXfmMQ15ryUUSFq12kcjWfMRtOWa4I4
         NXdeVTu7OSEtNUwJ76XKPc5Z1gVF+VKtf1XVxpa9aBeUMEwP2RuW4riVqP89zKm54fkh
         ZH5joGxAzRYGgnTDz3S81cl9KSjLAGznjbl01SQIVvqUdGAJUt3/1GpcX+k2aJpI8PcG
         OYPU6bL97fi7SGzMFRiiyTsKNu0zoRaU00o5P1jDogsYfuRz4mm1uNYyxVX2N023uOif
         pdcw==
X-Gm-Message-State: APjAAAXPhZKIraF3Q0sE4S2cslKrV6ci2+9EpjgvxKMkXLTZbbEPpa15
        G+Zcp3R09brrJ9/VNAmW4/U=
X-Google-Smtp-Source: APXvYqwP+vdWgL+4/Q5w17dnJaZsWbMyM2SrXqF+mzfuoTe0DfVjLGeAXBgiGvOc1VHu1dFEatTbnw==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr34150387wro.216.1580297176380;
        Wed, 29 Jan 2020 03:26:16 -0800 (PST)
Received: from szeder.dev (x4db96321.dyn.telefonica.de. [77.185.99.33])
        by smtp.gmail.com with ESMTPSA id p5sm2385006wrt.79.2020.01.29.03.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 03:26:15 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:26:13 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        jrnieder@gmail.com, olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v3 08/12] grep: allow submodule functions to run in
 parallel
Message-ID: <20200129112613.GE10482@szeder.dev>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
 <af8ad95d413aa3d763769eb3ae9544e25ccbe2d1.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af8ad95d413aa3d763769eb3ae9544e25ccbe2d1.1579141989.git.matheus.bernardino@usp.br>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, Matheus, Philippe,

this patch below and a7f3240877 (grep: ignore --recurse-submodules if
--no-index is given, 2020-01-26) on topic
'pb/do-not-recurse-grep-no-index' don't work well together, and cause
failure of the test 'grep --recurse-submodules --no-index ignores
--recurse-submodules' in 't7814-grep-recurse-submodules.sh', i.e. in
the new test added in a7f3240877.

More below.

On Wed, Jan 15, 2020 at 11:39:56PM -0300, Matheus Tavares wrote:
> Now that object reading operations are internally protected, the
> submodule initialization functions at builtin/grep.c:grep_submodule()
> are very close to being thread-safe. Let's take a look at each call and
> remove from the critical section what we can, for better performance:
> 
> - submodule_from_path() and is_submodule_active() cannot be called in
>   parallel yet only because they call repo_read_gitmodules() which
>   contains, in its call stack, operations that would otherwise be in
>   race condition with object reading (for example parse_object() and
>   is_promisor_remote()). However, they only call repo_read_gitmodules()
>   if it wasn't read before. So let's pre-read it before firing the
>   threads and allow these two functions to safely be called in
>   parallel.
> 
> - repo_submodule_init() is already thread-safe, so remove it from the
>   critical section without other necessary changes.
> 
> - The repo_read_gitmodules(&subrepo) call at grep_submodule() is safe as
>   no other thread is performing object reading operations in the subrepo
>   yet. However, threads might be working in the superproject, and this
>   function calls add_to_alternates_memory() internally, which is racy
>   with object readings in the superproject. So it must be kept
>   protected for now. Let's add a "NEEDSWORK" to it, informing why it
>   cannot be removed from the critical section yet.
> 
> - Finally, add_to_alternates_memory() must be kept protected for the
>   same reason as the item above.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  builtin/grep.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index d3ed05c1da..ac3d86c2e5 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -401,25 +401,23 @@ static int grep_submodule(struct grep_opt *opt,
>  	struct grep_opt subopt;
>  	int hit;
>  
> -	/*
> -	 * NEEDSWORK: submodules functions need to be protected because they
> -	 * call config_from_gitmodules(): the latter contains in its call stack
> -	 * many thread-unsafe operations that are racy with object reading, such
> -	 * as parse_object() and is_promisor_object().
> -	 */
> -	obj_read_lock();
>  	sub = submodule_from_path(superproject, &null_oid, path);
>  
> -	if (!is_submodule_active(superproject, path)) {
> -		obj_read_unlock();
> +	if (!is_submodule_active(superproject, path))
>  		return 0;
> -	}
>  
> -	if (repo_submodule_init(&subrepo, superproject, sub)) {
> -		obj_read_unlock();
> +	if (repo_submodule_init(&subrepo, superproject, sub))
>  		return 0;
> -	}
>  
> +	/*
> +	 * NEEDSWORK: repo_read_gitmodules() might call
> +	 * add_to_alternates_memory() via config_from_gitmodules(). This
> +	 * operation causes a race condition with concurrent object readings
> +	 * performed by the worker threads. That's why we need obj_read_lock()
> +	 * here. It should be removed once it's no longer necessary to add the
> +	 * subrepo's odbs to the in-memory alternates list.
> +	 */
> +	obj_read_lock();
>  	repo_read_gitmodules(&subrepo, 0);
>  
>  	/*
> @@ -1052,6 +1050,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	pathspec.recursive = 1;
>  	pathspec.recurse_submodules = !!recurse_submodules;
>  
> +	if (recurse_submodules && (!use_index || untracked))
> +		die(_("option not supported with --recurse-submodules"));

So this patch moves this condition here, expecting git to die with 
'--recurse-submodules --no-index'.  However, a7f3240877 removes the
'!use_index' part of the condition, so we won't die here ...

>  	if (list.nr || cached || show_in_pager) {
>  		if (num_threads > 1)
>  			warning(_("invalid option combination, ignoring --threads"));
> @@ -1071,6 +1072,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		    && (opt.pre_context || opt.post_context ||
>  			opt.file_break || opt.funcbody))
>  			skip_first_line = 1;
> +
> +		/*
> +		 * Pre-read gitmodules (if not read already) to prevent racy
> +		 * lazy reading in worker threads.
> +		 */
> +		if (recurse_submodules)
> +			repo_read_gitmodules(the_repository, 1);

... and eventually reach this condition, which then reads the
submodules even with '--no-index', which is just what a7f3240877 tried
to avoid, thus triggering the test failure.

It might be that all we need is changing this condition to:

  if (recurse_submodules && use_index)

Or maybe not, but this change on top of 'pu' makes t7814 succeed
again.

However, I'm not familiar with the intricacies of either threaded grep
or submodules, much less the combination of the two...  so just an
idea.

>  		start_threads(&opt);
>  	} else {
>  		/*
> @@ -1105,9 +1114,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	if (recurse_submodules && (!use_index || untracked))
> -		die(_("option not supported with --recurse-submodules"));
> -
>  	if (!show_in_pager && !opt.status_only)
>  		setup_pager();
>  
> -- 
> 2.24.1
> 
