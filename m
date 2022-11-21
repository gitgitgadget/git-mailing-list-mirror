Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF6C4167B
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 14:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiKUO5u convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Nov 2022 09:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiKUO5N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 09:57:13 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E64DC6578
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:48:25 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id g10so10760836plo.11
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63iUux/z1Xa0pL/MRqCLj7H/11/KhciWYoovXN5e0P8=;
        b=NnBOZs5WlITteVzdwgEpjY+xYY3Mcx2Ob3JNBjf89B1mN3ICivCc/hQ3g4UVqHfQ3z
         kOTiUk4OKEV/5xFSsqVp0wjKvbns1VOMfs9gEvdgsXWVVA4UOUNghVpi3j6scBabTEpR
         MmL0oW6feP0glxIQ78/ArP1lkH7LwEBiCBrViO3rREzz08SCgofQd27Y+66eiWr20HMn
         iZalu6PuIvc1lu6H9FvAeM6TcIvevr+PreUnYOkISAvMpIFG/b6KYQnuVBCO5c7Vbvr6
         ZOWH0yBRtY+wtrnzXZMzOvpZMtBFVSb2LUY0Ck7eRVhP4aGRtQBSTdH9pgHxbfFFZwNg
         XNAQ==
X-Gm-Message-State: ANoB5pl7b/pxlaZ62Cc3NPi7HmQvCgTM8Ib8jF4YZ8TJ4LrV+KJfD9xU
        rcUXC7X+cZ8GYszWu76wiGHiAJX8Xn8H2HjdSx4=
X-Google-Smtp-Source: AA0mqf50ESnayp45bo/Xz5CS/BBfcduEorAS6LnzHFLsxCSEVmeX64+6wr8eo+t6uEM4nfwRY6gbdxdbRaqmWKPfxoM=
X-Received: by 2002:a17:90a:898b:b0:218:bbfb:72e1 with SMTP id
 v11-20020a17090a898b00b00218bbfb72e1mr3469588pjn.64.1669042104405; Mon, 21
 Nov 2022 06:48:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr> <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net> <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
 <221121.86tu2sbfh8.gmgdl@evledraar.gmail.com> <CAPig+cS3Ui=SFuRLPKKugT9RFvtUV3FmO23Wse_Rhih5hgbPmg@mail.gmail.com>
 <221121.86leo4bd91.gmgdl@evledraar.gmail.com>
In-Reply-To: <221121.86leo4bd91.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Nov 2022 09:48:13 -0500
Message-ID: <CAPig+cTTWu+bO3xMZrrKCLxmtBeJoToP-eMdsin7qMm-BC07iw@mail.gmail.com>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 9:20 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Nov 21 2022, Eric Sunshine wrote:
> > Oh, I didn't at all mean that `make` parallelism would be helpful on
> > Windows; I can't imagine that it ever would be (though I could once
> > again be wrong). What I meant was that `make` parallelism would be a
> > nice improvement and simplification (of sorts), in general,
> > considering that I've given up hope of ever seeing linting be speedy
> > on Windows.
>
> But just ditching the "ithreads" commit from chainlint.pl should make it
> much faster, as sequentially parsing all the files isn't that slow, and
> as that won't use threads should be much faster then.

On my (old) machine (with spinning hard drive), `make test-chainlint`
with "ithreads" and warm filesystem cache takes about 3.8 seconds
walltime. Without "ithreads", it takes about 11.3 seconds. So, the
improvement in perceived time is significant. As such, I'm somewhat
hesitant to see "ithreads" dropped from chainlint.pl before `make`
parallelism is implemented. (I can easily see "drop ithreads" as the
final patch of a series which adds `make` parallelism.)

But perhaps I'm focussing too much on my own experience with my old
machine. Maybe linting without "ithreads" and without `make`
parallelism would be "fast enough" for developers using beefier modern
machines... (genuine question/thought since I don't have access to any
beefy modern hardware).
