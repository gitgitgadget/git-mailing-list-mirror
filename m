Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D44DC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 18:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbhLPSL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbhLPSL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 13:11:57 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B51C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:11:56 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id h17-20020aa79f51000000b0049473df362dso12194pfr.12
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SqNdWHAs8f+HcyQ8b2P23jGkhEwR5DzMSRFzGirhvvI=;
        b=QwzC5RZ/7szh1GqTosLzfRUSOc0EYimI/YwVHYcFESgJM+jTB+ZupncFbgsphWyWld
         3ZPQaKPn/aaYMOb6kWtYf1VLZwIaxPzFweRM1hndyHgmA4Ke33TWR5tgUFsHes9/q84n
         WCwE8AurXU9DjSBQwfW8SrQcxnFCPJ7qop0e2ckfC1i3l2duRbpJdTQRsLjTTK4j3xu8
         JCk22o3mpDTwVMjWRC6PcdV7FaZov49NLni5yFingoDaCuebiH2xdQOz3h0Wdwly8PWl
         GgHPlEJU0GszKYCqUFiaJ1ZlMUc6T7QytLFp2abj6dxBPnST6mzAB1PgrkcqhI4e0VJA
         jtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SqNdWHAs8f+HcyQ8b2P23jGkhEwR5DzMSRFzGirhvvI=;
        b=eVokIyLFIAygbFJoLAWr1HQ+XwSL20Q+bQ5dBiDrRkHDqGKsCXAn8ukyB3tjjftdYh
         UGrDgbAOdMgLdSYVX9AW2B6Y5KGfRAo8fMzVXTfGe3hqxP4IXpJvvGwKVqCx8E2KOeoq
         6f5MnfBxgRl0ut/39wBU5xOaALhSG1EtjiW2MQ3lfdrIP5Av7r30uMo69xvOXKc+aUi5
         DvqaPO+YhtPO/s1dF39pDiU9cUpCk659TAW/aHoCA3jqbLCCdkaP6lU1yCDsCrs1c9WC
         Qnbv1zDH/tPgWCYLPpJAKciO/slwPRlUIaA2D+WnFzR+Dlb8eArGzisKxEdGn/zVj5U9
         4I4A==
X-Gm-Message-State: AOAM530c6V5sSz2OIHc1dVfj30TwjcVGU3LulMqPy+nrRZamf64Hf5TK
        tG9n53sq3KVpKU2cJ+w5s7EnGAI6ic4W3Q==
X-Google-Smtp-Source: ABdhPJx7+9sbtWFxeMpyC7eGD6ihF4x8tI4vz1YHCzbOkybZJZdGKMCWY7pA4MsdKjbtZ5oFlCO/Oi9EZOpssg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:c203:: with SMTP id
 e3mr588804pjt.0.1639678316100; Thu, 16 Dec 2021 10:11:56 -0800 (PST)
Date:   Thu, 16 Dec 2021 10:11:54 -0800
In-Reply-To: <20211213225842.768852-1-jonathantanmy@google.com>
Message-Id: <kl6lwnk4to5x.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lbl1p9zjf.fsf@chooglen-macbookpro.roam.corp.google.com> <20211213225842.768852-1-jonathantanmy@google.com>
Subject: Re: [PATCH] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> > Glen Choo <chooglen@google.com> writes:
>> >> `git fetch --negotiate-only` does not fetch objects and thus, it should
>> >> not perform certain auxiliary tasks like updating submodules, updating
>> >> the commit graph, or running gc. Although send_pack() invokes `git fetch
>> >> --negotiate-only` correctly, cmd_fetch() also reads config variables,
>> >> leading to undesirable behavior, like updating submodules if
>> >> `submodule.recurse=true`.
>> >> 
>> >> Make cmd_fetch() return early if --negotiate-only was specified so that
>> >> these auxiliary tasks are skipped.
>> >> 
>> >> Signed-off-by: Glen Choo <chooglen@google.com>
>> >> ---
>> >> `git fetch --negotiate-only` is used during push negotiation to
>> >> determine the reachability of commits. As its name implies, only
>> >> negotiation is performed, not the actual fetching of objects. However,
>> >> cmd_fetch() performs certain tasks with the assumption that objects are
>> >> fetched:
>> >> 
>> >> * Submodules are updated if enabled by recurse.submodules=true, but
>> >>   negotiation fetch doesn't actually update the repo, so this doesn't
>> >>   make sense (introduced in [1]).
>> >> * Commit graphs will be written if enabled by
>> >>   fetch.writeCommitGraph=true. But according to
>> >>   Documentation/config/fetch.txt [2], this should only be done if a
>> >>   pack-file is downloaded
>> >> * gc is run, but according to [3], we only do this because we expect
>> >>   `git fetch` to introduce objects
>> >> 
>> >> Instead of disabling these tasks piecemeal, let's just make cmd_fetch()
>> >> return early if --negotiate-only was given. To accommodate possible
>> >> future options that don't fetch objects, I opted to introduce another
>> >> `if` statement instead of putting the early return in the existing
>> >> `if (negotiate_only)` block.
>> >
>> > Some of this probably should be in the commit message too.
>> 
>> I suppose you mean the explanation of why the tasks are irrelevant to
>> negotiation fetch? i.e. 
>> 
>>    * Submodules are updated if enabled by recurse.submodules=true...
>>    * Commit graphs will be written if enabled by...
>>    * gc is run, but according to [3]...
>
> Yes - why the behavior is undesirable, and the way you're doing it (by
> adding another "if" statement).
>
> After looking at this, more concretely, it might be better to use the
> part below the "---" as your commit message. :-) Just note that we're
> not just accommodating future options that don't fetch objects - "fetch"
> already may not fetch objects (e.g. if the ref we want doesn't exist or
> if we already have all the objects).

Good suggestion. I'll clean it up for brevity.

>
>> > Maybe add a check here that --recurse-submodules was not explicitly
>> > given.
>> 
>> Hm, that's not a bad idea, but it's not so easy because we don't have
>> RECURSE_SUBMODULES_EXPLICIT so it's not easy to tell whether or not
>> submodule recursion was enabled by CLI option or config.
>> 
>> This is the exact same use case I encountered with "branch
>> --recurse-submodules" [1]. I think this means that we should consider
>> standardizing the parsing of submodule.recurse + --recurse-submodules. I
>> haven't done it yet because it's a little tricky and hard to review.
>> 
>> So I'll punt on this check until we get RECURSE_SUBMODULES_EXPLICIT.
>
> Hmm...can we separate out the recurse_submodules variable into one
> that's given by config and one that's given by CLI argument?

This would be similar to what I did for branch --recurse-submodules [1],
which, as I noted in my cover letter [2], is easier to understand, but a
little inconsistent with the rest of the --recurse-submodules parsing.

I'm not very enthusiastic about adding more inconsistency, and since
this check isn't critical to this bugfix (and I think there is very
little chance that anyone would run afoul of this check any time soon)
I'd like to hold off on it until RECURSE_SUBMODULES_EXPLICIT.

Unless you think I'm missing something of course :)

[1] https://lore.kernel.org/git/20211216003213.99135-6-chooglen@google.com
[2] https://lore.kernel.org/git/20211216003213.99135-1-chooglen@google.com
