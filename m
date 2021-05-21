Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0244C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A36F613D9
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhEUWse (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhEUWsd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:48:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01608C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:47:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y14so20363641wrm.13
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=esyBjyi13QStuPIX1dP9fbbwN1uBKYKzgu3J/BsyEgI=;
        b=YqXmHixPcWzjvUitGWvDBftLsbN8DUPrjNN1KG5sdQvOK33MWC+63/maWGlZcq9KSj
         8E4B4Xq+ugOgQ46LP4AUDtN0F9u4U0u05j4UWfs65Li3Cp4/VuRJJ5ZVpB2XcpMwMwj1
         ZZZm6TacFu0L1yBe3kIPH/gL0/+Kz5UN3ejWFTmd7SQlYrgN+1ImRNjc53YOtXsYsgas
         i/1fUaIu8XzRh/d5ZCJc0cfpI1plb832ZhjqIf9wG1IMxDuzAuVO70dMpPqZgXfyX+rl
         zb9NAfeK04nb3j1JPaI/Cyv+2/ACZv6lgLkGE0r9Eq+dzTgSekNuw3NBFbNvDh+/Mack
         3qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=esyBjyi13QStuPIX1dP9fbbwN1uBKYKzgu3J/BsyEgI=;
        b=j683E9iOouImtMKbVm/CIhWOlDJDgBOAGyTabnSKldgaktOiTEaftYayXia62vQpeA
         InOC3MsbavIOXoua40iAx1R9Wl9IyDrYlq2Y/k1qaaNTtgISltm1C8xtUT9SlsJ7zIdK
         2vmPLLOSP8Y/QF/c0Fsm8YjA5cr3R9Me6p/I7VpUL68+JDvRmo8de93brmYVgdDfvIB8
         bKW6ni8DqGBTYr9EV+CMj9DpgdRuVav7Yr8EZ9gblvnGPk9lj4//3NxyDlSxGyS98rg0
         sXzgzoQ5X62Zg9bK3P2QAJh0fJnwCgI74O9kxRl3Ps8vI1G1e2yIK9EsdUL6rDioslZ/
         ub9w==
X-Gm-Message-State: AOAM533QzdAgq4K2Ns+zakcH5QOiMc8BsugoJwkJLGQjsOthOWfUK0o6
        2jTKbpTI5runGVxtkq8FioA=
X-Google-Smtp-Source: ABdhPJzpI/31xfyAywCM1bPWLP56qkWkRxWQMA97wFakBWTy0BR7KxAlIqN4IK7vLNzFywOnLcLkwA==
X-Received: by 2002:adf:e608:: with SMTP id p8mr11842733wrm.162.1621637228670;
        Fri, 21 May 2021 15:47:08 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.165.96])
        by smtp.gmail.com with ESMTPSA id d8sm820603wmb.40.2021.05.21.15.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 15:47:08 -0700 (PDT)
Subject: Re: [PATCH] help: colorize man pages
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net> <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net> <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
 <60a7f7427eab6_55039208ba@natae.notmuch>
 <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
Message-ID: <d18b09f5-6a6f-6fdb-bdd2-e63156c7ce9d@gmail.com>
Date:   Sat, 22 May 2021 00:47:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/05/2021 21:48, Igor Djordjevic wrote:
> 
> So, the whole point is make the default value be "no color" for each 
> and every application consistently, where user (and _not_ developer) 
> needs to opt-in in order to enable colors (in each and every 
> application where colors are in fact still desired).

Oh, and might be what NO_COLOR homepage provides as a tip for 
"disabling color in software not supporting NO_COLOR" for Git 
specifically might be a good (and enough of a) clue by itself...?

  git config --global color.ui false

So I'd argue that Git should react to NO_COLOR exactly as it should 
react to `color.ui` set to false - disabling all color.

Do note it's only by default, in case no (other) color configuration is 
specified - any existing user config should take precedence, of course, 
further acting as per user's desire ("... NO_COLOR says I prefer no 
color in general, but I do want color in this specific case, enabled by 
setting this software specific config option explicitly...").
