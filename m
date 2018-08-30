Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C071F404
	for <e@80x24.org>; Thu, 30 Aug 2018 08:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeH3Mqq (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 08:46:46 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38120 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeH3Mqq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 08:46:46 -0400
Received: by mail-qk0-f193.google.com with SMTP id g197-v6so5220284qke.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 01:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1pTI0MZc4PMpeHwsTqrTxgoPqLr0e0gL30z26pk9gI=;
        b=bsEyTF3zXeJqvZNtKjlKZtV/+gpBL+uVKnqhZP3qY6Ce6wLaN9r+8wUrhZ+/czIKH1
         0wBn+SV0FWKVUo1G/JmHi+bJv8l3vhP8U8eGe7OlZSj3L1BdZUtFmkJMRCrEdlgg8/Sn
         VYZPznrhlEa3K893BK3vmaCGHLsktM2y7AFNCWoFR2geAvd6BS5gStmmxPa48aqYVfb6
         LqQDKq5x8NTS0kweLWtk/pv51JOpvu6lujVwK9XkswpCBzsKO7AOKAHO1g8xYgtCAYWE
         b4szuPnFBcxHFTA4oTg2LVR87nX14/XHMIlvkIXjJMwCJ9/55byCsAymxwHcbhPOU93n
         9sIg==
X-Gm-Message-State: APzg51BKCKvj45H0iJTbQf5gXLCavpGm18AHoA12FwNEb3LURHStCF7M
        JTqQe1Izq9mxjGqwY5tgo0JYMBGE8SShLnQ35DY=
X-Google-Smtp-Source: ANB0VdZbuXvZUv+xHzGvxOXkUZAm2iAADNdpaXdFXeGo28b4yaUh9XvCft/f/QtEZgXWRpDwPVrWcJJyVsJO1yiZYMk=
X-Received: by 2002:a37:4653:: with SMTP id t80-v6mr9919617qka.314.1535618742438;
 Thu, 30 Aug 2018 01:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-4-sunshine@sunshineco.com> <20180830065734.GA11944@sigill.intra.peff.net>
In-Reply-To: <20180830065734.GA11944@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 04:45:30 -0400
Message-ID: <CAPig+cR90mzorzLfQTuq73R0zx_DrAa0hThHDsghdZo=cxOWSw@mail.gmail.com>
Subject: Re: [PATCH 3/9] worktree: generalize delete_git_dir() to reduce code duplication
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 2:57 AM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 28, 2018 at 05:20:20PM -0400, Eric Sunshine wrote:
> > Simplify by extending delete_git_dir() to handle the little bit of
> > extra functionality needed by prune_worktrees(), and drop the
> > effectively duplicate code from the latter.
>
> Makes sense. The name "delete_git_dir()" is a little funny (I assume it
> means "the git dir", not a worktree's git-dir), but that is not new (and
> it's static in worktree.c, which helps).

It's not necessarily the best name, but, as you say, it's not a new
issue, and it is local to that file.

Also, it's such a small function, and it's quite clear from the
implementation that it's deleting stuff from .git/worktrees that it's
probably okay to leave the name as-is for now.

> Your patch maybe stretches that a little by deleting non-directories.
> Maybe delete_from_worktrees() would be a better name. Probably not worth
> a re-roll, though.

That's perhaps a bit better, though still somewhat ambiguous, as I can
also read it as deleting something from every worktree directory, as
opposed to from .git/worktrees.
