Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1DC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568C620675
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBC+NToW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403806AbgDCNef (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:34:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38810 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCNee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 09:34:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id c7so8537909wrx.5
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+MS5HnpGNaRcBoAU+scss6vgsGeZXi+yjBCiZKLEy7E=;
        b=kBC+NToWf12eDV8HfJUMpEtn4uZF/lvh9GpkxSPFi6rpd4nz6Mqo7F2IgxVll1lPgx
         S1cpGiVyYgc30kT/31kXbDkBWlwfzQLrdrHkt0nOg2arB25cwTVOcpOHMOCFO3wR8XYa
         vcuiX7qkQVpYiAi+Lx2BEqLDiCV0L+Bi8MmL8Nbz0CpvIBljAfLRRGpLsB+GYC3fjiYg
         Q4vY+YlyPX45B006fzj4UoLVYRGSW8Ikxmhv29aP6jnnYoTHLtO4UkCn6KVUBapGWg3F
         BIWy2bXh9EFuL7GPLpdi9q5U6/S9EJjTVigRO8FyvCgh8Ab4VWBvGn/Nb1vWC1sxJ+2q
         GM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+MS5HnpGNaRcBoAU+scss6vgsGeZXi+yjBCiZKLEy7E=;
        b=L2uZ7nq15KEpKk6symgUT7nNnATUX63luoqa8k9z6ZPaiRsLfNoNLZ0eskzegmNrtD
         J5LaF03eQKPUaPqVXGn/tI3T+fvQVEQGn2OAIJkkEu3PsYRoGMse6SEU5HoVIHzLdPas
         GjMRQqknlWYjIc2yDiuF1oIF8AWLcvqnEGrTolnmP1SfpT8aCLitph6hR9SwWAl+0Pc9
         QHcakKSS5Bsd/eNoko4NjugKA15u+ET78zed2+6aoek8QWa2Ru7V+e69Q2EMy/GeldJj
         XZoe/jP6lEJNb90afFmVOxUKR5cUU9DbIYQ+vGjJGHlQRT7AAa0CdOWDflc5y7zSVcoQ
         hz3w==
X-Gm-Message-State: AGi0PubmhDpeKyJvYyYK6Ekwyw/5dpHAFHu/c/uk68l+x9xDRq7RFseW
        CINOjrccavqs4+PHYnWzecU=
X-Google-Smtp-Source: APiQypKBk0GDbgNWepdyVABzFyzzFWs3WNEGNoAd1CSNRjtJxuHn24+oOlInmHlZae84Tu9LzgeaXA==
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr8728378wrn.325.1585920872335;
        Fri, 03 Apr 2020 06:34:32 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id y1sm4220886wmd.14.2020.04.03.06.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:34:31 -0700 (PDT)
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
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <194df5e2-4e5d-3150-d8a4-bb55bdef75be@gmail.com>
Date:   Fri, 3 Apr 2020 14:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403103126.GA3163329@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 03/04/2020 11:31, Denton Liu wrote:
> Hi Phillip,
> 
> Thanks for your detailed review on the series. I've updated everything
> according to your comments except for the parts below:

That's great, I've added a few more comments below

> On Thu, Apr 02, 2020 at 04:24:54PM +0100, Phillip Wood wrote:
>>> diff --git a/branch.c b/branch.c
>>> index 579494738a..bf2536c70d 100644
>>> --- a/branch.c
>>> +++ b/branch.c
>>> @@ -344,6 +344,7 @@ void remove_merge_branch_state(struct repository *r)
>>>    	unlink(git_path_merge_rr(r));
>>>    	unlink(git_path_merge_msg(r));
>>>    	unlink(git_path_merge_mode(r));
>>> +	apply_autostash(git_path_merge_autostash(r));
>>>    }
>>>    void remove_branch_state(struct repository *r, int verbose)
>>> diff --git a/builtin/commit.c b/builtin/commit.c
>>> index 7ba33a3bec..c11894423a 100644
>>> --- a/builtin/commit.c
>>> +++ b/builtin/commit.c
>>> @@ -1687,6 +1687,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>>    	unlink(git_path_merge_mode(the_repository));
>>>    	unlink(git_path_squash_msg(the_repository));
>>> +	apply_autostash(git_path_merge_autostash(the_repository));
>>> +
>>
>> It's hard to tell from the limited context but do we want to run
>> commit_index_files() before applying the autostash?
> 
> I don't think it really matters which order we run it in. When we run
> apply_autostash(), we only ever touch the working tree, not the index so
> it doesn't matter if it's run before or after. I'd prefer to keep it
> here because if we ever refactor this to use
> remove_merge_branch_state(), the person working on this will be able to
> perform the refactor more easily without having to worry about implicit
> ordering dependencies.

Thinking a bit more about this we definitely want to commit the index 
files before applying the stash as that is done in a separate process so 
we want our index written to disk first.

'git stash apply' does touch the index while it's merging and then tries 
to reset it to the pre-merge state if the merge has no conflicts. If the 
user runs
     git add new-file
     git merge --autostash branch
and new-file is not in branch then 'git stash apply' will add new-file 
to the index


>> I wonder if this should
>> be using remove_merge_branch_state() instead of duplicating it as well.
> 
> We can _almost_ use remove_branch_state() even! Unfortunately,
> remove_merge_branch_state() calls `unlink(git_path_merge_rr(r))` which
> we cannot do since repo_rerere() relies on it later. Perhaps we can
> can move repo_rerere() earlier?

I think we should move apply_autostash() down so that repo_rerere() is 
called with the index that we've committed before we apply the stash 
which might add conflicts or new files. We should probably run the 
post-commit and post-rewrite hooks before we apply the autostash as well 
to avoid changing the existing behaviour.

If we aim for something like
   commit_index_files()
   repo_rerere()
   stash_oid = read_autostash_oid()
   cleanup_branch_state()
   run_post_commit_hook()
   run_post_rewrite_hook()
   print_commit_summary()
   apply_autostash(stash_oid)

Then we keep the existing behaviour for rerere and the hooks, and the 
commit summary is printed before all the status junk that 
apply_autostash() spews out

We probably need to check the where 'git merge' applies the autostash as 
well to make sure it is writing the index to disk, calling the 
post-merge hook and printing any messages before applying the stash

Best Wishes

Phillip


>>> diff --git a/builtin/reset.c b/builtin/reset.c
>>> index 18228c312e..038c8532eb 100644
>>> --- a/builtin/reset.c
>>> +++ b/builtin/reset.c
>>> @@ -25,6 +25,7 @@
>>>    #include "cache-tree.h"
>>>    #include "submodule.h"
>>>    #include "submodule-config.h"
>>> +#include "sequencer.h"
>>>    #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
>>> @@ -437,8 +438,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>>    		if (reset_type == HARD && !update_ref_status && !quiet)
>>>    			print_new_head_line(lookup_commit_reference(the_repository, &oid));
>>>    	}
>>> -	if (!pathspec.nr)
>>> +	if (!pathspec.nr) {
>>> +		if (reset_type == HARD)
>>> +			save_autostash(git_path_merge_autostash(the_repository));
>>> +
>>>    		remove_branch_state(the_repository, 0);
>>
>> This removes the autostash file for all reset types but we only keep the
>> stash in the case of 'reset --hard' which is confusing.
> 
> I was worried that this change would be controversial... The rationale
> behind this change was that with `reset --hard`, we want to leave a
> clean working tree behind so we save it into the stash reflog. In all
> other cases, remove_branch_state() will apply the saved stash entry
> which should be fine since users don't expect a clean worktree with the
> other reset types.
> 
> I considered saving the autostash in all cases of reset but
> `git merge --abort` invokes `git reset --merge` behind the scenes so
> we'd have to consider that. Perhaps we can make all resets save the
> stash entry and, in the case of `merge --abort`, we can add some extra
> logic to subvert this so that the stash entry is applied?
> 
> I'm not sure about what the most intuitive behaviour is. I thought that
> this implementation would be the best but I'm not entirely sure. I'd
> appreciate some more discussion on this.
> 
> Thanks,
> 
> Denton
> 
>> Best Wishes
>>
>> Phillip
>>
>>> +	}
>>>    	return update_ref_status;
>>>    }
