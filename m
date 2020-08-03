Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B7FC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0576522BF3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1hCXSxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgHCVQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgHCVQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 17:16:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59481C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 14:16:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so10912483ljc.10
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EQGG3wwViP356CchW3W9Sa6mQwgVEWsjIe2hoT6sN+4=;
        b=i1hCXSxjeecaBLwn7le9bmmTTlREuf/IWPN7c5rRJrlBn/AhSrI8s8CWL5Y4zfMiH6
         rAPEOeGlmBUYcyiYlSNQ4lE/FZWwhw80y3ojbVGedDQDoMIOFz9zJM1Z2O9Auw1UdZnz
         FhW/iVaAMeYshZegL6onpTiG5AS4XUW5plg9lxid8FE8GlZbP9nZgyUd/9hngflteQxB
         1ztVPD8qINliPyicGXypYmBuFkChqdK11CWD4X4X1Svi0MNkYT9vJyBLugG0WLXzGBPI
         mh/VkvaQrVbCwVIAYwaGZ3r1sFrSdFPU7p8uxP7cdAZakjb7V+sA9ghGRzlF0udLOcrx
         NOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=EQGG3wwViP356CchW3W9Sa6mQwgVEWsjIe2hoT6sN+4=;
        b=nOLy0dTVQDUMhlTillLZxRrqCOrcD58C1HkgQUUC5E/tOqwNy4gQ3UhbUiDgzi7h35
         IERODeIo80nkPG4Lu14Xdfq9EfCrsqvgtF46rb8yriM7sNr/swDPt+Hrt96IDuY9zhfo
         i2iRhpuFManTkeoLjI5xmSokwAaZdqqnbq4I71Gf28zskN7XNzT2VfbrRWmt4qL6gU+3
         J21z9IAOnOsE3199l3eKzvASJIT0xq+pg6ecgRSDN7WUVHSzAfMvixpxk3HpbxoAnYDW
         pBzbMLaRspGDSKRQYOUnbM+k9vNGzZWWG/9MeeFOkcA5SqJASYdFeuS4nYUojaCssCfe
         Hp8Q==
X-Gm-Message-State: AOAM532uL/ssD3z4QB3hN6P0T0Cf5+Kum6u0QHpCplR6cYMWp0oVflDQ
        3mPSRcF7BSwOjYHNLZBIZ40=
X-Google-Smtp-Source: ABdhPJzTnFQwxjs4p5wosfEYMx/6Jkd4Mnan79pJcKIBDYXgEEPLWO4ds4dpNLpEj3JOUcPC8ITGwA==
X-Received: by 2002:a2e:858e:: with SMTP id b14mr8964453lji.301.1596489364871;
        Mon, 03 Aug 2020 14:16:04 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s2sm4645525ljg.84.2020.08.03.14.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:16:04 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru> <xmqqd047wuuh.fsf@gitster.c.googlers.com>
        <87pn87smw3.fsf@osv.gnss.ru> <xmqqy2mvve65.fsf@gitster.c.googlers.com>
        <87y2mvqxy6.fsf@osv.gnss.ru>
        <20200803205815.GD2715275@coredump.intra.peff.net>
Date:   Tue, 04 Aug 2020 00:16:03 +0300
In-Reply-To: <20200803205815.GD2715275@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Aug 2020 16:58:15 -0400")
Message-ID: <87pn87qvl8.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 03, 2020 at 11:25:05PM +0300, Sergey Organov wrote:
>
>> I mean, why introduce --[no-]diff-merges in the first place, if we do
>> agree --xxx=(none|...) is where we'd like to end up? I thought the
>> answer was "it's too late", but in fact it was an answer to changing
>> semantics of -m that I don't think I suggest.
>
> Spelling out the between the lines of my answer a bit more, it was
> really: I am happy enough with the topic as-is and do not want to rework
> it again. But if _you_ want to do so, I have no problem with it. :)

OK, I see!

>
>> As a side-note, my secret hope is for pure "git log -p" to give me diff
>> against first parent for all the commits, no matter how many parents
>> they happen to have. This desire still sounds like a job for
>> configuration option though, rather than, or in addition to,
>> --diff-merges or --diff-parents? We well can later introduce a
>> config to assume --diff-merges=<config> when no explicit
>> --diff-merges=<value> is specified, right?
>
> Yes, I think a config there would be reasonable as long as:
>
>   - we have the command-line options to counteract it when necessary
>     (i.e., --diff-parents or your advanced --diff-merges exists, too)
>
>   - it only impacts porcelain "git log", and not plumbing like
>     diff-tree.

Yeah, these two are totally agreed upon.

Thanks,
-- Sergey
