Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F839C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 07:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B56B6113A
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 07:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbhIQHnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 03:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbhIQHnW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 03:43:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B099C061764
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 00:42:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e16so8423039pfc.6
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l+KCuYOaPEMzOmt6OxsS1Bw/iHc0aPO9P6gSBDN+h0s=;
        b=lEDyKcuKh5Mx/6OgBlAZWg2yp1QDrlZfhEo4Fl7jCPScxjagah23AVJC3P6uwkw6+Q
         OJU3XI9cIzZEA9WGyGPPvT7y1daRwwkyT9WOUft42NRFdV99t2ZioUZUlG9J7ENTbK2L
         R40gRT5i490tOnI1CMb1Z1td7G7+ywW+nBEJUux57lLz76tw1WiYYEkDZ4vLbcMNbMVT
         H0cdNRD31dpc8m+ReHpPtBJYJKuUa7XE0J2BXNfPImi+rfedQ1t0OvrPpga9v029gATE
         wN2lAQL1FaKWyxs/czakkAV9ODSdQeskkxahmu/yYPZzBGSA/a69hs8nMvrep5JI/Cj2
         AfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l+KCuYOaPEMzOmt6OxsS1Bw/iHc0aPO9P6gSBDN+h0s=;
        b=sWamgk0Cyg/mo8G7MzrtAgJRVpkLFMPwUHjMGZkb9hnKvhF/Zqd2rBNNOVO0qokEJu
         1+rhu70q+zZVNhoGx56BgsikxnDukUwWByNEcwfPHU8kNkqc0tvOB0KvTjUMpLe2eqH7
         dwt4fV+7UunuR4m/2g+SYPpeTY50G5NXVDgpHuwubr13iO+vTYJNWUef8iFmx/9PfYo9
         qSSudzPXae/+zxFaQF73SmlPKWT0iC7Eaugli2BIIAJ8g5tpjlddp0Je3nNvxEjrqoz6
         1eDXZ/JX+QvZ9jMHXIP1p9eHK+uJ0Ha6G8DHhJH2lUTajkdOgYyR/vle/fNQRq0u7YHh
         ED7w==
X-Gm-Message-State: AOAM530wTA3/Wg6w2AYEbPp3zSFAhcFFF/mqX05vInpNDPERDp9Kfedf
        TgbFAT7ftkFBQW+rjwDbhF0=
X-Google-Smtp-Source: ABdhPJwz9/bAlMPDLVsMFIVNCqoamD769ZqWfeHoAXee86MYHGcPY/zR9G8JdevfvZpaiCA4kbalcQ==
X-Received: by 2002:a63:5413:: with SMTP id i19mr8638642pgb.297.1631864520012;
        Fri, 17 Sep 2021 00:42:00 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-51.three.co.id. [116.206.12.51])
        by smtp.gmail.com with ESMTPSA id l1sm9693048pju.15.2021.09.17.00.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 00:41:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] request-pull: mark translatable strings
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
        vmiklos@frugalware.org, bedhanger@gmx.de
References: <20210916113516.76445-1-bagasdotme@gmail.com>
 <20210916113516.76445-3-bagasdotme@gmail.com> <YUNKIj44AlW0tkXk@danh.dev>
 <xmqqbl4stg91.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <187b4b89-e037-6103-08f4-870ce8f1e4fd@gmail.com>
Date:   Fri, 17 Sep 2021 14:41:56 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqbl4stg91.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/09/21 03.30, Junio C Hamano wrote:
> So a good middle ground may be
> 
>   - allow translation, like these patches attempt
> 
>   - introduce the command line option "--l10n=<value>" and
>     the requestpull.l10n configuration variable that gives the
>     default for the option:
> 
>     - when it is set to 'true', end-user's local taken from the
>       environment is used as the target for translation.
> 
>     - when it is set to 'false', translation is turned off.
> 
>     - when it is set to any other value, the locale is set to the
>       value of that variable (imagine a Japanese developer
>       contributing to a German project).
> 
> perhaps?   I dunno.
> 

I'm leaning towards second option.

However, I proposed that --l10n and corresponding config 
requestpull.l10n just take locale value set, and defaults to English 
(en_US or C) if empty.

-- 
An old man doll... just what I always wanted! - Clara
