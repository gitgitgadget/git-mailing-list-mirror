Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D33C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 10:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594EC64E4F
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 10:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBBKDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBBKC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 05:02:58 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A68C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 02:02:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z22so22177615edb.9
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 02:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqHf5v2pwAijAUDQzxL1c10ueAKJtKnSYZhMGBIFHGE=;
        b=OmngZK0Cvqm9Qiw91ElWl7g9GjsPU2FCIw/Duie4op8lRIGSdxthK/SamGUa083dk+
         yEKQk9f87vxNmbEJ71ILKtA6EX+KTIA5ocbn39QNeySP4X1NJ9mTWeNA0JjWgvA+iUnM
         O9xdFG+fARxqj6AipEdDR5eJT2dj5qVm4IO/6j3pTrz584U7sA72hvkwBgCQRCuipXo9
         Cr0IGtnijztzQUeoHpi58ZM3LLb+Pf0FCXkpfvycC85+wl24sqyyFnDSu5fpBX0Ea3K3
         x9c9b19jLIWC+TO5Jfp8GUCRNfdTVIOElSd1NOAa42DHaSCSqifPhLz/FGkAuRFSQRrT
         FsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqHf5v2pwAijAUDQzxL1c10ueAKJtKnSYZhMGBIFHGE=;
        b=D/i1M784b0XSj4C7LJM0RSQSqbl39bbeL91ICQykMkCbadJ1YZ+FlF31C3Y+HDUNoR
         hxtMjPp1cl1M1UylidUPCCbTyOLxRwUCtS8mTst0OZjsGC9YBEFYqDMqwZ3wlEYvsA5r
         8TcWJb6YjrnZkxrhEqCLEnZcMiCMuH7uYN30rAifp2/0LMTqWjjsH3Exruh9l2wbdzwg
         6ezajai4ki8N99GzK2MDxDZgfYGHcEs8tGtVSx2OGuU+4cUZsE3rberLxIFYQoqBnqcR
         AhNSxe8nVeLe4gVItCPceQw3aKqZSlAbLEFc7vUr/KZROrevsViexKKZu+4tYtX5wWb2
         VULQ==
X-Gm-Message-State: AOAM530vY+9MOwSpcRD9f/ukXcP5SJk18WDM0U3nwdG65/R7lgiveywQ
        wgWgLwoggC7cBCUjvOWJlUrsfNqaqI6FqPPksS887Wmtaf/y+w==
X-Google-Smtp-Source: ABdhPJwvp0/nxqY9hIWKwGiOovESn3bndhVb5FNy0Z2PG+GA1wOEG/wQ2H19iPPOaIXLRDqnvHGOPvVw65yCs7AIrZI=
X-Received: by 2002:aa7:c58e:: with SMTP id g14mr14519761edq.362.1612260135730;
 Tue, 02 Feb 2021 02:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-8-charvi077@gmail.com> <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
In-Reply-To: <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 2 Feb 2021 11:02:04 +0100
Message-ID: <CAP8UFD2m18ZemGMkfzFhO1TUrMjNOGuQCqP1KVnRK7JEngeuog@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] t3437: test script for fixup [-C|-c] options in
 interactive rebase
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 3:01 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Jan 29, 2021 at 1:25 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> > diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> > @@ -51,6 +53,8 @@ set_fake_editor () {
> >                 exec_*|x_*|break|b)
> >                         echo "$line" | sed 's/_/ /g' >> "$1";;
> > +               merge_*|fixup_*)
> > +                       action=$(echo "$line" | sed 's/_/ /g');;
>
> What is "merge_" doing here? It doesn't seem to be used by this patch.

Yeah, it's not used, but it might be a good thing to add this for
consistency while at it.

> The function comment above this code may also need to be updated to
> reflect this change.

Yeah, good suggestion.

> > diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
> > @@ -0,0 +1,213 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2018 Phillip Wood
>
> Did Phillip write this script? Is this patch based upon an old patch from him?

Yeah, it might be a good idea to add a "Based-on-patch-by: Phillip ..."

> > +test_commit_message () {
> > +       rev="$1" && # commit or tag we want to test
> > +       file="$2" && # test against the content of a file
> > +       git show --no-patch --pretty=format:%B "$rev" >actual-message &&
> > +       if test "$2" = -m
> > +       then
> > +               str="$3" && # test against a string
> > +               printf "%s\n" "$str" >tmp-expected-message &&
> > +               file="tmp-expected-message"
> > +       fi
> > +       test_cmp "$file" actual-message
> > +}
>
> By embedding comments in the function itself explaining $1, $2, and
> $3, anyone who adds tests to this script in the future is forced to
> read the function implementation to understand how to call it. Adding
> function documentation can remove that burden. For instance:
>
>     # test_commit_message <rev> -m <msg>
>     # test_commit_message <rev> <path>
>     #    Verify that the commit message of <rev> matches
>     #    <msg> or the content of <path>.
>     test_commit_message ()  {
>         ...
>     }

Good suggestion.

> The implementation of test_commit_message() is a bit hard to follow.
> It might be simpler to write it more concisely and directly like this:
>
>     git show --no-patch --pretty=format:%B "$1" >actual &&
>     case "$2" in
>     -m) echo "$3" >expect && test_cmp expect actual ;;

I think we try to avoid many commands on the same line.

>     *) test_cmp "$2" actual ;;
>     esac

In general I am not sure that using $1, $2, $3 directly makes things
easier to understand, but yeah, with the function documentation that
you suggest, it might be better to write the function using them
directly.

> > +test_expect_success 'setup' '
> > +       cat >message <<-EOF &&
> > +               amend! B
> > +               ${EMPTY}
> > +               new subject
> > +               ${EMPTY}
> > +               new
> > +               body
> > +               EOF
>
> Style nit: In Git test scripts, the here-doc body and EOF are indented
> the same amount as the command which opened the here-doc:

I don't think we are very consistent with this and I didn't find
anything about this in CodingGuidelines.

In t0008 and t0021 for example, the indentation is more like:

     cat >message <<-EOF &&
          amend! B
          ...
          body
     EOF

and I like this style, as it seems clearer than the other styles.

[...]

> > +test_expect_success 'simple fixup -C works' '
> > +       test_when_finished "test_might_fail git rebase --abort" &&
> > +       git checkout --detach A2 &&
> > +       FAKE_LINES="1 fixup_-C 2" git rebase -i B &&
>
> I see that you mirrored the implementation of FAKE_LINES handling of
> "exec" here for "fixup", but the cases are quite different. The
> argument to "exec" is arbitrary and can have any number of spaces
> embedded in it, which conflicts with the meaning of spaces in
> FAKE_LINES, which separate the individual commands in FAKE_LINES.
> Consequently, "_" was chosen as a placeholder in "exec" to mean
> "space".
>
> However, "fixup" is a very different beast. Its arguments are not
> arbitrary at all, so there isn't a good reason to mirror the choice of
> "_" to represent a space, which leads to rather unsightly tokens such
> as "fixup_-C". It would work just as well to use simpler tokens such
> as "fixup-C" and "fixup-c", in which case t/lib-rebase.sh might parse
> them like this (note that I also dropped `g` from the `sed` action):
>
>     fixup-*)
>         action=$(echo "$line" | sed 's/-/ -/');;

I agree that "fixup" arguments are not arbitrary at all, but I think
it makes things simpler to just use one way to encode spaces instead
of many different ways.

> In fact, the recognized set of options following "fixup" is so small,
> that you could even get by with simpler tokens "fixupC" and "fixupc":
>
>     fixupC)
>         action="fixup -C";;
>     fixupc)
>         actions="fixup -c";;
>
> Though it's subjective whether or not "fixupC" and "fixupc" are nicer
> than "fixup-C" and "fixup-c", respectively.

I don't think this would scale nicely when the number of options grows
for both "fixup" and "merge".

> > +test_expect_success 'fixup -C removes amend! from message' '
> > +       test_when_finished "test_might_fail git rebase --abort" &&
> > +       git checkout --detach A1 &&
> > +       FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
> > +       test_cmp_rev HEAD^ A &&
> > +       test_cmp_rev HEAD^{tree} A1^{tree} &&
> > +       test_commit_message HEAD expected-message &&
> > +       get_author HEAD >actual-author &&
> > +       test_cmp expected-author actual-author
> > +'
>
> This test seems out of place. I would expect to see it added in the
> patch which adds "amend!" functionality.
>
> Alternatively, if the intention really is to support "amend!" this
> early in the series in [6/9], then the commit message of [6/9] should
> talk about it.

Yeah, I think it might be better to just remove everything related to
"amend!" in this series and put it into the next one.

[...]

> > +       git checkout --detach A1 &&
> > +       test_must_fail env FAKE_LINES="1 fixup_-C 2" git rebase -i conflicts &&
> > +       git checkout --theirs -- A &&
> > +       git add A &&
> > +       FAKE_COMMIT_AMEND=edited git rebase --continue &&
> > +       test_cmp_rev HEAD^ conflicts &&
> > +       test_cmp_rev HEAD^{tree} A1^{tree} &&
> > +       test_write_lines "" edited >>expected-message &&
>
> It feels clunky and fragile for this test to be changing
> "expected-message" which was created in the "setup" test and used
> unaltered up to this point. If the content of "expected-message" is
> really going to change from test to test (as I see it changes again in
> a later test), then it would be easier to reason about the behavior if
> each test gives "expected-message" the precise content it should have
> in that local context. As it is currently implemented, it's too
> difficult to follow along and remember the value of "expected-message"
> from test to test. It also makes it difficult to extend tests or add
> new tests in between existing tests without negatively impacting other
> tests. If each test sets up "expected-message" to the precise content
> needed by the test, then both those problems go away.

Yeah, perhaps the global "expected-message" could be renamed for
example "global-expected-message", and tests which need a specific one
could prepare and use a custom "expected-message" (maybe named
"custom-expected-message") without ever changing
"global-expected-message".

Thanks for your review!
