Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31675C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0273A6148E
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhC3TiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhC3TiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 15:38:00 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF52CC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:37:59 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so16685614ote.6
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soAxoSEoAfJKS55mdlbfstDGUnl6I8u8d+abDJrskE4=;
        b=ilr5X+Tl7mbITKtL3SenjBl9tiJSD//mSfeCNwWS4M4zPCY/9O0Ilj+Z82dhOjeEqP
         MldELF05gcfI1hX7God+mM45j5q3oA4VbTFD8EAtwQGoTny8DDYwlkrij9jfTZNyrlF8
         iFvBn8NgwYgpU9hApbLm4i772i1eXTlc4BhtTXIUoWRJpThW5udNzg/8iCiqKvRjG+Bx
         E/TceCE2Xyub9iF7G/wNtHJRyAdg1E3XxQ+6BQ7RyO4S0h5zDYXuYCfUJg0J51IDxfBh
         hGAZtNxwZ8U1UAjEr31XV+7yZmiHs7GujJUCYpcKftySP2xjpSvVhWGZwS/pFPp7aHeo
         Jg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soAxoSEoAfJKS55mdlbfstDGUnl6I8u8d+abDJrskE4=;
        b=JxDvpE6BYgdnoUV4A2RTq7PWXv2IhK/WgQ3uKz8OH1xkM3xotiXeBP9Bg2V7qEADnB
         sAYon3fYCqoVy/VnBpmiKq3QY40y1nEt4il1ktWAFelpTmPXtlexLidHgmKBrh/w5bhF
         xPNrimljCKXpaGw59gITPTFj0n8pzs2qPMppricBI6daSZD8mMXWRaJRIMKEsbQtVrHG
         R9Zj4MUVf0vOvJgd5UphlQXA9s4YI/gSdqf4ymY0vROtLoukEGOry0/Toq3+httUfm4t
         GhWVodKDM2iF01BpSqK3Ts9LZSBx1Plgtd7xXglsNZtHskOuXd48oJqRuG6dyDxs6hoo
         kNew==
X-Gm-Message-State: AOAM530lkJ6BsowP4N6lcg7t0Pqdm9ofAqOLX9Q7nVw0lVeo/UlayA4a
        UC63Q/4AuW4LbDxwXUdeW5qPbvF2ZZnrb9BLYRs=
X-Google-Smtp-Source: ABdhPJxcolsCKdRYBzdmjNxMsxdGZraj7xHpu48mwmtUrlVggwRxNBHoGEWoBQBbEN995UnZwBKMpFXB1zMgoppnGk8=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr28981806otf.345.1617133078806;
 Tue, 30 Mar 2021 12:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
 <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Mar 2021 12:37:47 -0700
Message-ID: <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
Subject: Re: [PATCH v2] sequencer: fix edit handling for cherry-pick and
 revert messages
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 3:13 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 30 Mar 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > save_opts() should save any non-default values.  It was intended to do
> > this, but since most options in struct replay_opts default to 0, it only
> > saved non-zero values.  Unfortunately, this does not always work for
> > options.edit.  Roughly speaking, options.edit had a default value of 0
> > for cherry-pick but a default value of 1 for revert.  Make save_opts()
> > record a value whenever it differs from the default.
> >
> > options.edit was also overly simplistic; we had more than two cases.
> > The behavior that previously existed was as follows:
> >
> >                        Non-conflict commits    Right after Conflict
> >     revert             Edit iff isatty(0)      Edit (ignore isatty(0))
> >     cherry-pick        No edit                 See above
> >     Specify --edit     Edit (ignore isatty(0)) See above
> >     Specify --no-edit  (*)                     See above
> >
> >     (*) Before stopping for conflicts, No edit is the behavior.  After
> >         stopping for conflicts, the --no-edit flag is not saved so see
> >         the first two rows.
> >
> > However, the expected behavior is:
> >
> >                        Non-conflict commits    Right after Conflict
> >     revert             Edit iff isatty(0)      Edit iff isatty(0)
> >     cherry-pick        No edit                 Edit iff isatty(0)
> >     Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
> >     Specify --no-edit  No edit                 No edit
> >
> > In order to get the expected behavior, we need to change options.edit
> > to a tri-state: unspecified, false, or true.  When specified, we follow
> > what it says.  When unspecified, we need to check whether the current
> > commit being created is resolving a conflict as well as consulting
> > options.action and isatty(0).  While at it, add a should_edit() utility
> > function that compresses options.edit down to a boolean based on the
> > additional information for the non-conflict case.
> >
> > continue_single_pick() is the function responsible for resuming after
> > conflict cases, regardless of whether there is one commit being picked
> > or many.  Make this function stop assuming edit behavior in all cases,
> > so that it can correctly handle !isatty(0) and specific requests to not
> > edit the commit message.
>
> Nicely explained!
>
> I'll allow myself one tangent: the subject of the sequencer's Unix shell
> script heritage seems to come up with an increasing frequency, in
> particular the awful "let's write out one file per setting" strategy.
>
> I would _love_ for `save_opts()` to write a JSON instead (or an INI via
> the `git_config_*()` family of functions, as is done already by the
> cherry-pick/revert stuff), now that we no longer have any shell script
> backend (apart from `--preserve-merges`, but that one is on its way out
> anyway).
>
> The one thing that concerns me with this idea is that I know for a fact
> that some enterprisey users play games with those files inside
> `<GIT_DIR>/rebase-merge` that should be considered internal implementation
> details. Not sure how to deprecate that properly, I don't think we have a
> sane way to detect whether users rely on these implementation details
> other than breaking their expectations, which is not really a gentle way
> to ask them to update their scripts.

Ooh, I'm glad you took this tangent.  May I follow it for a second?
I'd really, really like this too, for three reasons:

1) I constantly get confused about the massive duplication and
difference in control structures and which ones affect which type of
operations in sequencer.c.  Having them both use an ini-file would
allow us to remove lots of that duplication.  I'm sure there'll still
be some rebase-specific or cherry-pick-specific options, but we don't
need a separate parallel structure for every piece of config.

2) In my merge-ort optimization work, rebasing 35 commits in linux.git
across a massive set of 26K upstream renames has dropped rename
detection time from the top spot.  And it also dropped several other
things in the merge machinery from their spots as well.  Do you know
what's the slowest now?  Wasted time from sequencer.c: the unnecessary
process forking and all the useless disk writing (which I suspect is
mostly updating the index and working directory but also writing all
the individual control files under .git/rebase-merge/).  And this
stuff from sequencer.c is not just barely the slowest part, it's the
slowest by a wide margin.

3) I also want to allow cherry-picking or rebasing branches that
aren't even checked out (assuming no conflicts are triggered;
otherwise an error can be shown with the user asked to repeat with the
operation connected to an active working directory).  For such an
operation, the difference between "cherry-pick" and "rebase" is nearly
irrelevant so you'd expect the code to be the same; every time I look
at the code, though, it seems that the control structures are
separating these two types of operations in more areas than just the
reading and writing of the config.

> > diff --git a/builtin/revert.c b/builtin/revert.c
> > index 314a86c5621b..81441020231a 100644
> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -182,7 +182,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
> >                               "--signoff", opts->signoff,
> >                               "--no-commit", opts->no_commit,
> >                               "-x", opts->record_origin,
> > -                             "--edit", opts->edit,
> > +                             "--edit", opts->edit == 1,
>
> Honestly, I'd prefer `> 0` here.

WFM; I'll change it.

>
> >                               NULL);
> >
> >       if (cmd) {
> > @@ -230,8 +230,6 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
> >       struct replay_opts opts = REPLAY_OPTS_INIT;
> >       int res;
> >
> > -     if (isatty(0))
> > -             opts.edit = 1;
> >       opts.action = REPLAY_REVERT;
> >       sequencer_init_config(&opts);
> >       res = run_sequencer(argc, argv, &opts);
> > diff --git a/sequencer.c b/sequencer.c
> > index 848204d3dc3f..d444c778a097 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1860,14 +1860,26 @@ static void record_in_rewritten(struct object_id *oid,
> >               flush_rewritten_pending();
> >  }
> >
> > +static int should_edit(struct replay_opts *opts) {
> > +     assert(opts->edit >= -1 && opts->edit <= 1);
>
> Do we really want to introduce more of these useless `assert()`s? I know
> that we stopped converting them to `BUG()`, but I really dislike
> introducing new ones: they have very little effect, being no-ops by
> default in most setups.

What do you mean by "useless"?  They serve two purposes:
  * It's a very concise comment understood by readers of the code
  * Many asserts are helpful guardrails for future people attempting
to change the code and assumptions they were written under

Neither of these have anything to do with users running code in
production -- if that mattered, I would have used BUG().  Since
production use isn't relevant here, I could use code comments, but
those tend to be much more verbose, and less helpful in catching areas
where assumptions were important to the code for any future folks
(possibly myself in a few years) who want to change the code in ways
that might call into question previous assumptions.

> > +     if (opts->edit == -1)
>
> Maybe `< 0`, as we do elsewhere for "not specified"?

Makes sense; will change.

> > +             /*
> > +              * Note that we only handle the case of non-conflicted
> > +              * commits; continue_single_pick() handles the conflicted
> > +              * commits itself instead of calling this function.
> > +              */
> > +             return (opts->action == REPLAY_REVERT && isatty(0)) ? 1 : 0;
>
> Apart from the extra parentheses, that makes sense to me.

The extra parentheses make it more readable to me; since the statement
still makes sense to you, I'll leave them in.  :-)

> > +     return opts->edit;
> > +}
> > +
> >  static int do_pick_commit(struct repository *r,
> >                         enum todo_command command,
> >                         struct commit *commit,
> >                         struct replay_opts *opts,
> >                         int final_fixup, int *check_todo)
> >  {
> > -     unsigned int flags = opts->edit ? EDIT_MSG : 0;
> > -     const char *msg_file = opts->edit ? NULL : git_path_merge_msg(r);
> > +     unsigned int flags = should_edit(opts) ? EDIT_MSG : 0;
> > +     const char *msg_file = should_edit(opts) ? NULL : git_path_merge_msg(r);
> >       struct object_id head;
> >       struct commit *base, *next, *parent;
> >       const char *base_label, *next_label;
> > @@ -3101,9 +3113,9 @@ static int save_opts(struct replay_opts *opts)
> >       if (opts->no_commit)
> >               res |= git_config_set_in_file_gently(opts_file,
> >                                       "options.no-commit", "true");
> > -     if (opts->edit)
> > -             res |= git_config_set_in_file_gently(opts_file,
> > -                                     "options.edit", "true");
> > +     if (opts->edit != -1)
>
> s/!= -1/>= 0/

Will fix.

> > +             res |= git_config_set_in_file_gently(opts_file, "options.edit",
> > +                                                  opts->edit ? "true" : "false");
> >       if (opts->allow_empty)
> >               res |= git_config_set_in_file_gently(opts_file,
> >                                       "options.allow-empty", "true");
> > @@ -4077,7 +4089,7 @@ static int pick_commits(struct repository *r,
> >       prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
> >       if (opts->allow_ff)
> >               assert(!(opts->signoff || opts->no_commit ||
> > -                      opts->record_origin || opts->edit ||
> > +                      opts->record_origin || should_edit(opts) ||
> >                        opts->committer_date_is_author_date ||
> >                        opts->ignore_date));
> >       if (read_and_refresh_cache(r, opts))
> > @@ -4370,14 +4382,35 @@ static int pick_commits(struct repository *r,
> >       return sequencer_remove_state(opts);
> >  }
> >
> > -static int continue_single_pick(struct repository *r)
> > +static int continue_single_pick(struct repository *r, struct replay_opts *opts)
> >  {
> > -     const char *argv[] = { "commit", NULL };
> > +     struct strvec argv = STRVEC_INIT;
> > +     int want_edit;
>
> Do we really want that extra `want_edit` variable? I think the code would
> be easier to read without it, and still be obvious enough.
>
> > +     int ret;
> >
> >       if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
> >           !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
> >               return error(_("no cherry-pick or revert in progress"));
> > -     return run_command_v_opt(argv, RUN_GIT_CMD);
> > +
> > +     strvec_push(&argv, "commit");
> > +
> > +     /*
> > +      * continue_single_pick() handles the case of recovering from a
> > +      * conflict.  should_edit() doesn't handle that case; for a conflict,
> > +      * we want to edit if the user asked for it, or if they didn't specify
> > +      * and stdin is a tty.
> > +      */
> > +     want_edit = (opts->edit == 1) || ((opts->edit == -1) && isatty(0));
> > +     if (!want_edit)
>
> Here is what I would prefer:
>
>         if (!opts->edit || (opts->edit < 0 && !isatty(0)))

Given the changes elsewhere to use >0 as true, <0 as unspecified, and
==0 for false, this change makes perfect sense.  I'll include it.

> The rest looks good, and the comments are _really_ helpful.
>
> And the remainder of the patch also looks good, so I will spare readers
> time by not even quoting it.
>
> Thank you!
> Dscho
