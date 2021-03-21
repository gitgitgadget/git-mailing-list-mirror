Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EA2C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE3C60C41
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 10:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCUK54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 06:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCUK5l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 06:57:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEFAC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 03:57:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e14so5071175plj.2
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vBmH2EmSvlBAgIt5JEEtTMPBLYNpT+ZJev0/45bfWhw=;
        b=HIzYEcdQMiFxyZysn/IZpu90J8OjfHr4qJZ8Rd42CsYxUExqMuV0RsLiNGU2XAjyXC
         sDTDMNLURhEOw/gLMy4Mqcj95cIR3z+DmuFANaDgr3DOW4ITnkLBVN2l1j9V9wxZdWKV
         wcWrlfnnme+3LsX2g46LAcUwJv5z8JEm/S5wYM99jQuoi+WsCxf1kaFWziHD/9IH5Ztr
         /1qV7F9v40oRwhaLQxa9NJrQSmzbDYBZUN2Mvteq6RpcbMxEnJffH4Dhhm5UmBfLZA09
         RmFSBxnRHVmF5cH301dSH4FtdcymzYTkje6JYrxFiIVmTakmT2SKwUTPsmt6fcu3vJKH
         nvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vBmH2EmSvlBAgIt5JEEtTMPBLYNpT+ZJev0/45bfWhw=;
        b=UcXa8yxwhRv9TjDY3c7jA67XzDwowdUVhwuqaGaxOdhJfTyhdnMMwudi5dmE09ewaL
         a7f8PFmGsCpi5voFP9V+0uYpDe9YutCnshS5qftE4/R2EypBLdU1mfQU4E1rckUBy3hH
         4+zLkqT94hJ/6Tu2SqKlLK3IAC40DPNcDQfqA+M6CWwpqZNeyU6mq0s90KUWo8fHB6Ym
         P8Bf8Hn7OznR08GsPKLOGfpuMK5OiYCqo1oZiif6apmKIiE6vlmIqNy4bB30GzRqF0S3
         cappbS2v+UNfxaf6ZVEL2IhPJelpKtqwW3wsPDE1Sz1kzrVEaUySRab7jP5vM6UFZ/im
         QnPg==
X-Gm-Message-State: AOAM530tcfAMZgS0Z+043PHr2cJvwXxaCtBFmivRX+1B4lAEEla+cyc4
        2ax6Mdejuispy32UplSva9Y3C0PHnAftUsui
X-Google-Smtp-Source: ABdhPJwrdTOdzeYA1BOLTA78uOkJwKCnjXybYy4i/uXbwxSeDXgCqdFUgQwaYW4LN8arUeT5UsV0WA==
X-Received: by 2002:a17:90a:498d:: with SMTP id d13mr8037392pjh.47.1616324261009;
        Sun, 21 Mar 2021 03:57:41 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-71.three.co.id. [180.214.232.71])
        by smtp.gmail.com with ESMTPSA id w15sm10332102pfn.84.2021.03.21.03.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 03:57:40 -0700 (PDT)
Subject: Re: Git Tools Reset Demystified
To:     John Yates <john@yates-sheets.org>
References: <CAJnXXojdM5dyergCqhq2FR3Sf8fxQHzfenWgFfZR8KAZFE9TAA@mail.gmail.com>
 <CAJnXXohF+sBs2Kjf8HeC9KKWiJ_g+Jg+C6hTRpX2LQvENeunEg@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7312b8d8-0670-380a-aeaf-368e8b776110@gmail.com>
Date:   Sun, 21 Mar 2021 17:57:38 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJnXXohF+sBs2Kjf8HeC9KKWiJ_g+Jg+C6hTRpX2LQvENeunEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 21/03/21 09.50, John Yates wrote:
> https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified
> 
> I found mapping between the first image and those in the
> remainder of the article disorienting.  I suggest adjusting
> the first image so that it, just like all the rest of the images,
> shows, left to right, head, index and working directory.

Hi,

This is Git mailing list, when people here discuss about Git development.
Bug reports concerning Git are also reported here.

It seems like you're opening issue for Pro Git book, so please instead
head to its GitHub issues tracker [1]:

[1]: https://github.com/progit/progit2/issues

Thanks

-- 
An old man doll... just what I always wanted! - Clara
