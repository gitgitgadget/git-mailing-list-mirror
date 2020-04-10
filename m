Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB736C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C70D20801
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUWsbt99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDJVnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:43:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38334 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJVnK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 17:43:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id w2so2489901oic.5
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6j2Vo1GIJ1d3FZyGgtcTj7g72MumVtkCXPt+en58v4=;
        b=lUWsbt99CQjNsqWzq3lWKpj8/0H84Cj4m8ORmDQDMkzKldEs/FrW1+SNpxDO51cJpH
         FAh3xoA9MRemQ8J+1fHtZf8SkRWlX/ANybBDgkAE0zClf065CTLBRWUP/3A54Bk/Gvjb
         416wH2AXETGyvC9Up75nNGNEuQLU2Y5fWsKcYrhx4ChLtjVXyYC8gQ+dxP/UQRTf5Idm
         ZviuKAwhjoiINOQjP7t2VbFLN0C8HposVViX4Lna46tyB/prACUSIAfZgDdA/uBYFWLe
         B1u/+VNJ5kOseCt/HfjUNmm6m6gTbOu8Xu3d0PUUv2c7O+EGf4M3V33iqdc/Un5rNf8/
         aZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6j2Vo1GIJ1d3FZyGgtcTj7g72MumVtkCXPt+en58v4=;
        b=jlxvfiBabwmVotQaSqofwMUPxPzEuW6/0HBVaVe4wN0Cm6EfrMp8j76XioORwKLD1r
         impaNTDNEnPoPwlF+BWARtCoSoXQO9QAKjtS4XWV4o8vDO2lMKLJkO0dBYrtJJ6FSmPq
         UOkC9zbaytc7/rf45ocXtw5AbHFiHUXqHU6TLQSAC9TkCv+oykONdK6EAVmYkGpygAiz
         b2k1mV0KnMf5c/Pi0P2bcZjj4edt9UnAPGnP2sjL59mafvKWKmGicttKIJMSjX719iuQ
         w6rOgR81YoUPQTLRpqP85L/m51A4KLwHtmLaisi/vM+BWUCuxdMfcxH/0wrauQkYfg13
         gNHQ==
X-Gm-Message-State: AGi0PuYPM04ppsBfZTGZrwEmHFN9H0Tj8Lhr0X/YEAM6WBuozriU84kr
        cwatfG13/MhBkHa8oZ8675A=
X-Google-Smtp-Source: APiQypLAFtGqKg+1WDtX529vlbzFSF9uRBYLvkJ7TeBZ22NHgH+uKoJgW3fKXvoZ9eSfCkL50jrxPg==
X-Received: by 2002:aca:e18a:: with SMTP id y132mr4640466oig.74.1586554988005;
        Fri, 10 Apr 2020 14:43:08 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o23sm1982724oos.36.2020.04.10.14.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 14:43:07 -0700 (PDT)
Subject: Re: [PATCH v3] revision: --show-pulls adds helpful merges
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        philipoakley@iee.email, sandals@crustytoothpaste.net,
        Johannes.Schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
References: <pull.599.v2.git.1586390501128.gitgitgadget@gmail.com>
 <pull.599.v3.git.1586521183873.gitgitgadget@gmail.com>
 <xmqq369bjebo.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <28075cfb-34bb-1109-5685-8d662e7559c3@gmail.com>
Date:   Fri, 10 Apr 2020 17:43:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqq369bjebo.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2020 4:06 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>   A----C1----C2--- ... ---Cn----M------P1---P2--- ... ---Pn
>>    \     \     \            \  /      /    /            /
>>     \     \__.. \            \/ ..__T1    /           Tn
>>      \           \__..       /\     ..__T2           /
>>       \_____________________B  \____________________/
>>
>> If the commits T1, T2, ... Tn did not change the file, then all of
>> P1 through Pn will be TREESAME to their first parent, but not
>> TREESAME to their second. This means that all of those merge commits
>> appear in the --full-history view, with edges that immediately
>> collapse into the lower history without introducing interesting
>> single-parent commits.
>>
>> The --simplify-merges option was introduced to remove these extra
>> merge commits. By noticing that the rewritten parents are reachable
>> from their first parents, those edges can be simplified away. Finally,
>> the commits now look like single-parent commits that are TREESAME to
>> their "only" parent. Thus, they are removed and this issue does not
>> cause issues anymore. However, this also ends up removing the commit
>> M from the history view! Even worse, the --simplify-merges option
>> requires walking the entire history before returning a single result.
> 
> True.  It is not advisable to use --simplify-merges unless you are
> limiting the history at the bottom for that reason.

I will modify my advice to include this "limiting the history at the
bottom" advice.

>> In some sense, users are asking for the "first" merge commit to
>> bring in the change to their branch. As long as the parent order is
>> consistent, this can be handled with the following rule:
>>
>>   Include a merge commit if it is not TREESAME to its first
>>   parent, but is TREESAME to a later parent.
> 
> "but is" -> "even if it is" would make it a bit more accurate, I
> would think.  Normally, such a merge that is treesame to some side
> branch is omitted from the output, but the rule wants it to be shown
> even if all the changes were brought in from one single parent.

This is an excellent clarification, since the way I wrote it does not
describe every merge that we include. I wrote it to include the "extra"
merges that are included. A better strategy is to include a complete
description of every merge commit that appears in the output, as you
defined it.

>> Update Documentation/rev-list-options.txt with significant details
>> around this option. This requires updating the example in the
>> History Simplification section to demonstrate some of the problems
>> with TREESAME second parents.
> 
> Good.
> 
>> diff --git a/revision.c b/revision.c
>> index 8136929e236..f89dd6caa55 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -870,7 +870,19 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>>  			}
>>  			parent->next = NULL;
>>  			commit->parents = parent;
>> -			commit->object.flags |= TREESAME;
>> +
>> +			/*
>> +			 * A merge commit is a "diversion" if it is not
>> +			 * TREESAME to its first parent but is TREESAME
>> +			 * to a later parent. In the simplified history,
>> +			 * we "divert" the history walk to the later
>> +			 * parent. These commits are shown when "show_pulls"
>> +			 * is enabled, so do not mark the object as
>> +			 * TREESAME here.
> 
> As we no longer use the word "diversion", this explanation should
> shift the focus from defining the word "diversion" and giving its
> background to explaining why the above parent rewriting is done and
> why the TREESAME marking is conditional, e.g.

Sorry about this. I intended to replace all references to this old
terminology, but failed.

>       			The tree of the merge and of the parent are
>       			the same; from here on, we stop following
>       			histories of all other parents but this one
>       			by culling commit->parents list.  We also
>       			normally mark the merge commit TREESAME as
>       			the merge itself did not introduce any
>       			change relative to the parent, but we
>       			refrain from doing so for the first parent
>       			under "--show-pulls" mode, in order to let
>       			the output phase to show the merge, which is
>       			the last commit before we divert our walk to
>       			a side history.
> 
> or something along that line.

This is pretty good. I plan to take it with very minor modifications in my
next version.

> 
>> +			if (!revs->show_pulls || !nth_parent)
>> +				commit->object.flags |= TREESAME;
>> +
>>  			return;
> 
>> @@ -897,6 +909,10 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>>  				relevant_change = 1;
>>  			else
>>  				irrelevant_change = 1;
>> +
>> +			if (!nth_parent)
>> +				commit->object.flags |= PULL_MERGE;
> 
> For a three-parent merge that brings in changes to the first parent,
> if the result matches the second parent, we would have returned in
> the previous hunk before having a chance to inspect the third one
> and marking the merge result with PULL_MERGE, but if you swap the
> order of the second and the third parent, the second parent, which
> has different tree from the result, would not return in the previous
> hunk and cause the merge with PULL_MERGE here.  And then when we
> inspect the third parent, the previous hunk's return would kick in.
> So for two merges that merge exactly the same two branches on top of
> exactly the same commit on the mainline, you sometimes mark the
> result with PULL_MERGE and sometimes don't, depending on the order
> of the second and the third parent.
> 
> That feels iffy.  Treating the first parent differently from others
> is what we intend to do with this change, bhut this hunk treats the
> other parents differently depending on the merge order.

It is worth adding a test with an octopus merge to really be clear
about the intended behavior. When describing the concept, I've been
careful to say "TREESAME to the first parent" and "not TREESAME to
a later parent" instead of assuming two parents. In the default
mode, we should not reach here unless we found a TREESAME parent
that was not the first parent, since we stop visiting parents after
we find any TREESAME parent. But this would change for --full-history
or --simplify-merges.

>> @@ -3019,7 +3037,8 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
>>  	if (!cnt ||
>>  	    (commit->object.flags & UNINTERESTING) ||
>>  	    !(commit->object.flags & TREESAME) ||
>> -	    (parent = one_relevant_parent(revs, commit->parents)) == NULL)
>> +	    (parent = one_relevant_parent(revs, commit->parents)) == NULL ||
>> +	    (revs->show_pulls && (commit->object.flags & PULL_MERGE)))
>>  		st->simplified = commit;
> 
> ... hence, wouldn't we see different result here ...
> 
>> @@ -3602,6 +3621,10 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>>  			/* drop merges unless we want parenthood */
>>  			if (!want_ancestry(revs))
>>  				return commit_ignore;
>> +
>> +			if (revs->show_pulls && (commit->object.flags & PULL_MERGE))
>> +				return commit_show;
> 
> ... and also here?

If there is a flaw in how I set PULL_MERGE, then hopefully the fix is where
I assign the PULL_MERGE flag and these lines do not need to change.

Thanks,
-Stolee
