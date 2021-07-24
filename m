Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FC7C4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 10:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAD960E97
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 10:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhGXJTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhGXJTa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 05:19:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B9AC061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 03:00:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso7157857pjs.2
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RFczsvPpBlqAEZHfVoayhC55ufPPID+5ux3DDBflNgY=;
        b=cp6VAklanYbfWP/HWV957SYpF/hzRvooQ3FmB6ITUiT3r7UhxxO5Pc1WGqLiaib91x
         mXqpLfSujwvz5oD8vSbtTKMx12Web53wLYTYVf1HR5Bd0fw2hGsKeahmouJgr957TPGL
         mrWU1185ZCL2m5vkTzz3riZ907or+6WzQzAv0Ay46hdi6Pbn5JZjlhJdbHM+YCXvT/X2
         tCbgUwpjyfIkXiWwjxh6/VNDmh7niYmnHST2UoM7oBugsPZQd1/8JdKxs2zZ+CuFK2I3
         Ubhd5rp9D3oNz1kpzZA+vipI3UTo4th23OFL6qnir0jm3sfe1HWLX5bgIZbaSOPqQjRm
         Ehnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RFczsvPpBlqAEZHfVoayhC55ufPPID+5ux3DDBflNgY=;
        b=b563bvwQw10SLlvFsE78rUu5z6LJC1ekAbPuvHdUi24KN3nct8hmAEa2NM/glMysBw
         XyZe4+nf6vd+M5mJhU5VfyjG77dfB0hQ6J8WrM+G4lMZnqRhcEJTNU2+kRposqdvRqPo
         Rx1bUFS1yf598tkp77/4yV/lMgdMsrW8cni+ilZ6Fbt/aAQCQ0eY0UIK0cOJamfSR1Ox
         79ES8R0wmsh4qhecQ4hFr7pcZzwzhWExS8q3o1JXkTu6fiS1WZXQ9Vjay+QYcA6UlwrQ
         RU5Rk/dM93eHES+yofY7Ub5NNrVEYIjDaDCfVzsPiv4Uto1mgPjyAzIlNetjECVXtk0l
         tCPw==
X-Gm-Message-State: AOAM531ljy2tN+9eY+ED+bDWSWz14mOb99JIpBIZeY+j0LhDr1gbxLDI
        icD4MH3vNh2/5hYm6HQcRSQ=
X-Google-Smtp-Source: ABdhPJxy3Lo/dlC3jc/CejJI1mlV35+FKDEiM6raOuWP7lnWFOdC8Sk6KCNqwdRZZkMhuI3t/lPWtg==
X-Received: by 2002:a65:594d:: with SMTP id g13mr8740040pgu.329.1627120801295;
        Sat, 24 Jul 2021 03:00:01 -0700 (PDT)
Received: from [192.168.0.46] ([119.82.121.47])
        by smtp.gmail.com with UTF8SMTPSA id oj4sm8132218pjb.56.2021.07.24.02.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 03:00:00 -0700 (PDT)
Message-ID: <a6de518a-d4a2-5a2b-28e2-ca8b62f2c85b@gmail.com>
Date:   Sat, 24 Jul 2021 15:29:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0
Subject: Re: [GSoC] [PATCH] submodule--helper: introduce add-config subcommand
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
References: <20210722112143.97944-1-raykar.ath@gmail.com>
 <xmqq4kckn4x1.fsf@gitster.g>
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <xmqq4kckn4x1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/07/21 02:06, Junio C Hamano wrote:
> Atharva Raykar <raykar.ath@gmail.com> writes:
> 
>> This is meant to be a faithful conversion from shell to C, with only one
>> minor change: A warning is emitted if no value is specified in
>> 'submodule.active', ie, the config looks like: "[submodule] active\n",
> 
> ... meaning that submodule.active is *not* a boolean.
> 
> In scripted porcelain, I think we let "submodule--helper is-active"
> to inspect its value(s), which may end up feeding a NULL as one of
> the pathspec elements when calling parse_pathspec(), so this may
> even be a bugfix.  In any case, I think "submodule--helper
> is-active" is where such a fix should happen and in the longer term,
> the code that says "if submodule.active exists, ask is-active and
> set submodule.*.active accordingly, otherwise activate everything"
> we see in this patch should be simplified to always ask is-active
> and let is-active worry about cases like missing submodule.active
> and submodule.active being valueless true, so let's not worry too
> much about what happens in this patch, because it needs to be
> cleaned up anyway after the dust settles.

Okay, that makes sense. I'll remove the extra warning and special
handling and make it a bug-for-bug conversion for now, so that the
cleanup can be handled afterwards. It will probably be more fitting to
have this change 'is_submodule_active()' afterwards. I'll maybe add a
NEEDSWORK comment for now?

>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 862053c9f2..9658804d24 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2936,6 +2936,130 @@ static int add_clone(int argc, const char **argv, const char *prefix)
>>  	return 0;
>>  }
>>  
>> +static void config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
>> +{
>> +	char *key;
>> +
>> +	if (!is_writing_gitmodules_ok())
>> +		die(_("please make sure that the .gitmodules file is in the working tree"));
>> +
>> +	key = xstrfmt("submodule.%s.%s", name, var);
>> +	config_set_in_gitmodules_file_gently(key, value);
> 
> This uses _gently() to avoid dying, but does it discard error return
> and hide it from our callers?
> 
>> +	free(key);
>> +}
>> +
>> +static void configure_added_submodule(struct add_data *add_data)
>> +{
>> +	char *key, *submod_pathspec = NULL;
>> +	struct child_process add_submod = CHILD_PROCESS_INIT;
>> +	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
>> +	int pathspec_key_exists, activate = 0;
>> +
>> +	key = xstrfmt("submodule.%s.url", add_data->sm_name);
>> +	git_config_set_gently(key, add_data->realrepo);
>> +	free(key);
>> +
>> +	add_submod.git_cmd = 1;
>> +	strvec_pushl(&add_submod.args, "add",
>> +		     "--no-warn-embedded-repo", NULL);
>> +	if (add_data->force)
>> +		strvec_push(&add_submod.args, "--force");
>> +	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
>> +
>> +	if (run_command(&add_submod))
>> +		die(_("Failed to add submodule '%s'"), add_data->sm_path);
>> +
>> +	config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path);
>> +	config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo);
>> +	if (add_data->branch)
>> +		config_submodule_in_gitmodules(add_data->sm_name,
>> +					       "branch", add_data->branch);
> 
> A failure in any of the above in the scripted version used to result
> in "failed to register submodule" error, but they are now ignored.
> Intended?

This was not intended. I think I did not notice those expressions were
chained in the scripted version. I'll fix this.

>> +	add_gitmodules.git_cmd = 1;
>> +	strvec_pushl(&add_gitmodules.args,
>> +		     "add", "--force", "--", ".gitmodules", NULL);
>> +
>> +	if (run_command(&add_gitmodules))
>> +		die(_("Failed to register submodule '%s'"), add_data->sm_path);
>> +
>> +	/*
>> +	 * NEEDSWORK: In a multi-working-tree world this needs to be
>> +	 * set in the per-worktree config.
>> +	 */
>> +	pathspec_key_exists = !git_config_get_string("submodule.active",
>> +						     &submod_pathspec);
>> +	if (pathspec_key_exists && !submod_pathspec) {
>> +		warning(_("The submodule.active configuration exists, but the "
>> +			  "pathspec was unset. If the submodule is not already "
>> +			  "active, the value of submodule.%s.active will be "
>> +			  "be set to 'true'."), add_data->sm_name);
>> +		activate = 1;
>> +	}
>> +
>> +	/*
>> +	 * If submodule.active does not exist, or if the pathspec was unset,
>> +	 * we will activate this module unconditionally.
>> +	 *
>> +	 * Otherwise, we ask is_submodule_active(), which iterates
>> +	 * through all the values of 'submodule.active' to determine
>> +	 * if this module is already active.
>> +	 */
>> +	if (!pathspec_key_exists || activate ||
>> +	    !is_submodule_active(the_repository, add_data->sm_path)) {
>> +		key = xstrfmt("submodule.%s.active", add_data->sm_name);
>> +		git_config_set_gently(key, "true");
>> +		free(key);
>> +	}
> 
> This is the part I discussed earlier.  I think this "optimize so
> that we can avoid calling is_submodule_active()" should go away in
> the long run.  In the current code, is_submodule_active() needs to
> find out the value of submodule.active itself anyway, so the
> short-circuit is not working as an optimization.

Agreed.

> Other than the "what happens when we see errors?" issue, the patch
> looks quite straight-forward rewrite from the scripted version.
> 
> Thanks.
> 

