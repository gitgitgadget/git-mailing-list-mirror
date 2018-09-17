Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220831F404
	for <e@80x24.org>; Mon, 17 Sep 2018 17:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeIQWsF (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:48:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50574 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQWsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:48:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so10549420wmc.0
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QV73tSnnfiLNCHBNlJc2zL7lHiup7BWbslOhjBCikes=;
        b=DEuMMtGCRjD+q58L39hLTPX/avI7vPcfSg0I7EGNMVN23dCIlndGpl7lGR6kjinh+3
         IVSLYymYCP5RWQE8s6R/i6xw65wFJljsP39S1dMVaMaVwqbvogvHe3dV1BEmmtaaXQrS
         JQQpc86/9KXAVjLEuzQZrWeOWZgv5kJryYCLNh2YHchnInI+R2mU+V78hlzaMps/NXKj
         68l2FTwpkO0A7tJbhbf1VQSGH4TjjnhxazAFXlOxS+w5rLcYRUhcPzYhXMT7U9UPLAKs
         p7ixB8HhqU2haAGQHoLPT4nMWGENCfWK+8YEpVq0bNwrBbyUfmbI5zPkpR0NwVQY3JVT
         GT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QV73tSnnfiLNCHBNlJc2zL7lHiup7BWbslOhjBCikes=;
        b=JwVBmMp+jZqbDopEV5sdRtcbZxQ0JREid4buYPcC3h4wC/E2QOr0L28XQnSoJA6Kwl
         eOy7pxfYImKNkdfyAh+DbGXQV4yIaUhw4DUUrAfzYcFPPaYiQr4idg98VnUN5mc4b81E
         o67dxlQMN1YlMgZEqbpcmUGy1hrsi3OUl3BjI1uGoaHeuI11d8HPHzJz62W/L/6ZU5wQ
         XsNVzUO84+d8y6bQrGcUGm89l1BerGKhQEjXzZ5MtsG8ElW5o1oYISlRVGsRo/9cSpLm
         FRh2LB26aoUW3GU/3dL6elExKFR/0rk5Kfgh9CTlyyY8YP6L+PW2sGxDVRoC8yDPdoVl
         2Hfg==
X-Gm-Message-State: APzg51CNlJeLVs+x4CrsrKZ+rpmB2nFlCAPMWojvZKxE8x+q7InGmG4S
        ki0cDLa38sAvRZ5Oz5MJFLxu6UZY
X-Google-Smtp-Source: ANB0VdZxRZ31pBaXh6l1SE/UZjnPihoZ/j42ziSf0K9b2D7WSCDS6E1gfPK+xwxSQOokpVlJ5M03nw==
X-Received: by 2002:a1c:1dc9:: with SMTP id d192-v6mr12928847wmd.140.1537204786257;
        Mon, 17 Sep 2018 10:19:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l5-v6sm5593054wmh.0.2018.09.17.10.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:19:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v5 2/5] read-cache: load cache extensions on a worker thread
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180912161832.55324-1-benpeart@microsoft.com>
        <20180912161832.55324-3-benpeart@microsoft.com>
        <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
        <CACsJy8DtYrB99_7GyZaHsLTG8Ff7Mt_hENwhLE6_x6b5zzQ9Hg@mail.gmail.com>
Date:   Mon, 17 Sep 2018 10:19:44 -0700
In-Reply-To: <CACsJy8DtYrB99_7GyZaHsLTG8Ff7Mt_hENwhLE6_x6b5zzQ9Hg@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 15 Sep 2018 18:23:59 +0200")
Message-ID: <xmqqwork6nyn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Sep 15, 2018 at 12:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> Wait there's no way to disable this parallel reading? Does not sound
>> right. And  if ordinary numbers mean the number of threads then 0
>> should mean no threading. Auto detection could have a new keyword,
>> like 'auto'.
>
> My bad. Disabling threading means _1_ thread. What was I thinking...

I did the same during my earlier review.  It seems that it somehow
is unintuitive to us that we do not specify how many _extra_ threads
of control we dedicate to ;-).
