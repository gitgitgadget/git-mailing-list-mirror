Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE9C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70024205F4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUTqUZ+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgKWVna (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 16:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbgKWVn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 16:43:29 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E57C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 13:43:28 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t8so16231177pfg.8
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 13:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DrYW6VrtH/BYHvg6aph6xy73J/ZnMFr48cPeaUReD8w=;
        b=eUTqUZ+afoatghTV0mNijLVPMEXuvCz40lzw75jcB+m8q4NAog87+RkDR9KpkgrLvb
         Zj/yPkUB0/IDaaerwZi9pEHI1ZfdqM1el+MC+N7KBV/va3BI9Kf4/7YsaPduAgWEQXiU
         AN3GhwWpgzMIRzaS3juro1WP0IYVSp9rBz1PwaQ9TEi1DyEHqmx04xTXr/fktIRPGzeR
         HDhjwgOP5d7EfzrJ/39CegZ7qEFsyhIlT4NeCxkgeCScaz6/rkMQcRbFa/lidSWb1w4n
         GUD0N/C9f5cEfncwurLifE3rO0p3TTI/1akmkyw+QaN+b6qS/qdMBCeUwuku6V4YXrtt
         1KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DrYW6VrtH/BYHvg6aph6xy73J/ZnMFr48cPeaUReD8w=;
        b=eEFucrH29ZiLTnmVy7jNH/7RfjtoNCBi+lRfYWZ9Vntu979GGh1xzt1La2BPP+eqPS
         AEP6PMjDNFs/sFWOolx+OTY+I85tEBfkiPUIPFDwEqHXEVUV7GpylZwZkGMeGiyHgI9X
         gZ0BG7gyD2Y79tfQ4PlLncrSr3Nx8vpP1Ds3BZvdlJcf2FoqZ6KL55mr6K/uFu5l/qGG
         4kujgIvk/N9VIhhXVfba031A1k2u6nc5yiGFZh/Jt/yU+uml0bBm0oTGTVHF0gjdVXMC
         yd00whGyLzfbOvm5czHbVFpuN1afMJ58iYEEsVC8UcokUOKYJdaq6gr/qaUm6IFrOlHI
         gzFg==
X-Gm-Message-State: AOAM531KpVMdaGdVtC2/+5byudaozsCj57XlbvoEFPeEq6SFnEUk+m99
        mJc6zEYwVnO4/vLRIzGeYamshg==
X-Google-Smtp-Source: ABdhPJzVIrcZESCW63vY9xG70yOujxQ9iGy0QUrdYhUvb6qnPkhwXM4kFbJYLDjw8E4QIwpGn2Tcxw==
X-Received: by 2002:a17:90a:f317:: with SMTP id ca23mr1009468pjb.141.1606167807596;
        Mon, 23 Nov 2020 13:43:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id e2sm337631pjv.10.2020.11.23.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 13:43:27 -0800 (PST)
Date:   Mon, 23 Nov 2020 13:43:22 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/7] config: convert multi_replace to flags
Message-ID: <20201123214322.GC499823@google.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <0c152faa00881483db0a59f4c5bc7204ebed8966.1606147507.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c152faa00881483db0a59f4c5bc7204ebed8966.1606147507.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 04:05:03PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 
> We will extend the flexibility of the config API. Before doing so, let's
> take an existing 'int multi_replace' parameter and replace it with a new
> 'unsigned flags' parameter that can take multiple options as a bit field.
> 
> Update all callers that specified multi_replace to now specify the
> CONFIG_FLAGS_MULTI_REPLACE flag. To add more clarity, extend the
> documentation of git_config_set_multivar_in_file() including a clear
> labeling of its arguments. Other config API methods in config.h require
> only a change of the final parameter from 'int' to 'unsigned'.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> index e82301fb1b..5ce3844d22 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -829,10 +829,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  			die(_("Branch '%s' has no upstream information"), branch->name);
>  
>  		strbuf_addf(&buf, "branch.%s.remote", branch->name);
> -		git_config_set_multivar(buf.buf, NULL, NULL, 1);
> +		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
>  		strbuf_reset(&buf);
>  		strbuf_addf(&buf, "branch.%s.merge", branch->name);
> -		git_config_set_multivar(buf.buf, NULL, NULL, 1);
> +		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);

Converting callers. Straightforward.

[snipping more similar work]

> diff --git a/config.c b/config.c
> index 2b79fe76ad..096f2eae0d 100644
> --- a/config.c
> +++ b/config.c
> @@ -2716,9 +2716,9 @@ void git_config_set(const char *key, const char *value)
>   * if value_regex!=NULL, disregard key/value pairs where value does not match.
>   * if value_regex==CONFIG_REGEX_NONE, do not match any existing values
>   *     (only add a new one)
> - * if multi_replace==0, nothing, or only one matching key/value is replaced,
> - *     else all matching key/values (regardless how many) are removed,
> - *     before the new pair is written.
> + * if (flags & CONFIG_FLAGS_MULTI_REPLACE) == 0, at most one matching
> + *     key/value is replaced, else all matching key/values (regardless
> + *     how many) are removed, before the new pair is written.

This documentation to me sounds like the question you asked on-list the
other day: "does replace-all turn many configs into one, or many configs
into many with the same value?" Is it reflected in user-facing
documentation? Looks like no - you might have a good opportunity here to
make that more clear.

>   *
>   * Returns 0 on success.
>   *
> @@ -2739,7 +2739,7 @@ void git_config_set(const char *key, const char *value)
>  int git_config_set_multivar_in_file_gently(const char *config_filename,
>  					   const char *key, const char *value,
>  					   const char *value_regex,
> -					   int multi_replace)
> +					   unsigned flags)

Well, I wanted to complain about using 'unsigned' instead of 'unsigned
int', but 'git grep -P "unsigned(?! int)"' tells me that it's not a
thing anybody else seems to mind. So I'll just grumble in my corner
instead :)

>  {
>  	int fd = -1, in_fd = -1;
>  	int ret;
> @@ -2756,7 +2756,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
>  	if (ret)
>  		goto out_free;
>  
> -	store.multi_replace = multi_replace;
> +	store.multi_replace = (flags & CONFIG_FLAGS_MULTI_REPLACE) != 0;
>  
>  	if (!config_filename)
>  		config_filename = filename_buf = git_pathdup("config");
> @@ -2845,7 +2845,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
>  
>  		/* if nothing to unset, or too many matches, error out */
>  		if ((store.seen_nr == 0 && value == NULL) ||
> -		    (store.seen_nr > 1 && multi_replace == 0)) {
> +		    (store.seen_nr > 1 && !store.multi_replace)) {

Huh, I wonder why 'store.multi_replace' wasn't used here before, since
it was bothered to be set at earlier. Ah well.

>  void git_config_set_multivar_in_file(const char *config_filename,
>  				     const char *key, const char *value,
> -				     const char *value_regex, int multi_replace)
> +				     const char *value_regex, unsigned flags)

And some more signature conversions. [snip]

>  /**
>   * takes four parameters:
> @@ -276,13 +289,15 @@ int git_config_set_multivar_in_file_gently(const char *, const char *, const cha
>   * - the value regex, as a string. It will disregard key/value pairs where value
>   *   does not match.
>   *
> - * - a multi_replace value, as an int. If value is equal to zero, nothing or only
> - *   one matching key/value is replaced, else all matching key/values (regardless
> - *   how many) are removed, before the new pair is written.
> + * - a flags value with bits corresponding to the CONFIG_FLAG_* macros.
>   *
>   * It returns 0 on success.
>   */
> -void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
> +void git_config_set_multivar_in_file(const char *config_filename,
> +				     const char *key,
> +				     const char *value,
> +				     const char *value_regex,
> +				     unsigned flags);

Nice opportunity to make the header a little easier to read here.
Thanks.

With just one optional comment,

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
