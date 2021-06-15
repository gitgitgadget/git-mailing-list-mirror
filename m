Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF9C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E982D61439
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhFOLXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhFOLXR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:23:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F4C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:21:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g22so6076498pgk.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q6hwaotPVlqXC5IiYqDa86fuUPcp/8D1XppsW6AMCvw=;
        b=rrvEB+YPbNoDCKEIbDpboIlvQuJ5b8yOn1/JP8t2ID/5RkFzXn+TAjO7Y8qJBOENMq
         6SsiHig7OnPSJ2EOqGV+/6R168DjBgsAD+5xhQl3pE0IELFypKPGzNywLYJG2ARIhx3X
         c7HeDtTG/lv/F683k3h0bcBi6llI6nl+JFeYs01WWZQoGLRC/ZfUCZM4KymfDvWSEXN6
         Ov8TcAp/n5Q/4L+VxInLh/u8EOwxFLDsqvDvLi1CZrys+EdZ0Z2LIE+9NFx97EZsUvTQ
         5uyD3gSPTsa3do2ETNzR8FEdyXeiOYOl/tal2jJRYoVHzi2hswl0eHX/CXoqBg+q3t5O
         zpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q6hwaotPVlqXC5IiYqDa86fuUPcp/8D1XppsW6AMCvw=;
        b=iUMBa60Q0Tydu22IsJ2JyyshnMC0s84vMo02u2R583LMihKbmk7sWec095dNS9OdhD
         pbszdTNZf/2mAJ6d8Lx3BcW0Ig3gmu8fiocgu6/DIcyM26j8pQFklQho9EhJNODqHuZt
         /v+l6uQCZwtNPuVGhKXma/sp8QUHumpKlyrMKB+6pRZkrWsu8Gj1+jVMnnlLxDkubffC
         PhnNBJlBatM5pK5qfv/vp2RzIFy8lzwkUHPFW3HT69WNx/4nxPURvDTWcf7B71XA9ZsN
         2mxbzYpf9mXlH/GG15YDp9KZ08KQezwX66T1LT7Y+z7IHZM53yRzHDxkw6AMW7wnUOwc
         VycA==
X-Gm-Message-State: AOAM530myHVLF9ZVM1Rsyy5IoxO2NJs+D2CccsPQCb9UuGjX/o8h3rHh
        LYOoAWMkkSRRnCmiL8sHcI4=
X-Google-Smtp-Source: ABdhPJxf0KWBpGqeq8mmLnCFtuoTlUD0Sg9T9P18SJmWGuEW45NA1tAXSfaSKwM428d8vVLn4BLGJA==
X-Received: by 2002:a05:6a00:1893:b029:2f6:456a:aeef with SMTP id x19-20020a056a001893b02902f6456aaeefmr3949447pfh.43.1623756071245;
        Tue, 15 Jun 2021 04:21:11 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id b195sm16497478pga.47.2021.06.15.04.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 04:21:10 -0700 (PDT)
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
 <60c627cac29b3_41f45208a7@natae.notmuch>
 <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
 <60c715dd9939e_436208f3@natae.notmuch> <8735tk22if.fsf@evledraar.gmail.com>
 <YMdm5XayUfp4/atY@coredump.intra.peff.net>
 <87r1h4z8k0.fsf@evledraar.gmail.com>
 <YMiKlmY3B/1cDrr8@coredump.intra.peff.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3caba1f7-026d-827e-d97a-8b5708dd9765@gmail.com>
Date:   Tue, 15 Jun 2021 18:21:00 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMiKlmY3B/1cDrr8@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On 15/06/21 18.10, Jeff King wrote:
> I think it's just that the aggregation script was never meant to signal
> to "make". In a regular "make test" (not using prove), each individual
> test script is a dependency than can fail on its own. That means a
> failure of any of them will signal "make" to fail the overall operation.
> 
Only one failure can trigger FTBFS when make test, right?

-- 
An old man doll... just what I always wanted! - Clara
