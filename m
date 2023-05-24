Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC01C77B7A
	for <git@archiver.kernel.org>; Wed, 24 May 2023 20:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjEXUgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXUgu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 16:36:50 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB610B
        for <git@vger.kernel.org>; Wed, 24 May 2023 13:36:48 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-561deaad117so19800907b3.0
        for <git@vger.kernel.org>; Wed, 24 May 2023 13:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684960607; x=1687552607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZwcG7nn4GYM8bXsMVVev1IvB2KQN163mHyuBppg3RQQ=;
        b=OYjybc3cNVslVpD/qXTq7AtSlwp5/unrU3ulQpxt2jUZIPBr0LowvmG8KnR37Wa7I4
         s7hSUkmyS+7Km3yqJCV3ds4UCGyTTl8kX/DkQmLAJqV7/eTSxDfbb9fl/Gcd3Jm0KiVU
         pwugDeTnle9z3dq7WfcoijuQpjOR554j/R8/QVLed4l8Re2Ux395ZpNhqD50hwdQ3CRv
         ZsjWQfwwxf9Zqe31HQKHN42xQvyHxpDefMbZclKaiUYK9v4mWGPN3oyds8VKVmSf5dre
         0XxOrrvrmq+jCUkjm1UDmvYw1TXD4bG5nvMHTZwdJWfBMznB0BFzfLiJasxN2kFAZf/n
         v0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684960607; x=1687552607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwcG7nn4GYM8bXsMVVev1IvB2KQN163mHyuBppg3RQQ=;
        b=hSMKQrMMkLIfRZQ4jrk9aE+4DXWwaNiQNtGQzQvyBXBqDBWRcXcxhte+oPSIbwWC58
         GzPA3R6YU5gPEBgxO8lhvO8gRAVrnaA+9/kf/AQYrQCcAToLZHqPjgTdxuIaKOTe4MFA
         7jxAUNLvzLF9A512g7Cs5uPQIZ8x2H1HLxo6fV+U53a+sKQya4Vr5DwWRWWHNSDfuiNI
         3+ERMt6vF7fhDW7ZcIwIHFIiL8tkjtyapLHcvCAp2xnBvRiEOQADUjvDkfmQoU3CuEp4
         ZEpNpTqHm4iZ4uy0HyR480yCWFgQIM0T47FUBsAbM//wY1ZiL0NeobgsOclCdoldyUtR
         8czQ==
X-Gm-Message-State: AC+VfDy2ulFuFgAHEkp3gInp9Mj8bFrV7tRZSog+sOD2et4h4Ks0EkML
        KuIYr220gbPZIei/z09GrkFGwg==
X-Google-Smtp-Source: ACHHUZ7sKJVAs9YCyW4ZhpZeqAZ1n1rCv8jq5pYtJSHm5ql4qSGtEycKd2ZG3813TesH6y+dPpTFyA==
X-Received: by 2002:a81:6903:0:b0:539:1b13:3d64 with SMTP id e3-20020a816903000000b005391b133d64mr19920836ywc.48.1684960607195;
        Wed, 24 May 2023 13:36:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z62-20020a816541000000b0055a7c2375dfsm3929365ywb.101.2023.05.24.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 13:36:46 -0700 (PDT)
Date:   Wed, 24 May 2023 16:36:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tribo Dar <3bodar@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] builtin/submodule--helper.c: handle missing submodule
 URLs
Message-ID: <ZG51XsEq4JB9IK33@nand.local>
References: <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
 <ae6cf3fa461b85e346f034371dae56a2790dfa20.1684957882.git.me@ttaylorr.com>
 <c8d32d5a-9803-9eb7-baaa-49b4521f0c37@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8d32d5a-9803-9eb7-baaa-49b4521f0c37@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2023 at 10:29:39PM +0200, René Scharfe wrote:
> Am 24.05.23 um 21:51 schrieb Taylor Blau:
>
> > By adding a NULL-ness check on `sub->url`, we'll fall into the 'else'
> > branch, setting `url` to `sub->url` (which is NULL). Before attempting
> > to invoke `git submodule--helper clone`, check whether `url` is NULL,
> > and die() if it is.
>
> Why die() here instead of just warn and skip as well?

That's a good point. When I read prepare_to_clone_next_submodule(), I
thought that it was already too late to skip that submodule. But my
understanding was incorrect, we could easily issue a warning() and
return '0', which would indicate to skip it.

But I concur with Junio earlier in the thread that we don't have to rush
things to get this into -rc2 or even 2.41, since this bug has been with
us since v2.20.0.

Thanks,
Taylor
