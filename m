Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA05C46467
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 02:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjAHCFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 21:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHCFs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 21:05:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F613D6E
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 18:05:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso4039000pjl.2
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 18:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ea6ZsWVPSnDJlEoEZ35h0jTLxCebbsSlCqHcnHGqEw4=;
        b=b5onD9aoiK6Z+OJYgmWMkXWSTlxlNdB5iqbHzsPKYZlu28BSkDAy6fNInNxAmAt41v
         bW0/xxB/UskqAu1F+uNRQ0NqeW+Txj9Evsn7A2mUPuk96rZyBj/kGdgB7v5pLJM0IdtH
         zsIO/MwCbazuuK4viYklw7X2KMLEDDE6zeZqB8wyutJcsWg5koVY2p7L2e5I+6fQZGFl
         H0yb2O5zHx7BSq86wxb1Q85HK7T5jUNikKaZynlvKQfwAJxjuBYbwk3jvKcfCKv7kKq+
         luE1Ma3nczJF7q/QtyHvXOaNCU4MJUnac5RKSl9CqlKPJH1X/2B5rGKTBnkc1GMaUoPP
         70Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ea6ZsWVPSnDJlEoEZ35h0jTLxCebbsSlCqHcnHGqEw4=;
        b=OHB+hBy8Z4CHEtLCFZGfwTgLEsoOHB1T8OZkC4AIDAYMnlsVypy2nC4aKKfVwmjuX1
         QYbmfveHp5DkuDDDM6EjomjLUkBwq91soDwD2YgWnaUStvRC1DPQpPlSoMJkAAT5zjSW
         IIF0P7hT39icIsMIhI+AtCuULB5qE1BV8BUx9YEp+9kTiudy2WFwFhQFsfk83r4MBYaL
         DeU86jkIbDSBfjb7m2sXl+090TA5gTAkcYJAIhxsmMNGguG49EMuVf/D2R+NLBCiOMHF
         K4bYgAi0AEP+QbV0cjUptf5TCm5THUy4ulHlMToztrq6wl5+Mskk4tZa7eCmkLbdhruM
         SDZQ==
X-Gm-Message-State: AFqh2kofKMbzmo5m6YSempqFLCw50e/ckNVUU7NsJlA3Mm6HrIfn7GUS
        XC1lxpu/msHLyZg53G+x9wsRPDLgHsOsVw==
X-Google-Smtp-Source: AMrXdXurPR2cV2s28qKd6FMWZ/MTqPi0COOxpJF2+3nfyU8Rh/h+0/a6g0b5PPkTrLLAJ3hXgEwgRQ==
X-Received: by 2002:a05:6a20:12d1:b0:b5:4928:3ab9 with SMTP id v17-20020a056a2012d100b000b549283ab9mr13196565pzg.35.1673143546553;
        Sat, 07 Jan 2023 18:05:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r8-20020a632048000000b0045ff216a0casm2896253pgm.3.2023.01.07.18.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 18:05:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/5] git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
        <74b2d5a9144e4893311d9acfb0b5e8268da6f0f0.1673120359.git.gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 11:05:45 +0900
In-Reply-To: <74b2d5a9144e4893311d9acfb0b5e8268da6f0f0.1673120359.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Sat, 07 Jan 2023
        19:39:15 +0000")
Message-ID: <xmqqh6x1232e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The command used in the example to abort the cherry-pick is 'git reset
> --merge ORIG_HEAD', but cherry-pick does not write 'ORIG_HEAD' before
> starting its operation.

Sorry, but I am confused.  Doesn't <1> update ORIG_HEAD used by <3>?

>  $ git cherry-pick topic^             <1>
>  $ git diff                           <2>
> -$ git reset --merge ORIG_HEAD        <3>
> +$ git cherry-pick --abort            <3>
>  $ git cherry-pick -Xpatience topic^  <4>
>  ------------
>  <1> apply the change that would be shown by `git show topic^`.

