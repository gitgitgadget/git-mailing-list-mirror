Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE03C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBE46199C
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhGGXLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 19:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhGGXLW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 19:11:22 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDCC061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 16:08:40 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x24so3375640qts.11
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JYr4n6nHa5cR9MiPB0ZK383zkhUrh0GFs5s8I/HeDUY=;
        b=eUh443xi8YlmAT7/uqzndo3ddfTqt0GsWkHnCA/ckb41C1lXkDjyZdgSMUT6hOXRz3
         gE0dMG20oIqE20KysUB5pNizOQ8EnNQxby0B8BWxf3gQ78nGPGHrZ9w42jwh93zKrRR7
         /VuNVEwm3z0NiqcuHFhi+ydPZ8paU9Z5y9g6TITbAkD7O/T9uwVrBC1BRHR4dEar4Spp
         n4Ts37qdCvaHalVW2vxAr6ux01OzIKyfY5ENqANyty3VPVna0oxnOFYGprFi/5tENf12
         rfCghEXoEiohuEs3BT/yzVakC76x8t0qR1JSTFD/r2/ViBF4ZocxkayhPz7pNj7J1EVh
         3lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JYr4n6nHa5cR9MiPB0ZK383zkhUrh0GFs5s8I/HeDUY=;
        b=V1d5gdDFQwbvH9Keo1W9PJIWr2ZRKQJYVPHprn1osFWRUGf8L4qML7ssfnm0Ugi47G
         t5nUvLKn+16rsWkVtf+MDFsKYDPkKmjL9IpX441br6OLv+SVJqSWKAm55u/lViKBTwu3
         FphJNX9r6DUAXBCODG+LGwvCbUGiowUAQDa2uJlTqQdSF+hMS4sZJ/S2QW0Y0/Y0zaLV
         lfAbQMAw+afm841KdtnVJ0c4lXlD+3wKqEtq6bbYNzr7S+UYExOvH8/LODvW8yrfG7zs
         E2noinjG+0mCtXAzbmGMGEibqnK0rMOt9qE3sbE8GwAwAfurqgmi9J/xAIncVb95a9tn
         Af3g==
X-Gm-Message-State: AOAM531NZz/zjZLPZtkiPIJOKwOk73qIE3Y9sEdnWGpnv1Kp2EL1ZvNO
        B9aUHU5+G7Dk2M8iGWhJ0+I=
X-Google-Smtp-Source: ABdhPJyiWTK+Uyy0yS5nuPgCxju5AJAICnP7QMtCHzSurS+vK9Ffg8QaQZRMlEkH13oOXJccVdLX8A==
X-Received: by 2002:ac8:7491:: with SMTP id v17mr13987088qtq.228.1625699319334;
        Wed, 07 Jul 2021 16:08:39 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id t20sm239443qtx.48.2021.07.07.16.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 16:08:38 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2021, #01; Tue, 6)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqim1mgbty.fsf@gitster.g>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <fc5ec100-1d42-4199-236e-7a99c9218f38@gmail.com>
Date:   Wed, 7 Jul 2021 19:08:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqim1mgbty.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2021-07-06 à 21:19, Junio C Hamano a écrit :

> 
> * bc/inactive-submodules (2021-07-02) 1 commit
>   - submodule: mark submodules with update=none as inactive
> 
>   Usability update for inactive submodules.

nit: "for 'update=none' submodules" would be more accurate;
we do mark those as inactive but inactive is a different
concept than update=none.

> 
>   Will merge to 'next'.
> 

I'm finishing up a review of brian's v2, so maybe we could keep
that one in seen a little longer?

Thanks,

Philippe.
