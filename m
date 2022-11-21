Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF5C43219
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 14:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKUOLO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Nov 2022 09:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiKUOK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 09:10:56 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB633C63
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:07:45 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id z26so11436092pff.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr6UFFXh1fA17Dq2iLs46cUDO8eJ+/ZJjzBm6G/NNNI=;
        b=QCT8vd8rp3cyantQeOYxaHDwfBKaOm5dLvSZjtVcSrL0WsduP6GBo8NDnt79Ai44oz
         uivW1o53blAQmRP5mAKYJv9SHO1nHUqcXNKYiZ4I66cZtD7g5Yv6ZaQCz2N9F16wrBco
         2VXc3ZjO2bNRut7WJuD/iTAZ/i71niwVIbzm0HTUmzynHtQXpZ1/l2HNY/Q8ZMhnOxKz
         1kzdMz0HZO415AVJPz7b3mtW61W9tgu0mo9b0Yp28xLHu+kMdTeXI+PfTlgjdWE4t0ld
         Zfyj6zl8QGfMQiC+3OpC9cfsyaVdmS4+VoKw18MICHYW+KDkBYGlrib+hdcEU/nAvtW5
         Tmdw==
X-Gm-Message-State: ANoB5plKPwdmaZ7YVRI36iACWZbO6XW5Elz/4XaCU2iTNZEv2rzUgBIZ
        1IOV3iEV7y9sR5ImI42SNH7giLDI1nqbur2hpsM=
X-Google-Smtp-Source: AA0mqf4vZxvkGK8fbTPn/Ac1kKnIANnTf8iuiTJSNSYMCeDDcGVVV3ra14SI8HNPCDBxujGMGHbMpXgIBe6/CjsFTEc=
X-Received: by 2002:a05:6a00:24c1:b0:56e:a001:8cb0 with SMTP id
 d1-20020a056a0024c100b0056ea0018cb0mr496634pfv.60.1669039665200; Mon, 21 Nov
 2022 06:07:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr> <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net> <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
 <221121.86tu2sbfh8.gmgdl@evledraar.gmail.com>
In-Reply-To: <221121.86tu2sbfh8.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Nov 2022 09:07:33 -0500
Message-ID: <CAPig+cS3Ui=SFuRLPKKugT9RFvtUV3FmO23Wse_Rhih5hgbPmg@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 8:32 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Nov 20 2022, Eric Sunshine wrote:
> > Somehow Windows manages to be unbelievably slow no matter what. I
> > mentioned elsewhere (after you sent this) that I tested on a five or
> > six year old 8-core dual-boot machine. Booted to Linux, running a
> > single chainlint.pl invocation using all 8 cores to check all scripts
> > in the project took under 1 second walltime. The same machine booted
> > to Windows using all 8 cores took just under two minutes(!) walltime
> > for the single Perl invocation to check all scripts in the project.
>
> I'd be really interested in seeing e.g. the NYTProf output for that run,
> compared with that on *nix (if you could upload the HTML versions of
> both somewhere, even better).

Unfortunately, I no longer have access to that machine, or usable
Windows in general. Of course, someone else with access to a dual-boot
machine could generate such a report, but whether anyone will offer to
do so is a different matter.

> Maybe "chainlint.pl" is doing something odd, but this goes against the
> usual wisdom about what is and isn't slow in Perl on windows, as I
> understand it.
>
> I.e. process star-up etc. is slow there, and I/O's a bit slower, but
> once you're started up and e.g. slurping up all of those files & parsing
> them you're just running "perl-native" code.
>
> Which shouldn't be much slower at all. A perl compiled with ithreads is
> (last I checked) around 10-20% slower, and the Windows version is always
> compiled with that (it's needed for "fork" emulation).
>
> But most *nix versions are compiled with that too, and certainly the one
> you're using with "threads", so that's not the difference.
>
> So I suspect something odd's going on...

This is all my understanding, as well, which is why I was so surprised
by the difference in speed. Aside from suspecting Windows I/O as the
culprit, another obvious possible culprit would be whatever
mechanism/primitives "ithreads" is using on Windows for
locking/synchronizing and passing messages between threads. I wouldn't
be surprised to learn that those mechanisms/primitives have very high
overhead on that platform.

> > Overall, I think Ævar's plan to parallelize linting via "make" is
> > probably the way to go.
>
> Yeah, but that seems to me to be orthagonal to why it's this slow on
> Windows, and if it is that wouldn't help much, except for incremental
> re-runs.

Oh, I didn't at all mean that `make` parallelism would be helpful on
Windows; I can't imagine that it ever would be (though I could once
again be wrong). What I meant was that `make` parallelism would be a
nice improvement and simplification (of sorts), in general,
considering that I've given up hope of ever seeing linting be speedy
on Windows.
