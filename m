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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7976C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7793F23B75
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgLRRC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 12:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgLRRC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 12:02:28 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E6C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 09:01:48 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d8so2522763otq.6
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 09:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUJfvd08K5SuvqcoRVv+BjXEzrYDPJD0iW+JjTVdg9M=;
        b=t4Do0SDZ3w7sPSKXWnTWknmC6nMWG3/27b5+L0TnPf5WJpx3R2YPiK5Wx+Qop8hh/t
         0ua5ipwOgb9bgYg5hC6iC88GYHgWarLsCQYw/Ba0kjpoj6zk7bHIZYUmPv3zAy5aDCJL
         818it1SHyhvI/3s8AgLQ/6kiKv9DzrvjeTGq1pQ8eOISMIMyq6Tug1Rsyp6rV9XdwRD0
         GskeMfWHhZig3IMFOdV4bZaihjTR6hSMU41V/aGQjFhdORrBSVH56H7URgYIN13oxLIp
         6z4OFDG9dAtQgSp6Wp4G31orA2ncv2gNLkbLLv8H/xtFKF3dv7sHXZnHihiWSmhIhItN
         1kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUJfvd08K5SuvqcoRVv+BjXEzrYDPJD0iW+JjTVdg9M=;
        b=hoUAMIR5FCKqBqUKNvA2O6XkwrEIkefStCWyUUtsxh7DEK8lDsPrS0fAXH1Xa21WPw
         kvu6d8b7pO18fDyOG3zxj2/EJXSvLVbu9y2iTu/fK4NjH8hatKBbdb8ekOud7vZjyV7M
         RJYIwZKT2rb2id9ncqRUbYsvHlpZW5VPSu1i2tb34IRvfiFY9qFatyFerddZ2XtBsndC
         5KF9K4GHDoFceCP+fhc2tf9KdOa1xD8DVHohufMqchRgkXAs1fKYGLpTE/5nufT8dDsI
         XSM5lV/xDqeG/enCTXtYGCB1N6eC3r9/yd5KpfaWIcJbWVYgO2insxrskDpdsFK1lYiC
         VlwQ==
X-Gm-Message-State: AOAM532CcR5br/WbpvL+ZT/m9f6JgKCETmRAUH8XUdxTpgxvupV8wn6o
        i4HgXm1EcP/n4qyJF+LRT8zK5QJpoZ2rU7cU81VkXhMrTRo=
X-Google-Smtp-Source: ABdhPJzeorjpNdnt0ZuCfECDY7yeuQxQhouP7p+C0/YOjWK2jpSjl2P4bK0xKRuKR8IksWLOortvafLksq3qRDIAwiA=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr3478397oth.316.1608310907519;
 Fri, 18 Dec 2020 09:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-27-sorganov@gmail.com> <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
 <87wnxfb2gt.fsf@osv.gnss.ru>
In-Reply-To: <87wnxfb2gt.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Dec 2020 09:01:36 -0800
Message-ID: <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff without -p
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 6:42 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> New options don't have any visible effect unless -p is either given or
> >> implied, as unlike -c/-cc we don't imply -p with --diff-merges. To fix
> >> this, this patch adds new functionality by letting new options enable
> >> output of diffs for merge commits only.
> >>
> >> Add 'merges_need_diff' field and set it whenever diff output for merges is
> >> enabled by any of the new options.
> >>
> >> Extend diff output logic accordingly, to output diffs for merges when
> >> 'merges_need_diff' is set even when no -p has been provided.
> >>
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  diff-merges.c | 16 ++++++++++------
> >>  log-tree.c    | 13 +++++++++----
> >>  revision.h    |  1 +
> >>  3 files changed, 20 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/diff-merges.c b/diff-merges.c
> >> index 725db2312074..ffe20d8daa4a 100644
> >> --- a/diff-merges.c
> >> +++ b/diff-merges.c
> >> @@ -10,6 +10,7 @@ static void suppress(struct rev_info *revs)
> >>         revs->dense_combined_merges = 0;
> >>         revs->combined_all_paths = 0;
> >>         revs->combined_imply_patch = 0;
> >> +       revs->merges_need_diff = 0;
> >>  }
> >>
> >>  static void set_separate(struct rev_info *revs)
> >> @@ -51,9 +52,11 @@ static void set_dense_combined(struct rev_info *revs)
> >>
> >>  static void set_diff_merges(struct rev_info *revs, const char *optarg)
> >>  {
> >
> >> +       if (!strcmp(optarg, "off") || !strcmp(optarg, "none")) {
> >> +               suppress(revs);
> >> +               return;
> >> +       }
> >>         if (0) ;
> >> -       else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
> >> -               suppress(revs);
> >
> > The "if (0) ;" is still really weird.
>
> An idiom (see my previous answer). I'm fine getting rid of it if you
> guys find it weird (that I'm not).

I've never seen this idiom, and we apparently have no uses of it in
the code.  If it were near any code I was editing, I think I'd rip it
out as a preliminary cleanup patch...but maybe others have other
opinions.

> >
> >>         else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
> >>                 set_first_parent(revs);
> >>         else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
> >> @@ -64,6 +67,7 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
> >>                 set_dense_combined(revs);
> >>         else
> >>                 die(_("unknown value for --diff-merges: %s"), optarg);
> >> +       revs->merges_need_diff = 1;
> >
> > I'd put this above the if-else-else block, to make it clearer why you
> > are returning early for the "off"/"none" case.
>
> Yeah, makes sense, thanks!
>
> >
> >>  }
> >>
> >>  /*
> >> @@ -132,12 +136,12 @@ void diff_merges_setup_revs(struct rev_info *revs)
> >>                 revs->first_parent_merges = 0;
> >>         if (revs->combined_all_paths && !revs->combine_merges)
> >>                 die("--combined-all-paths makes no sense without -c or --cc");
> >> -       if (revs->combine_merges)
> >> +
> >> +       if (revs->combined_imply_patch)
> >>                 revs->diff = 1;
> >> -       if (revs->combined_imply_patch) {
> >> -               /* Turn --cc/-c into -p --cc/-c when -p was not given */
> >> +
> >> +       if (revs->combined_imply_patch || revs->merges_need_diff) {
> >>                 if (!revs->diffopt.output_format)
> >>                         revs->diffopt.output_format = DIFF_FORMAT_PATCH;
> >>         }
> >> -
> >
> > The random space changes squashed in here instead of being combined
> > with the earlier patches that introduced the relevant areas break up
> > the reading.  Would be nice to clean this up.
> >
> >>  }
> >> diff --git a/log-tree.c b/log-tree.c
> >> index f9385b1dae6f..67060492ca0a 100644
> >> --- a/log-tree.c
> >> +++ b/log-tree.c
> >> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
> >>         int showed_log;
> >>         struct commit_list *parents;
> >>         struct object_id *oid;
> >> +       int is_merge;
> >> +       int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
> >
> > So rev_info.diff has changed in meaning from
> > commits-need-to-show-a-diff, to non-merge-commits-need-to-show-a-diff.
> > That's a somewhat subtle semantic shift.  Perhaps it's worth adding a
> > comment to the declaration of rev_info.diff to highlight this?  (And
> > perhaps even rename the flag?)
>
> No, the meaning of rev_info.diff hopefully didn't change. rev_info.diff
> still enables all the commits to pass further once set. It is still
> exactly the same old condition, just assigned to a variable for reuse.
> My aim was to avoid touching existing logic of this function and only
> add a new functionality when opt->merges_need_diff is set.
>
> It looks like I rather choose confusing name for the variable, and it'd
> be more clear if I'd call this, say:
>
>   int need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>
> ?
>
> What do you think?

I think need_diff would actually be confusing.  It can be false when
you need diffs (e.g. --diff-merges=cc with no -p, because then you'd
need diffs for merge commits and not for non-merge commits).  I'd
stick with your original local variable name.

Perhaps opt->diff hasn't changed meaning and I just had a wrong mental
model in my head for what it meant, but even then what seems like its
obvious purpose given its name is mismatched with what it actually
does.  Since you are already changing struct rev_info in this series,
this was more a note that a name change or at least a comment for
opt->diff might be useful.  I mean, you asked a couple times on the
previous series for help trying to understand it, and I could only
offer some flailing guesses and Junio responded with a couple bits of
history.  Clearly, it isn't very clear and this patch reminded me of
that and made me wonder if we're possibly making it a little harder
for others further down the road to figure out.

> >> -       if (!opt->diff && !opt->diffopt.flags.exit_with_status)
> >> +       if (!regulars_need_diff && !opt->merges_need_diff)
> >>                 return 0;
> >>
> >>         parse_commit_or_die(commit);
> >>         oid = get_commit_tree_oid(commit);
> >>
> >> -       /* Root commit? */
> >>         parents = get_saved_parents(opt, commit);
> >> +       is_merge = parents && parents->next;
> >> +       if(!is_merge && !regulars_need_diff)
> >> +               return 0;
> >> +
> >> +       /* Root commit? */
> >>         if (!parents) {
> >>                 if (opt->show_root_diff) {
> >>                         diff_root_tree_oid(oid, "", &opt->diffopt);
> >> @@ -916,8 +922,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
> >>                 return !opt->loginfo;
> >>         }
> >>
> >> -       /* More than one parent? */
> >> -       if (parents->next) {
> >> +       if (is_merge) {
> >>                 if (opt->combine_merges)
> >>                         return do_diff_combined(opt, commit);
> >>                 if (opt->separate_merges) {
> >> diff --git a/revision.h b/revision.h
> >> index bfbae526ad6e..494d86142454 100644
> >> --- a/revision.h
> >> +++ b/revision.h
> >> @@ -194,6 +194,7 @@ struct rev_info {
> >>                         always_show_header:1,
> >>                         /* Diff-merge flags */
> >>                         explicit_diff_merges: 1,
> >> +                       merges_need_diff: 1,
> >>                         separate_merges: 1,
> >>                         combine_merges:1,
> >>                         combined_all_paths:1,
> >> --
> >> 2.25.1
> >
> > The rest makes sense.
>
> Thanks,
> -- Sergey
