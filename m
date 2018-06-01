Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599C81F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 11:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeFALHm (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 07:07:42 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53551 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeFALHk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 07:07:40 -0400
Received: by mail-it0-f67.google.com with SMTP id a195-v6so1220101itd.3
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tjbJcx2QsxBO6FiWouW0mh2+YgjdtAXU/Af8sNuZLI=;
        b=D5KAGV65jSUBwOWfaL2UHpq7qXchHw86vuLI4vTfc7XtQTtXz6pIqi5Uj6l4Yg5QVB
         Z1eUYefpnVDPSV5o+QjUSrN9MSmPhLmXA3f9c68dWCKyUe9NNSyFqPUNof9kFUu0VVJt
         ko3JAa3p3z/FuNH77DJDfP5FRv2Ix4gZoHf98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tjbJcx2QsxBO6FiWouW0mh2+YgjdtAXU/Af8sNuZLI=;
        b=k8n1vTwqOzTxHz2/6oACiYN5yVJvbKophIFgQeK99BfP1XO2XOOlh6VExawoOzDaWM
         ug/maYmxuL6kzvdKiruUdlhBwkArldJz6UV94l33gLJX33hyBTGiShp35GyPI2zVEvqU
         veZIv253GiewkbaDb3GIVXAdk3qelxI9mXLspPovoU4bmEs+XfdoAAU/f12Vxq/4g7Hv
         AmTfqfMwPKVYd+Op+d4KBxXj1NasdaanYNWLJjQA2vJVMelOd8GlSrR/8AKBExKg3pKu
         zxQkZiaZMiljrLtx6SZavE4Ppvd4L5dRLF79lwXZJ8gOAxIVmtdChY5A2h/MVzIhF84q
         Q7NA==
X-Gm-Message-State: APt69E1BzdWkyvxoJPMbHhDfZQlxDJGlPGXfKUUCkGny8aXoJRL4ppL+
        RMmOqN0kPezGKzE/ymIZ1leYJgJ4Dhg02lH4nlc=
X-Google-Smtp-Source: ADUXVKJuUQ2cceeKJ5xPUleHn4aZEM1YKcgBquRQQWaoGtRycHe0TZlAfT5QH6vgoB27YyfBlofTnKXG9mFR9N9HC3c=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr3678134itd.16.1527851259454;
 Fri, 01 Jun 2018 04:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1805261449160.6211@i7.lan>
 <xmqqd0xim1tp.fsf@gitster-ct.c.googlers.com> <20180601070456.GB15578@sigill.intra.peff.net>
In-Reply-To: <20180601070456.GB15578@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Jun 2018 06:07:28 -0500
Message-ID: <CA+55aFz5cwZa_PWMV2aGv0TGBpBz8OUB-dPvdwv4ouQs1t1mzA@mail.gmail.com>
Subject: Re: [RFC] git gc "--prune=now" semantics considered harmful
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 2:04 AM Jeff King <peff@peff.net> wrote:
>
> We'd also accept relative times like "5.minutes.ago" (in fact, the
> default is a relative 2.weeks.ago, though it's long enough that the
> difference between "2 weeks" and "2 weeks plus 5 minutes" may not matter
> much). So we probably ought to just normalize _everything_ without even
> bothering to match "now". It's a noop for non-relative times, but that's
> OK.

Heh. That's what I tried to do at first.

It's surprisingly hard.

You can't normalize it as a date, because we have a few times that
aren't expressible as dates because they are just the maximum value
(ie "all").

And then I tried to just express it just as a standard numerical
value, which we accept on input. But we *only* accept that if it's
more than eight digits.

And regardless, you need to special-case "now", since
parse_expiry_date() special cases it.

Or you'd need to just make another version of parse_expiry_date() entirely.

End result: I only special-cased "now".

> There are still possibilities for a race, even with the grace period.

Agreed. But you *really* have to work at it.

              Linus
