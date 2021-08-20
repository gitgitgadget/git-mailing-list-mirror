Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E890C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476AF610C8
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 12:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbhHTMPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 08:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbhHTMPa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 08:15:30 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CFFC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 05:14:53 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id bk29so4858525qkb.8
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uTehv9joGw2ZH+wSPZOdPIguSeelX4eu+aFJakfHwVs=;
        b=sSU0jNIuyjg8G5KMHsdOaqW6ikDB9Am9SmucizlmlA/p+Z6QPCl6+pm5m/klJGez3o
         DdHSMv7HOKCOL/E3e8VXt/k2/zjkLQHMEZ6UrKPZu45EE0D4v1vO4U50lejhc+MmjZhg
         SIx4+HIT+QYeQVwThExeTNx6ZFSGK6eY04ANFZKA/Bd2DrJykjBFwMj9Iw/G5WrEvPvW
         3fAdpV3NA2RzPmTQth3Z9dsbLStSARxClGKvS53soVfZBTi1iJyh47oZ1h70OLwRtxCw
         XWe0vk1wnqLZ9oHsgAe5CyVLEfxFRLjLLZAmmNJzbmOkjMeOD6QLbkml8HtTx+lzlG98
         Mhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uTehv9joGw2ZH+wSPZOdPIguSeelX4eu+aFJakfHwVs=;
        b=sph8QUaYkTQVq5DusH+7z5xs0ChN6q4HAig1lWiEC+QhCJSHqxeEOwC/tE/mEYWz8Y
         LU+DUBfNBx236fqJYDyxuFaUZxphV3vHbuaiYv76wsGKGOwW1E3qwtFIQe0B/Yo83ewb
         nlPGUYtMImYf3hl457k7h4WiBNB9nKM1ucOKzxeDNwdcJPWzlEHQppcHCS58ETzIek8V
         uhCSjfJnUFcAfaN68YcVUgekPJB8j+C579i7v4NSnd3zneLaDBUNLSYTlpADdiwS7bn8
         SzgNaj6UDscsXVS7DA3ya/gNENqG5g0CjKBI4OCxs4pb5f8szE7kuTrUGG0SCUq0OfBQ
         JGKw==
X-Gm-Message-State: AOAM533BoYPLBZ4TgcTeKwTCVK0PEEVxo5Eu0X4E85RiSHhv9dTy3pQW
        oUHzUIWtfLn3Ank3yP5isv4=
X-Google-Smtp-Source: ABdhPJybZ7XCZCA27fxZg277mI7ENnCRMZbMrZPtyop2YD8WO4x+/J0QGc3M11n9K1i9ZwXXQ6+NHQ==
X-Received: by 2002:a05:620a:89b:: with SMTP id b27mr8438878qka.429.1629461692256;
        Fri, 20 Aug 2021 05:14:52 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id l11sm2508862qtv.88.2021.08.20.05.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:14:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] test-lib-functions: use user's SHELL, HOME and TERM
 for 'test_pause'
To:     Carlo Arenas <carenas@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <bf916ad98ccc1526f5298d1c3e1740cabad093af.1629393395.git.gitgitgadget@gmail.com>
 <CAPUEspiu35JZZ1z6BosGyWeE9z4uOBhSotFL6iF+jEY8tXsjhw@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <9b563662-6208-26e9-ff84-d10b98078cd4@gmail.com>
Date:   Fri, 20 Aug 2021 08:14:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspiu35JZZ1z6BosGyWeE9z4uOBhSotFL6iF+jEY8tXsjhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

Le 2021-08-19 à 23:08, Carlo Arenas a écrit :
> On Thu, Aug 19, 2021 at 10:17 AM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> The 'test_pause' function, which is designed to help interactive
>> debugging and exploration of tests, currently inherits the value of HOME
>> and TERM set by 'test-lib.sh': HOME="$TRASH_DIRECTORY" and TERM=dumb. It
>> also invokes the shell defined by SHELL_PATH, which defaults to /bin/sh.
> 
> that is a bug, it should have been TEST_SHELL_PATH instead.

Right. I'll make that change unconditionnally as a preparatory step.

> 
> goes without saying, that if you don't really need that shell for your
> interactive session, nothing prevents you from calling bash and
> resetting TERM or even HOME as needed

Yes. I'm just trying to streamline to experience :)
