Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020DC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3742077D
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5n9kbLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbgDCNJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:09:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38230 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgDCNJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 09:09:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id f6so7630152wmj.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BvEJywZYoI/wt+GRTLvTKvnb8kzDKFwzxaEX0fYWPg4=;
        b=W5n9kbLYkG27PjkuY++OXa0SOoLTEtkI/6kRKHs5IEPd7TETIri2s5Ken1YXNDDQrH
         0Oqbuo1eDveSkQrEAqnZTYOdpqaGuhaEXkmHA4VWd9XSd810MT55Pwr442T81lP4TjXB
         xO2GowpbwwV4L1WOknX5EUq8q/SHKyaS6C+tyM/E/XOeP5t3d+rfHPfsA8HUoZSA19/R
         B8QgXMzonBqQBRBLBcnUHdmGSC48w+LjJk9NmUqdgfLhhF3IYGaiSD+XskXKoYBu3wo4
         I/+HPaJkqbXI3Zwh84oJvKaAfMXQbIhM3gG1GGkcos+8lIWFPQWkn5gUHlURcyX4cmbl
         MuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BvEJywZYoI/wt+GRTLvTKvnb8kzDKFwzxaEX0fYWPg4=;
        b=pv54hv3IUlQpzMTiih0KodKEXX3hRPUMstQpPfoHszPJ2NF6kR1b1wNeK5ypbDn9Lg
         kXgXlip2ADJ6yGqvh3UShjuItjSRNTOskjYzq5uLYvnIqnL+lDogxEkpKukwLCkQI6ni
         fiVFvoU6Ffp0VcHI9IRgVIAkeQwEFEOgnNFFSZhdOSV7VSJyD09+BDfiEsXZXSCvot+L
         Rj8EVABEObRwVrJryg2LZQLHELrmn33sp7geFUQg9iBTgqp5sG8oX5HKN/eJfSbitTx6
         rYvmCEFbB7IIVIxIVQR/+UMKl5MVb1h6zV4KJNLxGsJCbJvsZWClDC/N5SpmzrYbS+zU
         a75w==
X-Gm-Message-State: AGi0PubNFvSPFC7n1WjsYiud3pARte+bJHEltui/lHwfwjiUFJ/BkYHK
        lkmsbax4dVwcy26+MeUxn6c=
X-Google-Smtp-Source: APiQypI/y6hfbyk0/TffL1QLRFsbroUQd+m7efKib4kzi3Dm8ZoQ5ZcvH7aXF11M02oKyheSZLXpLw==
X-Received: by 2002:a05:600c:54d:: with SMTP id k13mr8478672wmc.81.1585919368529;
        Fri, 03 Apr 2020 06:09:28 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id c6sm8988573wrm.85.2020.04.03.06.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:09:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 17/19] merge: teach --autostash option
To:     Denton Liu <liu.denton@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <9e3d4393cae8813cc4718c6ffcc28231b1344fbe.1584782450.git.liu.denton@gmail.com>
 <cd7cb5aa-0a08-29dc-e1cc-f65a4010622f@gmail.com>
 <20200403103126.GA3163329@generichostname>
 <20200403105639.GA3193506@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <faa275d4-ca5d-9ab9-cbcb-aebd5e53e20b@gmail.com>
Date:   Fri, 3 Apr 2020 14:09:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403105639.GA3193506@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 03/04/2020 11:56, Denton Liu wrote:
> On Fri, Apr 03, 2020 at 06:31:26AM -0400, Denton Liu wrote:
>>>> diff --git a/builtin/reset.c b/builtin/reset.c
>>>> index 18228c312e..038c8532eb 100644
>>>> --- a/builtin/reset.c
>>>> +++ b/builtin/reset.c
>>>> @@ -25,6 +25,7 @@
>>>>    #include "cache-tree.h"
>>>>    #include "submodule.h"
>>>>    #include "submodule-config.h"
>>>> +#include "sequencer.h"
>>>>    #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
>>>> @@ -437,8 +438,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>>>    		if (reset_type == HARD && !update_ref_status && !quiet)
>>>>    			print_new_head_line(lookup_commit_reference(the_repository, &oid));
>>>>    	}
>>>> -	if (!pathspec.nr)
>>>> +	if (!pathspec.nr) {
>>>> +		if (reset_type == HARD)
>>>> +			save_autostash(git_path_merge_autostash(the_repository));
>>>> +
>>>>    		remove_branch_state(the_repository, 0);
>>>
>>> This removes the autostash file for all reset types but we only keep the
>>> stash in the case of 'reset --hard' which is confusing.
>>
>> I was worried that this change would be controversial... The rationale
>> behind this change was that with `reset --hard`, we want to leave a
>> clean working tree behind so we save it into the stash reflog. In all
>> other cases, remove_branch_state() will apply the saved stash entry
>> which should be fine since users don't expect a clean worktree with the
>> other reset types.
>>
>> I considered saving the autostash in all cases of reset but
>> `git merge --abort` invokes `git reset --merge` behind the scenes so
>> we'd have to consider that. Perhaps we can make all resets save the
>> stash entry and, in the case of `merge --abort`, we can add some extra
>> logic to subvert this so that the stash entry is applied?
> 
> Perhaps something like this?
> 
> -- >8 --
> commit 14d0b569cb7675f00d32d3d7fad7564fcaeca458
> Author: Denton Liu <liu.denton@gmail.com>
> Date:   Fri Apr 3 06:50:34 2020 -0400
> 
>      squash! merge: teach --autostash option
>      
>      Stash is saved when any reset is run, when git merge --abort is run,
>      stash is applied.

I think this is the easiest behavior to understand, it avoids changing 
the behavior of reset, in particular it stops 'reset --mixed/--soft' 
from suddenly starting to touch the working tree.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 9573d77096..31b82d614c 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1242,6 +1242,8 @@ static int merging_a_throwaway_tag(struct commit *commit)
>   	return is_throwaway_tag;
>   }
>   
> +static GIT_PATH_FUNC(git_path_merge_autostash_saved, "MERGE_AUTOSTASH_SAVED")
> +
>   int cmd_merge(int argc, const char **argv, const char *prefix)
>   {
>   	struct object_id result_tree, stash, head_oid;
> @@ -1295,9 +1297,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   		if (!file_exists(git_path_merge_head(the_repository)))
>   			die(_("There is no merge to abort (MERGE_HEAD missing)."));
>   
> +		if (file_exists(git_path_merge_autostash(the_repository))) {
> +			if (rename(git_path_merge_autostash(the_repository),
> +						git_path_merge_autostash_saved()))
> +				die_errno(_("failed to rename autostash"));

This is a bit of a performance, can't we just remember the stash oid in 
a variable and tweak the apply code?

> +		}
> +
>   		/* Invoke 'git reset --merge' */
>   		ret = cmd_reset(nargc, nargv, prefix);
> -		apply_autostash(git_path_merge_autostash(the_repository));
> +
> +		apply_autostash(git_path_merge_autostash_saved());

Calling cmd_reset() was already a bit dodgy by our normal rules, now 
we're calling other functions after it though I guess given the current 
autostash implementation it's mostly in a separate process.

I think this is a good direction to go in
BTW what message gets printed when the stash is saved?

Best Wishes

Phillip

>   		goto done;
>   	}
>   
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 038c8532eb..060470c455 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -439,9 +439,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>   			print_new_head_line(lookup_commit_reference(the_repository, &oid));
>   	}
>   	if (!pathspec.nr) {
> -		if (reset_type == HARD)
> -			save_autostash(git_path_merge_autostash(the_repository));
> -
> +		save_autostash(git_path_merge_autostash(the_repository));
>   		remove_branch_state(the_repository, 0);
>   	}
>   
>>
>> I'm not sure about what the most intuitive behaviour is. I thought that
>> this implementation would be the best but I'm not entirely sure. I'd
>> appreciate some more discussion on this.
>>
>> Thanks,
>>
>> Denton
>>
>>> Best Wishes
>>>
>>> Phillip
>>>
>>>> +	}
>>>>    	return update_ref_status;
>>>>    }
