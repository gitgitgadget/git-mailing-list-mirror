Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E1FC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B47820739
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHvvTGWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgFNTJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTJA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 15:09:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C224C08C5C2
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 12:08:59 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v79so13750543qkb.10
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lOHRDGBtzpQbJRxyTv61dHFsuEQ/wOgwCgQQNSPYMNk=;
        b=CHvvTGWeGRN9ouiv51UO1hJJHlYCjPGCM3qiLPG14g1ABquFWtWC0O7DJ+WblcHiiJ
         FfEbp4/ao48oDpladUqXZEvj52+TpImhetJ1/vaKoqgNdss1KiVi00WEb/nK4bIWpJTL
         wdJesqQx8bI52jsLTaLfX1OHEsNW+pmp3XlO74vkY0dvkN4ljTbSwwh65Yhsa8Gyg2jn
         /fEMDbOf1Kvse6lN3vKA9LCcSLBefR8uwgAjBuuWrj1sx7SEKhn6nS8xbUMzcn0V54lq
         qnm/RWBuS3/Ckasnp1SedrrGYMq5bkAHCTQDQCUHWpUQi9YB1RB0ShCZaXxk/UEQFLxN
         ogyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lOHRDGBtzpQbJRxyTv61dHFsuEQ/wOgwCgQQNSPYMNk=;
        b=q5kiNldKO9wWxuxVBsM31czaAAv6GYA9mt+utUDUAlh4zY6e2D5uRS3kbCPX78Y8JE
         5PcxQsbpvNMt6rmjocNU0CD5nAOY/KcxfQIPBsOhMzKSn/53GNJTlJAEBDZgDLiG4UR1
         Laigoz7NikH3jX7Iq/29Z2cVkU5fW2TvBaMl71YpKGIagrzy5KKqgM7xWgL78YstaBsw
         fFqYa4nZghmHflE1mVKSNcbVI/WgpfFMpJ+DvFs7bQOA1ALqEA/eUhAlc+vE7+RONZ0G
         7srjTZohuK+exfEFV/LGqU/VPZJB6jTEnhOHX0KgqHN/t08np2PTCYjbENvKKCTnrucg
         /Jrw==
X-Gm-Message-State: AOAM533JUgpN7MC3UiC/xuSYuFGfavo7Nb9Iv2MxP+xHl2IpD50e0wBJ
        uunAHFENyBYCqvZ5DU5LDOuMolZPUH0=
X-Google-Smtp-Source: ABdhPJyU7UK6whXVEwaTjNBNjISBiAhWi2bJSbcCRf1GwAAG8vhGTcQGaqnr3fqf6YFPsNXzK5o77w==
X-Received: by 2002:a37:9ed2:: with SMTP id h201mr12187222qke.280.1592161738376;
        Sun, 14 Jun 2020 12:08:58 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id x36sm9957009qtd.97.2020.06.14.12.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 12:08:57 -0700 (PDT)
To:     konstantin@linuxfoundation.org
Cc:     Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        philipoakley@iee.email, sandals@crustytoothpaste.net,
        sergio.a.vianna@gmail.com, simon@bocoup.com, stolee@gmail.com
References: <20200614190400.bk22inkkz2w6f2sg@chatter.i7.local>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <18018f12-1376-9b17-e1b4-a2e5c59e711a@gmail.com>
Date:   Sun, 14 Jun 2020 16:08:53 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200614190400.bk22inkkz2w6f2sg@chatter.i7.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 >I just did. "Master" is not descriptive enough because it implies that 
a branch with this name carries some special status over all other 
branches, whereas in reality it doesn't.

No, you presented a contrived explanation. I wanted to see a real word 
case where someone had issues understanding it.


 >Well, then nothing really changes then, does it?

Did you read what I said? I said it would be chaotic for everyone to 
deal with this change. It won't change anything for the people who WANT 
the change. They are just forcing everyone else to use what they want.


 >Nobody should have to fix anything. If you already have an existing 
repository, then literally nothing changes for you.

Except git flow. And any software that deals with new git repositories 
being created. The world doesn't revolve around you.


 >False. Efforts to remove the usage of "master" traces back over half a 
decade

There will always be people that adopt fringe ideologies. In the 1960 
there were feminists that accused every single straight woman of being a 
gender traitor, for example. Yes, I said "literally no one", and that 
was hyperbole. I'm sorry if that went over your head so easily.

