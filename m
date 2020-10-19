Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F4FC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A831822400
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="GDJtZqXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgJSVym (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJSVym (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:54:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CCFC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:54:42 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k25so1727469ioh.7
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OAifbJSWSvgnGcVkay8r0/w96WRvvDdCe7JjoRxyhGc=;
        b=GDJtZqXnQGJsddpE8N8NJtEt8v/uk95n2kYGM+FpsuaXpmn+EvxJ3hIPnsdnpLevi5
         0q6niCV7HWsxVvAlk7rRqtOSaO79FjZDPtfTwJxYwpVJJIqqQ43V3gS+rDfHCmKrYymf
         FIwoKUbt9UnFrWe3US09yMTIXOqRBXy9tGR4isuyAgKb/AMvxbzVGydNOu+lgztkhWw3
         xDeGco61hU2zEuw7TanQtIxaKX7I3RBYaiAC3kopXMGJZBqhQoLBlSXHeCtX6aexoGx8
         C2kZMdWWUWpeGbvBa9Y6LKhtxLkjr41wONIDyCdqWUoCoaTWaPt1VmAm9tR9gbHZrYS1
         koGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OAifbJSWSvgnGcVkay8r0/w96WRvvDdCe7JjoRxyhGc=;
        b=h3iBmhRudxWETlRomfZ48TerI4Sv9t12PnR1i+m9ZsVxHubeMHwR1a4UoVPBQr3OaU
         VIhuSOdYA6rV/ySa48nbtl67uHwkbwqMtgPrlaZyPLw9/zsnqyOIi+3Tw9wVoZI/0dDO
         ePUo5jc+Can0xy/ioFI+ZCoR8/3n8HO4F+Rt4D2htqSWUZ85PQBK/qQLlz2QmWnI6N2K
         UrqXUt8vNtAQCgsfn1fvPPH924JMgiMOVYsSq2XtvcPqAJdzGXnAwmlXzphlQkxcD3qE
         uMtxtKt/KdkKdSt1SSR9oDvYpD+j/ImKxDwvyANvD12Zu3H41K7n83ZoUPWRIWB1ATzV
         JHZQ==
X-Gm-Message-State: AOAM533F+HSZAHi5Vwzwn11qxr053i8XVHY0ejLbxomWZZmej+CwNPqT
        NpbypiE5tkFn/G+21IvzWlUqCQ==
X-Google-Smtp-Source: ABdhPJwbyETTntzA4fYkHxW5t+f58MFO0pKeR7GHDzvE4YkJleJ2ymBOGBMBcBQIzvBW2/JVzTFzjQ==
X-Received: by 2002:a02:3e13:: with SMTP id s19mr1673645jas.61.1603144481453;
        Mon, 19 Oct 2020 14:54:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id j20sm975090ile.55.2020.10.19.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:54:40 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:54:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/4] t/perf: add fsmonitor perf test for git diff
Message-ID: <20201019215438.GA49623@nand.local>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <f572e226bb5e4b67cc57f8d9d4732086f01190a2.1603143316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f572e226bb5e4b67cc57f8d9d4732086f01190a2.1603143316.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 09:35:15PM +0000, Nipunn Koorapati via GitGitGadget wrote:
> From: Nipunn Koorapati <nipunn@dropbox.com>
>
> Results for the git-diff fsmonitor optimization
> in patch in the parent-rev (using a 400k file repo to test)
>
> As you can see here - git diff with fsmonitor running is
> significantly better with this patch series (80% faster on my
> workload)!

These t/perf numbers are very helpful, at least to me.

> GIT_PERF_LARGE_REPO=~/src/server ./run v2.29.0-rc1 . -- p7519-fsmonitor.sh
>
> Test                                                                     v2.29.0-rc1       this tree
> -----------------------------------------------------------------------------------------------------------------
> 7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)                 1.46(0.82+0.64)   1.47(0.83+0.62) +0.7%
> 7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)            0.16(0.12+0.04)   0.17(0.12+0.05) +6.3%
> 7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)           1.36(0.73+0.62)   1.37(0.76+0.60) +0.7%

Looks like about 0.01sec of overhead, which seems like an acceptable
trade-off for when the user has at least 10,000 files.

This reminds me; did you look at the 'git add' performance change? I
recall Junio mentioning that 'git add' takes the same paths in the code.

> 7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)                   0.85(0.22+0.63)   0.14(0.10+0.05) -83.5%
> 7519.6: diff -- 0_files (fsmonitor=.git/hooks/fsmonitor-watchman)        0.12(0.08+0.05)   0.13(0.11+0.02) +8.3%
> 7519.7: diff -- 10_files (fsmonitor=.git/hooks/fsmonitor-watchman)       0.12(0.08+0.04)   0.13(0.09+0.04) +8.3%
> 7519.8: diff -- 100_files (fsmonitor=.git/hooks/fsmonitor-watchman)      0.12(0.07+0.05)   0.13(0.07+0.06) +8.3%
> 7519.9: diff -- 1000_files (fsmonitor=.git/hooks/fsmonitor-watchman)     0.12(0.09+0.04)   0.13(0.08+0.05) +8.3%
> 7519.10: diff -- 10000_files (fsmonitor=.git/hooks/fsmonitor-watchman)   0.14(0.09+0.05)   0.13(0.10+0.03) -7.1%

OK... so having fsmonitor turned on adds an imperceptible amount of
slow-down to cases where there are [0, 10000) files. But, in exchange,
you get much-improved whole-tree performance, as well as single-tree
performance when that tree contains at least 10,000 files.

I was going to say that this has little downside, because turning on
fsmonitor is probably a good indicator that you don't have any fewer
than 10,000 files in your repository, but I think that's missing the
point. Likely true, but that doesn't exclude the possibility of having
sub-10,000 file directories, which users may very well still be
diff-ing.

So, there's a slow-down, but it's hard to complain when you consider
what we get in exchange.

> 7519.12: status (fsmonitor=)                                             1.67(0.93+1.49)   1.67(0.99+1.42) +0.0%
> 7519.13: status -uno (fsmonitor=)                                        0.37(0.30+0.82)   0.37(0.33+0.79) +0.0%
> 7519.14: status -uall (fsmonitor=)                                       1.58(0.97+1.35)   1.57(0.86+1.45) -0.6%
> 7519.15: diff (fsmonitor=)                                               0.34(0.28+0.83)   0.34(0.27+0.83) +0.0%
> 7519.16: diff -- 0_files (fsmonitor=)                                    0.09(0.06+0.04)   0.09(0.08+0.02) +0.0%
> 7519.17: diff -- 10_files (fsmonitor=)                                   0.09(0.07+0.03)   0.09(0.06+0.05) +0.0%
> 7519.18: diff -- 100_files (fsmonitor=)                                  0.09(0.06+0.04)   0.09(0.06+0.04) +0.0%
> 7519.19: diff -- 1000_files (fsmonitor=)                                 0.09(0.06+0.04)   0.09(0.05+0.05) +0.0%
> 7519.20: diff -- 10000_files (fsmonitor=)                                0.10(0.08+0.04)   0.10(0.06+0.05) +0.0%

Great! No slow-down without fsmonitor enabled, as expected. Fantastic.

> I also added a benchmark for a tiny git diff workload w/ a pathspec.
> I see an approximately .02 second overhead added w/ and w/o fsmonitor
>
> From looking at these results, I suspected that refresh_fsmonitor
> is already happening during git diff - independent of this patch
> series' optimization. Confirmed that suspicion by breaking on
> refresh_fsmonitor.

So, the overhead that we're paying is purely the pipe+fork+exec? I.e.,
that watchman has already computed an answer in the earlier call, and we
just have to read it again (or find out that the last results were
unchanged)?

> (gdb) bt  [simplified]
> 0  refresh_fsmonitor  at fsmonitor.c:176
> 1  ie_match_stat  at read-cache.c:375
> 2  match_stat_with_submodule at diff-lib.c:237
> 4  builtin_diff_files  at builtin/diff.c:260
> 5  cmd_diff  at builtin/diff.c:541
> 6  run_builtin  at git.c:450
> 7  handle_builtin  at git.c:700
> 8  run_argv  at git.c:767
> 9  cmd_main  at git.c:898
> 10 main  at common-main.c:52

:-).

> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 71 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 9313d4a51d..2b4803707f 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -115,6 +115,13 @@ test_expect_success "setup for fsmonitor" '

Everything in here looks very reasonable to me, except for the seq vs.
test_seq() issue that I pointed out in another email in this thread.

It's too bad that we have to write these twice, but that's not the fault
of your patch.

Thanks,
Taylor
