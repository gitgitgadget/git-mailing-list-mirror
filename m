Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0076EC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 17:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CDD23B53
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 17:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgLRR0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 12:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgLRR0X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 12:26:23 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F65C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 09:25:43 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id q25so2571679otn.10
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THnVBJTRxo8ulcdwvSsmzeoVVBgoI0B76Ea4Bj8nLHU=;
        b=L0TdbUPCobmatjB7hD/ZaoaFjaNxBwAb7m7LrCsthP8cS3rCqkX3POlso8F9+ZQ0Dr
         zWeHlwiq1Optq5EorvcCsAyza3M6KDT3iIeLeDKR6st68JJmxstohSwfFHgkdw7Ti1Sw
         YvtNo8a5kY4rB04YI1XL3hJDK3h2HYT/6OW7+WGCIzK0WBdjjms3RfaxibzgEFVCZESS
         GlMDlSFTl7IfQWP5BBkUkyhp/4ewbAkFOQqME6GUIGu9C+hRgDAOEunMag83kHCv5pkA
         BbXtO+l2ZhJvLCQxaIsxyoMy0WQiv35UyPNE9CdgV25S2v4bYcsnC5n3oO+b2VDz6U2E
         ULLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THnVBJTRxo8ulcdwvSsmzeoVVBgoI0B76Ea4Bj8nLHU=;
        b=LKYER0F+UlG/s6cED5LyjD/yoguYpZ4f58LYymq9F4XCdvTd4DfeADtGVBKn2PFgYV
         xgf12raWYCdKL6IVU2Yg0X7pZgNKfPRBmHni+QZJbDgFgps2ydWvH3w/EwUQ+sqv1kjJ
         4DQeQmob5Nmw5ShhG9EhSk349LtBh4jjd+i4c5VPStEc5Y3JNNB9f0vzkvwqT/fkHhQB
         lHiG+QvphZryZmEhaCs0fmM9q4Jyuh1+q0mTle4dl4egedR9LsG+ZaYfqxPqFB/kP8+g
         dB3vjrXPSb66rKxJcBH/6Ue+fl0eekLX0Gd/M3o/HlikOEtU3quiG4L/nKbp61Z8eLJz
         7H3g==
X-Gm-Message-State: AOAM533byGR/Tk2YJj83a+FANVxI4bFwlYdw8FAyKgZ/KVLwxb5KUvHq
        7t+/AlQ1XeVzytsCtMgs0tsIlpOgusTNsQ+72kxV7dgQivQ=
X-Google-Smtp-Source: ABdhPJw2djqlnCrCcrEH0Hd2Rp9PCQ97Js0VyUpynmtnbBfuyKtWXlrRUJxX35HlUkLjE6GKQIVY1uozXKoPEOXTvvg=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr3574815otr.345.1608312342471;
 Fri, 18 Dec 2020 09:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-30-sorganov@gmail.com> <CABPp-BFRPFxm=SuJFwfG+QYCivMKp2VRpnHGwxNL+extK7UdtA@mail.gmail.com>
 <87lfdvaymn.fsf@osv.gnss.ru>
In-Reply-To: <87lfdvaymn.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Dec 2020 09:25:30 -0800
Message-ID: <CABPp-BGAHFLZDWaK5q+ZHOShUOZnRqUQd+T-X6mXxkg5cp7QpQ@mail.gmail.com>
Subject: Re: [PATCH v2 29/33] doc/git-log: describe new --diff-merges options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 8:05 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Describe all the new --diff-merges options in the git-log.txt and
> >> adopt description of originals accordingly.
> >
> > You also took care to explain interactions of options with -p that
> > were previously undocumented, which is a nice bonus.  That wording
> > could still be improved a bit, though, as noted below.
> >
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  Documentation/git-log.txt | 85 ++++++++++++++++++++++++---------------
> >>  1 file changed, 52 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> >> index 2b8ac5ff882a..27bc619490c6 100644
> >> --- a/Documentation/git-log.txt
> >> +++ b/Documentation/git-log.txt
> >> @@ -120,45 +120,64 @@ DIFF FORMATTING
> >>  By default, `git log` does not generate any diff output. The options
> >>  below can be used to show the changes made by each commit.
> >>
> >> -Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
> >> -will never show a diff, even if a diff format like `--patch` is
> >> -selected, nor will they match search options like `-S`. The exception is
> >> -when `--first-parent` is in use, in which merges are treated like normal
> >> -single-parent commits (this can be overridden by providing a
> >> -combined-diff option or with `--no-diff-merges`).
> >> +Note that unless one of `--diff-merges` variants (including short
> >> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
> >> +will not show a diff, even if a diff format like `--patch` is
> >> +selected, nor will they match search options like `-S`. The exception
> >> +is when `--first-parent` is in use, in which case `first-parent` is
> >> +the default format.
> >
> > Thanks for fixing this up.  :-)
>
> Don't mention it :-)
>
> >
> >>
> >> --c::
> >> -       With this option, diff output for a merge commit
> >> -       shows the differences from each of the parents to the merge result
> >> -       simultaneously instead of showing pairwise diff between a parent
> >> -       and the result one at a time. Furthermore, it lists only files
> >> -       which were modified from all parents.
> >> -
> >> ---cc::
> >> -       This flag implies the `-c` option and further compresses the
> >> -       patch output by omitting uninteresting hunks whose contents in
> >> -       the parents have only two variants and the merge result picks
> >> -       one of them without modification.
> >> +--diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
> >> +--no-diff-merges::
> >> +       Specify diff format to be used for merge commits. Default is
> >> +       `off` unless `--first-parent` is in use, in which case
> >> +       `first-parent` is the default.
> >> ++
> >> +--diff-merges=(off|none):::
> >> +--no-diff-merges:::
> >> +       Disable output of diffs for merge commits. Useful to override
> >> +       implied value.
> >> ++
> >> +--diff-merges=first-parent:::
> >> +--diff-merges=1:::
> >> +       This option makes merge commits show the full diff with
> >> +       respect to the first parent only.
> >
> > Does it imply -p?
>
> No, none of --diff-merges options do. This one is not any special. Why
> the question?

The documentation on -m was vague enough that it made me wonder.
Fixing it would probably prevent me from having asked this question.

> >> ++
> >> +--diff-merges=separate:::
> >> +--diff-merges=m:::
> >> +-m:::
> >> +       This makes merge commits show the full diff with respect to
> >> +       each of the parents. Separate log entry and diff is generated
> >> +       for each parent. `-m` is different in that it doesn't produce
> >> +       any output without `-p`.
> >
> > Different from what?  From --first-parent?  From flags that haven't
> > been covered yet?  (-c and --cc show up below)
>
> Well, from --diff-merges=m and --diff-merges=separate, that, as any
> other --diff-merge option, do produce output (for merge commits) even
> without -p.

That wasn't at all clear to me as the intent of the last sentence.

> >> ++
> >> +--diff-merges=combined:::
> >> +--diff-merges=c:::
> >> +-c:::
> >> +       With this option, diff output for a merge commit shows the
> >> +       differences from each of the parents to the merge result
> >> +       simultaneously instead of showing pairwise diff between a
> >> +       parent and the result one at a time. Furthermore, it lists
> >> +       only files which were modified from all parents. Historically,
> >> +       `-c` enables diff output for non-merge commits as well.
> >
> > "Historically"?  Does that mean it doesn't anymore?
>
> Eh, I don't think "historically" means that, but I'm not sure, being
> non-native English speaker.

Sometimes non-native speakers use the language more accurately.  This
might be such a case, but that sentence did make me think you might be
attempting to document past behavior as a way of helping people adjust
to current/new behavior.

> > (Maybe, "The short form, `-c`, also enables diff output for non-merge
> > commits as well." or something like that?)
>
> ... and then try to explain why this otherwise illogical behavior is
> there? I thought "historically" would cover that.

It doesn't seem like illogical behavior to me.   Perhaps the view of
-c as a diff-merges option, reinforced by placing -c right next to
--diff-merges in the documentation, is what causes you to think so?
If so, maybe we should document -c (and --cc) separately after all the
--diff-merges options, using something like the following:

-c:::
    Implies both --patch and --diff-merges=combined, i.e. turn on
patches for normal commits and show a combined diff format for merges.

> >
> >> ++
> >> +--diff-merges=dense-combined:::
> >> +--diff-merges=cc:::
> >> +--cc:::
> >> +       With this option the output produced by
> >> +       `--diff-merges=combined` is further compressed by omitting
> >> +       uninteresting hunks whose contents in the parents have only
> >> +       two variants and the merge result picks one of them without
> >> +       modification.  Historically, `--c` enables diff output for
> >> +       non-merge commits as well.
> >
> > Same note as above.
>
> Yep.
>
> >
> >>  --combined-all-paths::
> >>         This flag causes combined diffs (used for merge commits) to
> >>         list the name of the file from all parents.  It thus only has
> >> -       effect when -c or --cc are specified, and is likely only
> >> -       useful if filename changes are detected (i.e. when either
> >> -       rename or copy detection have been requested).
> >> +       effect when `--diff-merges=[dense-]combined` is in use, and
> >> +       is likely only useful if filename changes are detected (i.e.
> >> +       when either rename or copy detection have been requested).
> >>
> >> --m::
> >> -       This flag makes the merge commits show the full diff like
> >> -       regular commits; for each merge parent, a separate log entry
> >> -       and diff is generated. An exception is that only diff against
> >> -       the first parent is shown when `--first-parent` option is given;
> >> -       in that case, the output represents the changes the merge
> >> -       brought _into_ the then-current branch.
> >> -
> >> ---diff-merges=off::
> >> ---no-diff-merges::
> >> -       Disable output of diffs for merge commits (default). Useful to
> >> -       override `-m`, `-c`, or `--cc`.
> >>
> >>  :git-log: 1
> >>  include::diff-options.txt[]
> >> --
> >> 2.25.1
> >
> > The rest looks good.
>
> Thanks,
> -- Sergey
