Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71E7C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E823613E3
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhEGDdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 23:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhEGDdW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 23:33:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF28C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 20:32:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m12so6183030pgr.9
        for <git@vger.kernel.org>; Thu, 06 May 2021 20:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uEXZHfJeIoofkuvgbWuCJEAayz1teCZzj9QkB+TWE/4=;
        b=V/Xj12PWIyVgKuNo81SRW6BTkaPKwtTPXA5lIMOuM7UoCeM6N9FbV3e5q4Vaba1Ukh
         EbgFa/4aDavidO/mF6ORL6aSQ9O6VrVjDXprdzXdNQ80MJziB4zGDwewgq4/kgpBmr23
         Hx7RMdLsuStYvYWF7VQsb9ifoek7TRxVytto6beIVxNpKSkbJy3mw6fokdYjx5LDs4rb
         oFGeTQJ7i//moVAv/78IFxkbV/PxhkQqapYbqNy1WoL6d/mzthAQorqx4azco02IH0FV
         283s2pmFqopWJM+2T+W+yhDZf7F7H6vGtOJnIxuHudLqA5qYebkRS9m+7SvyPi10XMOU
         kkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uEXZHfJeIoofkuvgbWuCJEAayz1teCZzj9QkB+TWE/4=;
        b=ly4YCHxScjWO0u630j6mozR5xtLQ1qBKR2J50Va/mUZH8Ah7+Jxf1UBqHo9BvtOeKc
         bAYxd1I3d7hd98t+FVNQn/mxgFOZVbitXd8X6D3v4cL9/oW765EKxa1SgSquWnhlcDsB
         jTLSjkth/a1kje1Pm8UoCHeLz73mk7T8r7NQtIwTJXp09vstMTMeCut8mccNk3+Hs2Gv
         d68K7+v6451sDYIIb8FdzJlgYHsnPhiqVU+jSuKNjYB9G1S42+vf69SIK0b5e/wVZlXr
         j8IjLNIY91OBstapzTYK0JRu/i+fKIi/J6b/wpE4VKohy9Btt9ealxARBshMhGszLwhO
         dx2A==
X-Gm-Message-State: AOAM5317irLJfdrnVhcBMiEd2sySCO/VB5mpV8Tqk2GERTPUAH5Z4+ov
        p3sOT/dGjBsOMnS37R3rSIg=
X-Google-Smtp-Source: ABdhPJwedMrwuJpHkOeuCbybHMMOfzZWeBlrfVycLdIbWZp+gxNjK5kG2HFZRJXORRKQ4sKtF9IIpQ==
X-Received: by 2002:a62:f84a:0:b029:245:17e4:bde2 with SMTP id c10-20020a62f84a0000b029024517e4bde2mr7925861pfm.64.1620358341531;
        Thu, 06 May 2021 20:32:21 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-82.three.co.id. [180.214.233.82])
        by smtp.gmail.com with ESMTPSA id 132sm3152932pfu.107.2021.05.06.20.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 20:32:21 -0700 (PDT)
Subject: Re: [PATCH v1 7/8] doc/format-patch: describe --confirm-overwrite
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <20210506165102.123739-8-firminmartin24@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <e0bc4aef-a92a-20f2-0b9f-d65917710e3b@gmail.com>
Date:   Fri, 7 May 2021 10:32:17 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210506165102.123739-8-firminmartin24@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05/21 23.51, Firmin Martin wrote:
> +always;;
> +never;;
> +	Always/never prompt for confirmation whenever patches or a cover letter
> +	are subject to be overwritten.
> +cover;;
> +	Ask confirmation whenever a cover letter is subject to be overwritten.
> +--

For `always` and `never`, I think s/patches or/patches and\/or
For `cover`, I think s/whenever/whenever only (add `only` after `whenever`

-- 
An old man doll... just what I always wanted! - Clara
