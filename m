Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40068C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 05:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKJFm7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Nov 2022 00:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiKJFm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 00:42:56 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D32DDF28
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 21:42:55 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id o13so535015ilq.6
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 21:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1tK5QRyj/AY6LKvviSy7cUjNzPS+aOYTdYJ2jTPdY8=;
        b=bTuceps1bkQckAdCP9RCT3+SVxEkFqkig5Q0Gwo8+CQ6I7IdrYprsfiqiGq6onlQvd
         dMkiS87mZuG+1QLnaeAtPE+sk1WTk+Mhowwpgac+UhLq8/mxsLxy/YuqZpbCgzyZWtyD
         40nbgYLk5VbB7pXpcp7jryFiL1qBVphLjIrz9xJsNlWw63TxJ/U2EWA0t4Qu5MxP3ae1
         KD23koud17Y0BH41I9v6scmpYFiJP/YwHMw2vsXLKWbfOu+h7mO4npIekMN4ylUTxnBx
         bgt9JQrtCHyFyEGbzWKV4N29JC3eb4clj8rOAsfwTVCc08qzOEx4odke1ZwuR8/oJeo2
         dyxQ==
X-Gm-Message-State: ACrzQf0RPIuas4v0mhxLxxeNYlHTHx2dAUlXHf7oJC5fM6TLyv7Y9OcR
        riFpCQUsLF09qFB/xQ/tj8D13uE1n57tCmvYe/y/60M5U/U=
X-Google-Smtp-Source: AMsMyM6JqnSrEoxMUXciIK2t4wLWlejOZ0ZhteU8Dj0ni7oE8EqsOf0e9tkvdstOGLxSumbfQii/0rS3Gv6qUnShsjk=
X-Received: by 2002:a92:d2c2:0:b0:2f9:4023:d5e9 with SMTP id
 w2-20020a92d2c2000000b002f94023d5e9mr2572572ilg.249.1668058974457; Wed, 09
 Nov 2022 21:42:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com> <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Nov 2022 00:42:43 -0500
Message-ID: <CAPig+cTGG-y6myEYOVeF8W9QBdCjhqeghsepi-2R9V-v7=YwZA@mail.gmail.com>
Subject: Re: [PATCH v4] status: long status advice adapted to recent capabilities
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2022 at 11:46 PM Rudy Rigot via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Improve the advice displayed when `git status` is slow because
> of excessive numbers of untracked files.  Update the `git status`
> man page to explain the various configuration options.
>
> `git status` can be slow when there are a large number of untracked
> files and directories, because Git must search the entire worktree
> to enumerate them.  Previously, Git would print an advice message
> with the elapsed search time and a suggestion to disable the search
> using the `-uno` option.  This suggestion also carried a warning
> that might scare off some users.
>
> Git can reduce the size and time of the untracked file search when
> the `core.untrackedCache` and `core.fsmonitor` features are enabled
> by caching results from previous `git status` invocations.
>
> Update the advice to explain the various combinations of additional
> configuration options and refer to (new) documentation in the man
> page that explains it in more detail than what can be printed in an
> advice message.
>
> Finally, add new tests to verify the new functionality.
>
> Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
> ---
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> @@ -457,6 +457,61 @@ during the write may conflict with other simultaneous processes, causing
> +UNTRACKED FILES AND STATUS SPEED
> +--------------------------------
> +
> +`git status` can be very slow in large worktrees if/when it
> +needs to search for untracked files and directories.  There are
> +many configuration options available to speed this up by either
> +avoiding the work or making use of cached results from previous
> +Git commands.  Since we all work in different ways, there is no
> +single optimum set of settings right for everyone.  Here is a

Not necessarily worth a reroll, but the "since we all work..."
fragment could be dropped without any loss of clarity:

    There is no single optimum configuration suitable
    to every situation.

would probably be sufficient.

> +brief summary of the relevant options to help you choose which
> +is right for you.  Each of these settings is independently
> +documented elsewhere in more detail, so please refer to them
> +for complete details.

This leaves the reader hanging somewhat by not saying where
"elsewhere" actually is. You can use gitlink: to insert links to the
appropriate documentation.

> +* The `-uno` flag or the `status.showUntrackedfiles=false`
> +    config : indicate that `git status` should not report untracked
> +       files. This is the fastest option. `git status` will not list
> +       the untracked files, so you need to be careful to remember if
> +       you create any new files and manually `git add` them.

This and all the other bullet points use an odd mix of spaces and TAB
for indentation. They should consistently use one or the other.

Earlier in this thread, Ævar suggested that it might be worthwhile to
mention an additional possibility: that simply rerunning `git status`
might be sufficient to achieve reasonable speed since the second run
of `git status` may benefit from the filesystem cache having been
primed by the first invocation of `git status`. As such, it may be
overkill for a user to dive into the various options described here.
Hence, to mitigate the possibility of a user doing a lot of research
and extra unnecessary configuration, it might make sense for the very
first bullet point (before this one) to say merely:

    * Do nothing. Subsequent invocations of `git status` may be faster
      simply because the first `git status` primed the filesystem cache.

or something like that (probably more formal, though).

> diff --git a/t/t7065-wtstatus-slow.sh b/t/t7065-wtstatus-slow.sh
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +
> +test_description='test status when slow untracked files'
> +
> +. ./test-lib.sh
> +
> +DATA="$TEST_DIRECTORY/t7065"

This variable is unused, isn't it, now that you're inlining everything
with here-docs?

> +GIT_TEST_UF_DELAY_WARNING=1
> +export GIT_TEST_UF_DELAY_WARNING
> +
> +test_expect_success setup '
> +       git checkout -b test
> +'
> +
> +test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
> +       test_must_fail git config --get core.untrackedCache &&
> +       test_must_fail git config --get core.fsmonitor &&

Rather than asserting that some preceding code has left the
configuration in a state this test wants, it would be more robust for
this test to forcibly set up the state it wants. Something like this
should work:

    test_might_fail git config ---unset-all core.untrackedCache &&
    test_might_fail git config ---unset-all core.fsmonitor &&

> +       git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&

At all costs, avoid escaping the "trash" directory in which this test
is running. All files created by this test should be within the
"trash" directory hierarchy. Therefore, drop "../" from all the
filenames, and instead create these files directly in the "trash"
directory or in some subdirectory of the "trash" directory.

I presume the reason you're escaping the "trash" directory is because
you don't want these untracked "actual" and "expected" files to
pollute the `git status` output you're testing? If so, then you should
probably instead set up a .gitignore file in the "trash" directory to
make `git status` ignore them.

We usually want to avoid having a Git command upstream of a pipe since
the exit code of the Git command will be lost. So, we'd typically do
this instead:

    git status >out &&
    sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&

> +       cat >../expected <<-EOF &&
> +On branch test
> +
> +No commits yet
> +
> +
> +It took X seconds to enumerate untracked files.
> +See '"'"'git help status'"'"' for information on how to improve this.
> +
> +nothing to commit (create/copy files and use "git add" to track)
> +       EOF

Two comments. First, use <<-\EOF rather than <<-EOF to make it clear
to readers that you're not interpolating any variables in the here-doc
body. Second, the <<- operator allows you to indent the here-doc body
(with TABs, not spaces), so you can align the body with the rest of
the code:

    cat >expected <<-\EOF &&
    On branch test
    ...
    EOF

> +       test_cmp ../expected ../actual &&
> +       rm -fr ../actual ../expected
> +'

We usually don't bother cleaning up these files if they don't impact
subsequent tests negatively. However, note that if any code above the
`rm -fr` command fails, then the `rm -fr` command itself won't be run,
hence the files won't get cleaned up upon test failure. To ensure
cleanup (if that's what you desire), use test_when_finished() _before_
code which may fail. So, something like this is typical:

    test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
        test_when_finished "rm -fr actual expected" &&
        test_might_fail git config ---unset-all core.untrackedCache &&
        test_might_fail git config ---unset-all core.fsmonitor &&
        ...
    '

Same comments apply to the other new tests added by this patch.

> diff --git a/wt-status.c b/wt-status.c
> @@ -1205,6 +1207,17 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
> +static inline int uf_was_slow(uint32_t untracked_in_ms)
> +{

Does this need to be inline? Is this a hot piece of code, or is this
merely a premature optimization?

> +       const char *x;
> +       x = getenv("GIT_TEST_UF_DELAY_WARNING");
> +       if (x) {
> +               untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
> +       }

Style is to avoid { } braces for these one-liner bodies.

I think we don't even need the variable "x" in this case, so:

    if (getenv("GIT_TEST_UF_DELAY_WARNING"))
        untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;

would be cleaner.

> +       return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
> +}
