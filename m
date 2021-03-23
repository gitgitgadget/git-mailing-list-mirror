Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC05EC433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EC0619BF
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhCWUpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhCWUpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:45:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7051EC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:45:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so22222750wrd.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g26lcUSxrK66GNPXyMbDwk2r+d12vjmCSiHvKIT06Uc=;
        b=b0TbKsGfrKcSf0Ocppemwb6WFUulIsqPA56rnuWQiReqDxfZYNMmzow3THq81JkoFZ
         QTvFv/TaCmEMnVNe/jaql3Vo+SfpH+cvdw4mafTmY4tGCWoF7yAXiIRx1eBpQ/gYVzHJ
         RMX1mLPo25Om6VKeeIN1xD8IegvgLmHjr/4sXYhz42E8yXU8nasJY1uXivSW1I9MI/BV
         dbtJABXvV6IeNbZ/ZhQJxWloDBTU90NtJAiBl0vUJ1WLhcve8DFnoO8qDdklfeKTfYqZ
         JvgZKDS5blzFIUP2lH2tSqpz9jQdZUH9Goxkbwe5X0UEayuiBNyNpsfo1FTnQm14s8hL
         jLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g26lcUSxrK66GNPXyMbDwk2r+d12vjmCSiHvKIT06Uc=;
        b=Ifpo8/U0fp6kVKeUL7lV73mMLVytnCCp1RqutB0RNYjWsnZLLNW2NBaBE34KxHQB9v
         QVfuZUng5SYWOGGXBVQYiy0fQlYI8TjPXbpFsdkPGyD7kFeOw397tGOYXHv+cHvBOwvf
         avOFNMdKD0NfNv3r2gPBDbSv0ayy7Zpk11NhL08uAc7XsH/OjW84d1OJAAgFGvmCGN4t
         iFWRKHjiqyXwN7GeBm/frC8Mf9BsRMwHdNSqyPLhwgPVTF0v+eY2g+/ba4ry+nk3BuYG
         8v0zqS/Nisv3RqQijDAeglhIGNTaDHq4pUKrSmSnsaunJ1LOrgVlIvzouwMn+UdztY2F
         hWSA==
X-Gm-Message-State: AOAM533p7v/n5XPbOS1s7vSBfp+xjCpu7OwY6dclA8p3AFzDwDiHDgAH
        n+NIwTvyoGfYwURrUWkW1oU=
X-Google-Smtp-Source: ABdhPJyWN71cBUYw5d96DaseOoVDUhVnTxnnX+5x1QwumIRz13Y2Y1ytwMynjKDrUftisbnWqiq5LA==
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr5917099wrx.356.1616532315231;
        Tue, 23 Mar 2021 13:45:15 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-370-45.w86-199.abo.wanadoo.fr. [86.199.105.45])
        by smtp.gmail.com with ESMTPSA id u2sm115347wrp.12.2021.03.23.13.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 13:45:14 -0700 (PDT)
Subject: Re: [PATCH v7 07/15] update-index: move add_cacheinfo() to
 read-cache.c
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
 <20210317204939.17890-8-alban.gruin@gmail.com>
 <nycvar.QRO.7.76.6.2103222255550.50@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <8fc767c1-2b3e-8fbe-9efb-8e87d862cbfb@gmail.com>
Date:   Tue, 23 Mar 2021 21:45:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2103222255550.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 22/03/2021 à 22:59, Johannes Schindelin a écrit :
> Hi Alban,
> 
> On Wed, 17 Mar 2021, Alban Gruin wrote:
> 
>> This moves the function add_cacheinfo() that already exists in
>> update-index.c to update-index.c, renames it add_to_index_cacheinfo(),
>> and adds an `istate' parameter.  The new cache entry is returned through
>> a pointer passed in the parameters.  The return value is either 0
>> (success), -1 (invalid path), or -2 (failed to add the file in the
>> index).
> 
> This paragraph still talks about magic numbers, but the code has constants
> for them. Maybe elevate the commit message to a more generic description
> that does not spend time on specifying the exact values, but rather lists
> the three outcomes in plain English?
> 

Okay, I'll do this.

Cheers,
Alban

> Other than that, this looks fine to me! Thanks,
> Dscho
> 

