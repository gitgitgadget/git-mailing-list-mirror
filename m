Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07E4C433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7778420693
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7BOxd1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgH3WSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgH3WSB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 18:18:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C16C061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:18:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g72so4052407qke.8
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8QZRkdEk+SOaiM27jDc+aHmq6JlQI9CWp6vjorP9gOc=;
        b=E7BOxd1wWdhf6JvVOBYDr4Mq5RI+wOUPVdFVLoY5PM9o7vZ1fAko4EyKVnuOvutwpZ
         Hk9UxU0EB+hZCN6UeC3ePEUn6GJgg+MqwPCep1x7+xG2Bky5+ajvPnw5gN5FV/6KNMeZ
         Chu0n/y7Gm3e1GpMXKw4FUyZWLM5F+/KDJoA/wCW5jYK/mnAcFbRHRGsEXaJc/sUZKup
         sU9Q0DG8vy8glFk+AzzWJXqhlIapZvP/TbpP5j/IIq8EDLEbvHZWMvVPUI3Xj7U9x+E4
         x/GbRLiOhkOmUUh5FXVp1jt6hp1U3xJbsfhzRs5MyH4YeCVLpnI5zO1Vtxv8y4BVryE1
         0MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8QZRkdEk+SOaiM27jDc+aHmq6JlQI9CWp6vjorP9gOc=;
        b=kZcBvEYDFLkcyU6+HD0W1x/XXIrsoF7uLKwuWugLbvlGP//fJv7/sVMuSbJSJOT0sp
         y5gnJGpBBEWY7sVqw380zMJcXeBUSqjzt4ah0qjwRRQz1Dn4aYXXrtnfJWY9pJc9lU4t
         /ehliQkbut2CoRrTeVDB98Ij7FZfC2Dk+73AzsXoHDTtpQo7pO/SM/zXy0EVneM0J4Jx
         lYNC5p9XvWW1eyg1lpSdCExFUxnZFWSqv7cPDtB6lr63JKNwkQr3m2ycQ7T1OdzwDxW4
         kyovazxoKTjqtKtCSCg4zuCqsM7qgNhMtcld9PTIn51e7q3bY280k/7fAFf4/rPM0Ctz
         sASA==
X-Gm-Message-State: AOAM530J9x/yxPUxoiBWEtKSOgF316LtoDKbPP81AYXnmpKiLeUfTShW
        z9ZBqlRoQYioHWn59o1+nmQWBInvRIo=
X-Google-Smtp-Source: ABdhPJxoF1yrAaaWdMrg/IbmhG+ztG1S+VJkGHD+QWVXdWnIjXyR/ieHmT+8LoV5Yydq0tR3CzYcYw==
X-Received: by 2002:ae9:e102:: with SMTP id g2mr8072537qkm.134.1598825878576;
        Sun, 30 Aug 2020 15:17:58 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id s20sm2939945qkg.65.2020.08.30.15.17.56
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 15:17:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Makefile: add support for generating JSON compilation database
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
Date:   Sun, 30 Aug 2020 18:17:55 -0400
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC95CFF7-F9DA-4CDA-9923-99C3432DCAD5@gmail.com>
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> #
> +# Define GENERATE_COMPILATION_DATABASE to generate JSON compilation =
database
> +# entries during compilation if your compiler supports it, using the =
`-MJ` flag.
> +# The JSON entries will be placed in the `compile_commands/` =
directory,
> +# and the JSON compilation database can be created afterwards with
> +# `make compile_commands.json`.
> +#

I'm realizing that the way I'm describing how it works here is wrong: =
there is no
separate 'make compile_commands.json' step needed (it was needed in my =
first draft).

I'll fix that for v2.

