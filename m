Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34829C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 21:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiAYVBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiAYVAk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 16:00:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EADAC06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:00:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jx6so33611313ejb.0
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ux8LL/PoR1Ir8iiF0/y79TtIWRHrh1INajCbJKVlhRo=;
        b=kJil0xdJvVktCKcUMr7hyqe3zfM0z5KJCGSBHrcGhSh+/vrc7nEIqP66zuX67Vs2gY
         j7xLn+TPcZsd1x+xkyP9i70jErFCTbhXqhtuZooHmT8UNlTgrBJp4Et67ecmyH4Q8/h8
         p16TX/7HMEoiOC5U4iQLxIQe8/dlW4w8j94/y4DyImgRfBfbsSHIfl2/bfNd9QGuseZ6
         hpQnSiAaAtZGxHSRiqCyavBn3/uEeXOC3exgUtWCOdoSDSGTjklDvYhz26KiQ/RNNd1t
         jeknuZfMlDF1jztPpKbytRt1zTUwvm/wkTbZZKEeAZu0RNbwyILkuXTFlilw6P+GOLY9
         DvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ux8LL/PoR1Ir8iiF0/y79TtIWRHrh1INajCbJKVlhRo=;
        b=OfBm/iijwfuucxAvAyZA51fwgX0vUdhjbHJvgwYPA6t5q9b+BJekGDgh1BgMJqidkj
         307cj43MHGtXa4tbTTY4mSZOqdI1l3MIjmqxOf3ph/TRR9rtJtD9amazWgofz9YFN8MJ
         Ih/bCv17HtOE6l3EcI1EKHBrS024TTgvTOJGzoYY4CsnUV70JfGjAV8V3V2FJtL5Piu/
         3mzWUyt6b5g8q1gN3vVbKcnlx7XeaspQr9ztbfG23FArqKwRYcSFS2McVBOGLR5K9X6g
         evRFyAgcRkuuewZqZgFtfE0HksSA2p7GEHkZYsP/qB/v3GQvIfuCIOm/1AGuPNRZowG0
         VcAg==
X-Gm-Message-State: AOAM531GvNdNHS9hmROipdKl52LpCnV4eUiwGK1Wfm/d/42/zNcqDLeH
        +VGawpQtI2etNB7Ks3+WcXSxaBGP8XU/Ukd/KvQ=
X-Google-Smtp-Source: ABdhPJwET+xralMdFw9S9WLgn+Ks0QmM6HCZD7+ONzEFTFlFjUThJw/j4868RF0fi0JzaKOK9JXkuJyH/1wL+xm8Wh4=
X-Received: by 2002:a17:907:8687:: with SMTP id qa7mr2373951ejc.328.1643144437916;
 Tue, 25 Jan 2022 13:00:37 -0800 (PST)
MIME-Version: 1.0
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
 <xmqqsftgbkvm.fsf@gitster.g>
In-Reply-To: <xmqqsftgbkvm.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 25 Jan 2022 13:00:26 -0800
Message-ID: <CABPp-BE2B9NkWG8bWft6m-UOg66aRpjwSRTWvAyrKCiwJCemHQ@mail.gmail.com>
Subject: Re: [PATCH] clone, submodule: pass partial clone filters to submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 22, 2022 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Josh Steadmon <steadmon@google.com> writes:
>
> > When cloning a repo with a --filter and with --recurse-submodules
> > enabled, the partial clone filter only applies to
> > the top-level repo. This can lead to unexpected bandwidth and disk
> > usage for projects which include large submodules. For example, a user
> > might wish to make a partial clone of Gerrit and would run:
> > `git clone --recurse-submodules --filter=blob:5k
> > https://gerrit.googlesource.com/gerrit`. However, only the superproject
> > would be a partial clone; all the submodules would have all blobs
> > downloaded regardless of their size. With this change, the same filter
> > applies to submodules, meaning the expected bandwidth and disk savings
> > apply consistently.
> >
> > Plumb the --filter argument from git-clone through git-submodule and
> > git-submodule--helper, such that submodule clones also have the filter
> > applied.
> >
> > This applies the same filter to the superproject and all submodules.
> > Users who prefer the current behavior (i.e., a filter only on the
> > superproject) would need to clone with `--no-recurse-submodules` and
> > then manually initialize each submodule.
>
> Two concerns (I do not say "issues", because I honestly do not know
> how much this will hurt in the future).
>
>  - Obviously, this changes the end user experience.  To users in the
>    scenario that motivated this change (described above), obviously
>    it is a change in a good way, and but I wonder if there are
>    workflows that are hurt and actually have to resort to the
>    workaround to preserve the current behaviour.
>
>  - Passing the filter down to submodules means that the filter
>    settings are universal across projects.  The current set of
>    filters, I do not think such an assumption is too bad.  If 5k
>    blob is too large for the top-level superproject, it is OK for
>    the superproject to dictate that 5k blob is too large for any of
>    the submodules the superproject uses.  But can we forever limit
>    the filter vocabulary to the ones that can sensibly be applied
>    recursively?  If we had a filter that goes with pathnames
>    (e.g. "I only want src/ and test/ directories and nothing else
>    initially"), such a set of pathnames appropriate in the context
>    of the superproject is unlikely to apply to its submodules.  Even
>    the existing "depth" filter is iffy, if a toplevel superproject
>    is fairly flat and one of the submodules has a directory
>    hierarchy that is ultra deep.

This second item matches the concern I wanted to raise.  I've wanted
to do "sparse clones" for over a decade[*].  In my opinion,
disconnected development should not require a full clone or constant
network connectivity.  We're inching closer to this goal: (1) partial
clones provide some of the base ability for partial downloads
augmented by updates as needed, (2) sparse-checkout makes the working
tree handle a subset so we can work without downloading more, (3)
cone-mode corrects the mistake of specifying paths via gitignore-style
patterns, and (4) merge-ort has some huge wins for partial clones to
avoid downloading objects by both avoiding unnecessary rename
detections and avoiding traversing into unmodified directories.

There's a number of next steps, of course, one of which is that I
would really like to add a path-based filter (corresponding to the
directories in the sparsity cone) so that the initial partial clone
can get all commits, all trees, and the paths within the sparsity
cone.

But how would that interact with this patch?  There's a bit of a
conflict.  There's a few ways out:
  * Make your change be explicit rather than implicit: Based on
Junio's first concern, you could modify this patch so that it requires
a new flag like --filter-submodules-too (or some better name), and
perhaps folks with a path filter just wouldn't use that.
  * Make these incompatible: Maybe a path filter is incompatible with
--recurse-submodules, and we should throw an error if both are
specified.
  * Attempt to marry the two options: Each submodule could perhaps
extract the subset of paths with itself as a leading directory and
remove that leading prefix and then use that as the path portion of
the filter.  (And perhaps even taking this a step farther: each level
of cloning will only recurse into submodules which match the specified
paths).

I'm inclined to prefer an explicit flag for this behavior, but I feel
bad asking for that due to behavior and code that doesn't exist and
isn't even being worked on yet.  If your patch does go through as-is,
I'd probably implement the
make-path-filters-and-recurse-submodules-incompatible option when
adding path based filters.


[*] https://lore.kernel.org/git/AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com/,
the old code may be dead but the dream isn't
