Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9489C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DD36115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhGQSAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhGQSAc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 14:00:32 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A15FC061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 10:57:35 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so13386637otp.8
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZtbGGQs5yUj6xoU+BSgdzp0cvVpWofWJb6OxCtCOb3c=;
        b=AZyi7lG/CiodaLOvDfv8mU2D2roWXhYOWm5DZlSb713M73kNt5hWy/tyvR+/IfXLRQ
         uVWD9BY+5esk5IH2lFFYc8q7gSyAetH5XDSp7vY+iLupuXWBIZ75OUDeH9o4P1wSyEeP
         RObegBbxTLw8U0B8+TEtVzuCglitIVyEzkjV4jY5CZ1+ssPWiij+bH4lFSlvR9Lm21Ug
         lkycFiv9EgC7+XfZvHGXmZNN8zRWyFz6Menc8+EoeoVQ4td6SkAHWIZKTMAa7PwZARTx
         LYscQ/9D+GeCUogz/jP/5kTQ9TKIG8M75OFIiIJk+5DONMizZJq/9iLOCWxvQtS7YAtM
         7LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZtbGGQs5yUj6xoU+BSgdzp0cvVpWofWJb6OxCtCOb3c=;
        b=aCONTDKGxVtRhzDqW5Ib6M20jyfm6qr5L5lLPCbu0a88zCNGm+5s6J6ySMWnm9UN1F
         a/KdpP7t/hQwsGK3aJmeanywb9MzQ+ylxpvP/0XW5El9MjqeTDgy5gIzlmvVEM+eJTTo
         UIDMRShgRtgjg5Klsx6vwkMjFPsWB9cyNRn/S6Lkqq5QzFL5qa7IQkRIMtkhQUxXbncf
         v4yGRqzQIIx4FMMU7zDWueF6FcS9J3OT4x3L5ewOT3pBbZBkPhnYjvDrBDJWO9Kmejc/
         1rp5kFsR9P4dR2U2ufQnYhpI86tS6CBxvEobRasf5DrOZUAa9AmarUCJE/z0I4Z3wK/G
         osSQ==
X-Gm-Message-State: AOAM530q1W9oo/37s8tkNE5/ZijPBbyobfb4m/wPlp4cdfnF0/b0QJLl
        6X6zHzrxJe20QwJF+ilS3Gw=
X-Google-Smtp-Source: ABdhPJyYB70Jst2A7svvAT9YLDWSJjGV7IhO3elnJbPjujZPAmF6KhsgyXdvBUEtKKdSw78lx8NmWw==
X-Received: by 2002:a05:6830:40b6:: with SMTP id x54mr8649443ott.290.1626544654706;
        Sat, 17 Jul 2021 10:57:34 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id t10sm2718196otd.73.2021.07.17.10.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 10:57:34 -0700 (PDT)
Date:   Sat, 17 Jul 2021 12:57:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Message-ID: <60f31a0ddf7c_25f2208a5@natae.notmuch>
In-Reply-To: <c54fa084-75f4-b775-8ac2-6df3c7a36571@aixigo.com>
References: <60f1daa896f69_330208b1@natae.notmuch>
 <c54fa084-75f4-b775-8ac2-6df3c7a36571@aixigo.com>
Subject: Re: When are you going to stop ignoring pull.mode?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Baumgarten wrote:
> On 7/16/21 9:14 PM, Felipe Contreras wrote:
> > Elijah Newren wrote:
> >> It may be a worthy goal, but I cannot implement correct behavior if I
> >> cannot determine what correct behavior is.
> >>
> >> You've only specified how to handle a subset of the valid combinations
> >> in each of your emails, and from those individually or even
> >> collectively I cannot deduce rules for handling the others.  Reading
> >> the dozen+ recent messages in the various recent threads, I think I've
> >> figured out your opinion in all but two cases, but I have no idea your
> >> intent on those two (I would have thought --rebase override there too,
> >> but you excluded that), and I'm rather uncertain I've correctly
> >> understood you for the other ones (I really hope gmail doesn't
> >> whitespace damage the following table):
> >>
> >>     pull.ff  pull.rebase  commandline            action
> >>       *          *        --ff-only --rebase     fast-forward only[1]
> >>       *          *        --rebase --no-ff       rebase[1]
> >>       *          *        --rebase --ff          rebase[1]
> >>       *          *        --ff-only --no-rebase  fast-forward only
> >>       *          *        --no-rebase --no-ff    merge --no-ff
> >>       *          *        --no-rebase --ff       merge --ff
> >>
> >>      <unset>     *        --no-rebase            merge --ff
> >>      only        *        --no-rebase            merge --ff[2]
> >>      false       *        --no-rebase            merge --no-ff
> >>      true        *        --no-rebase            merge --ff
> >>
> >>      <unset>     *        --rebase               rebase
> >>      only        *        --rebase               rebase[2]
> >>      false       *        --rebase               ?[2]
> >>      true        *        --rebase               ?[2]
> >>
> >>       *          *        --ff-only              fast-forward only[1]
> >>
> >>       *       <unset>     --no-ff                merge --no-ff
> >>       *        false      --no-ff                merge --no-ff
> >>       *       !false      --no-ff                rebase (ignore --no-ff)[2][3]
> >>
> >>       *       <unset>     --ff                   merge --ff
> >>       *        false      --ff                   merge --ff
> >>       *       !false      --ff                   rebase (ignore --ff)[2][3]
> 
> What about
> 
>           *       !false      --ff-only              ???
> 
> I think these are conflicting options, see [ ] (the ref without a 
> number). This feels like saying oh, I want to rebase, but I want to 
> fast-forward. What should happen with my local changes then? Could one 
> argue that this should lead to the local changes being rebased on top of 
> the remote?

According to the above it would be a fast-forward only, because:

      *          *        --ff-only              fast-forward only

So the pull would abort f you have local changes.

-- 
Felipe Contreras
