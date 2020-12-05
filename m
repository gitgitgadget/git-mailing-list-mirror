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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3E5C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8688F22D70
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgLEBES (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgLEBES (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:04:18 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05200C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:03:37 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so8521624wmb.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+/UDYuc2Err74mONdwkprEmF/UX0BDuzqkZzXhYCxU=;
        b=vfP6eMr7jLA0bNxzrfDbtGK7Whtt2PVSBsAQaMDH9SN2T0fI9ZkcJ2GJqOjgFBve9L
         chB5AsoEzeEKbU9ymBSZBqrPTPdtnzv4t1SCmH5cbrJZVmMFcv7RA7kuLT4YzKjfnpKl
         QyTHTI1VfRYi864UCfeK92ox2KW0AbD0led/1TTLv1FfGkvkfWr+02N1Uo1iuSjhNzuq
         GI73cm95vr600mT6QqImDI1mbOYU5jrUwmkWJ0HkJwzvuxBiIcZw58wdA6TqlqK4/iK1
         16d4wP3I/uhdgb7nNcy/EqDZOazH04+QOd1OS9ENDXGwaYdjXSNDsglEcjfimdXs4dDQ
         KaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+/UDYuc2Err74mONdwkprEmF/UX0BDuzqkZzXhYCxU=;
        b=ONrNr7QoM4rsDOa/vZGJX93wZZ3ZQnfTwQRQSxSrGnOMZymH+duQYwKPVsMoXdQgP4
         MeMdKFObCgWUdBjSj//IJ8zSwIVwrWYNQnkmGVqj4r0GIXH94AG1lAauwPvfx29nByB9
         x5y8OnN4IW41eqskxq4HKKyCIdcXE7NV9uBWc9n93WvYLeuOLoorXVvtCQnHnNSrqbqG
         QfLx32XhU9WK9QH45iNwpm37R4KddRezeeoVEJ7CI87q+fk2QTVdq/cjjlAz3gaw9kSw
         mrkVJisSAUHY/HcofG29Bi9vn1Wi8Aldz1Py4/lZb1PpwIVUvf+gEX7SX515XSEvSZk7
         wk4Q==
X-Gm-Message-State: AOAM5315kBhlERfBrQ8I7rLGKGDGtUyQcVnJXr4FVNRuDDsdFYKmtKJ6
        fQFmLXnZX041bLqWTh3hS5hyWW1rhDHwTVVUAb8=
X-Google-Smtp-Source: ABdhPJxkah9QlPKBD/7khWrTt8k5Uzkyb+VChy065Sc/EaRzrTkNWn6rgpfWB1T2aqKodVqi3jrWVabeyY4J/YVbDvQ=
X-Received: by 2002:a1c:6008:: with SMTP id u8mr6547231wmb.173.1607130216676;
 Fri, 04 Dec 2020 17:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-8-felipe.contreras@gmail.com> <CABPp-BEdgwcueYC1OWd3LtJaGPLgLcdkezGEqeKo7mVfx=C6Jg@mail.gmail.com>
In-Reply-To: <CABPp-BEdgwcueYC1OWd3LtJaGPLgLcdkezGEqeKo7mVfx=C6Jg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 19:03:25 -0600
Message-ID: <CAMP44s1KtTP20bVimXkY7b_obGFD6E2ObuQEeYWEuRBDyWH18g@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] pull: display default warning only when non-ff
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

On Fri, Dec 4, 2020 at 5:24 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > There's no need to display the annoying warning on every pull... only
> > the ones that are not fast-forward.
>
> I like this.  :-)
>
> > This requires the tests to pick another base, so the merge is not
> > fast-forward.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/git-pull.txt   |  3 +++
> >  builtin/pull.c               |  2 +-
> >  t/t7601-merge-pull-config.sh | 28 +++++++++++++++++-----------
> >  3 files changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> > index dc812139f4..ad33d2472c 100644
> > --- a/Documentation/git-pull.txt
> > +++ b/Documentation/git-pull.txt
> > @@ -60,6 +60,9 @@ However, a non-fast-foward case looks very different.
> >         origin/master in your repository
> >  ------------
> >
> > +By default `git pull` will warn about these situations, however, most likely
> > +you would want to force a merge, which you can do with `git pull --no-rebase`.
> > +
>
> Everything in this sentence after the first comma seems dangerous to
> me for a number of workflows.

And this is precisely the reason why the default of "git pull" must be
changed to --ff-only (or similar).

But today "git pull" by default is the equivalent of "git pull
--merge". We need to explain to users why the warning is there, and
that "git pull" is doing an implicit "git pull --merge", and if they
do it explicitly they can get rid of the warning.

Later on when the default is changed to --ff-only this text can be
updated to something less dangerous.

But not explaining what "git pull" is doing today by default will not
make it any less dangerous.

> >  Then "`git pull`" will fetch and replay the changes from the remote
> >  `master` branch since it diverged from the local `master` (i.e., `E`)
> >  until its current commit (`C`) on top of `master` and record the
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index f82e214fc8..f0b1c6bfea 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -1013,7 +1013,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >
> >         can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
> >
> > -       if (default_mode && opt_verbosity >= 0 && !opt_ff) {
> > +       if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
> >                 advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> >                         "discouraged; you need to specify if you want a merge, or a rebase.\n"
> >                         "You can squelch this message by running one of the following commands:\n"
> > diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> > index 6774e9d86f..6b4adab8b1 100755
> > --- a/t/t7601-merge-pull-config.sh
> > +++ b/t/t7601-merge-pull-config.sh
> > @@ -28,7 +28,7 @@ test_expect_success 'setup' '
> >  '
> >
> >  test_expect_success 'pull.rebase not set' '
> > -       git reset --hard c0 &&
> > +       git reset --hard c2 &&
> >         git -c color.advice=always pull . c1 2>err &&
> >         test_decode_color <err >decoded &&
> >         test_i18ngrep "<YELLOW>hint: " decoded &&
> > @@ -36,54 +36,60 @@ test_expect_success 'pull.rebase not set' '
> >
> >  '
> >
> > -test_expect_success 'pull.rebase not set and pull.ff=true' '
> > +test_expect_success 'pull.rebase not set (fast-forward)' '
> >         git reset --hard c0 &&
> > +       git pull . c1 2>err &&
> > +       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> > +'
> > +
> > +test_expect_success 'pull.rebase not set and pull.ff=true' '
> > +       git reset --hard c2 &&
> >         test_config pull.ff true &&
> >         git pull . c1 2>err &&
> >         test_i18ngrep ! "Pulling without specifying how to reconcile" err
> >  '
> >
> >  test_expect_success 'pull.rebase not set and pull.ff=false' '
> > -       git reset --hard c0 &&
> > +       git reset --hard c2 &&
> >         test_config pull.ff false &&
> >         git pull . c1 2>err &&
> >         test_i18ngrep ! "Pulling without specifying how to reconcile" err
> >  '
> >
> >  test_expect_success 'pull.rebase not set and pull.ff=only' '
> > -       git reset --hard c0 &&
> > +       git reset --hard c2 &&
> >         test_config pull.ff only &&
> > -       git pull . c1 2>err &&
> > +       test_must_fail git pull . c1 2>err &&
>
> It makes sense to me that you'd need test_must_fail here...but why
> wasn't it needed before??  How did this test pass without it before
> this series?

Because before it was a fast-forward (from c0), not so anymore (from
c2); "pull.ff=only" fails if it's not a fast-forward.

Cheers.

-- 
Felipe Contreras
