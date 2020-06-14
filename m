Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115BAC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 12:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28E120714
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 12:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhdGNZbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgFNMHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNMH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 08:07:29 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C0DC05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 05:07:27 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dp10so6484569qvb.10
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AHkhV0sLZvccSfw53Gq4rpFFxyO2tW0O2VCgyx5jlxU=;
        b=YhdGNZbbpluIKrF9Bdug35uEDGZUa/NXawjER7EJ6e0C8dhsqzpqnSlTHklosCV0fS
         toftmOuBoGiHKllqI7TqxKkwQjRZOSFfE3Zrx53gOlZZIrXFN7vfSQhBsQ1iWMeikTn2
         spqdCw2CO0x5CHcD8dLWE+ougeSdfZXcHrV+yhcUfeb23DytPdPPWIejkMclOelPKuiF
         Mbu65QcTtiN4LVKQUdwNY8NnVMQmvWPm+Kcr3vTkzjNx63mn7NV7xDizzcP6rd2HVRbV
         EBegX2n20X3R06284/5m4YlFLI4a7r+mn6RTyrmAfptScAB1+eXXu+nS541NVJjNb9Id
         dUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AHkhV0sLZvccSfw53Gq4rpFFxyO2tW0O2VCgyx5jlxU=;
        b=An0gRDthk3B0dAbl75E2g+2tGKmuQDO/VUosVl4+Lu6qZHPvcay1NEQPdIzNDdzQ4t
         jrKj8G90DLcLTWtX+NIIyi9mRXAnXkKnk3N2k+8CX2pnjSxCmKNsV6yWSxEsvgZufURJ
         +oazZR7xN7cFb1d8gY3mBNeIbaQ2F6U8/djxGBJBCMv/Xy6g4t2exXaxsEFd2Eelb5sr
         KTgPe8z4w5Yu5xeFCdScQAAvNuPDb+gGDVcXogeR0OMwDwovdPMLF24VIq0BM5TIq3NA
         Ph9M1iHpbu2acnTESB7nC4qPhHa+pYzVEmx2oR4C6QcCmR+WPUpw1AQ/bxjaWb0NqEBe
         UZ3Q==
X-Gm-Message-State: AOAM532/HGGwi1L778QyzloxwybPmS62OzkcJMI//VpqPjSWX/fdQeXV
        gm8FiIZ2XG7oqf3s/ETXKSZcK1kEa44=
X-Google-Smtp-Source: ABdhPJwIpLi1hCjgLbrYH3sE7KisKXN+VNTait4RCSCA7yCT7zYK6R0inWIF3dX50PCrI0MVs+jd5A==
X-Received: by 2002:ad4:4f50:: with SMTP id eu16mr19373274qvb.223.1592136446737;
        Sun, 14 Jun 2020 05:07:26 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id t188sm9089257qka.27.2020.06.14.05.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 05:07:26 -0700 (PDT)
To:     don@goodman-wilson.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com
References: <CAGA3LAcZa76oSovMYS7kKt9YwbYe74YgEscQKKs5qd5_KCneNQ@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <0ff090f4-ef18-06f7-8bf3-e404ffb66ad9@gmail.com>
Date:   Sun, 14 Jun 2020 09:07:22 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAGA3LAcZa76oSovMYS7kKt9YwbYe74YgEscQKKs5qd5_KCneNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, first of all, "making a better world". Get off your high horse, ok? 
This is a version control system, an engineering tool. This change is 
100% meaningless and will bring literally zero impact to the world 
except the disruption in people's workflow. Second, this is a GLOBAL 
community. It does NOT revolve around americans is it NOT used 
exclusively used by americans. Let's assume just because a handful of 
people (by the way, only 8% of americans are progressive 
https://hiddentribes.us/profiles/) feels in a certain, does that means 
we should make changes like this because of any other people? Indians 
find it offensive that people eat cows. Muslims find it offensive that 
homosexuals are alive. French find it offensive when you don't take wine 
seriously. Chinese find black people offensive. Polish find communism 
offensive. Brazilians find classism offensive. Are we going around 
making all these slacktivist changes just because someone, somewhere 
might remotely feel offended by it?

Not only the original proposal comes from an absurd point of view and is 
just an excuse to say one is offended, but it also demonstrates just how 
entitled it is by ignoring that there are many others points of views 
and each one would be as valid to enact a plethora of other meaningless 
and pointless changes. Because let's not forget a very, very important 
aspect here: MASTER IS NOT INHERENTLY RELATED TO MASTER-SLAVE RELATIONS. 
It was pointed before but people keep willingly ignoring it: YOU JUST 
WANT TO BE OFFENDED. This is why I say "perpetually offended". You don't 
need to propose software changes likes this, you need therapy.

