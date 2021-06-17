Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9034C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9433D610A1
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhFQOoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhFQOoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:44:24 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE6FC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:42:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so6383155ott.1
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=wBBcnP12uhzFJXtU1doMSKhkHXHJ5hz8LbIZhsppq7w=;
        b=C9S8Q3kki1+O3ghobGQE8YCAjWIx5nd/P+9n5wypu6LRQaRljaPUHU9IJOAiUeXEtM
         2Vmr/nJp7exhQ+dhtQvI6KcwokbzbnClLLnVs46CdHcMJel87WgCeX5cH5TpLOnbq/G/
         bWjfFdv9OKp5z77QnbQLpZJcP7V2fUbyDI0STTzLmJd7ZryEITvBAcK9WCgingzudib8
         eKA7iy4S8gzvpJIrxZ7AVh+rlARmCEa2mOtqPxqc/K8v7C6tY9oeEUDsn0cdLYiZNTC4
         NFHOvuziBy44bRv0GNKfuMTMBq0Ku1vPZwVBh7W2a/x763AGkKwSVRByy6cDbRUaBQQw
         fO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=wBBcnP12uhzFJXtU1doMSKhkHXHJ5hz8LbIZhsppq7w=;
        b=qSyGWFLNk2IHt2Cs9qBPTpoyY8VMSOK6iELCAfkhMslB8IoMKszf27jhQbIDfeBLNX
         j42zMXF9zQnMdxl6160lMeJELDJv52aZB/FLio6NJJgrpEnaRCFgXbcmXzEIP2MJ2V/p
         ySCXQdlVvzxPP1Pgzuh7aQF15BK4NDWyc71HwWr2Z2G7tUDwaHFZeIp64yUH6EjoF9Ns
         Fo1BT2REyN980BQmcPngfJIc5CVxGEq34Dh9Pv5vTbRjp8gIaa5Bl0PI5tGOOfE3VHp/
         Wef0CJzYPxqmktvBHdbSMTljyciyOAf+zo2nTjR3QIr4OVVl1tYTu8mxfnY3ijUTuRIE
         kbNA==
X-Gm-Message-State: AOAM532tNIxJiYYmK7HIdhkj9t/si/EuB0ZoDbgo21qaZ7eLN59Jyfgz
        GvNq/3NpeDXi8ZiMmqkEh9U=
X-Google-Smtp-Source: ABdhPJwNKfgJsrsBfZiQP+EmEjTXcFCt2TGyPDWKOgMOCSLDYOR09Kslshal+NCZbBirPeqg02eJ4A==
X-Received: by 2002:a9d:4105:: with SMTP id o5mr4783205ote.20.1623940935704;
        Thu, 17 Jun 2021 07:42:15 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 2sm1278863ota.58.2021.06.17.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:42:15 -0700 (PDT)
Date:   Thu, 17 Jun 2021 09:42:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60cb5f4632d62_127fb208bb@natae.notmuch>
In-Reply-To: <xmqqr1h1mc81.fsf@gitster.g>
References: <xmqqr1h1mc81.fsf@gitster.g>
Subject: RE: What's cooking in git.git (Jun 2021, #06; Thu, 17)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * fc/completion-updates (2021-06-07) 4 commits
>  - completion: bash: add correct suffix in variables
>  - completion: bash: fix for multiple dash commands
>  - completion: bash: fix for suboptions with value
>  - completion: bash: fix prefix detection in branch.*
> 
>  Command line completion updates.
> 
>  Expecting a reroll.
>  cf. <60be6f7fa4435_db80d208f2@natae.notmuch>

As I already stated in my previous reply [1] to your what's cooking of
June 10, I already rerolled these:

https://lore.kernel.org/git/20210608060010.1676208-1-felipe.contreras@gmail.com/

I've sent a v4 [2] identical to v3 so they don't get lost again.

[1] https://lore.kernel.org/git/60c22863185f4_b25b1208e2@natae.notmuch/
[2] https://lore.kernel.org/git/20210617143527.77329-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
