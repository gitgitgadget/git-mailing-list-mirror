Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD1C43462
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0664613E8
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhEGF5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 01:57:47 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:37612 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhEGF5p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 01:57:45 -0400
Received: by mail-ej1-f47.google.com with SMTP id w3so11752730ejc.4
        for <git@vger.kernel.org>; Thu, 06 May 2021 22:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gkYLp7KE2KfLpCgXt+Q6Vmm1RGdEVQSQOXHQoCewfk=;
        b=qz7ObhTcMPwNeigiPmgk3SOdjnXmnZimS24X8/HC+15f3UQ26B8/FZ7miY43uPs+eE
         DPCLLvQ0+WbiZNQGuyRW/rWDX8GgJaMr3SwEW7ILGBIGiREkftAClWZbavS6YapOlmgJ
         8zfmAGG92XaJoeX9jdrNQOFHvUEdV+OyQ9YaralpmZxbcfFiUndxgmMdr+P8tgU+d1SW
         XTVp6yF6FNhSGoMU0An1bKxR46SDTfAaTFhQ73mHPT2Zat8g91Zdu1oBa1C7Novw0RiZ
         LEtB+9OfBpsrCixqiisKO25aUj91IijQ0kiIwrX77JOGF1Q9+fw4VcB9NJn447mHsUQK
         H1+Q==
X-Gm-Message-State: AOAM531fe/Ige/HeCEQ/wHbUXXX4jzOPQ0yKCxbkAZ8dDzrAqORuuRKU
        CeU9KAAy9XVE6RO2x5p5dt0cJfMJwUDgveKZAeQ=
X-Google-Smtp-Source: ABdhPJxw59F7dtATPX7dLQlzfpFwrVESCzGue5WaDYbzY2AyyKml7zQIe2RsW7wu8Kj5mcMudfZIlsc+ngJ9m3l3koc=
X-Received: by 2002:a17:906:a18e:: with SMTP id s14mr6735694ejy.311.1620367005507;
 Thu, 06 May 2021 22:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
 <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com>
 <CAPig+cR3Z1dy8ibLEr+64C57dgrivPbgTveirnmSt-5D1wo59Q@mail.gmail.com> <CABPp-BFYpGYvy1wNdZBGObcRuVHMP=MxZtmikugA2hOUEHb-=w@mail.gmail.com>
In-Reply-To: <CABPp-BFYpGYvy1wNdZBGObcRuVHMP=MxZtmikugA2hOUEHb-=w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 May 2021 01:56:34 -0400
Message-ID: <CAPig+cTrjcPjv8jva_ORbuSxm6XBumA1CZNcaDYYqqzTH7JJzw@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 7, 2021 at 1:42 AM Elijah Newren <newren@gmail.com> wrote:
> On Thu, May 6, 2021 at 10:32 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I may be confused, but I'm not following this reasoning. If you're
> > using `-i` to debug a failure within the test, then the
> > test_when_finished() cleanup actions won't be triggered anyhow
> > (they're suppressed by `-i`), so everything will be left behind as
> > desired.
>
> I didn't know that about --immediate.  It's good to know.  However,
> not all debugging is done with -i; someone can also just run the
> testsuite expecting everything to pass, see a failure, and then decide
> to go look around (and then maybe re-run with -i if the initial
> looking around isn't clear).  I do that every once in a while.

That's certainly an approach, and it's made easier when each test
creates its own repo (as the tests you write typically do).

In general. though, the majority of Git test scripts run all their
tests in a single repo (per test script), with the result that state
from a failed test is very frequently clobbered by subsequent tests,
which is why --immediate is so useful (it stops the script as soon as
one test fails, so the test state is preserved as well as it can be).
Due to the "clobbering" problem, I don't think I've ever tried
debugging a failed test without using --immediate.

> > The problem with not placing this under control of
> > test_when_finished() is that, if something in the test proper does
> > break, after the "test failed" message, you'll get the undesirable
> > alpine-linux-musl behavior you explained in your earlier email where
> > test_done() bombs out.
>
> Unless I'm misunderstanding the test_done() code (I'm looking at
> test-lib.sh, lines 1149-1183), test_done() only bombs out when it
> tries to "rm -rf $TRASH_DIRECTORY", and it only runs that command if
> there are 0 test failures (see test-lib.sh, lines 1149-1183).  So, if
> something in the test proper does break, that by itself will prevent
> test_done() from bombing out.

I see what you're saying. Okay.
