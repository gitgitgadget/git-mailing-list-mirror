Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEF6EB64D9
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 04:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjGLEsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 00:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGLEsV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 00:48:21 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3FA100
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 21:48:20 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b73a2d622dso241953a34.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689137299; x=1691729299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qemKQ9sNdQGxdD+RU1K3C79+eoyC6Cke/dmxrdK631Y=;
        b=hh8brDtW4lhceGg1ecZAybfhPkudEF2EmZptkWSh556tReRAo3JRJUwPs3OzK+4UcP
         S5BQJ00Bq/HqfEm35RnAPp27AoUhYdkgGurhnutlyg2ldxbdnyJ457nigX2LBlgINFwv
         75HnQGz3UE79Fh075chHxW2LV1Tcfb3G7XvlaFwenYG/ItaJQCeIFZHSE4QYPVEotFKT
         qRu8VRrKTiFD8GHQ10IHzvsGVcdLxzrDXruT7RbcQcJC59CBl4MWIntHATwQ67PaLWSL
         oxDgteteVOjKaL1Yq66CD6yC4OsiKAWXHzjvgV2purJHDoNSrL1voeNTGCbn52KFJXGW
         IXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137299; x=1691729299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qemKQ9sNdQGxdD+RU1K3C79+eoyC6Cke/dmxrdK631Y=;
        b=KtsaRbNgMwOcI0V6k8fF0ImQM3LT4VJ5l4/YM4GRtceBWGOl3an/XHG+THqU0BP9QD
         B5aeMFumCl5vwHtTF0jQaO2hJAR79eTnwJTttp+GbFhaeYen8jbt9TDp93WTc4z/FeVs
         cVWhGnbDUaMGqLPPhdGInW0Pk8Dg0fdPiZ0ik9ZhKxsUqrrmBDhFTmWaf23Y5E0HlWBQ
         epx6VPoA+091495VoK4JzYIWMIsq81rjSdT9zPkjhdFDkp9w9UTWJwP8eP60FF3NFplK
         GSIdU1RPBOHuBh41i7zQ+k6mIch4d475o5F6pDvd/LZ467GcOhCQrLF0VqwejJVtTtQF
         q4ig==
X-Gm-Message-State: ABy/qLbwwualHJWNgfmJRl3/0XyhdYxViVdtoO6aQv/dZek8+aWNY2RS
        fGTk4vQug3kvTd9pTh6ee8ASG12kz/0cmZErKgPaYdb8zvU=
X-Google-Smtp-Source: APBJJlGoXgnCbDp84PFpD0bG7MUi/C0PYoOIOGlPjwz/hBIqdCzOfdM83PUPYT1YXAZ7NeQAhhbdg5dBF+895Y6hXMc=
X-Received: by 2002:a05:6830:26ec:b0:6b5:e68e:e0f2 with SMTP id
 m44-20020a05683026ec00b006b5e68ee0f2mr489638otu.3.1689137299200; Tue, 11 Jul
 2023 21:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com> <20230706040111.81110-3-alexhenrie24@gmail.com>
 <82255166-49ac-3c10-1744-27d6d436822e@gmail.com> <CAMMLpeSk7_2xn_atUoVeyFSHwE3TNDijSwDMo6PVbvf4XFUvtw@mail.gmail.com>
 <3479e947-76ce-2eb6-8ae0-5360311c5967@gmail.com>
In-Reply-To: <3479e947-76ce-2eb6-8ae0-5360311c5967@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 11 Jul 2023 22:47:43 -0600
Message-ID: <CAMMLpeQ5fqCQnxT9cPhYV0pwr+PB5WCVeum21YVUR153hnSFnQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] push: advise about force-pushing as an alternative
 to reconciliation
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2023 at 12:33=E2=80=AFPM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:

> On 08/07/2023 19:56, Alex Henrie wrote:
> > On Fri, Jul 7, 2023 at 2:49=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >>> +        "before pushing again, or use 'git push --force' to delete t=
he remote\n"
> >>> +        "changes and replace them with your own.\n"
> >>
> >> I think it would be good to give a bit more context here as to when
> >> force pushing is a good idea. For example something like
> >>
> >>       If you have rebased the branch since you last integrated remote
> >>       changes then you can use
> >>       'git push --force-with-lease=3D<branch-ref> --force-if-includes'=
 to
> >>       safely replace the remote branch.
> >>
> >>       If you have deleted and then recreated the branch since you last
> >>       integrated remote changes then you can use 'git push +<branch>' =
to
> >>       replace the remote. Note that if anyone else has pushed work to
> >>       this branch it will be deleted.
> >>
> >> It makes the advice longer  but the user get a specific suggestion for
> >> their current situation rather than a generic suggestion to delete the
> >> remote changes without discussing the implications. In this case we kn=
ow
> >> that it was the current branch that was rejected and so should fill in
> >> the branch name in the advice as well.
> >
> > Even if we could fill in <branch-ref> automatically, it's too much to
> > ask the user to type out --force-with-lease=3D<branch-ref>
> > --force-if-includes.
>
> Can't they just copy and paste the command from the advice message? Even
> if the user does not copy and paste it is not that hard to type it out
> with the benefit of the shell's tab completion. You're basically saying
> this combination of options is unusable in practice because it is too
> much effort to type them. We could look to see if we can make it less
> unwieldy by changing push to allow --force-if-includes=3Dref imply
> --force-with-lease for instance.

Yes, `git push --force-with-lease=3D<branch-ref> --force-if-includes` is
cryptic and unwieldy, and even asking users to copy and paste a
command is a bit much. If that's what's presented as the alternative
to integration via `git pull`, it could make users who want to
overwrite the remote branch think that force-pushing isn't what they
want because what they want is conceptually very simple, so they
expect it to have a simple user interface.

It's possible that improvements will be made to this user interface in
the future, but that's definitely not something that I'm going to
tackle. I just want Git to give decent advice about what is available
right now. If we can't agree on what specific command to recommend,
maybe we can at least agree to tone down these messages to not sound
so prescriptive. Just changing "Use 'git pull' to integrate..." to
"You can use 'git pull' to integrate...' would be a big improvement.

Thanks,

-Alex
