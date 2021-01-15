Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA93C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 03:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CBE2339E
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 03:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbhAODha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 22:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbhAODh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 22:37:29 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496B5C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 19:36:49 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d11so3406572qvo.11
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 19:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s/jggE0/s+cjpa3gJa8Txc98H2j9yeIH88ivoNrfv9s=;
        b=naPoBPG3bRUTv6JiXRnycvYxzpX6ualRgTseXB000toj7ewiXtEdSeG9qjeSehCR+7
         l0AwBp8g0fjAKqf0g/PaXlX6mEyMOiC0LjkbhJml7xczge46j1TibgmT2Xly1SECaeAj
         sYuTPML8G2gsBxdDbL9/DyGx++ugONOp2CYL5oo21Ita4qRdgHVIeywALHkzGaq5NXJn
         lhM5jpGqfY7BhxdlWdNSvGywdUmEOUcxCAFZpM8ijbC+QHdvq9pnB5kmDtDuOTlsjHxM
         w/p1NMt1ngokawO/9afxCnwA+3jRQqLUK0zk+cZT2iEoNskzb2iNn0uWfrJ+din+bWod
         lZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/jggE0/s+cjpa3gJa8Txc98H2j9yeIH88ivoNrfv9s=;
        b=g9bMvtBo2Gvqpegg4JLghfVTcUgL+Ou6K0xYyuWAQZ2xiWN/TkCH4Jm+XurL2Q+ZDa
         STu6b4R778f7bEZPQnlMw5IEB32zY6ekR7SjlEnDCMY+LD49ZzkdVi8cmLzrMPiesTHu
         ABAr+Ou3KthwNZMG3Ni+/5FqOVCM0X0lvYqX4KgJANaKtOM4sIi69L+ZM/LwNHGIFaZb
         NCs4gNUXtqWDxH+Fuse3trzocfvT+WXuER6Ie218H1EzyehzMC5qUNPk9SodMdF0VCHp
         rABjgMZ3Ck1l8hQfmPosvP3ybQQq2weDXie76Aj4habijkLlO1G5VPGWFXZExfY8lPfQ
         UPDg==
X-Gm-Message-State: AOAM531wnLf4fe/i49j0ibhDZ/31VDVEvTaGmOG9FJlsBUV6wHaylqhQ
        Df9Dg3qTqASQaomahrNlLiw=
X-Google-Smtp-Source: ABdhPJzpk1idz/AWBxC3ZmmgDP8Uw9seIJp94Df1dWzurx0WlzImMR+G/lf7EphSqN949SFKdFraRA==
X-Received: by 2002:a0c:c583:: with SMTP id a3mr10192917qvj.15.1610681808623;
        Thu, 14 Jan 2021 19:36:48 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i3sm4036788qtd.95.2021.01.14.19.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 19:36:48 -0800 (PST)
Subject: Re: [PATCH 01/22] mailmap doc: create a new "gitmailmap(5)" man page
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20210105130359.21139-1-avarab@gmail.com>
 <20210112201806.13284-2-avarab@gmail.com>
 <a71860ee-6810-8766-b9c7-4c03ea7e6e01@gmail.com>
 <xmqqk0sfxpd4.fsf@gitster.c.googlers.com>
 <6612514d-051a-1e58-7ea1-c00428882f2d@gmail.com>
 <xmqqft32vqe4.fsf@gitster.c.googlers.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <4c9123c0-ee35-11aa-04dc-8ffe79781507@gmail.com>
Date:   Thu, 14 Jan 2021 22:36:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqft32vqe4.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Le 2021-01-14 à 22:18, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>> I was not sure...) I feel it is cleaner for that commit to use
>> the correct variable name from the start, hence the fixup.
> 
> The topic is already in 'next', and that is why I asked follow-up
> patches on top from people.  Otherwise I wouldn't have asked and
> instead just squashed these fixes in while the topic was in 'seen'.

OK, thanks for clarifying. I did not check the status of the series,
probably because I saw it was from just 2 days ago so I did not think it
would already be in next. I just sent a v2 with a proper commit message [2].

I'm still not sure I have should have sent it as a reply to the commit it's
fixing (as I did), or to the last commit of the series, or to the cover letter,
or as a new thread to the list... what's the etiquette around this ?
(I'm still new to the email workflow, especially around multi-author series...)

Philippe.

[2] https://lore.kernel.org/git/20210115032826.51369-1-levraiphilippeblain@gmail.com/
