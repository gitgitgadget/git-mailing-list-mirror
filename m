Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEB7C433DB
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 19:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE8764E61
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 19:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBUT4g convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 21 Feb 2021 14:56:36 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:33586 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBUT4f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 14:56:35 -0500
Received: by mail-ed1-f48.google.com with SMTP id c6so19411927ede.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 11:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pvOiJg9ojszIA1s8sFmuzlfbNgQtAb3zWPf+Hv8dGtE=;
        b=gYid9AhX66bALONeqhu6taHCKszTu7BxbMLLqEpnHOhJnDlDI5KIz1wkaHnwWQhcgV
         gxSeJ4aOr4j8DKldrcWVjyY9UrioKQy1IC1uRxeiHauxxUg6awzKXPTtk5dC9wRNuMqP
         ssalQer6nkSIdtFxxauat9d8J8kVZyLBTYbii3aEisX3u3IJlInRiGKlGTbaZ/V8Uf0U
         ydlgUFFfwK4fX5Gho99X6w2Yd14R9TZIgFr9Xy4+S3EgTn/pylPI7NUvdJyHXVkcVojy
         Tml/7wAuzBycLjnYkyEzjyzQ6CgcB/oyMcqsu7hv9uaj8fGigKsu4zy3x+pdJN0yLBUq
         sntA==
X-Gm-Message-State: AOAM533Fs3fJWyOTZQHsJ+0kwm8kry+92mHD9MhlUCWq81iIJiwiCcBn
        DST+wP4WydcDBLg0jXBT+rCuQWjXaJByukex4i8=
X-Google-Smtp-Source: ABdhPJwpzdUNyDvybyVMLUmy/hMM0IYXkuYrasQTjfvbqI/lVVnre+baBtXBhwJ6bKfDu1qYWhdClnTWRue5EC2tLY8=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr19289564edt.233.1613937353502;
 Sun, 21 Feb 2021 11:55:53 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
 <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com> <87wnv688u4.fsf@evledraar.gmail.com>
In-Reply-To: <87wnv688u4.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Feb 2021 14:55:42 -0500
Message-ID: <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 8:26 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Jan 06 2021, Eric Sunshine wrote:
> > Yep, when/if --orphan is added to `git worktree add`, it should mimic
> > the behavior of --orphan in git-switch rather than git-checkout.
>
> How would a mode for "worktree add --orphan" that mimics checkout rather
> than switch even look like? The "checkout --orphan" special-case is
> because we retain the index, so you need to "git rm -rf .".
>
> But with worktrees we always get a new index, so AFAICT the only way to
> make it work like "checkout" would be to have it be the only mode that
> copies over the current worktree's index.

I hadn't actually put any thought into it aside from (1) `--orphan`
being a likely candidate for `git worktree add`, and (2) my uses of
orphan branches always involved `git checkout --orphan && git rm -rf
.`. I never got as far as thinking about the actual implementation.

> In any case I implemented a rough version of this today, and it uses the
> "switch" semantics. I only discovered this ML thread afterwards.
>
> It's surely full of bugs, and needs test work (see all the BUG(...)),
> but if someone's interested in taking it further all it should need is
> some more tests & dealing with the edge cases of incompatible options
> etc. It's Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>.

Thanks. This looks like a good start.

> +test_expect_success '"add" worktree orphan branch' '
> +       git worktree add --orphan -b orphan here-orphan &&

Rather than making --orphan a boolean flag, we'd probably want to
mirror the behavior of the other commands and have <branch> be an
argument consumed by --orphan:

    git worktree add --orphan <branch> <path>

That would make --orphan, -b, and -B mutually exclusive, much like
they are for git-checkout, and much like -c, -C, and --orphan are
mutually exclusive for git-switch.
