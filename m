Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A2C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B70864E30
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBKC7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhBKC7A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 21:59:00 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C37C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:58:20 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id s107so3896985otb.8
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6W7h5dftCWrK3y0dPzza4j1SCO7wA6fl2R+4b7EKz+4=;
        b=AZy3k75QI2Tnu9Oi+bDdsWG4UcV/tleLbdmlJbBQLu3P4oxQyCzlww/ytzCjQB2D3D
         w+w1ga9vlaGHCGwXlDuataouK2jpg80ecWTcy2VmMXFH9rSsx9ihsweMQn84/aC3MKiM
         TsdBmDcdag8AiZ/3Kj/Y9dCYSrNhq79fhuKwgZMguTLaVmey90GDQvAfEdUO6HeAG577
         noHLV2CKCBmQk0fXWj7OlaPH0i9lpNP9qIBeR3pgyPE9EP/JfndizHJW5d37eBkZfL13
         mWuXhQsxTWKO/t2OYBt8Ir35ngn6vIamcZ1rwfrlAgDEMuQ6GAzA7flHlO4APbN+PDBY
         0ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6W7h5dftCWrK3y0dPzza4j1SCO7wA6fl2R+4b7EKz+4=;
        b=B/DC/+OTvf7ZDsz0PhsTGXCEQMo1xXTeqde8t2P8/m69djmkDgCkIx4xoUTSYabcGW
         kzql5au9CSf0Ypv+gVj08WJE1COVlhp4JmaUcm9lTlwT1F9GqSXSkkpQ/6dCz+7ZCozL
         iol5BAD2bzy7nhble09HkoiX0QuwCWM8grqHMv0I/I6SnlJp2T+EFiYa6LjxIJlp1rg2
         euaDii1J7xDmIaX3GyI8hYR8LQ0XiKcZlCzrWuqsgxh9932qZEU0/u3GPmgDaZgquFC4
         n3CRc5TLUA2fOgDyJDXjca5RiUzkGISzf9tsGZ/TgUh/99AnDMf+jCM8O2fU38ocr8Km
         QS0A==
X-Gm-Message-State: AOAM530LSYGcyM4itb5tN4VcRC8xPT9XzfSXk7hypO1uJAeu2FN82RcA
        dPvpeWhTRfBr8hvZvHSZ2Kw=
X-Google-Smtp-Source: ABdhPJxDThRSXzRAChkyOV9SiSuK8ZPhYSsih/qY8X8g+cxsYvH4UH2jbEwmQw8004HSYeSSanBsJg==
X-Received: by 2002:a05:6830:3108:: with SMTP id b8mr4305288ots.174.1613012299655;
        Wed, 10 Feb 2021 18:58:19 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:5030:63f6:1d3e:64d9])
        by smtp.gmail.com with ESMTPSA id a22sm782092otp.53.2021.02.10.18.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 18:58:19 -0800 (PST)
Subject: Re: [PATCH 0/9] midx: implement a multi-pack reverse index
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
References: <cover.1612998106.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f783c173-6a0f-71d0-174c-78e310d2edfd@gmail.com>
Date:   Wed, 10 Feb 2021 21:58:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/21 6:02 PM, Taylor Blau wrote:
> This series describes and implements a reverse index for the multi-pack index,
> based on a "pseudo-pack" which can be uniquely described by the multi-pack
> index.
> 
> The details of the pseudo-pack, and multi-pack reverse index are laid out in
> detail in the sixth patch.
> 
> This is in support of multi-pack reachability bitmaps, which contain objects
> from the multi-pack index. Likewise, an object's bit position in a multi-pack
> reachability bitmap is determined by its position with that multi-pack index's
> pseudo pack.

This has been a lot of work, but I'm impressed with the progress here.

This series is good prep, and my comments are very minor.

Since the need for these multi-pack-index-<hash>.rev files doesn't show
up until the reachability bitmaps can be paired with MIDX files, it
would make sense to hold this series in 'next' until that one also
stabilizes and they merge to 'master' together.

Thanks,
-Stolee
