Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AFDC433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 04:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A633820639
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 04:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BH8jFSJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgJRERx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 00:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgJRERx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 00:17:53 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9309EC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 21:17:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z2so7007894ilh.11
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 21:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nVy0yCSdZDg05nu6COGgd4Z5ACQ/bXMXn66vGMqiHyw=;
        b=BH8jFSJ/FP4800CF5+4mfkfVFfoV+aly35UiFmxFKNEDyUT2M4pYtlUHmqHkCO6nql
         U1NrTvggRTBp4bnZmuUciqtk7tncYGBUPXfPzzrbD2XSn6FrfhSN6nTqBfOV90AvQNoJ
         vWJjzzjRmVnQL3XJ83aYTlHHnP6tbXFniLYQJFIRHpQ6Yxrb8kFixyzODd0lITCSJsZP
         3cRMSUaUyUZ/NKW3NtKrVoa6gD1LtxF3QpgTna1z179TykReyOtfe3qUzJIUuj7JbC+9
         otVCyWnRFdAMtKUAKMFAiK9xLHxa0mMggqF9qr9dvkDHyu4m2OwXUeT7MC6wJivUtFJe
         95iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nVy0yCSdZDg05nu6COGgd4Z5ACQ/bXMXn66vGMqiHyw=;
        b=ckFzYH2oe6ZxYo05igZu7082LJ4hYIaq4RbwZHCEetnu9/ThUuiK5cDYUbXt1hLIxW
         q9GlSNmSlsGmHO6yKnrSafKMNdBfNuYSEvbAdxms2wXW7AJMRxTWC1SDt+u2S8OxowEt
         SZ3kiDtwKE/TmI9sc0uoAXXlK+RaAn93jhxEjjU3RWSOB/XWkJ8v2VyecKQAps3s2K1u
         J91av0BGGmDtG8nk8qqxVZZS5F2DuEJ2/itCiAKKgBf5o+zPId4rFUSXCJvjnyzcBqyQ
         Ln/VaB2dMTdgiCEmXvDeYg3in3lZYDecEzHZ8RMmWs3tfs9AesmAwwcYxlYBbzUqsvdu
         iysw==
X-Gm-Message-State: AOAM5309H2yruxvcXHvD6ofgYa8kp04AVFwDXPYBbGielK8KqHVFAxvX
        SGWQPk+SLBEuGg9UFrUbuuYggQ==
X-Google-Smtp-Source: ABdhPJywLgt4Bi1d763M3/P5yrXi/TvD0RL1knubMS5SyDurMxIoymIB4uR/sZ0e4Mb4rhjCQKFslw==
X-Received: by 2002:a92:5b02:: with SMTP id p2mr7052926ilb.283.1602994670776;
        Sat, 17 Oct 2020 21:17:50 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:150e:43c9:4c9b:f1fa])
        by smtp.gmail.com with ESMTPSA id b24sm7627633ilb.54.2020.10.17.21.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 21:17:50 -0700 (PDT)
Date:   Sun, 18 Oct 2020 00:17:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/4] fsmonitor: use fsmonitor data in `git diff`
Message-ID: <20201018041642.GB2262492@nand.local>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
 <xmqqeelw8p8i.fsf@gitster.c.googlers.com>
 <CAN8Z4-W=+D-P_qCYijGMnStY-EGwKFx-+AYzjACDPAXnLRAA8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN8Z4-W=+D-P_qCYijGMnStY-EGwKFx-+AYzjACDPAXnLRAA8A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 18, 2020 at 01:54:44AM +0100, Nipunn Koorapati wrote:
> > 20% of the working tree, running refresh_fsmonitor() for the entire
> > working tree is still a win, but if we are only checking less than
> > that, we are better off without fsmonitor, or does a tradeoff like
> > that exist?
>
> My understanding is that refresh_fsmonitor is
> O(delta_since_last_refresh) - so for developers
> with large repositories - this cost will amortize out over subsequent
> commands, so I don't
> think it's worth investigating this tradeoff here.
> As a user of large repositories, I expect that my major source of
> fsmonitor activity to be user
> intent (eg git pull, or intentionally copying/editing a large number
> of files). After such a command,
> I expect my next git command to be slower - that would be unsurprising.
>
> I think the tradeoff could be made for small diff requests, but I
> don't think it's worth adding complexity here -
> as that user will just have to pay the cost on their next git command.

Hmm. I do agree that I'd like to stay out of the business of trying to
figure out exactly what that trade-off is (although I'm sure that it
exists), only because it seems likely to vary to a large extent from
repository to repository. (That is, 20% may be a good number for some
repository, but a terrible choice for another).

But, I think that we can invoke watchman better here; the
fsmonitor-watchman hook has no notion of a "pathspec", so every query
just asks for everything that isn't in '$GIT_DIR'. Is there anything
preventing us from taking an optional pathspec and building up a more
targeted query?

There is some overhead to invoke the hook and talk to watchman, but
I'd expect that to be dwarfed by not having to issue O(# files)
syscalls.

> >
> > > +              */
> > > +             if (ce->ce_flags & CE_VALID || ce->ce_flags & CE_FSMONITOR_VALID) {
> >
> > Would it become easier to read, if written like this instead?
> >
> >                 if (ce->ce_flags & (CE_VALID | CE_FSMONITOR_VALID)) {
>
> I personally find this more confusing because it involves multiple
> bitwise ops, but this
> is potentially due to me having more mental practice thinking about
> boolean operators vs bitwise operators.
> I'm more than happy to align with the common pattern of the repo. I'll
> change this.

I don't have an opinion, nor do I think that git.git has an established
practice of doing one over the other. For what it's worth, my two-cents
is that Junio's suggestion is easier to read.

Thanks,
Taylor
