Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C1CC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9427020772
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN5htKK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGILVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGILVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 07:21:47 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D821C061A0B
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 04:21:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x62so1340656qtd.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tq3c4LQZ4wb+puYvwyT3LVSbi5ObHgUbaXBWYmbl2DI=;
        b=WN5htKK+8uUovpy5GpDwykAbIs6g2mGAbDQdQfsbJmxRdEaDhY/p4pm1Vp9mL2M38g
         IrmZjpcvr2RxnJMsL6YJxkyxL9zGhFnrbLbXmYHo7GwZMWhtJhrBi3trO3M2Zp6nxdDw
         mQr/CyWlV+T2yX+nGkyZWOC43BdniHne7IsZ7+LxDoip2sSxfjQNnLAo1pLVVy8B70tl
         4alccNR3PQM/wFs0zCW/KIHCaee/bZtscMuVP2cz3vppUsI3mEBwtmCixu43Lxvul0r5
         GSu0vsCXqbZj2SmL90IoDH7Cwb7436v6SH2FFOYLch1OVqs0AuixbW3hJEiNv7syZQ/x
         zkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tq3c4LQZ4wb+puYvwyT3LVSbi5ObHgUbaXBWYmbl2DI=;
        b=XGV+CThqLjGJfRuFxjjXqp7lkBURaDrp87ARyGoazKjUAdCrfVXjJ4SXiwQYhIGQvh
         aEmKP4zV4RlGs+giHpKAK4E0p1G4Z2XLXaWAdKuyQY7Sq0nOVJ5sCeG5rE5s2sAjOTP6
         ZTFXhtD4cxYWzBkK/AAz9QpHCgklZSJQ+9prevCzqVunimcW3dpzPXcQgfW8r57in+xy
         h8Hb8fpyCwzikg4Y8PWsVM9OAL12Q7LOjnKHBCG2ZKEPLVxg0VoPlW5aYihejpMr3UfQ
         RIJNgX2ftCTBBAlccREkGFZ5NsZ9SqTyf9fcWwSJeYeEIkM7rQNQGWOItfNuzm1J2GJZ
         gJjQ==
X-Gm-Message-State: AOAM533v23D8tLBlAgofibF/uQe49ieIA6tBMy1fT8psKVqd6P1T8V4Q
        pWVFAQ70PsrK8snGC3FEDMdJmt6aq6E=
X-Google-Smtp-Source: ABdhPJyrpqk1oXqtUqJ5Jo8ToJNSqfl56lZTDqj5WW2b32ItcU/cqmf/qbMvSd0v+Q3uqjUrhqzsMw==
X-Received: by 2002:ac8:87d:: with SMTP id x58mr6303358qth.28.1594293706359;
        Thu, 09 Jul 2020 04:21:46 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n64sm3292523qke.77.2020.07.09.04.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:21:45 -0700 (PDT)
Subject: Re: [PATCH] gc: fix some sparse 'symbol not declared' warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <9c9164e2-0fff-7211-a79a-f4c546d2cedd@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1acadbb6-3c28-0ce0-7578-a0af2b034a3c@gmail.com>
Date:   Thu, 9 Jul 2020 07:21:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <9c9164e2-0fff-7211-a79a-f4c546d2cedd@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2020 8:23 PM, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Derrick,
> 
> If you need to re-roll your 'ds/maintenance' branch, could you please
> squash this into the relevant patches. The first hunk should be squashed
> into commit a138b8ff61 (maintenance: create basic maintenance runner,
> 2020-07-07) and the second hunk into commit aca963ff39 (maintenance:
> initialize task array and hashmap, 2020-07-07).

Can do, thanks! Sorry for the disruption.

-Stolee
