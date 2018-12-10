Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6206820A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 06:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeLJGmk (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 01:42:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51631 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 01:42:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so9704337wmh.1
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 22:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5yEcXQEHo7uRrhiT0hOqgxZ+mXDH+QxwTNb6vF1Hyu4=;
        b=HNDpVIw9S6YxCMT+SkyxgYxfwwi2A1QA7qBomAxBrOUl1/oel+IBPyARyaNPqUxU97
         7gYvgU3E3oF7fhqzfXvlFYa1QDXCSy5K5mFqhHOnq/93xq4DJ0SyJMcnWQnHv15ISzle
         B6KTagZ2CLD1aXdte+XcbF0NJXvWa7nt9F9zUxFexRVNAOBtDz5L6wAbqQ+/mpZD7nji
         JP00S1tJ2Gj8vx0zXB84L1dx/IcOW13be6+9iGpb87TYQfzRvck4/emXrJs+17R3PuTi
         NkBG5VvxRHhq5nLob0P9iToBiifQksc1zEw/vF3PQF+3mpFf6uDkse9Hu+NmYf2H9RIq
         WXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5yEcXQEHo7uRrhiT0hOqgxZ+mXDH+QxwTNb6vF1Hyu4=;
        b=VsXUVKM233sqyf4sdOCiUxWOXH9DDGTcVmqbHcBaNADNVDEjhuilSWpRkNYYRnviUs
         elTDyDBHX/inxgMFIJc+WGjAjJmqet3Gcfs7iiSBHvWHD/VWwdNG6fTApdF90ZSH4r2z
         CbSIz4STTuEFxwHubI1cob9eLMUwLiSiiXSgM30pFxUBbQiIpRwPqkLRY1DnUkoM5cTk
         3kCb7S159CC2D37KGnZWpEqglIPFimFqFllQhYnp/odiOs3HX4q3D+mVxgCW2wMr5R3S
         VcubpGCidKox4DGE98zN35PjOYXIDsvv2wKIuEicaFnGjzs2P9ENP3DJePaIk2NZIK65
         JDag==
X-Gm-Message-State: AA+aEWbIngvvWRGxgKUbWH5VM4Ux/MlDXiPQhDyomGQ4L7WmwuIsDEM9
        sSDruEOjP6VhtBpt/HJ8huw=
X-Google-Smtp-Source: AFSGD/Wj4Ta0G94UYRxgIC6VUD+fZs7pDcYCFGdmVLsixmUi5MZv62L5Gy5bLZ0G0Gh0ZyHvDnstIg==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr3088987wmg.78.1544424157769;
        Sun, 09 Dec 2018 22:42:37 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h16sm31575411wrb.62.2018.12.09.22.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:42:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, git@vger.kernel.org, pcre-dev@exim.org
Subject: Re: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with pcre1
References: <20181209230024.43444-1-carenas@gmail.com>
        <20181209230024.43444-2-carenas@gmail.com>
        <87r2eqxnru.fsf@evledraar.gmail.com>
        <20181210004252.GK890086@genre.crustytoothpaste.net>
Date:   Mon, 10 Dec 2018 15:42:36 +0900
In-Reply-To: <20181210004252.GK890086@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 10 Dec 2018 00:42:52 +0000")
Message-ID: <xmqqtvjlkhlv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Considering that some Linux users use PaX kernels with standard
> distributions and that most BSD kernels can be custom-compiled with a
> variety of options enabled or disabled, I think this is something we
> should detect dynamically.
> ...
> My view is that JIT is a nice performance optimization, but it's
> optional. I honestly don't think it should even be exposed through the
> API: if it works, then things are faster, and if it doesn't, then
> they're not. I don't see the value in an option for causing things to be
> broken if someone improves the security of the system.

I agree to both of these two points.  Thanks for a thoughtful
discussion, all.
