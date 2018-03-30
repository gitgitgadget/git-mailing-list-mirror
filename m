Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E87F1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeC3TwO (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:52:14 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37568 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeC3TwN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:52:13 -0400
Received: by mail-wm0-f54.google.com with SMTP id r131so18150578wmb.2
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ch50ocz/fyh8riYCFKGxPBzjX+cH2h5w2vRntqGRqfA=;
        b=C+P0gFvG8CUSZbgwrAoXe5Uw33QSqTKztxJWOT3BRkrVIFBdVXlpHS0OHN3rjIz/dm
         paGO3R31IBmdSeBRDRuwK0Bf8yNLpEztRQAqrMCtAARcX43cvxH8se6eP8AFUB0JpH3D
         xQ0L7ntHdrUdWCCBYdKqx+okMhBel5NCDlihy+uafr0lkzVTPKNhPfXzoYGNHwGxHx0A
         ZRKQtpNXI3Jjowh3blxaKLIeE3VwPPrXazihtYJ3CrRNyodoxPpvcEjs2w7Syg4fdUYx
         3siKeCwKwLLYtySzHUVeVUByMILsjXA3GQ6yDvFxk+1iWmqr02BkYMWfmKRqmPqz/8Gl
         vIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ch50ocz/fyh8riYCFKGxPBzjX+cH2h5w2vRntqGRqfA=;
        b=RUlYULbMJv3U6ZPf5mq45WdKBgnwCkfbZWTUAahlr3le6NyetguiN4xt2oxrBNlgyq
         7qyYaj13IwXgM6zOXsARfoDJD3w/vas3VgaPxR/IBPT8khAVZdL/7eBY73J4obrBcdhO
         LF7rvfhDUzJzux8B9WN+ncs8I6xgvoDbt/JQnQMNiqhOEgPRSh7E6YaRhhZA6+bUZpdm
         g1T+4sgfS2KxMFzN2/zDkdTVA1cdIXIxNaHCRPmfByYrJMjAQBQLfffU94w5RxzzUiBz
         y26jEBLC7fybfxHVCnC8Nok2q7wVkjROlg9YkM2XbCS/2f7kW1TEudWNlvFXbYEo5k5j
         e14A==
X-Gm-Message-State: ALQs6tAk5R71Z/mtNfOtJ4em6TTTp+i264Pk2y0oFNCZt1nxmKtzlMry
        gtgko4xcqcPIwzFir3hhoIw=
X-Google-Smtp-Source: AIpwx49o7+CQ79NWwx9WGfe5SrjqX9DEhQY2S+cuXOR+Zv6u5nIdw0n2hqf3XNBRF2tamvW0YoQXSw==
X-Received: by 10.28.25.130 with SMTP id 124mr3230657wmz.92.1522439532043;
        Fri, 30 Mar 2018 12:52:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y42sm12399802wry.97.2018.03.30.12.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 12:52:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] config: move flockfile() closer to unlocked functions
References: <20180330192615.GB32338@sigill.intra.peff.net>
Date:   Fri, 30 Mar 2018 12:52:11 -0700
In-Reply-To: <20180330192615.GB32338@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 30 Mar 2018 15:26:15 -0400")
Message-ID: <xmqqzi2p1gus.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 30, 2018 at 09:04:13PM +0200, Johannes Schindelin wrote:
>
>> > Probably the flockfile should go into do_config_from_file(), where we
>> > specify to use the unlocked variants.
>> 
>> Ah, that makes sense now! I am glad I could also help ;-)
>
> :)
>
>> > Yeah, I'll wait to see how your refactor turns out.
>> 
>> I don't think I'll touch too much in that part of the code. My changes
>> should not cause merge conflicts with a patch moving the
>> flockfile()/funlockfile() calls to do_config_from_file().
>
> OK, then let's do this while we're thinking about it:

Yup, what Dscho found was quite amusing ;-) and this obviously makes
the code clearer to follow.

Will queue, thanks.

