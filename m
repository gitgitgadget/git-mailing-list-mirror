Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF421F453
	for <e@80x24.org>; Mon, 22 Oct 2018 01:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeJVJjY (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 05:39:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53095 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeJVJjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 05:39:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so8533352wmw.2
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mpDPw7sRZhsVEkHR68JPqslhN3Im9WRYJ6UD3srqqOM=;
        b=BnZSXJcow5a9+0PaxHzcjOrNzs6CxMKPhCbniVVL9hJPghM1E35jmtSK/rNJk9yMB/
         gqPlqdWTacL0UzLzOwuQP6vHJxmVndw3bqSyaQOfx30IhGjMNZlq2Vrf3Bl/nvMi5J3R
         eOIjfZmagZbxEXWi4HR8kS7SP0wajkEmm1HO0aqV1AEH/UAr7MOU7G1dQIXo2ZaJbVa0
         PqaRxucZqn86pxVP5E3fYBgQXuQMPc0WU3+ftlOXNKJed80Pe51T3NAhARUcdsCKHIBm
         2fYn7l4BV3fjVI0V/lEZ3zuHwcsIq3i4JtIQtICAhDztCBkcol0MF0oURBOXqSwjtXnf
         10zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mpDPw7sRZhsVEkHR68JPqslhN3Im9WRYJ6UD3srqqOM=;
        b=XYSaNtttoZtCemWN1A1hTLJb/i9EN1bL/4DKWTjTp8OkSKLEZCJXIipKIUrCX+owVi
         FJ1fzwI29COSfEiHldiCFnTXnUPIWsWbiYw22n47BPqPafwAR3FIqpKE5Ah91IbIbDAc
         Rs2EwTg8AgsYzUdq1JnNg0iPbcASedzT48gTo5+JnCsXM6W35XMJJnnMpNY7AW6lFrEY
         lqjVofzhjxCk1IKwVdQf81L1Z/hGrApy8yLYpr7OZRb+BVj2NwshvcirBZpnJat5a9BO
         6/HuAC+lLVZJtGF2cX/BbDtVoGG+PvwaDkRTXAo/GXg+KhaMq08InBnDjYb2M4+rNux9
         TTTg==
X-Gm-Message-State: ABuFfogorcMJ6H33USWKmlTCqY3AkeAeR6f6DIyudu517Dr4r7MQnsVv
        Eqc30+VwvV48URtGQGfq0eg=
X-Google-Smtp-Source: ACcGV62nqYvr37xExKN6VmEaRXdH6R5yoAUtifCC5A6cE+4yU534QoVPa4AswB8J/v6WAyHouvfZzg==
X-Received: by 2002:a1c:2dc5:: with SMTP id t188-v6mr13068414wmt.94.1540171382960;
        Sun, 21 Oct 2018 18:23:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p7-v6sm11694835wrt.10.2018.10.21.18.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 18:23:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
References: <87o9dar9qc.fsf@evledraar.gmail.com>
        <20181018225739.28857-1-avarab@gmail.com>
        <20181019220755.GA31563@sigill.intra.peff.net>
        <87ftx0dg4r.fsf@evledraar.gmail.com>
        <20181020185852.GA6234@sigill.intra.peff.net>
Date:   Mon, 22 Oct 2018 10:23:01 +0900
In-Reply-To: <20181020185852.GA6234@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 20 Oct 2018 14:58:53 -0400")
Message-ID: <xmqq5zxuzsei.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree it's probably quite rare, if it exists at all. But I also wonder
> how important looping alias protection is. It's also rare, and the
> outcome is usually "gee, I wonder why this is taking so long? ^C".
>
> At least that's my instinct. I don't remember having run into this at
> all myself (though certainly I have written my fair share of infinite
> loops in other systems, like bash aliases, and that is what happened).

Yup, that instict is shared with me, and I tend to prefer something
based on a simple counter for that reason.

> Would we print a long error message? I'd assume that we'd just recurse
> for longer and print one error message that says:
>
>   fatal: woah, you're 1000-levels deep in Git commands!
>
> That doesn't help the user find the recursion, but re-running with
> GIT_TRACE=1 would make it pretty clear, I'd think.

Thanks.
