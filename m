Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F93C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FCF6101D
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhDPVPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbhDPVPU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 17:15:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF898C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 14:14:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l4so44016557ejc.10
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=93T2gjA75ScwamVtHGt+lScGkuGhfVZ/SzwdjHEKXjk=;
        b=FOV/gmVLqF6SAF6U7s5rCfPYa7JYDx/QDbeHB86RuwqU7NFPy2DP9a/Ag2Rn1w2Tu0
         L+MXfLDRqq0QMFB9VzMTWkaXjRW0N0BXVhY8eljfm7tMm16CqfZSP8o/6CfV7OLdNlhf
         dKC7OB5c5apmRBDYk7dOEbWnwX+KCDZjcUI/JgyxoFApEd38jpNP7aPr3S6xuPk6DC69
         9LOzYtMMvrgWt5PzebAPMGEpIplapvZqoa6fBG2PZvlnjB+qvVI5qaxzPO1newJlsokY
         8dcTjohvD9Tj/dNprh0IRq09BgusaiW4msVJRQcHx+v5xHH+OBao/tbBY90w0t4Z4dne
         jF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=93T2gjA75ScwamVtHGt+lScGkuGhfVZ/SzwdjHEKXjk=;
        b=Wsxr1P5CUm7RkGHy1VUBd0VAuMcuuOabK++thD5BudwbCTMKTy0KxxA9X4IlD2aN2I
         x4CykjbsCI7M5wgfQSvUOkE7V7fZRJ9R9CIBGTi40NpC/RNzzBUMYUvkiFRoVb674tAJ
         viEA1JIsp2SlYwJS0XQNulA/4kDdbpYfk22pg6qCuer6eFHMMS2YvMUbfRX1UTcqi+5i
         8fu++5UMHwEWlZSS15LBEEkIE5oM2fmJSv+lmBEByCuWkOC/4MDcz36snOFF1bbO4kaA
         CmQy9DNdBUkzFyBpd/1JQ++zyCfLL1pSG4DwtHLFASaW/ElsJd42/0qaauD5nbM/rzJG
         4YoQ==
X-Gm-Message-State: AOAM533A+if4bn8pQGmK5l92RgUaANWY5LRzcwMlDSDzqv4EACHYeZ8H
        zrBXBS9XFuVdoeGDnky+H7Q=
X-Google-Smtp-Source: ABdhPJxQ7YIBtTF1u6v8GQclos1EG+sMShaEAkVIqRC8+IEweGlIZSSv4liJoSknb+1y23Ry/g5l9w==
X-Received: by 2002:a17:907:1c08:: with SMTP id nc8mr10386183ejc.378.1618607693609;
        Fri, 16 Apr 2021 14:14:53 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id b8sm6677934edu.41.2021.04.16.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:14:53 -0700 (PDT)
Date:   Fri, 16 Apr 2021 23:14:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] config: rename `git_etc_config()`
Message-ID: <20210416211451.GP2947267@szeder.dev>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
 <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 09:11:44AM +0200, Patrick Steinhardt wrote:
> The `git_etc_gitconfig()` function retrieves the system-level path of
> the configuration file. We're about to introduce a way to override it
> via an environment variable, at which point the name of this function
> would start to become misleading.
> 
> Rename the function to `git_system_config()` as a preparatory step.
> While at it, the function is also refactored to pass memory ownership to
> the caller. This is done to better match semantics of
> `git_global_config()`, which is going to be introduced in the next
> commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/config.c |  2 +-
>  config.c         | 18 ++++++++----------
>  config.h         |  3 ++-
>  3 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/config.c b/builtin/config.c
> index f71fa39b38..02ed0b3fe7 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -695,7 +695,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  	else if (use_system_config) {
> -		given_config_source.file = git_etc_gitconfig();
> +		given_config_source.file = git_system_config();
>  		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
>  	} else if (use_local_config) {
>  		given_config_source.file = git_pathdup("config");
> diff --git a/config.c b/config.c
> index 6428393a41..8c83669cce 100644
> --- a/config.c
> +++ b/config.c
> @@ -1844,12 +1844,9 @@ static int git_config_from_blob_ref(config_fn_t fn,
>  	return git_config_from_blob_oid(fn, name, &oid, data);
>  }
>  
> -const char *git_etc_gitconfig(void)
> +char *git_system_config(void)
>  {
> -	static const char *system_wide;
> -	if (!system_wide)
> -		system_wide = system_path(ETC_GITCONFIG);
> -	return system_wide;
> +	return system_path(ETC_GITCONFIG);
>  }
>  
>  /*
> @@ -1883,6 +1880,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>  				  config_fn_t fn, void *data)
>  {
>  	int ret = 0;
> +	char *system_config = git_system_config();
>  	char *xdg_config = xdg_config_home("config");
>  	char *user_config = expand_user_path("~/.gitconfig", 0);
>  	char *repo_config;
> @@ -1896,11 +1894,10 @@ static int do_git_config_sequence(const struct config_options *opts,
>  		repo_config = NULL;
>  
>  	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
> -	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK,

Removing git_config_system() from the condition breaks
GIT_CONFIG_NOSYSTEM:

  expecting success of 9999.1 'test': 
  	cat /usr/local/etc/gitconfig &&
  	git config --list --show-origin --show-scope
  
  + cat /usr/local/etc/gitconfig
  [foo]
  	bar = baz
  + git config --list --show-origin --show-scope
  system	file:/usr/local/etc/gitconfig	foo.bar=baz
  local	file:.git/config	core.repositoryformatversion=0
  local	file:.git/config	core.filemode=true
  local	file:.git/config	core.bare=false
  local	file:.git/config	core.logallrefupdates=true
  ok 1 - test

And breaks just about everything the Linux32 job on Travis CI:

  https://travis-ci.org/github/git/git/jobs/767207687#L1218

> -						  opts->system_gently ?
> -						  ACCESS_EACCES_OK : 0))
> -		ret += git_config_from_file(fn, git_etc_gitconfig(),
> -					    data);
> +	if (system_config && !access_or_die(system_config, R_OK,
> +					    opts->system_gently ?
> +					    ACCESS_EACCES_OK : 0))
> +		ret += git_config_from_file(fn, system_config, data);
>  
>  	current_parsing_scope = CONFIG_SCOPE_GLOBAL;
>  	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
> @@ -1927,6 +1924,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>  		die(_("unable to parse command-line config"));
>  
>  	current_parsing_scope = prev_parsing_scope;
> +	free(system_config);
>  	free(xdg_config);
>  	free(user_config);
>  	free(repo_config);
> diff --git a/config.h b/config.h
> index 19a9adbaa9..2be8fa1880 100644
> --- a/config.h
> +++ b/config.h
> @@ -318,7 +318,6 @@ int git_config_rename_section(const char *, const char *);
>  int git_config_rename_section_in_file(const char *, const char *, const char *);
>  int git_config_copy_section(const char *, const char *);
>  int git_config_copy_section_in_file(const char *, const char *, const char *);
> -const char *git_etc_gitconfig(void);
>  int git_env_bool(const char *, int);
>  unsigned long git_env_ulong(const char *, unsigned long);
>  int git_config_system(void);
> @@ -327,6 +326,8 @@ int config_error_nonbool(const char *);
>  #define config_error_nonbool(s) (config_error_nonbool(s), const_error())
>  #endif
>  
> +char *git_system_config(void);
> +
>  int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
>  
>  enum config_scope current_config_scope(void);
> -- 
> 2.31.1
> 


