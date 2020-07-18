Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F1C433DF
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 06:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A011D20724
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 06:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgGRGzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:55:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34938 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRGzv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 02:55:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so20527760wmf.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 23:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DHF6cUiJ8U2f3lzgpjihpyjoeSWPCPmKynm/aQ/awHI=;
        b=B6BrnsOlYMHFBxdhxo9WaDW+3GkJvxC82dLjUBky+Gn3TULPadwt7gJ9DSAp9katAT
         VTgodJ/3vmL1NHjvREBZ4lsrbkV9wsj3XP3KtYkeRhBHC5ckzKRoFdMt7o5/CsBodv7q
         8iDWSyeyBiWjn3szgPVLBeXKpYndEvZ1+RhQDQrHXCOqe26JpTHXBTEUBJHkfuKxAIgm
         vGaAjuTZy+xvg7c5a4xTJSrj7TBfTYJg1jBwbpP0HDR610gKrMXU7ZLTDb/pGnCK5lQ8
         Ge6vZHXoAduZyQ04ly8N6bRat/5HcBzjn2gd3gmS3H6pAwB9rr4PfxZ8lBINxu5/Tzvu
         JU7A==
X-Gm-Message-State: AOAM531h/6QWaKtpWQ6os4Fo2+QmUPZfY+WVT7CN3GsvcuqT8IcVjeCb
        txa3lsy/2QnTcwBPuvpND8mt2/P55ax4nKHwCJY=
X-Google-Smtp-Source: ABdhPJzEHLh/8PQyRGQqtuMqq6o187alGhtosNB54T7WX0ss/znCc+IZcQuOY9HyVPcCl69+nJnsXG7nceuC7sqGuAw=
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr12312348wmb.53.1595055348382;
 Fri, 17 Jul 2020 23:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
 <CAPig+cQaqg7MbyNZakuWVzezhPCXu=LonCVAw_p13c=0YNBdPw@mail.gmail.com> <CAPx1GvduDZw5pmfZHACDGZsMR5YYDowLw6+az+oL6oWLvDyCFA@mail.gmail.com>
In-Reply-To: <CAPx1GvduDZw5pmfZHACDGZsMR5YYDowLw6+az+oL6oWLvDyCFA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 18 Jul 2020 02:55:37 -0400
Message-ID: <CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com>
Subject: Re: [PATCH] git-mv: improve error message for conflicted file
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Chris Torek via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 17, 2020 at 9:35 PM Chris Torek <chris.torek@gmail.com> wrote:
> On Fri, Jul 17, 2020 at 4:47 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > ... use literal TABs and let the here-doc provide the newlines.
>
> I personally hate depending on literal tabs, as they're really
> hard to see. If q_to_tab() is OK I'll use that.

q_to_tab() is a good choice.

> > I realize that this test script is already filled with this sort of
> > thing where actions are performed outside of tests, however, these
> > days we frown upon that, and there really isn't a good reason to avoid
> > taking care of this clean up via the modern idiom of using
> > test_when_finished(), which you would call immediately after creating
> > the file in the test. So:
>
> Indeed, that's where I copied it from.
>
> Should I clean up other instances of separated-out `rm -f`s
> in this file in a separate commit?

In general, as a reviewer, I don't mind seeing a patch or two cleaning
up style and other violations, however, the magnitude of the fixes
this script needs is quite significant and would end up requiring a
fair number of patches. As such, I'm not particularly eager to see the
improvement made by this patch -- which is nicely standalone --
weighed down by a lengthy series of patches which aren't really
related to it.

If cleaning up the t7001 test script is something you might be
interested in doing, then making it a separate patch series would be
more palatable. A scan of the script reveals the following problems,
though there may be others:

* old style:

    test_expect_success \
        'title' \
        'body line 1 &&
        body line 2'

  should become:

    test_expect_success 'title' '
        body line 1 &&
        body line 2
    '

* test bodies should be indented with TAB, not spaces

* some tests use a deprecated style in which there are unnecessary
  blank lines after the opening quote of the test body and before the
  closing quote; these blanks lines should be removed

* style for `cd` in subshell is:

    (
        cd foo &&
        ...
    ) &&

  not:

    (cd foo &&
        ...
    ) &&

* there should be no whitespace after redirect operators, so:

    foo > actual &&

  should become:

    foo >actual &&

* tests 'cd' around and expect other tests to know the current
  directory and 'cd' relative to that; instead, any test which uses
  'cd' should do so in a subshell to ensure the current directory is
  restored by the time the test ends:

    test_expect_success 'title' '
        something &&
        (
            cd somewhere &&
            something-else
        )
    '

  Alternately, it may be possible to take advantage of `-C` if
  `something-else` is a `git` command:

    test_expect_success 'title' '
        something &&
        git -C somewhere foo
    '

* use `>` rather than `touch` to create an empty file when the
  timestamp isn't relevant to the test

* cleanup code outside of tests should be moved into the test and
  scheduled for execution via test_when_finished()

* there are several standalone "clean up" tests which invoke `git
  reset --hard` which should be folded into the tests for which they
  are cleaning up

* multiple commands on one line:

    mkdir foo && >foo/bar && git add foo/bar &&

  should be split across multiple lines:

    mkdir foo &&
    >foo/bar &&
    git add foo/bar &&

* at least one test incorrectly uses single quotes within the body of
  the test which itself is contained within single quotes; when
  quoting is needed inside a test body, it should be using double
  quotes instead; however, in this case, the quotes aren't even
  needed, so:

    git commit -m 'initial' &&

  can just become:

    git commit -m initial &&

* take advantage of here-docs, so:

    { echo other/a.txt; echo other/b.txt; } >expect &&

  can be expressed more cleanly as:

    cat >expect <<-\EOF &&
    other/a.txt
    other/b.txt
    EOF

* use `test` rather than `[`

* optional: rename the setup test 'prepare reference tree' to 'setup'

* optional modernization: use test_path_exists() and cousins instead
  of `test -f`, etc.

* optional: avoid `git` command upstream of a pipe since the pipe will
  swallow its exit code, thus a crash won't necessarily be noticed

* optional: it's unusual for tests to blast the test's ".git"
  directory and recreate it with `git init`, however, a number of
  tests in this script do so; for tests which really require a new
  repository, the more common approach is to use test_create_repo() to
  create a new repository into which the test can `cd` (in a subshell)
  without disturbing the repository used by the other tests in the
  script

A few of the above fixes can probably be combined into a single patch,
in particular, the style fixes in the first four bullet points. Each
remaining bullet point, however, probably deserves its own patch
(including the one about removing whitespace after a redirect
operator).
