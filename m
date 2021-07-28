Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE31BC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED4660E9B
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhG1TvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhG1TvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:51:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C008BC061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:51:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so5680313pji.5
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43gqFfsC52WJMDbcGsS0kKRIH18W6MmpYNDgfkdxKKk=;
        b=VYjkrvsUV4qKmSFZVoWT+uSepAZomL96ARiUr0BOyv/ZOyadeYg1h2urCQ28mtJGtl
         3fmnsN633OeYeK+Fh7/WtlIuoQXThha1uISEPskxBEIlUdycCtTcCLCIYmYSYumimViD
         /+Ch6OyHKDpQVjMGe9zkkhZfJITOQepljS1XCm9u+oafi1i5FyNynrOwwmA+8TogW7w3
         4WJqub5XBoprI75ikxUG9uXFakAsDTmoAnEJPoxYfsjCWWetSofoH77czUBETEXwLBqy
         idxiAQIB8UtJNkrU6WM7676/xE3m5WQVNqmBILdiQYIid7pA6rN3o0qshtNLVkbZdIjX
         xWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43gqFfsC52WJMDbcGsS0kKRIH18W6MmpYNDgfkdxKKk=;
        b=IFpjwMmz6kkbYjwFHpFfVe+a71kO7T4wJNwHg5uP1QWIx1U5Qo7Kwhrbwt3FHUgZUW
         WnVqxUpWuUNVBM34P1XOE6C8T3HVsZbqxycaxuGDE1TLJ8Q7/m6Agb2JS//cr6SqOAeu
         oCGIeR1j8wjpmOVk2rbPCHnn3M6NEkrFopYNFTw7GyCxQhq/cvhmMUYHpBfUUsH4OloS
         I+psT7pi7Tl4RQ61j8WZk+wg6sVG6NK3gxaKSJyaTFHdHiZ654Du91qEE3U0dCtGZldH
         ujQUHQVV02Vg50Rp82z75jT6nVJ9puZn4FKHyPHWOEcHwP+gipkZgkF/5+K1HNWOaqPW
         eVAA==
X-Gm-Message-State: AOAM53290YgdiAWke9R29TI+paOUGBM0+UV1H4fhv6cn26Qr8qoWL/v3
        HFCR+BUtf9XKD0tpMqa4OxGmV7sKSj1cZJeS
X-Google-Smtp-Source: ABdhPJzdb/779Wa2IVJLzKtHRcAfzswISZuJGz5m17qnLOiYNczcO9yTTMYbk9s1saUlyRFHZKy83w==
X-Received: by 2002:a17:90a:940e:: with SMTP id r14mr11028089pjo.41.1627501875156;
        Wed, 28 Jul 2021 12:51:15 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.87.176])
        by smtp.gmail.com with ESMTPSA id d31sm738653pgd.33.2021.07.28.12.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 12:51:14 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v2] submodule--helper: introduce add-config
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
References: <20210722112143.97944-1-raykar.ath@gmail.com>
 <20210728115304.80643-1-raykar.ath@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <07070c45-5761-b67e-59b1-aa90f8cd877b@gmail.com>
Date:   Thu, 29 Jul 2021 01:21:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728115304.80643-1-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 28/07/21 5:23 pm, Atharva Raykar wrote:
> Add a new "add-config" subcommand to `git submodule--helper` with the
> goal of converting part of the shell code in git-submodule.sh related to
> `git submodule add` into C code. This new subcommand sets the
> configuration variables of a newly added submodule, by registering the
> url in local git config, as well as the submodule name and path in the
> .gitmodules file. It also sets 'submodule.<name>.active' to "true" if
> the submodule path has not already been covered by any pathspec
> specified in 'submodule.active'.
> 
> This is meant to be a faithful conversion from shell to C, with only one
> minor change: A warning is emitted if no value is specified in
> 'submodule.active', ie, the config looks like: "[submodule] active\n",
> because it is an invalid configuration. It would be helpful to let the
> user know that the pathspec is unset, and the value of
> 'submodule.<name>.active' might be set to 'true' so that they can
> rectify their configuration and prevent future surprises (especially
> given that the latter variable has a higher priority than the former).
> 

v2 doesn't have the warning that this paragraph describes. So, this could
be dropped.

> [ snip ]
>
> A comment has been
> added to explain that only one value of 'submodule.active' is obtained
> to check if we need to call is_submodule_active() at all.
>

This could be me likely not understanding this properly. Anyways, where
is this comment in the code? I only see a comment about how 'is_submodule_active'
iterates over all values. I couldn't find any "one value" reference in it.
  
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> 
> Changes since v1:
> 
> * Remove the extra handling for the case where submodule.active is valueless, as
>    Junio pointed out that it is better dealt with in a cleanup patch.
> 
> * Do not discard error returns from 'config_submodule_in_gitmodules()', and also
>    ensure that any calls to it in 'configure_added_submodule()' die on failure,
>    like with the original shell porcelain.
> 
> * Style fixes.
> 
>   builtin/submodule--helper.c | 120 ++++++++++++++++++++++++++++++++++++
>   git-submodule.sh            |  28 +--------
>   2 files changed, 121 insertions(+), 27 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 862053c9f2..60b47492cb 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2936,6 +2936,125 @@ static int add_clone(int argc, const char **argv, const char *prefix)
>   	return 0;
>   }
>   
> +static int config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
> +{
> +	char *key;
> +	int ret;
> +
> +	if (!is_writing_gitmodules_ok())
> +		die(_("please make sure that the .gitmodules file is in the working tree"));
> +
> +	key = xstrfmt("submodule.%s.%s", name, var);
> +	ret = config_set_in_gitmodules_file_gently(key, value);
> +	free(key);
> +
> +	return ret;
> +}
> +
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
> +	add_gitmodules.git_cmd = 1;
> +	strvec_pushl(&add_gitmodules.args,
> +		     "add", "--force", "--", ".gitmodules", NULL);
> +
> +	if (run_command(&add_gitmodules))
> +		die(_("Failed to register submodule '%s'"), add_data->sm_path);
> +

We could restructure this portion like so ...

-- 8< --
         add_gitmodules.git_cmd = 1;
         strvec_pushl(&add_gitmodules.args,
                      "add", "--force", "--", ".gitmodules", NULL);
                                                                                                                                                                                              
         if (config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path) ||
             config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo) ||
             (add_data->branch && config_submodule_in_gitmodules(add_data->sm_name,
                                                                 "branch", add_data->branch)) ||
             run_command(&add_gitmodules))
                 die(_("Failed to register submodule '%s'"), add_data->sm_path);
-- >8 --

.. to avoid the redundant "Failed to register submodule ..." error message.
Whether the restructured version has poor readability or not is debatable, though.
                           
> +	/*
> +	 * NEEDSWORK: In a multi-working-tree world this needs to be
> +	 * set in the per-worktree config.
> +	 *

It might be a good idea to differentiate the NEEDSWORK comment from an informative
comment about the code snippet.

Also, you could add another NEEDSWORK/TODO comment regarding the change
to 'is_submodule_active' which you mention before[1].

[1]: https://public-inbox.org/git/a6de518a-d4a2-5a2b-28e2-ca8b62f2c85b@gmail.com/

> +	 * If submodule.active does not exist, or if the pathspec was unset,
> +	 * we will activate this module unconditionally.
> +	 *
> +	 * Otherwise, we ask is_submodule_active(), which iterates
> +	 * through all the values of 'submodule.active' to determine
> +	 * if this module is already active.
> +	 */
> +	if (git_config_get_string("submodule.active", &val) ||
> +	    !is_submodule_active(the_repository, add_data->sm_path)) {
> +		key = xstrfmt("submodule.%s.active", add_data->sm_name);
> +		git_config_set_gently(key, "true");
> +		free(key);
> +	}

It might be a good idea to expand this condition similar to the scripted version,
to retain the following comment which seems like a useful one to keep.

> [ snip ]
>
> -	if git config --get submodule.active >/dev/null
> -	then
> -		# If the submodule being adding isn't already covered by the
> -		# current configured pathspec, set the submodule's active flag
> -		if ! git submodule--helper is-active "$sm_path"
> -		then
> -			git config submodule."$sm_name".active "true"
> -		fi
> -	else
> -		git config submodule."$sm_name".active "true"
> -	fi

> +	git submodule--helper add-config ${force:+--force} ${branch:+--branch "$branch"} --url "$repo" --resolved-url "$realrepo" --path "$sm_path" --name "$sm_name"
>   }
>   
>   #
> 

-- 
Sivaraam
