Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F85C433F5
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 01:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiDQCAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 22:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiDQCAM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 22:00:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8895513F61
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 18:57:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v4so14010160edl.7
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppggUTizWS4J5ficyPQ0BkL/zk7MuUsDW2PMtDzDq64=;
        b=QYpzbV/x0fMvdp9orezciNwA/4E7vA/4gaXbmCn5/U7aWDmNUyA7tZOXz1caaQ4r5e
         2NLZJ1SJ0qkdBw4+i1kKsKGpIk3aOMoN41vaic5RsIdnALSEMhRzb1plC1CEUZKsDJ7n
         6kNPceIb8dQvzkh8Nr9qBpYrXpQRqefwnapYExkISOGeTR2zxr+McqVRBZpGtxDO1PGQ
         Oc1iqmVNs8Sh1iZFCV4zid6Wg6k3T/d1VKXVBcnOR4ll2aCP1wJeLsGLJWW/X6hQY3vx
         9BFXn14ioiKNIvtiEH9X7pedDjOYy7FCrVXkKdAZhDbOT1J0XmFwIBwX0Oy6kra0Pi3F
         5sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppggUTizWS4J5ficyPQ0BkL/zk7MuUsDW2PMtDzDq64=;
        b=WKiWPYsVROD3fFqy4sJN/nIOY7Y8KQdrGRFlENBwJzdjqAlr1cwhKhKLIJxUDDmWR5
         q+wBxeaJb4qnaUq0fdzUkdN12ENIOs1VDQzwgTx9vTevai1E5J9uG8cmpBPT66GIQ6j5
         REtcgpkLuXFGXMsiPBIPweGd+4coFBq5KHLWxeKxnIk/YsaGeeytBP53b/s2CBpY/8HR
         SPkxvpJsy82OQLvQvRAh/sK24RieGNa75fp/24pfTVrOiZexjcRF9jViKdbbIJ5fmLkB
         qO8P0h49kuodWSMFXReEe0+JUPLmUoFU3JOocmj6dLDuiZ8SObiuFmgQF8WMaAvl/Ipv
         Kr/g==
X-Gm-Message-State: AOAM530grUde3MSyHcM/WaT9QqVw0kvqToeyyBhtbGYVkxLj05HHNJ3w
        P2azPyO1b/a2AeveYCfR9FqIdhBtwn9KpEbvWrdLB6GV
X-Google-Smtp-Source: ABdhPJzrf84Zx6+vxJR2be12tBL2cT1QQHPFNJNgh7ZA8nnID0uxjlXS1vpxI0gT5sHnkRXytYBN01QTheAL10LzQRo=
X-Received: by 2002:a05:6402:34cf:b0:419:75b1:99ad with SMTP id
 w15-20020a05640234cf00b0041975b199admr5984461edc.228.1650160657121; Sat, 16
 Apr 2022 18:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
 <493254ffbb8b11f325f5995790341d70198b5c97.1645441854.git.gitgitgadget@gmail.com>
 <CAP8UFD0+V38FC8HZenFVRUputH+eD5cfXAQUZug3RWWMv==LBw@mail.gmail.com> <cde32b70-2f01-925c-2456-8f45fa8c5188@gmail.com>
In-Reply-To: <cde32b70-2f01-925c-2456-8f45fa8c5188@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Apr 2022 18:57:26 -0700
Message-ID: <CABPp-BEX1SJwtxLh8f-Mpc_YeaEs5UJSAZ0+P+Y0ZYKNN=vHAQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] rebase --merge: fix reflog when continuing
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 5:23 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Chirstian
>
> Thanks for taking a look at this series
>
> On 07/04/2022 14:49, Christian Couder wrote:
> > On Tue, Feb 22, 2022 at 6:12 AM Phillip Wood via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>
> >> The reflog message for a conflict resolution committed by "rebase
> >> --continue" looks like
> >>
> >>          rebase (continue): commit subject line
> >>
> >> Unfortunately the reflog message each subsequent pick look like
> >>
> >>          rebase (continue) (pick): commit subject line
> >>
> >> Fix this by setting the reflog message for "rebase --continue" in
> >> sequencer_continue() so it does not affect subsequent commits. This
> >> introduces a memory leak similar to the one leaking GIT_REFLOG_ACTION
> >> in pick_commits(). Both of these will be fixed in a future series that
> >> stops the sequencer calling setenv().
> >
> > Yeah, it looks like we will leak only a small string.
> >
> >> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> >> ---
> >>   builtin/rebase.c          |   2 -
> >>   sequencer.c               |   5 ++
> >>   t/t3406-rebase-message.sh | 120 +++++++++++++++++++++++++-------------
> >
> > The changes to the test script look a bit involved and aren't
> > explained in the commit message. I wonder if some of those changes
> > could have been made in a preparatory commit.
>
> That's a good point. For some reason when I put the series together I
> thought it would be tricky to do that without the fixes in this commit
> but that is not actually the case so I'll split the test changes out.

That would be very nice; I'd like to see it split out too.
