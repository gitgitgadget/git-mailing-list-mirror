Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE4C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62C620747
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 14:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoZIkUPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgFNOFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNOFj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 10:05:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD7C05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 07:05:38 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g11so6588116qvs.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QTMu2h0ey2fmmYCbmk3Dza/hHNaYEoEaap8Ef34h6Wo=;
        b=SoZIkUPK61/KXflCMPAy6O/0aRywuQVprgy8xTahxWX2oReVnD8JwsOvAhlGspTcTe
         SHse6mtijHPbOLRStnACNy0g4dIzS85+CpODwmmIwkz87YJTmVXq0f5A9bAHio0QrVD6
         EGQisvGdEJAU4mZrWXpxB0wF+fos8sa2cFCGEy3jKj8nXiEtcOHNiOa2HqfWlzj8k0aB
         WC8U1u0rTYhGMShYd1DFnhWueV7EnuvtQv5lLhRhZlrV0vn84CXawFuNui/2OA+bPEWg
         fi9vs/YCdltKH5BE0Ny5TN0toZX0KcsmeQ++AXu0uFYBH3wBkvMdtoO56G6+KO82aVER
         i61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QTMu2h0ey2fmmYCbmk3Dza/hHNaYEoEaap8Ef34h6Wo=;
        b=PHuk51tHATNrRsbedo56EoIfmoFqc3kTHX/4mpEfTNHEyS1Oi0VWVjwELOKUA25Gis
         CsP9e+ZSzIdUR4sNgwE9G47MPb4r3J5vIIgEzUqqCaRahYer9mcNyLjJbOp1yRIdbw7M
         z0iqRQwPq9H07BMJ0Ln2VkbygemLG85fhO28rAS7E1yC6kDIiixKPnQgkV6C5Acman4E
         b8/n5OMs5a8BK2o8AnZ/++MM4fgRCNd0x9Qvi9dQzKLIOIkivS0JuYiOeaVWChRfue2X
         /x1an+9szmgPThUXE8KtA72ZjmjpM1Cvlon2W6o+F9kTyVG0esHy9HtqWipfFtcbBlIW
         u2Ig==
X-Gm-Message-State: AOAM530FRTFVV0i7SYo4alAqLxGA3khHVYHyZJwIk+ETBjBPhpliDyD0
        +Vu8ORB/KJAIOjhtg4qUXXI=
X-Google-Smtp-Source: ABdhPJwigb+Xa+m9xTzt60NPEijbkfLss98VsDQFRHLdRA5xZ8rlXxvlZksYfCJPvsB3hsMK5JN2/w==
X-Received: by 2002:a05:6214:1267:: with SMTP id r7mr20524958qvv.18.1592143536628;
        Sun, 14 Jun 2020 07:05:36 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id a191sm8827885qkc.66.2020.06.14.07.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 07:05:36 -0700 (PDT)
To:     don@goodman-wilson.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, msuchanek@suse.de,
        newren@gmail.com, philipoakley@iee.email,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com, stolee@gmail.com
References: <CAGA3LAfqzBsn91YTYaCT5y9XLeNLY_0B_7b1f3fdc6X4JOU81A@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <f36ffb6b-94ed-b8ef-6f7c-011d65785afd@gmail.com>
Date:   Sun, 14 Jun 2020 11:05:32 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAGA3LAfqzBsn91YTYaCT5y9XLeNLY_0B_7b1f3fdc6X4JOU81A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

But YOU can force other people to engage in YOUR values and YOUR agenda? 
Why do you feel the need to coopt successful movements for a completely 
unrelated agenda? Free software achieved it's goal to protect people's 
software freedoms. If that's not enough for you, create a new movement 
and push a different agenda with it. Fork git, change w/e you want and 
leave normal people alone. I will repeat, only 8% of americans are 
progressive, you are a tiny, tiny minority. Just an incredibly vocal one.

Also, the reasoning that the word "master" excludes black americans is 
ludicrous. "Master" can mean so many things, then you CHOOSE to be 
offended because of one of it's meanings and now it's "INHERENTLY" 
racist and excludes people? Do colleges also exclude them when they 
offer you a MASTERS degree? Do chess excludes them because the highest 
rank is grandMASTER?

Listen to yourself, you are completely lost in pure, unadulterated ideology.

