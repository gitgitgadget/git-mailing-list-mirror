Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60B7C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A085761B71
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbhKRACg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbhKRACa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:02:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678E9C0613B9
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:59:30 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b15so18608516edd.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sTMxM+gHMcYpesQDcI+d6xJYKV/UvLWeLx5mhVDzXww=;
        b=MdV6BBKACHbqoMWvW15MmcNNBlCncb3oPpy22nIjXUKFYMIxtXsbnhAUTW4YZgQmcY
         A11JgM8vBHOgK7+VFqKxdLq1+Ut/+nI2MbA6bWsaGPZ8lPQOHnh8+0hj2r5I82/UZ5es
         mslZYNmSyvc8UTEG67t5lCg/X/I1VJyqnORaEhwTMWix0rEcKcFzllv7ElPRinHqyNDB
         g4wZ7zUlE2gsF8NrDqWBkzo8maaZmG+4KnmOWibVXRPvk+NNAXLNhVTMncFozigstvIa
         AOVx8t90wmbmpLw9K4DP1XlbbGFJ6mVYprK4NV2ldNBO4P5q0p/lVCrIa1p7Au+716rC
         rVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sTMxM+gHMcYpesQDcI+d6xJYKV/UvLWeLx5mhVDzXww=;
        b=BoPrRl6kUswPo8oCVC+rBHXsolbbH94i+R0eKZ77D6grL1p2mBsGUxZG7pYMZx2Pxs
         zoWSJ4B8jOF4wWLkSH+BhDNsN8nLBUm5wiK2PoVWtNiTBeJSOUN69WbrMIzUqFjnq4QV
         Hgi7OVHWdQlR5QzSpGdTy8PctYMuk38TcPKwRWpmC9yT5vzu4+ln+HkBaJYxJgEAHczq
         DKSt9Kyj2p+limprlH9RjHdkZZKMwWojMNrxkvYdPWa/s3wHUAcuyIBqzW0nHJy/v0Qv
         Q+RkrvVD/iUtNknVsRgdvtOjzTwZwGHs8uVC2vhnVH+vyDVt2FnIPE9+62Hj8bJ5WHab
         KidA==
X-Gm-Message-State: AOAM530z30hfgWhmMCeFz8zwYJ6w4IeFRIYHvv1zF3IXtznKvmnLaUQ4
        USryudd4qpXXUUoHTCsGORQ=
X-Google-Smtp-Source: ABdhPJz4sb60t+CPeCH1fJR20t/n66Lagdz3HMNr2wcYHlYG+1Zh3dX+l12snydmPB5GPoQVGSwakw==
X-Received: by 2002:aa7:c390:: with SMTP id k16mr4317919edq.161.1637193568873;
        Wed, 17 Nov 2021 15:59:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hw8sm559296ejc.58.2021.11.17.15.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 15:59:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnUpr-000GHu-JG;
        Thu, 18 Nov 2021 00:59:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: fix parallel build race
Date:   Thu, 18 Nov 2021 00:56:35 +0100
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
 <YZR0djZbRUicXcQm@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111180012470.21127@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111180012470.21127@tvgsbejvaqbjf.bet>
Message-ID: <211118.86tuga5o68.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, Johannes Schindelin wrote:

> On Tue, 16 Nov 2021, Jeff King wrote:
>
>> I wondered if contrib/buildsystems/CMakeLists would need a similar
>> fixup, but it doesn't have any generated header dependencies at all (not
>> for hook-list.h, but not for the existing command-list.h). So I'll
>> assume it's fine (as did cfe853e66b).
>
> The strategy we take in our CMake-based configuration is for files like
> hook-list.h to be generated at _configure_ time, i.e. before the build
> definition file is written, i.e. well before the build. That's why there
> is no explicit dependency, it's not necessary.

It is necessary, otherwise how will it know to re-generate the
hook-list.h if its source of truth changes? I.e. if we add a new
hook. Ditto for a new built-in, config variable etc.

I understand that the answer is that cmake (or at least our use of it)
doesn't even try to solve the same problem as the Makefile does, i.e. to
declare dependencies and to be capable of incremental builds.

It's more of a one-shot command where you'll need to run its equivalent
of "make clean" before you recompile.

Correct?
