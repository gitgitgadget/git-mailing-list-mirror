Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A017C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019E22077B
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHt4Wqx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLKU3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:29:40 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:32897 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfLKU3k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 15:29:40 -0500
Received: by mail-qv1-f66.google.com with SMTP id z3so15876qvn.0
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 12:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=88Ol3kOSZt7rmIXgJnwd4cpETODu7NKOh6PIeBAqHc8=;
        b=vHt4Wqx4y+PcIEK3bZMg+9YqeNWsZ+BTk36Brtk2yHx+HtMcmm1p/qRMV7zhvLlSm2
         SQJsQOz/iReE63+LTz/EpPzY8sbW9rCjpl+U8giPuQpPqhWJTEXqVG0vSZChasgdTn3l
         Pov2sx+60fgCk1dhS/BD/z8B5W/AaUSczLoOPa9Ci9zGY/qXPxeDaupAmZCQH3nB68G9
         nS8N4Zb6HHeUPbQzxmpd9aSu7os7noRUi71Zu+mXrYdjeBaL5uSrTSBg5GrUvJ30hSJL
         w9S1FFZAqNqjUVx8dXij+/NNvNj7ti8eK/6GeSFYF8OM0bZLEoMEUF9xk3hx+qyHRdpL
         3oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=88Ol3kOSZt7rmIXgJnwd4cpETODu7NKOh6PIeBAqHc8=;
        b=X6pdtwQ3XfpXpHCg+5SirmQsW6+Fl4V3hC0VdtAtgFiIHNo307U4FleKOnJqq3qi3d
         rzw+AQg/iiBw2bqgJ/q18xDqrsde6A6lPCqU97QaqGSzbuqXNEwceNvOI9JdCsPqN4iI
         YMjHH1unBYw8M35IGxHDp9+bif6vo6DDaMM0VbSWlZscgez885QTcellHWcEcq5mH856
         kbnNZ+p7toWh14esNayowQsJmrstG3+lQLS5SbMrmu6zIEFLNB6eneaYqKM09OgqQQYN
         Kq+xKE0wq3XiUgjKWf1/lPiLnfcayT1E9gMalH4gHLm/z3v6BkPrqOAnyZpj+dhw+ARF
         pX2Q==
X-Gm-Message-State: APjAAAVfOke24YvgAHieTWObV/S6FqSQyIsJPOJsPS3jl0ffQj6/DbM5
        1sZRUwtsMlPT0u/BIq6wAFI=
X-Google-Smtp-Source: APXvYqzFrMlxqB5GpyoXNTH4tYBD10oBZDf761W57n8OV+XHawxMfe1pCUKPHbCkopskyJnFmTsXoA==
X-Received: by 2002:a0c:fac1:: with SMTP id p1mr4980987qvo.231.1576096179117;
        Wed, 11 Dec 2019 12:29:39 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3126:c1d8:6135:a84d? ([2001:4898:a800:1012:e259:c1d8:6135:a84d])
        by smtp.gmail.com with ESMTPSA id c84sm1020707qkg.78.2019.12.11.12.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 12:29:38 -0800 (PST)
Subject: Re: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
 <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
 <xmqqtv66og63.fsf@gitster-ct.c.googlers.com>
 <9dbf6d43-ac1e-4790-84e5-4829d21f5fdb@gmail.com>
 <xmqqeexaocos.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3e64b470-93cc-5491-09e1-e499f0a7583d@gmail.com>
Date:   Wed, 11 Dec 2019 15:29:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqeexaocos.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11/2019 3:00 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> I'm trying to find a way around these two ideas:
>>
>> 1. The index is case-sensitive, and the sparse-checkout patterns are
>>    case-sensitive.
> 
> OK.  The latter is local to the repository and not shared to the
> world where people with case sensitive systems would live, right?

Yes, this information is local to a specific local copy. Even worktrees
have distinct sparse-checkout files.

>> 2. If a filesystem is case-insensitive, most index-change operations
>>    already succeed with incorrect case, especially with core.ignoreCase
>>    enabled.
> 
> I am not sure about "incorrect", though.  
> 
> My understanding is that modern case-insensitive systems are not
> information-destroying [*1*].  A new file you create as "ReadMe.txt"
> on your filesystem would be seen in that mixed case spelling via
> readdir() or equivalent, so adding it to the index as-is would
> likely be in the "correct" case, no?  If, after adding that path to
> the index, you did "rm ReadMe.txt" and created "README.TXT", surely
> we won't have both ReadMe.txt and README.TXT in the index with
> ignoreCase set, and keep using ReadMe.txt that matches what you
> added to the index.  I am not sure which one is the "incorrect" case
> in such a scenario.

The specific example I have in my mind is that the filesystem can have
"README.TXT" as what it would report by readdir(), but a user can type

	git add readme.txt

Without core.ignoreCase, the index will store the path as "readme.txt",
possibly adding a new entry in the index next to "README.TXT". If
core.ignoreCase is enabled, then the case reported by readdir() is used.
(This works both for a tracked and untracked path.)

>> The approach I have is to allow a user to provide a case that does not
>> match the index, and then we store the pattern in the sparse-checkout
>> that matches the case in the index.
> 
> Yes, I understood that from your proposed log message and cover
> letter.  They were very clearly written.
> 
> But imagine that your user writes ABC in the sparse pattern file,
> and there is no abc anything in the index in any case permutations.
> 
> When you check out a branch that has Abc, shouldn't the pattern ABC
> affect the operation just like a pattern Abc would on a case
> insensitive system?
> 
> Or are end users perfectly aware that the thing in that branch is
> spelled "Abc" and not "ABC" (the data in Git does---it comes from a
> tree object that is case sensitive)?  If so, then the pattern ABC
> should not affect the subtree whose name is "Abc" even on a case
> insensitive system.

This is a case that is difficult to control for. We have no source
of truth (filesystem or index) at the time of the 'git sparse-checkout
set' command. I cannot think of a solution to this specific issue
without doing the more-costly approach on every unpack_trees() call.

I believe this case may be narrow enough to "document and don't-fix",
but please speak up if anyone thinks this _must_ be fixed.

The other thing I can say is that my current approach _could_ be
replaced in the future by the more invasive check in unpack_trees().
The behavior change would be invisible to users who don't inspect
their sparse-checkout files other than this narrow case.

Specifically, our internal customer is planning to update the
sparse-checkout cone based on files in the workdir, which means that
the paths are expected to be in the index at the time of the 'set'
call.

> I am not sure what the design of this part of the system expects out
> of the end user.  Perhaps keeping the patterns case insensitive and
> tell the end users to spell them correctly is the right way to go, I
> guess, if it is just the filesystem that cannot represente the cases
> correctly at times and the users are perfectly capable of telling
> the right and wrong cases apart.

My first reaction to this internal request was "just clean up your
data." The issue is keeping it clean as users are changing the data
often and the only current checks are whether the build passes (and
the build "sees" the files because the filesystem accepts the wrong
case).

The "git add" behavior made me think there was sufficient precedent
in Git to try this change.

I'm happy to follow the community's opinion in this matter, including
a hard "we will not correct for case in this feature" or "if you want
this then you'll pay for it in performance." In the latter case I'd
prefer a new config option to toggle the sparse-checkout case
insensitivity. That way users could have core.ignoreCase behavior without
the perf hit if they use clean input to the sparse-checkout feature.

> But then I am not sure why correcting misspelled names by comparing
> them with the index entries is a good idea, either.

Right, that seems like a line too far.

>> It sounds like you are preferring this second option, despite the
>> performance costs. It is possible to use a case-insensitive hashing
>> algorithm when in the cone mode, but I'm not sure about how to do
>> a similar concept for the normal mode.
> 
> I have no strong preference, other than that I prefer to see things
> being done consistently.  Don't we already use case folding hash
> function to ensure that we won't add duplicate to the index on
> case-insensitive system?  I suspect that we would need to do the
> same, whether in cone mode or just a normal sparse-checkout mode
> consistently.

Since the cone mode uses a hashset to match the paths to the patterns,
that conversion is possible. I'm not sure how to start making arbitrary
regexes be case-insensitive in the non-cone-mode case. Suggestions?

Thank you for the discussion. I was hoping to get feedback on this
approach, which is why this patch is isolated to only this issue.

Thanks,
-Stolee


