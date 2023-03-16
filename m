Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC04C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 20:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCPU2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCPU2A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 16:28:00 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D9A196B4
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 13:27:58 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17683b570b8so3460973fac.13
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678998478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+orkgCxkIyEgT/AR0dXyod4s3mM8xN4YjZo3nOKsMs=;
        b=cPR1Yl3hm/TxB2YoIW53XHLqotbSKWCZxnaYKhc+RX9pTLjJ2yLd4yal0aAT04vBta
         xOzwQR0M1zpNEAn6gEtWMRHj2b2dbdfxYzn7LAX8ldjxMIyTkFwvLM2EPo+wzerOaKpy
         STDqa8fqB+aifz0f9e+iFF4agkKS5xz1VFFOIfbqidO0QtUWaajmq/cQdQjZvYE6tGir
         JN0PkcJliNSLuctib4EbO9l56jBKa28WVgAh9MXqhC4lWJPux0ETtAvxmlk3pZbhw2z0
         rWTPEZa6FYVs4+sf7o5d4QaO+ttnGS4iTdyj4WlOxYAy0/L+YBkcHB/zlj1x8AE0DOJ8
         5beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+orkgCxkIyEgT/AR0dXyod4s3mM8xN4YjZo3nOKsMs=;
        b=31IynZJ5pY7zLyNWj/L4AORFfXxOwh5hLDcleD6/wi1Tfgw1gpblN2QF2Jmy6cWEYi
         hQsV4P0gRVgdu0W0NEkeBhglkq4YqlDa/7xrwRL7HTNKT5QIWP7ar3/tI+tD/16OI/P3
         dF976ggafZ9TwYWDxCrMHRwkiK5EY+E7HHM0kzG3x+PL1NaDhL7OAThLyLKZNilg4NEB
         f2fD8Ml8ZVEujv6Um+fjobvp1+d0kvJiUQS7TyvcZRTA6AWIQxrqoVJw8y0x+UA/aFXd
         /IkPgQCGU802eaf0ogZ+z88UpwlRAtOU4w12PA2ZkrXlTPw0QDJC72nnpwMrluqpOYl2
         hJMg==
X-Gm-Message-State: AO0yUKW3/tmmURA+LMPUtsw2ZT3EYDYNuxVx90krZOxT6nmxQkSB9ZOP
        gbtlU1CGUnJgvU1K5wv3ch+njohZAVZdoPbk2gk=
X-Google-Smtp-Source: AK7set9Ju+HUopMiVndJCM+3dM0tVyIP4y5JBO1B9XKs9rQzHQEdMNRC7EnCsBNcEkYbr006lY7eQh8lI/yAQkpwcRk=
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr7798906oab.9.1678998478107; Thu, 16
 Mar 2023 13:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com> <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 16 Mar 2023 14:27:21 -0600
Message-ID: <CAMMLpeR4x0_u=JGnWQ1xvBeVBXBw7VAgLTWgvHdMFDZLrcy1pA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2023 at 11:32=E2=80=AFAM Glen Choo <chooglen@google.com> wr=
ote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> >> > In the future, the default rebase-merges mode may change from
> >> > no-rebase-cousins to rebase-cousins.
> >>
> >> I suspect a more likely future would be that the default is to rebase
> >> 'evil' merges instead of trying to recreate merge commits, but of
> >> course, the important thing is that we promote the default, not what t=
he
> >> default will be...
> >
> > Glen, do you have any more thoughts? At this point, the only thing
> > that's keeping me from implementing Phillip's request to make
> > --rebase-merges without an argument clobber rebase.rebaseMerges is
> > your suspicion that we might need to change the default rebase-merges
> > mode in the future, and I assume that we would want to use the
> > rebase.rebaseMerges config option to facilitate the transition.
>
> (Sorry for the late reply)
>
> Ah, I don't really have more thoughts on the matter. I am fairly
> confident that we would _like_ to change the default to rebase 'evil'
> merges, but I don't know how likely that will be.
>
> Perhaps it would help to enumerate the rules to see if it is too
> confusing or not?
>
> The behaviors we can tweak are:
>
> - Whether to rebase merges or not (true, false, specified mode, or
>   default)
> - What mode to use when rebasing merges (specified mode or default)
>
> And the sources are either CLI or config, with CLI always overriding
> config.
>
> Should we rebase a merge?
>
> - If neither CLI or config tells us whether or not to rebase a merge,
>   default to "don't rebase merges".
> - If one of CLI or config tells us whether or not to rebase a merge,
>   respect it.
> - If both CLI or config tell us whether or not to rebase a merge,
>   respect CLI and ignore config.
>
> What mode should we use?
>
> - If neither CLI or config tells us what mode to use, default to
>   "no-rebase-cousins" (or whatever default we decide).
> - If one of CLI or config tells us what mode to use, respect it.
> - If both CLI or config tell us what mode to use, respect CLI and ignore
>   config.
>
> If users cleanly separate the two concepts, I think it is quite clear.
> (I'm not advocating for this approach, but) e.g. if we pretend that each
> behavior were configured separately, like:
>
> --[no-]rebase-merges [--rebase-merges-mode=3D(rebase-cousins|no-rebase-co=
usins)]
>
> I don't think there would be any confusion. (Having --rebase-merges-mode
> be a no-op without --rebase-merges is probably even more confusing to
> users, plus this would break backwards compatibility, so I don't think
> this is a good idea at all.)
>
> Your doc patch explains the rules pretty clearly, but perhaps it doesn't
> explain this mental model clearly enough, hence the confusion. If we
> don't find a good way to communicate this (I think it is clear, but
> other reviewers seem yet unconvinced), I wouldn't mind taking Phillip's
> suggestion to have "--rebase-merges" override
> "rebase.rebaseMerges=3D'specific-mode'".

I got the impression that everyone, including Phillip,[1] already
agrees that the proposed documentation is clear about the interaction
between the config option and the command line option. However, it is
a little weird when you consider that other flags with optional
arguments, like `git branch --track`, unconditionally override their
corresponding config options.[2]

Let me ask a different but related question: If we add a
rebase-evil-merges mode, do you think that would be orthogonal to the
rebase-cousins mode?

-Alex

[1] https://lore.kernel.org/git/7cf19017-518b-245e-aea2-5dee55f88276@dunelm=
.org.uk/
[2] https://lore.kernel.org/git/5551d67b-3021-8cfc-53b5-318f223ded6d@dunelm=
.org.uk/
