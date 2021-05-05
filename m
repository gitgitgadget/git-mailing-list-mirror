Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2845C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBA5610A1
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhEEODB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 10:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhEEODA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:03:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80554C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 07:02:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j19so1196778qtp.7
        for <git@vger.kernel.org>; Wed, 05 May 2021 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SVmtXaJdUDj4aGCmDfyjEtE4K38FXiuo1CzTIalN8I8=;
        b=N1nPj5AsRJNb+HgcoBXxim3TBuNh6eXUjQKxZ16IVjj1MiD1mz/htajK6s/wPlMXQc
         n2vwj+FK9BDFUpAB+ftwWCQxx52RKeVIiVX4skBHq2wTVeHYM681Jk8IbZqJnttT8Wvp
         Z45QwW1BaYz1Ph40g+pkQOz9cVXcFhA6QSVyvFaFaIF9Ru84+jENAdwH9uh010Fpu7DC
         zfJq/cXbjwtF2j735Fm5vskeaTzcJV474rdW/bO+ZNySrexUttWlIRhcXJHjPJcFg9Ou
         fHEwbmyZDxjZmuxYoGTJ/5QO8rEpbrR2PCa8YyqoMmzH3Gx//CLG90l44R0wCvdghRlx
         Q1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVmtXaJdUDj4aGCmDfyjEtE4K38FXiuo1CzTIalN8I8=;
        b=cwhlwygv9ZNB/13AF7zjp8cO5+ChlG9YCpbVfCtWWvBeQtteOcBtS0YNnibPlDWjCM
         jBcrvhr1WYDz/s2OqgteGH6wKwthAARWIFHYPeV05bAzYM8sqB0RDu9fLHXiNEgDPZku
         wdEwpGPvfYw8NVcQdwj3W34E5kY6xec16E4FTl7OTCMAZ9cZ3FnjxbCfpJpwkIzSdFb+
         PUVpnumNYBauq4KUigDJ0yDU2zkG5eGh/4vJ6cgunLYNvpsfL7OTE8GBcxlGOpgaV+Uy
         ondHEOdV3o/6tE2l1UJmgxl6sFs7RDcrpGMAPW/FQck59Pm8Ba8Wnth18uVrar1ZQ1VB
         lb3g==
X-Gm-Message-State: AOAM532Cab1x5OQ72WZdrCIkG59ja+nQzIE6jjEgA42Cvir3jBiKggeE
        vjO6doGP/kb+QLuwy1YFeMY=
X-Google-Smtp-Source: ABdhPJyHgG4PorY9H5IuGVP6KKZAYmt4Hoxu6jLzP+47FqzE7IkHJYgiQyXe9UUfYi4gE/uzkTNsNA==
X-Received: by 2002:ac8:7284:: with SMTP id v4mr1684229qto.180.1620223323698;
        Wed, 05 May 2021 07:02:03 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s22sm13431745qkp.136.2021.05.05.07.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 07:02:03 -0700 (PDT)
Subject: Re: [PATCH 1/2] sparse-index.c: remove set_index_sparse_config()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
 <patch-1.2-6872fd6a59b-20210505T121028Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a9f4ec53-f9f0-3522-6ad2-510b46605a53@gmail.com>
Date:   Wed, 5 May 2021 10:01:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <patch-1.2-6872fd6a59b-20210505T121028Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/5/2021 8:11 AM, Ævar Arnfjörð Bjarmason wrote:
> Remove the set_index_sparse_config() function by folding it into
> set_sparse_index_config(), which was its only user.
> 
> Since 122ba1f7b52 (sparse-checkout: toggle sparse index from builtin,
> 2021-03-30) the flow of this code hasn't made much sense, we'd get
> "enabled" in set_sparse_index_config(), proceed to call
> set_index_sparse_config() with it.
> 
> There we'd call prepare_repo_settings() and set
> "repo->settings.sparse_index = 1", only to needlessly call
> prepare_repo_settings() again in set_sparse_index_config() (where it
> would early abort), and finally setting "repo->settings.sparse_index =
> enabled".
> 
> Instead we can just call prepare_repo_settings() once, and set the
> variable to "enabled" in the first place.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  sparse-index.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/sparse-index.c b/sparse-index.c
> index 6f21397e2ee..b0d5dc5f081 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -102,7 +102,7 @@ static int convert_to_sparse_rec(struct index_state *istate,
>  	return num_converted - start_converted;
>  }
>  
> -static int set_index_sparse_config(struct repository *repo, int enable)
> +int set_sparse_index_config(struct repository *repo, int enable)
>  {
>  	int res;
>  	char *config_path = repo_git_path(repo, "config.worktree");
> @@ -111,15 +111,6 @@ static int set_index_sparse_config(struct repository *repo, int enable)
>  					    enable ? "true" : NULL);
>  	free(config_path);
>  
> -	prepare_repo_settings(repo);
> -	repo->settings.sparse_index = 1;
> -	return res;
> -}
> -
> -int set_sparse_index_config(struct repository *repo, int enable)
> -{
> -	int res = set_index_sparse_config(repo, enable);
> -
>  	prepare_repo_settings(repo);
>  	repo->settings.sparse_index = enable;
>  	return res;
> 

This cleanup makes sense to me. The previous code was confusing and
this is an improvement.

Thanks,
-Stolee
