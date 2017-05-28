Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6429620D09
	for <e@80x24.org>; Sun, 28 May 2017 00:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750770AbdE1AEK (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 20:04:10 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35297 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdE1AEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 20:04:09 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so2600631pgd.2
        for <git@vger.kernel.org>; Sat, 27 May 2017 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wu1ISqqw9t990w31lFV/Nma8TYQKtKdRYPliR5Qelew=;
        b=ZZFtiHoX/0e3E1ACgeeOFrOYIo8St62J/Peo6K5ZAa/5gaIXIOhchOHq+aWkXjxSVC
         qoYkrWMCCcjmR6LkIkReKY8MCXlDgiOYT7I57xRNlpspYaxJIQRybRyr9fZu6wE0Nibe
         SxLukyflFQcU8IAcIUG713H4UGncrQEvuTDNL6p835i7+cndFWncace7LfskLBx0KMpO
         D7HrS4m9VfLHrA01L0KqOZpRCtb23DDOFSF6vgCSM/OFb2hZS49wYbs+6YEavp7KHXQX
         w2jBE/QBHgvE+oVPNoQC/SsnS6lSnB2nq20YvlNFU1/4jEnZWi9o8Ovyw4+C6R4cV/U/
         DYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wu1ISqqw9t990w31lFV/Nma8TYQKtKdRYPliR5Qelew=;
        b=FU236cbKFAqAZK8EPcKnYxAeRBwBzK4oW8rkC1rxsYwzeA4N/X0JRqeIMaot7WBDGX
         EBNInnny1pByVkXfebHFT9lXTUEU62nspIsWfD9ttjBjpXjtTTxConDeo8/7shyAYvrf
         LTUZou1yJArcROc813kGDfXzi2+kFE/bGyMoWvd9uw5Gf9dauUJbryc9pxVQTNCHf9vV
         IEv+53Clrd5T1lhv2WomZf4QfNMEtk98zOOww7l4KZepNEMAX2Adb7HXuWdy1ix1aMUT
         7BMnp3vl94wF2B+WVjnQQRjsi4nAC4EZkz4MtJNDVwXKmfehf5ES8m03s6ecVo2avh4I
         tBGg==
X-Gm-Message-State: AODbwcAApzFsL/23ez0y2HxmZ4rM3EXZXr1Rl1+t/N7flIgSSXL/3AAz
        V9xuOpEbQM3Gng==
X-Received: by 10.99.109.141 with SMTP id i135mr10702947pgc.33.1495929848657;
        Sat, 27 May 2017 17:04:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bd10:cbc8:82cc:8993])
        by smtp.gmail.com with ESMTPSA id m8sm9451951pga.34.2017.05.27.17.04.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 27 May 2017 17:04:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] recognize pathspec magic without "--" disambiguation
References: <20170525152739.t63dbsq2dojy2y2h@sigill.intra.peff.net>
        <CACBZZX6K7ppVB0qYah76_+pjTKjsco3rHT0xRyKtF2H1dS4k_w@mail.gmail.com>
        <20170527203937.hto7lwxfbjvl5f7o@sigill.intra.peff.net>
Date:   Sun, 28 May 2017 09:04:06 +0900
In-Reply-To: <20170527203937.hto7lwxfbjvl5f7o@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 27 May 2017 16:39:38 -0400")
Message-ID: <xmqqd1atc0eh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah. That's a good reason not to use ":/" without a disambiguating "--"
> (which _does_ work, even without my series, because check_filename()
> does specific path-matching). At best, you pay for a complete useless
> history traversal before the command actually starts running. But much
> more likely is that Git just complains of ambiguity, because people tend
> to mention top-level paths in their commit messages. E.g.:
>
>   $ cd t
>   $ git grep foo :/Documentation
>   fatal: ambiguous argument ':/Documentation': both revision and filename
>
> So it really is a pretty horrible syntax.

It does not allow it to be further annotated like "HEAD^{/^Merge
branch 'foo'}^2".  Yes, I agree that ":/string" was a pretty poor
design that was done without thinking things through.

But back then in 2007, it is a bit unfair to blame the initial
design for not thinking things through.  There weren't as many
precedents, good or bad, to learn from than we have today ;-)

