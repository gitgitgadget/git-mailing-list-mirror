Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C23FC6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 11:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCMLtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCMLtW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 07:49:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F65F6F8
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 04:48:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l12so2738717wrm.10
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678708133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keg4iVLCjMZeJOZqbOYxYneNnRz5cnZnTKNPUdCZn1g=;
        b=Y2nqmgyuXx+myc1IX5Qamu4a7AvznLI+uc2ROp7vtx+ZBXDrAD1Qx0zdN1qHAEeuc4
         9sGk59vedDhQs9DU/lHND5lspMQK+RSaOWdVZAL+5ZdUkiFnv0W6eMpGA4OtjXZ/hNNG
         +k7v4+K2OqB8wAUfntIsDHybiKfn/VW1RuD33uO2BVyROV44nG6ESqY1EaDz+UlgWpBO
         Mp/NEwef5lb7Ej0sW6U1dlkCzpoTjkTIHMebQTRqAvSXJxHt/+Z/peVefy6OXmdzrCFT
         yA/6SUoGxfaD6xm9jA6R/w6F5+gJ4bLCMqVFxXxvYJuV0fmoG/lA0U5h9k19QTZooylb
         ZOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678708133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keg4iVLCjMZeJOZqbOYxYneNnRz5cnZnTKNPUdCZn1g=;
        b=LXsJSQfW/NF2OfeftbMOjuMOuBQGxMbwnWNumCZFtWx460xjTpa87l2WZjBmTu8vtu
         Ix87/hVP7PrlFvPkvgQqmkD4yKW7+nLo/TadmTU6AxScTyA8TbjQXbePKHBWb2gTCW/e
         UkoMWe0cwtSdc3NwroP+qCJOdz2YF0C3qoupTbz/5W9JOsG5KeV/LWrYnpteczuib9FR
         UJQIcthlnSUFoYFMPFXwCs4CB7xpA+wRqVY2kX75lud/mkQavKxcdVKXysOIH/cCgG5v
         tvIOQ22xPRqCn13cl6ZmzNew4N8ReontdkSPv499/Iry605+O5XO7xp60AQezgksk98D
         H+5g==
X-Gm-Message-State: AO0yUKWIDyFq4H0AN6pg8ZVZlNpAgiVBQLb342VUny8aVuoxc+wQthZA
        Wkcvf3cMyDufqMj1SSkVQokIqHrMqk2lb2FumskUHsdCo7U=
X-Google-Smtp-Source: AK7set+3E5M/WbuOmZRqWjFn4FzstFvt+lWfswk61fCxOc3x9PlRIkxyZ4oFYfOivODfb231+jleWxtdgC9BwYYaymY=
X-Received: by 2002:a5d:6512:0:b0:2c8:6dd3:a2c5 with SMTP id
 x18-20020a5d6512000000b002c86dd3a2c5mr7142601wru.6.1678708132500; Mon, 13 Mar
 2023 04:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAAo-ADZBBRxSROeAwrA9o30Etf3QQhLCaWQJtVsChVwT-AbgTg@mail.gmail.com>
 <xmqqwn3pai2d.fsf@gitster.g>
In-Reply-To: <xmqqwn3pai2d.fsf@gitster.g>
From:   Ilia Pozhilov <ilyapoz@gmail.com>
Date:   Mon, 13 Mar 2023 13:48:40 +0200
Message-ID: <CAAo-ADbDW3WCuRFCnNopg31B_hDumz5qVOzirczG70odSVa6Bw@mail.gmail.com>
Subject: Re: Track git blame through two unrelated histories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Track git blame through two unrelated histories

Inbox
Ilia Pozhilov
Thu, Mar 9, 1:05=E2=80=AFPM (4 days ago)
Hello! I have a weird use case. A repository at my company was
migrated git -> non-git vcs -> git again. During transition to non-git
vcs the history was lost,

Junio C Hamano <gitster@pobox.com>

Thu, Mar 9, 8:35=E2=80=AFPM (4 days ago)


to me, git
Ilia Pozhilov <ilyapoz@gmail.com> writes:

> So let's say I add two remotes and fetch all the commits, but they
> look like this:
>
> A->B-> .... . . . -> Z    history1
>
> 1 -> 2 -> ..... -> 0 history2
>
> and file contents in commits Z and 1 are exactly the same, but the
> commits themselves are completely unrelated for git.

You mean you want to pretend that history "2 -> ... -> 0" was built
on top of Z?  Here I am assuming that time flows from left to right
in the picture.

If so, you should be able to graft the histories together, perhaps?

Totally untested but something like

        $ git replace --graft 1 Z

based on my reading of "git help replace" should allow you to
pretend that Z happened immediately before 1.



Junio C Hamano (gitster@pobox.com), git@vger.kernel.org
Plain text






Ilia Pozhilov <ilyapoz@gmail.com>

Fri, Mar 10, 6:32=E2=80=AFPM (3 days ago)


to Junio
Thank you very much for this! It worked, I found the corresponding
commits and did exactly as you suggested. Now blames just work!

Now I will need to figure out if this is push'able to github, but even
at this stage it's incredibly useful, I love blames!

On Thu, Mar 9, 2023 at 8:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Ilia Pozhilov <ilyapoz@gmail.com> writes:
>
> > So let's say I add two remotes and fetch all the commits, but they
> > look like this:
> >
> > A->B-> .... . . . -> Z    history1
> >
> > 1 -> 2 -> ..... -> 0 history2
> >
> > and file contents in commits Z and 1 are exactly the same, but the
> > commits themselves are completely unrelated for git.
>
> You mean you want to pretend that history "2 -> ... -> 0" was built
> on top of Z?  Here I am assuming that time flows from left to right
> in the picture.
>
> If so, you should be able to graft the histories together, perhaps?
>
> Totally untested but something like
>
>         $ git replace --graft 1 Z
>
> based on my reading of "git help replace" should allow you to
> pretend that Z happened immediately before 1.
>
