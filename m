Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F345C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F2C64F64
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhBBPen (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbhBBPcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 10:32:16 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1397AC061788
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 07:31:36 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id k8so20176873otr.8
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 07:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpmvcFzEPzXXe1joUh7SYNE1ID0GYaecWdjg3kw3p30=;
        b=A8ekxDtGx6pWlqMDmD0becTVeuZw69MKS/KnGcNWtqrOkDmXgBg03Rwfu+Zcr0QvcC
         3LSkX6XycperojfNSNyXkf9c7grsV1Dx3VwMm6TPArbRmhW+isJs8nnqKduGdk7JozXO
         tKOpU+kDbGE7XJpivvhgAiEYomKhbiLSFoBKm7kNNCqxjGPk/XqlC+8NHcw/2cB/vJQQ
         o+OBxuUuPMTVntqEQjOW80zLKaKYwo3TwrXkwZFglg0aK4I8YOXAdER5O1o72WlJs9j9
         WaBV4FlI7M3qXDXKv/xT5ZvVe9lS9+pqlfADZCac1H4UvbiFrVC+SsnaYqZCHZklFhcx
         1vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpmvcFzEPzXXe1joUh7SYNE1ID0GYaecWdjg3kw3p30=;
        b=nXJJmmPbHLTsiUk+e7ilJzfZxQIWBmcRfO6CFpHP9m0cWNI0RNy6DZ68Ca1iyc2TCn
         hnCFh67nTzdq1AcDxZRHBvClLleRviRQq8GQQTn7Le9ujJGL3Yrun89eWCdPvZmon+7r
         YNwG34IlWqLwL2w/6QONubdQwclx9CqVU2kEnegFtljy2WYmIOqighmbU4gRT0Sy38XE
         bLzMV0Vv0WpsHVysaXpIpXQy2728Cn3NlyL1GA4erLYuJ+BIVrBO8MNuf1fB0rG5wSWT
         vohPozI+IiREosDvSXjfIVKv8Du1zr76pvX0iUiC4TIAevqXVRm09GzM/cbD9xVOQlEE
         UqYw==
X-Gm-Message-State: AOAM533YxmR2Q0QmvMJDIRGHNvEYGUmRJVh1Anj3FPOzOlMbT/pQfSql
        IN+lUjCHeNxHgesl2B+nkcamD/gSuN+rGVT2nss=
X-Google-Smtp-Source: ABdhPJx4LzFY9n/iyxYru+Os7LExlrducDMCTIszEP6W5LspvNHzaMj+R7mvP1RPjmvUbw/g83BhJ/3lyITuzJVZkMk=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr15550662otk.210.1612279895409;
 Tue, 02 Feb 2021 07:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-8-charvi077@gmail.com> <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
 <CAP8UFD2m18ZemGMkfzFhO1TUrMjNOGuQCqP1KVnRK7JEngeuog@mail.gmail.com>
In-Reply-To: <CAP8UFD2m18ZemGMkfzFhO1TUrMjNOGuQCqP1KVnRK7JEngeuog@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 2 Feb 2021 21:01:24 +0530
Message-ID: <CAPSFM5dWLLa2HVVDyh+_vW-Kv=8wn-MOz7YUOXUr=hqn0jumQQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] t3437: test script for fixup [-C|-c] options in
 interactive rebase
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 2 Feb 2021 at 15:32, Christian Couder
<christian.couder@gmail.com> wrote:
[...]
> > The function comment above this code may also need to be updated to
> > reflect this change.
>
> Yeah, good suggestion.
>

Okay, I will add that .

> > > diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
> > > @@ -0,0 +1,213 @@
> > > +#!/bin/sh
> > > +#
> > > +# Copyright (c) 2018 Phillip Wood
> >
> > Did Phillip write this script? Is this patch based upon an old patch from him?
>
> Yeah, it might be a good idea to add a "Based-on-patch-by: Phillip ..."
>

Oops, I forgot to add the trailer in this patch and will add it.

> > > +test_commit_message () {
> > > +       rev="$1" && # commit or tag we want to test
> > > +       file="$2" && # test against the content of a file
> > > +       git show --no-patch --pretty=format:%B "$rev" >actual-message &&
> > > +       if test "$2" = -m
> > > +       then
> > > +               str="$3" && # test against a string
> > > +               printf "%s\n" "$str" >tmp-expected-message &&
> > > +               file="tmp-expected-message"
> > > +       fi
> > > +       test_cmp "$file" actual-message
> > > +}
> >
> > By embedding comments in the function itself explaining $1, $2, and
> > $3, anyone who adds tests to this script in the future is forced to
> > read the function implementation to understand how to call it. Adding
> > function documentation can remove that burden. For instance:
> >
> >     # test_commit_message <rev> -m <msg>
> >     # test_commit_message <rev> <path>
> >     #    Verify that the commit message of <rev> matches
> >     #    <msg> or the content of <path>.
> >     test_commit_message ()  {
> >         ...
> >     }
>
> Good suggestion.
>

Agree, I will add the comments.

> > The implementation of test_commit_message() is a bit hard to follow.
> > It might be simpler to write it more concisely and directly like this:
> >
> >     git show --no-patch --pretty=format:%B "$1" >actual &&
> >     case "$2" in
> >     -m) echo "$3" >expect && test_cmp expect actual ;;
>
> I think we try to avoid many commands on the same line.
>
> >     *) test_cmp "$2" actual ;;
> >     esac
>
> In general I am not sure that using $1, $2, $3 directly makes things
> easier to understand, but yeah, with the function documentation that
> you suggest, it might be better to write the function using them
> directly.
>

Okay, I will update it.

[...]
> > > +test_expect_success 'fixup -C removes amend! from message' '
> > > +       test_when_finished "test_might_fail git rebase --abort" &&
> > > +       git checkout --detach A1 &&
> > > +       FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
> > > +       test_cmp_rev HEAD^ A &&
> > > +       test_cmp_rev HEAD^{tree} A1^{tree} &&
> > > +       test_commit_message HEAD expected-message &&
> > > +       get_author HEAD >actual-author &&
> > > +       test_cmp expected-author actual-author
> > > +'
> >
> > This test seems out of place. I would expect to see it added in the
> > patch which adds "amend!" functionality.
> >
> > Alternatively, if the intention really is to support "amend!" this
> > early in the series in [6/9], then the commit message of [6/9] should
> > talk about it.
>
> Yeah, I think it might be better to just remove everything related to
> "amend!" in this series and put it into the next one.
>

Agree. Eric pointed at other patches also for amend! commit.
So I also admit that to avoid confusion, I will remove all these amend! part and
will add to other patch series.

> [...]
>
> > > +       git checkout --detach A1 &&
> > > +       test_must_fail env FAKE_LINES="1 fixup_-C 2" git rebase -i conflicts &&
> > > +       git checkout --theirs -- A &&
> > > +       git add A &&
> > > +       FAKE_COMMIT_AMEND=edited git rebase --continue &&
> > > +       test_cmp_rev HEAD^ conflicts &&
> > > +       test_cmp_rev HEAD^{tree} A1^{tree} &&
> > > +       test_write_lines "" edited >>expected-message &&
> >
> > It feels clunky and fragile for this test to be changing
> > "expected-message" which was created in the "setup" test and used
> > unaltered up to this point. If the content of "expected-message" is
> > really going to change from test to test (as I see it changes again in
> > a later test), then it would be easier to reason about the behavior if
> > each test gives "expected-message" the precise content it should have
> > in that local context. As it is currently implemented, it's too
> > difficult to follow along and remember the value of "expected-message"
> > from test to test. It also makes it difficult to extend tests or add
> > new tests in between existing tests without negatively impacting other
> > tests. If each test sets up "expected-message" to the precise content
> > needed by the test, then both those problems go away.
>

I agree with it ...

> Yeah, perhaps the global "expected-message" could be renamed for
> example "global-expected-message", and tests which need a specific one
> could prepare and use a custom "expected-message" (maybe named
> "custom-expected-message") without ever changing
> "global-expected-message".
>

... Okay, I will change it.

Thanks Eric and Christian for the suggestions and reviews. I will
include all the changes
in the next revision.

Thanks and Regards,
Charvi
