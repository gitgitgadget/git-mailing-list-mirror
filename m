Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63393C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 21:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiCYV0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiCYV0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 17:26:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E73237FD9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 14:25:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d5so15400543lfj.9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kXVXaFtJbQ/qZo9MHXbnQaOBuGmfhOSEe7Fqdv2sl+s=;
        b=f8aHPDlJZs5UTyEiV5u79uPq706xcBN+DOOY98pf+/fNBfefPhjPUDZGDRht1AdJzZ
         YCAx/ORdo17j7agZwPOFBEM55m1ScQWj6GKq/8yg5tLVNUA+NSVXoHG909iwejGLFQKV
         PEuckvOhlTAxgXDPz6nIbw/DdlQz2ky83rvGpFrT9twFaJ8XN72aBPbL+BtkbvdpMq5a
         JSsrjzk0uJRm9aq7ZOv40iL+DQgwNHcI3WasbsQ8hMk/eiRp6DuA1DDEW2YiAzdEbVEn
         HlnRgHJXTOeNGlqAMzO5TxShR+ode8MJkiZH9bOQcpfGxfLSmnvws/+oeV1ym/AKnziC
         rf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kXVXaFtJbQ/qZo9MHXbnQaOBuGmfhOSEe7Fqdv2sl+s=;
        b=Wg9dum4qx8moP4Rc6XK5oLSH5o6g4g0RA0CdSP3PJM6Oa78NxvROoNl63NZpgj24CF
         DKJAhKG9EvslHBcgZnq53lUvIWkGpU33xhiqno8SyRA55HATPpxvepMuWZiw+UU79S59
         ks9sFu6p8nmaFyjTfcCycBs0zH8f1zMQ7nxEJ1ebq2RyaDYxUqXWuvxUhsvV9auTocw5
         RRfvObf/tfa3FSSGxyXNRo5wD2fCfeLDqQu4uLE1FZXA6iQcOy2iltAOqMQwblSzph3x
         16RhXOAxWSnO3/w5sxya5Y9vVcBLjH65lYzOk4Mh8jfimJGnq9l0XMtvUWfqVaoKtRur
         7+BQ==
X-Gm-Message-State: AOAM531Qn1BnctFNCCSYjR8zCgFXZCUKtSMLTnF8lx3J2t3hRBMChl+G
        C22uPoZ1SGs9WT0DsXS+sVyEbH9iaULV0YfLJ/8wo7YYSUQ=
X-Google-Smtp-Source: ABdhPJzXn+Ir/vI6pUrYFxvBAkTVXLatU9eAG6y9hM45O46X7PmJiPh1Y0tc3wdq5yzfC+k5sQaKvkQdNV8OOKVevng=
X-Received: by 2002:a05:6512:1684:b0:448:a0e6:9fa6 with SMTP id
 bu4-20020a056512168400b00448a0e69fa6mr9414638lfb.592.1648243508713; Fri, 25
 Mar 2022 14:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
 <20220315191245.17990-1-neerajsi@microsoft.com> <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
In-Reply-To: <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 25 Mar 2022 14:24:57 -0700
Message-ID: <CANQDOdeeP8opTQj-j_j3=KnU99nYTnNYhyQmAojj=FZtZEkCZQ@mail.gmail.com>
Subject: Re: do we have too much fsync() configuration in 'next'? (was: [PATCH
 v7] core.fsync: documentation and user-friendly aggregate options)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 7:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Mar 15 2022, Neeraj Singh wrote:
>
> I know this is probably 80% my fault by egging you on about initially
> adding the wildmatch() based thing you didn't go for.
>
> But having looked at this with fresh eyes quite deeply I really think
> we're severely over-configuring things here:
>
> > +core.fsync::
> > +     A comma-separated list of components of the repository that
> > +     should be hardened via the core.fsyncMethod when created or
> > +     modified.  You can disable hardening of any component by
> > +     prefixing it with a '-'.  Items that are not hardened may be
> > +     lost in the event of an unclean system shutdown. Unless you
> > +     have special requirements, it is recommended that you leave
> > +     this option empty or pick one of `committed`, `added`,
> > +     or `all`.
> > ++
> > +When this configuration is encountered, the set of components starts w=
ith
> > +the platform default value, disabled components are removed, and addit=
ional
> > +components are added. `none` resets the state so that the platform def=
ault
> > +is ignored.
> > ++
> > +The empty string resets the fsync configuration to the platform
> > +default. The default on most platforms is equivalent to
> > +`core.fsync=3Dcommitted,-loose-object`, which has good performance,
> > +but risks losing recent work in the event of an unclean system shutdow=
n.
> > ++
> > +* `none` clears the set of fsynced components.
> > +* `loose-object` hardens objects added to the repo in loose-object for=
m.
> > +* `pack` hardens objects added to the repo in packfile form.
> > +* `pack-metadata` hardens packfile bitmaps and indexes.
> > +* `commit-graph` hardens the commit graph file.
> > +* `index` hardens the index when it is modified.
> > +* `objects` is an aggregate option that is equivalent to
> > +  `loose-object,pack`.
> > +* `derived-metadata` is an aggregate option that is equivalent to
> > +  `pack-metadata,commit-graph`.
> > +* `committed` is an aggregate option that is currently equivalent to
> > +  `objects`. This mode sacrifices some performance to ensure that work
> > +  that is committed to the repository with `git commit` or similar com=
mands
> > +  is hardened.
> > +* `added` is an aggregate option that is currently equivalent to
> > +  `committed,index`. This mode sacrifices additional performance to
> > +  ensure that the results of commands like `git add` and similar opera=
tions
> > +  are hardened.
> > +* `all` is an aggregate option that syncs all individual components ab=
ove.
> > +
> >  core.fsyncMethod::
> >       A value indicating the strategy Git will use to harden repository=
 data
> >       using fsync and related primitives.
>
> On top of my
> https://lore.kernel.org/git/RFC-patch-v2-7.7-a5951366c6e-20220323T140753Z=
-avarab@gmail.com/
> which makes the tmp-objdir part of your not-in-next-just-seen follow-up
> series configurable via "fsyncMethod.batch.quarantine" I really think we
> should just go for something like the belwo patch (note that
> misspelled/mistook "bulk" for "batch" in that linked-t patch, fixed
> below.
>
> I.e. I think we should just do our default fsync() of everything, and
> probably SOON make the fsync-ing of loose objects the default. Those who
> care about performance will have "batch" (or "writeout-only"), which we
> can have OS-specific detections for.
>
> But really, all of the rest of this is unduly boxing us into
> overconfiguration that I think nobody really needs.
>

We've gone over this a few times already, but just wanted to state it
again.  The really detailed settings are really there for Git hosters
like GitLab or GitHub. I'd be happy to remove the per-component
core.fsync values from the documentation and leave just the ones we
point the user to.

> If someone really needs this level of detail they can LD_PRELOAD
> something to have fsync intercept fd's and paths, and act appropriately.
>
> Worse, as the RFC series I sent
> (https://lore.kernel.org/git/RFC-cover-v2-0.7-00000000000-20220323T140753=
Z-avarab@gmail.com/)
> shows we can and should "batch" up fsync() operations across these
> configuration boundaries, which this level of configuration would seem
> to preclude.
>
> Or, we'd need to explain why "core.fsync=3Dloose-object" won't *actually*
> call fsync() on a single loose object's fd under "batch" as I had to do
> on top of this in
> https://lore.kernel.org/git/RFC-patch-v2-6.7-c20301d7967-20220323T140753Z=
-avarab@gmail.com/
>

99.9% of users don't care and won't look.  The ones who do look deeper
and understand the issues have source code and access to this ML
discussion to understand why this works this way.

> The same is going to apply for almost all of the rest of these
> configuration categories.
>
> I.e. a natural follow-up to e.g. batching across objects & index as I'm
> doing in
> https://lore.kernel.org/git/RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140753Z=
-avarab@gmail.com/
> is to do likewise for all the PACK-related stuff before we rename it
> in-place. Or even have "git gc" issue only a single fsync() for all of
> PACKs, their metadata files, commit-graph etc., and then rename() things
> in-place as appropriate afterwards.
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.tx=
t
> index 365a12dc7ae..536238e209b 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -548,49 +548,35 @@ core.whitespace::
>    errors. The default tab width is 8. Allowed values are 1 to 63.
>
>  core.fsync::
> -       A comma-separated list of components of the repository that
> -       should be hardened via the core.fsyncMethod when created or
> -       modified.  You can disable hardening of any component by
> -       prefixing it with a '-'.  Items that are not hardened may be
> -       lost in the event of an unclean system shutdown. Unless you
> -       have special requirements, it is recommended that you leave
> -       this option empty or pick one of `committed`, `added`,
> -       or `all`.
> -+
> -When this configuration is encountered, the set of components starts wit=
h
> -the platform default value, disabled components are removed, and additio=
nal
> -components are added. `none` resets the state so that the platform defau=
lt
> -is ignored.
> -+
> -The empty string resets the fsync configuration to the platform
> -default. The default on most platforms is equivalent to
> -`core.fsync=3Dcommitted,-loose-object`, which has good performance,
> -but risks losing recent work in the event of an unclean system shutdown.
> -+
> -* `none` clears the set of fsynced components.
> -* `loose-object` hardens objects added to the repo in loose-object form.
> -* `pack` hardens objects added to the repo in packfile form.
> -* `pack-metadata` hardens packfile bitmaps and indexes.
> -* `commit-graph` hardens the commit graph file.
> -* `index` hardens the index when it is modified.
> -* `objects` is an aggregate option that is equivalent to
> -  `loose-object,pack`.
> -* `derived-metadata` is an aggregate option that is equivalent to
> -  `pack-metadata,commit-graph`.
> -* `committed` is an aggregate option that is currently equivalent to
> -  `objects`. This mode sacrifices some performance to ensure that work
> -  that is committed to the repository with `git commit` or similar comma=
nds
> -  is hardened.
> -* `added` is an aggregate option that is currently equivalent to
> -  `committed,index`. This mode sacrifices additional performance to
> -  ensure that the results of commands like `git add` and similar operati=
ons
> -  are hardened.
> -* `all` is an aggregate option that syncs all individual components abov=
e.
> +       A boolen defaulting to `true`. To ensure data integrity git
> +       will fsync() its objects, index and refu updates etc. This can
> +       be set to `false` to disable `fsync()`-ing.
> ++
> +Only set this to `false` if you know what you're doing, and are
> +prepared to deal with data corruption. Valid use-cases include
> +throwaway uses of repositories on ramdisks, one-off mass-imports
> +followed by calling `sync(1)` etc.
> ++
> +Note that the syncing of loose objects is currently excluded from
> +`core.fsync=3Dtrue`. To turn on all fsync-ing you'll need
> +`core.fsync=3Dtrue` and `core.fsyncObjectFiles=3Dtrue`, but see
> +`core.fsyncMethod=3Dbatch` below for a much faster alternative that's
> +just as safe on various modern OS's.
> ++
> +The default is in flux and may change in the future, in particular the
> +equivalent of the already-deprecated `core.fsyncObjectFiles` setting
> +might soon default to `true`, and `core.fsyncMethod`'s default of
> +`fsync` might default to a setting deemed to be safe on the local OS,
> +suc has `batch` or `writeout-only`
>
>  core.fsyncMethod::
>         A value indicating the strategy Git will use to harden repository=
 data
>         using fsync and related primitives.
>  +
> +Defaults to `fsync`, but as discussed for `core.fsync` above might
> +change to use one of the values below taking advantage of
> +platform-specific "faster `fsync()`".
> ++
>  * `fsync` uses the fsync() system call or platform equivalents.
>  * `writeout-only` issues pagecache writeback requests, but depending on =
the
>    filesystem and storage hardware, data added to the repository may not =
be
> @@ -680,8 +666,8 @@ backed up by any standard (e.g. POSIX), but worked in=
 practice on some
>  Linux setups.
>  +
>  Nowadays you should almost certainly want to use
> -`core.fsync=3Dloose-object` instead in combination with
> -`core.fsyncMethod=3Dbulk`, and possibly with
> +`core.fsync=3Dtrue` instead in combination with
> +`core.fsyncMethod=3Dbatch`, and possibly with
>  `fsyncMethod.batch.quarantine=3Dtrue`, see above. On modern OS's (Linux,
>  OSX, Windows) that gives you most of the performance benefit of
>  `core.fsyncObjectFiles=3Dfalse` with all of the safety of the old

I'm at the point where I don't want to endlessly revisit this discussion.

-Neeraj
