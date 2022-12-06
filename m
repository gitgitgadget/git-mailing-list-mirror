Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35984C3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 03:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiLFDwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 22:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiLFDwP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 22:52:15 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1121ADB7
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 19:52:13 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 6so12274602pgm.6
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 19:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3wBQTUG2/sAMcL4L1cRCO9AnHmuIRHDwN0zzO23f50=;
        b=F0AB2N5K4nZpJW2Axv97Tuhxdyz9adsaMTfbyo9RtIHFw9rqPQAwKz3TAxIF4xA3QM
         gBTlRz/qX5MjaZ12Wj8N7iay9XyFxbLei/lG/TWklkotdl3O4TRg2LqqOkIsvfMlvO8S
         NZmBdLUHEMFp69IWcdAbvwWAUa4vPYQ6+Pm7GCTkrj5a3vxr9xzB/w9EgDOpEkSXh7Rp
         QPFgfThU9g1lchKa/kWAlm6j+DLAPb90gpno1dxQxh5QwQNLgi5Glkr/FGaAZdAekjQG
         W8lD/xEpsjMAQxb/4h52CLpc2IYmWSeC4SdXZ7uzEqgFqHLJKBQla5d4170oDAzC1EhA
         OLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3wBQTUG2/sAMcL4L1cRCO9AnHmuIRHDwN0zzO23f50=;
        b=NSpB1h7ePaSCh0wWXK2SN4Ct7kkWrG0DV0KUrrAg+GbxXDu0Av8rLPFDVeSvdSbkki
         DaobvEjja8L2cJbCeJpn2xO8Q/utnuiyWbVeGreMtqFzVKR4cRKtPXWXX2NfrWxzqTqF
         7xLgJuxHrK/v/fZ/83+tZfC8oCF35+9mcUq2XyJEtKVK8nDkK+lDQnB7vI3QZ+kuFgL9
         gNJvMFHsq/HSsDcxenlQWX8sEhLJWcIboNxR71chdi7tQD8T7duntgMRt/rHy6qec/3+
         YxnvixGbHxfhK8fWHkw3ia4uwpYXP9ZZt/ATRhF0uw3u5fYb8oKuhIZavyizp2gsNP6R
         Y7Pg==
X-Gm-Message-State: ANoB5pkJpAQnLI9av/mT6L3R0LVAYxdQqopZpag7aUAp25yxwInP4zQd
        Sja79gqAbtlkloerMLhiUsg=
X-Google-Smtp-Source: AA0mqf4Ass7loLZOEPnbcfsuhz2r3H3IFrzQjOnY+jkvoeLTIRmsJhZYgnEql7Likw5Ni3b/p3NCUA==
X-Received: by 2002:a62:ea0e:0:b0:575:7bb:d6fc with SMTP id t14-20020a62ea0e000000b0057507bbd6fcmr44511152pfh.79.1670298733030;
        Mon, 05 Dec 2022 19:52:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e17-20020aa798d1000000b005742ee445fdsm10571034pfm.70.2022.12.05.19.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 19:52:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
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
        <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
        <Y45/8WnuUnP9gOMo@nand.local>
        <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
        <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
        <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
        <221206.86mt81claa.gmgdl@evledraar.gmail.com>
Date:   Tue, 06 Dec 2022 12:52:12 +0900
In-Reply-To: <221206.86mt81claa.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 06 Dec 2022 03:19:57 +0100")
Message-ID: <xmqqilipnq8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Just to add my own digression: I asked in some past thread (which I'm
> too lazy to dig up) why it was the cmake file couldn't just dispatch to
> "make" for most things.
>
> I.e. it needs to at some level be aware of what it's building for the
> IDE integration, but for say making a "grep.o" there's no reason it
> couldn't be running:
>
> 	make grep.o
>
> Instead of:
>
>         cc <args> -o grep grep.c [...]
>
> which requires duplicating much of the Makefile logic (possibly with
> some Makefile shim to not consider any dependencies in that case).

That leads to a question at the other extreme.  Why does any logic
in CMakeLists.txt even have to exist at all?  Whenever it is asked
to make foo, it can be running "make foo" instead of having its own
logic at all.  ;-)
