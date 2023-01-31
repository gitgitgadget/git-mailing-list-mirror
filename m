Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853F6C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 18:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjAaSfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 13:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAaSeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 13:34:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE55F521C8
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 10:34:20 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y11so15338059edd.6
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6weGwyNy/jP7S9Oe/bbxcosVQpHR4o7ped0exb+Bcs=;
        b=I2xxMBYRBxh4FFO0Hn+aCSl9eBIRI080IPK79EUDRqpz0rgzw/W9PgQpIBWaorvJ+k
         Jen4qc8KaAHzm8DfQ+iFngUJvneCrp3SQ/8iq4W0Ve9c7w6XpiTElh+AF42SdmQmoAH8
         aHzJFT019K6oB2uQh12c+w1P4XP/RhQBrHyNQ8wu80dGzL8L6AIADMpkfd+8wjfRmQXm
         d/d7oPnKK7P63dleHw+aU8k0SyaYBs0VBfLcpOqC+DbOvWuIOCv2xLXNP3rLbtElpDCN
         PD9lQWQ5/S0tkJUhCf7Q3m4ctdFK3gTNVEHwU0UdU+bmleATGDLdx7Rc07GWaogn3N7N
         +BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6weGwyNy/jP7S9Oe/bbxcosVQpHR4o7ped0exb+Bcs=;
        b=QiKdrEy53KvMZJMQBWSSMFsqsK5YNR5Qip478jzDNC4P90KshH9Utt6pW9wMlcPHhD
         Ydaxs7tzYTfT603qEhNPwUA8O2BQ/X4tdV1IOZPsXLQjXQeWBePcSPGa1ABWBLHMXnHa
         j9R9GfANsowJWjl9Q41q+BHmnxPftIZUuxiPgtlSRPXyRnFfhtd+CDpgvqEY9hzJ6aOJ
         OAG7wCUV10BwXh/MgIvvKcgtyRHNA56wvLgHbb78K0ZZnaq+gV9WUAu9A9amreeHGmPU
         QqAaGg4gj6Fl2K2E6DqTmgGrw85gZFzlqXbkotdsnXHljJy6rqyxb95TDHfYZzNSmAF+
         RxcQ==
X-Gm-Message-State: AO0yUKWKFbpzJ5YQ9tFpHO01o39VKPFsoWe+/mSmJ5ZnSovb4+969rfy
        55tbgasQq49xUrAo0EGS56ziDy6JqLs9gQpk
X-Google-Smtp-Source: AK7set8U7BGjZL3oGeuE9vs7b9kGEqB9KHCIhisNoampYo9cIQnYr8lN+M23X/RfokCloSrjPaXc4A==
X-Received: by 2002:a05:6402:40d6:b0:4a2:49be:5cd2 with SMTP id z22-20020a05640240d600b004a249be5cd2mr5476465edb.22.1675190055804;
        Tue, 31 Jan 2023 10:34:15 -0800 (PST)
Received: from ?IPV6:2003:f6:af25:c200:dcc7:5696:ff63:6d6f? (p200300f6af25c200dcc75696ff636d6f.dip0.t-ipconnect.de. [2003:f6:af25:c200:dcc7:5696:ff63:6d6f])
        by smtp.gmail.com with ESMTPSA id h17-20020a05640250d100b004a249a97d84sm3246073edb.23.2023.01.31.10.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:34:15 -0800 (PST)
Message-ID: <fb4c20a8-1bab-5905-5d56-90efad135a97@grsecurity.net>
Date:   Tue, 31 Jan 2023 19:34:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
Content-Language: en-US, de-DE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <20230127154952.485913-1-minipli@grsecurity.net> <xmqqbkmk9bsn.fsf@gitster.g>
 <xmqq1qnfancf.fsf@gitster.g>
 <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
 <xmqqk0156z55.fsf@gitster.g>
 <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
 <xmqq357r4zvk.fsf@gitster.g> <xmqqlelj3hvk.fsf@gitster.g>
 <xmqqk0131zxi.fsf@gitster.g>
 <d1c4cbad-bbb8-d610-5e27-970d96dd7a74@grsecurity.net>
 <xmqqtu06zmg2.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqqtu06zmg2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31.01.23 17:41, Junio C Hamano wrote:
> Mathias Krause <minipli@grsecurity.net> writes:
> 
>> Looks sensible, but maybe something like below would be even better?
> 
> When I say "in the meantime", I expect it not to be the final one.
> This time, it was meant as a mere reminder to me while I wait for
> the (hopefully final) reroll.

Got it, will send v3 (the final one, as three times is the charm, they
say) integrating the change to die() in a moment.

Thanks,
Mathias
