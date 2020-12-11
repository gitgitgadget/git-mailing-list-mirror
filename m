Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87198C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 12:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B40423EF2
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 12:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405971AbgLKMto (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 07:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405976AbgLKMt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 07:49:26 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E88FC0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 04:48:46 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id q18so1382343wrn.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 04:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKBDKPFtdyu4CPaN6I9oRdskj/MI/3CG52wE2Vb9rxM=;
        b=QqWMYEx70E3CXgausJ+x7iMl3limDc5OoJAlXXJUCU9/9n4b/JTUiapZPazubPTYNn
         yiJ+6uOIThclGZHjfJ0sraUqn9cEuf3rXm9s4aV/K+tg7NWaw7sKE7jc/kom4/1M1/gN
         WjEMcPBQXKrCCJAOsaIhnVw3B589JtGldFzCVS+BRSPERuk9EDDmHZEVVlFYH7LI34Xv
         1sTTaz3fu19ZLOzZRVrOKt5ERmKWK1RMlPWcD0YYt9u5UayrV4837yMuYy33nmrVqjqQ
         DP/4SpXm/rv0gh/BjszXgkjsRA7WXjcsotcQ7sVpINw5fA6kk6SBYj/cp/YYkzRNP/hT
         1OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKBDKPFtdyu4CPaN6I9oRdskj/MI/3CG52wE2Vb9rxM=;
        b=bLhIo5dFEUnZBKV1RMiAJmpBk/cOgAlpdXZANjaJ9BeJ5MpIytFskyJ8Y2FyBVWPOF
         QZDAgwD+4tbceOqwjkSyIfypTxwu/mbq0NT/x31Xx9IaR+i49XGfQVv8YGSx9VCALqYK
         o29hZfFremMRkvi7kE7qwY+7IPaE3cMDBWTIOehL3MFKH21a5BbyG/B/jCfQABDcDip6
         f86LSL5RGtb8OgWbM60frfrpXe65dMLjvMU+eeK8EyVbOQcTN6CzP1oIcTKkQcAmFEC9
         2JNi8ri4aTOYNHbr369aQhJ8k/dzPruZhMQWdRq9fPSwkIETKYo3FoG4WEAqEEkgkdMy
         FN3Q==
X-Gm-Message-State: AOAM531vcVR+HGbIatc0Dr6OgdxKxtiZyFVbCnp/DQEt/rmb1nv++nXX
        pv1SFzVl7yiS9bEHlXUtYvOagcZ4E+SBBrKkJjrUUdTeQo5y7/dS
X-Google-Smtp-Source: ABdhPJybAOEWvkG3/Sd81n7wayQi2cRS6P9o5BJXCuALbEKmRWA7c+xOziw7Mywp9gaVcbjRgCDCQ39I4wctTDNmr2A=
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr6877624wru.84.1607690924691;
 Fri, 11 Dec 2020 04:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <20201210100538.696787-4-felipe.contreras@gmail.com> <xmqqzh2kitn9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh2kitn9.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 06:48:33 -0600
Message-ID: <CAMP44s0wjfZ9TeQzpJvVD-OzFA47HFd87TABiJo3Ec9H8j-fjA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] pull: display default warning only when non-ff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 3:22 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > There's no need to display the annoying warning on every pull... only
> > the ones that are not fast-forward.
>
> Yes!  And thanks to the previous two steps, the change to the code
> is quite obvious.  I don't have to give any further comment on the
> part that changes code---it is well done, period.
>
> > This requires the tests to pick another base, so the merge is not
> > fast-forward. And in the cases where --ff-only is specified add
> > test_must_fail (since now they are non-fast-forward).
>
> I am not sure what this means.

It means in order to test the previous warning--which appeared in
fast-forward and non-fast-forward merges, and now appears only on
non-fast-forward merges--we need non-fast-forward merge situations.

> Existing tests pull histories that may or may not be descendants of
> the HEAD.  If we do not change the pair of commits involved in the
> tests, i.e. if we do not apply many s/c0/c2/ replacement I see in
> the patch, some of these tests would change their behaviour with
> respect to their advice output (but not the outcome).

All the tests, actually.

> The ones that
> pulled fast-forward would stop showing the warning, and that is a
> good effect of this change.  We want to see that in the update to
> the tests, no?

Yes.

> The ones that pulled non-fast-forward history would still show the
> warning as they used to, and that is also what we want to see after
> this change.

Currently no test is doing that; all are in a fast-forward situation.

> In other words, the changes the paragraph says that the commit made
> to the tests sound quite backwards.

I'm not sure how it is backwards. All the tests are fast-forward, we
need them not fast-forward, so we pick another base... so the merges
are not fast-forward.

> The actual changes to some of the tests do look sensible, testing
> both sides of the coin.  I've looked at the changes to the tests,
> but cannot convince me that we are not making irrelevant changes
> to the tests, or losing coverage needlessly because of s/c0/c2/
> (i.e. turning tests that used to check fast-forward situations
> into tests that check non-ff situations).

No test is checking fast-forward situations, because the warning
doesn't check fast-forward situations.

> > diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> > index 6774e9d86f..6b4adab8b1 100755
> > --- a/t/t7601-merge-pull-config.sh
> > +++ b/t/t7601-merge-pull-config.sh
> > @@ -28,7 +28,7 @@ test_expect_success 'setup' '
> >  '
> >
> >  test_expect_success 'pull.rebase not set' '
> > -     git reset --hard c0 &&
> > +     git reset --hard c2 &&
> >       git -c color.advice=always pull . c1 2>err &&
> >       test_decode_color <err >decoded &&
> >       test_i18ngrep "<YELLOW>hint: " decoded &&
>
> This is not "keeping what the original test does and adjusting the
> expectation, to demonstrate how behaviour changed"; instead, we make
> sure that the message we originally gave and we intend to keep
> giving is shown in non-ff situation by choosing the current commit
> that won't allow a ff merge.  This is OK if we did not lose test
> coverage---as long as we test that we no longer give the message in
> ff situation somewhere else, And that happens later, I think.
>
> > @@ -36,54 +36,60 @@ test_expect_success 'pull.rebase not set' '
> >
> >  '
> >
> > -test_expect_success 'pull.rebase not set and pull.ff=true' '
> > +test_expect_success 'pull.rebase not set (fast-forward)' '
> >       git reset --hard c0 &&
> > +     git pull . c1 2>err &&
> > +     test_i18ngrep ! "Pulling without specifying how to reconcile" err
> > +'
>
> This is the new test to check the other side of the coin.  It sees
> how the original test to merge c1 into c0 would behave with the new
> code.  We make sure we do not give the advice because it is
> irrelevant in this situation.
>
> So the above two are good, even though the way this patch updates
> tests is probably a bit more error prone than necessary.

Any suggestions to make it less error prone are welcome.

> Since we have checked how the new code behave for fast-forward with
> this new test, the remainder of the entire test script can be
> modified to test only non-ff situation without losing test coverage?
>
> I am not sure if that is the case.

It is the case. That's what the patch does.

> > +test_expect_success 'pull.rebase not set and pull.ff=true' '
> > +     git reset --hard c2 &&
> >       test_config pull.ff true &&
> >       git pull . c1 2>err &&
> >       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> >  '
>
> We are merely allowing fast-forward merges without unnecessary merge
> commits, but we are faced to merge c1 into c2, which is not ff.  The
> command goes ahead and merges anyway, but why shouldn't we be seeing
> the message?  I am puzzled.

Because that's what the current code does; it just checks that any
opt_ff is set, it doesn't check for any specific values.

I tried to fix that since v1, v2, v3, and v4 of the series [1], which
only received comments from Elijah Newren, but that's a separate
patch, and as I mentioned in the cover letter of v5; I've dropped all
those other patches.

> >  test_expect_success 'pull.rebase not set and pull.ff=false' '
> > -     git reset --hard c0 &&
> > +     git reset --hard c2 &&
> >       test_config pull.ff false &&
> >       git pull . c1 2>err &&
> >       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> >  '
> >
> >  test_expect_success 'pull.rebase not set and pull.ff=only' '
> > -     git reset --hard c0 &&
> > +     git reset --hard c2 &&
> >       test_config pull.ff only &&
> > -     git pull . c1 2>err &&
> > +     test_must_fail git pull . c1 2>err &&
> >       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> >  '
>
> This used to test that fast-forwarding the HEAD from c0 to c2 would
> be done successfully without issuing the message.  Shouldn't that
> still be true in the improved "do not complain on fast-forward" code?

No. It doesn't care if it's fast-forward or not; it's just checking
that "pull.ff=only" is set.

Before the code just checks "!opt_ff", now it checks "!opt_ff && !can_ff".

So, in order to do the "pull.ff=only" check, we need a non-fast-forward merge.

> We seem to be losing test coverage by checking how pull.ff=only prevents
> the command from working in a non-ff merge.

No we don't. Remove the "test_config pull.ff only" and the test fails,
as expected.

> I'd stop my review on the tests here, but I generally think s/c0/c2/
> done in this patch is a wrong thing to do.  We are changing the
> condition under which the messages is given (we are narrowing it to
> avoid giving it when it is irrelevant), without changing the final
> outcome (even though we changed the condition to give the message,
> we didn't change what the final outcome of the pull command would
> be), so I'd strongly prefer testing the same set of scenarios and
> update the expectation to an improved reality.

We are testing *exactly* the same test scenarios, we are just forcing
can_ff to be false.

If I remove the precise thing each test-case is supposed to test:

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6b4adab8b1..6c3413ddc9 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -44,52 +44,49 @@ test_expect_success 'pull.rebase not set (fast-forward)' '

 test_expect_success 'pull.rebase not set and pull.ff=true' '
  git reset --hard c2 &&
- test_config pull.ff true &&
  git pull . c1 2>err &&
  test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '

 test_expect_success 'pull.rebase not set and pull.ff=false' '
  git reset --hard c2 &&
- test_config pull.ff false &&
  git pull . c1 2>err &&
  test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '

 test_expect_success 'pull.rebase not set and pull.ff=only' '
  git reset --hard c2 &&
- test_config pull.ff only &&
- test_must_fail git pull . c1 2>err &&
+ git pull . c1 2>err &&
  test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '

 test_expect_success 'pull.rebase not set and --rebase given' '
  git reset --hard c2 &&
- git pull --rebase . c1 2>err &&
+ git pull . c1 2>err &&
  test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '

 test_expect_success 'pull.rebase not set and --no-rebase given' '
  git reset --hard c2 &&
- git pull --no-rebase . c1 2>err &&
+ git pull . c1 2>err &&
  test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '

 test_expect_success 'pull.rebase not set and --ff given' '
  git reset --hard c2 &&
- git pull --ff . c1 2>err &&
+ git pull . c1 2>err &&
  test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '

 test_expect_success 'pull.rebase not set and --no-ff given' '
  git reset --hard c2 &&
- git pull --no-ff . c1 2>err &&
+ git pull . c1 2>err &&
  test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '

 test_expect_success 'pull.rebase not set and --ff-only given' '
  git reset --hard c2 &&
- test_must_fail git pull --ff-only . c1 2>err &&
+ git pull . c1 2>err &&
  test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '

What do we get?

not ok 4 - pull.rebase not set and pull.ff=true
not ok 5 - pull.rebase not set and pull.ff=false
not ok 6 - pull.rebase not set and pull.ff=only
not ok 7 - pull.rebase not set and --rebase given
not ok 8 - pull.rebase not set and --no-rebase given
not ok 9 - pull.rebase not set and --ff given
not ok 10 - pull.rebase not set and --no-ff given
not ok 11 - pull.rebase not set and --ff-only given

All failures. Exactly as expected.

So what coverage precisely are we losing?

Cheers.

[1] https://lore.kernel.org/git/20201204061623.1170745-13-felipe.contreras@gmail.com/

-- 
Felipe Contreras
