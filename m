Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432DAC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 04:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiF3EG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 00:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3EG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 00:06:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22091D327
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 21:06:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ej4so24868652edb.7
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 21:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkY73NHKrIJhtBeoGrD5OjtDsXiuTGAMT0FUsQ1p1rg=;
        b=kIgrKpzi6L0zcWhAurEHPAYUUivK1fD8q8eWWJpx8jrbw9eLWLjJun0soc6dEjGFBu
         0LdzQ8MPrMUB82u1V+/USHgUBuP5Jby7QgcgcgHnxGJGXc9i9wU8tXyIVCiur26/P4/G
         TwtW40Fc+NiGJHKPTXINM3NfQfW0/Qd7AUQbu1hxBxYoyuF0RYT7YGG4jJeDfkZ0ZJT1
         M5gXX5l5Bw9o+8TI2mVOdHKtwlzFDvzn46sDSfU1YAuPuAESp9p8FZnbEsCLqFfZRjcx
         i23+LYuV/qpJ3pnCDv3i+h1ghp9n3OSa/7aE+jzX0R03+XQU0nhrT13TWzUWLL2er0NQ
         L9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkY73NHKrIJhtBeoGrD5OjtDsXiuTGAMT0FUsQ1p1rg=;
        b=PQzXIm/vYlWVcugYTNpKWO2jIGz3pbVb22A8gppJcE8HYK6JN46MS897dGRQbz3qvS
         dLB10gPzsdQNFrNaO9PoWm6KxCTBHKpm1jM+PhACnueTSfuSoofGpfm94mauezRe2tF0
         KRKa+KCil2XHdhuUXkrLgUdpd5Afxy8C4KGs8TBJC4M7D0rV/X5S53P7UypAz4ORRvpL
         xQZhGMDu1j+HG6zEdFlhKbbCmfEqB0QmXXofuI1IgFXamt0WqvhoDLXIfWkbA6y85eOP
         nbAx+xc1HuI8PBMEisg0ybn0TxIG3ohk5QAQXoRb0LkQiXZMkoPR32xN7RY5lxYJ+64j
         H2ng==
X-Gm-Message-State: AJIora8Suzdf68XC8wv8LVkc0iO1z6PJ2UHm4CoUtfMAFNzaDCYJg201
        AjZwta28XfBBLlW4ZKJ/PTouVrcEYUMAg85jx54=
X-Google-Smtp-Source: AGRyM1sx9tlv+NQNe4hE920CLKmyFf+2tK7vJwuMQDmmfo3C83uoV+MGQXEC7yCaJBIOhGXPNmMDiNIKd1ZZWGuIpxY=
X-Received: by 2002:a05:6402:2999:b0:434:edcc:f12c with SMTP id
 eq25-20020a056402299900b00434edccf12cmr8682256edb.96.1656561986162; Wed, 29
 Jun 2022 21:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
 <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com>
In-Reply-To: <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Jun 2022 21:06:14 -0700
Message-ID: <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     Victoria Dye <vdye@github.com>
Cc:     Dian Xu <dianxudev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 3:04 PM Victoria Dye <vdye@github.com> wrote:
>
> Dian Xu wrote:
> > Dear Git developers,
> >
> > Reporting Issue:
> >               'git add' hangs in a large repo which has
> > sparse-checkout file with large number of patterns in it
> >
> > Found in:
> >               Git 2.34.3. Issue occurs after 'audit for interaction
> > with sparse-index' was introduced in add.c
> >
> > Reproduction steps:
> >               1. Clone a repo which has e.g. 2 million plus files
> >               2. Enable sparse checkout by: git config core.sparsecheckout true
> >               3. Create a .git/info/sparse-checkout file with a large
> > number of patterns, e.g. 16k plus lines
> >               4. Run 'git add', which will hang>
> > Investigations:
> >               1. Stack trace:
> >                        add.c: cmd_add
> >                   -> add.c: prune_directory
> >                   -> pathspec.c: add_pathspec_matches_against_index
> >                   -> dir.c: path_in_sparse_checkout_1
> >               2. In Git 2.33.3, the loop at pathspec.c line 42 runs
> > fast, even when istate->cache_nr is at 2 million
> >               3. Since Git 2.34.3, the newly introduced 'audit for
> > interaction with sparse-index' (dir.c line 1459:
> > path_in_sparse_checkout_1) decides to loop through 2 million files and
> > match each one of them against the sparse-checkout patterns
> >               4. This hits the O(n^2) problem thus causes 'git add' to
> > hang (or ~1.5 hours to finish)
>
> Thanks for the explanation, it helped me narrow down the source to an exact
> commit (49fdd51a23 (add: skip tracked paths outside sparse-checkout cone,
> 2021-09-24)).
>
> You're correct that the `path_in_sparse_checkout()` check is slow [1].
> However, it only runs on files that are not "hidden" with the
> `SKIP_WORKTREE` flag. Ideally, if you're using sparse-checkout, this will
> only be a small subset of your 2 million files.
>
> In your repro steps, you're adding patterns to a file then immediately
> running `git add`. If that reflects how you're usually working with
> sparse-checkout, `SKIP_WORKTREE` likely isn't being applied properly before
> the `add`. You can check to see whether file(s) have the flag properly
> applied with `git ls-files -t <file or dir names>` - each `SKIP_WORKTREE`
> file should have an "S" next to it. "H" indicates that the flag is *not*
> applied.
>
> If you see that most of the files that *should* be sparse don't have
> `SKIP_WORKTREE` applied, you can run `git sparse-checkout reapply` (make
> sure you don't have any modified files outside the patterns you're
> applying!). The downside is that it'll be as slow as what you're reporting
> for `git add`, but any subsequent `add` (or reset, status, etc.) should be
> much faster.
>
> If you do all of that but things are still slow, then the way we check
> pathspecs in `git add` would need to change (not trivial, but probably not
> impossible either). At a cursory glance, I can think of a few options for
> that:
>
> 1. Remove the `path_in_sparse_checkout()` check. It's the simplest solution,
>    but it means you'd be able to stage files for commit outside the
>    sparse-checkout patterns without using the '--sparse' option. I don't
>    personally think that's a huge issue, but given that the implementation
>    was intentionally changed *away* from this approach, I'd defer to other
>    contributors to see if that's an okay change to make.

I'm strongly against this.  This just restores the original bug we
were trying to fix, attempts to paper over the fact that non-cone mode
is fundamentally O(N*M) in one small instance, and sets the precedent
that we can't fix further sparse-checkout-based usability bugs because
it might add performance bottlenecks in additional places given
non-cone-mode's fundamental performance design problem.  We should
instead (in rough priority order)

* encourage people to adopt cone mode
* discourage people still using non-cone mode from having lots of patterns
* make sure people aren't misusing things (the lack of a `git
read-tree -mu HEAD` or `git sparse-checkout reapply` seemed very
suspicious)
* educate people that non-cone mode is just fundamentally slow, among
other problems, and that the slowness might appear in additional
places in the future as we fix various usability issues.
* provide workarounds users can adopt if they really want to persist
with non-cone mode with lots of patterns (e.g. add "--sparse" to their
"git add" commands), though warn them about the possible side effects
they'll face (the added files can seemingly randomly disappear in the
working tree with future checkout/pull/merge/rebase/reset/etc commands
if the added files don't match the sparsity patterns).
* investigate ways to optimize the code to lower the constant in the
O(N*M) behavior on a case-by-case basis

We deprecated non-cone mode in v2.37 in part because of this type of
issue, and I really don't want the see the deprecated side of things
dictating how commands work for the now-default mode.

> 2. After every call to `ce_path_match()`, check if all pathspecs are marked
>    as `seen` and, if so, return early. This would slow down each individual
>    file check and wouldn't help you if a pathspec matches nothing, but
>    prevents checking more files once all pathspecs are matched.

Might be interesting.  Would need some careful measurements and
attempts to validate how often all pathspecs are matched early in some
kind of way, because this would definitely slow down some cases and
speed others up, but I don't have a good feel for which side happens
more frequently in practice.

> 3. Do some heuristic checks on the pathspecs before checking index entries.
>    For example, exact file or directory matches could be searched in the
>    index. This would still require falling back on the per-file checks if
>    not all pathspecs are matched, but makes some typical use-cases much
>    faster.

I'm confused.  "before checking index entries", you're checking things
(namely, exact file or directory matches) "in the index"?

> There are almost certainly other options, and I can dig around `add.c` more
> to see if there's anything I'm missing (although I'd love to hear other
> ideas too!).
>
> Hopefully this helps!
> - Victoria
>
> [1] `path_in_sparse_checkout()` is significantly faster in cone mode, but
> with 16k patterns I'm assuming you're not using cone patterns ;)
>
> >
> > Please help us take a look at this issue and let us know if you need
> > more information.
> >
> > Thanks,
> >
> > Dian Xu
> > Mathworks, Inc
> > 1 Lakeside Campus Drive, Natick, MA 01760
> > 508-647-3583
>
