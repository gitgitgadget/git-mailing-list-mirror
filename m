Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B7C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD5A207C4
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RleknwUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgFPOYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFPOYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 10:24:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D31C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 07:24:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f18so19327624qkh.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ojAYgi6tcbJ7Kgu73X1hxcbIqEmwzrw0F+T7ECgVSbY=;
        b=RleknwUUaMyuJn4lTn9jyU53b2UH8TBty+sxNp7Ldrxr8nQSfvniiN5AJCa5GIWCfJ
         iJB6JsLnh/+Aav+Yvau9ZUrFTUTJJTelsBx5o2yrDMuCXY7QD0hZvRCGoZE4KsScdLHv
         w0ZtNMRkxHY8HsyekxKgmPX1P/SUEF74I5R6bUtVzYzNmsYZ1WiWFLOXiilSYUXQoQ0n
         +w8CcKWpa6pUSw5uP4DOhoGi/7CcLbr5HyAmk7j8uOGmxnJ6UTEdYAT7w1A1+Uyz/sCs
         37Tv5MYqAbLQmlo/qZ6brlKYIUMwFKpt4wG8puinMZBpXNbEjUetLz+e8rpDLODIyfyY
         PyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ojAYgi6tcbJ7Kgu73X1hxcbIqEmwzrw0F+T7ECgVSbY=;
        b=JcD0aoZVvSPLNurXul+xBMpMdX9F93uJvrmE3s5TiCowvZL3qkD4cpv2fiJqdv8BVO
         APw3qWLAZ/uDpoWiHuM6ZLFAK00p4rRJVZxttiPtn7lc43hcgkxQmF27Ya0ZPj4QcGCA
         GbCW8BBrhVJ1dZ0zO4RNajKcn53RkaD9Sai0mrSRbUf3MsGQFwvQgA8sKYZAVPaAKLeG
         mHk5W9CGM+SoZjusEXHfuxGQt3RLxRurMr7GIoD/61/jodmGa9pQJGaVypezf8YmEyNE
         AiO7Laetr2UXPKDOmbzwnXbBC5CXAigKFywI+Rf1pz4UD/0JH8t/LW+mvqcYQyqChmUw
         ZyxQ==
X-Gm-Message-State: AOAM5316gkb+EEz7sScOutMcgqM0UWLMbm3e9L+tJHCAeR40Op0v2WYs
        TH1SU+dnnHirDZQuqTT2MqU=
X-Google-Smtp-Source: ABdhPJys/LeUiPREeBqIZU4U0ABQm+IbvMarFeGuJICGrQnYi6WyhQ/UD5KH7owPWhShyLjWyNaNuw==
X-Received: by 2002:a05:620a:4d8:: with SMTP id 24mr19711620qks.219.1592317449908;
        Tue, 16 Jun 2020 07:24:09 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id y16sm16181034qty.1.2020.06.16.07.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 07:24:09 -0700 (PDT)
To:     konstantin@linuxfoundation.org
Cc:     Whinis@whinis.com, alexsmith@gmail.com, don@goodman-wilson.com,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com
References: <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <201a33b3-478c-fcd8-e707-63baab09e712@gmail.com>
Date:   Tue, 16 Jun 2020 11:24:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 >Let's leave emotionally charged rhetoric and discuss this like 
reasonable human beings.

Oh, now we put emotions aside? This whole thing started because white 
people FELT like black people FELT offended by the word "master" on it's 
own. But if that's the case, I'll just argue there is no need to avoid 
the word master at all. After all, feeling aside, right?

