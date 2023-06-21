Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D9EB64DC
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 10:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjFUKL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjFUKLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 06:11:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97A1BD3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:10:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51a426e4f4bso6899655a12.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1687342245; x=1689934245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpMKx8CHBn0e4KNMV33ZbRz83YOzMXo7rszcz8/eVJA=;
        b=PhmbDbG/cfoKDgGrugOluBkQ1LxT76eI5mqO8gPIyXWI+1yRaEWIu4+66Y7tYs5OuP
         Fn2z3ahiq5WvDm8FaUVRLBzWl7m5G5t9SFnxHbbzgUi2ak5IWcwIt5jiywxhQ0Mjw4C5
         govepLV/Cgge3SjwBSr+J8xkbLpIncwuHmeIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687342245; x=1689934245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpMKx8CHBn0e4KNMV33ZbRz83YOzMXo7rszcz8/eVJA=;
        b=luvcpgzxp33qAfwrPotmkBo2CMT6SRHCzcz/SkEhfgKV4wA0neOszDxRd9LT7e0Ng4
         w4DFudSSYbSnRAYK+TSFBDPm47Z9LZHQbaGJa3YdhHZrbqbBA4EGxeGFApX6/z30xhth
         gMpWpYVzTo8VaCGpuXpQeD7doyld8s8IYMoTCWfrsi2aHgp4VcjqrERbM8XJ+Q/GxZBS
         V+uqAhdx57hG9EteacM5uq8WRNYWEKq0JwkwpO3F/WzDrEz+TGpmABW7E015asU0iX/9
         MYp9AU39HKGtiwxriWclqV73gVZJQ01GnzVGENX52DBfpXHXojukmETlG22WdUKV5QGG
         eRWw==
X-Gm-Message-State: AC+VfDxBcoBhxPdmqaiwhJvkyEiYQ6WJzT3JS1Dn1/5T/88P1Qh5ApXX
        ofE3660h/bukQzCAaaFVBEiyYSHJitD0kN/YJmUeUBbDbkYLT79FyClG7g==
X-Google-Smtp-Source: ACHHUZ4M1cFTeUPPUeXG5gBI65Nsa9SFd3tINfg4XogrHzsCi3gCj6ut5gF+qEk3PDceeYH5qSGagVT8tQjeCg9bzBg=
X-Received: by 2002:aa7:c307:0:b0:51a:4e14:d573 with SMTP id
 l7-20020aa7c307000000b0051a4e14d573mr7542696edq.11.1687342244891; Wed, 21 Jun
 2023 03:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
 <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com>
 <CAPMMpojUpJD21x2i_hshTB96TBFVd-_WRV54KHT2-4R8DUh8=Q@mail.gmail.com> <20230621064459.GA607974@coredump.intra.peff.net>
In-Reply-To: <20230621064459.GA607974@coredump.intra.peff.net>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 21 Jun 2023 12:10:33 +0200
Message-ID: <CAPMMpoha6rBA-T-7cn3DQT_nbNfknigLTky55x0TEmt4Ay2GRA@mail.gmail.com>
Subject: Re: Determining whether you have a commit locally, in a partial clone?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 8:45=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Tue, Jun 20, 2023 at 09:12:24PM +0200, Tao Klerks wrote:
>
> > I'm back to begging for any hints here: Any idea how I can determine
> > whether a given commit object exists locally, *without causing it to
> > be fetched by the act of checking for it?*
>
> This is not very efficient, but:
>
>   git cat-file --batch-check=3D'%(objectname)' --batch-all-objects --unor=
dered |
>   grep $some_sha1
>
> will tell you whether we have the object locally.
>

Thanks so much for your help!

in Windows (msys or git bash) this is still very slow in my repo with
6,500,000 local objects - around 60s - but in linux on the same repo
it's quite a lot faster, at 5s. A large proportion of my users are on
Windows though, so I don't think this will be "good enough" for my
purposes, when I often need to check for the existence of dozens or
even hundreds of commits.

> I don't work with partial clones often, but it feels like being able to
> say:
>
>   git --no-partial-fetch cat-file ...
>
> would be a useful primitive to have.

It feels that way to me, yes!

On the other hand, I find very little demand for it when I search "the
internet" - or I don't know how to search for it.


> The implementation might start
> something like this:
>
> diff --git a/object-file.c b/object-file.c
> index 7c1af5c8db..494cdd7706 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1555,6 +1555,14 @@ void disable_obj_read_lock(void)
>
>  int fetch_if_missing =3D 1;
>
> +static int allow_lazy_fetch(void)
> +{
> +       static int ret =3D -1;
> +       if (ret < 0)
> +               ret =3D git_env_bool("GIT_PARTIAL_FETCH", 1);
> +       return ret;
> +}
> +
>  static int do_oid_object_info_extended(struct repository *r,
>                                        const struct object_id *oid,
>                                        struct object_info *oi, unsigned f=
lags)
> @@ -1622,6 +1630,7 @@ static int do_oid_object_info_extended(struct repos=
itory *r,
>
>                 /* Check if it is a missing object */
>                 if (fetch_if_missing && repo_has_promisor_remote(r) &&
> +                   allow_lazy_fetch() &&
>                     !already_retried &&
>                     !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
>                         promisor_remote_get_direct(r, real, 1);
>
> and then have git.c populate the environment variable, similar to how we
> handle --literal-pathspecs, etc.
>
> That fetch_if_missing kind of does the same thing, but it's mostly
> controlled by programs themselves which try to handle missing remote
> objects specially.

Thanks, I will play with this if I get the chance. That said, I don't
control my users' distributions of Git, so on a purely practical basis
I'm looking for something that will work in git 2.39 to whatever
future version would introduce such a capability. (before 2.39, the
"set remote to False" hack works)

> It does seem like you might be able to bend it to
> your will here, though. I think without any patches that:
>
>   git rev-list --objects --exclude-promisor-objects $oid
>
> will tell you whether we have the object or not (since it turns off
> fetch_if_missing, and thus will either succeed, printing nothing, or
> bail if the object can't be found).

This behaves in a way that I don't understand:

In the repo that I'm working in, this command runs successfully
*without fetching*, but it takes a *very* long time - 300+ seconds -
much longer than even the "inefficient" 'cat-file'-based printing of
all (6.5M) local object ids that you proposed above. I haven't
attempted to understand what's going on in there (besides running with
GIT_TRACE2_PERF, which showed nothing interesting), but the idea that
git would have to work super-hard to find an object by its ID seems
counter to everything I know about it. Would there be value in my
trying to understand & reproduce this in a shareable repo, or is there
already an explanation as to why this command could/should ever do
non-trivial work, even in the largest partial repos?

> It feels like --missing=3Derror should
> function similarly, but it seems to still lazy-fetch (I guess since it's
> the default, the point is to just find truly unavailable objects). Using
> --missing=3Dprint disables the lazy-fetch, but it seems to bail
> immediately if you ask it about a missing object (I didn't dig, but my
> guess is that --missing is mostly about objects we traverse, not the
> initial tips).

Woah, "--missing=3Dprint" seems to work!!!

The following gives me the commit hash if I have it locally, and an
error otherwise - consistently across linux and windows, git versions
2.41, 2.39, 2.38, and 2.36 - without fetching, and without crazy
CPU-churning:

git rev-list --missing=3Dprint -1 $oid

Thank you thank you thank you!

I feel like I should try to work something into the doc about this,
but I'm not sure how to express this: "--missing=3Derror is the default,
but it doesn't actually error out when you're explicitly asking about
a missing commit, it fetches it instead - but --missing=3Dprint actually
*does* error out if you explicitly ask about a missing commit" seems
like a strange thing to be saying.

Thanks again for finding me an efficient working strategy here!
