Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE20C433EF
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 03:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798A261100
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 03:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347767AbhIYDRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 23:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347678AbhIYDRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 23:17:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2207AC061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 20:15:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bb10so7866803plb.2
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 20:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/+yEQs7+9KD+5Wag0Enia0cQ/6LGDcc/FZarMfqCqkQ=;
        b=aqFC/sTzWwnHmfb7CBCcPFkKALJOnuZ8Uoax4cTcov0yhomuSwiYLF3+IsOYOAPcph
         TsOiTrTvbNXHwme92fx3USoy/SZC/uaaf5FcF38e6YvVTzspn4mvMNsfTclS2ynDTU8C
         DqXTz4ucSvQM5qqWcwIHh4EEFa4YUEtcJwK9wLOBLorOvJVvqYuDeKMe4CmBu/i3WkYa
         xwcGgeA7Gi2IorOeZu1/bDLHeLwaWrCBQXYhmirNkdZVWdjLNiM0IKD5ZqtccCz6thJ9
         PTsWBGArObD1DJeQ0O8N0bG34J8JwNzu8rYEKWqLIz8r3EuzIb/+uVerzyXT5Q76Btue
         FNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/+yEQs7+9KD+5Wag0Enia0cQ/6LGDcc/FZarMfqCqkQ=;
        b=LECCQs1XV1VCYB+bc3uzPBPEAi8VpGicL6QcZjxMHD2Ob/Edt4iHxuDwl23zjJGNjX
         bdYZMKEwcbJHX5FJPLgcoB7rr8MINWhBhFVjn00u2Dw9jx23/OVaM2Fp9aE86uGw9e9k
         D/8yTFOyeILpz5Ref88QsLGVrfbigTruaeUR4MtDmekJcgM8eo+pD0cgPKzTNxEzQ/DQ
         0wtH1+QySz/e+jbKEnAshSxVTi+s9wJBKwz8ar0WwFZqu2a7wW/vUC/RXGsJ6lyM75vR
         hquz/mZJ9IzO7Z3skHIW6wvhh0QfzMrhxKdCQ6T+cY0T9aiQIk9+COSsKbNWp7VKdYBc
         BJLQ==
X-Gm-Message-State: AOAM531E1fyVA63XLgRgZK76UAYiCpk0Bwi77YFfX9/apNmNpmLPZDFg
        2HuzlhTkFUbi6NZcWkXrRu0=
X-Google-Smtp-Source: ABdhPJwqPQ8xSPbZ4XTh08y+fnTuc3yofRqyaR3uUDp//ZEzUopzWP9reA+Lk289swNf5aawX5d77A==
X-Received: by 2002:a17:902:710c:b0:13d:f226:2e3b with SMTP id a12-20020a170902710c00b0013df2262e3bmr4455913pll.83.1632539731465;
        Fri, 24 Sep 2021 20:15:31 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-88.three.co.id. [180.214.232.88])
        by smtp.gmail.com with ESMTPSA id y3sm9746409pjg.7.2021.09.24.20.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 20:15:31 -0700 (PDT)
Subject: Re: [PATCH v6 3/8] core.fsyncobjectfiles: batched disk flushes
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
 <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
 <543ea3569342165363c1602ce36683a54dce7a0b.1632527609.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <e8244ef1-dbd3-d56d-b9db-1e67114538fa@gmail.com>
Date:   Sat, 25 Sep 2021 10:15:27 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <543ea3569342165363c1602ce36683a54dce7a0b.1632527609.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/09/21 06.53, Neeraj Singh via GitGitGadget wrote:
> At the end of the entire transaction when unplugging bulk checkin we:
> 1. Issue an fsync against a dummy file to flush the hardware writeback
>     cache, which should by now have processed the tmp-objdir writes.
> 2. Rename all of the tmp-objdir files to their final names.
> 3. When updating the index and/or refs, we assume that Git will issue
>     another fsync internal to that operation. This is not the case today,
>     but may be a good extension to those components.

The 'we' can be stripped because only point 1 and 2 that are 
subject-inferred, so that subject needs to be explicitly mentioned, like:

```
At the end of ... <snip>.:
1. We issue an fsync ... <snip>.
2. We rename ... <snip>.
3. When ... <snip>, we assume <snip>. (stays same)
```

-- 
An old man doll... just what I always wanted! - Clara
