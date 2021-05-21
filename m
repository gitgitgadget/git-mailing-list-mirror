Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6410DC43460
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EC8613CB
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhEUJzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 05:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhEUJx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 05:53:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E20EC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 02:52:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso6871669pjb.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 02:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WI5EOT5Wr/TkVe1EHdVfrHSiYWef0/eZaG//M8bWLwI=;
        b=YOGXdmG5gTSKIdjVWdiNdY3dp0fnzRYdmNINDiIByJ8T1I1EqRZVscMUV4nByrO/Sl
         U+EHOB84OdSY6ZqBKMGb1InFZyh9vZpdZ+IajFSeD+VK8UJGVwYrM1hK5cg68gIW57Fy
         eK4yJsHt41JasqcrAMMEN5dLhzm94t2Zd/k+i2uS7nG7xsB/ihRmc4uy4+CKc/aD0ETT
         NZERSHf69btBHiL67IbTvJmpbrvjHoHXO68rtgXIcEpa9fqMKBYN9YEDfs/qYiB+hu08
         6tq/fgVtEjz2+S78fpktqHqIbckVUdvFKwA9p5m3ozKQWhHuQkkzPeU6ZTLKDH4IGTNl
         WyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WI5EOT5Wr/TkVe1EHdVfrHSiYWef0/eZaG//M8bWLwI=;
        b=qgHbsT8CPCgRYeLnGRWiPumtzYVAiuKmOjt6Qz5C0PKukkYv1tnobVwOeUSgjWCvDX
         VUMjU0Vy+y6RMPTwX5sJ8ABrLelZKQOSmSBHwraJ/Qi1pQPehcA6S6OFAhFM2epTfJn8
         V80oYiFCgiVZlSg2/epql0HnvhKcnwWyPne5yyHmC7aq8rvipy5HQtcoIRkdGWvGr3vd
         GGPxobZq1Rm/62NIlpSxUgKDrL3IB6G0H6xMeqpz54gDnYeHYGyvewIYcjxAs4y1jerv
         OAo3JoGMdnIExoZ6ZcYu8XOBESEGinbwfeVUsaaj7bdCyGiNyeG0/J1zdsogfSQGjj2W
         B7KA==
X-Gm-Message-State: AOAM530e2GwKZd0OqBXizZOkW+/7GTkdWNpMUAo8C8HzJ8Hc7rBrxeyf
        8THmOfvs7CU4f1lDHHDyoTk=
X-Google-Smtp-Source: ABdhPJyMDcdKqM7zDBI+n/MK9RoPJ53mbcencGUdgOGfnxO9runVgibJecIisjnGWnaJIh/3Ukcnjg==
X-Received: by 2002:a17:90a:de04:: with SMTP id m4mr9650153pjv.40.1621590745985;
        Fri, 21 May 2021 02:52:25 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-41.three.co.id. [116.206.28.41])
        by smtp.gmail.com with ESMTPSA id b16sm4251096pju.35.2021.05.21.02.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 02:52:25 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-4-lenaic@lhuard.fr>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <31eda7fa-5935-91e8-0059-09188cb30511@gmail.com>
Date:   Fri, 21 May 2021 16:52:21 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520221359.75615-4-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/05/21 05.13, Lénaïc Huard wrote:
> Depending on the system, different schedulers can be used to schedule
> the hourly, daily and weekly executions of `git maintenance run`:
> * `launchctl` for MacOS,
> * `schtasks` for Windows and
> * `crontab` for everything else.
> 

...and soon to be supported systemd timers.

> `git maintenance run` now has an option to let the end-user explicitly
> choose which scheduler he wants to use:
> `--scheduler=auto|crontab|launchctl|schtasks`.
> 
> When `git maintenance start --scheduler=XXX` is run, it not only
> registers `git maintenance run` tasks in the scheduler XXX, it also
> removes the `git maintenance run` tasks from all the other schedulers to
> ensure we cannot have two schedulers launching concurrent identical
> tasks.
> 
> The default value is `auto` which chooses a suitable scheduler for the
> system.
>
  
Until this point, we haven't supported systemd timers yet, but in the next
patch we add support for it. So the patch description looks OK.

-- 
An old man doll... just what I always wanted! - Clara
