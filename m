Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F925C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 20:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiJZUxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiJZUxU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 16:53:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5216E5852A
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:53:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d24so15388679pls.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHzkaFlwQgnnYDkTnVzofbKmn2z+9GQ+a2ti8s8hgq4=;
        b=cO6hyN1qP4HnNF06pxWAw+RLKs248IhWC5iGj6g/kTkaLoTvB9Rg4+ur0ke22r+VWW
         Tlfc4iHhbodLstZMmdEqPwGV5WMnIq5KOb9rmlyzC8j9fClOysP/I5csGgWiGC/VeJ5/
         Ahh/twdb/Q4c2PfQ42Sf/dS3Vwzzn0ygwqTf+HzW2uTPF7IADLQFEwCRYq13VxvrgdvD
         w+tZQl1sbjQb+7sNWgDxjFfNnIVFL4VExfWBafAlS4pxHtFTbmW2FeGQrjMaS0FakJF6
         iVfatiyM8h4+lTm58yK+giGuehPXECYnQm379UVx6+/QshnHOJ4mofiGJIrhxbXUAV2t
         V3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YHzkaFlwQgnnYDkTnVzofbKmn2z+9GQ+a2ti8s8hgq4=;
        b=00degBvZQwcV1KgpHo6cCRTbWVzooqIG3IbROXGj0cnoyVzTf51lUrVVz6dvrAb1gZ
         MHwx+31jtiWpmS7n6taKDSH4Q5e6e5Ta5VhHlq23Bq1jN95mITrrF8+rpIr83+hvMk81
         KnTc7U8q7EirqiMm6fDDKewI8tNo/ee2ejBLX7FJp1G0qRwJExNV1ZIohTCbZ69ra8us
         OBuuQHl3zSUKdrjO3f0NiG3nrs8Bf/X5hq8EhTm7rAeaLBwEa9jzldUvZx6LsT6jOuot
         2C/VTszrHXkU/uMOGrRUrpbj7U1C5TDy9d23aUTz5pMGXbm+lQsa4i9dyNdi2GvYste4
         +Z9g==
X-Gm-Message-State: ACrzQf02L4nHJ6k+Z4EDXYF8b7N0hytb99wXlz2PCC/2ebStL06aQ14c
        cf7pF+mq+eUkpuWyrx34aes=
X-Google-Smtp-Source: AMsMyM6Uuj+HWMaGiQ/wr/6174IYihHCtsYjTwVvNpsszypACoe0+BoULURT/9WoAJjPPYUX7U9KnQ==
X-Received: by 2002:a17:90b:4b04:b0:213:63e7:d0cc with SMTP id lx4-20020a17090b4b0400b0021363e7d0ccmr2773220pjb.12.1666817597704;
        Wed, 26 Oct 2022 13:53:17 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e7-20020a056a0000c700b005672daedc8fsm3410848pfj.81.2022.10.26.13.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:53:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] gc: let feature.experimental imply gc.cruftPacks
References: <cover.1666815209.git.me@ttaylorr.com>
Date:   Wed, 26 Oct 2022 13:53:16 -0700
In-Reply-To: <cover.1666815209.git.me@ttaylorr.com> (Taylor Blau's message of
        "Wed, 26 Oct 2022 16:13:34 -0400")
Message-ID: <xmqqwn8mfgsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This is a moderately-sized reroll of Emily's series from [1], which I
> saw while sifting through old mail in my inbox.
>
> That series was sent when I was on vacation, which is a likely
> explanation for why I most likely missed it.
>
> I'm sending a reroll out on Emily's behalf, since the series hasn't
> received any activity in a few months, and I would like to see the
> topic pushed forward.

Yeah, it has been quite a while.  I'd prefer to at least see an Ack
by the original author before proceeding.

In my quick scan of the original round
https://lore.kernel.org/git/20220803205721.3686361-1-emilyshaffer@google.com/

the new round appears to address all the points raised.  It was so
long time ago that I am not sure if reviewers stopped after seeing
minor points that need to be addressed, or there were only minor
issues in the original series, though.

Thanks.
