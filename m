Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F1C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7587C6103B
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhG2CDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 22:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhG2CDm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 22:03:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC00C0613D3
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:03:39 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id k7so4359632qki.11
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cHZCQsV/2zGHjMxuJIZyiY9/KeYMpK2Wx77FfvooPF8=;
        b=UiVbwklSh9IbbfgpKpTuzaEd5L6u+8B2vCXNx8wzY0Ly4GXYwC8iwoi+0JIXYXOpeD
         /QTnrb2FLsnftd2URUGaUnf8SDneescAL3O4d+awBT95rvFerDF5bWgfkpHXXGIW1DHH
         Pqy3WMagIFlHAjzRWYbKWNY2G41mOO0nHXuW7qOT+0DqD4Q26gBEjJJnEa/B7MeR+UQk
         dMNHK0uYXg7yjWJtDY0FmpMLEW3ckI9TPlZKaTAu4D5rtmiJnN2IbrhkWCQSZwKDVPi4
         l2xerytL79Zwwogk9hmZS73E4onM86KykxwAxbIPIY+mn4kuO5Bej7x14035JQdFi3hx
         VvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cHZCQsV/2zGHjMxuJIZyiY9/KeYMpK2Wx77FfvooPF8=;
        b=ozAG3qmXm6jFTsX0UyAZQjVhe0LKjkPvhnVfZg3T0ktl7BBqahxG+Hbp+juhenLNnn
         SWJACsN3shnRHWxgGpxH+JSn5CFUvCnvPddY9Bh8fT/pPwuGrN9hhnB2AtRUPf2Sa6jb
         7IhTRR5XdRVwLPEH+JCHecEi8mEEsao1cA1zZUw1txZxM7CpPZk9YDj+rXiCBX+MUs2L
         xM4O768PfQSxFAedTe5X9vOD143Grj+ELOAOEnXZWab8B2cUk7npxiIYdtfgRDxeENGn
         hpFBlMWH4qcwHnKgAu8pN4oQ9Mk7PzV5+pu22WRT5ARLK+Enza/vdic6jP11XSKAmDJV
         hA8A==
X-Gm-Message-State: AOAM53235lleSgr9x/0Wp0UN8dxdtJnBqxTHmvS9rrpLKv6dzWMqnjkx
        cHEgg98CYrbDXWXn2gxTlVs=
X-Google-Smtp-Source: ABdhPJwanuyYVWVLD8N6/AbsJDMIlOdM0izifTH5ooKXaIuGH1Ivv72aZUU5fdpxDjTxPrxF4oaETQ==
X-Received: by 2002:a05:620a:11bc:: with SMTP id c28mr2814007qkk.113.1627524218085;
        Wed, 28 Jul 2021 19:03:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:cb4:2b6c:a89e:4048? ([2600:1700:e72:80a0:cb4:2b6c:a89e:4048])
        by smtp.gmail.com with ESMTPSA id 11sm970807qki.128.2021.07.28.19.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 19:03:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Sparse Index: Integrate with 'git add'
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
 <CABPp-BHnvEPuYahFAoVSF58k99t__N2-M4OKKHDAAK2qrhY3WQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6a63736a-feb8-b74b-ef68-73cc71009e1d@gmail.com>
Date:   Wed, 28 Jul 2021 22:03:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHnvEPuYahFAoVSF58k99t__N2-M4OKKHDAAK2qrhY3WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/2021 7:13 PM, Elijah Newren wrote:
> On Mon, Jul 26, 2021 at 9:18 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
...
>>  * a full proposal for what to do with "git (add|mv|rm)" and paths outside
>>    the cone is delayed to another series (with an RFC round) because the
>>    behavior of the sparse-index matches a full index with sparse-checkout.
> 
> I think this makes sense.
> 
> I've read through the patches, and I like this version...with one
> exception.  Can we mark the test added in patch 1 under
> 
>      # 3. Rename the file to another sparse filename and
>      #    accept conflict markers as resolved content.
> 
> as NEEDSWORK or even MAYNEEDWORK?

I have no objection to adding a blurb such as:

	# NEEDSWORK: allowing adds outside the sparse cone can be
	# confusingto users, as the file can disappear from the
	# worktree without warning in later Git commands.

And perhaps I'm misunderstanding the situation a bit, but that
seems to apply not just to this third case, but all of them. I
don't see why the untracked case is special compared to the
tracked case. More investigation may be required on my part.

>  I'm still quite unconvinced that it
> is testing for correct behavior, and don't want to paint ourselves
> into a corner.  In particular, we don't allow folks to "git add
> $IGNORED_FILE" without a --force override because it's likely to be a
> mistake. 

I agree about ignored files, and that is true whether or not they
are in the sparse cone.

> I think the same logic holds for adding untracked files
> outside the sparsity cone.  But it's actually even worse than that
> case because there's a secondary level of surprise too: adding files
> outside the sparsity cone will result in delayed user surprises when
> the next git command that happens to call unpack_trees() (which are
> found all over the codebase) removes the file from the working tree.
> I've had some such reports already.

I believe this is testing a realistic scenario that users are
hitting in the wild today. I would believe that users succeed with
these commands more often than they are confused by the file
disappearing from the worktree in a later Git command, so having
this sequence of events be documented as a potential use case has
some value.

I simultaneously don't think it is behavior we want to commit to
as a contract for all future Git versions, but there is value in
showing how this situation changes with any future meddling. In
particular: will users be able to self-discover the "new" way of
doing things?

The proposal part of changing how add/mv/rm behave in these cases
would need to adjust this test with something that would also help
direct users to a helpful resolution. For example, the first run
of

	git add sparse/dir/file

could error out with an error message saying "The pathspec is
outside of your sparse cone, so staging the file might lead to
a staged change that is removed from your working directory."
But we should _also_ include two strategies for getting out of
this state:

1. Adjust your sparse-checkout definition so this file is in scope.

-or- (and this is the part that would be new)

2. If you understand the risks of staging a file outside the sparse
   cone, then run 'git add --sparse sparse/dir/file'.

(Insert whatever option would be appropriate for --sparse here.)

Such a warning message would allow users who follow the steps listed
in the test to know how to adjust their usage to then get into a
good state.

> If that test is marked as NEEDSWORK or even as the correct behavior
> still being under dispute, then you can happily apply my:

I would classify this as "The test documents current behavior, but
isn't a contract for future behavior." With a concept such as my
suggestion above, the test could be modified to check for the
warning and then run the second command with the extra option and
complete the test's expectations. Having the existing behavior
documented in a test helps demonstrate how behavior is changing.

We we've discussed, we want to give such a behavior change the
right venue for feedback and suggestions for alternate approaches,
and this series is not the right place for that. Hopefully you
can tell that it is on my mind and that I want to recommend a
change in the near future.

Thanks,
-Stolee
