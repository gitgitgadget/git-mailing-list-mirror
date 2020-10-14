Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053BEC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37872222A
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgJNR57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:57:59 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42310 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJNR57 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:57:59 -0400
Received: by mail-ej1-f67.google.com with SMTP id h24so6067954ejg.9
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGDBIBnfdTZM8FBf5DRqIT50+McG5kJGaeNrtmHHgDY=;
        b=BxxKPNiZld24xVc6uht++G4RvTJOdWmawOTVfu41GZHr0srhwaj+8LB+C9L44awCMk
         nH7U1tInZRtGwZTGPKFXGbeI0GG+f6LQ2tybHWdZPPqxAkA44qTLIbfFZ+ojhOlco4lc
         8BHGWVnUWaBIvB5gZJs6oMG/I/cFHUP5SZwTIvH9VhLbevPZ6xkbLFwVjq1PLHapAtY2
         GVS0CT3PBQwYf8C87CG/J2uQu76L1ziXgO+u4FZ/+vOB/lnHEeVeH8hMKTd/vt7Wxz5H
         QxLhix+yocUq4J+GxBqCF5lIyRAGUP6dFFAoRN1lZWO3hWgFkQ3d8+w7gqAwWFfJIEQN
         4caA==
X-Gm-Message-State: AOAM533DAw885vZeidJNXHBZ2YLdwhcUgIDawfJV/WHpz2SPKaH1d72Q
        okudrUpF8o2z4HNgIJoMnRGYWLN7rhB5hopmNCU=
X-Google-Smtp-Source: ABdhPJyRcOtlZ0m6vN93Dq53IU3zzquXSMy8bciOKT35c2Rj8VTOn+aTZDaUxD3mBq+czI0MMeMFOOLS+OJ/RAWuLQQ=
X-Received: by 2002:a17:907:20b2:: with SMTP id pw18mr201829ejb.159.1602698277761;
 Wed, 14 Oct 2020 10:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com> <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net> <CABPp-BEOrYhUBZ112Z7qFgwUYojmus6_Ra0G0Ts4y+n=-D5vMw@mail.gmail.com>
In-Reply-To: <CABPp-BEOrYhUBZ112Z7qFgwUYojmus6_Ra0G0Ts4y+n=-D5vMw@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 14 Oct 2020 10:57:43 -0700
Message-ID: <CAPc5daU+w2U_5FBrSYEVO5PB2sOV_fxvBQ1=51_=NMTZooZGmA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by substring/regex
 with --run
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> are you suggesting dropping the regex handling and limit it to
> substring matching?  In either case, does using expr save us anything
> (isn't expr a shell command)?

I had something along this line in mind, not to do a regex but a glob.

case "$title" in $selector) found=1 ;; esac
