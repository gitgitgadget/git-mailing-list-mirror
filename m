Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5ABC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8383B619CB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 20:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhC3URM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 16:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhC3URE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 16:17:04 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3F1C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 13:17:04 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso16787407otq.3
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouReABfz13Mzx0foBdUJpsePw15Hr1vZ6A+OgOf3r04=;
        b=gsuNA88dTFKwXwpR5q55YHlLSSfUGERDGspLaiXeLb6mrOFb8dgq3OPcartcZxwND+
         JrIsAKCQ73vlt5EZ5OfyM4K8n/cUmSRdIp56+epeaPVkmtmNMPtjRUujaiV5KaaqVZx5
         G8V5LtuvNodhscQ+jNlk1XulLmRpGSs2RDbzPsEZ3HXhBzAgyLElPG5R2WicdflG6aRN
         c26TzC+j7i5XpFddmGWX8C/nir2lodcK3AH78uAmwFTf+HJCjrDOUcLe9687vrLt1g7G
         KHwP5jpZ6/YYBkfM7Rymo/lXArPiZcVegb//xBeOd1NIF375wtvHcLfLN4YArB8YUBPt
         Valg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouReABfz13Mzx0foBdUJpsePw15Hr1vZ6A+OgOf3r04=;
        b=XYoC117b8HlSmPo/LECBxZ9L+CNqPPKM7hqzrWLXGC6H7WGiKv/UIdZbXVS5i9okr5
         y2oWBYJSRp+6ifwNXQFhrxSyznG6HaPh3QDlAzrn7lQfA0ZKKTreEEQkHgW4l7vs10KN
         V9SUSKLipMHTtC6WxRdoeFt0qnbTTuMvZW5rhnOYHrZa4zLfV3VKbJuYk6Ud7bsnvPqr
         ZQE4vWvbeVuWwwhk1D0ogG7vxvZNTDtdq1BWDRMsQX5y5TKuBvrKtXPT8ZBzVXrGhuzU
         dPGCq6fS1H10k/4PcfA8Fe9aRoEyuvgdewqz0UGXAFtaewbGy+njprswQc+Mw0FXlfsK
         fuXQ==
X-Gm-Message-State: AOAM533x2Va1MrtWaH/o5ES3Gak6NWY+l099SPADX+h63QZ49wyFVyyv
        PPxC/zd1Qzegm4ZH5pWjk6U2DAd3S0yiRN2hJ8o=
X-Google-Smtp-Source: ABdhPJyAykK7ctagjBQAbpaMmHAURK581DKlJ3T6uI0kkjn4SAVVJ45QWUIZc/UArRDwOG7atveRaR7TEy5tYamuzoQ=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr27974441otf.162.1617135423255;
 Tue, 30 Mar 2021 13:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
 <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet> <xmqq7dloeawf.fsf@gitster.g>
In-Reply-To: <xmqq7dloeawf.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Mar 2021 13:16:51 -0700
Message-ID: <CABPp-BErXWkEOCyZtYP9AHd9eP2osL4s1xjMZ_BRkGSktdFnKg@mail.gmail.com>
Subject: Re: [PATCH v2] sequencer: fix edit handling for cherry-pick and
 revert messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 11:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> @@ -182,7 +182,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
> >>                              "--signoff", opts->signoff,
> >>                              "--no-commit", opts->no_commit,
> >>                              "-x", opts->record_origin,
> >> -                            "--edit", opts->edit,
> >> +                            "--edit", opts->edit == 1,
> >
> > Honestly, I'd prefer `> 0` here.
>
> Unless somebody (including Elijah) is trying to soon introduce yet
> another value to .edit member, I'd agree 100%.  If it is a tristate
> (unspecified, no, yes), I think "is it positive" should be the way
> to ask "does the user definitely wants it?", "is it zero" should be
> the way to ask "does the user definitely declines it?" and "is it
> non-negative" (and "is it negative") the way to ask "does the user
> care (or not care)?".  Using that consistently is good.

Sounds good; I'll switch it over.

> >> +static int should_edit(struct replay_opts *opts) {
> >> +    assert(opts->edit >= -1 && opts->edit <= 1);
> >
> > Do we really want to introduce more of these useless `assert()`s? I know
> > that we stopped converting them to `BUG()`, but I really dislike
> > introducing new ones: they have very little effect, being no-ops by
> > default in most setups.
>
> Yeah, in a new code in flux where programmers can easily make
> errors, "if (...) BUG()" may not be a bad thing to add (but then we
> may want to see if we can make the codepaths involved less error
> prone), but I agree with your view that assert() is mostly useless.
> A comment that explains the expectation and why that expectation is
> there would be more useful.

Since you both don't like this assert, I'll remove it.  But I strongly
disagree that assert is useless in general.  If you two have such a
strong reaction to assert statements, though, would you two prefer
that I add a new affirm() function that is ALSO compiled out in
production?  Because I really want to use one of those.  My operating
assumptions with asserts are the following:

1) If the check is relevant for production, assert() statements should
NOT be used; if(...) BUG() should be used instead.
2) assert statements will be compiled out in production, almost always
  2a) NOTE: don't make asserts expensive, since a few production users
will keep them
3) assert statements will be active for future me and some other folks
doing active git development

Do you two disagree with any of those operating assumptions?  I find
asserts very valuable because:

* It's a _concise_ code comment that is readily understood.  Any
attempt to word in English the same thing that an assert statement
checks always takes longer
* It helps future folks tweaking the rules to catch additional
locations where assumptions were made about the old rules.  In the
development of merge-ort, for example, asserts shortened my debugging
cycles as I found and attempted new optimizations or added new
features or changed data structures and so on.  The checks were _only_
assists while developing; once the code is right, the checks could be
removed.  But future development might occur, so it'd be nice to have
a way to keep the checks in the code just for those future developers
while production users remove them.

In particular, for merge-ort, I think the second point is very
helpful.  What can achieve the "remove these now-unnecessary checks
from the code for production, but keep them there for future
development"?  I thought assert() was created exactly for this
purpose.  Would you rather I created an affirm() that does essentially
the same thing and is compiled out unless DEVELOPER=1?  That would
allow us to declare all assert() calls in the code as buggy, but I'm
not sure affirm() is as readily understood by developers reading the
code as "ooh, a reminder I get to assume these statements are true
while I'm reading the rest of the code".

> >> +    if (opts->edit == -1)
> >
> > Maybe `< 0`, as we do elsewhere for "not specified"?
>
> Yup.
>
> >> +            /*
> >> +             * Note that we only handle the case of non-conflicted
> >> +             * commits; continue_single_pick() handles the conflicted
> >> +             * commits itself instead of calling this function.
> >> +             */
> >> +            return (opts->action == REPLAY_REVERT && isatty(0)) ? 1 : 0;
> >
> > Apart from the extra parentheses, that makes sense to me.
>
> I can take it either way (but personally I think this particular one
> is easier to see as written---this is subjective).
>
> > ...
> > The rest looks good, and the comments are _really_ helpful.
>
> Yup, I agree.
>
> Thanks for a review.

Indeed; and thanks to you as well Junio for all your time reviewing.
