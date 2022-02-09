Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76727C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 06:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiBIG41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 01:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiBIG4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 01:56:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE8C05CB8C
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 22:56:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id a15-20020a17090ad80f00b001b8a1e1da50so1170176pjv.6
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 22:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Clb1mdGcBGQlP2211bjHSs+gXmDKv8M8Hs/N/LV80Ig=;
        b=haCUhxr7YUjb4URFHt93ZI4mJtq9iFxBIdcw6/n7WOjXPkiZxkvJ7rFVc8eWAV/RSk
         jhFYmUicENsFMn87rpIwx/Az32eqOMPmiSxBJV2i32A9FM57+eqPFevBjEgJO6Vm99Lf
         lZUrJ6zTL+nUfHOuwxCMi6M9dr+3AzmQgLP7qReNEbUbdnpm/Wp8JgB3iGrbMUi6+pMs
         wx43yDp1KM39qooh8ZSNJswgyVe0Div/OpeRa/FPZsk/FEUTrQA9HzvG01MYNnXX2GF3
         LwKCp+nlpxTm6+arJZKQbQNUhzv1qlRLLWeXMdhDgb6jyudOPKaM1bwjbBpRCoddPpuy
         vaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Clb1mdGcBGQlP2211bjHSs+gXmDKv8M8Hs/N/LV80Ig=;
        b=vlw5phOH5RIdqCGud0RFxVvZcQN2/FKTthUzoQJ85BPLLqxfS/kG3fselzH1Qo7/ju
         bd4x/bYa70Y4bSCp5mShHqKK/HQ3GmspJ4RYyWx/Lr9DjTf36rJTNvi9tF20P69D8ihO
         gUE4HgplN4npCWNvZU0Bk0zdlngkHuqvqIPKGKWF9rgDv21srIO43+grNFpt6ZrN3nae
         yk53NI2rDpSFR3Azuyt1AqJcFg0AU3/2tAxRfBXw3TtHiX8M+xevRUe9DFgotAgFs5mN
         1giFfIjZQXghpSGWCsgBxST6SNpCmADIfelI5SDEdrc7l1S3hLIFQw9VmTSZKBqecHPu
         S8sw==
X-Gm-Message-State: AOAM530hN0LBvcbgeU1qcZQ7nWJemsScvIOt1nhOgO9lZALDivY2vUog
        075bBI2bewYlGW/r3Qtl6fGBe8g2cB/ztTtSlvM+pDdEzchhKvs3SU/E1VIPMlp26oAMip8jP+W
        F9NP/GkIlHGnsNbNxoJ/4+U+Ssy7Xa5A8g5nXOoARUF90Hnrb5/IGdNkZJ1Xbyhs=
X-Google-Smtp-Source: ABdhPJwP8oQoME49Gz0n1Jl8G0ybTRjd6opKrQnhRAb8v7xJMfzgGgRLK3NcmPYAT8oZ0RV+nWZ8L4Yr7bsX5Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:174b:: with SMTP id
 j11mr914744pfc.19.1644389786008; Tue, 08 Feb 2022 22:56:26 -0800 (PST)
Date:   Wed, 09 Feb 2022 14:56:23 +0800
In-Reply-To: <20220209065236.36494-1-chooglen@google.com>
Message-Id: <kl6lczjwfrzc.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220209065236.36494-1-chooglen@google.com>
Subject: Re: [PATCH 0/1] checkout: teach "git checkout" to checkout submodule branches
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> This series is based on gc/branch-recurse-submodules.
>
> Since gc/branch-recurse-submodules is queued for next, I was hoping to
> get some feedback on a followup feature - teaching "git checkout
> --recurse-submodules" to checkout the branches created by "git branch
> --recurse-submodules".

Gah, I meant to send this with the RFC tag.
