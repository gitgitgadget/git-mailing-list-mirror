Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C5DC48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EC86112D
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFWJzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhFWJzr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 05:55:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223B4C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 02:53:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f15so1905990wro.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SnotZRKE0Rr8HxuUW91zXCSijMnnaDyuaotJHQ12KTE=;
        b=B4GcxGnf6ZbNK2qKe7vXtrXmiEpcqWb4qb94TPk9dSdkgKMrIdejdpY1REZfPZbvgT
         1vWH8L2LARNNH/OXhdVOhiIPKIYUy8OCDHnu9BtMnatunzO1prUfNG5Ptigj9KKh6DrS
         o4fBpO8ybaofNZ0ZS31rfUy6DcqXkv8SacTWsTLIt0p/9PGfSOQ4xPtRwMCUSSlO9NfO
         0CsJArRL/Dk3ZJl3VwyTEocnJz6PrrgbeJjkfFq+VNY5OuUZDCIbYot1+3V6XUfhkJOa
         RQihGpvRjZGkoUaZosXo3fShoZEy6aKKiT3EJReMb6apYw6Aa06sq+mipqIU1C7oSjJj
         aCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SnotZRKE0Rr8HxuUW91zXCSijMnnaDyuaotJHQ12KTE=;
        b=oVd0ylCud/tpR8b0SIjp0qUD1qcc1cRzysfkCo03pEoPbxvNho/zVcVMNk6VctotvR
         xp+pQIjyShRwpdmcnhsGa121O+8MyRRlv3Ws/bFwvspL5kRLAg6Tc6nsip8PaxuPBVEj
         IFzv6TM+E343GFjKMoC5QauUMDC8ipt1xqB8qhIeKS/bmfaiZFqY/KFmT496GXnzaJDp
         VaEjKD+ZghgnYUtjm7PoihsTJcLUBfLR2nW8nSI7zTEFANrVYq/XSHqF8H3l1B6IbfV2
         3FwCL2jg/ZCrMxUo78EH1KJ4WxkslZpTkk8p1k9j5azNbNqam6icLmFfs3OL+Yrb4Bak
         uhGw==
X-Gm-Message-State: AOAM533/7WLmrfZb1VWBcdgnviyamLgNEFu413T/jX7GV5vyQPJM2cb7
        j87CD999yRM2lPI1zDu+Vs+bn7T1Xeo=
X-Google-Smtp-Source: ABdhPJx2KICM62zHid6m7JsDX1meiyVs0zZQakQpdZMoR6xxDuuSnBqXl7bQsZCjls7NeXnlazlw9Q==
X-Received: by 2002:adf:f88e:: with SMTP id u14mr10487665wrp.391.1624442006638;
        Wed, 23 Jun 2021 02:53:26 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id f19sm2358370wre.48.2021.06.23.02.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 02:53:26 -0700 (PDT)
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <YMh2M8Ek/RUVjKkL@coredump.intra.peff.net>
 <CABPp-BE7-E03+x38EK-=AE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.com>
 <255df678-9a31-bba2-f023-c7d98e5ffc15@gmail.com>
 <YMnS+2DFYiswc75z@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f76c79d6-f280-3011-d88d-6de146977626@gmail.com>
Date:   Wed, 23 Jun 2021 10:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMnS+2DFYiswc75z@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/06/2021 11:31, Jeff King wrote:
> On Wed, Jun 16, 2021 at 09:57:49AM +0100, Phillip Wood wrote:
> 
>>>> which seems worse. I haven't dug/thought carefully enough into your
>>>> change yet to know if this is expected, or if there's a bug.
>>
>> XDL_MERGE_ZEALOUS coalesces adjacent conflicts that are separated by fewer
>> than four lines. Unfortunately the existing code in
>> xdl_merge_two_conflicts() only coalesces 'ours' and 'theirs', not 'base'.
>> Applying
>> [...]
>> gives
>>
>> <<<<<<< HEAD
>> 		if (starts_with(arg, "--informative-errors")) {
>> 			informative_errors = 1;
>> 			continue;
>> 		}
>> 		if (starts_with(arg, "--no-informative-errors")) {
>> ||||||| 2f93541d88
>> 		if (!prefixcmp(arg, "--informative-errors")) {
>> 			informative_errors = 1;
>> 			continue;
>> 		}
>> 		if (!prefixcmp(arg, "--no-informative-errors")) {
>> =======
>> 		if (!strcmp(arg, "--informative-errors")) {
>> 			informative_errors = 1;
>> 			continue;
>> 		}
>> 		if (!strcmp(arg, "--no-informative-errors")) {
>>>>>>>>> 0c52457b7c^2
>>
>> Which I think is correct. Whether combining single line conflicts in this
>> way is useful is a different question (and is independent of your patch). I
>> can see that with larger conflicts it is worth it but here we end up with
>> conflicts where 60% of the lines are from the base version. One the other
>> hand there are fewer conflicts to resolve - I'm not sure which I prefer.
> 
> Thanks for figuring that out. I agree that the output after the patch
> you showed is correct, in the sense that the common lines show up in the
> base now. It does feel like it's working against the point of zdiff3,
> though, which is to reduce the number of common lines shown in the
> "ours" and "theirs" hunks.

I agree - the output is longer rather than shorter. As we only want to 
trim the common prefix and suffix from the conflicts I wonder if it 
would be better to special case zdiff3 rather than piggy backing on the 
existing XDL_MERGE_ZEALOUS implementation. We can trim the common lines 
by looping over the begging and end of the hunk comparing the lines 
with xdl_recmatch() without going to the trouble of diffing them as 
XDL_MERGE_ZEALOUS does. I don't think we need to worry about coalescing 
adjacent conflicts for zdiff3. It makes sense to coalesce in the 
XDL_MERGE_ZEALOUS case as it can potentially split a  N line conflict 
hunk into N/2 single line conflict hunks but zdiff3 does not split 
conflict hunks.

> Likewise, I think this coalescing makes things worse even for "merge",
> where you get:
> 
>    <<<<<<< ours
>                    if (starts_with(arg, "--informative-errors")) {
>                            informative_errors = 1;
>                            continue;
>                    }
>                    if (starts_with(arg, "--no-informative-errors")) {
>    =======
>                    if (!strcmp(arg, "--informative-errors")) {
>                            informative_errors = 1;
>                            continue;
>                    }
>                    if (!strcmp(arg, "--no-informative-errors")) {
>    >>>>>>> theirs
> 
> and have to figure out manually that those interior lines are common.
> But I imagine there are cases where you have a large number of
> uninteresting lines (blank lines, "}", etc that create a lot of noise > in the output by breaking up the actual changed lines into tiny hunks
> that are hard to digest on their own.

Yes, I think the heuristic for coalescing conflict hunks could be 
improved. It would be fairly simple to only join two hunks if the 
conflicts are longer that the context between them and the existing 
XDL_MERGE_ZEALOUS_ALNUM logic allows conflicts with more context between 
them to be coalesced if the context lines are uninteresting. I think 
XDL_MERGE_ZEALOUS_ALNUM is only used by `git merge-file` at the moment, 
with everything else going through ll_merge() which uses XDL_MERGE_ZEALOUS

Best Wishes

Phillip

> 
> -Peff
> 

