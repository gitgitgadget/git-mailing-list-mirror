Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF3C46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 21:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAOVtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 16:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjAOVtK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 16:49:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8831815C
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:49:09 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z4-20020a17090a170400b00226d331390cso29328200pjd.5
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjVMZnZKmdlfay9JLgp9SbiHChDjnCj6U0Mdf7Lz8fE=;
        b=A3MKvGTaWQKH08EF5UMvmebq4IPnaswB+a+i6KisjdQdpc9bNjeXFyaD8e+S6JhrQw
         9nLdtOzz11kv74wQgH5Zk9W1y8gQ6IGNPs4LlmMT6KbNV65+A4ckCvULqh0s6kmuKJaQ
         N/xAV78NcZ+/94yJOiZ7+UnXxfAfewwp+G+Qw+mf8vQY0KNU5fJAi2gDUmKEiPrx3/t1
         MKoNBFm0+J3xTPb9g9/tVu7ZwCK9LzxqEcp3lmkyOvMtnc6f2ZHVIeGtgdLFRSiFkcAQ
         Mp5+oNr0F7pCyhg7V3Q405lqFGU99+d0Qx/0Sz0fu5+bO8ERK5hcMJD3hHo/frkn0VVm
         yHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjVMZnZKmdlfay9JLgp9SbiHChDjnCj6U0Mdf7Lz8fE=;
        b=iaNTiaCARd1XUjzERyULojinY+0rFbI31nDlw4ZyZ2O8SJ95T2NAGbaNbVDUDPz468
         jnqxHUCUUSALbjep0BB1uD67n9A51XM2y8hmbwSWiSFNOByML9Y/5NKs8aOp+D1L47Ul
         V700vL0ZAIeFEhvF1b42TtUeb3loCooILN5qktDHSnOYZlAtLJFVzz+uAKYDN3T3g97/
         AUD3s8PcD/IOGIIh7r+S8VOQyO4porYI8zHvgCeYxRr1UznbYrW4lG1G4zMQpQYY17hp
         YnAwMffuNTNjOzrq9Z2PBMrutoFuS//QREgP3631BcEsEtu3YciMXdViSRYgfH1DOJri
         qf2A==
X-Gm-Message-State: AFqh2kqC3vBG4mvf8qV2tiUhJsWSdgcu4Lerd3cPP0mgdktPQiemRajB
        wtJi4ahXkXi7xLnuczpHYsM=
X-Google-Smtp-Source: AMrXdXsR6PLn4WfC1JPkBw/mq3+aaRmaeYk505iyzG3NaRQ3jdoEKVrqUGw6UAkAHk4s2mfx1lemWw==
X-Received: by 2002:a17:902:c948:b0:188:c395:1756 with SMTP id i8-20020a170902c94800b00188c3951756mr121814199pla.41.1673819348914;
        Sun, 15 Jan 2023 13:49:08 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b001782aab6318sm17816479pla.68.2023.01.15.13.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 13:49:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?RnLDqWTDqXJp?= =?utf-8?B?Yw==?= Fort 
        <fortfrederic@free.fr>, git@vger.kernel.org
Subject: Re: Segmentation fault within git read-tree
References: <d0f9520d-9ccc-a899-609e-fbbb4529e005@free.fr>
        <CAP8UFD0pKZT57jpUOg7gckcr4stoq24YDB2Fu0-AwbGPrEweqg@mail.gmail.com>
        <Y8RHfjFFLRdW3WRh@coredump.intra.peff.net>
Date:   Sun, 15 Jan 2023 13:49:08 -0800
In-Reply-To: <Y8RHfjFFLRdW3WRh@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 15 Jan 2023 13:35:42 -0500")
Message-ID: <xmqqedrvfoyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure if Frédéric is seeing another segfault in practice (when
> not using --debug-unpack), but yeah, it is very easy to trigger this
> segfault. It does not even have to do with sparse checkouts, etc. Here's
> an even more minimal example:
>
>   git init repo
>   cd repo
>   touch file
>   git add file
>   git commit -m added
>   git read-tree --debug-unpack --prefix=subtree HEAD
>
> I was going to bisect, but it looks like it was broken all the way back
> to Junio's ba655da537 (read-tree --debug-unpack, 2009-09-14).

As "git read-tree --help" does not even metnion "--debug-unpack", I
have no idea what it does, or how useful the debug information it
produces is.  As long as the same command without --debug-unpack
works OK, I'd throw this into "does it hurt? don't do it, then" bin.

;-)
