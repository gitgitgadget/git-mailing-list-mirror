Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EFDC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925FC613D6
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhELN1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELN1e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:27:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0ABC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:26:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so2506814wmk.1
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ypo0p1EFkVSi0QhfBqZnwTcGAZYlDDZtphSIurD/Ub4=;
        b=vLOsJ+smsaEmu/3lF7X7/frc3QHirbKuHivt2hIs7uj12nLOqduDuwNkMIB61mj3iD
         i8ia3RnmaotxeED57T2lDDdgMfnyeQ0xyV3A+K+sCNotcE0IA3TxDcisGpSp0VU7ah8X
         Yolk4kYYzYeeTh/zAUFIAvpvu8UK36qaMUEpk7dnXpd18QIfRpx14seDQi+i3GJj4lnG
         cYU9kBSTNirPKmzbQaKZP+IU4e0zzK37O5dGbPmrZA1W+4vQ28n58K1v/zwGtapxk5Lk
         ODgkEwsdHAgzWMtgzll5iW9/WNxmhVioyk0OsGy4mkZonsFG1SjFlNkESOkTZl90cDYs
         7diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ypo0p1EFkVSi0QhfBqZnwTcGAZYlDDZtphSIurD/Ub4=;
        b=eUeHhNEwxlMC2W1eFFfWvxHOembXdG+008E0tyE3TMLkAR473w6sOmqXe1UIrCYent
         L/mHxvG/uNiQO42mO7EIDOxsAyN2IkrO7LqYSrjPXwxX1+xjplRZMoso71GOZqKS9Dp1
         CLuRk6gEbYt4SXJw/a+MPjlyk8LfOLaxix+8pInYMy4p1eEbsNyKY9D8dWJG82UrjWh7
         aV6ypb4hvLxBCC1lyexIjqIU0jtJvn40j821m7pg20HO2jU1Fwt2h4z6+MnW/gJyZfLo
         Dc8JkYjVXU5UKk59bP8pVvw3OgzOlvF1dfH7HZ9wdG/K26UjeVp86mGnNd1TcnaUR4JG
         eFRA==
X-Gm-Message-State: AOAM533RZiZUdMlfBc66M+np6qOMoFi0S1Pxyu4W0KlyXjuWvkvrmcYg
        jphgqdfmL5Fwr44mIxnXTm8=
X-Google-Smtp-Source: ABdhPJznuDrl3bAZETgnxCMo6y566ZLROh6P4ChSv2r5x8csBPJMuZANCrUmH8U2fg/cUwPIsBQNLw==
X-Received: by 2002:a05:600c:4896:: with SMTP id j22mr11406985wmp.156.1620825985449;
        Wed, 12 May 2021 06:26:25 -0700 (PDT)
Received: from [192.168.1.240] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.gmail.com with ESMTPSA id n5sm30977293wrx.31.2021.05.12.06.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:26:25 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr> <YJiKXRywBhhGXC5Q@danh.dev>
 <CAPig+cQdU_0uPKDkbuz3XqdYePAMNPcF_u+Enx+qfgRGvtiseA@mail.gmail.com>
 <xmqqtunbqf5o.fsf@gitster.g> <YJsheKt/UBJNtgv1@danh.dev>
 <609b7cd397063_6e0fc2082c@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c676b6e7-e152-ef8b-c29d-3835a3899ffa@gmail.com>
Date:   Wed, 12 May 2021 14:26:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <609b7cd397063_6e0fc2082c@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/2021 07:59, Felipe Contreras wrote:
> Đoàn Trần Công Danh wrote:
>> Yes, dependence on systemd should be strictly opt-in.
>> Although, I don't use systemd-based distro, so it is irrelevant to me.
>> I think it's none of Git (the project) business to decide which
>> scheduler should be given higher priority. It's crontab when
>> maintenance was introduced, it should be crontab, now.
> 
> I do use a systemd-based distro, and I like the option to use systemd
> units, but let's be honest...
> 
> 100% of systems with systemd have cron...

This is untrue, as the commit message points out cron is optional on 
systems running systemd and there are distributions such as Arch Linux 
that do not install a cron daemon without explicit user intervention.

  So...
> 
