Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F77EC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiKVXQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiKVXQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:16:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE3C6228
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:16:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w23so15060525ply.12
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsOnL9MA2cy/LjD8/jnS4PgbAKzwc3/T9GOqNEf30Bw=;
        b=BGmJ2GKdJSQrbshwZTqNfwgHwHvK6kBC4hhGY0UjwJ1KHtGjmIc3uDUjWb5suEemk3
         H2pzbqEkvYWkAwWbfCBc4EmpnqDKXzJXrTCXoHwq1z6W9SBC2e/zMrqfdsERYHo9u969
         nUWjTv+zVsIqcb3pY30Bju5/xQccMn9r5kpfKnqgxo0xeiPdDMd0gkF05+z5T7BcM4M+
         /eza1rjwIOZss4Pus27C6M2a5dGotm3HbZBTwCOlkoi8du/97q2Z8RUzf3cABLpLgUK2
         6Zfe2GZ0fbsxccTB0IKqacGczh9RvT1Fq9e/MieT7q/hdMEqOx85Qc0x485BLgppOBFS
         2pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jsOnL9MA2cy/LjD8/jnS4PgbAKzwc3/T9GOqNEf30Bw=;
        b=C/4utt0nInB8vkN6edSBGe4b/YF84+upwxagCDuiS4jCWv1pGcgChjBwG36nJ92spF
         rs3uJumYEuMYjWI4p9p4Dmqv0+JVJrtRMYmSoy7bxIsWF6EDzI70m2jbez/NUF7MD6r4
         snwMH0IAvokadGFGpTZq7idL0++GeADiBUmRJwYf5xP1L4RPBnKpmtDTswkEhOdcMEvK
         HoE/2CJOJkznTbqC6oATJq1kzOT78co4/watUIL1HSabbuxH96JlPcBlCXbaEJHKIIhf
         dZTy6BM2xGvgeclRvou1hbQRvZy9Qv/7zjzZqXqzDzUX/aMqJ/4w+k0tZEyTtH81Ql5R
         9vpA==
X-Gm-Message-State: ANoB5pnBCFegsyykingsDexc5+JGGhGq2cQSWxj5yS4Jk15AOnxMW68J
        5y+oz14bKtXR9kTHr0YrdA0=
X-Google-Smtp-Source: AA0mqf5v13nMxWNR2IRC5KDpJPBUAWpXuar9bXhhbOOpGA+3Sod9Iqm2qkR9IYTzsaGVmvte400a0g==
X-Received: by 2002:a17:90a:7e8b:b0:213:df24:ed80 with SMTP id j11-20020a17090a7e8b00b00213df24ed80mr33449148pjl.186.1669158979528;
        Tue, 22 Nov 2022 15:16:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g1-20020aa79dc1000000b0056befcd7958sm11210428pfq.84.2022.11.22.15.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:16:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] prune: recursively prune objects directory
References: <20221119201213.2398081-1-e@80x24.org>
        <xmqq5yf8yhe0.fsf@gitster.g> <20221121104427.M268307@dcvr>
        <xmqqpmdgv4it.fsf@gitster.g> <xmqqleo3vraj.fsf@gitster.g>
        <20221122000927.M873500@dcvr> <xmqq7cznu69p.fsf@gitster.g>
        <20221122095943.M478967@dcvr>
Date:   Wed, 23 Nov 2022 08:16:18 +0900
In-Reply-To: <20221122095943.M478967@dcvr> (Eric Wong's message of "Tue, 22
        Nov 2022 09:59:43 +0000")
Message-ID: <xmqqbkoyr35p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <e@80x24.org> writes:
>> 
>> > I am unsure about duplicating ishex() from name-rev.c, however...
>> 
>> Yeah, I wonder why name-rev.c does not use isxdigit() in the first
>> place.
>
> isxdigit includes uppercase [A-F].  I think being strict is
> better, here.  I don't want to open up a can of worms if we
> become tolerant of 3rd-party git implementations developed on
> case-insensitive FSes.

OK, we do not recurse into .git/objects/AA/ for the same reason why
we do not recurse into .git/objects/info/.  We do expect [0-9a-f]{2}
and pack to be directories, so we go silent if they are missing, but
we do complain if somebody creates a regular file .git/objects/aa
for fun.

I agree that isxdigit() is not a good match.  I also agree with what
you said about it belong to git-compat-util.h but let's leave it for
a future clean-up patch to remove both copies of ishex(), introduce
islxdigit() in git-compat-util.h and use it as its replacement.

