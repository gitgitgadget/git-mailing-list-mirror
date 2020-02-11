Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B28C352A4
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 02:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B87D2070A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 02:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+WaTcUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBKCjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:39:18 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42347 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgBKCjS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 21:39:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so11361556oih.9
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 18:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0tn/8veDcbMeuge5ZVkDVJIkXV3lMrYrffYGREJyQwk=;
        b=O+WaTcUR/vYsuLZo1J7khnHw/HMHeWfmXtXZrw6gJv6+t1oAzlKtka7EmzfOde6Tge
         YHCfiSJQZRs37d6w73IvNF6uWWKnVz3R6ebvqKMp4EpQ9P2bTePTbCABduIopwIxHK5+
         NF7SbI9r8IDU7AXMWPRzZUYmIILNGWNxi5mKGwQZSmPx6KREfaAqLIEaJCAeUH0DOww5
         pUirjcRifQEmHrjqvGkR3rw4HeLuC5G+Hi6didQcqu/nxhdUEBVrp4ip5UIUHmj/KDoT
         g/0Suv70nb/aGqMn87HBCWwEP+MGXb63aRKigesomuOQmdYwXDC+GVMb2LVKV9xJ7TbY
         Wfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0tn/8veDcbMeuge5ZVkDVJIkXV3lMrYrffYGREJyQwk=;
        b=dO0vV1qyCTaV7MmPCoSAX8g5m3WMVvjo2WBmSM8xFcuH0SlCwF1ludwW5AG+PDfR+r
         k9XuAebwVicGTMlOTQag3TEywalhpEzqYmutsVk/4IMIIQbytMOv5IJMqJ1zZz2gBEvE
         y4wA+h2RbWYYhr+gReqdBZJjaEaE0561M2FTV0+HiIMPoBvM2Pznm+I00kcBkJgaGzeu
         NoxdMsb5ZYy/JG8KWSqxF0G13gRrNTfVDh1Kaiysiv6D9Udg9GMAZ/IBHKw7zoNvVxeW
         DDTR9ywxc9PjcP4Bia0dNtpyATxJuStNepJecCoSUlM+Cg7P8FhAO2Z9r/NAe0+Vuv59
         XfYg==
X-Gm-Message-State: APjAAAW3MuOT5E5D7UswEjxS2K371SEk3rTxU6l6UaFUfpTe/VeRpEoQ
        WTmsn6pbfxQY3lWdJcmtgXWklS5n018=
X-Google-Smtp-Source: APXvYqxZTo1VkPxArlqV8MhLRoxKjhDf5fD8U+21m2uDCVl0gmpEKbxeTcqH5x1n3fynR3pNAU3nlg==
X-Received: by 2002:aca:e084:: with SMTP id x126mr1458465oig.97.1581388756881;
        Mon, 10 Feb 2020 18:39:16 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i8sm738991otr.41.2020.02.10.18.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 18:39:16 -0800 (PST)
Subject: Re: [PATCH] advice: refactor advise API
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com>
 <CACg5j27SyHsc0soh_MUJHtAowjGxQ5e5ZBoXsDKfXCV2OMUpTQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <86f2abc4-c5ee-1b6c-94d1-0c7576a16efa@gmail.com>
Date:   Mon, 10 Feb 2020 21:39:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <CACg5j27SyHsc0soh_MUJHtAowjGxQ5e5ZBoXsDKfXCV2OMUpTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/2020 6:56 PM, Heba Waly wrote:
> On Tue, Feb 11, 2020 at 3:38 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> I definitely tend to recommend more tests than most, but perhaps this
>> unit test is overkill? You demonstrate a good test below using a real
>> Git command, which should be sufficient. If the "turn this message off"
>> part gets removed, then you will still have coverage of your method.
>> It just won't require a test change because it would not modify behavior.
>>
> 
> I see your point but I wanted to make sure advise_ng honors the config
> variable using tests 2 & 3 in `t0018-advice.sh`
> and `t7004-tag.sh` didn't seem like a good place to add these tests.

You're right. I wasn't considering the case of not showing the message
with respect to the config.

-Stolee
