Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE6EB64DB
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 06:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjFQGfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 02:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjFQGfO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 02:35:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398F1724
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:35:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f8c5d0b19dso13694195e9.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686983712; x=1689575712;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fMuTLDQhoJwV+6g6JCpuSRhTaEI6V+8WW+ocH+E6dY=;
        b=VmKLE4BjuwWarE+3aTjr2bcVDpw4je4jhHe/TU9RjtTXwxRa7UiJo1r6Vxh7kkpQ7l
         FXXoIrB3MyjtIgu6S6QnRNTXRFn7+0J+21LIwjY+Vd+Dy1Ee5MuqLhCYWs5os2L3jaEQ
         qJ+BLtb36fLA02DOiI0F4IJkuqJEkelMjG6ZYKoCfV3sku/PK/bsQOI1L2XRQldr000K
         DWBRNyIeUvHOZLiwn8MxOrb7Q5rIAA1uvyxtyMaDuTHjqTkzkUhfdXu9yh5+5fnzyiLA
         olxVIjP3sO+x7zhXiT9Ejt+qfsTqMjlpLqNAyAcW2e5IgcRpMDxE9Lb0AjbZyKVRaSm6
         78Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686983712; x=1689575712;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fMuTLDQhoJwV+6g6JCpuSRhTaEI6V+8WW+ocH+E6dY=;
        b=FCHUO8WNUyDMzmIWFEhBeV5EQeVCkoUZNgexFO8D4SPA4+c3grFNU7jGmViIoFebsC
         aOZ6Mg53/un9/bEiGCR6FiXoY9MQTWgiS+sRhHcP+j5YIxt7lbbNj0+SF2kUvHlKe1Sl
         yM9+BZxCGv2RCDikIqDYFH19J0NZa/wFJGtjWeG0C/rlTHo+ai7/FwlrmHzgKYl2RlY3
         zSE4nvY7q2U1iuZ4zmAUOd0yOHY7Fm9ThiZSkuwsBxN1x+EV4t+WlEiVLRqP7sOoL8hM
         iXrVF8U0Pd33dhwvkLozOeQ5FsL0ewN8xosZ3uoEuV1G8alVPZBxfyUVA66aoxm3Oduf
         WymQ==
X-Gm-Message-State: AC+VfDwk4K8oJzXRoArlXO/rSZo8Xa1ao+fiW/QaKlabiYgbAIv8RmF+
        XV+mz2rtB7nxAd53KYdZcmI=
X-Google-Smtp-Source: ACHHUZ4mX6wy52I1ilWPhL4gock6q4w5AOk+HreycMkJ8PfUNSBmuOzX46584OABSG660380d6PrRQ==
X-Received: by 2002:a05:600c:cb:b0:3f7:4961:52b6 with SMTP id u11-20020a05600c00cb00b003f7496152b6mr3627266wmm.25.1686983712287;
        Fri, 16 Jun 2023 23:35:12 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id s1-20020adfea81000000b003111a9a8dbfsm4948283wrm.44.2023.06.16.23.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 23:35:11 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] tests: mark as passing with SANITIZE=leak
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
 <20230617054823.GG562686@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <5b7cd886-5747-b6df-dcfb-1cc8624d982d@gmail.com>
Date:   Sat, 17 Jun 2023 08:35:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230617054823.GG562686@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/6/23 7:48, Jeff King wrote:
> These all look good to me. I'd probably have split the config.c refactor
> into its own commit

That's a good point.  I'll send the refactor when the dust settles,
along with a revision for the UNLEAK().

Thank you!
