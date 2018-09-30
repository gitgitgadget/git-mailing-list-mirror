Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9071F453
	for <e@80x24.org>; Sun, 30 Sep 2018 07:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeI3N4S (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 09:56:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45362 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeI3N4S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 09:56:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id l2-v6so10880993qtr.12
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 00:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPnhfgget9kES8hwsPN63ZrkEOnJMOfjTuau7NDxsrM=;
        b=QdT7d9wDBszlEeR3bm/0DN49c/SFUJiYv6E+gj1RCVBxJxcwlYnFmL3wnH553XvHeA
         o8Oqswfv2FJor5rXOOdPK+V6IWyqSmsAalO+A4B3pGRGVap+2MFBPTUR48Pwby4MB6cV
         yfioR11SftlCJC6SOU8pzfVQ5Qz1ZcWI/RAOimyt2vaT+F9+xBqg2FkDxU5GiyZEnBp8
         AXRErSTxOHDL7CXa88QKn06IPJXYkw5PL2Bs+L0o5OzqH5f4jTACVlhWf3LZc8EURcRp
         GVre9hn4XL41fRPXO12OFF46PZD+aSvTQerWFslUN6JJ1ytCtPRcoAtiV1H1Q3+iMgB5
         N1gw==
X-Gm-Message-State: ABuFfoiTX5q0T5xvgdu/w4PdJTCzrEJQPUtuylG5ELNzM9VizUZIz+zK
        DgYOT3RrozKnwLfP79MDdmS01WUhJPHJHxy4W/8=
X-Google-Smtp-Source: ACcGV63kEGC4ZcfN1JAYHgaE9LGkBBv+bPzaXzro5+xM0V5EUzc8/4g+ytu9LkmnZKlhNke/mditYJQ4ZQKCNQfXFfY=
X-Received: by 2002:a0c:b3d6:: with SMTP id b22-v6mr4379346qvf.203.1538292266631;
 Sun, 30 Sep 2018 00:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <20180929153005.10599-1-pclouds@gmail.com>
 <20180929153005.10599-3-pclouds@gmail.com> <CAPig+cSv4P99ZJ=CtCC7HctfSg5W6sadiknhk9yXSaBDZ81ctw@mail.gmail.com>
 <CACsJy8AVowvXDkOh_fjdRpNtcXWchxFULbE8m9ZPQN9BsJx5ag@mail.gmail.com>
In-Reply-To: <CACsJy8AVowvXDkOh_fjdRpNtcXWchxFULbE8m9ZPQN9BsJx5ag@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Sep 2018 03:24:15 -0400
Message-ID: <CAPig+cTJKuEkb5AVi=xyztfEo84NzaduNnX3mhec3xrYf4PGUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: add per-worktree config files
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 30, 2018 at 3:16 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Sep 30, 2018 at 6:33 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > diff --git a/builtin/config.c b/builtin/config.c
> > > @@ -645,7 +649,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> > > +       else if (use_worktree_config) {
> > > +               struct worktree **worktrees = get_worktrees(0);
> > > +               if (repository_format_worktree_config)
> > > +                       given_config_source.file = git_pathdup("config.worktree");
> > > +               else if (worktrees[0] && worktrees[1])
> > > +                       die(_("--worktree cannot be used with multiple "
> > > +                             "working trees unless the config\n"
> > > +                             "extension worktreeConfig is enabled. "
> > > +                             "Please read \"CONFIGURATION FILE\"\n"
> > > +                             "section in \"git help worktree\" for details"));
> > > +               else
> > > +                       given_config_source.file = git_pathdup("config");
> >
> > I'm not sure I understand the purpose of allowing --worktree when only
> > a single worktree is present and extensions.worktreeConfig is not set.
> > Can you talk about it a bit more?
>
> Unified API. If I write a script to do stuff and want it to work in
> multiple worktrees as well, I should not need to do "if single
> worktree, use "git config --local", if multiple use "git config
> --worktree"". By using "git config --worktree" I tell git "this config
> is per-worktree" and git should do the right thing, single worktree or
> not.

That's what I thought, but I still don't understand how that unified
API is going to help if the script writer happens to have multiple
worktrees but doesn't have extensions.worktreeConfig set, in which
case the command will error out. I don't see how that simplifies
things, but perhaps I'm missing something obvious.
