Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F878C46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 01:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjAPBHb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 15 Jan 2023 20:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjAPBH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 20:07:27 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E814496
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 17:07:24 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id jl4so28758447plb.8
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 17:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6Zvb5XDLDa5jwrYq1uU3ctzsWM8ZHgBJ6pb0Kq+rao=;
        b=vYEd4mMj0Y/V3vECEbP0yQTjmp2+/Mz37dp46Lpke6EcdKy2vrmMI0IY/MFGZ7pznQ
         gEcLQhbvHmVUIm/enF65B1T8EFC690M9a3iHUB2eZqLJbPWuQj2SNhmluH/MbxSxNp2h
         j1gXS7VsSz4DZF8BwbkoW97x27a6smP3JziSCRkB2kT6fEcpfHGLuESSMd6wzBn5WW6Z
         6RiBU1sWB6PmMmzzgdHC02KH3rx2bd+xhhbRBh3WsvUcEPlc1rfDM6xrg0Af/hkii7u9
         LS54mpiYT6civCcj/XTFsuM293oosrESs2CYvMMc5Tm6wG6zJ5wh0UH+6wa4ZXLfOjJE
         V6Zg==
X-Gm-Message-State: AFqh2kqVtQtPbQBAM4GMfaYwo4i+5pbd66ASJyrJnuYqBMqa8MKuGzR1
        SliFqiC9YnVqrwb39AMyNa9xLFadnbc6YuA4aIKWWF5H
X-Google-Smtp-Source: AMrXdXu61fH6kb9hio17kxqT8LRnZy0n0FevVENbp/HhkAlViWOSoUXkIIQbwqslC9tyKsc2epAb+eAzOXZSx1SW9DA=
X-Received: by 2002:a17:90a:9b8c:b0:227:22a6:eff0 with SMTP id
 g12-20020a17090a9b8c00b0022722a6eff0mr2275559pjp.64.1673831244374; Sun, 15
 Jan 2023 17:07:24 -0800 (PST)
MIME-Version: 1.0
References: <CAA3Q-aaO=vcZd9VLFr8UP-g06be80eUWN_GjygfyGkYmrLx9yQ@mail.gmail.com>
 <20230116001144.dt76xk6hkwn45klz@Carlos-MacBook-Pro-2.local>
In-Reply-To: <20230116001144.dt76xk6hkwn45klz@Carlos-MacBook-Pro-2.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 15 Jan 2023 20:07:13 -0500
Message-ID: <CAPig+cQc1+D9gH7BAC-r03bGKWx3a9jpPyLuP-ehH-X2P+fV6Q@mail.gmail.com>
Subject: Re: bugreport: "git checkout -B" allows checking out one branch
 across multiple worktrees
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Jinwook Jeong <vustthat@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 7:23 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> On Sat, Jan 14, 2023 at 06:45:34PM +0900, Jinwook Jeong wrote:
> > 1. `cd` into any git repo that has at least one commit.
> > 2. Identify the current branch, say main
> > 3. $ git branch foo # a new branch
> > 4. $ git worktree add ../new_worktree foo
> > 5. $ cd ../new_worktree
> > 6. $ git checkout -B master HEAD
>
> Was your intention to get this worktree's content back to what is in
> master's HEAD?, then the command should had been
>
> $ git reset --hard master
>
> The documentation might be confusing, but you most likely do NOT want
> to use -B unless you want to force things, but the lowercase version `-b`
>
> > Anything else you want to add:
> >
> > https://www.git-scm.com/docs/git-checkout#Documentation/git-checkout.txt-emgitcheckoutem-b-Bltnew-branchgtltstart-pointgt
> >
> > According to the documentation, "git checkout -B BRANCH START" is the
> > transactionally equivalent of:
> >
> >   git branch -f BRANCH START
> >   git checkout BRANCH
> >
> > When I ran the first command in place of the step 6 of the above
> > reproducing procedure, git refused to carry on;
> > I suppose that this is the intended behavior for "git checkout -B".
>
> I think you are correct, and this is therefore a bug, but there is also
> a reason why `--force` allows doing dangerous things and I am not sure
> if it might apply here.

I'd say there's a bug in `git-switch/git-checkout -B` not performing
the same checks as `git branch -f`. As a result, it is possible to get
into a state in which the same branch is checked out in multiple
worktrees, which is probably undesirable. I looked briefly through the
code but don't have the time presently to dig into it.
