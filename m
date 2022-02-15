Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66B2C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242266AbiBOWBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:01:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiBOWBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:01:54 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A57E09C
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:01:44 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id v4so505620pjh.2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0qOc2hFP1fesHedmkP2dd5sEwYzX5J0czZdqXkGEBY=;
        b=gHB3uJydOxV+qGFfEztNpCYsXwBxyKsP+KMHyCKZ/CNpjTUzoitbMAMH6ZttYK2jFV
         W9icFD6AWTQmzwLkxTqf3guU1HUQkh115MdfqFZfvbaYY2TeJP0Ddd0n+Kd2TT9jT3RP
         VgOKLZgDCa0VTLK/d/sWeR/sRu0TO1mKLIZOfl17XTOa4NGITMlNmPbdPerGdzB7wLS2
         hPtnqfZsGYYRKGPi5fNeFw7NY1Jk+p71XTmFeyVITKwuwOL1lIGm+GnBWY5nA+dX1wQ3
         U57/Vv3B3zeiC/9MWtpeKf9lSTottT64rKnfvQsiy1DqdrjB385xl13zFUWq6y5GiIdp
         8TIw==
X-Gm-Message-State: AOAM531E8Il7Wd2xFxHuWZ4EPo/ADSYEYNh9rXicHprwBqEu7soze6Y/
        x5pnP516NYDykOtR6kx34LRtLLghnZDarx300I8=
X-Google-Smtp-Source: ABdhPJyI7vp5N9P1f4aa7LJrTiQWv3+b+bSHoJMVOKGyiOrNGx99RpP4jxK67OIIzdqhCY7HBjdBdJfxUT+jkyV9Lbs=
X-Received: by 2002:a17:902:a988:: with SMTP id bh8mr1080885plb.35.1644962503905;
 Tue, 15 Feb 2022 14:01:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com> <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
 <CAPig+cQOieO3cmZv42G_8XRiMwkh4v3cO1AYg5VR9SiPNMwxhw@mail.gmail.com> <93747eca-08d6-0be9-08c7-42c81340b788@gmail.com>
In-Reply-To: <93747eca-08d6-0be9-08c7-42c81340b788@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Feb 2022 17:01:33 -0500
Message-ID: <CAPig+cS6Of=1OOw-6MOCBJVW6_FxtGw_ciUR=RTYakdy=1Z_hA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config
 on add
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 7, 2022 at 9:30 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 2/6/2022 6:30 AM, Eric Sunshine wrote:
> > On Mon, Jan 31, 2022 at 10:01 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +               git config --worktree bogus.key value &&
> >> +               git config --unset core.bare &&
> >
> > Why is this being unset? (Genuine question. Am I missing something obvious?)
>
> I'm moving it out of the common config file. Earlier commands
> enabled it in the config.worktree file for this working tree.

But won't the `git worktree add` commands which immediately follow
this bit automatically drop `core.bare=true` from the common config
file? Or am I misthinking on this? Or are you just trying to be
explicit here with the manual removal?
