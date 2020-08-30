Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4402C433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 05:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A673F20720
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 05:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgH3FfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 01:35:19 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46708 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgH3FfS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 01:35:18 -0400
Received: by mail-ej1-f65.google.com with SMTP id d11so4215530ejt.13
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 22:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnpHl6TYbF4LHAs5c4Vo8iZVD3kG2N8CZhe02Azx7pQ=;
        b=jMjBHhvMhqjwX0fhlzNtU0Ukog6WgQIU+yxzXLniZZKuFwC4RN7U0FB0l/3Q905OM5
         3v87w0wnivfbwT9Qa9nuTENKL+LEOe0FUftgF8/0EeYmRv/v8VlME+vi4iPtR5qYBpvt
         zkaPWmJSnRCq3pGiypqGGeok1XhWoKCiRCSm2jKwN6QJdScTAJvJDvhz+VHxcc+bN6uc
         RQmJLMeej/WLzBSehPqT2NnlM9f4kAsyIOIi2DDaobyzcpPQn2KYhAhl7ASc7ZAWf7X+
         /Yt7t91YdyQDRGaL2lxxKWSA5HOSPJ73RuCtE/c2lSOmane/La5+gf29HGcHWRcMJdvQ
         w4IQ==
X-Gm-Message-State: AOAM532old0VrML+DD4sV3929Ypt2ib9ELLIZyPALmNJGh/bKOIUan1P
        FOGtxAQ+1Dd0/U9BohfIuRsRM/8FdGwXItY4eeQ=
X-Google-Smtp-Source: ABdhPJxG9k8zytbsxP8rCdFU4zR6vRbJnkgH0T7DUmZIcZ8Y+nIo43i5v3q6Mz8cgSjw76wWeol/O67vn6FjWKE7vAU=
X-Received: by 2002:a17:906:4f11:: with SMTP id t17mr6663942eju.371.1598765716683;
 Sat, 29 Aug 2020 22:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200829225648.11971-1-alipman88@gmail.com>
In-Reply-To: <20200829225648.11971-1-alipman88@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Aug 2020 01:35:05 -0400
Message-ID: <CAPig+cQeYz9Mh+26YshuCQSzXCCUyKNGGr1wJ3FNNLpf=9QRuw@mail.gmail.com>
Subject: Re: [PATCH] t3200: clean side effect of git checkout --orphan
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 29, 2020 at 6:57 PM Aaron Lipman <alipman88@gmail.com> wrote:
> The "refuse --edit-description on unborn branch for now" test in t3200
> switches to an orphan branch, causing subsequent git commands
> referencing HEAD to fail. Avoid this side-effect by switching back to
> master after that test finishes.
>
> This has gone undetected, as the next effected test expects failure -
> but it currently fails for the wrong reason.

s/effected/affected

In fact, the three tests following the orphan test all expect failure
(though I didn't check if they also fail for the wrong reason), and
the following test which doesn't expect failure has an explicit "git
checkout master" early on, which explains why it was not impacted by
this problem.

> Verbose output of the next test referencing HEAD,
> "--merged is incompatible with --no-merged":
>
>   fatal: malformed object name HEAD
>
> Which this commit corrects to:
>
>   error: option `no-merged' is incompatible with --merged
>
> Signed-off-by: Aaron Lipman <alipman88@gmail.com>

Description and actual fix make perfect sense.
