Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD7EC77B7A
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbjFCBfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjFCBfl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:35:41 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF219B
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:35:38 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39a55e5cfc0so2414876b6e.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685756138; x=1688348138;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHK9n/2fYZceA6Nu0lwCTWAYzDOdkdtVigGbNHl3Uvw=;
        b=N3mk5YGuSFeUzKy5F4TAMDrgKGL5KR3Z+EVvtfCEE7IR2ky4VEXDR7UVfXNuKjOq9m
         FzODpQArH0EGRZKbEXtm59lxpoWvIbcZCqbEnIMpW7Qafsbu6zbcTGxBqQ3HU3CuT+Qi
         qjTlCn4cT471HuwyE3SujzZlovJbFtYVX1qupfElJmSYCa/S+U/Bd5tsAmsjxeStcUUL
         iHAMXnA/wiksGflDN2QhqYL/tbh4791R9P0Fa+QQ8pHPvTLYQy6nD+hYLkzB7pI2cZzq
         QRvFOlhj8SL6lXzpmlLV+hQRkX1kMHrY1fmOms5+GwsKy8h/LhQKGkFt3fpzJvWv8ZhB
         lQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685756138; x=1688348138;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RHK9n/2fYZceA6Nu0lwCTWAYzDOdkdtVigGbNHl3Uvw=;
        b=lmiq3FZIPwSIBAksV3rIq+wbxpV7TfFs4YD7/r2AWRHusBxZoK1WLvTWQF/nPPNp0z
         S6a6cny9ZiwEyWFg39Ec2zXpyoSdGSqQhiBx0K25BD05gkYnGVmbMmd1DYKumIonMuuL
         t42FdiC4fEUzi4nXJbg9Frn2aLiOrBwwmrw/eCac3IGwwqaX5tifjQ4Y3nd3GG0q5dWE
         Z8IWKsITqgZ6mNeFt5D+7sN3OR3l/iRQIGqMZgrbflgIyJg6jv/HKD2rP1Mwwskc4RNp
         L+Gkdp4WHzpDGRFk5kqiP+BnGvJlXk1ETURxWi9lSQb2eA55l3DsdsFkuWU9757zEBwW
         t+kQ==
X-Gm-Message-State: AC+VfDyWkpkBmjpCakZJBTTpIoaNF7FRj558KJo3xvVno8ddGvYMJlHG
        BtCGbI3qWx4rhPhsoZfxHDA=
X-Google-Smtp-Source: ACHHUZ5BdeVYWtwBLvKnGE0+vGR1Wmb4QUHmRFaRPZHfR9saJYB5iTmQhWkjTIGnGDQRsYu3wW1urg==
X-Received: by 2002:a05:6808:3b0:b0:398:5a28:d80f with SMTP id n16-20020a05680803b000b003985a28d80fmr1803751oie.4.1685756137934;
        Fri, 02 Jun 2023 18:35:37 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001a060007fcbsm1970167plk.213.2023.06.02.18.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 18:35:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 0/3] ci sanitizer cleanups and performance improvements
References: <20230601180220.GA4167745@coredump.intra.peff.net>
Date:   Sat, 03 Jun 2023 10:35:37 +0900
In-Reply-To: <20230601180220.GA4167745@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 1 Jun 2023 14:02:20 -0400")
Message-ID: <xmqq1qit8h06.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here are a few patches to tweak our CI sanitizer setup. The first one
> hopefully increases coverage. The other two just aim to reduce the
> amount of CPU we use.
>
>   [1/3]: ci: use clang for ASan/UBSan checks
>   [2/3]: ci: run ASan/UBSan in a single job
>   [3/3]: ci: drop linux-clang job
>
>  .github/workflows/main.yml | 10 ++--------
>  ci/lib.sh                  |  7 ++-----
>  2 files changed, 4 insertions(+), 13 deletions(-)

Makes sense.  Will queue.  Thanks.
