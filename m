Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AE0C28D13
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 03:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbiHWDII (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 23:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbiHWDHj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 23:07:39 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D395A5EDC6
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 20:05:17 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c20so9454365qtw.8
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 20:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KOPEURay4owmSPog3r8bezTTxLowPcVygsoVlaC6Me8=;
        b=fRepKNptZU4cZIQPAr1FbuUzPMGoLrqu1tuR2d43ipwy5dr88wY67gUQ8jsQHS49YG
         /PPkkcE40Nr3xmBJ9SBpcQzI3frttsOnhd8gL8egGYav2zfYeRgbB2dAW5eqH57Ty8Ko
         hx/eFJUnjG/rVoWpr95Jb92rQDDYZgkrN9clRBc2LB/qp6Zz1r8e3aEraw9T53QV+0nP
         b3N5GIcoAMqmU/p7fsRPnz4EiODOoekNQrSpYbB9u3vawfB6sECfdOXYTcHxmL2ufRqY
         gYdpk1Wu8jl6m0Lp1UwC06pX2aDvSTbcyxoDPRsejJfRUn6P7fyxmotzXMsxlnArUlVp
         pwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KOPEURay4owmSPog3r8bezTTxLowPcVygsoVlaC6Me8=;
        b=AA558ENjJYoRiFJTOA7IcjXlrkRfJEi4rOIMeHYWqxWS4nC9dBQcc4lR8SMC5GMmEY
         dyOT55w8JczCf50q42y2zfYd77Klnzva/rl+OmYG7aXFoptQTo8ag73rysfDRWW+ZQyy
         RzvfQ6FQRZs9Y3Ucb133BlrEcR0cyN2lTDix2nHsXfviTbeCXUG7o+grmBGnIzmx989O
         ojeAUwjQfgeGLqR2yZFU5HbX20RceIT4YoO4ymnjDD5rl8mr1Mvg8PKAoIvVxqcr0Yf1
         ymWx4Wq4Vb0g+wWT3nrDUrmXorhp9kFBhYy+FiAFDB+9YPxcHXMjZ4azDPc9rkc8PYu2
         Z4Hg==
X-Gm-Message-State: ACgBeo1B4r1hc2PSF0GKS/KVzJl89il0WLivRVOzeQIEIRok1zVgx+wL
        rKtnnTzPWSwPpIhhFu6FV+sq8m/6Qv26vHcJmn+ixyzB
X-Google-Smtp-Source: AA6agR6ymsjzz8lsrSrDNvRvet3E+U1YsiyZA+zb36mJwkEoywfkKF6ix95/umeHpLkNQDyzg8T7ettFscVtwfEQnwE=
X-Received: by 2002:ac8:5f09:0:b0:343:67b3:96f5 with SMTP id
 x9-20020ac85f09000000b0034367b396f5mr17904925qta.470.1661223916625; Mon, 22
 Aug 2022 20:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com> <31a962fd5070d68964e545fb5506d795e8845ec3.1661192802.git.gitgitgadget@gmail.com>
In-Reply-To: <31a962fd5070d68964e545fb5506d795e8845ec3.1661192802.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Aug 2022 20:05:05 -0700
Message-ID: <CABPp-BH-QzH-5MmvBwqncxr2VQQPfAk0oEYus2HMgdmpX3ppUg@mail.gmail.com>
Subject: Re: [PATCH 3/3] t: detect and signal failure within loop
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 11:26 AM Eric Sunshine via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> Failures within `for` and `while` loops can go unnoticed if not detected
> and signaled manually since the loop itself does not abort when a
> contained command fails, nor will a failure necessarily be detected when
> the loop finishes since the loop returns the exit code of the last
> command it ran on the final iteration, which may not be the command
> which failed. Therefore, detect and signal failures manually within
> loops using the idiom `|| return 1` (or `|| exit 1` within subshells).
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
[...]
> diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
> index e1ce9199164..650b3cd14ff 100755
> --- a/t/t6429-merge-sequence-rename-caching.sh
> +++ b/t/t6429-merge-sequence-rename-caching.sh
> @@ -725,7 +725,7 @@ test_expect_success 'avoid assuming we detected renames' '
>                 mkdir unrelated &&
>                 for i in $(test_seq 1 10)
>                 do
> -                       >unrelated/$i
> +                       >unrelated/$i || exit 1
>                 done &&
>                 test_seq  2 10 >numbers &&
>                 test_seq 12 20 >values &&
> --
> gitgitgadget

That's not something I'm likely ever going to remember to think of as
capable of failing and needing this special care.  Is this a
preliminary series before you send chainlint improvements that finds
this kind of thing for us?  Or did you notice this some other way?

Change is fine, of course, I'm just curious how it was found (and how
I can avoid adding more of these that you'll need to later fix up).
