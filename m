Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABA2C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A658619BA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCWUnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhCWUnk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:43:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594DBC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:43:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c8so9294991wrq.11
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LTqm3mWhhSoCEV90PV6pouHEaV96TDy1zWhK7PPX5hE=;
        b=BFt8PSJcuQQigG0F7Y5MqxbYO1oWpMCymkZiErqlFFpj+C/00zEaS7ANcXAffCkGSg
         kutqk96JsrvflXHgutwHiR3fGFieVuf48RrCQDwg5NRdib/RrUFct3OaBf7H4w9RQ7oW
         CUpVkrwjkV1BXlLGfFt60QbmodVTGDFZa4WbdGDSgnhmohvaOgM+LqGy3H6Vkjk2hmzy
         ARzI8hn8jEaabsMAOV2kJeqBK7ucGXuAHGY9qhoLdg+ATVGPqA1esOwWO+3QF9aR5feh
         kYcsWouaQ69tH+ZlzEbknx6hx/WboqY2/Pin+U1iXgkYHk0LAhRd8XFnJ0fCrXTdoI/d
         ILcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LTqm3mWhhSoCEV90PV6pouHEaV96TDy1zWhK7PPX5hE=;
        b=kESz9P0LSrv0V9dtvY5jpsyHJAgEhKb2SRPRS3DbpJ/7tfGujtf2JhozSKjjm8OHNt
         oTWf8OweEM82Ru2w9CLl/m3Ha39mjB04Ww1soE/DgJn2gKr6K2+vBtIk5/ximZkrnEG9
         0BPHiVby+obrZdpv/jGGIvbLdkH8TrtRvzsj5+v4WP9Fcbb8hMxwDhuZrothHHG/nJdd
         K72xLXvatQIMrCgwic+pkuCNVZkr1WMziL6rrFnaJdPRWXSIByfGBFftXL25uyv0dJYq
         yoymeU7YSW2dBL+ZgC47XQKE9O85CVc9eZVVLi/plTRHtctweRaHgAMS/3Zk+ruPfA7h
         0Peg==
X-Gm-Message-State: AOAM530zdo+GLvBxGdxGyB9nW4I9l6Tvsr4Ev3NI6xc4icH89Ocv6joO
        3tuoFL6Fm8g/24zA3UiOyrYvNXMILTE=
X-Google-Smtp-Source: ABdhPJzRcbw2FTv8fsJjkMbEMhvoH/hXq42ejNWZfixi5azaQPKnmJa6zVqGm2ZLC7kr9jWesE4QGw==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr5706379wrn.226.1616532219110;
        Tue, 23 Mar 2021 13:43:39 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-370-45.w86-199.abo.wanadoo.fr. [86.199.105.45])
        by smtp.gmail.com with ESMTPSA id i26sm35900wmb.18.2021.03.23.13.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 13:43:38 -0700 (PDT)
Subject: Re: [PATCH v7 03/15] t6060: add tests for removed files
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
 <20210317204939.17890-4-alban.gruin@gmail.com>
 <nycvar.QRO.7.76.6.2103222235150.50@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <b9d48a96-7e76-8a83-4ca2-c47fca326123@gmail.com>
Date:   Tue, 23 Mar 2021 21:43:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2103222235150.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 22/03/2021 à 22:36, Johannes Schindelin a écrit :
> Hi Alban,
> 
> On Wed, 17 Mar 2021, Alban Gruin wrote:
> 
>> Until now, t6060 did not not check git-mere-one-file's behaviour when a
> 
> Channeling my inner Eric Sunshine: s/mere-one/merge-one/ ;-)
> 

Good catch.

>> file is deleted in a branch.  To avoid regressions on this during the
>> conversion, this adds a new file, `file3', in the commit tagged as`base', and
> 
> Maybe "during the conversion from shell script to C"?
> 

I'll rewrite it as "during the conversion from shell to C".

Cheers,
Alban

> Other than that, looks good to me! Thanks,
> Dscho
> 

