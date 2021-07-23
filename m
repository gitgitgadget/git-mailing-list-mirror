Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E67CC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892CC60EFD
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhGWF4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 01:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhGWF4I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 01:56:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D54C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 23:36:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u8so2215864plr.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 23:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=heRw86zeEfncdP4TC1gljYpWCNtcwPXWRWTxVdgKJRU=;
        b=urIooeqNGb8HFViJ9+T3Hst9toQw5f6QRE5gt6KxkhZu17R7wB5/HGAulvV3L31VlK
         6sSqa4lxoyXlFyJPCN4G5NwjnZTiHbkGio+5CGOyPYOx83Jx/bXye0a/G0BMxrpFci+j
         NHjAhsnapO80MOQcFnn+fwqFzP2Z/YVAMa5hioAzNHitJDx8LiiyaW+2znYAk6D0Oaec
         t47NaRugn747ggph0pha873QPeQgZLVWWH+aEFZ06NhXXSymcNcb1v/VBnQr1AU614tY
         7cLcr+QVjrLmcZhV+CnzTfTgIdwCW/F9LjYpeoiUtp5N60f5lwZxvAOMUkrQCEqauiG0
         z0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=heRw86zeEfncdP4TC1gljYpWCNtcwPXWRWTxVdgKJRU=;
        b=XlXpbnwaNjpbAwH33KLKC/ODCAY+waOw4EKbUDdyQ8uB5FuUdS+4ke5Yq/jLW9rSym
         0+9Yd1OFBpF7kdfq4+3YTMxkYzcGRa/68M+p5VdR1WUtoN2pkbO8IIojy+MgUGh1xozB
         ftY8/+Fb1DDRUDQUzt0wKUeIrs4yedgCCfqhylTRr/GnR1xQHXFjU5H80uHI55o0vRjp
         1fd/frWe0Fe6R3WrD2ie5Ekd4765m+/1cBNRHGGnV+vdP5NTqqzXvVAmk+ahGyKnkWjB
         8SyG/kbAj35Y5JL4eSXdfdTjdgkfvAgqpA1fDcJiqisZUguOvCtksWjSiRvMF2pzgaF2
         Vlrg==
X-Gm-Message-State: AOAM531QwnUfE/yu+NVwqHIVbkMeetr6OFOAjjc+ueIPOFNO6+Ju0Imf
        pszg3gbszQluM+SP6tUoBDw=
X-Google-Smtp-Source: ABdhPJxi6GI96Os5x7vBq2CAaXGVzIHEbO/Dfg03nl/YeTDVR5rt79NRqX+oLzvrwvnIHH9oNnuSyg==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr3274392pjb.51.1627022202443;
        Thu, 22 Jul 2021 23:36:42 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-56.three.co.id. [116.206.28.56])
        by smtp.gmail.com with ESMTPSA id i8sm31612653pfo.154.2021.07.22.23.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 23:36:41 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] SubmittingPatches: move discussion of
 Signed-off-by above "send"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
 <cover-0.2-0000000000-20210722T120746Z-avarab@gmail.com>
 <patch-1.2-4283f000c5-20210722T120746Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <1b1c3bf1-50ab-01d1-e9ff-a18b15a682a5@gmail.com>
Date:   Fri, 23 Jul 2021 13:36:37 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <patch-1.2-4283f000c5-20210722T120746Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/21 19.11, Ævar Arnfjörð Bjarmason wrote:
> Move the section discussing the addition of a SOB trailer above the
> section that discusses generating the patch itself. This makes sense
> as we don't want someone to go through the process of "git
> format-patch", only to realize late that they should have used "git
> commit -s" or equivalent.

Did you mean someone forget to sign-off commit?

-- 
An old man doll... just what I always wanted! - Clara
