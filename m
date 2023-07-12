Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FCDEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 04:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjGLE4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 00:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGLE4E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 00:56:04 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6269110D4
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 21:56:03 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b7279544edso5232458a34.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689137762; x=1691729762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG4aIxFLbHV7Je2Scre3TwbU/8xHRiAuL4k5PDSeoUc=;
        b=NuLsyNmY0A3u/qQRntnE31vcJXJVQKwmRJobnmVNlN08cWc3VuqGugEOsr6F8JP3/o
         OjaTdC4KfLF/K7YeERsjR38WyBc49k2Vjl5oiMHYHzkhZcGyI88kCNimtCQyz1IfENxg
         D0ohttL3guPHexAub0bVq3KE2ybYiSyKcjrISVS3W6DWb+rE3p1cjqeSBlWs4ojgROn4
         /NjxuzCVnqX7JvVkHhv85iHTIYaVqN6kJPAgAiOqaNDFSxr4J9LEvqfp3hG5mS74VUBX
         1V0oIy+avl+LEJ3mLFk+rZtJmfIf2lxex+1OXAm/lQH4tP9/R0z7XbMpWkbjkupjtOeC
         Psrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137762; x=1691729762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JG4aIxFLbHV7Je2Scre3TwbU/8xHRiAuL4k5PDSeoUc=;
        b=Z4TB83jpP9RNUjLz+dk4fEKLXeN23hKzLVRz7xI27KXsCcLbETV6wD3Ix3tF07+64w
         JYtzKgdjt/RhlhXMZ8/KYggTbC5qN+dP04VoiFsTm0SdSBktmQxv5iMe95CWLkHDoD+n
         QTt/BSqkcJlnVXGT+SqbtSil4RlRxvxNbDLi+UdL4nhMQhHRZJPRj+MRhtlBd6RJLopS
         HAgn7YtfbQ096NJN0goXF2+Kh5tIoPE5nanCe+krghedi7DQw7oQkiH1pW/PsARjVsD3
         Sr/RvJvdf4NHN5/d+VciBOeSwwYG640xuAbhBpeKNvVJEV5HeMmDDYkdz9/QeLAow2L/
         BPxg==
X-Gm-Message-State: ABy/qLYZxuLEd1D7uKt7SGdZuR/5DOxqYxEnRTITkbcQmiggwHk0Rxvw
        mC81/HNBnRmwmlUCZdsUu+ps7Tcl4ynWvTTXhBs=
X-Google-Smtp-Source: APBJJlHv4Vb2y1jVTndv772VkeAcAueGXFj8k/ZY4TYdQbvoHZm+pijXSLRDGxPbxUZlwnpe2NAkZ3VMhD82F/hXySo=
X-Received: by 2002:a05:6830:1550:b0:6af:a0d7:1819 with SMTP id
 l16-20020a056830155000b006afa0d71819mr16420427otp.28.1689137762616; Tue, 11
 Jul 2023 21:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com> <20230706040111.81110-3-alexhenrie24@gmail.com>
 <82255166-49ac-3c10-1744-27d6d436822e@gmail.com> <CAMMLpeSk7_2xn_atUoVeyFSHwE3TNDijSwDMo6PVbvf4XFUvtw@mail.gmail.com>
 <3479e947-76ce-2eb6-8ae0-5360311c5967@gmail.com> <CAMMLpeQ5fqCQnxT9cPhYV0pwr+PB5WCVeum21YVUR153hnSFnQ@mail.gmail.com>
In-Reply-To: <CAMMLpeQ5fqCQnxT9cPhYV0pwr+PB5WCVeum21YVUR153hnSFnQ@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 11 Jul 2023 22:55:26 -0600
Message-ID: <CAMMLpeQGjqsP0cFGw-RB7P2OozkpN6e-1H2=4C3VHWqpPuf8PA@mail.gmail.com>
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

On Tue, Jul 11, 2023 at 10:47=E2=80=AFPM Alex Henrie <alexhenrie24@gmail.co=
m> wrote:
>
> On Tue, Jul 11, 2023 at 12:33=E2=80=AFPM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
>
> > On 08/07/2023 19:56, Alex Henrie wrote:
> > > On Fri, Jul 7, 2023 at 2:49=E2=80=AFAM Phillip Wood <phillip.wood123@=
gmail.com> wrote:
> > >>> +        "before pushing again, or use 'git push --force' to delete=
 the remote\n"
> > >>> +        "changes and replace them with your own.\n"
> > >>
> > >> I think it would be good to give a bit more context here as to when
> > >> force pushing is a good idea. For example something like
> > >>
> > >>       If you have rebased the branch since you last integrated remot=
e
> > >>       changes then you can use
> > >>       'git push --force-with-lease=3D<branch-ref> --force-if-include=
s' to
> > >>       safely replace the remote branch.
> > >>
> > >>       If you have deleted and then recreated the branch since you la=
st
> > >>       integrated remote changes then you can use 'git push +<branch>=
' to
> > >>       replace the remote. Note that if anyone else has pushed work t=
o
> > >>       this branch it will be deleted.
> > >>
> > >> It makes the advice longer  but the user get a specific suggestion f=
or
> > >> their current situation rather than a generic suggestion to delete t=
he
> > >> remote changes without discussing the implications. In this case we =
know
> > >> that it was the current branch that was rejected and so should fill =
in
> > >> the branch name in the advice as well.
> > >
> > > Even if we could fill in <branch-ref> automatically, it's too much to
> > > ask the user to type out --force-with-lease=3D<branch-ref>
> > > --force-if-includes.
> >
> > Can't they just copy and paste the command from the advice message? Eve=
n
> > if the user does not copy and paste it is not that hard to type it out
> > with the benefit of the shell's tab completion. You're basically saying
> > this combination of options is unusable in practice because it is too
> > much effort to type them. We could look to see if we can make it less
> > unwieldy by changing push to allow --force-if-includes=3Dref imply
> > --force-with-lease for instance.
>
> Yes, `git push --force-with-lease=3D<branch-ref> --force-if-includes` is
> cryptic and unwieldy, and even asking users to copy and paste a
> command is a bit much. If that's what's presented as the alternative
> to integration via `git pull`, it could make users who want to
> overwrite the remote branch think that force-pushing isn't what they
> want because what they want is conceptually very simple, so they
> expect it to have a simple user interface.
>
> It's possible that improvements will be made to this user interface in
> the future, but that's definitely not something that I'm going to
> tackle. I just want Git to give decent advice about what is available
> right now. If we can't agree on what specific command to recommend,
> maybe we can at least agree to tone down these messages to not sound
> so prescriptive. Just changing "Use 'git pull' to integrate..." to
> "You can use 'git pull' to integrate...' would be a big improvement.

Whoops, I accidentally quoted my own proposed text as if it were the
current text. The current text is in fact "Integrate the remote
changes..." which is stronger still.

-Alex
