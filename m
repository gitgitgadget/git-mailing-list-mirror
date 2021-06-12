Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE2DC48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8480611CD
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFLEgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 00:36:52 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:39930 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLEgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 00:36:51 -0400
Received: by mail-pf1-f171.google.com with SMTP id k15so6083430pfp.6
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 21:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zukXmWI6ADsbCbLXctvsONVlMgp07kq8R5J4+EdjkAs=;
        b=hiOPYXxby+ZoZx01SBR47DTcqLHxXa68RbFw6QCwrKEtHTa51o1XhF1uQR27qrO8J9
         A/8kLfohDTCBH2HI/s3+tA/OB0doKzOSodOY3j2Qf3Ry67a0h+rAVKP/9OnjM+wmNPmK
         mw7yYpca6wu+0zDZALxUUxBNuEA7ZzPTv8llYitfTU/socmgYZKXRrDbs4CceUhS5uup
         q/PgjpaobB7SdWOG4M2CzkzWDQhHxXQczI72hm5jGfiHEzK4fbye/KBk4swzcD1P/1hg
         ZMzpA3R96QvXXUUscYputRMIHT+hfQak6Yyen7YFzJrja6kJfPSMSRk7VLAHECabQw+w
         5o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zukXmWI6ADsbCbLXctvsONVlMgp07kq8R5J4+EdjkAs=;
        b=Ng3h7PainDRohI/mqRRXvZdUdnao4jjz1E6ZwGPohw9M+RWkJo/RJJ6jPO6h8kZzv0
         GGJb8gVMUE3E/OBQg7/7MYhg5fXcgU//0nvhmx0vdpn5/NExfpmHmDS3MRmIxfmmPicQ
         bVHDTL9CH8dZuQpvnpZfwG5maPs2HCStvCuMIQzLQ36UoaEO7zWWA0fZ2wN3S8xDXYPj
         LwlFl73jepNEYl0+YlO02d3lAnBtUhj/SmLMsnN4vkpBkXckmhVLoCsb0mSGZoA951ux
         kv8ALxbBlIsP8F/13COvgn6BBt6HIgLh49izFM09cGmKOHXktk0DeL+Ta6lmPrgkr5ib
         rbdA==
X-Gm-Message-State: AOAM533PviuHTv+G+4rkCSpNB6isnw4kKP3YHK3hDfyjMhXipZfJRUWC
        Q973WonM2LANBfAiWIA1PhU=
X-Google-Smtp-Source: ABdhPJyeGCgyh+OBqgLJbtWJCMYaPguflYgpY0+S0OfxZXNnsINVxmOJm2b7KfOIBj3QrcPOAFCXYw==
X-Received: by 2002:a63:2f05:: with SMTP id v5mr6741724pgv.449.1623472432660;
        Fri, 11 Jun 2021 21:33:52 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-78.three.co.id. [180.214.233.78])
        by smtp.gmail.com with ESMTPSA id p17sm11684084pjg.54.2021.06.11.21.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 21:33:52 -0700 (PDT)
Subject: Re: [PATCH 3/4] t6400: use test_line_count_cmd to count # of lines in
 stdout
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-4-congdanhqx@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <68b41d84-e9ac-6cf1-184b-5ce9bbfbb18e@gmail.com>
Date:   Sat, 12 Jun 2021 11:33:49 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210612042755.28342-4-congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Đoàn,

> -	test 5 -eq $(git ls-files -s | wc -l) &&
> -	test 4 -eq $(git ls-files -u | wc -l) &&
> +	test_line_count_cmd --out = 5 git ls-files -s &&
> +	test_line_count_cmd --out = 4 git ls-files -u  &&

I read lines above as "Formerly I tested that 5/4 should be equal to 
output of git ls-files -s/-u piped to wc -l, now I do the same with 
test_line_count_cmd".

Am I right?

-- 
An old man doll... just what I always wanted! - Clara
