Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B33C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 04:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4022420882
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 04:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgLGEfL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 6 Dec 2020 23:35:11 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:43441 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgLGEfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 23:35:09 -0500
Received: by mail-ej1-f48.google.com with SMTP id jx16so17527520ejb.10
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 20:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0MaDbQGnpey5yMkcrT/RyRPnPf3W5MczJ2Lh0flmHYs=;
        b=aYXEEki/PUWn7m8QT5w2NAlcjgDTf2WvzRbCqf4fwY21toHCbqOxgZftvBwrFtT+7A
         kuXJmBE7vPN7qhtKG7cAezKuBqKVFe6sOQvUKrHc7eEKH41XY/Iej6AmZz1xgkwpPjdM
         Y/99e1xIWmR9AK/YIheCRCgD5m30axXxfNY7DHewhhQYNfVDhMIy4pYdX7Lhh4m1k86s
         pBecAYrqq0oX9UHGEk2xu5z0m81S57JWS6uGB4AFgTE2BeLmghdoBAo/wgjzZcNiDkVm
         KK9MMO18ws2JKJRhT/v5RAQAWS2b9sb06azkRL5FnYITDhr9pPCHxF1kTBuYzB3qbdua
         h7Mg==
X-Gm-Message-State: AOAM530qlzaxzUns63hYcTeUdmQi/60+Yh3J1Rbv2byrdwVxeJdTuRiC
        7ObjNpReko0SJT16sZPQCobS7PtDoLmGk4ABSRw=
X-Google-Smtp-Source: ABdhPJzgBDTzgDlQ/tj+/GfszXTOQGF+8hS5nBK6AC+7qAPGH4gqjT1QTHF4Dm5xM6CqOceDlrLXyHoVLM13BLnb3oU=
X-Received: by 2002:a17:906:614:: with SMTP id s20mr16920739ejb.202.1607315666721;
 Sun, 06 Dec 2020 20:34:26 -0800 (PST)
MIME-Version: 1.0
References: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com>
 <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com>
In-Reply-To: <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Dec 2020 23:34:15 -0500
Message-ID: <CAPig+cTsEx-puHn1N2=fBVAgdvc7cutCDTC7vBJuLm5utObfJg@mail.gmail.com>
Subject: Re: GIT_DIR output from git worktree list
To:     =?UTF-8?Q?Gabriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 1:33 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Sep 29, 2020 at 1:31 PM Gabriel Nützi <gnuetzi@gmail.com> wrote:
> > When you do move the .git folder somewhere else:
> > git init Test && cd Test && mv .git .git-b
> > git --git-dir=.git-b --work-tree . worktree list
> > the output is :
> > ..../Test/.git-b  0000000 [master]
> > Why is the output a .git Dir and not a worktree. I expected `.../Test`.
>
> I suppose one way to fix this would be to specially check if
> --work-tree or GIT_WORK_TREE is specified and use that value as the
> path of the main worktree. (This special case would only be used when
> computing the main worktree path; it would not be used when computing
> linked worktree paths.)

Fixing this is more complex than it seems at first glance. In fact,
I'm not sure there is a good fix at present without somehow recording
the location of the main worktree somewhere.

The problem is that determining the location of the main worktree by
consulting --work-tree or GIT_WORK_TREE when listing worktrees would
only give the desired result when `git worktree list` is run from
within the main worktree. If it is run within a secondary worktree,
then neither --work-tree nor GIT_WORK_TREE would be referencing the
main worktree (at best, they'd be referencing the secondary worktree),
which means that they would not help in determining the location of
the main worktree, thus `git worktree list` in a secondary worktree
would give different output.

Consulting core.worktree _may_ be doable, but it's iffy and would be
extra complicated because that configuration value is treated
specially. In particular, the value of core.worktree of the main
worktree is intentionally hidden from secondary worktrees. So, while
it _may_ be possible to write special-purpose code to go and seek out
the value of core.worktree for the main worktree by manually
spelunking various configuration files, it would be complicated. In
fact, it would be doubly complicated because it would require two
distinct implementations: one for when extensions.worktreeConfig is
enabled and one for when it is not.

The fact that the output of `git worktree list` would differ depending
upon whether it is run in the main worktree or a secondary worktree
(and whether core.worktree is configured or --work-tree or
GIT_WORK_TREE is used) makes me quite hesitant about these approaches.
I worry that such inconsistency would be perceived as instability, as
well as making it difficult to script `git worktree` reliably.

So, at present, I think any solution which can produce reliable,
consistent output may need to record the path of the main worktree
somewhere, but I haven't thought too deeply yet about how to do that
cleanly (while also taking other Git implementations into account).
