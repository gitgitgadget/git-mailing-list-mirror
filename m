Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436AEC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 06:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058A66192E
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 06:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhCVGCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 02:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCVGCE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 02:02:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3CC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 23:02:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o2so5974917plg.1
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 23:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ws/jnOT2QLUgSny3kdPhMtaeAVAKjAFbEirDx4tphL0=;
        b=ZhwyNpS/R5uwOQmMKzHc5p6qCkcxMzz2Pz3o6ZkAF9+TKJ0msM26hmUsY30X++Totv
         kFbdIHZ9wOkaqc7n8ViGGjntsKS8KuHYssGvGeSK6MCWNv8tCPbU+8SvzXGgdcRZjA5P
         scpl45eenZNGCiIAcU3NjbpR38ip9nvjfXxdcqUfWfVjvbv3YX5dODccaTq3FXms+84x
         6s4Quv76XDSz2xEP+IN7SgNX6MRXtf9H4DTVY0D9rKUp/ddejPj3iN99VSVWaL6V8VSC
         sPmcehavgtX2N1W1JT8OSKl/PkbW5hWnRGoVmYZn4pM1TtwEUI/c3chxIqAurFsPx7Y5
         SNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ws/jnOT2QLUgSny3kdPhMtaeAVAKjAFbEirDx4tphL0=;
        b=C30wc89vm6zmzEMumI46OkGbISFAKMIGTv4ceU+9ZA38tMTmecTofcrTAB39+sSgzj
         7jLaGBBaCqvX5LYgzoL6WYxyQY/SrS2KCzuCIIqOhyKJqDKbItUDssi6LZ4ZtpTUxut8
         N7XUOGGnb4NuVrqvFqXfM7iMiwutMf7CWvfQa1q/OfvhY6fXSRaQsswJI1BRFUQIEh1G
         AB6ijui/O1hZyzJsh1HUSDBsTtFF32423cI8N+HQo30REHxgfbm2nwLFPzRnTH5F6tXI
         FKFkVlbrLWHteyUBdb8U2xkXstpLdVBp51j8xySZlpZ1tEgyX5XZDQTEsr56cyhEPa91
         9g9g==
X-Gm-Message-State: AOAM531Ad5GDRmg26ZCwmDtWP/RlFacEstE4rJGJplLsTqCNFYLfQnjk
        KnDLbuQgmtJZRNwvtMq05dDFWKM2yz7vIcgW
X-Google-Smtp-Source: ABdhPJygJs3ktDTFSh1rZLeFrdFwrK6qbns5NvK9uC+wUmAw9bLscT5zJNzLDfWU3phWfJDyDM4YGQ==
X-Received: by 2002:a17:90a:8c86:: with SMTP id b6mr11810733pjo.8.1616392923320;
        Sun, 21 Mar 2021 23:02:03 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-16.three.co.id. [180.214.233.16])
        by smtp.gmail.com with ESMTPSA id p7sm11016235pgj.2.2021.03.21.23.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 23:02:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, git@vger.kernel.org
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <pull.911.v2.git.1616317134.gitgitgadget@gmail.com>
 <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
 <1722fbad-6ff3-444f-ad3f-59e37b640fc7@gmail.com> <xmqq1rc8cv01.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <47e8a13f-ce96-f3f3-0f8e-efd685f58e60@gmail.com>
Date:   Mon, 22 Mar 2021 13:01:58 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqq1rc8cv01.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/03/21 23.49, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> will be in the trailer (for example because <email1> is primary email). So a disambiguation
>> prompt should be added, something like:
> 
> No, it just should error out without going interactive.
>

I mean the error should be:

```
error: @batman match multiple identities:
1) batman <email1>
2) batman <email2>
...
n) batman <emailn>

Please disambiguate by running "git commit --trailer" with full identity, like:
     git commit --trailer="<someone> <<email>>" <options>...

```

-- 
An old man doll... just what I always wanted! - Clara
