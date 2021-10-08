Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9BBC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC5A60E98
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhJHH4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhJHH4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 03:56:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308DC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 00:54:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z20so32690885edc.13
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=j+T/kUNiMrxs2Y+2DZwUqSeKGhW5rVmks5ScyFs5pPU=;
        b=VoXjoa7z181YMo2oMr8GatDrmeSE8t+NnOgM3SACOW9h3B4WQFowTxSl1QJN4Y56Ml
         Ivjk+CCNlazWrQiqFVuRPeQScKX2isk10vYpVHwhXm2bUG2VMEJuutOdYJVXf3pUnVe9
         c9ZhJyGeAKlFHpdpuWSkEvEifQ9rDNRm8OTBD/5AoVg/1m+Fv8/gpuPbQgIr5HXZ765D
         iwYBtXLDf4qzV0XjULtwh9TLlEPcKQ+fD4CAfwwg/H21+z6MbDHwNawRtZzJ4mlrgjxL
         LQX6fvkyKgvEyfEt38rabrjt+hd+1e7rlyija65/mxATVlj1jMKGuljSPpTlwWLrEk3a
         gqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=j+T/kUNiMrxs2Y+2DZwUqSeKGhW5rVmks5ScyFs5pPU=;
        b=QMpct4qyb1MCQJPb6Go7yC+Vt0Snqg71ypSAevktGEBOpcB2ELOonGZM8SZ3Jv2rJA
         L9dFcmgvn8n3TYQLr9NianFNLf62ivCqKosa3y8YjXkNfDcxDnxXMBjuU//naW9sjmmB
         utsn/6mBcPOnjyRe5q5MhMzHkcIdD2sK2FU81sc7FBFvimmhNQLRiE0RgkBlj3Sx38qE
         rfqJBUXD/ZL/SaS2CahylAYxUsITfZ/JKr92VAxP+9besGFulHpDu8dSDJq58D69RO2z
         b8PWDjpN6zFv7KFyK3MaM7uwQ68oJe/X1bJCvOQx/NXWta7mHY09vHMLdhjpzPW/dXU/
         ACSw==
X-Gm-Message-State: AOAM532obTm4ARgUvFRDLmfGfANRHO4icdrbMSgBA5r89jja15+2eEZC
        YufHObA3uPlPJyBTrQr5q3M=
X-Google-Smtp-Source: ABdhPJwUjap5PtP/pwdNbxMAPKmfRfVMdRXqapGOODJGNSQ3GnyAcE8guliOHFNPzpop0JVaUHESfw==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr12454262edd.212.1633679659498;
        Fri, 08 Oct 2021 00:54:19 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u4sm636964ejc.19.2021.10.08.00.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 00:54:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: A hard dependency on "hyperfine" for t/perf
Date:   Fri, 08 Oct 2021 09:47:58 +0200
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
 <YVyPH59LpxFLHep0@nand.local> <YV3314Dnhj7srFZ4@coredump.intra.peff.net>
 <3f03ed89-d3db-32ba-3c1f-b8fac7cfb097@jeffhostetler.com>
 <YV+zFqi4VmBVJYex@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YV+zFqi4VmBVJYex@coredump.intra.peff.net>
Message-ID: <87pmsgeytx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Jeff King wrote:

> And there I think the whole "take the best run" strategy is hampering
> us. These inaccuracies in our timings go unseen, because we don't do any
> statistical analysis of the results. Whereas a tool like hyperfine (for
> example) will run trials until the mean stabilizes, and then let you
> know when there were trials outside of a standard deviation.
>
> I know we're hesitant to introduce dependencies, but I do wonder if we
> could have much higher quality perf results if we accepted a dependency
> on a tool like that. I'd never want that for the regular test suite, but
> I'd my feelings for the perf suite are much looser. I suspect not many
> people run it at all, and its main utility is showing off improvements
> and looking for broad regressions. It's possible somebody would want to
> track down a performance change on a specific obscure platform, but in
> general I'd suspect they'd be much better off timing things manually in
> such a case.
>
> So there. That was probably more than you wanted to hear, and further
> than you want to go right now. In the near-term for the tests you're
> interested in, something like the "prepare" feature I outlined above
> would probably not be too hard to add, and would address your immediate
> problem.

I'd really like that, as you point out the statistics in t/perf now are
quite bad.

A tool like hyperfine is ultimately generalized (for the purposes of the
test suite) as something that can run templated code with labels. If
anyone cared I don't see why we couldn't ship a hyperfine-fallback.pl or
whatever that accepted the same parameters, and ran our current (and
worse) end-to-end statistics.

If that is something you're encouraged to work on and are taking
requests :) : It would be really nice if t/perf could say emit a one-off
Makefile and run the tests via that, rather than the one-off nproc=1
./run script we've got now.

With the same sort of templating a "hyperfine" invocation would need
(and some prep/teardown phases) it would make it easy to run perf tests
in parallel with ncores, or even across N number of machines.
