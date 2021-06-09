Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FAEC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D5161354
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFIUgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:36:32 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42782 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFIUga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 16:36:30 -0400
Received: by mail-ot1-f42.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so20850545oth.9
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V0t2vkJPvH4oCiCS+3LC5xfxLoOHbZ4iTNsHCiHz8ug=;
        b=M0Ae2FgPMWBBnzyklmYDxly1fiyLVcqWuUK1gGxToHQ3TvzssZch9vwXFzBNde97+r
         PLktg+Y28MoN8Pcpmi9FlWiLnFGefvWfH0kTDxO6Nmj8RG/OGxRVxOWzzgoaLJ+kXG89
         mKboewh6920BKmnH19ysDt/XBphQjWDnKGAwmrzWpaI4uauoGeHfKHKiltPTa6SeeAhO
         BihMu7LCnSNbflVI0MUwT3SomXWpu9U8BlgvoRk4LhYqVhN1k2+qIUrQrNtokBkzXNqx
         ju1gl7p6Aeze9VB9Zn1yMtMGoZJNXwAmsU4JwjKgPOtKKZdfz0f3pZUMy0RJJwchIfB9
         +2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V0t2vkJPvH4oCiCS+3LC5xfxLoOHbZ4iTNsHCiHz8ug=;
        b=D7Hhe0SxJl1wrdOtKbiYCwBykbfEckcgU3BeMpDXHf/43bYogSLGT/EzimOcTgtxOs
         Lh0Gk4s05zHWI4tlhe4tZWNMzDthNMRkPaJM5NoxT8XjE9BCpE7EwC2FPd3sVpDxFHVa
         YtqBtiFvWQ4A9Y0fBpdy1WYqJsxvgfnK83BT1WImurK324MwYBcaN60fWr9Bz/NCHW94
         RnV98srlwLXZ4fAmsvaL4z2WPwB1FKIK6ebt9vsGbh+a4cI2ZlHDZMfjp6Hm8B7pLb9Z
         10cpfiiwfeb9yCKdO2TaIZ/KJyXQ/6R7K4Vzir5ycRmSC5OyDI7ne1S97qVnQFUXu+J+
         TOrg==
X-Gm-Message-State: AOAM533Qb+05/D+7y1zvTfTFKMuApmRAjpEsx4JDpW685qeyPmkx6yqv
        bHKRVDSmEPg1YhkqzQGHdO8=
X-Google-Smtp-Source: ABdhPJzCpi4C5JA/Nkt95Cua4jYwa6blUv0XocShfJQSnt2QiTlgjwVrHrguy0ZPAGQm3VOWbpCXJg==
X-Received: by 2002:a9d:4592:: with SMTP id x18mr1051136ote.74.1623270805896;
        Wed, 09 Jun 2021 13:33:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:757b:21f8:d6f2:dd1b? ([2600:1700:e72:80a0:757b:21f8:d6f2:dd1b])
        by smtp.gmail.com with ESMTPSA id m18sm201453otr.61.2021.06.09.13.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:33:25 -0700 (PDT)
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
 <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
 <CABPp-BEp0NzUqW_pWpTGoUvrB1JMp9fVHr28Sp8RZqV6w0-hEw@mail.gmail.com>
 <xmqqfsxrk0oc.fsf@gitster.g>
 <CABPp-BHEp6mH3jx6BeRk+u8C-9Q+go0=hHiaxenN_5KQKsR5iw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <60844f4b-33d4-b6d7-3611-a93cf012d3ff@gmail.com>
Date:   Wed, 9 Jun 2021 16:33:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHEp6mH3jx6BeRk+u8C-9Q+go0=hHiaxenN_5KQKsR5iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2021 4:11 AM, Elijah Newren wrote:
> On Tue, Jun 8, 2021 at 11:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>>
>>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>>
>>>> While comparing an index to a tree, we may see a sparse directory entry.
>>>> In this case, we should compare that portion of the tree to the tree
>>>> represented by that entry. This could include a new tree which needs to
>>>> be expanded to a full list of added files. It could also include an
>>>> existing tree, in which case all of the changes inside are important to
>>>> describe, including the modifications, additions, and deletions. Note
>>>> that the case where the tree has a path and the index does not remains
>>>> identical to before: the lack of a cache entry is the same with a sparse
>>>> index.
>>>>
>>>> In the case where a tree is modified, we need to expand the tree
>>>> recursively, and start comparing each contained entry as either an
>>>> addition, deletion, or modification. This causes an interesting
>>>> recursion that did not exist before.
>>>
>>> So, I haven't read through this in detail yet...but there's a big
>>> question I'm curious about:
>>>
>>> Git already has code for comparing an index to a tree, a tree to a
>>> tree, or a tree to the working directory, right?  So, when comparing a
>>> sparse-index to a tree...can't we re-use the compare a tree to a tree
>>> code when we hit a sparse directory?
>>
>> Offhand I do not think of a reason why that cannot work.
>>
>> The tree-diff machinery takes two trees, walks them in parallel and
>> repeatedly calls either diff_addremove() or diff_change(), which
>> appends diff_filepair() to the diff_queue[] structure.  If you see
>> an unexpanded tree on the index side, you should be able to pass
>> that tree with the subtree you are comparing against to the tree-diff
>> machinery to come up with a series of filepairs, and then tweak the
>> pathnames of these filepairs (as such a two-tree comparison would be
>> comparing two trees representing a single subdirectory of two different
>> vintages) before adding them to the diff_queue[] you are collecting
>> the index-vs-tree diff, for example.
> 
> Good to know it seems my idea might be reasonable.

I agree that this is reasonable. I just didn't look hard enough
to find existing code for this, since I found traverse_trees and
thought that _was_ the library for this.

>> But if a part of the index is represented as a tree because it is
>> outside the cone of interest, should we even be showing the
>> difference in that part of the tree?  If t/ directory is outside the
>> cone of interest, should "git diff HEAD~100 HEAD t/" show anything
>> to begin with (the same question for "git diff --cached HEAD t/")?
> 
> Excellent question...and not just for diff, but log, grep with
> revisions, and other commands.  We discussed this a while back[1] and
> we seemed to lean towards eventually adding a flag because there are
> usecases both for (1) viewing full history while having sparsity paths
> restrict just the working copy, and (2) also restricting the view of
> history to the sparsity paths.
> 
> [1] It's been discussed a few times, but there's a relatively
> comprehensive discussion at the "Commands that would change for
> behavior A" section from
> https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/

Yes, we could investigate this behavior change in the future. The
good thing is that these points that handle sparse directory
entries create clear branching points for that future behavior
change.

Thanks,
-Stolee
