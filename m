Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91F4C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 03:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A412961074
	for <git@archiver.kernel.org>; Sat, 22 May 2021 03:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhEVD4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 23:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhEVD4n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 23:56:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69395C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 20:55:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x188so16338897pfd.7
        for <git@vger.kernel.org>; Fri, 21 May 2021 20:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7jTTUJvTTkm1Ezva9gQMVAeHSnmLlm/iPlHO3qlYyxY=;
        b=Dddwzg8tjaQ08cvIHKefD5P9MH7a/3pw2uYC2PpHA8OlQQ8HIBVd3cC1G4sx0CaEQl
         lVf99MxOSBi5USlVAOCQgUF/qNG+gjgO5Hiyyz8hqJ+g8nz9fc+yuKLHmUhu/ZzMdiR1
         sH5YmiyVYdH9b2Qiy1t6kzwYY6J4f2WI+l21mPM+8TZvbtqYPZbMhfGJ6fZcNm9LkrxH
         NW+GHhRgzcT2igZu+6evY7fOu18a5ah1CnQ455DvNtXxT2UW2dTHOcYOod5X4L2HhLla
         cMBXF433uFrCxI9oCfVIaTtecf7xXK81qJm/Q0suBoHvF1/AEkyq8ztvMYL/HKiuFrWJ
         Su+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7jTTUJvTTkm1Ezva9gQMVAeHSnmLlm/iPlHO3qlYyxY=;
        b=WIb0TTHJRECQCYIK4hODAl4nULjAFsvlVe7CEhBiqiQXKPmG/lDme5L+8OqmbrflFY
         posnWQWGIQApPpDLgi6la3dCns63TaUx3MulXaJn4hUM4yGCKxsVlG2g2PrGYS2hWAEY
         I2u7TPUQRfgC8VT3/BjvF2wlvrw+4TyqCoBeskpVitGXY6+BytImS7xhPORR7Dd6FklW
         SFwAOXMW5TULQ+Mfuv7c3bcSg0jmZtAZjt0NxIn32D2Ansf5XaFdRCQc63PSFvCg36Is
         WU5n6WUxCH6bLbEcvWE6c7QPYGaXZLvaekkphrIrcUxqW4A9A2uSNpqnL/ju+3t4Dacc
         i6Ig==
X-Gm-Message-State: AOAM5318hPccNWB8ljTP5H9J77ZIC04Sc079WMgbz0ExfxczK5wMzKC5
        dphkdeDiYKpoExVMghKutUdscGLKGz0dtw==
X-Google-Smtp-Source: ABdhPJxmlatQmOVRLRQ0DrIQKmvYFVxsBrquDl+2pYtbXqn73E2qndtYvQsb6kX2WjbNRUEbiGAEXQ==
X-Received: by 2002:a63:5a43:: with SMTP id k3mr2103304pgm.308.1621655717738;
        Fri, 21 May 2021 20:55:17 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-19.three.co.id. [116.206.28.19])
        by smtp.gmail.com with ESMTPSA id k7sm9768774pjj.46.2021.05.21.20.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 20:55:17 -0700 (PDT)
Subject: Re: Formatting options are ignored when tracking functions
To:     Philippe Blain <levraiphilippeblain@gmail.com>, aidgal2@gmail.com
Cc:     git@vger.kernel.org
References: <EE7D39E6-D826-49E2-AD0E-090A83DFDEC1@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b3035e1c-79fc-e285-fd0e-fca246ae5190@gmail.com>
Date:   Sat, 22 May 2021 10:55:14 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <EE7D39E6-D826-49E2-AD0E-090A83DFDEC1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On 22/05/21 08.58, Philippe Blain wrote:
> Hi Aidan,
> 
> I believe this is working as advertised: only the first line of the commit message is shown.
> However as mentioned in the doc, the -L option also triggers patch output (-p),
> which you can omit if you explicitely add --no-patch (or shorter, -s).
> 
> Cheers,
> Philippe.
> 

So the complete command for --oneline with -L in order to produce similar
output as other cases is `git log -L:<function>:<file> --oneline --no-patch`.

I wonder if we can make --oneline implies --no-patch when -L is given,
right?

-- 
An old man doll... just what I always wanted! - Clara
