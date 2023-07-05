Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B1BEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 16:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGEQ0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjGEQ0K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 12:26:10 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A61703
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 09:26:09 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-401d1d967beso1002021cf.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688574369; x=1691166369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EaROCZE2vgtR6i5q4vyT1oHF2a+nyDECDW6gJyzBgeY=;
        b=RsqNhh94eViUAIPNJCKHdqyVj43QOXmvTRbiB0nZFkwyC/ypUiIQUQFIZSz8TZDzQ/
         rIX2IT8c5TTrfSOvD3t8ZMju7mPfBekImLzCgoN7q3AXi5epUUpgC4OfHccZ4pkjP9QZ
         XVEbaaMVuKxFQj+rx30pxgpcH+Xt86IMrwb0SSoTtkOulxlQMxyryIdB1hYYB1FY3swQ
         jorHG+QbVBTBUzx8qI3to4/ZmYw0w6y3mp09kvUIPfK8fPjRN7dyMhUZYQ27gzEXzP9Z
         FnpnxfD0u23n8TYNtiFDbRdNi1fpSP3+RrRlYL7nfwPsebZ6j71KlUjKm7NvOnDRSGb8
         vrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688574369; x=1691166369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EaROCZE2vgtR6i5q4vyT1oHF2a+nyDECDW6gJyzBgeY=;
        b=iSEx2jUzodTnK0Xvu4CawNLmgkbAJwkMZFwZYLIQ5Lt+yJx3WxLjExeFt7r1ANYYH0
         pRJyPPgqTl3ADVr8cEprPW1lg+C2AYReonRezuUTaTRsD5t7IL3NNPy4eAsA7irzlorl
         esylUkqB6mvl0af1I57J6+8+SAepy0TaQ4FF/N/lFtYLie3O+nKA0ADhFms2xRk0tkdG
         3rcqEoWe3lSoCAOs3HB1H+VXb47GBsXDZvD4/U+Jw9ZhaL1wgVs/4d3SI51E6spTJvJE
         cDm9jJZPrCTIoefMk42dtpTP0HTddry2PjZXaxvQeQ/2+3TjYHK1hBj2P6r7Xp5SWGEY
         RZSQ==
X-Gm-Message-State: ABy/qLaJKdn7kXioBhEPpzy4HLzZS/PGcgbRUt1u8mF0xO6rrblInFDK
        ZWkJvf1IzcNTjllbzDkj9SYLB5849iNlh2rf8Kx7Pw==
X-Google-Smtp-Source: APBJJlEX7R4TJIHdpWB2hCDkPFiZvsa9al+NMfFRN0Q5Q9jGgfn3rTWheJn4mYQ0NBI1YP8reK3E4j3ya4g5B1XXKTM=
X-Received: by 2002:a05:622a:199c:b0:3f8:99c1:52a1 with SMTP id
 u28-20020a05622a199c00b003f899c152a1mr176340qtc.10.1688574368981; Wed, 05 Jul
 2023 09:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230630202237.3069327-1-calvinwan@google.com>
 <20230630202346.3069950-6-calvinwan@google.com> <xmqqfs685zw1.fsf@gitster.g>
In-Reply-To: <xmqqfs685zw1.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 5 Jul 2023 09:25:57 -0700
Message-ID: <CAFySSZBDur-1+XG2AetS6jZ=mkv0esFFT5HgQnQ-SVsrpgKXew@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] common: move alloc macros to common.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Is this step mistitled?  There is no "common.h" in this round.

Ahhhh my pre-vacation brain managed to correctly edit the commit
message, but not the header

> For that matter, when the series makes a big change like this round,
> please update the cover letter so that those who are reading it
> without having seen the prior rounds can understand what the series
> is about.  It will equally help those who have seen prior rounds,
> too. what is going on.  E.g. The cover letter of v1 emphasized why
> moving many things to common.h was a great thing (and promised to
> talk about it more in patch 3), but that focus certainly has shifted
> in this iteration that no longer even creates "common.h", right?

That's correct. I'll reroll this series with an updated cover letter
and fixed commit header.
