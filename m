Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DEBC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 12:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB9B2177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 12:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxYvL7eI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgH0Moj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgH0Mn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 08:43:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC18FC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 05:43:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d26so7488791ejr.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7ZH/v/829gGGMtlpMYvVr2fDTJndn/5i/iVxlZDQWAs=;
        b=rxYvL7eIBDmVGSdFlOih9Co5Agtwkm+x/S/x8F8Uo57gc1WzOYosjJMHMaXMGlJUtr
         L/T7S8lllR/RImcnVuxqm/+CELzk0cRxtzGD3fo3kzS+5SOLkEN57bDlW3Hy0MIheI8a
         h8xwe5cUDXOC8hVIxuupseZfI/Hl8/T4+vcZbSXrE85tPg1Tm3tmmBKs57tKoEIJAkXt
         sHDF801rrttKV/dWxsyQ41GIgC1XVN3swkr+M0NdaXlNPO9plIxnNCPinEXSIaoun76O
         5OSTTGj6roPfdvMB4yDcth0Qqfyqk/31qPWVB+8+I2APlZXcM4hHQcZRSifXd3n/NwGp
         FjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=7ZH/v/829gGGMtlpMYvVr2fDTJndn/5i/iVxlZDQWAs=;
        b=sm3q/XkSWsD2EYETpK2xMIyqxaBbTtJRP0EEZdZ9QP79dcUi3OB2TrwY9GH7lGDoEq
         krRx3gZRy3gYLvlXmK7vaVWcJ6qhP9iQSjSiV3KGw+UYzWxxMVAh0qbn9bChaAHhCO82
         275hfzBQdapEKKFc6sjzUXTp6urpl3J+6T6vEv8hytjVtpbLBxbofuF1lFO/sY91pqyR
         GOi1mu0qSRMxYXpcMrnOHih8wmhUTPGeRXf7kUfSUbUcArbw1kuq1gXuLNdHxZx9CXsG
         hT0SdH/nxoXKYsoC8y5eGsrGW/tft8tMuAXb5DX94spFd54oO+KO9W9DiRDJzEz1t2xR
         GP1w==
X-Gm-Message-State: AOAM532qtAzWBWNemux8tWzcZeM/Fu2/W+bIKQgmKz99Wreg2nX6EOSp
        HvewysXJ70uNpD1M/fcgFvM=
X-Google-Smtp-Source: ABdhPJy7sK+kRF7O3U63SKcsVDq6jf6PiueRiXf23eWhoD9I0gKt28cPepzCcQYbks3N6RuQ9W25Hg==
X-Received: by 2002:a17:907:72cd:: with SMTP id du13mr13466420ejc.67.1598532235338;
        Thu, 27 Aug 2020 05:43:55 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id yh29sm1858939ejb.0.2020.08.27.05.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:43:54 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/11] doc: add corrected commit date info
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <f6f91af30587ec24e2eee052c89a536cbff42c4f.1597509583.git.gitgitgadget@gmail.com>
        <85y2m6fhkm.fsf@gmail.com> <20200827063951.GA16268@Abhishek-Arch>
Date:   Thu, 27 Aug 2020 14:43:53 +0200
In-Reply-To: <20200827063951.GA16268@Abhishek-Arch> (Abhishek Kumar's message
        of "Thu, 27 Aug 2020 12:09:51 +0530")
Message-ID: <85o8mwb6nq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Sun, Aug 23, 2020 at 12:20:57AM +0200, Jakub Nar=C4=99bski wrote:
>> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
[...]

>>> +    * This list of 4-byte values store corrected commit date offsets f=
or the
>>> +      commits, arranged in the same order as commit data chunk.
>>
>> I have just realized purely theoretical, but possible, problem with
>> storing non-monotinic generation number related values like corrected
>> commit date offset in constrained space.  There are problems with
>> clamping them.
>>
>> Say that somewhere in the ancestry chain there is a commit A with commit
>> date far in the future by mistake, for example 2120-08-22; it is
>> important for that date to be not able to be represented using uint32_t.
>> Say that a later descendant commit B is malformed, and has committer
>> date of 0, that is 1970-01-01. This means that the corrected commit date
>> for B must be larger than 2120-08-22 - which for this commit means that
>> corrected commit date offset do not fit in 32 bits, and must be clamped
>> (replaced) with GENERATION_NUMBER_V2_OFFSET_MAX.
>>
>> Say that we have commit C that is child of B, and it has correct commit
>> date.  Because of mistake in commit A, it has corrected commit date of
>> more than 2120-08-22 (corrected commit date degenerated into topological
>> level plus constant).
>>
>> Now C can reach B, and B can reach A.  However, if we recover corrected
>> commit date of B out of its date=3D0 and offset=3DGENERATION_NUMBER_V2_O=
FFSET_MAX
>> we get a number that is smaller than correct corrected commit date.  We
>> will have
>>
>>    gen(A) > date(B) + offset(B) < gen(C)
>>
>> Which breaks reachability condition guarantee.
>>
>> If instead we use GENERATION_NUMBER_V2_MAX for commits with clamped
>> corrected commit date, that is offset=3DGENERATION_NUMBER_V2_OFFSET_MAX,
>> we would get
>>
>>   gen(A) < GENERATION_NUMBER_V2_MAX > gen(C)
>>
>> And again reachability condition is broken.
>>
>> This is a very contrived but possible example.  This shouldn't happen,
>> but ufortunately it can happen.
>>
>
> Yes, that's very unfortunate.
>
> Here's a much simpler example:
>
> A commit P has an reasonable commit date (i.e. after release of Git to
> present) D and has a child commit C with committer date 0. Now, the
> corrected commiter date of C would D + 1 and the offset would be same too,
> as the committer date is zero. This overflows as reasonable dates are of
> the order 2 ^ 34.

No, we need the value of date D that doesn't fit in 2^32 _unsigned_ value,
so it needs to be even more in the future than Y2k38 (2038-01-19 03:14:07),
which is related to storing date as a _signed_ 32-bit integer

The current-ish Unix epoch time is 1598524281 - let's use it for value
of D.  Then the offset for commit C would be 1598524282.  The current
proposal uses 32 bits to store commit date offsets (as unsigned value).
The maximum value of offset that we can store is therefore 2^32 - 1,
which is 4294967295.

   corrected commit date offset(C) =3D 1,598,524,282
   GENERATION_NUMBER_V2_MAX        =3D 4,294,967,295

As you can see there is no overflow in the simplified example.

>>
>> The question is how to deal with this issue.  Ignore it as unlikely?
>> Switch to storing corrected commit date, which is monotonic, so if there
>> is commit with GENERATION_NUMBER_V2_MAX, then subsequent descendant
>> commits will also have GENERATION_NUMBER_V2_MAX -- and pay with up to 7%
>> larger commit-graph file?
>>
>
> To be honest, I would prefer storing corrected committer dates over
> storing offsets.
>
> While it is 7% of the size of commit-graph file, it is also *only* around
> ~3.5 MB for a repository of the size of linux kernel (and IIRC
> correctly, the Windows repo has ~2M commits, it amounts to ~8 MB).

It is up to 7% of per-commit data, and it doesn't take into account EDGE
chunk (for octopus merges), and it doesn't also take into account the
size of changed-paths Bloom filters data take in the commit-graph.

> Minimizing space and memory requirements are a top priority, but
> shouldn't making sure our program is correct and efficient to be a
> greater priority?

On the other hand the case where we would encounter offsets that do not
fit in uint32_t is extremply unlikely in sane repositories.

I can think of three solutions:

1. use 64-bit corrected commit dates
   - advantages:
     * simplest code,
     * no need for overflow handling, as we can store all possible values
       of timestamp_t
   - disadvantages:
     * commit-graph size increased by up to 7%

2. use 32-bit corrected commit date offsets,
   but simply do not store GDAT chunk if there is offset that would not
   fit in 32-bit wide field
   - advantages:
     * commit-graph is smaller
     * relatively simple overflow handling
   - disadvantages:
     * performance penalty (generation number v1 vs v2) for abnormal
       repositories (with overflow not fitting in uint32_t)
     * tests would be needed to exercise the overflow code

3. use 32-bit for corrected commit date offset,
   with oveflow handling, for example using most significant bit
   to denote that other bits store position into offset overflow
   with 64-bits for those offsets that do not fit in 31-bits
   - advantages:
     * commit-graph is smaller, increasing for abnormal repos
   - disadvantages:
     * most complex code of all proposed solutions
     * smaller overflow limit of 2^31 - 1
     * tests would be needed to exercise the overflow code

I think because the situation where we encounter overflow in 32-bit
corrected commit date offset is rare, we should go with either 1 or 2
solution.

> I would love to hear your and Dr. Stolee's opinions on this.

I have CC-ed Junio C Hamano to ask for his opinion.

>>> +    * This list can be later modified to store future generation numbe=
r related
>>> +      data.
>>
>> How can it be later modified?  There is no header, no version number.
>> How would we add another generation number data?
>>
>
> We could modify the graph version in future. Here's how I think it would
> work:
>
> Graph Version 1, No GDAT -> Topological level
> Graph Version 2, GDAT    -> Corrected committer dates
> Graph Version 3, GDAT    -> Generation number v3
>
> and so on.
>
> Of course, we do not have to update generation number definition for
> each graph version.

So it was about generic mechanism, not something specific to the GDAT chunk.

> However, my statement could still be wrong for things that we do not
> foresee (similar to how we missed the hard die on different graph version=
),
> so I am removing the statement.

Good.

[...]
>>> +We also merge commit-graph chains when we try to write a commit graph =
with
>>> +two different generation number definitions as they cannot be compared=
 directly.
>>> +We overwrite the existing chain and create a commit-graph with the new=
er or more
>>> +efficient defintion. For example, overwriting topological levels commi=
t graph
>>> +chain to create a corrected commit dates commit graph chain.
>>> +
>>
>> This is more complicated than that.
>>
>> I think we should explicitly state that Git ensures that in split
>> commit-graph chain, if there are layers without the GDAT chunk (that
>> force Git to use topological levels for generation numbers), then they
>> are top layers.  So if there is commit-graph file created by "Old" Git,
>> then when addig new layer it would also be GDAT-less.
>>
>> Now how to write this...
>
> Thinking about this, I feel creating a new section called "Handling
> Mixed Generation Number Chains" made more sense:
>
>   ## Handling Mixed Generation Number Chains
>
>   With the introduction of generation number v2 and generation data chunk,
>   the following scenario is possible:
>
>   1. "New" Git writes a commit-graph with a GDAT chunk.
>   2. "Old" Git writes a split commit-graph on top without a GDAT chunk.
>
>   The commits in the lower layer will be interpreted as having very large
>   generation values (commit date plus offset) compared to the generation
>   numbers in the top layer (toplogical level). This violates the
>   expectation that the generation of a parent is strictly smaller than the
>   generation of a child. In such cases, we revert to using topological
>   levels for all layers to maintain backwards compatability.
>
>   When writing a new layer in split commit-graph, we write a GDAT chunk
>   only if the topmost layer has a GDAT chunk. This guarantees that if a
>   lyer has GDAT chunk, all lower layers must have a GDAT chunk as well.
>
>   Rewriting layers follows similar approach: if the topmost layer below
>   set of layers being rewriteen (in the split commit-graph chain) exists,
>   and it does not contain GDAT chunk, then the result of rewrite does not
>   have GDAT chunks either.

Good idea, and nice writeup.

Best,
--=20
Jakub Nar=C4=99bski
