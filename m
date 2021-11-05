Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3412AC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0862661216
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhKESwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhKESw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 14:52:29 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D9EC061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 11:49:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e136so21819935ybc.4
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 11:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mrDhVpFCBIfi48MXsPwWQA+q7Kej3iz7NaXBiqpgbY=;
        b=hieJLBfZOb8T1c39EWVOJPLsIdID5AyHqwEN+S5SmavDUXoD5y1Nl58HfrwDsniX6D
         Hyrk3INhFtb5A2NdrGbHYjHwdsOxbh6irv55TzI750Vw6eJZCmil/FJfg1EEmV1gsaFs
         AspoaUaaOUZpw1di9YT9k2OQADG7xfH2xr0ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mrDhVpFCBIfi48MXsPwWQA+q7Kej3iz7NaXBiqpgbY=;
        b=nQZW29vyKjfPj9Bxmv5sbbUrrGztvNt8n7sXZKIELv1vS2KyTI/1bwHBdgHwQowjRo
         CFaGB6czVDC3DECXcbFZnZeogfdf6/PCW+2bfUUIcfxH9QLH8cuWqgIJulhWbrcrqhLh
         /RYoPPuiDFTSVOfTKvvOmKOOmZ5DK8izLgoh2aDs2aUQpQkKVo5NoYLZKvQYtAhhjgvr
         vdpqYsN5qKCHq1uzSlkP6wPmTKARJpnRhObPhHVAS2B22PP8FLuhSXW8FnQO+1Tn9DbW
         igVFpTcOSnPGdsJx4493w8RGqkKoqrfP/BSRwezagqGxWInIyL8NUsgFkQ38BxXzDMY2
         aJ2w==
X-Gm-Message-State: AOAM533s/pZ2nxSRxBX0+bLfbWLWKkajofv4NN4IsIH0FZWbs4BacRro
        +XrtEOALUzHbj/Tw148F/g8yDyJZ8opmyDfQdQR3qg==
X-Google-Smtp-Source: ABdhPJz/zHobEW1o7Q1892TZCAikFfNPUK4Td0a3NFvqIrCQj2qZ4rL0l4RlSbBtN56YzyTgtAeAMcE8RXo6Pqo1fxk=
X-Received: by 2002:a25:1c02:: with SMTP id c2mr66648070ybc.218.1636138188923;
 Fri, 05 Nov 2021 11:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211104192533.2520-1-adam@dinwoodie.org> <xmqq7ddn3dlt.fsf@gitster.g>
 <20211105112525.GA25887@dinwoodie.org> <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
 <xmqqk0hmxyw0.fsf@gitster.g>
In-Reply-To: <xmqqk0hmxyw0.fsf@gitster.g>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Fri, 5 Nov 2021 18:49:14 +0000
Message-ID: <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 5 Nov 2021 at 18:04, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Fri, Nov 05, 2021 at 11:25:25AM +0000, Adam Dinwoodie wrote:
> >
> >> > ... I am not quite sure how this explains "tests relating to ssh
> >> > signing failing on Cygwin".  After all, this piece of code is
> >> > lazy_prereq, which means that ssh-keygen in this block that fails
> >> > (due to a less restrictive permissions) would merely mean that tests
> >> > that are protected with GPGSSH prerequisite will be skipped without
> >> > causing test failures.  After all that is the whole point of
> >> > computing prereq on the fly.
> >>
> >> The issue is that the prerequisite check isn't _just_ checking a
> >> prerequisite: it's also creating an SSH key that's used without further
> >> modification by the tests.
> >
> > This is sort of a side note to your main issue, but I think that relying
> > on a lazy_prereq for side effects is an anti-pattern. We make no
> > promises about when or how often the prereqs might be run, and we try to
> > insulate them from the main tests (by putting them in a subshell and
> > switching their cwd).
> >
> > It does happen to work here because the prereq script writes directly to
> > $GNUPGHOME, and we run the lazy prereqs about when you'd expect. So I
> > don't think it's really in any danger of breaking, but it is definitely
> > not using the feature as it was intended. :)
>
> This merely imitates what GPG lazy-prerequisite started and imitated
> by other existing signature backends.
>
> I'd expect that you need some "initialization" for a feature X as
> part of asking "is feature X usable in this environment?".  Reusing
> the result of the initialization for true tests is probably an
> optimization worth making.  As long as the question is answered for
> the true tests, that is [*].
>
>     side note: so being able to create a key alone, without
>     verifying the resulting key is usable, is a no-no.  That is why
>     I said it is a good idea to check if the resulting key is usable
>     inside the lazy-prereq.

I'm not convinced by this. Or at least, I'm convinced by the
principle, but wary of the implications.

Take this case, for example: the function being tested by the
GPGSSH-gated tests is function that should work on Cygwin. If there
were a regression, running the tests on Cygwin ought to catch it, and
in this instance the tests failing meant that we caught a bug. On this
occasion it was a bug in the test library rather than the function
that most Git users care about, but I don't think there's anything
inherent about this situation that means it couldn't have been a
functional bug.

However, if the prerequisite checks had not only created the key but
also verified it could be used, in this scenario these tests would
have been skipped. The function the tests are exercising would still
work, and users would therefore expect it to continue working, but the
only chance we'd have to spot any future regressions is if they're hit
in some other environment or someone spots the tests being skipped by
trawling through the reams of test output to check what tests are
being skipped.

This is probably a much broader conversation. I remember when I first
started packaging Git for Cygwin, I produced a release that didn't
have support for HTTPS URLs due to a missing dependency in my build
environment. The build and test suite all passed -- it assumed I just
wanted to build a release that didn't have HTTPS support -- so some
relatively critical function was silently skipped. I don't know how to
avoid that sort of issue other than relying on (a) user bug (or at
least missing function) reports and (b) folk building Git for
themselves/others periodically going through the output of the
configure scripts and the skipped subtests to make sure only expected
things get missed; neither of those options seem great to me.
