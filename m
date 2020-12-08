Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47DFC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996AC206EC
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgLHUmX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Dec 2020 15:42:23 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:34358 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgLHUmX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:42:23 -0500
Received: by mail-ej1-f43.google.com with SMTP id g20so26598230ejb.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7TFAPEXRQNGwDeD8B09km7UMFfamOaR7wd8lcLJ5ans=;
        b=NY57+6PZfG8ok1Varv11mplI+2SUskBAXV2w97Zunup6slBJebhSbqm9Zpzkx2DCec
         GKe0KrI8dOCn9jWgICKig8ECDLrTcVK2q2TzEY4IwitmIe/Z+vSmwDNWp/GUAYmuzmDv
         O0tXcH11XyvUi0HJnONup2p6cATNZcPPHFT2GlFo/up5I+AIyU6O3XhICA3NH0B/NMM3
         SOmeysy9joY9k2tRi5Es3YXLN7y4qfh4+V/IHlvfHwcQ5NG8kzXtI/eiA5r0yJZ9Vvrw
         SzIRxWTv0zQDy/6aVNe+nSS3428NSVEs6bFksQqZnELIDYudor0zRMkfqZuPQ5brsfkR
         58MQ==
X-Gm-Message-State: AOAM5313nYDhEN0ZWCCF8uhlN3SG2dGfS1sLdXjZCa8YRFaOcgW6xatS
        erAPmyU/qiGMlf6nZQujfZbATniuKf5mbAYNy/P62sWdvoo=
X-Google-Smtp-Source: ABdhPJysljQ96WdtKMCtXCOr0UHSEWAq6BCdwZlaxXCadMcnCzNu9MR568iVsZinZ0NaLCAVS6fHs0hxelswWL45ocM=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr11794299edu.163.1607455665693;
 Tue, 08 Dec 2020 11:27:45 -0800 (PST)
MIME-Version: 1.0
References: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com>
 <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com>
 <CAPig+cTsEx-puHn1N2=fBVAgdvc7cutCDTC7vBJuLm5utObfJg@mail.gmail.com> <A462326B-505D-4A92-B789-21BB8FE6AA16@gmail.com>
In-Reply-To: <A462326B-505D-4A92-B789-21BB8FE6AA16@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Dec 2020 14:27:34 -0500
Message-ID: <CAPig+cQad_yyVgwQQ-NZyy7SergM-fUMeMAm9RsV4zEqNt9TDg@mail.gmail.com>
Subject: Re: GIT_DIR output from git worktree list
To:     =?UTF-8?Q?Ganriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 2:28 AM Ganriel Nützi <gnuetzi@gmail.com> wrote:
> As of your rational, wouldn‘t it be good anyway to have a file
> „worktree“ inside the .git dir (of the worktree) containing the path
> to the main worktree? So to speak any worktree always has a .git dir
> with a back link to its main worktree (the existence of the git dir
> might pose other problems?)

I'm having trouble understanding your proposal. Secondary worktrees
don't have a .git/ directory; instead they have a "gitfile" named .git
which is just a pointer to the worktree's administrative directory
within the repository (specifically, <repo>/worktrees/<id>/, where
<repo> might be a bare repository or the .git/ directory of the main
worktree).

So a secondary worktree's back-link is a pointer into the repository;
it's not necessarily pointing at the main worktree, as you discovered
and reported in the email which started this thread.

What I was suggesting was that it might be the case that the only way
to solve this would be to store the location of the main worktree
somewhere within <repo> in some file, and then `git worktree list`
would consult that file to learn the location of the main worktree.
This is complicated by the fact that that file would have to be
updated automatically if the main worktree directory is ever moved. It
also needs to be done in such a way that it is easy for other Git
implementations to understand and not trip over.

So, it's certainly possible, but it's something which requires more
thought, and there might be alternate and better solutions I'm
overlooking.
