Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DEBC433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0AA022D70
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgLEBTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLEBTy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:19:54 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085BC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:19:08 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a6so6890353wmc.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtoUpbZMrae/R8mgkf3ZGXMcm4hsOws9x8x8jTArHVQ=;
        b=T4Yven7o7bEanR+iOg/gb6nSDSWAy8lZKj0RZKxaW7d+94j8VDw1Mvut8B/soc7pVw
         b0EOxxz6W5AXlK2Q0c/g9gQffR4MfgpJ5B0mGcuRJY4xCSdyXliGVvDWdMMzj89CabuY
         pBg54kAxUQsKYF5dpYJoJmXKf1KsPSl/SUQb3FDW4Gyz9LpD4N0R8QhxQqq/D4LRGxAD
         kSzdcLtT9wd+FBuUyRdFEYfUluk3O2UFJkkmn66KDjqKBkhdPfC7smpmfFGuhaXPdZpc
         maQIrTlFJOm0HJnXhafhXUk+YjKWGw+2yHptfgz/HxE925pmqQYEu41wfZX2ojGekn8l
         JbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtoUpbZMrae/R8mgkf3ZGXMcm4hsOws9x8x8jTArHVQ=;
        b=H6Yx6iA5j0KzOWejQRFs76Zr8+j/YwZF4UT09De9sXYTjKjJ6nwCs1h3YLsJCL3wEp
         r9tMu0AIAdYX33iqjDZjBzOJpcnuJAirnQ1D/MTGlhmRLPA3lru8+8bZ3EvKfQNoFASi
         WPewhubSftADh448Mdx6AvqqQG53Ob2wzKVIDuzUywgs3FLLMcJWVOl/B78jR4Kmaik2
         r2gvuW9FRHUD3xF89cU6iHhJwljNWTRyW81m1+/z0k04hQlIufxR7lqk4OwUQn0UL/AI
         ERltGs1/GGlp+NZgFrl8BsHbvKlCNk9xPXwgqzdp6IMz2Lxs+L82CLd3lDwcwMjDuRfq
         wVgg==
X-Gm-Message-State: AOAM530AbTKZP99UNGShP9wnkdTq06SlsuqCpNvm2W6DhUoocsKwfQZC
        gNn9SWo3jfZwZl34m7/VDIGKxrixWk/2wZS8r8w=
X-Google-Smtp-Source: ABdhPJxQ5NIIbezgBX3VqVXhblokxvz3RpVew5gOdXMYO8b7L9J9usOzCVkFYgL62hIy0WR5Z1hTiYOOml6pV39bulg=
X-Received: by 2002:a7b:c843:: with SMTP id c3mr6887049wml.100.1607131146462;
 Fri, 04 Dec 2020 17:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-11-felipe.contreras@gmail.com> <CABPp-BGftkZqJ1GuB-7-7PCo3zOYn_Rr1yu4wv6hwtDea5_oYw@mail.gmail.com>
In-Reply-To: <CABPp-BGftkZqJ1GuB-7-7PCo3zOYn_Rr1yu4wv6hwtDea5_oYw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 19:18:55 -0600
Message-ID: <CAMP44s34qZcHPfjgD-eu2onWQCEoH_s5oUCZSeqy0qjijYub1A@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] pull: add proper error with --ff-only
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:34 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > The current error is not user-friendly:
> >
> >   fatal: not possible to fast-forward, aborting.
> >
> > We want something that actually explains what is going on:
> >
> >   The pull was not fast-forward, please either merge or rebase.
> >   If unsure, run "git pull --merge".
>
> Sorry to be a broken record, but I don't like the suggestion in the
> second sentence.  I've said it enough times that I'll quit harping on
> each instance.

In this particular case it does make sense to remove the suggestion,
since it has nothing to do with the current "git pull" default.

The user must decide in this case.

> > The user can get rid of the warning by doing either --merge or
> > --rebase.
> >
> > Except: doing "git pull --merge" is not actually enough; we would return
> > to the previous behavior: "fatal: not possible to fast-forward, aborting."
>
> Do you mean that the changes in this patch aren't enough and that
> future patches will address this shortcoming?  Or do you mean that
> prior to this patch such a bug existed?  Or something else?

I mean this is the shortcoming of using the --ff-only approach, and
why I think a "pull.mode=ff-only" must be introduced.

This patch does as much as it can without changing the semantics of
--ff-only, and it shows the limitations of the approach, as you can
see from the failed test below, and the next patch.

It's inherent to the current behavior of --ff-only.

> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/pull.c  | 34 ++++++++++++++++-----------
> >  t/t5520-pull.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 82 insertions(+), 14 deletions(-)
> >
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index 6ea95c9fc9..f54ff36b57 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -1015,20 +1015,26 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >
> >         can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
> >
> > -       if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
> > -               advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> > -                       "discouraged; you need to specify if you want a merge, or a rebase.\n"
> > -                       "You can squelch this message by running one of the following commands:\n"
> > -                       "\n"
> > -                       "  git config pull.rebase false  # merge (the default strategy)\n"
> > -                       "  git config pull.rebase true   # rebase\n"
> > -                       "  git config pull.ff only       # fast-forward only\n"
> > -                       "\n"
> > -                       "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > -                       "preference for all repositories.\n"
> > -                       "If unsure, run \"git pull --merge\".\n"
> > -                       "Read \"git pull --help\" for more information."
> > -                       ));
> > +       if (!can_ff && default_mode) {
> > +               if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
> > +                       die(_("The pull was not fast-forward, please either merge or rebase.\n"
> > +                               "If unsure, run \"git pull --merge\"."));
>
> This is a much better message for when the user requests --ff-only.

Right. Sans the "git pull --merge" comment :p

> > +               }
> > +               if (opt_verbosity >= 0 && !opt_ff) {
> > +                       advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> > +                               "discouraged; you need to specify if you want a merge, or a rebase.\n"
> > +                               "You can squelch this message by running one of the following commands:\n"
> > +                               "\n"
> > +                               "  git config pull.rebase false  # merge (the default strategy)\n"
> > +                               "  git config pull.rebase true   # rebase\n"
> > +                               "  git config pull.ff only       # fast-forward only\n"
> > +                               "\n"
> > +                               "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > +                               "preference for all repositories.\n"
> > +                               "If unsure, run \"git pull --merge\".\n"
> > +                               "Read \"git pull --help\" for more information."
> > +                               ));
> > +               }
> >         }
> >
> >         if (opt_rebase) {
> > diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> > index 9fae07cdfa..fdd1f79b06 100755
> > --- a/t/t5520-pull.sh
> > +++ b/t/t5520-pull.sh
> > @@ -819,4 +819,66 @@ test_expect_success 'git pull --rebase against local branch' '
> >         test_cmp expect file2
> >  '
> >
> > +test_expect_success 'git pull fast-forward (ff-only)' '
> > +       test_when_finished "git checkout master && git branch -D other test" &&
> > +       test_config pull.ff only &&
> > +       git checkout -b other master &&
> > +       >new &&
> > +       git add new &&
> > +       git commit -m new &&
> > +       git checkout -b test -t other &&
> > +       git reset --hard master &&
> > +       git pull
> > +'
> > +
> > +test_expect_success 'git pull non-fast-forward (ff-only)' '
> > +       test_when_finished "git checkout master && git branch -D other test" &&
> > +       test_config pull.ff only &&
> > +       git checkout -b other master^ &&
> > +       >new &&
> > +       git add new &&
> > +       git commit -m new &&
> > +       git checkout -b test -t other &&
> > +       git reset --hard master &&
> > +       test_must_fail git pull
> > +'
> > +
> > +test_expect_failure 'git pull non-fast-forward with merge (ff-only)' '
> > +       test_when_finished "git checkout master && git branch -D other test" &&
> > +       test_config pull.ff only &&
> > +       git checkout -b other master^ &&
> > +       >new &&
> > +       git add new &&
> > +       git commit -m new &&
> > +       git checkout -b test -t other &&
> > +       git reset --hard master &&
> > +       git pull --no-rebase
>
> Do you mean `git pull --merge`?

Yes. You found all the issues I spotted in my last review after I sent
the patches.

Good eyes.

Already fixed.

Cheers.

-- 
Felipe Contreras
