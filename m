Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F61DC61DA4
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 20:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCKUhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 15:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCKUhg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 15:37:36 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6C437B59
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 12:37:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i3so9038207plg.6
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678567055;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaXaFYz2UCZ1QDTY2sk/SonM+sEV31zDlj5lgQe4r8g=;
        b=AE6eQZVffH84PoJVsV24HF/hJ4CGVuG3f13lfDMEQodW0AQQf5TA7X9Z9hc3qwqtOs
         9fDpMquW3FyAO9ZoEgwnPn3QkIxReSdJucQoW/xdAOMu0OSqJ0AZ8swCZ8TE8ZdwCG5x
         dx+HBgNIyzwkcRMxQMFp5SLGMwY4d1Pmo6/LrvzU4onLwGYlHqfi8iZD7qp7IO97KX7l
         0mZz1CdDr9+41dc51t3II7spBhCp1VUZrvE09W0sOMMe1NUKKQUxsKQY/ehjXgVP3DPC
         JtS2Q0lTvlLhnhlIpeGsGSseaaU2PaKcacMLQoxy28nihNvyYybGYB5riNNXlokSTcgo
         RuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678567055;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DaXaFYz2UCZ1QDTY2sk/SonM+sEV31zDlj5lgQe4r8g=;
        b=0XccX1wODhI24G5kyW0lMpTCCraXVZxjfujstVlsrj4iXLu993XvQpnkEjtL2tH+ds
         nlVo2CcTP8OnNq3ZPPid+FQb2aijzABRLMSa1WUQoDEnD8P4qCXqbpkp6xcUvsvzjkHg
         LY4CyedllOEdyf8mvgxPfTpcf/ituDWO3vKR1eE3XVTgOfEdytpMqrvaR0jcrvB1LER+
         /CphRvMqiurQQwLQTwPaRQB5K/Ld044PUKtoHnrG0tQ/8JP21JbCPhgVOCVFJR5FwZo9
         8TThzxRrkWKxMqmRUznP6wEDxcGZLyj+E+G40eyGTPs2FTGAq2QnIc5qK12nDScFJlkd
         /Oxg==
X-Gm-Message-State: AO0yUKXA3s0Qvi1eoPkGQYt6y7MQPiAns5MA/n7M/Mv1MtDExdbOjqPE
        w5r7j3nbJoTRQ02ZPc7rbWQ=
X-Google-Smtp-Source: AK7set+ALVyHbMgbAmQwU1i6UxHD3BfMHBbM+kDiQU+D8hV0pLlRifcVVHWr8WdV3AreftmCTw4Uxw==
X-Received: by 2002:a17:902:f693:b0:19d:5fd:11fb with SMTP id l19-20020a170902f69300b0019d05fd11fbmr35235095plg.23.1678567054974;
        Sat, 11 Mar 2023 12:37:34 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902968a00b0019edb3c4941sm1914459plp.131.2023.03.11.12.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 12:37:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] index-pack: remove fetch_if_missing=0
References: <20230225052439.27096-1-five231003@gmail.com>
        <m0mt4j5a2n.fsf@epic96565.epic.com>
Date:   Sat, 11 Mar 2023 12:37:34 -0800
In-Reply-To: <m0mt4j5a2n.fsf@epic96565.epic.com> (Sean Allred's message of
        "Sat, 11 Mar 2023 14:01:28 -0600")
Message-ID: <xmqqttyrxbw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean Allred <allred.sean@gmail.com> writes:

> Kousik Sanagavarapu <five231003@gmail.com> writes:
>
>> Hence, use has_object() to check for the existence of an object, which
>> has the default behavior of not lazy-fetching in a partial clone.
>
> Any chance this fixes behavior[1] I was seeing ...

If I understand correctly, Kousik's change is meant to be a clean-up
that does not change any behaviour, so if it changes some behaviour
for you, it means the patch is buggy.

But I think you can build a version of Git without the patch
(earlier this week would have been a good time to do so to test the
release candidate #2 for the upcoming 2.40) to see if you have the
behaviour still, and then apply this patch to see if it fixes it,
and then report your findings here.  It would make a great
contribution to the community.

Thanks.
