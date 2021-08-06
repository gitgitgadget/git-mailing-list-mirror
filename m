Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A18C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E3C610FF
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbhHFMBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHFMBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:01:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B2C061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:00:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1so16267490pjv.3
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HqJKY+9W4O8WdtrSFNe4GsElo3Jcn9USCK0CtoE0kbY=;
        b=VqX3fJLUU1bovRIcQ3hE77o3ACeqznXWruq5QXx+ZlUtmSXyStCClbuz2M4WbBb0cl
         qMReCHiKpPRqtTCDWQsMFMjrO85KMrqxOBmvwIhsfpPd8cq9Yso/4Ij/Pvg704aqJOLX
         odrZqfhBmYEqYlKByWXg0kQLmhka92hKR+cZf4FqGo0bRhPP8vX+I/n0/LkruJO+XdQQ
         2kQJnXUyJDtzKth2FXnNF9+mEG3zjGJhjCVw4hnMp1kQlQudMGp8L+L2AToiCrjDcfhH
         Q9s2ZTQgYp1Y14gHLZ7HKNN9oEBfVOUkt6CBGrroVWwZwMQdskJdhS4HHZQ8Kn0d3CO2
         otPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HqJKY+9W4O8WdtrSFNe4GsElo3Jcn9USCK0CtoE0kbY=;
        b=GfuWV+hm81wcNI6w894saaps4OuYRhq5edJQDfPb+/53rA87bLHrVFlj62n0fsVjTT
         bhhMkLICeNTWwYlOq1GNwGxEtCqjznZTtBIQkzTOyNgzsb5S6oEpP/z0WWwAjWYZS5XN
         wVUNOw1O6rKa/cog+cFxSwEHmZd48INdGadLgZMZQNiwBTypzbhrQSm0aXJOgAaftbUu
         3CEOanoWUWs3dFHLnA7A5Sdm4uGUhF2cK48R3ZHa7cN3bFRACraFIdL/azNBlYk3GvQv
         Cwu2eZUcEH4iNipg3LScTFXiqLO/RpPFhhOFT1C5zUh1lzESsWiEQR3/0x3PHZwUdS/C
         UzUg==
X-Gm-Message-State: AOAM530aK8mfkyXT/TZni+1CGg34k/2Ug2a7mjkPRnciV777+9+8Nm5W
        95PUkAXI3Aw7Td+NJSYRZ6w=
X-Google-Smtp-Source: ABdhPJwTqYPywU9BT+k+daTLdovFARHtiSaJh81gQ3lYIaat+r+DUxitvqadZaq0JbQ+orM7KS0tqQ==
X-Received: by 2002:a65:44c4:: with SMTP id g4mr1074207pgs.435.1628251244496;
        Fri, 06 Aug 2021 05:00:44 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id q5sm9041130pjo.7.2021.08.06.05.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:00:44 -0700 (PDT)
Subject: Re: [PATCH] makefile: update detect-compiler for newer Xcode version
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com
References: <20210806080634.11869-1-carenas@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <8d3d5d2e-cad9-2b02-13d0-b6be1b96f730@gmail.com>
Date:   Fri, 6 Aug 2021 19:00:40 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210806080634.11869-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08/21 15.06, Carlo Marcelo Arenas Belón wrote:
> -"Apple LLVM")
> +"Apple LLVM"|"Apple clang")
>   	print_flags clang

Why not just s/Apple LLVM/Apple clang/?

-- 
An old man doll... just what I always wanted! - Clara
