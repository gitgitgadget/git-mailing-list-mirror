Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471C91F597
	for <e@80x24.org>; Tue, 24 Jul 2018 19:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbeGXUxW (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 16:53:22 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35097 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388470AbeGXUxW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 16:53:22 -0400
Received: by mail-qk0-f195.google.com with SMTP id u21-v6so3427275qku.2
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sxMn4A4pjADbM/8kte2M4dFqrZ3O9AIhf6fdJxth6c0=;
        b=SpWvwV6IrKyB+FoQdnWDbQIM39pATlOanDMEJFaJ1BZ9UL+5WKneoHFKCt8dDFTEPZ
         bdUnVvuXvN8kTjOCxu7qD0W+KhesV9uWflp3quWw9IDGMENpMTrYRIP6vIN+VzIcb4ip
         SP9uM3JyUCt9/rIR/Kj0vceqlzlgWOWu/QbmUV7MSMPCl71MGr+Hk1IeAYhNvDmT6O1K
         fEkjWuCYlXt0Y1ZEUEaqOdkU4UXdzPeGqwSKwPcDOLuqPlY9TvWpeNbsKqAT6JxUtz3M
         NLMUjy1rhPpT0bt/L8pSE/w/06eGALqxlC6+0xeaB7LnUx3I2Uf4bKsbF8AiavTDXqo1
         qb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sxMn4A4pjADbM/8kte2M4dFqrZ3O9AIhf6fdJxth6c0=;
        b=KSwXSk0gid4rjLdxcCPOvbOBKhi3qwiYnlwTcP/1g5I8AW2rA/tEXCs/v+1TgnJxsX
         6r5gkOo0XLeAyu9xiSfLji1QqFpw9XioF06nwpNk7fKCtQW/kgWP/sqNNEsJESnw0Tg5
         qLiEkH+D8u4xJyGF45+YT/Irms1iPePh7FbHCePqWmfe/8uqkBZrsYY5DZqeQnIVkF+1
         FJHc2BdmtFVLMkxoyGl9Er356LHEGhbWW06V1BvKz8Jrufmq9u2LrqU/KmgU3bQxnwnA
         Ac6tLWSYdWW49Op0IcN0Muuc6XKJlebUFmy5ALjDVct9nU+dg1hQOZYuDoAj3I/HIAE/
         corg==
X-Gm-Message-State: AOUpUlGGZgLTB7cNK0SAR662g3nnlGywwCxq6AbOgECTlE4h38eBouyD
        DtuUH8hBaT7OUm3hFaAnd8Q=
X-Google-Smtp-Source: AAOMgpe6aqdwepdr4M337e5qd7dmNNpBl4IzBogRrpEbcZr414ITEoYQvXOtgmL0WGAC7gi6ZL2WPQ==
X-Received: by 2002:a37:b001:: with SMTP id z1-v6mr16871532qke.156.1532461520856;
        Tue, 24 Jul 2018 12:45:20 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z22-v6sm3592550qki.59.2018.07.24.12.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 12:45:19 -0700 (PDT)
Subject: Re: [PATCH v1] checkout: optionally speed up "git checkout -b foo"
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <CAPig+cQZ4g-6uT3zB0n2XWb-68DUUBZdaimTb6_Y4DNZrLUdyQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <960c32c0-5b10-6854-73c9-392814dddbb3@gmail.com>
Date:   Tue, 24 Jul 2018 15:45:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cQZ4g-6uT3zB0n2XWb-68DUUBZdaimTb6_Y4DNZrLUdyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/24/2018 2:42 PM, Eric Sunshine wrote:
> On Tue, Jul 24, 2018 at 2:01 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
>> If the new core.optimizecheckout config setting is set to true, speed up
> 
> Maybe:
> 
>      Add core.optimizeCheckout config setting which, when true, speeds up
> 

Sure

>> "git checkout -b foo" by avoiding the work to merge the working tree.  This
>> is valid because no merge needs to occur - only creating the new branch/
>> updating the refs. Any other options force it through the old code path.
>>
>> This change in behavior is off by default and behind the config setting so
>> that users have to opt-in to the optimized behavior.
>>
>> We've been running with this patch internally for a long time but it was
>> rejected when I submitted it to the mailing list before because it
>> implicitly changes the behavior of checkout -b. Trying it again configured
>> behind a config setting as a potential solution for other optimizations to
>> checkout that could change the behavior as well.
> 
> This paragraph is mere commentary which probably belongs below the
> "---" line following your sign-off.
> 

Hopefully this commentary (I'll move it below the --- line) is clearer:

We've been running with this patch internally for a long time but it was
rejected when I submitted it to the mailing list before [1] because it
implicitly changes the behavior of checkout -b as it no longer updates
the working directory.

I'm submitting it again behind a config setting so that it doesn't cause
any back compat issues unless the user explicitly opts in to the new
behavior. My hope is this same setting and model can be used if/when we
make other performance optimizations to checkout like using the cache
tree to avoid having to traverse the entire tree being discussed [2].

[1] 
https://public-inbox.org/git/20160909192520.4812-1-benpeart@microsoft.com/
[2] 
https://public-inbox.org/git/20180724042740.GB13248@sigill.intra.peff.net/T/#m75afe3ab318d23f36334cf3a6e3d058839592469

>> https://public-inbox.org/git/20180724042740.GB13248@sigill.intra.peff.net/T/#m75afe3ab318d23f36334cf3a6e3d058839592469
> 
> Is this link meant to reference the previous attempt of optimizing
> "checkout -b"? Although there's a single mention of "checkout -b" in
> that discussion, it doesn't seem to be the previous attempt or explain
> why it was rejected.
> 
> It would be quite nice to see a discussion in both the commit message
> and the documentation about the pros and cons of enabling this
> optimization. That it was previously rejected suggests that there may
> be serious or unexpected consequences. How will a typical user know
> whether its use is desirable or not?
> 
>> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>> ---
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> @@ -911,6 +911,12 @@ core.commitGraph::
>> +core.optimizedCheckout
>> +       Speed up "git checkout -b foo" by skipping much of the work of a
>> +       full checkout command.  This changs the behavior as it will skip
> 
> s/changs/changes/
> 
>> +       merging the trees and updating the index and instead only create
>> +       and switch to the new ref.
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> @@ -471,6 +475,88 @@ static void setup_branch_path(struct branch_info *branch)
>> +static int needs_working_tree_merge(const struct checkout_opts *opts,
>> +       const struct branch_info *old_branch_info,
>> +       const struct branch_info *new_branch_info)
>> +{
>> +       /*
>> +        * We must do the merge if we are actually moving to a new
>> +        * commit tree.
>> +        */
>> +       if (!old_branch_info->commit || !new_branch_info->commit ||
>> +               oidcmp(&old_branch_info->commit->object.oid, &new_branch_info->commit->object.oid))
>> +               return 1;
>> +       [...]
>> +       return 0;
>> +}
> 
> This long list of special-case checks doesn't leave me too enthused,
> however, that aside, this approach seems backward. Rather than erring
> on the side of safety by falling back to the merging behavior, it errs
> in the other direction, which may be a problem if this list of
> special-case checks ever gets out of sync with 'checkout_opts'. That
> is, if someone adds a new option which ought to employ the merging
> behavior, but forgets to update this function, then this function will
> incorrectly default to using the optimization.
> 

I'm not thrilled with the long list either (the plethora of comments 
probably makes it appear worse than it is) but I don't see how flipping 
the logic around makes it fail if someone adds a new option.  The "meets 
all criteria for optimization" code can only test existing options.

> A safer approach would be the inverse, namely:
> 
>      static int skip_worktree_merge(...)
>      {
>          if (...meets all criteria for optimization...)
>              return 1;
>          return 0;
>      }
> 
>>   static int merge_working_tree(const struct checkout_opts *opts,
>>                                struct branch_info *old_branch_info,
>>                                struct branch_info *new_branch_info,
>> {
>> +       /*
>> +        * Skip merging the trees, updating the index, and work tree only if we
>> +        * are simply creating a new branch via "git checkout -b foo."  Any
>> +        * other options or usage will continue to do all these steps.
>> +        */
>> +       if (core_optimize_checkout && !needs_working_tree_merge(opts, old_branch_info, new_branch_info))
>> +               return 0;
> 
> This seems a somewhat odd place to hook in this optimization,
> especially as there is only a single caller of this function. Instead,
> one might expect the caller itself to make this judgment and avoid
> trying the merge in the first place if not needed. That is, in
> switch_branches:
> 
>      if (!skip_worktree_merge(...))
>          ret = merge_working_tree(...);
> 

I personally agree, it was moved to its current location per feedback 
the first time around.  Perhaps with the addition of the config setting 
it will be better received moved out to the caller.
