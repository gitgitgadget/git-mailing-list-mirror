Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3D3C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 05:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B144961964
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 05:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhC2Fpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 01:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhC2Fpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 01:45:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEF9C061574
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 22:45:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g15so9179784pfq.3
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 22:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I7gVQJWIAqIm7yu2v4XJNIFmezNuc2HtwndCQIY5t0Y=;
        b=HdiKIASztmpQi7TKGmpVfe+WIM1W1NpxNX55+jXGduXS8CylNQ7DbSZ1gjJcIHyJTw
         MBTqYit6F6qlpjUe2YP9S38iiMGmgD4Da7I1Psu05sxMDgpilPv2F0plebNgUijDzyoL
         zPn0jdkuRwjcI+mMigfGNdOfJ7g0KyZSMKuiByNZ1+sGuIl/fld0lSFJPXJ8337BOLsV
         Xa4+xeNjfR/0QsvTj1qelv+9XPCCylX7Y+OChgGlMZJRwkg0VIeHdHj+tc9LLORFrbbo
         Urx7uguEp98TnQeuKoc8thn65/2OcbQZjpRk2NMKrTGPTEETIAGXDhmAKFS/UYEuRkBp
         FVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I7gVQJWIAqIm7yu2v4XJNIFmezNuc2HtwndCQIY5t0Y=;
        b=EHFNmXW5IfVv95JgbDshlZRjQGV/SXvEpMbMelqZrhvHh9myL8FEYCfXAiY805KTjI
         5yFC0Mjeru0dPuMPCwnxv/pZPpbNsSbEKzJZOxb6UfJCOdVKNjcFT8T74hjCMVknVaB0
         RUaO0XkM1ZC7t0BNZxzW6s/B1sfZs31G5jTAvgdNb1DflAkZ2xyiGYxQRkbXGD4e/vEX
         C0Z3FiBj30tGlZLxnHf62QfrqbhVNZWlXM2BxkFPCJzLgy5gZ42dEY5u7F9O6y2bOOVY
         OZbY7a3ApidWfBPyXeC5mYC4HJf0PYXMV0BwYzbZZRZwqML4M+FXopQuld0XU78Ne/Jn
         EozA==
X-Gm-Message-State: AOAM530yHKkGkTVlpWcNEfUoUCcwD5jKhfJLU4hVxYa8tlKhou7Mtx2I
        YtXIPMe6H+GqzxfnJkswJ/F07eOPQYiqJF8+
X-Google-Smtp-Source: ABdhPJw0nxze6EhmuFK0g1scJokWI5OVlkakheWoP4FWcxuMQ9lzfeYpIO+80+bLaDEITXFcYNwAFg==
X-Received: by 2002:a63:770e:: with SMTP id s14mr21661737pgc.377.1616996236204;
        Sun, 28 Mar 2021 22:37:16 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-2.three.co.id. [180.214.233.2])
        by smtp.gmail.com with ESMTPSA id y9sm14170627pja.50.2021.03.28.22.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 22:37:15 -0700 (PDT)
Subject: Re: [PATCH 2/4] api docs: document BUG() in api-error-handling.txt
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
 <patch-2.5-8c8b1dfd184-20210328T022343Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7bbcebcd-002b-0c40-2415-d29cb7a6e3ec@gmail.com>
Date:   Mon, 29 Mar 2021 12:37:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <patch-2.5-8c8b1dfd184-20210328T022343Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/03/21 09.26, Ævar Arnfjörð Bjarmason wrote:
> -`die`, `usage`, `error`, and `warning` report errors of various
> -kinds.
> +`BUG`, `die`, `usage`, `error`, and `warning` report errors of
> +various kinds.
> +
> +- `BUG` is for failed internal assertions that should never happen,
> +  i.e. a bug in git itself.
>   
>   - `die` is for fatal application errors.  It prints a message to
>     the user and exits with status 128.
> 
Documentation looks OK.

-- 
An old man doll... just what I always wanted! - Clara
