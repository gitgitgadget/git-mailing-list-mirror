Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257FAC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 01:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiGABWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 21:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiGABWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 21:22:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2397D5A2F2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 18:22:49 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u14so2475337qvv.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z6DHxnuqM7ZwWfdsfKNN0JDdpsdwElBBZzf1YhVIpeA=;
        b=W4cP35s4FwYepcqraXdzaVUFEjQQNjtTxMRAMaDsqOWxh+UnaLtygQr3/aLQk2eeIR
         ukimTuYU9Wfcf+e66ynJExSutBlNgR3FakZQnAP9LCcDM8V7e0sDzSNxLOtnTXxU+QlR
         y5jbhm3cv3DQQeSAfjOnf5FmA6D3bL9TihJXyr43B+9k0dFolRuCeuAUfVGlZaHlsL3C
         4DPrYsTf9y+ON52zkwYj4LdKJd29KPW6eTVhorS6cOyOT6k9/lg7OortzYrjeKi/BdE3
         sSXiJJkUjUoJuIco7FEdu2+IkbEFrDzyY/GVSiMRRJ3jwm3a2CCCu9O6/KL9WqRwfLe0
         fdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z6DHxnuqM7ZwWfdsfKNN0JDdpsdwElBBZzf1YhVIpeA=;
        b=r/Rjt6Ey8gp5QeMKwY1BG3TULZULr/pkvPW8On1F6/DIP2bQardikVGE+6k/gMgHUn
         jP/h0ji9OP3TZsd5rRHG0xK7bQ4jqA9o74iF70MbaFm4KgZ/NPH05X0RDfxnQDpIbIvx
         l8t8VuMdUh1pPc5vG+BPUmWStJbnTSBv9V1j6c+OHOF5KrSvrlRb48NrWUeSKdoYKtDz
         Rtmr3waygvtq09j2hqojJinpeQF+6ko11yJpC1tvemzAJHIHKMN1TArpCcn2H3dQN8Fh
         IWKY6kEBF63uuts0xsHCNqyP0klf/xHV/41/77WQDyHCL1y5zozIpzV1UYtp67u6ucg1
         TSZA==
X-Gm-Message-State: AJIora+Fuc+sw2ZtB05tME1hQ7yM2PCjl+N94nFWRSU34LLFfqA9Lu8h
        y6dXOT2n1fdZelKWKPsGd5xjfg==
X-Google-Smtp-Source: AGRyM1vH9ud5tZb19cjiu828wJ7/9CQyipo6Os32CRcAMBa8vqgDsP4lORMLRLzSYxl/8TBHMB7KkA==
X-Received: by 2002:a0c:b258:0:b0:470:5709:4007 with SMTP id k24-20020a0cb258000000b0047057094007mr15246620qve.83.1656638568191;
        Thu, 30 Jun 2022 18:22:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b3-20020ac812c3000000b0031bf647b115sm4924090qtj.35.2022.06.30.18.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 18:22:47 -0700 (PDT)
Date:   Thu, 30 Jun 2022 21:22:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v6 3/5] config: learn `git_protected_config()`
Message-ID: <Yr5MZhgTBFgZh/XB@nand.local>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
 <3efe282e6b94c3daed77590c5f601fad34137c9c.1656612839.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3efe282e6b94c3daed77590c5f601fad34137c9c.1656612839.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 06:13:57PM +0000, Glen Choo via GitGitGadget wrote:
> In light of constraint 1, this implementation can still be improved
> since git_protected_config() iterates through every variable in
> protected_config, which may still be too expensive. There exist constant
> time lookup functions for non-protected configuration
> (repo_config_get_*()), but for simplicity, this commit does not
> implement similar functions for protected configuration.

I don't quite follow along with this paragraph: it sounds like reading
protected configuration is supposed to be as fast as possible. But you
note that only the slower variant of reading each configuration variable
one at a time is implemented.

If we care about speed (and I think we should here), then would it make
more sense to implement only the lookup functions like
repo_config_get_*() for protected context? That would encourage usage by
providing a more limited set of options to callers.

> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  config.c                     | 51 ++++++++++++++++++++++++++++++++++++
>  config.h                     | 17 ++++++++++++
>  t/t5544-pack-objects-hook.sh |  7 ++++-
>  upload-pack.c                | 27 ++++++++++++-------
>  4 files changed, 91 insertions(+), 11 deletions(-)
>
> diff --git a/config.c b/config.c
> index 9b0e9c93285..29e62f5d0ed 100644
> --- a/config.c
> +++ b/config.c
> @@ -81,6 +81,18 @@ static enum config_scope current_parsing_scope;
>  static int pack_compression_seen;
>  static int zlib_compression_seen;
>
> +/*
> + * Config that comes from trusted sources, namely:

Should we be using the word "scope" here instead of sources? I think
it's clear enough from the context what you're referring to, but in the
spirit of being consistent...

> + * - system config files (e.g. /etc/gitconfig)
> + * - global config files (e.g. $HOME/.gitconfig,
> + *   $XDG_CONFIG_HOME/git)
> + * - the command line.
> + *
> + * This is declared here for code cleanliness, but unlike the other
> + * static variables, this does not hold config parser state.
> + */
> +static struct config_set protected_config;
> +
>  static int config_file_fgetc(struct config_source *conf)
>  {
>  	return getc_unlocked(conf->u.file);
> @@ -2378,6 +2390,11 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
>  	return git_config_from_file(config_set_callback, filename, cs);
>  }
>
> +int git_configset_add_parameters(struct config_set *cs)
> +{
> +	return git_config_from_parameters(config_set_callback, cs);
> +}
> +
>  int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
>  {
>  	const struct string_list *values = NULL;
> @@ -2619,6 +2636,40 @@ int repo_config_get_pathname(struct repository *repo,
>  	return ret;
>  }
>
> +/* Read values into protected_config. */
> +static void read_protected_config(void)
> +{
> +	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
> +
> +	git_configset_init(&protected_config);
> +
> +	system_config = git_system_config();
> +	git_global_config(&user_config, &xdg_config);
> +
> +	git_configset_add_file(&protected_config, system_config);
> +	git_configset_add_file(&protected_config, xdg_config);
> +	git_configset_add_file(&protected_config, user_config);
> +	git_configset_add_parameters(&protected_config);
> +
> +	free(system_config);
> +	free(xdg_config);
> +	free(user_config);
> +}
> +
> +/* Ensure that protected_config has been initialized. */
> +static void git_protected_config_check_init(void)
> +{
> +	if (protected_config.hash_initialized)
> +		return;
> +	read_protected_config();
> +}
> +
> +void git_protected_config(config_fn_t fn, void *data)
> +{
> +	git_protected_config_check_init();

This may be copying from an existing pattern, but I think you could
avoid the extra function declaration by writing git_protected_config()
as:

    if (!protected_config.hash_initialized)
        read_protected_config();
    configset_iter(&protected_config, fn, data);

Thanks,
Taylor
