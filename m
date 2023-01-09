Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78226C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 21:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjAIVro convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 Jan 2023 16:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjAIVrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 16:47:24 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51FF1CFF6
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 13:47:23 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso9486682pjl.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 13:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A61ZEWy5lgGHF2Il/RYO2XqnniwbXSDEXJopkUH6cIA=;
        b=FaIcj3N+yDAfd4SQvSrgAtI8QiW2qhtOsBUbXKACAluYVz8ttXw1loEhN7odHnoExm
         m83yO9RPrvoMQJSToqfs1cGIgNERKhq6aC4Zc6DIZXECoau3v96xkDC35NB33r5W6BQ9
         yDtPHbsB6+T5t6x3YOFZ30I1namvQkCSsjRkD/oViSHwvfsF5uPJaKPufBYQhWwb2T9C
         Nrk7+cTw8umrqhC7dCH1EuFEi1wZo7PvK1aec2o5vFtI3yG8q4AaK7NbAm/EHviyDqgC
         DTHPivQJiZ88vHipKXsd2iRq15DZsXd0N2TwwjsQSUW2b/jyG3/X+L9184wraAF0xWUT
         1wCw==
X-Gm-Message-State: AFqh2krFuo9kW0QPex1Z9OesEjdY53t8L3g+bqPyT+60eTtMH1VbXhRM
        NJsshKboARvg3dlpZdox2ndh5Z8TBv8K8q4n+f2w6CAE
X-Google-Smtp-Source: AMrXdXsbkgvA4vp/ndn6jA2i3NobHjkwdklGVxNe4wSl7LrU6e6NBKWnc9iEzykkwu75c6BOAzHvTqvoPL+aQ+ZjPC4=
X-Received: by 2002:a17:90b:48cf:b0:226:164f:522e with SMTP id
 li15-20020a17090b48cf00b00226164f522emr3165217pjb.22.1673300843151; Mon, 09
 Jan 2023 13:47:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
 <CAC-j02O6z4sG85LpRNzEZ52Y-McurYDa_VnVXtqFVPBFu9kbug@mail.gmail.com>
 <CAPig+cS_dXL-Q6NZtUJxDOL4-Q=MJv8fPEPAnEPuONaNF8-sCA@mail.gmail.com> <CAC-j02MV+Gv0D8-fpCOu7JGUimxPLF+OP1dy7bxfs7ArX05BYg@mail.gmail.com>
In-Reply-To: <CAC-j02MV+Gv0D8-fpCOu7JGUimxPLF+OP1dy7bxfs7ArX05BYg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jan 2023 16:47:12 -0500
Message-ID: <CAPig+cQo3sEJHcQkS6O03Hw5+8NzrMaHwqcR5WwjmVK2s0bcyw@mail.gmail.com>
Subject: Re: [PATCH] githooks: discuss Git operations in foreign repositories
To:     Preston Tunnell Wilson <prestontunnellwilson@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2023 at 9:54 PM Preston Tunnell Wilson
<prestontunnellwilson@gmail.com> wrote:
> > So, no, I don't think this qualifies for the BUGS section of
> > git-wortkree, and mentioning this potential gotcha only in
> > git-worktree but not in any other hook-running command doesn't seem
> > ideal either. At present, the best place to discuss it seems to be
> > Documentation/githooks.txt, as this patch does.
>
> I agree the best place to put it is in Documentation/githooks.txt. I
> also agree the BUGS section doesn't make sense, but I'm still
> wondering if we should call it out in git-worktree.txt in addition to
> githooks.txt. When I ran into this issue, I tried to compare my setup
> to that of my coworkers. The difference was that I was using
> git-worktree, they were not. git-worktree's documentation lists:
>
> Within a linked worktree, $GIT_DIR is set to point to this private
> directory (e.g. /path/main/.git/worktrees/test-next in the example)
> and $GIT_COMMON_DIR is set to point back to the main worktree’s
> $GIT_DIR (e.g. /path/main/.git). These settings are made in a .git
> file located at the top directory of the linked worktree.
>
> To me, this is the "other side of the coin" of your patch. (Or maybe
> one of the many other sides of the coin for commands that can run
> git-hooks.) Mentioning a potential collision between git-hooks and
> these variables being set could maybe go in the above snippet, maybe
> in parentheses. It took a lot of working backwards to narrow the issue
> to the interaction between git-worktree and git-hooks rather than the
> package manager I was using or the tool the hook was calling. Putting
> a note in the git-worktree documentation (in addition to the note in
> git-hooks) might help out someone in the future, but I defer to your
> judgement. If it doesn't make sense, doesn't fit, or adding it here
> would detract and make the documentation more confusing, I am happy to
> leave it out.

I understand your concern, and can relate to the amount of effort it
took to narrow down the problem. Nevertheless, even though you
encountered this problem in relation to git-worktree, it's a more
general issue which can manifest in other situations. As such, I can't
think of a good way to discuss the issue in the git-worktree
documentation that wouldn't feel out of place and make the
documentation more confusing.

I'm not necessarily opposed to someone else giving it a shot if it can
be done in a way which doesn't feel out of place and doesn't confuse
git-worktree documentation further (especially for those new to the
documentation). I just don't know how to do so myself.
