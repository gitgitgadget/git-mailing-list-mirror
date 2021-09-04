Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420ADC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 06:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C20D60FDC
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 06:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhIDGDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 02:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhIDGC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 02:02:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA6C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 23:01:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 7so1161580pfl.10
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ufdc8cawbfkwqoU75Xt8eM684pXXviIAXR1nhJoT4Tw=;
        b=jep9bQeHHb7AZ6PZl9JJc2+W0wcgN2uslU7Fc69R8fgctBruDWu4HXuSp/WhsoIs0f
         S1gGnI77EEAHZjwdRMGGhlv86bNFoYI/H5eHOXj17maapGHVVpHNlGA0n3k6qT4Ae6Eh
         NOvSsHpQZUY6y88cMHvz6HDoyosyxKK55In5qZya4xMaQcWo1jwVWZAjf67AqrWxdiVT
         N+w2NglJiEbLY0RCrOafsYoq10oNojGvtks7bqQ5ovsgzvw1QPUjHXlP914ESEvrrHdX
         dBeBVtgKtqvSKeTn2zbVn5k67zmBV1wvR+oRDcgRT0Bcnc4uZlyya1cfh379zI8OXAfj
         8K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ufdc8cawbfkwqoU75Xt8eM684pXXviIAXR1nhJoT4Tw=;
        b=smbXY7xD+XuSw252AGwnxc6ss1SlZXaten6A376AEilgaHQizmo3aDCup0HXj1QHkN
         fnnRCHT8K9QC19btSd1ls4qgP7r/egWjg84D56thl/FRv3vsmI4Ev78oUj+uME3IeNoF
         f82NNup78sNWiEsxN5Zp1TSXb/Byy1KZCPujmle3k68miILe8Qx6m/zm2Bo/Z9dQhNt7
         cQ7IPegGn5A3x5BIyw0iY+TkJ9RzNBZQBgX/0Rgnp8fnda16Et08n2p5juCTWzb8DM4v
         UQTnkBS6DDj+XotSlgZ0sODlQDPMCq7W+/DWqZGWaHT6Ks6TgCiMMtc37grFRJGvyWyx
         Fj0g==
X-Gm-Message-State: AOAM5313bb0hPxvfAxxUFlBlgCuatVgwL9nwZvIY5ieBQbfcpuoX9UCF
        rI2x0wkwEMJNs7NqRovLr+E=
X-Google-Smtp-Source: ABdhPJywewTLG6EJHRBjr/M3t4rnAAoFobg6GYnczXV4e014EJozQEnFna6R8EtHvFckEr3Y4VepQQ==
X-Received: by 2002:aa7:8e4f:0:b0:3ee:27d5:28bc with SMTP id d15-20020aa78e4f000000b003ee27d528bcmr2223760pfr.24.1630735315427;
        Fri, 03 Sep 2021 23:01:55 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-60.three.co.id. [116.206.12.60])
        by smtp.gmail.com with ESMTPSA id w2sm996173pjq.5.2021.09.03.23.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 23:01:55 -0700 (PDT)
Subject: Re: bugreport papercuts
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     emilyshaffer@google.com
References: <20210903115933.622847-1-bagasdotme@gmail.com>
 <20210904021231.88534-1-carenas@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b932088f-9ae0-63ee-fc13-fdb11f17c666@gmail.com>
Date:   Sat, 4 Sep 2021 13:01:50 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210904021231.88534-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/21 09.12, Carlo Marcelo Arenas Belón wrote:
> While reviewing this patch, noticed the following other minor issues
> as well:
> 
>    [PATCH 1/2] bugreport: avoid duplicating options in usage()
>    [PATCH 2/2] bugreport: slightly better memory management
> 
> Maybe could we join them all in one single "papercuts" thread for
> easy of management?

OK, please add [1].

[1]: 
https://lore.kernel.org/git/20210903115933.622847-1-bagasdotme@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
