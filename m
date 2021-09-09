Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C3C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C898461207
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhIIOkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243977AbhIIOkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:40:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B609C1A2702
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 06:57:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s24so1424064wmh.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7YRBMWpIz7Co39C7px/QXHKO4R84JzGL3ch60IcQFCY=;
        b=g+zvBLQRvE6dGF5iBk7AdEuNz2WOJuaaE94DVj7SLwZPb0zinRjBgrRpQgXd/Hg1Yu
         NQvEb8NJdjfmWulUVSqss0G2BQxTI+dPAVMOuGGjVInuRpz4aK+EDqYAK34cG4ViD9+V
         ymh+bLeALX0spk3ePug26CP7tW3cceGuJxbtaViTB3HM1SMrUQ86Ip4xnmsDbGyecyWJ
         annozOUe0J4Rlde3rKB18CXO6ALQwhkISgeQ7Y4q5aHfVjcUhu5jEPsSt41QdatLERMe
         PRO2Ffphep0nF0SGvcbAg72x9obIzYK3sxXAYQ3ovThPvpiU0OsOnLRQOLL1heaZ36ZW
         BuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7YRBMWpIz7Co39C7px/QXHKO4R84JzGL3ch60IcQFCY=;
        b=06Y8p31cu7Re8j3T4rOatex29oaMS+3o6SCwXoLG16Q4L4EpbUMDDv2yo3/uJ5hI4Z
         PFY12D8XG58YI/WkK00/WODB+1PHaQ1nR4/HL9J1b6Bremz5S8qUERcNjdyjQCcq4lIw
         7NCLrxkd20RLpqupJP31UG1xcAnoFLKM0pxRXRKtS1xh5EMMULnYDkAttSc0X/6Fu10U
         knf4h3/knFKVkOgPH7e1D7jd78wlGsO9nY7INs9Hi8Y3pmNoA/zzE4a2uxypMO2vhLz8
         47JBOvZ4rYc7GEEnOFXv/bYkv4qPx73poSHB3S6TD+3INRe2rOFSWFW64gVQ901SKTVZ
         hUhA==
X-Gm-Message-State: AOAM533lfXUOOw5Vpv/KMnu7GxGPbu84Po0bXjwKQlW/SNKQVntGpQ1X
        rKXAjgKxrX0RZYWJooCvFfw=
X-Google-Smtp-Source: ABdhPJxAS9hM7skY/kpRM0D85RzFIV4LJVj0CADFqBa9ApAFkrN7OLdLigZr86y5hj9eveypm580uw==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr3189031wmk.51.1631195853148;
        Thu, 09 Sep 2021 06:57:33 -0700 (PDT)
Received: from [192.168.1.240] (187.96.189.80.dyn.plus.net. [80.189.96.187])
        by smtp.gmail.com with ESMTPSA id z2sm1778985wma.45.2021.09.09.06.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 06:57:32 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
 <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
 <c42d4051-59cd-094a-4570-32cf4d38ec27@gmail.com>
 <e7224105-83c6-7f12-f63a-474bd477583a@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <408dc1d3-44b8-a955-4d7b-94f23fa8a6bc@gmail.com>
Date:   Thu, 9 Sep 2021 14:57:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e7224105-83c6-7f12-f63a-474bd477583a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe

On 09/09/2021 13:40, Philippe Blain wrote:
>>> While in general I think it's a good thing to avoid forking, this
>>> change might result in behavioral differences. Any config that
>>> affects 'git checkout' but not the internal 'reset.c::reset_head'
>>> function might play a role in the rebase UX.
>>>
>>> One that immediately came to mind is 'submodule.recurse'. This
>>> initial 'onto' checkout was pretty much the only part of 'git
>>> rebase' that did something useful for submodules, so it's kind of
>>> sad to see it regress.
>>
>> Thanks for pointing that out. As a non-submodule user my question
>> would be is it actually useful for the initial checkout to work that
>> way if the rest of rebase (and the checkout for the am backend)
>> ignores submodules? reset.c::reset_head() just uses unpack trees like
>> checkout so if rebase read 'submodule.recurse' then reset_head()
>> would work like 'git checkout' and also 'git rebase --abort' and the
>> "reset" command in the todo list would start checking out submodules.

it would also affect fast-forwards

>> I'm reluctant to do that until the merge backend also handles
>> submodules unless there is a good reason that such partial submodule
>> support would help submodule users.
> 
> Yeah, it's not that useful, I have to admit; it can also be very confusing
> since some parts of rebase are affected, and some not. For example, any 
> time
> the rebase stops, like for 'edit', 'break', and when there are 
> conflicts, the
> submodules are not updated. So I think a full solution is better than a 
> partial
> solution; in the meantime I'm thinking the change you are proposing 
> would actually
> be less confusing, even if it slightly changes behaviour...
> 
> As an aside, I *think* reading submodule.recurse in rebase like it's 
> done in checkout
> et al., i.e. something like this:
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 33e0961900..125ec907e4 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -26,6 +26,7 @@
>   #include "rerere.h"
>   #include "branch.h"
>   #include "sequencer.h"
> +#include "submodule.h"
>   #include "rebase-interactive.h"
>   #include "reset.h"
> 
> @@ -1106,6 +1107,9 @@ static int rebase_config(const char *var, const 
> char *value, void *data)
>           return git_config_string(&opts->default_backend, var, value);
>       }
> 
> +    if (!strcmp(var, "submodule.recurse"))
> +        return git_default_submodule_config(var, value, data);

That looks about right to me though I think it would be safer to call 
git_default_submodule_config() for submodule.* rather than just 
submodule.recurse

>       return git_default_config(var, value, data);
>   }
> 
> 
> would actually also affect the merges
> performed during the rebase, since that would affect the "global" state 
> in submodule.c.
> I hacked exactly that the other day but did not test extensively...

merge-ort.c:checkout() which is used by merge_switch_to_result() uses 
unpack_trees() so it will pick up the global state and hopefully should 
just work (cc'ing Elijah to check as I didn't look what happens when 
there are conflicts). merge-recursive.c:update_file_flags() does this 
when updating the work tree

        if (S_ISGITLINK(contents->mode)) { 

                 /* 

                  * We may later decide to recursively descend into 

                  * the submodule directory and update its index 

                  * and/or work tree, but we do not do that now. 

                  */ 

                 update_wd = 0; 

                 goto update_index; 

        } 

 

so it looks like it does not update the submodule directory. Given 
merge-ort is now the default perhaps it's time for rebase (and 
cherry-pick/revert) to start reading the submodule config settings (we 
parse the config before we know if we'll be using merge-ort so I don't 
know how easy it would be to only parse the submodule settings if we are 
using merge-ort).

Best Wishes

Phillip
