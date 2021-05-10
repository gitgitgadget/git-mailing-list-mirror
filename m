Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F6CC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 04:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9775613C0
	for <git@archiver.kernel.org>; Mon, 10 May 2021 04:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhEJEX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 00:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhEJEX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 00:23:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB415C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 21:22:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g65so8354851wmg.2
        for <git@vger.kernel.org>; Sun, 09 May 2021 21:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hrE9wzzaGerPk6XWJ2cuXYVTNznRTa2urZbb+8j2fG0=;
        b=tvlhpjS2TwS3pt8jDjAwEmj7dqWZJOKVv6XBZ41E02u9qeNZAC2AjUch6o+xSJOLOV
         MU8bWYVe7bVW2knshw9MMfpq7q8ZOfzZGplangzjxi5/lHD5FiT8HZ0m71/rI+YmXvbz
         SGaueBMmKphzFkc+RnJvF4fiH3H1H0MCJUqgFAp4vARm9Esi7Wm/8MuR9ToXHCXG/rd6
         xH+n6C2jxD8F8x0BfTuyz4e/L23TqkVpY+yqoXczcbTpzstxVWT4QJx0V9mHzEOt6Zu2
         OFvMzG29mOCaFqcHwrcVMVvwuLUi4/6an88/q2wiyYEHVU3m/cBijdqctXfhmjfHjAPE
         TXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hrE9wzzaGerPk6XWJ2cuXYVTNznRTa2urZbb+8j2fG0=;
        b=HsJswxUOz8msXESnut0ob8PIwtaQMi1eDU4d/3GZJj3y8Q5CHWnWAmYpwVUTgwqaS7
         DBYOVmfAk93frSoVNfL6GpivR4PCEPj44pdr9tul59oK8DKDQ/D4xF3l20d1Y2MrVAgX
         9+PHICmVvGrkkur1KvdDEUY/qzJ4asIQYzElwulFvODClbIs3GJ5FaGfTUettNXXeczT
         g8Ao8UgTJ5SdKX2i/AGWT0qdxgt8Hm4Q8ImN7dHZU6BGTD4lf7yONBl7nQsPg2O78mnx
         d/awlxgj/gboNknNMNTQ7vCoKH0xYIQHVwJolOF9atzJOGEXd5hpPUJOX7OZZVBwlCQD
         yBvA==
X-Gm-Message-State: AOAM5325NbIPngZVo/xKbLU/fL+BzYgBE+jEm3ivIiXiXZ7+p8BGxwGo
        JV7tU36dmc5gzQgBj83iFW8=
X-Google-Smtp-Source: ABdhPJytM6ZEoYXyR5uGQbz2U9K3oSx3qbHw6AAaRwB+SfHHK5WGqTL4xzcXUxSNeiFslhR6uAV4CA==
X-Received: by 2002:a1c:bd46:: with SMTP id n67mr34463760wmf.113.1620620541660;
        Sun, 09 May 2021 21:22:21 -0700 (PDT)
Received: from Inspiron (2a01cb04010c420084a8e8ad2e2ee957.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:84a8:e8ad:2e2e:e957])
        by smtp.gmail.com with ESMTPSA id x17sm23799962wmc.11.2021.05.09.21.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:22:21 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 7/8] doc/format-patch: describe --confirm-overwrite
In-Reply-To: <e0bc4aef-a92a-20f2-0b9f-d65917710e3b@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <20210506165102.123739-8-firminmartin24@gmail.com>
 <e0bc4aef-a92a-20f2-0b9f-d65917710e3b@gmail.com>
Date:   Mon, 10 May 2021 06:22:20 +0200
Message-ID: <8735uvgqv7.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 06/05/21 23.51, Firmin Martin wrote:
>> +always;;
>> +never;;
>> +	Always/never prompt for confirmation whenever patches or a cover letter
>> +	are subject to be overwritten.
>> +cover;;
>> +	Ask confirmation whenever a cover letter is subject to be overwritten.
>> +--
>
> For `always` and `never`, I think s/patches or/patches and\/or
> For `cover`, I think s/whenever/whenever only (add `only` after `whenever`

Makes sense. I will change it if this text remains in v2.

>
> -- 
> An old man doll... just what I always wanted! - Clara

Thanks,

Firmin
