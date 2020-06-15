Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78919C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C73D20714
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbq2GtEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgFOThg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOThg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 15:37:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA46C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:37:35 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c185so16940361qke.7
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aSR+w0KjBw6hspREt4cuCG6+zOOVh6ZeAIgc9AhbmfQ=;
        b=Pbq2GtEe/H1PgPtWLMxpk46w8fdA8xoNVh2bxwH15gLofXG/6boefiUg+pGqXwAwsu
         oMkpEnJJ7zgqXIdQjtXMXZ3W/z0zPM9cNWYMOtx8C5LgHqrQZGH4uXxrBtf/E1TA1Js3
         72lUcVSPDd5z/GStuvcnLWeTk5WREWQ6x8uiSF5VYBCAtEMOkLaTJiaYdlGGTZBHDawH
         ixWZVsplQ46Njgoh4lmhaEG/zikgw/JKfi6EPyWHwiQU9uXkFtI+Ae/viYo0V9pwO2kc
         /iqdZXZ83LsDDlUttFCul2z22tKMuLiv1IVP0ZyfwAeIcEtVKw16jaGzQr9+ZkYi5mXX
         71NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aSR+w0KjBw6hspREt4cuCG6+zOOVh6ZeAIgc9AhbmfQ=;
        b=ExyakcCHXWOwRhDtuVXEtgPbpFYtSpF6Kze5ZIrDyuEsZeeMUyxhpQ9NVF7EWnuWAt
         wOe9QGwkEqNdvuVl9fpi9q431/OvtNon46XEo+JShzf+HSoI4M6RvARdvfYb0Yb+6Fnp
         jUspdN0YQFNuyOIqEjbSESKic5BcnUp62mSpA3CTxZeRbVti9BTjztEkhwNLn8Z7bL1c
         O3CUkG2fBrEy8TxgrBIQGT/u8CtFOfqMcrnq6QadVc4YDSyGVoor9OX1yFy+O+tYvvSr
         pbS/84Oq8VEhgEaHlnYgESDXknehp64LBmpO3mQYU8IPnJlbwl5azHpc8HDfhUQCSuxK
         oDtg==
X-Gm-Message-State: AOAM5318660vtlXepwFQJxp4nz72JCyICXOx6PX2LJc0f2jY7EP7ALkx
        Rt0EGC7HDdtj2nu/GLl5ATl0R+4dJ3M=
X-Google-Smtp-Source: ABdhPJw0TxkpUKydnoAlNMohIHUkkjjXx2wZUrHjHTDoeScJXw0OY/lzhVnyBRgBbPs1a+kob5xRmw==
X-Received: by 2002:a37:65c3:: with SMTP id z186mr17827517qkb.368.1592249855063;
        Mon, 15 Jun 2020 12:37:35 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id s70sm12390798qke.80.2020.06.15.12.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 12:37:34 -0700 (PDT)
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?Alexandru_P=c4=83tr=c4=83nescu?= <drealecs@gmail.com>
Cc:     jrnieder@gmail.com, johannes.schindelin@gmx.de,
        don@goodman-wilson.com, git@vger.kernel.org, msuchanek@suse.de,
        newren@gmail.com, philipoakley@iee.email,
        sandals@crustytoothpaste.net, simon@bocoup.com, stolee@gmail.com
References: <20200615180744.GB135968@google.com>
 <3cef6084-e632-c9ce-c0da-a2c250c2f512@gmail.com>
 <CAAwdEzDgJuoQJAZsrT0piuZPVP6nJTSB9RCbcuXO03-BYTnmOQ@mail.gmail.com>
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <8f9193aa-43bf-2ad3-d067-6330385e1788@gmail.com>
Date:   Mon, 15 Jun 2020 16:37:30 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAAwdEzDgJuoQJAZsrT0piuZPVP6nJTSB9RCbcuXO03-BYTnmOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 >But the people that contribute to the code and to an open-source 
project are the owner of that project so they get to get the calls.

Ignoring everyone else's opinions and needs and just exerting your 
authority is the very definition of authoritarianism. Yes, they do have 
the right. But if they ignore the users, they can just use a fork that 
does what they want. Have anyone considered that a breaking change in 
git might very well result in a fork?

