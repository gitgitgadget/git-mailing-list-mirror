Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0460CC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFD1221EA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgLCU2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgLCU2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 15:28:53 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCF9C061A52
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 12:28:13 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id y3so841798ooq.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 12:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uh2VvY1pP2BLmwb8Cw4qtiwj8fBvJcw/rmrlRh4FoMI=;
        b=PbXVOO5+pWP44lF4Nh27SXGG96GiGOv54VN+jQqSCG5UitFa8bOvGth7BuyiRqlODj
         YOZxj4ocLPYf2ON0jG5DdZGl+m62M9Y29BPSWmwZl9eaoP6hdhcLAnQuqA6HQCz6LoEQ
         b5cP699aNIYndScjBnNISDNQzaBrbNQl99l88D43bVGcqRs9+4Fd6TPO1wyR5U5elEDV
         Y7nuiLK+RcCYT5gUis2cugQ+R4W7WjET6Peo5qB2JO/7es/32Wiem41HJOS+5ghi5ZYD
         /dBE3XnnYE1Zwn7NjdrUclUVXps0ueMi1zrEN9KvpW4dYNaOBPPGHtA+FEe/Dq2KjzNn
         enLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uh2VvY1pP2BLmwb8Cw4qtiwj8fBvJcw/rmrlRh4FoMI=;
        b=XILQUhNAGax/DkJLggkhDFqIsEVumK6nxJjD5hUDQV53aLNy36VzY0Y/rtY7xHaK0I
         p3JBRZxfz71TBvXXJSfzWinZiHnsa6Ujgd1gmSvkEWdGw6a0kpIQMdsuSvVhokcQnSrU
         nEe5r2/B77JV34pRMkiPset9VOvumc//4rgrbQatyIAgthogS57s8ExMtjLFq2cl1bLr
         EjaomnmJFmBKNwuI9Yy+tUY6EnE/Ja8ap0OrkCQ4K0QjNxOo1E/l6sV2UVtAWNAjQs1Y
         LKoc/szTOB4qjXfs1PKCVKpZzlgqRZdN0Q4U7fdI6YWmDtObWmJu3V/mqNUZzARUhSpT
         tCeA==
X-Gm-Message-State: AOAM530ZHdzG1KA0dymhtPVA8/Vyi6n2QzO0frIBdToVuOLELGJEOlwK
        PDJzBnaB2UrdDlOPJguA3ZuL8RzxRb1whS4lNmk=
X-Google-Smtp-Source: ABdhPJxLV2MraxoFVkGj8nYLMZ21WASYUC4DRXBcxlj0llLE59xJbgc0nn5XzJeq3XWFBUCLqUIxS87liQoMC70KM8I=
X-Received: by 2002:a4a:7b4b:: with SMTP id l72mr717605ooc.45.1607027292599;
 Thu, 03 Dec 2020 12:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201101193330.24775-11-sorganov@gmail.com>
 <CABPp-BGH0+M_6gYYfYsp54X9DjKM4mv8Vssoo3uZtDAY1_Zb1A@mail.gmail.com> <87ft4mfycq.fsf@osv.gnss.ru>
In-Reply-To: <87ft4mfycq.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Dec 2020 12:28:01 -0800
Message-ID: <CABPp-BFW5ZLvEHFuiRC3rGqdGHWBZRjGHtTq=vVky9U5rZXsvA@mail.gmail.com>
Subject: Re: [PATCH 10/26] diff-merges: new function diff_merges_suppress()
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Thu, Dec 3, 2020 at 12:06 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Sun, Nov 1, 2020 at 11:36 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> This function sets all the relevant flags to disabled state, so that
> >> no code that checks only one of them get it wrong.
> >>
> >> Then we call this new function everywhere where diff merges output
> >> suppression is needed.
> >>
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  builtin/merge.c |  3 ++-
> >>  diff-merges.c   | 18 ++++++++++++++----
> >>  diff-merges.h   |  2 ++
> >>  fmt-merge-msg.c |  3 ++-
> >>  4 files changed, 20 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/builtin/merge.c b/builtin/merge.c
> >> index 9d5359edc2f7..1f7b69982b40 100644
> >> --- a/builtin/merge.c
> >> +++ b/builtin/merge.c
> >> @@ -14,6 +14,7 @@
> >>  #include "lockfile.h"
> >>  #include "run-command.h"
> >>  #include "diff.h"
> >> +#include "diff-merges.h"
> >>  #include "refs.h"
> >>  #include "refspec.h"
> >>  #include "commit.h"
> >> @@ -400,7 +401,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
> >>         printf(_("Squash commit -- not updating HEAD\n"));
> >>
> >>         repo_init_revisions(the_repository, &rev, NULL);
> >> -       rev.ignore_merges = 1;
> >> +       diff_merges_suppress(&rev);
> >>         rev.commit_format = CMIT_FMT_MEDIUM;
> >>
> >>         commit->object.flags |= UNINTERESTING;
> >> diff --git a/diff-merges.c b/diff-merges.c
> >> index 8536941e0b56..25bd9b12e667 100644
> >> --- a/diff-merges.c
> >> +++ b/diff-merges.c
> >> @@ -2,6 +2,13 @@
> >>
> >>  #include "revision.h"
> >>
> >> +static void suppress(struct rev_info *revs) {
> >> +       revs->ignore_merges = 1;
> >> +       revs->first_parent_merges = 0;
> >> +       revs->combine_merges = 0;
> >> +       revs->dense_combined_merges = 0;
> >> +}
> >
> > The function name is not so helpful;
>
> Do you have better suggestion? suppress_output()? supress_diff()?
>
> > why not put all this code directly in diff_merges_suppress()?
>
> I prefer the style where module implementation functions don't call its
> interface functions, only vice versa.
>
> >
> >> +
> >>  /*
> >>   * Public functions. They are in the order they are called.
> >>   */
> >> @@ -29,16 +36,15 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
> >>                 revs->combine_merges = 1;
> >>         } else if (!strcmp(arg, "--cc")) {
> >>                 revs->diff = 1;
> >> -               revs->dense_combined_merges = 1;
> >> -               revs->combine_merges = 1;
> >> +               set_dense_combined(revs);
> >>         } else if (!strcmp(arg, "--no-diff-merges")) {
> >> -               revs->ignore_merges = 1;
> >> +               suppress(revs);
> >>         } else if (!strcmp(arg, "--combined-all-paths")) {
> >>                 revs->diff = 1;
> >>                 revs->combined_all_paths = 1;
> >>         } else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
> >>                 if (!strcmp(optarg, "off")) {
> >> -                       revs->ignore_merges = 1;
> >> +                       suppress(revs);
> >>                 } else {
> >>                         die(_("unknown value for --diff-merges: %s"), optarg);
> >>                 }
> >> @@ -48,6 +54,10 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
> >>         return 1;
> >>  }
> >>
> >> +void diff_merges_suppress(struct rev_info *revs) {
> >> +       suppress(revs);
> >> +}
> >
> > ...especially since all this function does is call suppress()?
>
> Yes, it does, but it doesn't mean it will be that way forever. Interface
> function might need to perform additional checks or actions, in general.

Ah, I didn't catch the distinction and thus the reasoning in having
the two different functions.

> Besides, if diff_merges_suppress() is OK with you as interface function
> name, why suppress() is not OK as local function name in diff-merges
> module?

Right, the fact that it's in the diff-merges module as opposed to more
general diff-lib code is probably hint enough.  I was skimming over
the patches looking for things that jumped out, and although I had
read that you were adding it to the new module, I forgot that when I
saw the "suppress()" function name.  Thanks for the reminder, and
sorry for the noise.
