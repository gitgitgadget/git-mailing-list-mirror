Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4107C1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 07:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfBQHFY (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 02:05:24 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45293 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfBQHFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 02:05:23 -0500
Received: by mail-qk1-f196.google.com with SMTP id y195so8277125qka.12
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 23:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RLYJKs1zxr7btwZnP7dMgjG+BYnRyDYmxOOrxyP35k=;
        b=Vl+w5OppQe1btguLauYm2cgZ4ILcNMxHO4z1lQI6S1Io0EHwo7bQ4uCGQcxb6FmT0f
         phopbJX4KLsVKUEWGLKQQfVe9XMqneKkDG3Xbkd1CMch0r5WSdIs45VzSAU3TKmLI7vy
         dq6GVdg5QfDXJprB8VrTxfmivvN/dfBP3XI3k62zPOoZtwCnRqscius/HGq2YD3ftZfk
         cr5rOSqR1W8CKYjWCDjftB/RL+cgl24JzbqZETthdJdFoTCsOSiVzxXk2dRzLI8tnL36
         Up4n5qpe8r46LlZbSvzUTjjaVUK7AoSTg5F++RVkVCdrzckfuoh2W9mt/Q03NvLMvfnL
         onkw==
X-Gm-Message-State: AHQUAuay6/keAGgUwWwghJ39Syd2gEfIIi7vKUbQuXwx14xxSV5xpCLn
        sBv+fDFErJfP2ck9B9OzahGOdBp52bE/ajBO0W4=
X-Google-Smtp-Source: AHgI3IZko4ag9o00Jdmf+i7AYBbyKd0rJ1+vFsF/fWZhu3xlpJlWcG+wb/nDoAc/Z2iOG1gFLaqg4ZDpuYu1HBaQoAM=
X-Received: by 2002:a37:a4c2:: with SMTP id n185mr12480294qke.152.1550387122976;
 Sat, 16 Feb 2019 23:05:22 -0800 (PST)
MIME-Version: 1.0
References: <429046b2c9f02c5e4f0af88db51f6c0c099f08a9.1550254374.git.msuchanek@suse.de>
 <xmqq8syg6foq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8syg6foq.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Feb 2019 02:05:11 -0500
Message-ID: <CAPig+cQCw-7WALdzdFD--Jt5d+iZbY8DBBQdC_P8wZ9CVTYZKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] worktree: fix worktree add race.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Git List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 15, 2019 at 1:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> Michal Suchanek <msuchanek@suse.de> writes:
> > Git runs a stat loop to find a worktree name that's available and then does
> > mkdir on the found name. Turn it to mkdir loop to avoid another invocation of
> > worktree add finding the same free name and creating the directory first.
>
> Yeah, relying on the atomicity of mkdir(2) is much saner approach
> than "check -- ah we can use the name -- try to create" that is race
> prone.

Yep. When you re-roll, please mention [1] in the cover letter or in
the commentary section of this patch (after the "---" line below your
sign-off) to provide context to reviewers. Also, when re-rolling,
please Cc: people involved in that earlier discussion (whom I've added
to the Cc: of this reply). Thanks.

[1]: http://public-inbox.org/git/CAPig+cSdpq0Bfq3zSK8kJd6da3dKixK7qYQ24=ZwbuQtsaLNZw@mail.gmail.com/
