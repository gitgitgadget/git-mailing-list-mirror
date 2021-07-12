Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE3CC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 23:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1D560C3D
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 23:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhGLX1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhGLX1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 19:27:14 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C32C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 16:24:24 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t25so7728901oiw.13
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 16:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZWjyvDgrO6lrdRob8NGW9BB1mQByA3HwdeoWfQ8AsY=;
        b=H9v6O99w9uRN/dlFvwmHBegCKzvh5EAc8vzqcg4c+aTMmZeBO4omfg9MClFgbptKDb
         W63p7FTwdx8Zfdipz313LBdOqb+1CRvjzyMV7/1seAevZokdWeLfM9/Lzt0CnIuP6Tzb
         pLU32KI5YmyeJulM186Wxk0i0+p7ELkypXm4tw0wBeYHIqWc6Hf3wrKppG8exl3+uN9G
         QmyQoitxe+KzwB7lDHxcivgFUMULr7l8Z2tc4spZC2mHOSlDNBxDvjebF+jZhOv+OQmB
         VdX7sjT8w0pAjKfHzdya7sXk/z/dLDWUPH0hBStl3RSI4jIV6Qb9HDTfZhJIOgKZwjEA
         +G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZWjyvDgrO6lrdRob8NGW9BB1mQByA3HwdeoWfQ8AsY=;
        b=O4m9Kb4IuMN4BGY+wfuxR/u91n7tcw1nY+O5m0pxZsA9kFtSFvrNyFVEKqD6mFas7H
         wWiMRbGPsMXRBTrF12vqhVlVMY9+u+Fkvj8NAzF1jFD0WmGHZo1JRbms7p4oezqre8VZ
         g1qjGmU1FxdFnDkh/kZCyMp7HsMNJBNAjCOj5iTmDFnlm6o2tGXaXZ4wht8f0dSK4BpT
         AeWH+PUhD1VvcJrnFUsUASOlp9gRAtcf5MKbzj5CTdMHB6Vy8bFEOIqZ+QHWkHa4vC83
         K8USi8wUwQMp7h/bvLnK/5cli67+uP6dAJ4e4V+Dd6wFOr7CHfEcnF+vI/seyZbHxa1O
         Il2g==
X-Gm-Message-State: AOAM531hL5NieeFz1me8rBN6myP8sAO19idasre5SnLOvjibZX+of4ve
        VQ5lFGGF3JowHSWjNwxHhT9EYdES1PSL1+ROJu66hE8ECBM=
X-Google-Smtp-Source: ABdhPJwYl5s24eCrVR6KYFR1Tj5+7q0ljuFP0QWrnImoGK/1suMZJSPHYHE5qgm4+q+h6xWd69GUmvJUeqmmuVtW0M4=
X-Received: by 2002:aca:f0a:: with SMTP id 10mr12545322oip.39.1626132264115;
 Mon, 12 Jul 2021 16:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com> <xmqqpmvn5ukj.fsf@gitster.g>
 <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
 <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
 <CAMMLpeSBgURtX+MKbABKdmFuuoTA-Dw3h8uONwNeiP5aqcnfpA@mail.gmail.com>
 <xmqq8s2b489p.fsf@gitster.g> <CABPp-BH+LPbfdgixvSEGpLxwCHHSK99PFmE3q04jPZjLaqr5Xg@mail.gmail.com>
 <xmqqbl772l4m.fsf@gitster.g>
In-Reply-To: <xmqqbl772l4m.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Jul 2021 16:24:12 -0700
Message-ID: <CABPp-BHV4bkyKswbg0gBH8uJG7knH4fBC=fitRJK4_LCP50Tog@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 4:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> When we cannot fast-forward (i.e. we have our own development that
> >> is not in the tip of their history),
> >>
> >>  --ff-only would cause the operation fail
> >>  --ff would become no-op (as it merely allows fast-forwarding)
> >>  --no-ff would become no-op (as it merely forbids fast-forwarding)
> >>
> >> and the latter two case, we'd either merge or rebase (with possibly
> >> specified mode like --preserve-merges).  I thought the current
> >> documentation is already fairly clear on this point?
> >
> > git pull's --no-ff is documented to "create a merge commit in all
> > cases", and thus as worded, seems incompatible with rebasing to me.
>
> It smells like a "too literally to be useful" interpretation of a
> pice of documentation that has no relevance to "pull --rebase" to
> me, though.  It comes from merge-options.txt and would not be
> relevant to "git pull --rebase" to begin with.

"git pull --rebase" isn't a very interesting case -- it's missing
--no-ff, and has an explicit flag declaring user intent making both
pull.ff and pull.rebase irrelevant.  It doesn't really help us handle
the tougher cases at all.

Let me back up and see if I can explain a bit better.

1. In general, we allow command line options to countermand either
configuration options or other conflicting command line options, e.g.
--no-gpg-sign can countermand --gpg-sign=$KEY or commit.gpgSign
setting.

2. Starting with simple conflicts, git-pull has two sets of them of
the above form:
  * --rebase, --no-rebase, pull.rebase
  * --no-ff, --ff-only, --ff, pull.ff

3. git-pull *also* has conflicting options across these types.
  * --rebase[={true,merges,preserve,interactive}] and --ff-only
  * possibly also --no-ff with any of those rebase flags
  * the underlying pull.rebase and pull.ff which are meant to mirror
these flags thus also can conflict

4. The way we handle conflicting options in git is typically:
  * The last command line option countermands any earlier ones on the
command line
  * Command line options countermand anything in config
  * We do not assume any ordering in config, so if two configuration
options conflict, it's either an error or we document which one
overrides the other (e.g. diff.renames=false overrides
diff.renameLimit)

So my proposal is just to do 4 above, noting that:
  * pull.rebase set to anything other than "false" conflicts with
pull.ff set to anything other than "true" (and similarly for the
equivalent command line options)
  * If both pull.rebase and pull.ff are set (in conflicting fashion)
and no countermanding command line flags are set, I recommend throwing
an error; it's not clear that having one override the other would
match user intent.
