Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37406C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386974AbiDUScV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242768AbiDUScT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:32:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F0C2BCC
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:29:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so10267040lfb.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhCmIIlUZVBX1zmBZ4/YrFYbqxnSABbhvYE8znZfK6w=;
        b=CQDr/PkjHgz4QpAd7SvZIS5ub4vBajiAYD03lRnoQkps9U8v+d5wVMTZXhtluNYWSs
         kcP+dedIqP32IAQ/VTaWjT7aXhc0QAmwL4KBSqA3R4b2mksy/Au4o96xLDH9HYprbEYo
         jnzbHJCxi21OmYThhSxO76MaIpyD1Rj0O43x0JK0ygUEUn1M2qmILYDmfCfDt9sHMlYp
         lmDSV6/OXKWNRbg7UMLjbzxe0EW38Mcf9LkKyz9eyFjcJ0U8KQXeGYohdwcLynCe2chs
         VsASQK+7MgyayA2/tgG8HeqGLfdQw6oO/ubkZUGEGjQ788SPiAeD33jtIDSb1hkMauu/
         7tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhCmIIlUZVBX1zmBZ4/YrFYbqxnSABbhvYE8znZfK6w=;
        b=2awB/gk4PRxOulR6A3nZHCoY2BZOg6N5e0bL+FoSnTr1XXFCxC7oeADnR3+4+WVeJ5
         XNyncZ89PCUvL2E5FR/YLRE1M9yfuaKVal4S3GPdnp/cdYFUkaO6UstzAe5j2aTYKg5P
         UiJ2m4VGzz6nSCVGVbXH2bFEmQIN8uGC75kAzPxWcB4MdyDygXcByoFEjgALsPTNPVAf
         5d6utDgQF06zhnS9d9lFp9+YhF/3ONYsgDKA1EgARdDBS+vL/XU7G2qY+Uih6tLoqJrv
         1KnBQXvN/Ih5EYdltj6lywe7PzaXbt1pz9YpKLaSf3SG2XCy/iHyoEnGLq61fPF9WV+T
         5Jyg==
X-Gm-Message-State: AOAM530KFPw7VXRpsB/mW2RtuYVTrDOTEUexv1Jvym+CRKtuJmQCWz+u
        HKEM7FlQZK6bSiUB538n9tx8E7+j5bsFCxRX9VeZYA==
X-Google-Smtp-Source: ABdhPJy87P5ibnd0D28qDYDm943I4Qfr0iIGBTzCqz/JD8T7TYQntCbuugObRySKFKEU03LCmGK/6T17U+X8ExWTzVE=
X-Received: by 2002:a05:6512:4003:b0:471:9b68:34e5 with SMTP id
 br3-20020a056512400300b004719b6834e5mr507152lfb.325.1650565766868; Thu, 21
 Apr 2022 11:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Ylobp7sntKeWTLDX@nand.local> <CAJoAoZkgnnvdymuBsM9Ja3+eYSnyohr=FQZMVX_uzZ_pkQhgaw@mail.gmail.com>
In-Reply-To: <CAJoAoZkgnnvdymuBsM9Ja3+eYSnyohr=FQZMVX_uzZ_pkQhgaw@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 21 Apr 2022 11:29:15 -0700
Message-ID: <CAJoAoZkf6VuAOwX9j8Zc0x4HqJRJ5zQgqfmu+8Zs1kVx88dGpg@mail.gmail.com>
Subject: Re: Bare repositories in the working tree are a security risk
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo <chooglen@google.com>, Git List <git@vger.kernel.org>,
        justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 11:25 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Fri, Apr 15, 2022 at 6:28 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Fri, Apr 15, 2022 at 05:41:59PM -0700, Glen Choo wrote:
> > > * We want additional protection on the client besides `git fsck`; there are
> > >   a few ways to do this:
> >
> > I'm a little late to chime into the thread, but I appreciate you
> > summarizing some of the approaches discussed so far. Let me add my
> > thoughts on each of these in order:
> >
> > >   1. Prevent checking out an embedded bare repo.
> > >   2. Detect if the bare repo is embedded and refuse to work with it.
> > >   3. Detect if the bare repo is embedded and do not read its config/hooks, but
> > >      everything else still 'works'.
> > >   4. Don't detect bare repos.
> > >   5. Only detect bare repos that are named `.git` [1].
> > >
> > >   (I've responded with my thoughts on each of these approaches in-thread).
> >
> >   1. Likely disrupts too many legitimate workflows for us to adopt
> >      without designing some way to declare an embedded bare repository
> >      is "safe".
> >   2. Ditto.
> >   3. This seems the most promising approach so far. Similar to (1), I
> >      would also want to make sure we provide an easy way to declare a
> >      bare repository as "safe" in order to avoid permanently disrupting
> >      valid workflows that have accumulated over the past >15 years.
>
> I'd like to think a little more about how we want to determine that a
> bare repo isn't embedded - wantonly scanning up the filesystem for any
> gitdir above the current one is really expensive. When I tried that
> approach for the purposes of including some shared config between
> superproject and submodules, it slowed down the Git test suite by
> something like 3-5x. So, I suppose that "we think this is bare" means
> refs/ and objects/ present in a directory that isn't named '.git/',
> and then we hunt anywhere above us for another .git/? Of course being
> careful not to accept another bare repo as the "parent" gitdir.
>
> Does it work for submodules? I suppose it works for non-bare
> submodules - and for bare submodules, e.g.
> 'submodule-having-project.git/modules/some-submodule/' we can rely on
> the user to turn that flag on if they want their submodule's config
> and hooks to be noticed from the gitdir. (From
> 'worktree-for-submodule-having-project/some-submodule' there is a
> '.git' pointer, so I'd expect things to work normally that way,
> right?)
>
> As long as we are careful to avoid searching the filesystem in *every*
> case, this seems like a pretty reasonable approach to me.
>
> >   4. Seems like this approach is too heavy-handed.
> >   5. Ditto.
> >
> > > With that in mind, here's what I propose we do next:
> > >
> > > * Merge the `git fsck` patch [2] if we think that it is useful despite the
> > >   potentially huge number of false positives. That patch needs some fixing; I'll
> > >   make the changes when I'm back.
> >
> > If there are lots of false positives, we should consider downgrading the
> > severity of the proposed `EMBEDDED_BARE_REPO` fsck check to "info". I'm
> > not clear if there is another reason why this patch would have a
> > significant number of false positives (i.e., if the detection mechanism
> > is over-zealous).
> >
> > But if not, and this does detect only legitimate embedded bare
> > repositories, we should use it as a reminder to consider how many
> > use-cases and workflows will be affected by whatever approach we take
> > here, if any.
> >
> > > * I'll experiment with (5), and if it seems promising, I'll propose this as an
> > >   opt-in feature, with the intent of making it opt-out in the future. We'll
> > >   opt-into this at Google to help figure out if this is a good default or not.
> > >
> > > * If that direction turns out not to be promising, I'll pursue (1), since that
> > >   is the only option that can be configured per-repo, which should hopefully
> > >   minimize the fallout.
> >
> > Here's an alternative approach, which I haven't seen discussed thus far:
> >
> > When a bare repository is embedded in another repository, avoid reading
> > its config by default. This means that most Git commands will still
> > work, but without the possibility of running any "executable" portions
> > of the config. To opt-out (i.e., to allow legitimate use-cases to start
> > reading embedded bare repository config again), the embedding repository
> > would have to set a multi-valued `safe.embeddedRepo` configuration. This
> > would specify a list of paths relative to the embedding repository's
> > root of known-safe bare repositories.
> >
> > I think there are a couple of desirable attributes of this approach:
> >
> >   - It minimally disrupts bare repositories, restricting the change to
> >     only embedded repositories.
> >   - It allows most Git commands to continue working as expected (modulo
> >     reading the config), hopefully making the population of users whose
> >     workflows will suddenly break pretty small.
> >   - It requires the user to explicitly opt-in to the unsafe behavior,
> >     because an attacker could not influence the embedding repository's
> >     `safe.embeddedRepo` config.
> >
> > If we were going to do something about this, I would strongly advocate
> > for something that resembles the above. Or at the very least, some
> > solution that captures the attributes I outlined there.
>
> Nice - a more strict spin on proposal 3 from above, if I understand it
> right. Rather than allowing any and all bare repos, avoid someone
> sneaking in a malicious one next to legitimate ones by using an
> allowlist. Seems reasonable to me.

Ah, another thing I forgot to mention. There has been a little
discussion in the past about isolating "safe" parts of config (and
gitdir) from "unsafe" parts, e.g. "which configs and embedded scripts
are executables", to help better protect from zipfile-type attacks,
which are very similar to this kind of attack. I wonder if it makes
sense to consider that sort of thing as a needswork for this bugfix?
e.g. "/* NEEDSWORK: Only ignore unsafe configs and hooks instead of
ignoring the entire embedded config and hooks in the future */"?

>
>  - Emily
