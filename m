Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ED9C4320A
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA59E60C40
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhG2Taz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhG2Taz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:30:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D8BC061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:30:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so17282868pjb.0
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dRX5THqmsc6pS2wXgPdgU+wmBZ34bKA4fFs5tSAhwqo=;
        b=urf/1icGufp67OVdt8ptKTbs94CFcor4P2MsNxy8+iUc/v/0ScjAiyQ52HGKuhgXpJ
         3+ENic0a9M5P0EFLeJdOvN0716nYYUD+NceociljAfuOeOEe2nve5T7S6lWW/s+xGuW3
         gSsJrXNNRdtL60+qXCd1cx6R36oW6nyR7cHHEr/r51380c2YhnoJLSHdbSeHfGw0YzwR
         I2IRGlAI5t6WumK8hMHxyB1SVQoGg95KJRxaOjKymGVquvTm7oQDhC07bv9IlaXb7PZl
         hrxa9SYM6N6W1F7keAVjrabr1ACPGM0TSguqXgsx/A6pPiOLeDzxTIjFQtle1J+epv1k
         p1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dRX5THqmsc6pS2wXgPdgU+wmBZ34bKA4fFs5tSAhwqo=;
        b=BgHqmgRpkcvoLgcguRu6swmIDveVnmSBZEVIfX+PjN41EX8jq2oi23K7Zoy7KjSIM4
         KUCm+8i1nE3449gAWFJh6htDUVbJmNjuiaZ5eYXTFxLRbt9KF94wr8ouxMCMOYPZgYsp
         NnOq9rIvMBG4zrRpBEm7UzKQUyST3NT+Edi+F/aCFA+otyvxLMKJgJd1AhncXs+RcCML
         q5oP345kzZ/EQ06hRvLaCm31gOt80FFTyuKGnSBpS99HTjKNu0eDHvgB/pupkgL242wi
         2PaTvp/lso0gezWxBlMQLuvUp1Nz7ZKS0IFnwRXRBd3S34B8c0O0pwTu+kDnQHXChPk1
         3wiw==
X-Gm-Message-State: AOAM530sfl2sPl6DkBakUZqwOC4zG2GYoLGpdHI2NBpvyF1T2q05r7kU
        KqeoDkazn5bzTN/a/bKSB2HM2qTXwir5VFrD
X-Google-Smtp-Source: ABdhPJxbx+F6mVF1C/cnre3fVLrba2Z3rYa4beVPZsvnG20aziy+3UHWgiP88nz5vpcuw+vJFFMQRg==
X-Received: by 2002:a17:902:9a04:b029:12b:8d54:7c2 with SMTP id v4-20020a1709029a04b029012b8d5407c2mr6222470plp.62.1627587051158;
        Thu, 29 Jul 2021 12:30:51 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.83.241])
        by smtp.gmail.com with ESMTPSA id w2sm10111565pjd.35.2021.07.29.12.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 12:30:50 -0700 (PDT)
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
 <07070c45-5761-b67e-59b1-aa90f8cd877b@gmail.com>
 <d206fa7a-a450-552b-824c-518ee481c480@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <251ef131-bdd1-3881-659e-3caf20b65a53@gmail.com>
Date:   Fri, 30 Jul 2021 01:00:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d206fa7a-a450-552b-824c-518ee481c480@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/07/21 11:05 pm, Atharva Raykar wrote:
> (apologies for the reflowed text, seems to only happen when replying to
> this message?? Won't affect this response much though)
> 

In case you're using thunderbird then you could see if the following helps:

http://kb.mozillazine.org/Plain_text_e-mail_%28Thunderbird%29#Flowed_format

> On 29/07/21 01:21, Kaartic Sivaraam wrote:
>> Hi Atharva,
>>
>> On 28/07/21 5:23 pm, Atharva Raykar wrote:
>>> Add a new "add-config" subcommand to `git submodule--helper` with the
>>> goal of converting part of the shell code in git-submodule.sh related to
>>> `git submodule add` into C code. This new subcommand sets the
>>> configuration variables of a newly added submodule, by registering the
>>> url in local git config, as well as the submodule name and path in the
>>> .gitmodules file. It also sets 'submodule.<name>.active' to "true" if
>>> the submodule path has not already been covered by any pathspec
>>> specified in 'submodule.active'.
>>>
>>> This is meant to be a faithful conversion from shell to C, with only one
>>> minor change: A warning is emitted if no value is specified in
>>> 'submodule.active', ie, the config looks like: "[submodule] active\n",
>>> because it is an invalid configuration. It would be helpful to let the
>>> user know that the pathspec is unset, and the value of
>>> 'submodule.<name>.active' might be set to 'true' so that they can
>>> rectify their configuration and prevent future surprises (especially
>>> given that the latter variable has a higher priority than the former).
>>>
>>
>> v2 doesn't have the warning that this paragraph describes. So, this could
>> be dropped.
> 
> My bad, looks like I forgot to edit the commit message.
> 
>>> [ snip ]
>>>
>>> A comment has been
>>> added to explain that only one value of 'submodule.active' is obtained
>>> to check if we need to call is_submodule_active() at all.
>>>
>>
>> This could be me likely not understanding this properly. Anyways, where
>> is this comment in the code? I only see a comment about how
>> 'is_submodule_active'
>> iterates over all values. I couldn't find any "one value" reference in it.
> 
> Looks like my comment does not explain it clearly. It would have made
> more sense to start the comment with "If there is no value found for
> submodule.active", but I think instead of modifying that comment (which
> is clear enough as it is), I'll make the commit message better, by
> removing the mention of the "we check one value".
> 
> It seems like the line:
> 
> 	if (git_config_get_string("submodule.active", &val)
> 
> makes it clear that a single string is being queried first. The larger
> point was about why that conditional was needed, if we were going to
> call 'is_submodule_active()' to retrieve the value anyway.
> 

Ah. Now I get the idea. A rephrasing might indeed make this clear.

>>> +    if (config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path) ||
>>> +        config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo))
>>> +        die(_("Failed to register submodule '%s'"), add_data->sm_path);
>>> +
>>> +    if (add_data->branch)
>>> +        if (config_submodule_in_gitmodules(add_data->sm_name,
>>> +                           "branch", add_data->branch))
>>> +            die(_("Failed to register submodule '%s'"), add_data->sm_path);
>>> +
>>> +    add_gitmodules.git_cmd = 1;
>>> +    strvec_pushl(&add_gitmodules.args,
>>> +             "add", "--force", "--", ".gitmodules", NULL);
>>> +
>>> +    if (run_command(&add_gitmodules))
>>> +        die(_("Failed to register submodule '%s'"), add_data->sm_path);
>>> +
>>
>> We could restructure this portion like so ...
>>
>> -- 8< --
>>          add_gitmodules.git_cmd = 1;
>>          strvec_pushl(&add_gitmodules.args,
>>                       "add", "--force", "--", ".gitmodules", NULL);
>>>                                                                                                                                           
>>          if (config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path) ||
>>              config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo) ||
>>              (add_data->branch && config_submodule_in_gitmodules(add_data->sm_name,
>>                                                                  "branch", add_data->branch)) ||
>>              run_command(&add_gitmodules))
>>                  die(_("Failed to register submodule '%s'"),
>> add_data->sm_path);
>> -- >8 --
>>
>> .. to avoid the redundant "Failed to register submodule ..." error message.
>> Whether the restructured version has poor readability or not is debatable, though.
> 
> Yeah, I felt the redundancy in this case was okay, I find that big
> conditional rather hard to read.
> 

I tried to make it as easy to read as possible but its a really long one
indeed. So, I could understand. But the redundancy bothered me a bit ;-)

>>> +    /*
>>> +     * NEEDSWORK: In a multi-working-tree world this needs to be
>>> +     * set in the per-worktree config.
>>> +     *
>>
>> It might be a good idea to differentiate the NEEDSWORK comment from an
>> informative comment about the code snippet.
> 
> Okay. I suppose you mean give this part it's own closing delimiter and
> start the next line with a new multiline comment.
> 

Yeah. I did mean this.

> If you meant something else, do let me know.
> 
>> Also, you could add another NEEDSWORK/TODO comment regarding the change
>> to 'is_submodule_active' which you mention before[1].
>>
>> [1]: https://public-inbox.org/git/a6de518a-d4a2-5a2b-28e2-ca8b62f2c85b@gmail.com/
> 
> Good point. I'll add it.
> 
>>> +     * If submodule.active does not exist, or if the pathspec was unset,
>>> +     * we will activate this module unconditionally.
>>> +     *
>>> +     * Otherwise, we ask is_submodule_active(), which iterates
>>> +     * through all the values of 'submodule.active' to determine
>>> +     * if this module is already active.
>>> +     */
>>> +    if (git_config_get_string("submodule.active", &val) ||
>>> +        !is_submodule_active(the_repository, add_data->sm_path)) {
>>> +        key = xstrfmt("submodule.%s.active", add_data->sm_name);
>>> +        git_config_set_gently(key, "true");
>>> +        free(key);
>>> +    }
>>
>> It might be a good idea to expand this condition similar to the scripted version,
>> to retain the following comment which seems like a useful one to keep.
> 
> I felt that this version had less redundant code, and hence seemed more
> readable than the expanded conditional in shell.
> 
> For comparison this is the same code imitating the shell version:
> 
> if (!git_config_get_string("submodule.active", &var) && var) {
> 
> 	/*
> 	 * If the submodule being added isn't already covered by the
> 	 * current configured pathspec, set the submodule's active flag
> 	 */
> 	if (!is_submodule_active(the_repository, info->sm_path)) {
> 		key = xstrfmt("submodule.%s.active", info->sm_name);
> 		git_config_set_gently(key, "true");
> 		free(key);
> 	}
> 
> } else {
> 	key = xstrfmt("submodule.%s.active", info->sm_name);
> 	git_config_set_gently(key, "true");
> 	free(key);
> }
> 
> It repeats the string allocation and freeing, and also is a lot more
> code to parse mentally while reading. The shorter version that I used
> does not feel more "clever" to me than this either.
> 
> As for the comment, I felt that the new one I introduced (Otherwise, we
> ask ...) covers the same ground.
> 

I think the comment you introduced only mentions that 'is_submodule_active'
iterates over configs to determine that a submodule is active. It doesn't mention
that we set the submodule's active flag if the submodule is not covered by the
current configured pathspec, which is what the original tries to convey.
Correct me if I missed anything.

> I am open to reverting to the expanded conditional, but it would be nice
> if you could help me understand the motivation behind why it should be done.
> 

I'm not against short-circuiting the conditional. I suggested expanding the conditional
so that we get a structure similar to the scripted version. That way we could keep the
original comment close to the inside conditional where it felt relevant :)

>>> [ snip ]
>>>
>>> -    if git config --get submodule.active >/dev/null
>>> -    then
>>> -        # If the submodule being adding isn't already covered by the
>>> -        # current configured pathspec, set the submodule's active flag
>>> -        if ! git submodule--helper is-active "$sm_path"
>>> -        then
>>> -            git config submodule."$sm_name".active "true"
>>> -        fi
>>> -    else
>>> -        git config submodule."$sm_name".active "true"
>>> -    fi
>>> +    git submodule--helper add-config ${force:+--force}
>>> ${branch:+--branch "$branch"} --url "$repo" --resolved-url "$realrepo"
>>> --path "$sm_path" --name "$sm_name"
>>>    }
>>>      #
>>>
>>
> 


-- 
Sivaraam
