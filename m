Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2068BC4321E
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 01:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiLCBMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 20:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiLCBMS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 20:12:18 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7545D038C
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 17:12:16 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q71so5724477pgq.8
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 17:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+MXJf2K/2AhrHhdl32oVvGCnh0cXLm8AhiGFhAwmN8=;
        b=pmRzckhZ0HOk9uppF0WKRkChJJzrUpMCtYNHZmorm7fR2lJ9VPcb1oJgviFOQHnVpZ
         +3Z2c+1wVtgeWKY2JMtR3/CN8oux5TmdJz8igwqygyvwXCppjNgrmSbUmS0A7n+xGJQT
         MWY0an35ppYzu1KJpjrjMjI5wdSWpER9dXM/ispOZINmwh43HA4pM2Oraz1d2hwXQEbJ
         /dYih+OGKbBCEwuTpg4zUFLHxBhtMcBHeVBxoHUhbW6+Yh0giZIAMAPDoBQ3UkEbYCrH
         jOGdWTM2/c6aczJN2RSOMFERc7+LbAPDgFLZAFk6i434NUgKf6jGSiZ7pxMBurZ/eDMS
         moDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+MXJf2K/2AhrHhdl32oVvGCnh0cXLm8AhiGFhAwmN8=;
        b=3+B5FDcW/XCT9/UUEFiSOlR/Pok4wOBU7OdZu56kl+huLuRkGE+xl2uNosskzZFVcI
         aHPBGz97lo0Pbc7u6V9eciBsKf34W6uJkylWliTCY+H60OQGwX+ViyuBVWEUT48b4PCZ
         ix6VA5B8a9xug9WeGyIXxjQPBv1//t1rPYM/IiyjBeYgtADwthHD40JFY5aLj6oQKFL+
         huIYbw+xWEXTI6laQolhd9c1EeoALoP5rs0+NJs75+FnLmrB3/kxO7VfFWAthbjaaM2M
         Y22dpRZVUUnemGxgBcORxMH2fh6lPgVWRUuO3vofkytouQWrEPihqgzChOlDIO18RMFw
         CIAA==
X-Gm-Message-State: ANoB5pkLExzqgG8IdOQJjMSqLnB9108VnPGB8ZL/LxdcmqaVkfGZ/IL5
        XWIzYUOTJG0Rm+jQUpHDyZQ=
X-Google-Smtp-Source: AA0mqf6u2yia0kFtUP5DcvXx8azNpyKpc4ULeyComBvD/BLelNYgHpmxrBXFKfsx3zR1OOUZGhR4fg==
X-Received: by 2002:a62:e70d:0:b0:575:cb09:c411 with SMTP id s13-20020a62e70d000000b00575cb09c411mr17134540pfh.67.1670029936207;
        Fri, 02 Dec 2022 17:12:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902650400b00176dc67df44sm6174721plk.132.2022.12.02.17.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 17:12:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
        <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
        <xmqq5yeuspam.fsf@gitster.g>
        <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
        <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
        <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
Date:   Sat, 03 Dec 2022 10:12:15 +0900
In-Reply-To: <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 2 Dec 2022 18:10:22 -0500")
Message-ID: <xmqqv8mtthn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I have similar feelings to you here. Back when cmake support was
> introduced, I explicitly wanted it to be something for people who cared
> about it, but that wouldn't bother people who didn't use it:
>
>   https://lore.kernel.org/git/20200427200852.GC1728884@coredump.intra.peff.net/
>
> I stand by that sentiment, but it seems to have crept up as a required
> thing to deal with, and that is mostly because of CI. Using cmake in CI
> is good for telling developers when a change they make has broken cmake.
> But it also makes cmake their problem, and not the folks interested in
> cmake.
>
> Now maybe attitudes have changed, and I am out of date, and cmake
> support is considered mature and really important (or maybe nobody even
> agreed with me back then ;) ). But if not, should we consider softening
> the CI output so that cmake failures aren't "real" failures? That seems
> drastic and mean, and I don't like it. But it's the root of the issue,
> IMHO.

It makes the two of us (or three couning Ævar?).  

>   - I'd actually put the leak-checking CI in the same boat. It's a good
>     goal, and one I hope we work towards. But it feels like the current
>     state is not very mature, and people often end up wrestling with CI
>     to deal with failures that they didn't even introduce (e.g., adding
>     a new test that happens to run a Git program that has an existing
>     leak, and now you are on the hook for figuring out why the existing
>     "passes leaks" annotation is wrong).

Hear, hear.

> I'm not necessarily proposing to drop the leaks CI job here. I'm mostly
> philosophizing about the greater problem. In the early days of Git, the
> cross-platform testing philosophy was: somebody who cares will test on
> that platform and write a patch. If they don't, how important could it
> be? With CI that happens automatically and it becomes everybody's
> problem, which is a blessing and a curse.

True.
