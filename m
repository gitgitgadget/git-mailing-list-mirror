Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11262089A
	for <e@80x24.org>; Thu, 27 Jul 2017 13:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbdG0NZt (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 09:25:49 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:49954 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbdG0NZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 09:25:49 -0400
Received: from [192.168.2.240] ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id ainMdqMLhbjdZainQdFX5b; Thu, 27 Jul 2017 14:25:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501161947; bh=BZTxFOke+13dzVQMmU+M4+hUZZL5M2d5Sn2oHjMk5nM=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=PzxoIncLdWZ5KpCiq1+k+gNSF3Q1lg/H/qOafEQ7fGTvhVvIJi+jw0q24DdCFezDq
         xu5F5Cu72fgoEqR1bx1w34tUQ4Q1d/ve1D3ZtP+5rPNxmpHh2d46a7tmGXMBDT1uSC
         ON1vSC2mCmBBxu/WfMcv6DyBavVD6oL6ort66lX8=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=qLN8Lqsck1q58VXj-5kA:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a
 rebase
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
 <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
 <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
 <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
 <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
Message-ID: <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net>
Date:   Thu, 27 Jul 2017 14:25:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAQPCfwV6g41+6aX8NnmBzy3DWjfC8JupjDbE7z/ctJ9yxoYUAUzTNMihjxp2Tw3ssrKB5JlRI5wXJO2ewk4KCzMap3R8VabKZ/RnyOgB4DcXKcRbnFS
 QJk3aQb0rHUzE6BQLSTBrSvv2eY6WgpVSMFyYuwlfblP76jQy+L8+NYflblN3wqhCmi6oMN1ONxF2WHJgoZLQg0MssfVZegBxNvqZHDK4SCUdOcO1CGf6f3v
 sJqEtWXC0S3qUtwozElvjObyQNwsYJvdoFnEI14h5LA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/07/17 11:36, Phillip Wood wrote:
> On 26/07/17 23:12, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Hmph, this is interesting.
>>>
>>> "git rebase" does take "--rerere-autoupdate" option from the command
>>> line, and propagates it to a later invocation of "rebase --continue"
>>> by storing the value to $state_dir/allow_rerere_autoupdate file and
>>> reading the value from it.  $allow_rerere_autoupdate shell variable
>>> is used to hold the setting.
>>>
>>> I'd expect that this variable to be used in invocations of "git am"
>>> in git-rebase--am.sh; but that does not seem to be the case.  I
>>> wonder if this was once working but over time we broke the feature
>>> without anybody noticing it, or if the support was added but not
>>> completed and the feature was a no-op from the beginning?
>>
>> At least in v1.7.0 when doing "rebase -m", the rerere-autoupdate was
>> plumbed correctly through to the invocation of "git merge" that is
>> done inside git-rebase.sh.  I do not see the same option passed down
>> to the invocation of "git am", so perhaps nobody cared back then
>> about rerere during "git rebase" that does not use "git am" backend,
>> even though "git am" itself were capable of talking the option.
>>
>> In any case, if you corrected the existing "git rebase" and its
>> backend so that "--rerere-autoupdate" works as advertised
> 
> I've had a quick look and I think it's just a case of adding
> '$allow_rerere_autoupdate' to the invocation of 'git am'. 'git am' calls
> rerere_clear() when skipping so that doesn't need to go into the shell
> script. I'll come up with a test to check it works as I think it does.
> 
>> I think
>> you are already 80% there without adding a yet another option, as I
>> suspect that the most of the need for avoiding "git add" during a
>> "git rebase" session is during a conflict resolution, and allowing
>> "rerere" to automatically update the index with auto-resolution will
>> leave _only_ changes to the paths the end user actually needs to
>> take a look and manually fix still not in the index.
> 
> I'm interested in the 20% as it's about 100% of my rebase conflicts.
> I've got rerere enabled but I cannot recall it helping me with a rebase
> conflict in the five or six years I've been using git [1]. A lot of my
> rebase conflicts come from fixup! commits or reordering things with
> rebase -i and generally they're only going to happen once as I don't
> apply the same fixup! more than once and if I've rearranged commits the
> conflicts are likely to be different in the (possibly unlikely) event I
> rearrange them again in the future.
> 
> Once I've resolved a conflict I will look at the diff and maybe compile
> and run some tests. Then, if I'm happy I'll run 'git rebase --continue',
> to me the 'git add' stage doesn't really add anything useful, it's just
> an inconvenience.
> 
> The other use I have for --autostage is when editing commits with rebase
> -i, once I'm happy with the edit I just want to continue and have rebase
> amend the commit. I don't feel having to run 'git add' is helpful in
> this case.
> 
>> And from the
>> workflow point of view, encouraging them to "git add" their manual
>> resolution after they are satisified with their changes by not doing
>> "git add" blindly for all changes, like your --autostage" does, is
>> probably a good thing.

Git allows 'git commit -a' to complete a conflicted merge which I think 
is much the same thing as I'm proposing. Also there's nothing to stop a 
user accidentally running 'git add' on a path that isn't resolved or 
just blindly running 'add -u' before continuing the rebase because they 
think they've resolved everything. I guess it is a kind of 
convenience/safety trade-off.

> In my mind running 'git rebase --continue' is the signal to git that the
> conflicts are resolved.
> Best Wishes
> 
> Phillip
> 
> [1] Maybe I've not noticed it helping when rebasing onto an updated
> upstream, although if I'm actively changing the rebased commits between
> upstream updates the conflicts may well change between updates. Also I
> don't tend to get many upstream conflicts with the projects I'm working on.

Thinking about it some more, once a conflict is resolved, the next time 
that rewritten commit is rebased onto an updated upstream the same 
conflict will not occur as the rewritten commit that's being replayed 
does not conflict with the previous upstream - the resolution is baked 
into the commit that's being replayed.

