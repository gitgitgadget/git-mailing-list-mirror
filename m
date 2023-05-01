Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A30C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 21:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjEAVvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAVvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 17:51:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EADC1BCD
        for <git@vger.kernel.org>; Mon,  1 May 2023 14:51:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b7588005fso2405135b3a.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682977873; x=1685569873;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEf09YqcpymorThLxDnNRlcz3/DUQ4xzuGpew1ne2xg=;
        b=CcEfzDYpSgmV85oc7yo/qz/BxgePfhmxEIbEYrSvPWvDwbUpVpYDv3AcjBa0w75FH8
         F/U0nXPrDFfC2uEKIQ4GxmGkMEA5Qhne+PPnDHZ5zIRsca9c/UF1wNHQNzh6fR/dxgrJ
         S6hpP52Nta+Kec15GbT/dr+vGqzkZVYl5px3r5j/pDN/3l5f0RAox7cwO9KchkPl6naS
         9a0j+V+Cug8soPSjAV50rck1MYUel730606dXPtBrxPftQOXslRpa7AqG5CLMwJwHvIU
         Z7Wbtf0m3ugx1aDHj+rTRAYYWX7UmN7aiLRx1hC/W9K+D5nJDXcK/ei1nwuqG5UqmXyA
         7ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682977873; x=1685569873;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UEf09YqcpymorThLxDnNRlcz3/DUQ4xzuGpew1ne2xg=;
        b=fT7uw/TwNhy7xN58X3NDJY0OYx1zI1Q47Azrl12+euMrfBHy6WutrIC6qaMcscZqnz
         YC2WxLhqtLwAJyUz9G/yz0pdINtW5mAaqpKqMf5RI0SwBUP8bHtI18nTYKFjkFwxoAzY
         LQa/OsFOibMEhG32pEZCTIK/gikkOK2+r9Hb0khT65B9UH+qERGmm6dW1ikcl3r+zz/U
         nllgnikdV3T9QA1OGedq6wstW1+RJRFcQW3X3SpplH7zMptHl3myO43IBNCb7dI8w4WU
         Bk6acX3svij5CTDJgLNiQYKJi8Xk0IZLtEFnOqiZ401c54V9/EPle153qZjrPSk8s8HQ
         g5UQ==
X-Gm-Message-State: AC+VfDyrMgVGXEEnZeyADS+VFCEkSlSqFNQvziv9LXYF0ZZzGbRyhQHT
        FzUPZp40B0dptoJi8GKWP5U=
X-Google-Smtp-Source: ACHHUZ7yeCRz90eKEnI/uvMrs6yst+T9H0gyRhT0+JDpYkvLUKuculU1Euo5rGoYa5UVYzcyJqDxyQ==
X-Received: by 2002:a17:902:aa85:b0:1a5:22f3:220d with SMTP id d5-20020a170902aa8500b001a522f3220dmr14586863plr.49.1682977872678;
        Mon, 01 May 2023 14:51:12 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jo17-20020a170903055100b001a9873495f2sm11709276plb.233.2023.05.01.14.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 14:51:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 0/8] worktree: Support `--orphan` when creating new
 worktrees
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
        <wk2wpftowc7wqeaqrylxq7eci4bkmuffwu75h4qugxulcgsk2b@gw6ouq3g5g2j>
Date:   Mon, 01 May 2023 14:51:11 -0700
In-Reply-To: <wk2wpftowc7wqeaqrylxq7eci4bkmuffwu75h4qugxulcgsk2b@gw6ouq3g5g2j>
        (Jacob Abel's message of "Thu, 20 Apr 2023 03:05:35 +0000")
Message-ID: <xmqqcz3j4t68.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> I've noticed on the lore that this revision didn't continue the existing
> thread[1] for the patchset. It seems this is because the `In-Reply-To`
> header was stripped from the message due to a bug with the MTA/mail bridge
> I use on my dev machine [2].
>
> Apologies for any confusion this may have caused.
>
> For continuity purposes I can either:
>
> A. RESEND the revision to the main thread with a note in the cover letter
> tagging the discussions from this thread so far.
>
> B. Reply to [1] in the main thread to point to this thread and then
> eventually publish v10 in reply to that reply message in the main thread.
>
> C. Reply to [1] in the main thread to point to this thread and then
> eventually publish v10 in reply to this cover letter.
>
> Let me know which would be the least disruptive/most ideal way forward or
> if there is another way I should approach this.
>
> Thanks.
>
> 1. https://lore.kernel.org/git/20230109173227.29264-1-jacobabel@nullpo.dev/
> 2. https://github.com/ProtonMail/proton-bridge/issues/374

Once the thread is broken, it is broken.  You gave a link in the
message I am responding to, to make it easier for people to go back
to earlier iterations and that is good enough, I think.

Your eventual v10 can be sent with its cover set as a reply to the
cover of v9 and we will be fine.

It seems that we may need another iteration, but if I reclal
correctly what remains are all minor issues?

Thanks.
