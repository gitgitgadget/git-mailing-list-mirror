Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9E0C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05018214D8
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbgJNTYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:24:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41170 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389668AbgJNTYe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 15:24:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id l24so609965edj.8
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7Dqacts4p3LFQ+v6NCEsjR+DXqMJylOC5Ew5+hUvVE=;
        b=pKw2PKHYXsl5c3cg2dMBbzmrIknRVHI96RykXGMndtx7eorjVYSc2VUC5teRi3eJF3
         JgV0exCN1uSdVDrGB8y6KHiWv662FjmPGOa3uT51prL9J5cZICyVSAnj2vdZAs7YXDzs
         j7JyTk955rvhvWxZijj8QqHet7e0Ds0NtTZ05C/w9Y0HnuEpFcUf+8AF5keOnOxC8iOU
         CGq200A5ZBeLFZDmg8lxcWf9F3p9zQ6j+ucP0tJ8uDW5LCXG/w8rAIBG1bFBsGWzlxuI
         GenE3WKGD7Zqpnir4QqHsRn/PsQH+bu+KePBUEkCj93ZW7pTrOMJp4kz5tarZjg4RwbE
         fv4g==
X-Gm-Message-State: AOAM530OOTEIn6sy2DUQUl1k2QalrSQRpYH6kJK6VWIobOp8Vq6RVxIK
        F6QTP3zmoLsopvOI0oYqZSFVCihfwVAlJRQcrds=
X-Google-Smtp-Source: ABdhPJxRIQNSgWNcjP/c4UDG7bFMthyRYTRfUojFfoFR6hqlbqfLv/irxHGXQNVUCMdLetXEsfCDLrRE1/6HNALpOQk=
X-Received: by 2002:a05:6402:1151:: with SMTP id g17mr511940edw.312.1602703473681;
 Wed, 14 Oct 2020 12:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com> <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net> <CAPc5daVa4j5mDvTzCFCX2bLr1qVFLO=P=nSakT+mDG1kqeXa+g@mail.gmail.com>
 <20201014180707.GB24279@coredump.intra.peff.net>
In-Reply-To: <20201014180707.GB24279@coredump.intra.peff.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 14 Oct 2020 12:24:22 -0700
Message-ID: <CAPc5daU_aw=yWPKHG1XGt4X5A1AkEXeLfCmHqqVfZ+FzBD7nxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by substring/regex
 with --run
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > If you define the pattern is not regexp but is glob, you can use
> > case/esac to do this without any forking.
>
> Yes, that would probably be OK for most purposes, though I admit my real
> love for regex support is the ability to use "." instead of space to
> avoid quoting arguments. ;)

I use "?" for the same purpose for globs. For things that are casual,
I find that
it tends to make the end-user (read: my) experience simpler to use globs than
to use regexp, largely for your ".*" vs "*" reasons.
