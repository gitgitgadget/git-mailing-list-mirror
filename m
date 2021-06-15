Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78306C49EA4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6092561468
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhFONab (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhFONaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 09:30:25 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC85C0617AF
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:28:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t9so11176692qtw.7
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G7HcbRS7gtYhuKE3hOfGgCcqM/r8zzomtKRmuw/bU8M=;
        b=OPiaZ8VPMr0RF6mtd8vgUGyvOAkaUoHdhMpgyzbG702fUO8yWdHs+bUu/K52NysGvB
         TrAYyJp+HPdHJgYwHSdDk8Btdvxcl364bt3afN3dB9oUTnyfu+R5QgSRQyDnJ4WJ0z+k
         I65XsqlbTJMmfv3tOaLRWodB9sTrz6lVxcpYxrxKGmakbOgvjkAloXolgDhZ8YDmVuJ8
         IkKJM7Tuc5jdeYSJ0+JK2ITimB8+qpcvP2x2NjjmHT6OOkwi5+4Z3kSg64K5oXDpc8u1
         pHWstGzja0CNly/rxFPABPcIbqO16YXqpg/l66RQge6YSjWGVtLozWqldFhGTZ0d4deJ
         hKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G7HcbRS7gtYhuKE3hOfGgCcqM/r8zzomtKRmuw/bU8M=;
        b=WDvKptkX5HbwMcVK6bHJRvzuANXEmGsUM+C7OfobAlnfpwz2SxBKLbXB2Lnbyl1sFg
         zCQDWONeXUTbSPYkgxBRDs3D8D7iYivjj0esS9Rnm1PXmX/zkD2DH7lyXdDY9korRxES
         9LDT0tqswGx5+XmBkqBJdqWjlkEoIkKpr76byQnDoihgtmBYLuMgXdFZF9z9RRe1q7LQ
         dhlFp3Xg8gBZJq1xBI8IS2O62+ceSDjaYvbETm75ow7RD1ENQGih1VEE6KcFgntOqHt2
         yNou1duWGDQQhRjKPhK7IFhjAWL+Xg3codXVvozkV6mWdkX5zhQxMHHQo0NqTEb0dBpr
         uhPA==
X-Gm-Message-State: AOAM532d5u1CMTw4aRQdbuGSdUMQU0g3YVJAc06sWUAQ5hxOyReRwh6a
        9YUrRbv//DIhMXmuJXGLAMI=
X-Google-Smtp-Source: ABdhPJyOC5zsJ+ghH/wbVhaOdrX29hApWzSwzTLAAaDCJ9oUF76PRDDufcw2wg4y0HqAt0dSqceDow==
X-Received: by 2002:aed:2064:: with SMTP id 91mr12105722qta.318.1623763699619;
        Tue, 15 Jun 2021 06:28:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:113f:4437:94ed:3bef? ([2600:1700:e72:80a0:113f:4437:94ed:3bef])
        by smtp.gmail.com with ESMTPSA id h12sm11790547qkj.52.2021.06.15.06.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:28:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] doc: avoid using the gender of other people
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
 <20210611202819.47077-2-felipe.contreras@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <94848796-1a7f-e1d2-fcf7-5e6f5f361f2a@gmail.com>
Date:   Tue, 15 Jun 2021 09:28:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611202819.47077-2-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2021 4:28 PM, Felipe Contreras wrote:
> Some people have a problem with using a female reviewer or a female
> developer as an example, and since this is an irrelevant detail, let's
> say goodbye to our illustrative female colleagues.

I find this message to be snarky and underhanded instead of
actually describing the goals at hand. Citing the reason as
stated is _not_ the purpose of these gender-neutral
recommendations.

Instead, a message such as this could apply:

  Using gendered pronouns for an anonymous person applies a
  gender where none is known, and further excludes readers
  who do not use gendered pronouns. Avoid such examples in
  the documentation by using "they" or passive voice to
  avoid the need for a pronoun.

The textual edits in the patch are correct.

-Stolee
