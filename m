Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF38C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F025D613DA
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhELNjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNjj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:39:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD1FC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:38:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v12so23639470wrq.6
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0AMA0UyIjU9A0f75lUObDIw81UdEmFEg1tx9eV4aPVw=;
        b=KNGsemAxNWrdrQ/AIIGa0lTlMymReNOzeUCa2kHQ+MxhG6cTk9kMM9m7sNXZl6ZSaf
         jWJ8oVJhKbv5h+tyyyMYhYodKwy65ftqH3MShsCuyHuwu8CBXDQ5QaDgMzg9bBTyd0b9
         cv0Y71dOx2ely62/rtFNucQ0oseROCGuj0HS9yPQ+inay9EaneoaKVHU0e+Jqv2D5R9i
         w+nZEvdly4XZBB9AtvdEi8bEM1zLhiXx+q3LpssZmmAy1uNYNuIHkKccrfdxSrkU1Af+
         kKVMwC9Ew9aA25t6yeE3MqmE/0kbVt8yL4pTg2p2bPykGNAG7LyeFmlT4Zdpd+vepmOM
         wv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0AMA0UyIjU9A0f75lUObDIw81UdEmFEg1tx9eV4aPVw=;
        b=nSF7cKi9MPvKKj2XRoVceFCn93hgovXFmlcZOGrwbsWuQTtf7H0kFu3NSZkZMjCtO2
         G2M8KXlvQZdE8R0g5KVkcw11mkq2llo0PsVRGdGowbgPDS4fZBrS0BeLr7TZ05+FMkUy
         gohUDICOATwxT8I8IKIKhcuk3Ksbs4oTQbRJj+Xj0dj/uWPXCZLBSL7ZPhPWD6pKVMjM
         0VYHVs8oY1pRS40wWpFKS8/rhP/no6+bWJ5OWvtluIfa88CGIYs9DXR9iZWPPDlPn35D
         8MAjvFi61R/CXX+8ht0JNZqS5Ri7+oCWctV6ZRJmISdmrKkmSbpb8Ic/xmbt1nRxeM+c
         Om2w==
X-Gm-Message-State: AOAM531aFt4pIWAgklEzjBn31sYosIWTRGclOSkG3VKY2j6oDTgAbScv
        BeTpnYLvrRABWNshoPTGDqpBkn9VUyI=
X-Google-Smtp-Source: ABdhPJyx/u3OLNDS2bV7aIrjwL6Vdqv949jpK4UjjF70kdndKnjUGVz5Q7WavenHdZD1jlNpEeU1yg==
X-Received: by 2002:adf:f508:: with SMTP id q8mr45840203wro.109.1620826709078;
        Wed, 12 May 2021 06:38:29 -0700 (PDT)
Received: from [192.168.1.240] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.gmail.com with ESMTPSA id p12sm4311708wme.20.2021.05.12.06.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:38:28 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
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
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fbfd503b-d822-e9df-f766-cc70941fdec1@gmail.com>
Date:   Wed, 12 May 2021 14:38:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJsheKt/UBJNtgv1@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Đoàn

On 12/05/2021 01:29, Đoàn Trần Công Danh wrote:
> On 2021-05-10 15:25:07+0900, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>> I think others have strong opinion on not using "%1$s",
>>>> and prefer simple "%s" and using "exec_path" twice instead.
>>>
>>> I brought it up only because I hadn't seen it in Git sources, and
>>> wasn't sure if we'd want to start using it. Aside from Ævar, who
>>> seemed reasonably in favor of it, nobody else chimed in, so it could
>>> go either way, I suppose.
>>
>> If this were a piece of code that _everybody_ would use on _all_ the
>> supported platforms, I would suggest declaring that this is a
>> weather-balloon to see if some platforms have trouble using it.  But
>> unfortunately this is not such a piece of code.  Dependence on
>> systemd should strictly be opt-in.
> 
> Yes, dependence on systemd should be strictly opt-in.
> Although, I don't use systemd-based distro, so it is irrelevant to me.
> I think it's none of Git (the project) business to decide which
> scheduler should be given higher priority. It's crontab when
> maintenance was introduced, it should be crontab, now.

You seem to be simultaneously arguing that git should be neutral on the 
choice of scheduler while saying it should prioritize crontab. The 
commit message and cover letter list a number of difficulties with the 
strategy of prioritizing crontab over systemd when both are installed. I 
think we should aim for the solution that has the most chance of working 
without user intervention.

> Another point for eternal bikeshedding: why do we limit ourselves in
> crontab and systemd, how about other homebrew schedulers? What should
> we do if another scheduler raise to be the big star in the scheduler
> world?

We should support the default scheduler on each platform - that was the 
rod we made for our own back when we decided to use the platform's 
scheduler rather than having a cross platform git maintenance daemon. It 
just happens that there are two possible default schedulers on linux so 
we need to support both of them.

Best Wishes

Phillip

> I guess we should take some templates for running on {,un}register
> instead? However, I think such design may open another can of worms.
> So, I don't know.
> 
> 
