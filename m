Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E18EC433FE
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 04:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKYE6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 23:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKYE6q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 23:58:46 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C62F192BA
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 20:58:45 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id v28so3139777pfi.12
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 20:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn0vGTl1+7uUfjaSBLFJj8Azf3yZRwhq4187EyWLs7Y=;
        b=J+4QujZwXuD2hdc28O/27UM3nhCuWbqOWJMfbc87EcCKOQNd7i7RIObq9wQYXCm8AB
         2U8naq99EckxI8oRM818dryiH4qp37Haw3Jo+pgbDBDZ88+BMg4giEwhwMoCi9TQe7cE
         PuQazHGB0+JNRkePyIefKu/76EMSQ6JTCwtu5b4GecG5XIts4QOahpXwaOWf3FgbhNxX
         0x5cCbqYo7UiM+F9vYDuSTryWrvZ3dNu4Yop6UgAEFM2NC3jH8i/iJ6JA4I0YrJ++r+E
         rjSvLAI0uC3OtDhKI6YuKfS90MzWdKO3CYxPixKWlMfo24OQxSNA4hoByNGZ22WsTxA7
         utnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mn0vGTl1+7uUfjaSBLFJj8Azf3yZRwhq4187EyWLs7Y=;
        b=MunHClthtRTl9n22MbFI93YvJPSeolIK3Cg5HR4pqA4ykMwEsMJXy620scHM32OiyF
         Y940vEasEtvlnxDA6o5S/A4e2fsqPqWmT1HdbSkjZvKjiwtLtER+IoUFWy304pb4h1uA
         idY2B7aDcd47Seev/vYjIf475hOEFRqaHKYueozMW4jxb+0zkqHLYR8PtHsqpG94w1HX
         wdH34QxPQr9sPRJdH7+OLTiSt4Y+WfIJs4m6v13bnP6K2pI12atPVEg3WzEBfFXTpDnT
         ZTd2TYzWOcek2lhCZIzaNuvXuBl/smpGUHXSIBH0daDhkfOg/finsUtjW24JV8S8mcDD
         FdPA==
X-Gm-Message-State: ANoB5pn9+6CizMzfh/oVCTM1hCpzIykXhdIhhlILB7cADzvu4AveOP68
        lIqQ47u9ravGMP/J2GTUyRg=
X-Google-Smtp-Source: AA0mqf7+TWgVD3mgUnDezxMEdTJumDV2vpiMWFhn2o2yG34/fy4+UqFzb9nHjdWwojDsJ0lJePUWYw==
X-Received: by 2002:a65:4c88:0:b0:477:55c:3ff4 with SMTP id m8-20020a654c88000000b00477055c3ff4mr32446581pgt.442.1669352324576;
        Thu, 24 Nov 2022 20:58:44 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b0017f57787a4asm2217017plh.229.2022.11.24.20.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 20:58:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Subject: Re: [PATCH v8] status: modernize git-status "slow untracked files"
 advice
References: <pull.1384.v7.git.1669136378754.gitgitgadget@gmail.com>
        <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 13:58:43 +0900
Message-ID: <xmqq5yf3fx4s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Rudy Rigot <rudy.rigot@gmail.com>
>
> `git status` can be slow when there are a large number of
> untracked files and directories since Git must search the entire
> worktree to enumerate them.  When it is too slow, Git prints
> advice with the elapsed search time and a suggestion to disable
> the search using the `-uno` option.  This suggestion also carries
> a warning that might scare off some users.
>
> However, these days, `-uno` isn't the only option.  Git can reduce
> the size and time of the untracked file search when the

"time" I can sort of understand ("can reduce the time taken to
enumerate untracked files" is how I may phrase it, though), but
what did you want to say with "size"?

> `core.untrackedCache` and `core.fsmonitor` features are enabled by
> caching results from previous `git status` invocations.
>
> Therefore, update the `git status` man page to explain the various
> configuration options, and update the advice to provide more ...

Lose "Therefore, "; the resulting text would be much easier to
follow.

> +UNTRACKED FILES AND STATUS SPEED

"STATUS SPEED" somehow does not sound quite grammatical.  Perhaps
"untracked files and performance" or something instead?

> +--------------------------------
> +
> +`git status` can be very slow in large worktrees if/when it
> +needs to search for untracked files and directories. There are
> +many configuration options available to speed this up by either
> +avoiding the work or making use of cached results from previous
> +Git commands. There is no single optimum set of settings right
> +for everyone.  Here is a brief summary of the relevant options
> +to help you choose which is right for you.

Good.

> +* First, you may want to run `git status` again. Your current
> +	configuration may already be caching `git status` results,
> +	so it could be faster on subsequent runs.

The above may be a good advice, but it is misleading to make it as
if it is another alternative of equal footing with everything else
listed.  It may likely make the resulting text much easier to follow
if you fold it into "Here is a summary", perhaps like...

    ... right for everyone.  We'll list a summary of the relevant
    options to help you, but before going into the list, you may
    want to run `git status` again, because your configuration may
    already be ...


> +* The `--untracked-files=no` flag or the
> +	`status.showUntrackedfiles=false` config (see above for both) :

Lose the SP before the ":" (applies to all other entries, too).

> +	indicate that `git status` should not report untracked
> +	files. This is the fastest option. `git status` will not list
> +	the untracked files, so you need to be careful to remember if
> +	you create any new files and manually `git add` them.

OK.

> +* `advice.statusUoption=false` (see linkgit:git-config[1]) :
> +	this config option disables a warning message when the search
> +	for untracked files takes longer than desired. In some large
> +	repositories, this message may appear frequently and not be a
> +	helpful signal.

This is not technically wrong per-se, except that "desired" in
"takes longer than desired" may simply be wrong.

The reason why the message may not be a "helpful signal" is in such
a repository and project the user may have already accepted the
current trade-off as _desirable_, iow, the user is WILLING to wait
for 2 seconds.  And in such a case, it indeed is the most sensible
option to disable the advice.

We should also stress the fact that this has nothing to do with
speeding up, unlike other pieces of advice you are giving here.
It's not like disabling the advice will allow us to omit something
we need to do to compute the advice (in other words, if the overhead
to measure the time taken to list untracked files is large, this may
matter, but that is hardly the case).

Perhaps

    Setting this variable to `false` disables the warning message
    given when enumerating untracked files takes more than 2
    seconds.  In a large project, it may take longer and the user
    may have already accepted the trade off (e.g. using "-uno" may
    not be an acceptable option for the user), in which case, there
    is no point issuing the warning message, and in such a case,
    disabling the warning may be the best.

or something like that.

> +test_expect_success 'setup slow status advice' '
> +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main git init slowstatus &&
> +	(
> +		cd slowstatus &&
> +		cat >.gitignore <<-\EOF &&
> +		/actual
> +		/expected
> +		/out
> +		EOF
> +		git add .gitignore &&
> +		git commit -m "Add .gitignore" &&
> +		git config advice.statusuoption true
> +	)
> +'
> +
> +test_expect_success 'slow status advice when core.untrackedCache and fsmonitor are unset' '
> +	(
> +		cd slowstatus &&
> +		git config core.untrackedCache false &&
> +		git config core.fsmonitor false &&
> +		GIT_TEST_UF_DELAY_WARNING=1 git status >out &&
> +		sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&

What if it takes more than 10 seconds, e.g.

	"It took 92.34 seconds to enumerate..."

Wouldn't it be redacted into "It took 9X seconds to enumerate"?

It probably does not happen, only because you are forcing the code
to pretend that it took 2.001 seconds or something, I suspect.  But
if you are forcing with GIT_TEST_UF_DELAY_WARNING to pretend that it
took some unacceptably long time, it may be more robust to

 * pass "struct wt_status *s" to uf_was_slow(), instead of passing
   s->untracked_in_ms

 * when GIT_TEST_UF_DETAIL_WARNING tells us we are pretending a long
   delay for the purpose of running tests, ASSIGN a known value to
   s->untracked_in_ms

 * get rid of "out" and use of "sed" in these test, and instead
   check for exact output.

e.g.

	static int uf_was_slow(struct wt_status *s)
	{
		if (getenv("GIT_TEST_UF_DETAIL_WARNING"))
			s->untracked_in_ms = 3.25;
		return UF_DELAY_WARNING_IN_MS < s->untracked_in_ms;
	}

plus

	GIT_TEST_UF_DETAIL_WARNING=1 git status >actual &&
	cat >expect <<-\EOF &&
	...
	It took 3.25 seconds to enumerate ...
	EOF
	test_cmp expect actual

Also, what do you need /g modifier in "sed" script for?  I do not
think we give more than one such number in the message we are
testing.

> +		cat >expected <<-\EOF &&
> +		On branch main
> +
> +		It took X seconds to enumerate untracked files.
> +		See '"'"'git help status'"'"' for information on how to improve this.

This is not wrong per-se, but it is more customary to do say:

		See '\''git help status'\'' for information on ...

All of the comments for this test apply to other two new tests.

> +		nothing to commit, working tree clean
> +		EOF
> +		test_cmp expected actual
> +	)
> +'

Additionally (read: you do not _have_ to do this to make this topic
acceptable, but it probably is worth thinking about), if we need to
introduce a new helper function uf_was_slow() anyway, a much better
change may be to make the 2 seconds cut-off configurable, than
inventing GIT_TEST_UF_DETAIL_WARNING used only for tests.  You can
introduce, say, "status.enumerateUntrackedDelayMS", a configuration
variable that can be set to override the hardcoded 2000 milliseconds
(i.e. UF_DELAY_WARNING_IN_MS) to control what delay is acceptable
for the repository.

Then you can run the tests with the configuration set to a negative
value (i.e. no time is acceptably short, even 0 milliseconds).  If
you go that route, then you do need to redirect to "out" and redact
with "sed" (make sure you are prepared to see a delay more than 10
seconds in such a case).

Thanks.
