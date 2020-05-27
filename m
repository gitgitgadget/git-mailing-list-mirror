Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1E3C433E1
	for <git@archiver.kernel.org>; Wed, 27 May 2020 09:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B3A2088E
	for <git@archiver.kernel.org>; Wed, 27 May 2020 09:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozwmM22P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgE0J4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 05:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgE0J4C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 05:56:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC5C061A0F
        for <git@vger.kernel.org>; Wed, 27 May 2020 02:56:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so2428223wmd.0
        for <git@vger.kernel.org>; Wed, 27 May 2020 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=svbV2FUw70qcujClDCEyvHv6dtwVnxUOQEm0uqEosew=;
        b=ozwmM22PmseDsQ0HS85qEJdNbtM3DdxuOkNjgugnm7AJzMiROE/cvtLQiOEdbnDYUs
         /QkDkh77VCsE7FurZdgEUrdtf+mfFBrhibXqLG1YIOwt21C5pgHbnyRoc7huXSI3F7Qt
         IfhzYzrdDjgisYTzJI4NjRmdnoE6DPZzULTb+gFR8FP5k4hP1ZL4KFNFk+Srj4OCZX5q
         hw8ogIc/iGWjenqDZYSv3jzUuGGlLbFwu1Ta/Yf+q2dQhkRSpxpOCp74GtKxiWukN04T
         lhg/CHEab2EUNxwajxO4O+q2im4/ya//OeyyQx4VkaARzJqYFQF1KvvSbfRRDWA7+JD2
         oCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=svbV2FUw70qcujClDCEyvHv6dtwVnxUOQEm0uqEosew=;
        b=Qp23S5XxC4aI9PALE+UbGkN5DqJ0d5Rp3mggaO1acD64fvE5WawgtExIVAbtoR9Nd9
         gHM6IAdQNB4bGr8SvWnY4RFsZ+4cpGOP4u0gCA7Uc9MK8fekMOQGjVow/ehW1/PQxfkT
         eCUYFVHzrBin7sTtz8rJAtH/x661s5x9i0Z2SGHUEzbD0UVvXV5mp8vganWy1O2zinOH
         wk2np1jrnRcENJfaIMypuY5hy/0WsdLGWPUEO/4RHDzsPu2DL2j/CbqAMpxq+b7cWGSo
         7AREdttbbMz7pBYDFXUP12TMqLvhvB00UJrcftfxDRRWHgDQHY15RvypMd925aLOpkBn
         CE5w==
X-Gm-Message-State: AOAM530mG9LDBJ/Tm5odk3R1FG7mDYvDP2n+er6eSmYGfEf0SwQadFTX
        oFP7BMI5vm6qG5ZQQB6j3knrAcy2
X-Google-Smtp-Source: ABdhPJybKEaJNqzLx6c85zAESSVCxanANaXKyVoGWsylCZr7Aq8tnU6DaI5JjETEnf4cF4gOLTj5dQ==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr3396977wmi.43.1590573360557;
        Wed, 27 May 2020 02:56:00 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id z25sm2334272wmf.10.2020.05.27.02.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 02:55:59 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/5] rebase -i: support --ignore-date
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
 <20200521101455.63484-5-phillip.wood123@gmail.com>
 <20200523123025.GA20683@danh.dev>
 <bc6bc4d4-79cb-f788-deca-41a3735fcaae@gmail.com>
 <20200523155203.GA10163@danh.dev>
 <0cf07e92-25f2-ae0f-6f44-c2cd9e9f4851@gmail.com>
 <20200523230526.GA1981@danh.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <489037af-0a59-9cbf-6ba1-92dc48b24a45@gmail.com>
Date:   Wed, 27 May 2020 10:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523230526.GA1981@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh

On 24/05/2020 00:05, Đoàn Trần Công Danh wrote:
> Hi Phillip,
> 
> On 2020-05-23 19:50:40+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> The part of my reply you've cut said "I've checked the log invocations in
>> the other tests and I think they're all OK." So it is just the one that you
>> pointed out that needs to be fixed up (the others without -1 are all
>> checking the result of rebase --root). I'm happy to re-roll if Junio wants -
>> lets wait and see what he says.
> 
> Ah, I was thinking "they're all OK" meant that part can be left as-is,
> and the only part need to change is the --pretty=format.
> 
> Sorry for the noise, (and my bad in reading).

Looking at the patches again I think I misunderstood what you were 
saying - I had not twigged that I needed to remove the 'format:' from 
all the git log invocations. I'll send a reroll later.

Sorry for the confusion

Phillip
