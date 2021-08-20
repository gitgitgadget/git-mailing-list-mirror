Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC55C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8EF61101
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbhHTOmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 10:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhHTOmG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 10:42:06 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C8C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:41:28 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f22so1390123qkm.5
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xc/s6SNRPppUctOpMjYYtlARzKp3JFEZjiRVEYEWliY=;
        b=FRBDXYUBNe0SPTpqN7EJOikOFXHMXXf/RoXTxAHMTjWf6e+1ER4JZG3H5xMyn4r6DW
         Rz5p7NhiJlWbf2LyK+NUVQC5j/xYbqZJQGZr8Id+HeoCkl4Z9dJYMWzv+0rYtS+UsVEo
         BB5phEn7Vwns+TdyxQ7GH1CsaUSQ2Q9dl/GNcXBPhGje5e77kVaRio7dAaw+XfS1/Q9z
         z3E9zls8nPbco2Ra43RSpLYSc/oNvVt7eavbedjo2suVjowM/4IoIYXEjxOLDOVbMBeS
         mEsXzj3bSoS/aRrxLb5ExNfUGt+WNvQiZ1lq2oBREbZma8VcFxmK+Q5lpay7Q0vTxy26
         5Mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xc/s6SNRPppUctOpMjYYtlARzKp3JFEZjiRVEYEWliY=;
        b=fENONbK6Vx0C+JURVwcO9vte3DPH/bs1xtVFSck9jHMTevJNQApe5E8qfVX6K1U/Ib
         s8+MfezdtnLTUBw4wB/GJKovTZbOAD+chFyyHP7PyJ+dxtoNXTTk2rc/yEZ0PA2DN+Ig
         8Y4rmTSpVPR62ZKjk5A5BEEm2WDMNFlfc9c5wLiKNj8ojV0UECOmY2k7x/zHg4P3LKxl
         5vybD8tUdoDISNg95vgNf4ZcjBV1TD1wyVc0/Uuo7sZV76o0rm4mFBThXqrDS5Audlp1
         vNSP3kT6B6jeYBY+idR+Uoq3CcPQ2l5Aaa6zpOYmU4IxtaKFSCUK0WUPM6AHB/dbgxNV
         BHNw==
X-Gm-Message-State: AOAM530JmdJch0PrtPwacZjvmMC1993iWJgtlRt6z38FCk62X/Hop9Oz
        i/LvzCZCRYejxrCpUpweMEs=
X-Google-Smtp-Source: ABdhPJy+I3Ql8OzntEim4VO8Vd4JnVyGK+ComnREm7JppU586V2i+EUw2jruE20W7EEr9+WfzQV8qA==
X-Received: by 2002:a37:dc7:: with SMTP id 190mr9509683qkn.99.1629470488111;
        Fri, 20 Aug 2021 07:41:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id n20sm3396607qkk.135.2021.08.20.07.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:41:27 -0700 (PDT)
Subject: Re: [PATCH 5/6] fetch: refactor fetch refs to be more extendable
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1629452412.git.ps@pks.im>
 <7653f8eabc1eb9c26e06ad3efa3d7e19dc9547cb.1629452412.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f0da7080-1621-5951-1272-044e4bbf48b7@gmail.com>
Date:   Fri, 20 Aug 2021 10:41:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7653f8eabc1eb9c26e06ad3efa3d7e19dc9547cb.1629452412.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 6:08 AM, Patrick Steinhardt wrote:
> Refactor `fetch_refs()` code to make it more extendable by explicitly
> handling error cases. The refactored code should behave the same.

It took unrolling this diff to understand that this code behaves the
same, and it's because of the previous code using "if (!ret) return 0;"
to handle two possible ways that 'ret' could become zero.

I agree that the new code makes it clear that we can leave early after
a successful call to check_exist_and_connected() and again after a
successful call to transport_fetch_refs().

Thanks
-Stolee
