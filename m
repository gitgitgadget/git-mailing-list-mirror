Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7B8C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C854D6124C
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhFHA6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 20:58:05 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:38744 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhFHA6E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 20:58:04 -0400
Received: by mail-pj1-f47.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so13017241pjz.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 17:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TMMZgKuu5BjWdK2SxL8UEuBz6JK5PC/Kn9/Ix+jJecc=;
        b=mYoaEKxufXPixn/MlrYk49lFSFaAmwojOGCZHjvBU+dAOEvVMpAWk6inglNoEmdctt
         KzZBFqIOv83AihFyfG1JVYyO27JaARsqXX1RR/TB+kS6i6WQzvPjYN4Bi76LWp9PE+Zu
         d6+yC7oHh8e+vWn3kLDx945WNF8VWKJ2VmE7gsoZN6BIhHChRGtPsAYAwe3NolhINRt3
         I5aSsoGXfJj2b89ynjxLaCc+GwSxL1PvLTCBGf57n8tHtpMDDtKHXriThdj2lhyDcL9g
         zrLtqikwXg9/W+0gJhPweZcew44k5kdqQ5xNIHxiwgb26/U4kv61q7IJeDOd6/mI3lIo
         NhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TMMZgKuu5BjWdK2SxL8UEuBz6JK5PC/Kn9/Ix+jJecc=;
        b=ZRTmb8WfvNmhf1I9W2Bsq9SA9OJWNHdQsArTYgmMISK5W49+dC3c2YVgqcr7d6SK6I
         XRFS3Nx175XE9tt4GZTbv/ym+TuGjQq2TQEsyycT5xMLUc7LO5iWZscKyG5xwWLQfAV2
         7BMo13xgkh+dZn+5pIB2PSEBJ5k3GVFbRjVp8N8oHEo8lcdn6RbNCl9cV5+3iKp1HApm
         PaVMYWrw7Tm1bjWLbdoyGB0gkurcA3JaFIRWQN5Bs4AngejFw9j7bAM3GfiCDj3wghOU
         8otiZb1ciXQfBolPEOHMAWxKZJA3Z+jLuVDh/Pm7YBKb4WcyJjiPe1Z4I46EQQB6QKPj
         VpaA==
X-Gm-Message-State: AOAM530j9uKWjT8rvaWKTbNhYOUg2VZAofSzQpndfWBzFVObTuzYvcRa
        pOIZWVWnl77D3zo3kdounkW8rMcV2NckdQ==
X-Google-Smtp-Source: ABdhPJzgdAlOTg45WWg1+vSnDSIZ54K+wqCOOi0Btj6oBgEZdldPEQnfgXW+1PALGRumaSH45P8K2g==
X-Received: by 2002:a17:902:7404:b029:101:af04:4e24 with SMTP id g4-20020a1709027404b0290101af044e24mr20825027pll.3.1623113695989;
        Mon, 07 Jun 2021 17:54:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:2096:9338:a9c3:81da])
        by smtp.gmail.com with ESMTPSA id d23sm516761pjz.15.2021.06.07.17.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 17:54:55 -0700 (PDT)
Date:   Mon, 7 Jun 2021 17:54:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] run-command: move envvar-resetting function
Message-ID: <YL6/2eFRtdG42JdG@google.com>
References: <cover.1622580781.git.jonathantanmy@google.com>
 <c5307a9f02f3f0f9b30c87bb3e9f8fa3163f839d.1622580781.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5307a9f02f3f0f9b30c87bb3e9f8fa3163f839d.1622580781.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:34:18PM -0700, Jonathan Tan wrote:
> 
> There is a function that resets environment variables, used when
> invoking a sub-process in a submodule. The lazy-fetching code (used in
> partial clones) will need this function in a subsequent commit, so move
> it to a more central location.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  run-command.c | 10 ++++++++++
>  run-command.h |  7 +++++++
>  submodule.c   | 14 ++------------
>  3 files changed, 19 insertions(+), 12 deletions(-)
> diff --git a/run-command.h b/run-command.h
> index d08414a92e..6f61ec7703 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -483,4 +483,11 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
>  			       task_finished_fn, void *pp_cb,
>  			       const char *tr2_category, const char *tr2_label);
>  
> +/**
> + * Convenience function that adds entries to env_array that resets all
> + * repo-specific environment variables except for CONFIG_DATA_ENVIRONMENT. See
> + * local_repo_env in cache.h for more information.
> + */
> +void prepare_other_repo_env(struct strvec *env_array);

I like the name change on the function as well.

>  void prepare_submodule_repo_env(struct strvec *out)
>  {
> -	prepare_submodule_repo_env_no_git_dir(out);
> +	prepare_other_repo_env(out);
>  	strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
>  		     DEFAULT_GIT_DIR_ENVIRONMENT);
>  }
>  
>  static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
>  {
> -	prepare_submodule_repo_env_no_git_dir(out);
> +	prepare_other_repo_env(out);
>  	strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
>  }

This call was used in less places than I thought (I guess that's part of
why you're making it more public/central), so my worry about having some
large scale change was for nothing.

As for Taylor's comment about the CONFIG_DATA_ENVIRONMENT variable, it
was named like that before you got here, so I am not too worried whether
or not you change it.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
