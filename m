Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2572C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiKGVbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKGVb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:31:29 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C6025C44
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:31:28 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id 13so33739049ejn.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mYa2f0h1bs5NyNU+lAKOo6BM736V/YSc7p12s1tchM4=;
        b=gZf7OI4l2gx7+mW/pKr+nmPia9Pwq/25dPnZ9klhduaN0K6k1hVcyP/oNyWn2SyAxC
         COBwQd+5dXO/UkE51WF+/1LLJQCrOpZTLZy513q/lrwR1eJf9pML3mosSwPtfLF9govh
         F52SyJ1lrEeIIUnf3bUsIXUjtSoyp7kAdCLKe15k/Ds1hXlNIaIDhcXaIMkF91WEedXJ
         pkOVYHzShlAUR5+PC/r1jvvM0dPGSI5G7JkpnTH9ISYGvZIyVLmBPETQJIZZKzCgwSO/
         RJbOraJ6G10/Vx/k7EWSj8bGYyP7/AkmkeP1HlvAyOTbMnU/DF3ZEAisigCqkaE4Dxlz
         F83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYa2f0h1bs5NyNU+lAKOo6BM736V/YSc7p12s1tchM4=;
        b=K1czu0b/Sg8eDHir+4aRuNqiJBYfpAnE3arr0BLnMGXQ1+jjl9W5tA3c1xUv37elKD
         uvBSPnnrQhlp8K9pBy6S+SDGKT+eDaVD/t+2FVL6ZwRPuFIZ+pbkCkXdROZFwKjtI+92
         Cn0otDUr7UekxsDGaQtgvQGA/M6FvwRJVp8+KS5BZLTySKmLlk/Bym+f/akjqmnfKERE
         ZjSFRvCK/LvUvB/KpCyOqeLNcOxMGEqYPOhMZyqLbHL4TlfyYJECxEdRTAQNJp++OeNT
         GuuNTJzOiEBm6QklHIO45L6O9SzmBC+AwKKL4xCHB1Ek/WnQzxPiPytxSaIjNmvRCLqP
         ANXw==
X-Gm-Message-State: ACrzQf2gBigEqij9tFTHnuk6GNqbb/CjSO/wceI+o/9kK2Ir6mpYIJHN
        mIDS9evy/OcXoSyAx02GMwo3YedIlw7Flg==
X-Google-Smtp-Source: AMsMyM6dY7vAHQdu5xDkuoIO3CsWXvFLGQrHXXjdDovWngqWH33Jgo+80GaV6WpXDsYufiG2o47StA==
X-Received: by 2002:a17:907:6296:b0:787:d066:9fcf with SMTP id nd22-20020a170907629600b00787d0669fcfmr47196790ejc.692.1667856687294;
        Mon, 07 Nov 2022 13:31:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906200100b007ae693cd265sm1823786ejo.150.2022.11.07.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:31:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os9iI-000Lyf-0I;
        Mon, 07 Nov 2022 22:31:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/13] bisect--helper: pretend we're real bisect when
 report error
Date:   Mon, 07 Nov 2022 22:29:00 +0100
References: <cover.1667667058.git.congdanhqx@gmail.com>
 <cover.1667667460.git.congdanhqx@gmail.com>
 <f212e6428855f0b0839bf6befd7c4703c505cc66.1667667460.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <f212e6428855f0b0839bf6befd7c4703c505cc66.1667667460.git.congdanhqx@gmail.com>
Message-ID: <221107.86sfiutpsh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 06 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> In a later change, we will convert the bisect--helper to be builtin
> bisect. Let's start by pretending it's the real bisect when reporting
> error.

It's good to have this in here, FWIW I left this out of my version
reasoning that it was broken before, so we could leave it with the
psot-cleanups.

I'm fine with having it in while we're at it, but just FWIW:

I don't think we're "pretending". We *are* the bisect command, the fact
that we're implementing it via a "helper" is really quite irrelevant,
just like we're not "pretending" if we say we're "git bisect" instead of
"git-bisect.sh" or whatever.

The only cases where we should have these helpers report that they are
the helper is for messages that aren't user-visible, e.g. the "-h"
output emitted when you invoke a helper-specific command that no user
should be invoking (although arguably, we should just BUG() out
there...).
