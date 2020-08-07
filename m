Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14CAC433E3
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B624206B6
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JstDt15x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgHOV6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgHOVv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:58 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F18FC02B8E2
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 04:39:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w14so12572909ljj.4
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=zbRJGwGH//QLcB2HQu/21P2Jd4juyc/Ca7axUP3mAwU=;
        b=JstDt15xv3vpPJmLXlHiwv52wG+eOMKyyjmClC9FaVYHcAvvy3YGHZWZKh02hJAEk5
         R6eIy9cjB4xmcZzD/crirfzQbtBSJ9RGKXYN3hnywR5tp60brpXDh9GhrLluHaUOrpH2
         CVS795Gz4or23oSDmWDuGlFghHhVFugmNozEVVgKhvP/r4cQBGUFXXsfmwVRM0Oi0Brt
         yj2SiUWVcq3Iz+aW4tFIfEC82iuCy9uCDEftikRiORRIXD+1mE94Hw/H4zxg/f205T3T
         MDT78GXKMVLVXw04lUJAjf85ZBJTkpFyoEy6DOcp8e2R1ejDIncItjST7uiavlJ3xUnq
         M0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:message-id
         :user-agent:mime-version;
        bh=zbRJGwGH//QLcB2HQu/21P2Jd4juyc/Ca7axUP3mAwU=;
        b=TP0UbKqIONiCrOOQPciND0+DhNVziO7hr5pvjezTmtcaL2cpHZJEdEOkj7gGG57axg
         bpfORhZcYHANlErp9VmiwoG2Xqh5PNYQmTTlfn5g0/ON5PH3rPXAFyFyI15wRiBgcdWy
         qLOVBvyoHZSeHRZeX4Hib59GwD+loOVB+iIGYAZ0DKV/ff/5rsknXY15rOXMqqr7rkRm
         bTxsMxWwlaYce1/pbCoruZCkn7YnMS3QMFyS6s8qcCNakACOljhRa/RVYUMrvUdyDG5R
         PPOyi7o5J7o1BF3qeA9w8EKmI2wCrCh7vS8jfTYuLWjfI6/oXIvJ0V1OX/bBOv8lfCya
         XsSg==
X-Gm-Message-State: AOAM530RUGS/2Ie8WpLn8WdWpaHXWzFs9sa6OEjTDYL+5MOmawb4iX7P
        yXUoPRxvSfNZyUEjDm5Qi8vpvJ/rw74=
X-Google-Smtp-Source: ABdhPJxbHdfjdMlB3xWgUJKbRM+Y+LFY0sEyauKPRiBpqoC0ZWLgA8zVslQWOOH/EZATZBHZCa1HlQ==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr3175596lji.67.1597491565913;
        Sat, 15 Aug 2020 04:39:25 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h2sm2357453ljl.16.2020.08.15.04.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 04:39:24 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  3/3] t/t4013: add test for --diff-merges=off
Date:   Sat, 08 Aug 2020 02:11:45 +0300
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-4-sorganov@gmail.com>
        <xmqq3650n2rc.fsf@gitster.c.googlers.com> <87lfisk915.fsf@osv.gnss.ru>
        <xmqqy2msllz0.fsf@gitster.c.googlers.com>
        <xmqqtuxglksy.fsf@gitster.c.googlers.com> <87ft90uq8w.fsf@osv.gnss.ru>
        <xmqqmu37lmym.fsf@gitster.c.googlers.com>
Message-ID: <874kp4uoic.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I asked because I thought you see some essential difference between two
>> tests, as you didn't suggest to add similar permutation test to the
>> original. I think this reply resolves my doubt.
>
> Yeah, I didn't explain this very well.

I think you actually did in a previous thread where I've suggested to
change the order in the existing test to relax it slightly, but more
explanations never hurt.

>
> The thing is that the way "--first-parent" interacts with other
> options that countermand "--diff-merges" (i.e. "--no-diff-merges"
> and "--diff-merges=off") needs to be highlighted with extra clarity,
> simply because "--first-parent" is different from a simple
> "combination" of "follow the first parent commit chain while
> traversing" and "--diff-merges" [*1*]
>
> [ *1* It makes it worse that the "-m" option itself changes behavior
> (whether it is given explicitly or implied) when used together with
> "--first-parent".  Unlike "git log -m -p" without "--first-parent",
> you cannot see the difference the mainline brought in to the side
> branch when the "--first-parent" option is in use. ]

The more you explain it, the more I'm reinforced in my view that the
whole thing is unnecessary complicated, and that we'd better fix it than
try to cast it in stone.

> It merely "implies" (or "defaults", which is the usual word we use)
> "--diff-merges", so anything the user says explicitly on the command
> line countermands it, i.e.

This sounds exactly as if "implied" option were put at the beginning of
the options list, no?

By the way, could you please give an example in documentation where
"defaults" is used to mean "implies", or is it informal and just for
communication of intentions? I failed to find it myself, see below.

>
>     git log --first-parent --no-diff-merges -p
>
> does not trigger "--diff-merges" because the user explicitly says
> that diffs for patches are unwanted after saying "--first-parent"
> (i.e. without "--no-diff-merges" later, we would have done the
> "diff-merges" implied by "--first-parent").
>
> And
>
>     git log --no-diff-merges --first-parent -p
>
> does not trigger "--diff-merges"

So, do these both effectively resolve to:

      git log -m --no-diff-merges --first-parent --patch 

where first -m is the one implied by --first-parent, and the rest are
real options relieved from their side-effects, so that reals are
mutually independent and thus immune to specific relative positions?

> because the user explicitly said that diffs for patches are unwanted
> by the time "--first-parent" is seen (i.e. without "--no-diff-merges"
> upfront, "--first-parent" would have weighed in to enable
> "--diff-merges" behavior, but because the user already said "no", it
> wouldn't).

This is too complicated for my taste. I believe useful outcome could be
achieved without such inter-dependencies, only by using options that
/actually/ imply other option(s) by simple substitution, instead of
"defaulting", whatever it actually means, that would allow to
technically describe options without resorting to guessing user
intentions, and without need to explain behavior by outcome of a set of
examples.

Those particular options aside, there is yet another existing kind of
option that we didn't take into account yet:

      --patch-with-raw
           Synonym for -p --raw.

Synonym! Now, "synonym" means something very definite: that I can safely
substitute one for another with no change of semantics, right? So, here
it is, the "implies" that I mean -- true substitution, and also with no
other side-effects! Synonym, perfect! For myself I call such option a
"convenience option", an option that does nothing else but brings in
(implies) specific set of other options. OK, let's remember we already
have that.

[The only problem with it is that even longest form "--patch --raw" is
shorter than the option itself, so there doesn't seem to be a point of
having this synonym. Looks like historical option converted to
"convenience option" some time ago.]

Digging further, in an attempt to actually find where "defaults" term is
used, I stomped over acutal use of "imply", rather than "default", and
then to yet another kind of option, "shorthand"! What a nice name for
what I called "convenience option" above, I thought! Let's check:

--oneline::
	This is a shorthand for "--pretty=oneline --abbrev-commit"
	used together.

Nice, "shorthand" sounds exactly like "shorter synonym", so it must be
true substitution!

But then, we have this:

--no-abbrev-commit::
	Show the full 40-byte hexadecimal commit object name. This negates
	`--abbrev-commit` and those options which imply it such as
	"--oneline". It also overrides the `log.abbrevCommit` variable.

So, --oneline "implies", according to this piece of git documentation,
--abbrev-commit, and simultaneously --oneline is "shorthand"=="synonym",
that to me means it substitutes --abbrev-commit.

The problem is that, as direct consequence of the above, "implies" must
mean simple substitution, that contradicts the definition of "implies"
being something called "defaults" that you gave at the beginning of your
explanations.

So, finally, I'm entirely lost in all this, again. There doesn't seem to
be strict definition that could be relied upon, and that is not a good
sign.

[Unrelated, but mention not to forget. According to description above,
when --oneline implies --abbrev-commit, the --no-abbrev-commit negates
entire --oneline rather than implied --abbrev-commit! Is this a defect
of the description, or an intended behavior, I wonder?]

>
> This is quite different from options that are orthogonal to each
> other.  We do not need permutations of "log --root --cc" vs "log
> --cc --root" tested.  We know from the code that they cannot
> possibly interact with each other.  We could still test the
> permutations, and it may give us more "complete" coverage, but it
> may be of very low value.

These I like very much!

Ideally, all the different options would be orthogonal to each other,
making things much simpler to grasp, test, and describe, overall. I
believe this should be one of the explicit rules or guidelines for
design for new options, as well as for fixing old options whenever it's
possible without breaking things.

> As to permutations of additive options, we do want to make sure they
> are truly additive (as opposed to being the "last one wins") and as
> a side effect of ensuring the additive nature, we would end up
> testing the effect of the order of options given, e.g. "git commit
> -m paragraph1 -m paragraph2".

These are to be rare exceptions, I think, with explicit tests indeed.

> As to permutations of options that directly overrides or opposes
> each other, we may want to ensure e.g. that "git log -p -U2 -U4"
> uses four context lines and "git log -p -U4 -U2" uses two or that
> "git format-patch --attach --no-attach" does not use attachment and
> "git format-patch --no-attach --attach" does (i.e. "last one wins").

Yeah, the same option with different values should override itself in
general, except additives that you've mentioned above.

>
> But again, especially for commands that use parse-options API
> correctly to implement their command line options, it is hard to get
> these two cases wrong (e.g. you need to deliberately write a
> callback to make "log -p -U2 -U4" additive to use six context
> lines), so it may be of lower value to throughly test permutations.
> It would not be as low as testing permutations of unrelated options,
> though.

This is very good! The only problem remaining is to avoid creating new
inter-dependencies and to get rid of existing wherever possible.

BTW, the revision.c does not use the parse-options API, right? Is it
possible to change that gradually, or should it be done all at once
instead? I mean, if I implement new option for revision.c, should I
somehow rather use the parse-options API instead of imitating existing
code in revision.c?

Thanks,
-- Sergey
