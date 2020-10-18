Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2554C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 05:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5062080D
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 05:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgJRF4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 01:56:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34445 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgJRF4I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 01:56:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id x1so6965285eds.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 22:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwZfVhYhp42PIA7K47gnd3qVXzq+lnCTG47cstwfnlE=;
        b=aeIRzpgjwYXs7aYXeXKTVCyRO7MZCKkEjtOQSf4Ny348j+0Zs0CBSN5cA966TNR9CG
         NPs3+CN9rJzzLFiFt+xmgupIdPxTy2K7/OgfozmHyNP+n321xKOXj0pzV1qaYP3HWj7Y
         OJYQE7QEewMEMafVE0JlHrjtd5I0WGh7NsLKyCXeblI4oZmykTyHw+yoomwseyjHyIXn
         FlcwzFFLMXX8PB150p8GlW/psts/4ZrtzYXMFnF4iD3OuahrtUm2eq4TUE7YuM2c73m5
         4beRqxgbj2Ucw/oHHddReh9q4IF0jr19DjzQhXSuoGqKbnFpHumXRD1vSO2oEv8yhSME
         MYrA==
X-Gm-Message-State: AOAM530374Dt6hC55e91usbTCr4EBXPO37e4m7HiZb4tR1IPLhHB5drX
        fXG199kJvMmrlkIcCtK5soFVuxAc+1j0D5yIrMm72YvOQoM=
X-Google-Smtp-Source: ABdhPJwxAJi6kRb/P2iCVY5rcJWAiW6ybyfX9re6KKhWKivc0X43h10S/x73v9M4gigelOuSIuK1n103/JT6NxxRjtM=
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr12546035edj.94.1603000566422;
 Sat, 17 Oct 2020 22:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com> <0a1550cb225591a53118bd8f7782d95de5a4df34.1602950552.git.gitgitgadget@gmail.com>
In-Reply-To: <0a1550cb225591a53118bd8f7782d95de5a4df34.1602950552.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Oct 2020 01:55:55 -0400
Message-ID: <CAPig+cRuutHJ64aXQy5X9h-Vg4=_NKKyL57KdwbvXj4cGRS1PQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] t2200: modify code syntax
To:     Amanda Shafack via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 17, 2020 at 12:02 PM Amanda Shafack via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Using the logical not operator on both the git and grep command is
> redundant, since the main check is done at the level of the grep
> command.
>
> Apply the logical not operator only to the grep command.
> ---
> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> @@ -179,10 +179,8 @@ test_expect_success 'add -u resolves unmerged paths' '
> -       ! (
> -               git ls-files >actual &&
> -               grep "non-existent" actual
> -       )
> +       git ls-files >actual &&
> +       ! grep "non-existent" actual

The commit message talks only about redundancy of applying the logical
NOT operator to the combined subshell content, but what it misses is
that transformation of:

    ! (git ls-files | grep "non-existent")

in patch [1/2] into:

    ! (
        git ls-files >actual &&
        grep "non-existent" actual
    )

is actively wrong. In particular, if `git ls-files` itself fails, then
the `grep` will never get run, and the subshell will exit with a
failure, however, the NOT then turns that failure into a success,
which is quite undesirable. The test should fail if either `git
ls-files` fails or if the `grep` expectation is not met; it should not
succeed when `git ls-files` fails.

So, the correct thing to do is to merge [1/2] and [2/2] into a single
patch which directly transforms:

    ! (git ls-files | grep "non-existent")

into:

    git ls-files >actual &&
    ! grep "non-existent" actual
