Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C5C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 18:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B4661154
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbhHESZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 14:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240172AbhHESZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 14:25:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF20C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 11:25:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l19so11024504pjz.0
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+GITS2m+EcixkmBguSTMaKO0ZEIcH4TS+KT/8snqcBE=;
        b=tlT2Mbysh/yqLVlpFoMs1W2D6TQ38wAKtMZmuc37vBS9YgOnAv9P6rsVkhQXeuDUUn
         +He1M/cibLEnVgUEAIkte8qx0nrFhOA6lLSDeOe1GLy97J4wvt/Novh9stMEUKwOms3e
         2zlUuV3yf6UIKkogIfgYvPRbpI7Fvs4praeaDLkDZfBmwjziJpxCnQvYEvZMz47m3O8I
         j07aNmjSSHkLYirQdJNaff55ziMd2vUd86b3emfB3CagkPZCZeUcghUymcK8BitdO6Yx
         zgRvkZBqnKBBU2AFgsGXJf1RKTAc55htYFl2G/dzkLWYcRikw21/ItMkCYocOwG3H/jg
         WXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+GITS2m+EcixkmBguSTMaKO0ZEIcH4TS+KT/8snqcBE=;
        b=XtLLClW808DtBshxO908kdT7gGmm0rEKjzhpo8KROFHkxZ+u0WS3ymL6JzjaOih9d1
         HdsKF2bVsSC+kWHJVlSYadk3C+2yK1PnW8ok5Jt1SExsBFNwvaOlIWjYTeVsk8/9u9aH
         jXH6q+MkS09Lnm+NWQmbBHqkexdP5U5nYVRaKgtvezqpRbqfgl8yu/t6PJvzqdRaHD0h
         s1E4Tx1MzQ1nLlr9MP6ug3mEkm4GDm1CUWzNeMpin2Vb5oGb/FzEjWFPbwgBE70U/XH3
         jOIVObJO2DGz3Oc/g9cSYx25AwmNQ6x4S6z1aR9nXkWx8MwEVxl0dQjYIoWfdXa5Ein+
         dQeQ==
X-Gm-Message-State: AOAM533tZkoJ59wBDDbrWUPwE6tXzBC0djArAi1nTz2G5jnPVH1W3jgs
        TnBpY7qwbn4GcAcyJwK5hAhTcNddlsrLCA==
X-Google-Smtp-Source: ABdhPJwQqjH+hIjl8/B8sIedLSuUKz2k9hz9RA4hFZXXzsNkjAbggDSkAui9eZgTVh8swG+OUvV59w==
X-Received: by 2002:a63:6c5:: with SMTP id 188mr225316pgg.39.1628187933554;
        Thu, 05 Aug 2021 11:25:33 -0700 (PDT)
Received: from [192.168.208.38] ([183.82.191.73])
        by smtp.gmail.com with ESMTPSA id z18sm3246121pfn.88.2021.08.05.11.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 11:25:33 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v3] submodule--helper: introduce add-config
 subcommand
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org
References: <20210728115304.80643-1-raykar.ath@gmail.com>
 <20210801063352.50813-1-raykar.ath@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <1013ed94-ad4f-6ec8-09fb-772edea4ea05@gmail.com>
Date:   Thu, 5 Aug 2021 23:55:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210801063352.50813-1-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08/21 12:03 pm, Atharva Raykar wrote:
> Add a new "add-config" subcommand to `git submodule--helper` with the
> goal of converting part of the shell code in git-submodule.sh related to
> `git submodule add` into C code. This new subcommand sets the
> configuration variables of a newly added submodule, by registering the
> url in local git config, as well as the submodule name and path in the
> .gitmodules file. It also sets 'submodule.<name>.active' to "true" if
> the submodule path has not already been covered by any pathspec
> specified in 'submodule.active'.
> 
> This is meant to be a faithful conversion from shell to C, although we
> add comments to areas that could be improved in future patches, after
> the conversion has settled.
> 
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>

The v3 mostly looks good to me. Just one style nit:

> [ ... ]
>
> +static void configure_added_submodule(struct add_data *add_data)
> +{
> +	char *key;
> +	char *val = NULL;
> +	struct child_process add_submod = CHILD_PROCESS_INIT;
> +	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
> +
> +	key = xstrfmt("submodule.%s.url", add_data->sm_name);
> +	git_config_set_gently(key, add_data->realrepo);
> +	free(key);
> +
> +	add_submod.git_cmd = 1;
> +	strvec_pushl(&add_submod.args, "add",
> +		     "--no-warn-embedded-repo", NULL);
> +	if (add_data->force)
> +		strvec_push(&add_submod.args, "--force");
> +	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
> +
> +	if (run_command(&add_submod))
> +		die(_("Failed to add submodule '%s'"), add_data->sm_path);
> +
> +	if (config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path) ||
> +	    config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo))
> +		die(_("Failed to register submodule '%s'"), add_data->sm_path);
> +
> +	if (add_data->branch)
> +		if (config_submodule_in_gitmodules(add_data->sm_name,
> +						   "branch", add_data->branch))
> +			die(_("Failed to register submodule '%s'"), add_data->sm_path);
> +

As the body of if(add->branch) has a nested if in it and totally spans 3 lines, it might
be a good idea to wrap it in braces like so:

         if (add_data->branch) {
                 if (config_submodule_in_gitmodules(add_data->sm_name,
                                                    "branch", add_data->branch))
                         die(_("Failed to register submodule '%s'"), add_data->sm_path);
         }


... or collapse both conditionals into a single if like so:

         if (add_data->branch &&
             config_submodule_in_gitmodules(add_data->sm_name, "branch", add_data->branch))
                 die(_("Failed to register submodule '%s'"), add_data->sm_path);

-- 
Sivaraam
