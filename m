Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8399A1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 04:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeFDE4C (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 00:56:02 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35964 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeFDE4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 00:56:01 -0400
Received: by mail-wr0-f169.google.com with SMTP id f16-v6so26371529wrm.3
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 21:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ilbgk5v/OxOHPpSL7nJ5OQkSbYJEKJUi6/M2yy5YS6E=;
        b=c51gkOUZCIw7ZoKYoV/qm3wX+QWn84oQwdAKZio2koI7sQLOt/LcvkHE45LPODPGh3
         kYdINpPPjRaL6pKSq/vhc8g+9hjR3aRjWYWt4y5MALGNWEBdvZ//bkAs1aXqLUOet6bA
         GrUfqw3Rk11X7PD6fw6GWb04IuKCIJR1TQaOYmi4eNQuLqkYDvUCsWoKAX/EvjS/GMfV
         i5W+8i2rF4B/Rbx7xvdezPiAihToPVeh6fkonIVbNS3EebhHCvbD30TMMQzpHQtjr1NX
         Sm6eJj93eXKIrEctPo+OXYRFN69+NLUPPVlK1xLaxfkuMhPya0+KIAm6rwznhbdlLDx1
         7JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ilbgk5v/OxOHPpSL7nJ5OQkSbYJEKJUi6/M2yy5YS6E=;
        b=inDUmQzSiXiEKLkoeGARYUy/GgRoRdd1Okz2F9Cw/jvitjePSa5X3bmvthCWrocwCW
         KSbYJs3Glb8BQQCHPecPSFqWR764UNKxxtAKW7pIEDo4DZWD7g98qqZ85K5SrpVGU8Ue
         dPP+kdgDzArXKVpreJ7xqUgDghFL4dxyZjW4SuRwz2mEa6VIbPPLtHXStxXlz1sIqM48
         bPonNk7qAK5axxac8Durcr1FJJ5zqL8rPQ+TGOzyvnHpfKG6msHGFYSyURSnNJ+yxKrZ
         7Ht8PlpCwUpGcK9G8ooKERElyFb+6VP7xyJ/kN8paXORGlz/KV5E+5uA3KFgmjXkqAZ5
         HYgw==
X-Gm-Message-State: APt69E2XVK0nLrwejQQ563PmRTx76HCMtmATCZxvqqnu+shozzhrdcUx
        uzUajw/t40zqS2uKULN8A3c=
X-Google-Smtp-Source: ADUXVKIh2+CISw2jdd3auEoNa1DSqEsvbJGS+QrX1XPuBeWYdBc3wQ0tpUhTRcbbcXrAw0UhSqI77w==
X-Received: by 2002:adf:9cca:: with SMTP id h10-v6mr689932wre.11.1528088159997;
        Sun, 03 Jun 2018 21:55:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 72-v6sm46720687wrb.22.2018.06.03.21.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 21:55:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
References: <20180601200146.114919-1-sbeller@google.com>
        <20180601200146.114919-2-sbeller@google.com>
        <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com>
        <xmqqmuwb5i7k.fsf@gitster-ct.c.googlers.com>
        <20180604035637.GA15408@sigill.intra.peff.net>
        <xmqqin6z5g8e.fsf@gitster-ct.c.googlers.com>
        <20180604045122.GE14451@sigill.intra.peff.net>
Date:   Mon, 04 Jun 2018 13:55:58 +0900
In-Reply-To: <20180604045122.GE14451@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Jun 2018 00:51:22 -0400")
Message-ID: <xmqqa7sb5ew1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> With that strategy, we'd have to have a big initialize_defaults()
> function. Which actually might not be _too_ bad since we now have
> common-main.c, but:
>
>   - it sucks to keep the default values far away from the declarations
>
>   - it does carry a runtime cost. Not a huge one, but it sucks to pay it
>     on every program startup, even if we're not using those variables.

True, and s/even if/even though most of the time/ the situation is
even worse X-<.
