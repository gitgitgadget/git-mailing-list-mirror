Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759B4C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE4A61359
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbhDZUE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbhDZUEY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 16:04:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2D5C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 13:03:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j19so2263005qtx.13
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qgmU2IumbkoGFI9BPhSTBuqpY/wTMyqA4BZABPDubMg=;
        b=kuKivpaY9wrwVSJ+kaOSMrIRY30d6i5kN6gxfd5hFsSO4RRDURIveh7JedtbOTFfoC
         A9XjCnIxbdu3sgqjZm2yBO7Caz5UE0E9i5W5uPZ9av+JOsPripr7/SjTTJp8S878+vhE
         zzANAi1oII/an7G19CC2bwHNuMCRZKSQD51Cwr72ZJzQcbgOuvJo1XxdYrAbdBw/AAwB
         Hj/AlqV3icz4v6EjVMcTJwXwNNMC2IsHN/tnz2ypXnM8CEuI6KLlCq5c/maxVMVN5z2a
         XL6L8My6MvJHAP2nIIKMLdP/xR5/rfJ9gKAWbBf1d92fIwf81CsQPrDJDBHX72YtDfPy
         +S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qgmU2IumbkoGFI9BPhSTBuqpY/wTMyqA4BZABPDubMg=;
        b=OxlEFAWeK1So/cX05VZFdeU2nux7a4vvk1+fkimEQAau+UMdQ6atar5K7xN0OrMDhb
         idbLKLNUYyd8Y6k9yUynrCOH7+pdQs3xeX5+ez8xVyH+WJSvkXoFuhMk+xqLmtoWXobs
         noAwYRnViBbEWBU//T84m46Y8T0QRgGYqzdnhfPrSPTJXItijDlkniV+Wp7UKndALQLr
         wZwFMhYxibjbceheg7NAqV7punWZZHDHAQ/e48lRaG9lWVB4diqvfeZxhBZNtgwLToOx
         vVTl5pg98PqRFO3Z2oCqUsXvOWgvM0/dPJSlFoa3a1+3wMUhAyGxgqPWYqPCTQ1pn09P
         RPEg==
X-Gm-Message-State: AOAM530mujDrQ7yf+T33NXvZ+f5Ef0gUVLHZgOk9ph7V42/Evys47Cfp
        +ovfabtRSa5QbPofvse/Kfc=
X-Google-Smtp-Source: ABdhPJxxTUA7urQc1cEG4lWIN+s0LDzs9UAWpSaexrp/Aci2BhNdmvniBpsGVW/yCVScmjQcTFomaw==
X-Received: by 2002:ac8:678f:: with SMTP id b15mr2969086qtp.118.1619467418614;
        Mon, 26 Apr 2021 13:03:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65f6:360e:4aa8:3d0f? ([2600:1700:e72:80a0:65f6:360e:4aa8:3d0f])
        by smtp.gmail.com with ESMTPSA id h12sm12100833qtq.1.2021.04.26.13.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 13:03:38 -0700 (PDT)
Subject: Re: [PATCH 11/23] fsmonitor--daemon: define token-ids
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <304fe03034f8622aa8728d8872cc9bc539bab861.1617291666.git.gitgitgadget@gmail.com>
 <3f0c5c7d-8448-15ec-9e12-b2745d7bbf2b@gmail.com>
 <CAPig+cSNJYh-cTxghPiaAxKhYENDKbYO8jrdvoBsB3Eq0GYWjA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <171678f4-75ee-f404-4dd3-215616d08373@gmail.com>
Date:   Mon, 26 Apr 2021 16:03:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSNJYh-cTxghPiaAxKhYENDKbYO8jrdvoBsB3Eq0GYWjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2021 4:01 PM, Eric Sunshine wrote:
> On Mon, Apr 26, 2021 at 3:49 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>>> +     token = (struct fsmonitor_token_data *)xcalloc(1, sizeof(*token));
>>
>> I think the best practice here is "CALLOC_ARRAY(token, 1);"
>>
>>> +
>>> +     strbuf_init(&token->token_id, 0);
>>
>> This is likely overkill since you used calloc() above.
> 
> Not quite. A strbuf must be initialized either with STRBUF_INIT or
> strbuf_init() in order to make strbuf.buf point at strbuf_slopbuf.

Thanks! I didn't know that detail, but it makes a lot of sense.

-Stolee
