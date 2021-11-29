Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B2CC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349752AbhK2SSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbhK2SQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:16:03 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11258C03AA23
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:44:51 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id m6so35044917oim.2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ppWMoG9GxVKSlkfECckllCkY0nm1hAHgd4ivM1vGAew=;
        b=XbMP5ONzNgByqaTj3iyqjze+HRl2R6yZf8e2tcLb/90Oi+vb6pOnDMGduWkyvxYm7A
         EoOnOG9+QnYYM4N5hqlHWvIsqhunS3hkr1gA0U+YiidPu7TrFEQ1sE/RV2vSmBD5MJdk
         GIcjSMMQmnEOEUUw4NmqeOVEfZYZcrp5jBo9m+dfvesKRnvzH1hg2B8yMowiQXacD07A
         PFCe1soiWbh19RF5umVRPaezPGjWTZ6V5zHsidqE8wyiHt6twrLoAOch9J4d75u1wY9b
         6rI7Eye0AfW67GgGZH2Y1tPahQDS9BoSULp232mshQjr9ZtXMMLTVweLyzCvkH/jZ6Yi
         vFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ppWMoG9GxVKSlkfECckllCkY0nm1hAHgd4ivM1vGAew=;
        b=7++0OkTR0wLtmmcRh8XbKS+BH5PRLZk7HvDf+QwZ+Fa8ounOrTcBCinR6drBqdJInP
         X22JDkbvn5/jFZWL2aBDhfN1UlR3+FPgBpuK87SwerNeDfPDZv/SeBVsIKnckB1OZlK7
         Bqd+R4Uen7yZp5YmWxJqVMXsZyLx/Hru0EpWgUp9j/3xQm7ywR5/H51jw0gKv4wSbBt/
         n1y1YegYc1q6qWToFmb7c7mVfWaesFZEnOzYrhFB7HHq4JvdH7Al86LA9pU9oXJpMcUS
         n7KxwkAO4C/GOgNLtVANCTo0Bo/uPgVy2SHJBf7li+PNqt4d2eyGMySzVpyrtuBqVd6u
         BwUw==
X-Gm-Message-State: AOAM530XZmNupBTN5+AlnFcBWWh1Mx8sEzjAgZJ/sfjmA7nFt/aYiQfb
        ollpg/yvWJwMURqP7aXo8g0=
X-Google-Smtp-Source: ABdhPJxY0oY6DB1KwNcNSejz+WeXySHAjCS9oL/f1eR8i3CCdWpUKGF3dWve6YpwBMvmMF7JZG6Zjw==
X-Received: by 2002:a05:6808:1a88:: with SMTP id bm8mr40961909oib.159.1638197090390;
        Mon, 29 Nov 2021 06:44:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id w80sm2999117oif.2.2021.11.29.06.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 06:44:50 -0800 (PST)
Message-ID: <3afe7a17-bf9f-1191-5ed4-407f4f26b9ed@gmail.com>
Date:   Mon, 29 Nov 2021 09:44:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/4] Fix LLP64 `(size_t)1` compatibility VS C4334 warnings
Content-Language: en-US
To:     Philip Oakley <philipoakley@iee.email>,
        GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20211126113614.709-1-philipoakley@iee.email>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211126113614.709-1-philipoakley@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26/2021 6:36 AM, Philip Oakley wrote:
> The Visual Studio MSVC compilation reports a number of C4334 "was 64-bit
> shift intended" size mismatch warnings. In most of these cases a size_t
> is ANDed (masked) with a bit shift of 1, or 1U. On LLP64 systems the unity
> value is 32 bits, while size_t is 64 bits. 
> 
> The fix is to upcast the unity value to size_t.   
> 
> The first patch has also been reported [1] by René Scharfe as an extra patch
> to the rs/mergesort series. That patch had been on maint.
> 
> The middle two patches are similar changes, though [2/4] is a uintptr_t.
> 
> The final patch is applied to object-file.c, which has recently been
> renamed from sha1-file.c, so couldn't be applied to the earlier maint
> branch.[2]
> 
> These fixes clear all the current C4334 warnings.

Thank you for these changes. They all are obviously correct.

I had one style nitpick that you could take or leave.

> The patches can be squashed together if required.

I'm fine either way.

Thanks,
-Stolee
