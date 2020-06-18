Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1EEC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F9222201
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQB01Dhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbgFRBnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732701AbgFRBm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 21:42:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABFEC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:42:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w1so4102255qkw.5
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OxJKNTdY0L+lpPJhqtfEEqId2wRMnq/p1ERfPxBbtPM=;
        b=dQB01DhyuKJnvuyhVrRgR7biAKvY1ZyI1aIiH9C3d4oph9sYJKemcUnV6/0NqNhkCz
         Ju/JbuyXnbsqJZmoiRoYWu08QfzNVjQfajB/v4jFbJxEXAwAigzPgl8XK9CUdPg2KcIQ
         3yAYdpisjIVdmQgytV9QanvfZXbRenk4n7SIkmK26FganawMUzk8KcQLdBrNBV3Vw/Fa
         W5aSd/OTs1cnfw2DbJYZoj90dhkKg+EahYL2AyfPkCNCJOKI/5EhcEenZ99MqeiMq7Cl
         iYCfWwm4BRxySsUzizX3Z7ILkgDK4oOFSKVKfI80MFOLRW+3Ilr0QysKnN1r5uCJgewg
         Q3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OxJKNTdY0L+lpPJhqtfEEqId2wRMnq/p1ERfPxBbtPM=;
        b=oIBjwyLPTwsLSk96gneJmMR3Kf/sgKEfEVf+IP4klnGgNWW6vycw8S526xo9H+SyEk
         OvcP3wwOfJ/vmIMB0z7Lb3ASJvMgY+RUiquadzljovJEr2KOkK1oKnaTxg5Dw//YfwDO
         X0TsRcrXxsKIruvs+DG24LhQkKxqzpS5O4SV+H/g1Iww9Cbg+Jx+m0zzPwSDkIDdQ1q0
         W7a5RzTE4lpDv7tUHar4Ow79qQXGgRiI8xmPK5g02juSocBadrKeSLvpU8BFFb0IJaGF
         4UTOS72u1IjvpdfcPlNeJKF/nDi2PPFtcnTBiwi3LzB1r/gvPE4yH2yjoPht9av9Jv5V
         gECg==
X-Gm-Message-State: AOAM532bFN4usTrKRShGD1wi1JsHeDgpP5PgcepbM1wr98U6dEXeVNAv
        BHFLRzfOfw0uBrPqOOLgKd0=
X-Google-Smtp-Source: ABdhPJxADMeC36h6YDEwmJ64GoFo0Op/nJRlQP/w+Ou51mtMXKT/QihEWgYeZx0N/+x6Wi3ucYS5KA==
X-Received: by 2002:a37:c17:: with SMTP id 23mr1571248qkm.235.1592444575969;
        Wed, 17 Jun 2020 18:42:55 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p13sm1781017qtk.24.2020.06.17.18.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 18:42:55 -0700 (PDT)
Subject: Re: [PATCH 00/10] [RFC] In-tree sparse-checkout definitions
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <CABPp-BET86K_N5_W1pXMWeFccbUdxU8+vNvi+m-i6PX0MrXknw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <64d477b6-7bf2-fa0d-b9b4-821285af386e@gmail.com>
Date:   Wed, 17 Jun 2020 21:42:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BET86K_N5_W1pXMWeFccbUdxU8+vNvi+m-i6PX0MrXknw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/17/2020 7:14 PM, Elijah Newren wrote:
> Hi,
> 
> Another late addition...
> 
> On Thu, May 7, 2020 at 6:20 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
>> IN-TREE SPARSE-CHECKOUT DEFINITIONS
>> ===================================
>>
>> Minh's idea was simple: have sparse-checkout files in the working directory
>> and use config to point to them. As these in-tree files update, we can
>> automatically update the sparse-checkout definition accordingly. Now, the
>> only thing to do would be to ensure that the sparse-checkout files are
>> updated when someone updates the build definitions. This requires some extra
>> build validation, but would not require special tools built on every client.
> 
> "In-tree" still bugs me after a few weeks; the wording seems slightly
> awkward.  I don't have a good suggestion, but I'm curious if there's a
> better term.

I am open to suggestions. It reminds me of the two hardest problems
in software engineering:

	1. concurrency
	2. naming things
	3. off-by-one errors

> But I really came here to comment on another issue I think I glossed
> over the first time around.  I'm curious if all module definition
> files have to exist in the working directory, as possibly suggested
> above, or if we can allow them to just exist in the index.  To give
> you a flavor for what I mean, with my sparsify tool people can do
> things like:
>     ./sparsify --modules MODULE_A
> which provides MODULE_A and it's dependencies while removing all other
> directories.  If MODULE_B, is not a dependency (direct or transitive)
> of MODULE_A, it will not exist in the working directory after this
> step.  Our equivalent of the "in-tree" definition of MODULE_B exists
> *in* the directory for MODULE_B, because it seems to make sense for
> us.  I want people to be able to do
>     ./sparsify --modules MODULE_B
> and have it correctly check out all the necessary files even though
> the definition of MODULE_B wasn't even in the working directory at the
> time the command ran.  (The sparsify script knows to check the working
> directory first, then fall back to the index).

I think one tricky part of my RFC is that it _only_ looks at the
index. This allows us to read the contents even when the files are
not part of the current sparse-checkout definition.

You mentioned in another thread that it is a bit unwieldy for a user
to rely on a committed (or staged?) file, so adding the ability to
check the working directory first is interesting. I wonder how the
timing comes into play when changing HEAD to a new commit? Seems
tricky, but solvable.

Thanks,
-Stolee



