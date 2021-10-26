Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B92C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5CA60F21
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbhJZWpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhJZWpv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 18:45:51 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3A3C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:43:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bp15so2016614lfb.4
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Od/vN0aypKNbTNCh6m0AketCt0euV7HtZbG3je2ANAw=;
        b=T7teNoSjOMUWf9C4qG0GY3l2TIrmgWxeEwFF+RbtWN05Hj2YvCZCOBjOMpmUiz9YbS
         MNtfCY4UabDlzCl2I5+Jx3GlHJwaeiXTJjugmM0hvur/Lch5UUJadmKONs7jp7K5dQU4
         QRoRBnC/vgfNXthoRcjmvSm2n8NjgvUX6HOnmIR+lyBOGp4PMJLgFHPnKBiReiTXPcAx
         bCWhP72SLo8OVvF49KFUHC/ufQhbAxY6PH/ZrEl7j2AYk1rGO7vMGXc9B+p8zsNuRBqs
         Qj/anSuJUuJkTBRKf+vOiOWjgUymcmNuWvVjmuBIg7Iitrp5VAinvcNmticd2Kl74hij
         wczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Od/vN0aypKNbTNCh6m0AketCt0euV7HtZbG3je2ANAw=;
        b=TVPHn6q7XLtGhpj7FIP/tJUeESf2YQFc+eOC0HA4vd3W/GZqBjMY+bhn1MGWyq/60f
         IYfzEHTQ2JcJmFk/QKTpLH3KIkiGv/5g0aO5vc4mYDO3nnFeL7/f3teJ2q9eyQOzfMpy
         Jx1WFpk/iXfFDBgLq38VGsgBqHrDp9Y4+5XdUNpzSt/E/FPR9DCsQbuqNiNxijzkLrnl
         4W04xtjxmTAtmwieE4p1T3kFEHSJks48Sl4c5Br26FWQ27EpksSO7VoK48YvfpzoptH2
         J+GTR8kZ8Sk7LSP/LJJrwyqlDgEJVHuC26Wn6ClbDEY8v2td9XdEf/VOqfIznKOmZCKH
         8sDQ==
X-Gm-Message-State: AOAM533ubWAIkD/GcumGSw3vxWXqpRbsKsoglNjuM9oHewqiTcDmVqTc
        aggAz3dew2TNOMyvz+XZ6WATMqrBetTB429kDuQGcA==
X-Google-Smtp-Source: ABdhPJx7mme6ToAYnodzN/68kzUaPokDEd1ZcFZhN0n2xsxaupc/UmGmTBBmCEDYkX/00xGaLX40jgrdeoYT2OIxnqg=
X-Received: by 2002:a05:6512:142:: with SMTP id m2mr24183344lfo.125.1635288205107;
 Tue, 26 Oct 2021 15:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
 <47aec8ed-5e54-6d13-8154-0202ef0fd747@gmail.com>
In-Reply-To: <47aec8ed-5e54-6d13-8154-0202ef0fd747@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Tue, 26 Oct 2021 19:43:13 -0300
Message-ID: <CAHd-oW6w0aiFDVX1S2ttfc++H3okz2YTGf3f2p=xSbL_Bc_DNA@mail.gmail.com>
Subject: Re: [PATCH v2] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Stolee

Thanks for the review!

On Tue, Oct 26, 2021 at 9:53 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/25/2021 5:07 PM, Matheus Tavares wrote:
> >
> > - Simplified the implementation by unifing the code path for cone mode and
> >   full pattern mode. Since path_matches_pattern_list() never returns UNDECIDED
> >   for cone mode, it will always execute only one iteration of the loop and then
> >   find the final answer. There is no need to handle this case in a separate
> >   block.
>
> This was unexpected, but makes sense. While your commit message hints at the
> fact that cone mode never returns UNDECIDED, it doesn't explicitly mention
> that cone mode will exit the loop after a single iteration. It might be nice
> to make that explicit either in the commit message or the block comment before
> the loop.

Yup, will do.

> > - Inside the loop, made sure to change dtype to DT_DIR when going to parent
> >   directories. Without this, the pattern match would fail if we had a path
> >   like "a/b/c" and the pattern "b/" (with trailing slash).
>
> Very good. We typically need to detect the type for the first path given,
> but we know that all parents are directories. I've used this trick elsewhere.
>
> I see in the code that the first path is used as DT_REG. It's my fault, but
> perhaps it should be made more clear that path_in_sparse_checkout() will
> consider the given path as a file, not a directory. The current users of the
> method are using it properly, but I'm suddenly worried about another caller
> misinterpreting the generality of the problem.

Yeah, I was thinking about this too... I'm afraid there might be at
least two users of this function which already pass non-regular files
to it: builtin/add.c:refresh() and
sparse-index.c:convert_to_sparse_rec().

The first calls the function passing the user-given pathspec, which
may be a directory. But this one is easy to solve: I think we don't
even need the path_in_sparse_checkout() here as the `git add
--refresh` only work on tracked files, and the previous
matches_skip_worktree() call covers both skip_worktree and
non-skip_worktree index entries (maybe we should rename this function
to matches_sparse_ce()?)

As for convert_to_sparse_rec(), it seems to call
path_in_sparse_checkout() with the directory components of paths, so
something like "dir/". Perhaps we can make path_in_sparse_checkout()
receive a dtype argument and pass DT_UNKNOWN in this case?

Another case I haven't given much thought yet is submodules. For example:

git init sub &&
test_commit -C sub file &&
git submodule add ./sub &&
git commit -m sub &&
git sparse-checkout set 'sub/' &&
git mv sub sub2

Erroneously gives:
The following paths and/or pathspecs matched paths that exist
outside of your sparse-checkout definition, so will not be
updated in the index:
sub

But it works if we change DT_REG to DT_UNKNOWN in
path_in_sparse_checkout(). So, I'm not sure, should we use DT_UNKNOWN
for all calls?

> > @@ -1504,8 +1504,9 @@ static int path_in_sparse_checkout_1(const char *path,
> >                                    struct index_state *istate,
> >                                    int require_cone_mode)
> >  {
> > -     const char *base;
> >       int dtype = DT_REG;
>
> Here is where we assume a file to start.
>
> > +     enum pattern_match_result match = UNDECIDED;
> > +     const char *end, *slash;
> >
> >       /*
> >        * We default to accepting a path if there are no patterns or
> > @@ -1516,11 +1517,23 @@ static int path_in_sparse_checkout_1(const char *path,
> >            !istate->sparse_checkout_patterns->use_cone_patterns))
> >               return 1;
> >
> > -     base = strrchr(path, '/');
> > -     return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
> > -                                      &dtype,
> > -                                      istate->sparse_checkout_patterns,
> > -                                      istate) > 0;
> > +     /*
> > +      * If UNDECIDED, use the match from the parent dir (recursively),
> > +      * or fall back to NOT_MATCHED at the topmost level.
> > +      */
> > +     for (end = path + strlen(path); end > path && match == UNDECIDED; end = slash) {
>
> nit: since this line is long and the sentinel is complicated, it might
> be worth splitting the different parts into their own lines:
>
>         for (end = path + strlen(path);
>              end > path && match == UNDECIDED;
>              end = slash) {

Good idea, I will split the lines like you did.
