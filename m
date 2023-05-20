Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DC2C77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 10:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjETKWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 06:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjETKWd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 06:22:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE86189
        for <git@vger.kernel.org>; Sat, 20 May 2023 03:22:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so770316b3a.3
        for <git@vger.kernel.org>; Sat, 20 May 2023 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684578152; x=1687170152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0ZeXQajPcFA7iYYPJBZEFxqtHHYefPTpDNA+2CnWhY=;
        b=qDik6nkm/kKB2AANXvaZOZOdJF0HtYxgGNzVAkN8kZARg80Sbf/9BTAa0LUUR890ht
         4F/9E6w6n6a6NqThhzJ7c4r6vLIsPcWlLKWz1Kbqv6w0CKsi11/T4P9ZdjeyPdPfxAN7
         i+y9QqDQilKCRPiWElEiLANJWYw+aTUHqMnJgo8QG3rZ9Z/SYRNlxLg7vRPIdIntS82p
         jdkrlRHQ6ecdLyaGTzIl/mH44kM/oE6nJlQ5KkP85ZQOvgY/m4/F2pL9hcUgCzHJW41/
         3h0+WVkxMpZRT71wsOEbq0ILbtH3d7cuBLwGhneoN4agbIYf8KMeU4OriwJbSgPvZVNa
         phbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684578152; x=1687170152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0ZeXQajPcFA7iYYPJBZEFxqtHHYefPTpDNA+2CnWhY=;
        b=ZDoUIOC7mQosLCv8JpBowUY7Up1yipPoYqvp4cn/X+u1+1J/rQu2jnytM1RF3bvgTz
         1ZFp0IsukZQBv9eKewk7nO6vDhA2schfIumBtD3N5x0686CKkMtA2dEJXPiZ/1UxheWR
         Vxs+NZaDoW4BpX6gzo2eVHjfC0IOVgRiCALFtnH4NMQT1OnecdWrsoXQwVgVmU8n8fMs
         vYPpE1Sr95OdMCFyu79D4tndQhCnbJpXUSUdbUOWjrqXL31qULVYkun6iXEPPGyHbGuA
         L012wwb+MZ1H5P+9voYMy6hubevx/RFB0lNqVH6mmlpoPcAfZolbxb3OJSn1DFcREsq8
         3M7g==
X-Gm-Message-State: AC+VfDzjUxRVr5GJc7pGGJYYMk+cI3zyPiOZxbLtzZe7IjcACydslVat
        oZ0Nln4zP0sU1dJ1mJTwt+A=
X-Google-Smtp-Source: ACHHUZ700ApUfSPg9/QTHIYjchebWRc1+h/pE2MUbKczLeEwmviQ6GQC1+oXfLM1uqKKWNDLCKRNNA==
X-Received: by 2002:a05:6a21:3945:b0:101:5f22:b46d with SMTP id ac5-20020a056a21394500b001015f22b46dmr4641204pzc.29.1684578151844;
        Sat, 20 May 2023 03:22:31 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.54])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7914d000000b0062e63cdfcb6sm1021903pfi.94.2023.05.20.03.22.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2023 03:22:31 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     code@khaugsbakk.name
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 0/6] notes.c: introduce "--separator" option
Date:   Sat, 20 May 2023 18:22:24 +0800
Message-ID: <20230520102224.53522-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.356.g67a1c1d0
In-Reply-To: <3f86a553-246a-4626-b1bd-bacd8148318a@app.fastmail.com>
References: <3f86a553-246a-4626-b1bd-bacd8148318a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

#On Thu, May 18, 2023, at 14:02, Teng Long wrote:
#> From: Teng Long <dyroneteng@gmail.com>
#>
#> Diff since v9:
#>
#> 1. [4/6] support `--no-separator` which means not to add any paragraph-breaks.
#
#Nice to see. :) I think this will be useful. Specifically:
#
#Johan Herland wrote (2010):[1]
#> BTW, since I started talking about git notes, people on this list have found
#> more and more interesting use cases for them:
#>
#> […]
#>
#> - Help in bug tracking with header-like lines such as:
#>     - Causes-Bug: #12345
#>     - Fixes-Bug: #54321
#>
#> - Store after-the-fact "Acked-By", "Reviewed-By", etc. annotations
#
#This switch is nice for that since you you don’t really want
#blank lines for those kinds of format.
#
#Cheers
#
#[1]: https://lore.kernel.org/git/201001201148.11701.johan@herland.net/

Thanks. It's because of you that this function was incubated and possibly
born.
