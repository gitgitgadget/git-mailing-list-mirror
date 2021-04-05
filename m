Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C13FC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A914613D3
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbhDEWIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhDEWIV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 18:08:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A23C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 15:08:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a7so18823180ejs.3
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqHx5Z1TvpHN7q1kFPbqnruNmpJEVkVCiTTHWMR97r4=;
        b=AIJ6TU0yI9gc/m7SWi5a/mfZ8tp7aMukSu7X9Sr0SKsX7wNB4Eux6xPprYQbLHJZdx
         uUA8k1f+BOBTjFYGQeqGRdh16qfOXnCVpV2bm28GDBoDJ7z2ZOubCSJ+u/2ImBHo/fPy
         PVPAK0Nd8pHcoxfAPkH2JrFutYpW174aE6CXFuuvzjVyEjYJfFCSvBe3X1XO/2GL9en3
         6Srb9+lbSNE1tiNYn9H8koEF/JEHZ+jmUP6yWafEO9790YLQVoXh+c/qF5FCggMSRNBc
         Jjn7dLGbPIvqPBUZAF5LRDz+8R+Ksn+O4imevhm5v+WhxKU+vtP+hZF2eD1RJGJJ/rFL
         UGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqHx5Z1TvpHN7q1kFPbqnruNmpJEVkVCiTTHWMR97r4=;
        b=P+WdQWkML9K6zs5Ua15dFSEi3JjHqCqIlr188z8NZHXIYhccNUzbUVDs0gRdjgMFIM
         4atyzRcO43qmBs+aLZWvBUQezGAUtdnTy99WbE6aYQRFbk0FxY23h1TpFdU4eWOaGSU3
         GEIPAdquNyp44qFotmzIqrPvh1WiuYjeGDwCDKwOwr90nWdENX1A96Gu3QF6FpqZQZ0y
         4v6GFOt3JY287wX+2wfLcddgtGWDkJ22akigQbS9FzMMtDVr6FvMhYLUiv6MUloaS1JJ
         O1EeivjbxH7SicpBN6ZSI6hjrgpxTNjZV2BNN6YTHZTmDT6gB4NbeIxNYSEiRQZ7oaot
         kFew==
X-Gm-Message-State: AOAM531ld5nyGxitzXUrjI8gJ2haKKEVQN6qHdvkch5V6YZAkTeeO6sR
        DErvQWyRbKalfAssBW24kYXQnzA/yGzgecOxgBP9Lg==
X-Google-Smtp-Source: ABdhPJxchEWdnetvWzdlN034MB/+uqrcTZKYJNDyeESfTS+DrKmwdigJuG0xeuP8gOryuBgSe1FDazbOsqx2ZBqSQuc=
X-Received: by 2002:a17:906:8583:: with SMTP id v3mr31293778ejx.361.1617660492708;
 Mon, 05 Apr 2021 15:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210403013410.32064-1-jerry@skydio.com> <20210403013410.32064-2-jerry@skydio.com>
 <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
In-Reply-To: <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Mon, 5 Apr 2021 15:08:01 -0700
Message-ID: <CAMKO5Ct89R=Ls61H-q4ArhmWSokRQKS_uc93+=6_Gnxnjnk80A@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-apply: Allow simultaneous --cached and --3way options
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 2, 2021 at 8:46 PM Elijah Newren <newren@gmail.com> wrote:
>
> I'm not that familiar with apply.c, but let me attempt to take a look...
>
> On Fri, Apr 2, 2021 at 6:36 PM Jerry Zhang <jerry@skydio.com> wrote:
> >
> > Previously, --cached and --3way were not
> > allowed to be used together, since --3way
> > wrote conflict markers into the working tree.
> >
> > These changes change semantics so that if
> > these flags are given together and there is
> > a conflict, the conflict markers are added
> > directly to cache. If there is no conflict,
> > the patch is applied directly to cache as
> > expected.
> >
> > Signed-off-by: Jerry Zhang <jerry@skydio.com>
> > Signed-off-by: Jerry Zhang <jerryxzha@googlemail.com>
> > ---
> >  Documentation/git-apply.txt |  4 +++-
> >  apply.c                     | 13 +++++++------
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> > index 91d9a8601c..3dc0085066 100644
> > --- a/Documentation/git-apply.txt
> > +++ b/Documentation/git-apply.txt
> > @@ -89,7 +89,9 @@ OPTIONS
> >         and we have those blobs available locally, possibly leaving the
> >         conflict markers in the files in the working tree for the user to
> >         resolve.  This option implies the `--index` option, and is incompatible
> > -       with the `--reject` and the `--cached` options.
> > +       with the `--reject` option. When used with the --cached option, any
> > +       conflict markers are added directly to the cache rather than the
> > +       working tree.
> >
> >  --build-fake-ancestor=<file>::
> >         Newer 'git diff' output has embedded 'index information'
> > diff --git a/apply.c b/apply.c
> > index 6695a931e9..fc94ca0e99 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -133,8 +133,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
> >
> >         if (state->apply_with_reject && state->threeway)
> >                 return error(_("--reject and --3way cannot be used together."));
> > -       if (state->cached && state->threeway)
> > -               return error(_("--cached and --3way cannot be used together."));
> >         if (state->threeway) {
> >                 if (is_not_gitdir)
> >                         return error(_("--3way outside a repository"));
> > @@ -4490,13 +4488,16 @@ static int create_file(struct apply_state *state, struct patch *patch)
> >
> >         if (!mode)
> >                 mode = S_IFREG | 0644;
> > -       if (create_one_file(state, path, mode, buf, size))
> > -               return -1;
> > +       if (!state->cached) {
>
> Why add this check?  create_one_file() already has an early return if
> state->cached is true.
>
removed in latest patch
> > +               if (create_one_file(state, path, mode, buf, size))
> > +                       return -1;
> > +       }
> >
> > -       if (patch->conflicted_threeway)
> > +       if (patch->conflicted_threeway && !state->cached)
> >                 return add_conflicted_stages_file(state, patch);
> > -       else if (state->update_index)
> > +       else if (state->update_index) {
> >                 return add_index_file(state, path, mode, buf, size);
>
> So if something had conflicts, you ignore the various conflicted
> modes, and just add it to the index as it stands.  What if it was
> deleted upstream and modified locally?  Doesn't that just ignore the
> conflict, make it invisible to the user, and add the locally modified
> version?  Similarly if it was renamed upstream and modified locally,
> doesn't that end up in both files being present?  And if there's a
> directory/file conflict, due to the lack of ADD_CACHE_SKIP_DFCHECK (or
> whatever it's called), the add is just going to fail, but perhaps
> that's the most reasonable case as it'd print an error message and
> return -1, I think.
>
> Again, I didn't test any of this out and I'm not so familiar with this
> code, so I'm guessing at these scenarios.  If I'm wrong about how this
> works, the commit message probably deserves an explanation about why
> they work, and we'd definitely need a few testcases for these types of
> scenarios.  If I'm right, the current implementation is problematic at
> least if not the idea of using these options together.
Echoing my other reply, I think I will give up on the conflict markers and
just leave the files at the higher stages. I think that will address any
safety concerns since that's what --3way does without the cached
flag
