Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5441F405
	for <e@80x24.org>; Sun, 16 Dec 2018 11:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeLPLMH (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 06:12:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38740 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbeLPLMH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 06:12:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so9464761wrw.5
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 03:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BpWr4hWJo1Zhl+m3va3Ppil90EJqJKI0mDgOFejFLOY=;
        b=Q39OPgmvAJBI0tA14zIDRMoKzp4WQW9diA5artrwNtVdLKATFSx2GJl2xHPhObrLLu
         CrStGSgvO35IZozr/c49cbCu2EMdgGcZuzGUbTOQP+6jI0ABTG+2yx5wZr9YtcQ5mXjp
         M/42ESPBTIQRBTYF0NOOlRvItHQf5H/MoazPTsF54Azlre76imF82KIeomyGidzof3zh
         7y1G8X8vgwZc7gd8Tci+oX87r0Ed9MWgyP6vraioRRGFzNPjkxpn7bsEZLdntShp4zBj
         gntP7dEDPsR0dydk/mIvQpJcwfMrIykh1QSQaJxU9Ur6PS7y9vdFJH8rGVhL70ieYgHB
         k7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BpWr4hWJo1Zhl+m3va3Ppil90EJqJKI0mDgOFejFLOY=;
        b=T6CVU3Y4U0ynNGDwUhWrecRwRe2gXnONZcQvzi1UMPsMrO4Z2uYuHNGynne14cYyqN
         GxajNPDduJdUlI11mFnWKQJDewycf1iiHE1ujMFvkqdO/V/2Tg/ekTvVK14HUEpB1IIa
         v+NT7oguiL3dPE0yNDVGRwRjWPQjK+l/B72ItzISIbY/Vtf6IdMZeWN3OEgqTMSKFifV
         xUNilqtUGKp0NdERMfjfrRPHZpLkgZVkz9Kx4Rtgtgx09ypXKrB7LOU9PyTJvEs6dksr
         f2Lh315lyNlXjhcXn548Uy6Vo/hZ1KhBYP34coHRaxWo4LZ0AOxuIX8Ppzzj0NGV5kp6
         931A==
X-Gm-Message-State: AA+aEWYpeJnHphM1Ykf6n3q8u+VLmy3qUn1Suij5Q685OKy7gyFmBX+3
        7Id2F+R/D/u8722smAK8kt1ZeWwN
X-Google-Smtp-Source: AFSGD/X5ZlCFu7YOz1BGkEGm4ESZ5p1xvn2B0Yh+ZO0C2p8Vw2z7BBjMSUfqTOnehsh01IS20LfVcw==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr7667302wru.300.1544958725232;
        Sun, 16 Dec 2018 03:12:05 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p5sm6642288wmh.16.2018.12.16.03.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 03:12:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual commands
References: <20181211104236.GA6899@sigill.intra.peff.net>
        <20181211104342.GA7233@sigill.intra.peff.net>
        <xmqqo99oeu4u.fsf@gitster-ct.c.googlers.com>
        <20181214082050.GA11777@sigill.intra.peff.net>
        <xmqq5zvvd418.fsf@gitster-ct.c.googlers.com>
        <20181216102544.GA13704@sigill.intra.peff.net>
Date:   Sun, 16 Dec 2018 20:12:03 +0900
In-Reply-To: <20181216102544.GA13704@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 16 Dec 2018 05:25:45 -0500")
Message-ID: <xmqqo99lbu9o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I agree that such a "pass this through" struct full of options and
> context would make sense. I just wouldn't tie it to the "serve"
> machinery.
>
> Did you read the side-thread between me and Jonathan? Another option
> here is to just have ls-refs assume that the client will tell it the
> context (and assume uploadpack for now, since that's all that v2
> currently does).

Yes, I'd be 100% happy with that, too.  And it certainly is simpler.

Thanks.

P.S. I expect to be mostly offline for the coming 72 hours, as I and
my wife are both down with a cold.  I am guessing that we will enter
slower weeks in many parts of the world, and hoping this won't be
too disruptive.


