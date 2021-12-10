Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0327FC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 11:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbhLJLzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 06:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbhLJLzO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 06:55:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C95C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 03:51:40 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so7997138pjb.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 03:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/U0usk9/kuPFzyNgVrwXDZBWemEs2CHv7UI+x/C3+ds=;
        b=opMlcIdKWBjbQPwZB06zt0bgsT+DbGMDfSON/BQEEkXDelSL597mylhR6RGsv519J7
         zTKL00mMQlyRPPWf77xftcZPEKdpIeQeAOEIl63KqtoaRbjFRT7nVIRnwVTZN2TPcukd
         ZwjjYwdH2IRXBe1Z7MSAxknyKcptxZLcTqCXxIXeOe7DLG92wFxoVmJx1iuk833zuPPM
         wlpsG5bGKqGSkyw6LEZkcKJmqEdqcvVgUa7D8aJr55UvXzPdsBLg8HtfOGATZFk7habU
         tCY9lEuaJ+8LrGXkr95+ebYg8Uznu9H/lgUd518GfeL0SmgBzBSyyvDAm+A2OxBERBcq
         Cstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/U0usk9/kuPFzyNgVrwXDZBWemEs2CHv7UI+x/C3+ds=;
        b=dsueJ0dklMdauOLodyT6Uxt9BYF+O8a730eB5kwSHyjpwp1PvJDc34tZZtq0ktFRsy
         q5aPfm/OS8ONZ9WZ7J0oQLWiUImNMqG+AvSzQQuXz1t/m1w93TB5EF2trcblIsDRg2jb
         t76HvFUpcjmELXlGaF3ziZOpAhPk8SW+TlLxvcerlI9TeJPnvpqBhrwuoZye2hXDvIrM
         f1MByCM1X3sXH8fo1uCtFT5lVlcOG9QY/axwbSiZhb271Z0qpMzBtUd/rBMGHCpu4fiv
         TAenU2anYOqODP9tIiEQqFHlQXtevD1BMwo+DimmB1I0uCtWm12d9Hl/JQxsEsH0qE3O
         MrnQ==
X-Gm-Message-State: AOAM5326QmrJ27H36QWhzxTSMIJJ6sx68iLyFzavm1NQWlC0Es01/s/V
        batyGwmVoO7dxjUYbczljoY=
X-Google-Smtp-Source: ABdhPJx9S21x8D96dSvj8/tCchZqkFRAYgqZ+Twd+fmfz3PFkOisi7Ujkgkv8u0CUWgVKZK49hv7xg==
X-Received: by 2002:a17:90b:4d0e:: with SMTP id mw14mr23286090pjb.43.1639137099574;
        Fri, 10 Dec 2021 03:51:39 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id o124sm3082188pfb.177.2021.12.10.03.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 03:51:39 -0800 (PST)
Message-ID: <7a8206d3-f06f-07b0-c60b-dea549af7731@gmail.com>
Date:   Fri, 10 Dec 2021 18:51:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
Content-Language: en-US
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
 <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/21 13.22, ZheNing Hu via GitGitGadget wrote:
> +-w::
> +--to-branch::
> +	Rather than checking out a commit to work on it, checkout out
> +	to the unique branch on it. If there are multiple branches on
> +	the commit, the checkout will fail.
> +

Did you mean unique branch that contains the commit?

-- 
An old man doll... just what I always wanted! - Clara
