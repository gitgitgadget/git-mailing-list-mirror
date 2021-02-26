Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF087C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844AC64E4D
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 15:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBZPoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 10:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBZPod (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 10:44:33 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C0C061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 07:43:52 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d11so6194939qtx.9
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 07:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DNSbdw+BxrzsXKWm/DmQv0am+u0wNV4PcUEv0vxpZqI=;
        b=sBOJnvAPPtm/9WIuOeFAehLdMre202fhlVUsmpk1Apd5GYj0rQgGfAQloLr/fI73cV
         trUCUzVDTabvjM8didtvD7GB3wlQrZhBz4pMc9IjGGbClnwNIGrmFl+PE0+82t2pEMAz
         Ke2qeuClkNJo9o9X1CN5+Fdw84r3BiC+DCEJQQDsLrzgMUsGCgnBOtrLepmbiPDnk8V2
         RWUc6yqWcyKQ7Hj3PoE4eZTLxeOChM2182Z5FpJ8SEtCSwTUVrQd4MQz8q12Dciftb6N
         O21uOfR4do1SSDGcJ091RJb2UykyMIDYQCyosEcfgh8jLEFkfBWNgSieS71SINbSE1vT
         p1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DNSbdw+BxrzsXKWm/DmQv0am+u0wNV4PcUEv0vxpZqI=;
        b=IK8+0Usym1dNoFM1rYjd5cPcnVlqVHVuTQRyE66G3sjFpWLg+saDjaSHUQJzxsqPZ1
         BwOCnqSMsQPvnavISlAEXzk2X4pLSRZVXF04F3POkOM5akMFMqxhJsmY87fspIrqmBH0
         wucv3o6Od/7XmqsZtEDrv2hRXwYot4faEf1fP3IEac38qr1upxqbrjxNCkvwOjNN7F07
         Z4fMOzEFg+6emxR/WKU0HkU3JJVSiErzQtcLUkyl0Ep7sQX5ab9SmQhpFY/HjRtc0adA
         CXB7c62cQtsK8ZrhS73DEsurbEDm9oizwRzLMAmp0sh6Cox645cMlQ0hrT3NwYZSk1gd
         0zXg==
X-Gm-Message-State: AOAM533ogTTJGiIE9J3ggsGAl66+25Dj0rQrT5CNEUaJfOsg7/GdKIla
        0dyUKSQQjHu0pDBsW1GnPAo=
X-Google-Smtp-Source: ABdhPJxcbz91GMlymchaVIZ82CNY/B+A9Oao5alQuYed1UJrDClM97yiIosKCRy/T1KEHQU6Z8/XGQ==
X-Received: by 2002:ac8:120b:: with SMTP id x11mr3176683qti.120.1614354230937;
        Fri, 26 Feb 2021 07:43:50 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8d21:2da6:2067:31cb? ([2600:1700:e72:80a0:8d21:2da6:2067:31cb])
        by smtp.gmail.com with UTF8SMTPSA id s19sm812185qks.130.2021.02.26.07.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 07:43:50 -0800 (PST)
Message-ID: <d6edd2e2-a1ae-bdef-7e6e-7c1984903a49@gmail.com>
Date:   Fri, 26 Feb 2021 10:43:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2] t/perf worktree improvements
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net>
 <YDiesofYW18Mzd9Q@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YDiesofYW18Mzd9Q@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/26/2021 2:09 AM, Jeff King wrote:
> I don't think v1 of this patch got picked up at all, so here it is
> again. There was a question of whether we could do the much simpler
> solution discussed in:
> 
>   https://lore.kernel.org/git/22378ce3-6845-1cd9-996a-8bdc3a8b65d7@gmail.com/
> 
> But I think it would be confusing. So patch 1 is unchanged here from v1.
> 
> Johannes suggested we could add some extra protections to avoid
> accidentally modifying the original repo. Patch 2 does that.

Thanks. LGTM.

-Stolee

