Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37976C433E6
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 05:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D456195E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 05:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhC2FSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 01:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhC2FRr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 01:17:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F5EC061574
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 22:17:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id g10so3844029plt.8
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4d2oq7ajLOQ/gdSDWRa9J2VXywmgRdVPKxeE9woPqAw=;
        b=QOBE1IKcd1LYOhFo/AV7Lr+S6+YZDV2UJg0zowwpRDpK3jowdILcHvYafPQis+1ieb
         tdYH5moRd1MeZqHPug7DvOQ0UZdxupIMppm+TwhxIyZXbEyBXMhxLtntqcLRrDF75p6U
         KBkJV3ge1x5EuD6CwVNnCoVp6HKr8gWfARwCTFJhFtBKg7FbCeTi9E0waFXP0N6lGthu
         LZq7/j4aXTx7oaI5aBTyFjna4eFRlbAvF06MJtSZRO1rvlVsQMvMtfNEMZHgO4BILO3O
         23R/dcGYcso2BLUx4/fqbrryxD6QI2yYxw5Ztk99GeOgpRqUhD4VOUMR9NMmtzJuLF93
         QeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4d2oq7ajLOQ/gdSDWRa9J2VXywmgRdVPKxeE9woPqAw=;
        b=DJU3dox/PKbUSjFbEgkoBVb/pUhsMdiVwuYPdvI0gEyPS8nOcGEcf+5TGRjLb/U1oj
         NIAgjo7d/Zs3BnMND2wCketCMZoNV+SyOCgGTdIZq4elLd4PkuJD9blCpbUxo3sX3pAN
         gCpoWJTT5jdhPPDAos6wYw5GuhRs7bWkz9KcceqXVnZhgh5SS80RobNCbYzWhaHu9vZk
         lj1zSFHksi20R5DAD4lDDMXOymZk8MpBoAokaaY4ki82VIIifbUryJuNkdP0geyD530X
         57pqrrT0OJX/M/dxcRtcPWVGZyOXH9EXEqrfSg84K/E+66Ia4+SPTemD+MTDfpfkEE4p
         6iCg==
X-Gm-Message-State: AOAM532d5A9UosTvy+GkhRIQWXX8/SNCuh6XeoSBTKFYH0R2fGRJqoLS
        chR6LvSaIYrgRg5WHdsEZb37OrLTuSbyFg==
X-Google-Smtp-Source: ABdhPJwpW2SUxmZWXIn3P+uT7GBh39LYyjsTFtK8dimwN/V5ji8yVSTyuW1O4gIvor+q7pzwoMfDPQ==
X-Received: by 2002:a17:90a:3be4:: with SMTP id e91mr24165307pjc.113.1616995066712;
        Sun, 28 Mar 2021 22:17:46 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-2.three.co.id. [180.214.233.2])
        by smtp.gmail.com with ESMTPSA id i1sm14745277pfo.160.2021.03.28.22.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 22:17:46 -0700 (PDT)
Subject: Re: [PATCH] Documentation: amended usages of various (sub)commands
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chinmoy via GitGitGadget <gitgitgadget@gmail.com>,
        Chinmoy <chinmoy12c@gmail.com>, git@vger.kernel.org
References: <pull.920.git.1616913298624.gitgitgadget@gmail.com>
 <e85a653c-2650-313d-b5ca-5874559d9528@gmail.com>
 <de6d56b5-89e4-1e50-1011-0a9b9c46f4d9@gmail.com> <xmqq35wfm8mt.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <6852d727-5ce8-0b9f-112e-e420c44227ce@gmail.com>
Date:   Mon, 29 Mar 2021 12:17:43 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqq35wfm8mt.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/03/21 01.32, Junio C Hamano wrote:
>> What about this patch title below?:
>>
>> `Make (sub)command options conform to TD of option parsing`
> 
> "Make X conform" has low information contents (especially when
> nobody knows what the TD is), because nobody would try to make the
> code worse by making things nonconforming.
> 
>      Subject: [PATCH] column, range-diff: downcase option description
> 
>      It is customary not to begin the help text for each option given to
>      the parse-options API with a capital letter.
> 
>      Downcase the first word of some option descriptions for "column"
>      and "range-diff".
> 
> or something like that?

That's what this patch intended to do (from the diff).

-- 
An old man doll... just what I always wanted! - Clara
