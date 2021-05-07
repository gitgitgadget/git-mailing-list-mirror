Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C67C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68A1613DD
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhEGFdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 01:33:09 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45647 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGFdI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 01:33:08 -0400
Received: by mail-ed1-f44.google.com with SMTP id s7so4038070edq.12
        for <git@vger.kernel.org>; Thu, 06 May 2021 22:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zcp1peng5iqlqb+BUWF2ylBnOWhXumipRNhAejU5rcw=;
        b=dSD8Y9Ii1ki5MeLgBbl8L3p8Q0sgrUili3Rf1xAb7kHAZEaDB1caqEbJ7f5euzpzM5
         5fqWIkQMP6+TEBqo2mq59a04XQEGdyOolC/8Sq2tgEQC2SBXm11jYoxiAcnqx/ptyc41
         mwDgbapEFNjDamdnhct5VU4ALmboL2RqVwZP9lzWa/z8vkwfzGyFND2ihgp3ZeRxAPwd
         FriWN+Bm5/mrSN0xA4uYIiT8rpdatHEbgJw6BfWCTdgK9QUlrGU/U+HJux9AOpcRDULt
         7sRXPb5SGAvoIs1e7n2LQMDfXyZLLu8gIlIboPocnbJcoDeTYGrrfRo20M+uVudtBxRZ
         Wqww==
X-Gm-Message-State: AOAM533L8MDGrMDr7ZIlJlh0RzKrrlZjR4pAFhZRiD9IssI5mWsPBQ9Q
        eJ2HyR7vaBix7x/MBmNy5yap9OIHwEDa0m8DSqU=
X-Google-Smtp-Source: ABdhPJxaJamgcKLmycS2McGSrCKXRoyWvjfiwr3k0avgt/bfnAcHHmJ3uVXrQyWPxS8mid2dv3BAvR2MP0R1pnIcVKs=
X-Received: by 2002:a05:6402:51c9:: with SMTP id r9mr5410550edd.94.1620365528681;
 Thu, 06 May 2021 22:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com> <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com>
In-Reply-To: <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 May 2021 01:31:57 -0400
Message-ID: <CAPig+cR3Z1dy8ibLEr+64C57dgrivPbgTveirnmSt-5D1wo59Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 7, 2021 at 1:01 AM Elijah Newren <newren@gmail.com> wrote:
> On Thu, May 6, 2021 at 9:27 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Is this expensive/slow loop needed because you'd otherwise run afoul
> > of command-line length limits on some platforms if you tried creating
> > the entire mess of directories with a single `mkdir -p`?
>
> The whole point is creating a path long enough that it runs afoul of
> limits, yes.
>
> If we had an alternative way to check whether dir.c actually recursed
> into a directory, then I could dispense with this and just have a
> single directory (and it could be named a single character long for
> that matter too), but I don't know of a good way to do that.  (Some
> possiibilities I considered along that route are mentioned at
> https://lore.kernel.org/git/CABPp-BF3e+MWQAGb6ER7d5jqjcV=kYqQ2stM_oDyaqvonPPPSw@mail.gmail.com/)

Thanks, I read that exchange (of course) immediately after sending the
above question.

> > > +               while test ! -f directory-random-file.txt; do
> > > +                       name=$(ls -d directory*) &&
> > > +                       mv $name/* . &&
> > > +                       rmdir $name
> > > +               done
> >
> > Shouldn't this cleanup loop be under the control of
> > test_when_finished() to ensure it is invoked regardless of how the
> > test exits?
>
> I thought about that, but if the test fails, it seems nicer to leave
> everything behind so it can be inspected.  It's similar to test_done,
> which will only delete the $TRASH_DIRECTORY if all the tests passed.
> So no, I don't think this should be under the control of
> test_when_finished.

I may be confused, but I'm not following this reasoning. If you're
using `-i` to debug a failure within the test, then the
test_when_finished() cleanup actions won't be triggered anyhow
(they're suppressed by `-i`), so everything will be left behind as
desired.

The problem with not placing this under control of
test_when_finished() is that, if something in the test proper does
break, after the "test failed" message, you'll get the undesirable
alpine-linux-musl behavior you explained in your earlier email where
test_done() bombs out.
