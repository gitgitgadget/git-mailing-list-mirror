Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3FAC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 12:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbiAZMqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 07:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiAZMqD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 07:46:03 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C534C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 04:46:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k18so25576816wrg.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 04:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=4ZTFArTLLjG8kaTBkvf33BV+IJf6YkHqJ7Racx2L+yA=;
        b=Kcu/4WWiR5CoOd4qEkrmOf3+yOobJeV1ckfdkGTTxURGpcmMCeQBRY2NulIb1fC2Rf
         ywDFxOCVWi7CfK1+bn22r35R8idgwk/UgqIspGU5e7b4eH6z8Ptc9vi335w5QQ1hUKd/
         O3drBy5MQw6s2EwogAhcadJjdz7CGPyt+XofgW9GMNILBHyQvikXPvC8rBOt8RSBHGDm
         zh94vAV3eizhsM8MVeeOGnc/WgBIl9OmVK0CHN8lNLuv0+ocyi42qxdF8qVuBLm+E5O4
         z6IRO23EA+esn0+BjE2vvgwlE0t5URPKEW539ALxmkLKsnR+bqXpuxD9MgnBvYwZHmw8
         MRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=4ZTFArTLLjG8kaTBkvf33BV+IJf6YkHqJ7Racx2L+yA=;
        b=gLJw8ffL5TARIeNM13KJ9BFFAjTVEPWSfjWXY+xh6fYRWWcktRQoChh+/GHy7RZ1KF
         aMzdCjizVT95ioYeKQuZ99gJ1RadO2M5N+TtieobGZEv3Om11J1ABR3FjxPshv5vhVkg
         eQ6RszpDyiMpVfYZc6TYpe8Uj1IToXbftaOaHaoVU+A8XWtWWYDxNPZx3n9W1T2d1E9p
         /uaqs6hfw7c8xWvZhW7OdZo2LE9VSx2tHHVbyq03Ijpe/Gy/71yqXM6ZKRjgl+WgD/9V
         WUWdd+tEPA4ARon1Ov4gGdWzB8+lC2RS2idhPoseFNSoSZHON9fskekgV1fPcfEoir/E
         oUrg==
X-Gm-Message-State: AOAM530/sIqJE0tRxsi5Etukv/ag/EGpm6/xvbgy9UXPZq/pcy3JgFDx
        0Di+wAmyDMu/Sis9mdAEv1xfRW/lwEGRTw==
X-Google-Smtp-Source: ABdhPJxEOOYQDLLRHbwgsUApahkPM5t1/gwEJRC1D+HyW1IfkppHGff5eIYWT0XZxEeD4GbDz69WnA==
X-Received: by 2002:a5d:58c4:: with SMTP id o4mr16581908wrf.532.1643201162030;
        Wed, 26 Jan 2022 04:46:02 -0800 (PST)
Received: from localhost (2a01cb000f483e003b320a5f125af7b5.ipv6.abo.wanadoo.fr. [2a01:cb00:f48:3e00:3b32:a5f:125a:f7b5])
        by smtp.gmail.com with ESMTPSA id i17sm19174369wru.107.2022.01.26.04.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 04:46:01 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 26 Jan 2022 13:46:00 +0100
Message-Id: <CHFM74053TIA.3G3CIXQYDMDXS@diabtop>
Subject: Re: [PATCH] receive-pack: interrupt pre-receive when client
 disconnects
From:   "Robin Jarry" <robin.jarry@6wind.com>
To:     "Jiang Xin" <worldhello.net@gmail.com>
Cc:     "Git List" <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Jiang Xin" <zhiyou.jx@alibaba-inc.com>,
        "Robin Jarry" <robin@jarry.cc>,
        =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
References: <20220125095445.1796938-1-robin.jarry@6wind.com>
 <CANYiYbGRK0eshjUJoPH0yWT1tVLoerOMC6CY6tAMrwAh7T+y1g@mail.gmail.com>
In-Reply-To: <CANYiYbGRK0eshjUJoPH0yWT1tVLoerOMC6CY6tAMrwAh7T+y1g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin, Jan 26, 2022 at 08:17:
> We used to ignore the SIGPIPE signal when calling "pre-receive" hook,
> so we could tolerant a buggy "pre-receive" implementation which didn't
> consume all the input from "receive-pack". On the other side, "ctrl-c"
> from the client side will terminate "receive-pack", only if we do not
> ignore the SIGPIPE signal when running "pre-receive".
>
> Wouldn't this be much simpler: add a new configuration variable
> "receive.loosePreReceiveImplementation", and only ignore SIGPIPE when
> "receive-pack" turns off the config variable?

I had not thought of this. Yes it would be much simpler. I'll prepare
another patch with this approach.

Thanks!
