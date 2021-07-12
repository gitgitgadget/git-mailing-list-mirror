Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3523C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E5261221
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhGLRpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhGLRpz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:45:55 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95663C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:43:05 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e1-20020a9d63c10000b02904b8b87ecc43so5754122otl.4
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uQ3mkT1c7OT7el9TrreIIMDG5BBDdbZc6Mj53j5ndKY=;
        b=h0K08b6sRpyrFE5Ra4dRDE0CZoOjKwXbtb+nKtSlmGrisDu0+Y+j7yR7UnRh0vETzk
         zOCupdZO9Rt/R4LgQR6XdO4a8HJRH244UsEWlE0g/wmavf6yjXbIBqRaGHQOzKAnuSa2
         gpAaqPrJ7OcYqIyfJDXE8oafibZKCX/T8CnpnCvsawsIc6tkN8KRN18tQpy4kMbE382E
         o4mKn7LvzujWfUAobByV2PaqjcKPEJ04+EwOn77pRnOefN8nKWHZ3uIqqIMXQO0MFkwQ
         gpMv45yzPWnID83+PbkRZ6Kx8NjeQiwf0knhXh+3M9PLFYAXwprIG8UAUqbvtseSdhAn
         OA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uQ3mkT1c7OT7el9TrreIIMDG5BBDdbZc6Mj53j5ndKY=;
        b=Oq/gHlkoKrxTxOstajc0B7UZnJbomR4418qww9FqbTi1Qwu+q3TXYEDxRITd518ny2
         j8/Cswjra3YDGv3H7j8wfM9BtUcpdeTsKdrUKqwfJJanyc/LbETJcZBD20G4y3G6y0gr
         gHz/D3wZUZizPTl3T5ud9LKiidFnVu7V/mI6EOvstTSwUzPKFvBHX1Q6Slzs/WFEMpk8
         dnzeOZcCE/gedwsP658ehsusBg9oI06i3f6RSN+XXsIHahpUOLW5+YatITOZrzd+gIef
         mkV20omjQn/ztf5lQZe2qHPqDTiHTAZ4hEKd4WVeDJjux3t0sQKZWRq2sIE34cmxPKcU
         VdAg==
X-Gm-Message-State: AOAM533VoOS7ZhrvYujWUOZKKfjD43dnsF3RtJs/LjfmEuVJf/Fl/NwL
        CBe363jQStXwFxcCBt7tAT8=
X-Google-Smtp-Source: ABdhPJyPJWvqwXU/MNzpiusyJMSGeLKQcaEap2tql87NQykTtsS/JlFvrotSYx+OvvE8bhKACgaRHg==
X-Received: by 2002:a05:6830:1290:: with SMTP id z16mr167307otp.28.1626111785037;
        Mon, 12 Jul 2021 10:43:05 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 33sm3199679ots.19.2021.07.12.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:43:04 -0700 (PDT)
Date:   Mon, 12 Jul 2021 12:43:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60ec7f276909f_a4525208c7@natae.notmuch>
In-Reply-To: <CAMMLpeQYwPDjc8WVFmwVismJPBYAifQS96+R8hDj+pch_db+Qg@mail.gmail.com>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
 <CAMMLpeQYwPDjc8WVFmwVismJPBYAifQS96+R8hDj+pch_db+Qg@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Mon, Jul 12, 2021 at 4:21 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> > On 11/07/2021 02:26, Alex Henrie wrote:
> > > The warning about pulling without specifying how to reconcile divergent
> > > branches says that after setting pull.rebase to true, --ff-only can
> > > still be passed on the command line to require a fast-forward. Make that
> > > actually work.
> >
> > Thanks for revising this patch, I like this approach much better. I do
> > however have some concerns about the interaction of pull.ff with the
> > rebase config and command line options. I'd naively expect the following
> > behavior (where rebase can fast-forward if possible)
> >
> >    pull.ff  pull.rebase  commandline  action
> >     only     not false                rebase
> >     only     not false   --no-rebase  fast-forward only
> >      *       not false    --ff-only   fast-forward only
> >     only     not false    --ff        merge --ff
> >     only     not false    --no-ff     merge --no-ff
> >     only       false                  fast-forward only
> >     only       false      --rebase    rebase
> >     only       false      --ff        merge --ff
> >     only       false      --no-ff     merge --no-ff
> >
> > I don't think enforcing fast-forward only for rebases makes sense unless
> > it is given on the command line. If the user gives `--rebase`
> > `--ff-only` on the command line then we should either error out or take
> > the last one in which case `pull --rebase --ff-only` would fast-forward
> > only but `pull --ff-only --rebase` would rebase. We should also decide
> > what to do when the user has pull.ff set to something other than only
> > and also has pull.rebase to something other than false set - I'd guess
> > we'd want to rebase unless there is a merge option on the command line
> > but I haven't thought about those cases.
> 
> I was thinking of --rebase and --ff-only as orthogonal variables.
> Nevertheless, we could make --rebase imply --ff, which would be pretty
> easy to explain in the documentation for the command-line options.
> That way, even though pull.rebase=true with pull.ff=only would enforce
> fast-forward-only, the user could easily override it with `git pull
> -r`. Would you accept that compromise?

What happens if the user has configured `pull.ff=no`?

-- 
Felipe Contreras
