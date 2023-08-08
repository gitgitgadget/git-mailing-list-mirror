Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60385C001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 15:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjHHPyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 11:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjHHPwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 11:52:33 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B14EE1
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:43:07 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63cf57c79b5so37443626d6.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1691509356; x=1692114156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zooSTW0bCoLl4fFwce/WuZYo6pD2Uws9GBCGar/kL4E=;
        b=N9k3UZCz1dBlKFunV/9Yv9mNVSXyuUKn0jt5i77uEB8MYFBkTyvvvQokPradJIWUXr
         uqgGhPPXXSmngvMqnVgi2CAxJfV53Bflqx/w6LXOonGQ7qWnDtUPGC7p671Cj9wP95qb
         V24ChXJh9ozYUmRVxtvIa8ENRKk5lpBrzPmw6nReuDq/XgEpNIXOQTgfp2GUx7a1Sm9+
         p2V3Zq2sylHSPJVTLhBf9OBI2g7RoLiPRDpn95SJ4CZPHuq3tLYg0Bpw4oH0Iqbo4U8N
         gQLQdVrbhCmQluE2He2SOOUx2X78ymqT5YnYBWWVMR4w/AW/CGUdn3i3wxcCNJdYGdTz
         9SEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509356; x=1692114156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zooSTW0bCoLl4fFwce/WuZYo6pD2Uws9GBCGar/kL4E=;
        b=ZM8IorklkBU8P9MMQHT44Tds6r26+8rZxTGGFIF6GCArjIF8wW0z0PuCg8RnGoSj7h
         VjVdmvz8LdrY6AdV7UQf9t+cQsqieYCMEnS/XYtFCIvMqSt2zoLRS02ONs6xOdsmijw4
         MH19wcuMaxJOjfJUAEcfYBRnnC7GYb8fp+0oFaxsAdkC1zEWIPN/GuOVTqALgmeYfhJy
         Ru/e+Z22LT+9fZKDDUZsdByxmgYBUB0Qc2OqRbtMw5M9zReY4ITdQ9cb0eOuOoETkgDN
         LW17sz4ySSp8hnyRnAKSibXXtEznjHNj5gXhWD8wvevjVC7/9rEVdPj/5rgidjJDweMi
         iDXQ==
X-Gm-Message-State: AOJu0Yy2/V7yrsUB3u9KPiWljKaRsMEMeRaRkL86xOC+kPGuLrLkP8HI
        MJ1B/1P3oGOVnw1P/KWcpE631gYNJztVgnKlMg==
X-Google-Smtp-Source: AGHT+IGB2Gbi65WCjLwskIH0XpwoBZZB/AYbMnOAlIKyFpMikblPaJgZOxiueXWGm6GP7E0F62yu2Q==
X-Received: by 2002:a81:4ec4:0:b0:586:a59f:6559 with SMTP id c187-20020a814ec4000000b00586a59f6559mr11635778ywb.24.1691502989905;
        Tue, 08 Aug 2023 06:56:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1d2:c14b:5536:5192? ([2600:1700:e72:80a0:f1d2:c14b:5536:5192])
        by smtp.gmail.com with ESMTPSA id m20-20020a819c14000000b00568b941e5e3sm3298370ywa.72.2023.08.08.06.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 06:56:29 -0700 (PDT)
Message-ID: <8aa7be24-f4a8-4515-8425-dd4bc69e07b1@github.com>
Date:   Tue, 8 Aug 2023 09:56:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
 <adc0cf80-c2e3-7af2-6d7f-036b95d27f80@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <adc0cf80-c2e3-7af2-6d7f-036b95d27f80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2023 5:53 AM, Phillip Wood wrote:> Hi Stolee
> 
> On 07/08/2023 19:51, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>> +    switch (schedule) {
>> +    case SCHEDULE_HOURLY:
>> +        schedule_pattern = xstrfmt("*-*-* *:%02d:00", minute);
>> +        break;
>> +
>> +    case SCHEDULE_DAILY:
>> +        schedule_pattern = xstrfmt("*-*-* 0:%02d:00", minute);
>> +        break;
>> +
>> +    case SCHEDULE_WEEKLY:
>> +        schedule_pattern = xstrfmt("Mon 0:%02d:00", minute);
>> +        break;
> 
> This is not a new issue with this patch but we run the hourly job even
> when we want to run the daily job or the weekly job and we run the daily
> job when we want to run the weekly job.

This is an excellent point! Thanks for bringing it up.

> So only one of these jobs will succeed. The cron entries are careful to
> only run one job at a time, I think it would be worth doing the same
> thing here. I think the using the following format strings would fix this.
> 
> Hourly: "Tue..Sun *-*-* 1..23:00:%02d"
> Daily:  "Tue..Sun *-*-* 00:00:%02d"
> Weekly: "Mon      *-*-* 00:00:%02d"

I would modify this with dropping the "Tue..Sun" from the hourly schedule,
as we still want 23 runs on Mondays.

> It looks like the launchctl schedule has the same issue.

I will take a look at this and consider some additional patches to correct
these issues across both schedulers. Thank you for the attention to detail!

> One thing I've been wondering about which is related to maintenance but
> totally off-topic for this patch is that I think when auto maintenance
> is enabled we stop automatically running "gc" so how do the reflogs get
> expired?

The default maintenance schedule does not include a 'gc' run as it does
not intend to remove any data. Reflog expiration could be considered as a
separate maintenance task that might be useful in the default maintenance
schedule.

Thanks,
-Stolee
