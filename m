Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE32C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5E161164
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbhD0Pl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhD0Pl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 11:41:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA19C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 08:41:12 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id i26so4770900oii.3
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g8raHxQvna7dVhCYHKC2mEXR1cs6hnuYaMmpbLlKCZI=;
        b=JbkvOTfa/zGWfRGCKaqKDfBnNk36LOl+YSKWGhuHoP4PPRdv62VZoyZfXt95R41J0R
         nOvTUR89SbvhsDvmoYwny2xsJ5khLDidnnFMSdnyfWYsNG/WOO/fjS6cJ3cX+Q8GHgj3
         +fLpXzCp2FHfcxnjVm86fZ2OETnoOUNZdmchhMB0cFZX8gCvXt5zUhI/tVZRAfgLdPdF
         FRNWdrZsMae4mIPoGebYD/5d4PwXDRru2CA1hRfNXWpaSwqCyvpoDcR1TMXNrTu0B5lD
         JivkV5rSKz8m4oWk92wSl3TCo8S9jwUpMtA4L5H+mpSXd9UtZQq7x5uWvVyjZDMFUIyw
         Wajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g8raHxQvna7dVhCYHKC2mEXR1cs6hnuYaMmpbLlKCZI=;
        b=EMpcsuWRGNbIFJgode1/uL22X/8Z4vgoVxBZc/4FAc50IBX852MdiFAPuaxMdACOvv
         6unjhTPCS5JLyy9lbHWZna3ybPX3kFNNu/ln0OU+q6Z924h2xPcvFDKdogLtarjsgK3j
         g1P7DAhPfOfyxIJ7fp9oqBhLtTt6WfFIrHVsjVu+vCIMlMOO6C5moaHZ9TOyvc9hP3ub
         +Xut2E3PQVRKI0DQapFbX89EQH0Kr+JWtzPo/B3Rcy3koc1aQ74Pg6olyGGf/GQppqZA
         YbAfSEEqmIkdWqLwMEb3Z1JygpN16LUDOdJc+VTuoy5oDXR7hN7D/B+Y4PyrFywtTSGI
         v8dw==
X-Gm-Message-State: AOAM533KcmRa0ppVd9Gj6XTaHTOI1PWqVp81l6zEZV11jYtMiTpl7V5v
        lGmWyCW0HMSoJxTYHBLtRJY=
X-Google-Smtp-Source: ABdhPJyC7Y2yA7DQ8jF39igf8j0gyZzGFqCUF6YWoLNOpW8JBJWPrampK5MRS5TiiU+dmiJYvSGedw==
X-Received: by 2002:aca:57cc:: with SMTP id l195mr11555251oib.83.1619538072109;
        Tue, 27 Apr 2021 08:41:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id 128sm726102oog.37.2021.04.27.08.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 08:41:11 -0700 (PDT)
Subject: Re: [PATCH 21/23] t7527: create test for fsmonitor--daemon
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <8b2280e5c4d2cec1fe39e90bfc93f059a1d0eb05.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b62694df-7dd5-71fa-304d-576c2550e5d2@gmail.com>
Date:   Tue, 27 Apr 2021 11:41:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8b2280e5c4d2cec1fe39e90bfc93f059a1d0eb05.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:41 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>

It might be nice to summarize the testing strategy here. Are these just
the basics? Is this a full list of every conceivable client/server
interaction? Do some platforms need special tests?

> +# Ask the fsmonitor daemon to insert a little delay before responding to
> +# client commands like `git status` and `git fsmonitor--daemon --query` to
> +# allow recent filesystem events to be received by the daemon.  This helps
> +# the CI/PR builds be more stable.
> +#
> +# An arbitrary millisecond value.
> +#
> +GIT_TEST_FSMONITOR_CLIENT_DELAY=1000
> +export GIT_TEST_FSMONITOR_CLIENT_DELAY

As I mentioned before, this seems like it is hiding a bug, especially
because of a full second delay. But even a 1 millisecond delay seems
like it is incorrect to assume this feature works correctly if the
test requires this delay.

If there is a specific interaction that has issues, then it might be
valid to insert this delay in a specific test or two.

> +git version --build-options | grep "feature:" | grep "fsmonitor--daemon" || {
> +	skip_all="The built-in FSMonitor is not supported on this platform"
> +	test_done
> +}

I see some precedent of this pattern, but it might be nice to instead
register a prereq and then test for the prereq here in the test script.

> +kill_repo () {

Perhaps "kill_repo_daemon" might be more specific?

> +	r=$1
> +	git -C $r fsmonitor--daemon --stop >/dev/null 2>/dev/null
> +	rm -rf $1
> +	return 0
> +}
> +
> +start_daemon () {
> +	case "$#" in
> +		1) r="-C $1";;
> +		*) r="";
> +	esac
> +
> +	git $r fsmonitor--daemon --start || return $?
> +	git $r fsmonitor--daemon --is-running || return $?

Perhaps add 'test_when_finished kill_repo "$r"' as a line here so
consumers don't need to do it themselves.

> +	return 0
> +}
> +
> +test_expect_success 'explicit daemon start and stop' '
> +	test_when_finished "kill_repo test_explicit" &&
> +
> +	git init test_explicit &&
> +	start_daemon test_explicit &&
> +
> +	git -C test_explicit fsmonitor--daemon --stop &&
> +	test_must_fail git -C test_explicit fsmonitor--daemon --is-running
> +'

This is an example of a test that could have been created as early as
patch 09/23.

> +test_expect_success 'implicit daemon start' '
> +	test_when_finished "kill_repo test_implicit" &&
> +
> +	git init test_implicit &&
> +	test_must_fail git -C test_implicit fsmonitor--daemon --is-running &&
> +
> +	# query will implicitly start the daemon.
> +	#
> +	# for test-script simplicity, we send a V1 timestamp rather than
> +	# a V2 token.  either way, the daemon response to any query contains
> +	# a new V2 token.  (the daemon may complain that we sent a V1 request,
> +	# but this test case is only concerned with whether the daemon was
> +	# implicitly started.)
> +
> +	GIT_TRACE2_EVENT="$PWD/.git/trace" \
> +		git -C test_implicit fsmonitor--daemon --query 0 >actual &&
> +	nul_to_q <actual >actual.filtered &&
> +	grep "builtin:" actual.filtered &&
> +
> +	# confirm that a daemon was started in the background.
> +	#
> +	# since the mechanism for starting the background daemon is platform
> +	# dependent, just confirm that the foreground command received a
> +	# response from the daemon.
> +
> +	grep :\"query/response-length\" .git/trace &&
> +
> +	git -C test_implicit fsmonitor--daemon --is-running &&
> +	git -C test_implicit fsmonitor--daemon --stop &&
> +	test_must_fail git -C test_implicit fsmonitor--daemon --is-running
> +'
> +
> +test_expect_success 'implicit daemon stop (delete .git)' '
> +	test_when_finished "kill_repo test_implicit_1" &&
> +
> +	git init test_implicit_1 &&
> +
> +	start_daemon test_implicit_1 &&
> +
> +	# deleting the .git directory will implicitly stop the daemon.
> +	rm -rf test_implicit_1/.git &&
> +
> +	# Create an empty .git directory so that the following Git command
> +	# will stay relative to the `-C` directory.  Without this, the Git
> +	# command will (override the requested -C argument) and crawl out

Why the parentheses here?

> +	# to the containing Git source tree.  This would make the test
> +	# result dependent upon whether we were using fsmonitor on our
> +	# development worktree.
> +
> +	sleep 1 &&

I can understand this sleep, as we are waiting for a background process
to end in response to a directory being deleted.

I'm surprised this works on Windows! I recall having issues deleting
repos that are being watched by Watchman.

> +	mkdir test_implicit_1/.git &&
> +
> +	test_must_fail git -C test_implicit_1 fsmonitor--daemon --is-running
> +'
> +
> +test_expect_success 'implicit daemon stop (rename .git)' '
> +	test_when_finished "kill_repo test_implicit_2" &&
> +
> +	git init test_implicit_2 &&
> +
> +	start_daemon test_implicit_2 &&
> +
> +	# renaming the .git directory will implicitly stop the daemon.
> +	mv test_implicit_2/.git test_implicit_2/.xxx &&
> +
> +	# Create an empty .git directory so that the following Git command
> +	# will stay relative to the `-C` directory.  Without this, the Git
> +	# command will (override the requested -C argument) and crawl out
> +	# to the containing Git source tree.  This would make the test
> +	# result dependent upon whether we were using fsmonitor on our
> +	# development worktree.
> +
> +	sleep 1 &&
> +	mkdir test_implicit_2/.git &&
> +
> +	test_must_fail git -C test_implicit_2 fsmonitor--daemon --is-running
> +'
> +
> +test_expect_success 'cannot start multiple daemons' '
> +	test_when_finished "kill_repo test_multiple" &&
> +
> +	git init test_multiple &&
> +
> +	start_daemon test_multiple &&
> +
> +	test_must_fail git -C test_multiple fsmonitor--daemon --start 2>actual &&
> +	grep "fsmonitor--daemon is already running" actual &&
> +
> +	git -C test_multiple fsmonitor--daemon --stop &&
> +	test_must_fail git -C test_multiple fsmonitor--daemon --is-running
> +'

The tests above seem like they could be inserted as soon as the
platform-specific listeners are created. None of this requires the
linked-list of batched updates or cookie file checks.

> +test_expect_success 'setup' '
> +	>tracked &&
> +	>modified &&
> +	>delete &&
> +	>rename &&
> +	mkdir dir1 &&
> +	>dir1/tracked &&
> +	>dir1/modified &&
> +	>dir1/delete &&
> +	>dir1/rename &&
> +	mkdir dir2 &&
> +	>dir2/tracked &&
> +	>dir2/modified &&
> +	>dir2/delete &&
> +	>dir2/rename &&
> +	mkdir dirtorename &&
> +	>dirtorename/a &&
> +	>dirtorename/b &&
> +
> +	cat >.gitignore <<-\EOF &&
> +	.gitignore
> +	expect*
> +	actual*
> +	EOF
> +
> +	git -c core.useBuiltinFSMonitor= add . &&
> +	test_tick &&
> +	git -c core.useBuiltinFSMonitor= commit -m initial &&
> +
> +	git config core.useBuiltinFSMonitor true
> +'

Now we are getting into the meat of the interactions with Git
features. I can understand these not being ready until all of
the previous product patches are in place.

> +test_expect_success 'update-index implicitly starts daemon' '
> +	test_must_fail git fsmonitor--daemon --is-running &&
> +
> +	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_1" \
> +		git update-index --fsmonitor &&
> +
> +	git fsmonitor--daemon --is-running &&
> +	test_might_fail git fsmonitor--daemon --stop &&

Should this be a "test_when_finished kill_repo ." at the
beginning of the test?

> +
> +	grep \"event\":\"start\".*\"fsmonitor--daemon\" .git/trace_implicit_1
> +'
> +
> +test_expect_success 'status implicitly starts daemon' '
> +	test_must_fail git fsmonitor--daemon --is-running &&
> +
> +	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_2" \
> +		git status >actual &&
> +
> +	git fsmonitor--daemon --is-running &&
> +	test_might_fail git fsmonitor--daemon --stop &&
> +
> +	grep \"event\":\"start\".*\"fsmonitor--daemon\" .git/trace_implicit_2
> +'
> +
> +edit_files() {
> +	echo 1 >modified
> +	echo 2 >dir1/modified
> +	echo 3 >dir2/modified
> +	>dir1/untracked
> +}
> +
> +delete_files() {
> +	rm -f delete
> +	rm -f dir1/delete
> +	rm -f dir2/delete
> +}
> +
> +create_files() {
> +	echo 1 >new
> +	echo 2 >dir1/new
> +	echo 3 >dir2/new
> +}
> +
> +rename_files() {
> +	mv rename renamed
> +	mv dir1/rename dir1/renamed
> +	mv dir2/rename dir2/renamed
> +}
> +
> +file_to_directory() {
> +	rm -f delete
> +	mkdir delete
> +	echo 1 >delete/new
> +}
> +
> +directory_to_file() {
> +	rm -rf dir1
> +	echo 1 >dir1
> +}
> +
> +verify_status() {
> +	git status >actual &&
> +	GIT_INDEX_FILE=.git/fresh-index git read-tree master &&
> +	GIT_INDEX_FILE=.git/fresh-index git -c core.useBuiltinFSMonitor= status >expect &&
> +	test_cmp expect actual &&
> +	echo HELLO AFTER &&
> +	cat .git/trace &&
> +	echo HELLO AFTER
> +}
> +
> +# The next few test cases confirm that our fsmonitor daemon sees each type
> +# of OS filesystem notification that we care about.  At this layer we just
> +# ensure we are getting the OS notifications and do not try to confirm what
> +# is reported by `git status`.
> +#
> +# We run a simple query after modifying the filesystem just to introduce
> +# a bit of a delay so that the trace logging from the daemon has time to
> +# get flushed to disk.
> +#
> +# We `reset` and `clean` at the bottom of each test (and before stopping the
> +# daemon) because these commands might implicitly restart the daemon.
> +
> +clean_up_repo_and_stop_daemon () {
> +	git reset --hard HEAD
> +	git clean -fd
> +	git fsmonitor--daemon --stop
> +	rm -f .git/trace
> +}
> +
> +test_expect_success 'edit some files' '
> +	test_when_finished "clean_up_repo_and_stop_daemon" &&

Do you need the quotes here?

> +
> +	(
> +		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&

Use "$(pwd)/.git/trace". There are some strange things with $PWD
especially on Windows.

> +		export GIT_TRACE_FSMONITOR &&
> +
> +		start_daemon
> +	) &&
> +
> +	edit_files &&
> +
> +	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
> +
> +	grep "^event: dir1/modified$"  .git/trace &&
> +	grep "^event: dir2/modified$"  .git/trace &&
> +	grep "^event: modified$"       .git/trace &&
> +	grep "^event: dir1/untracked$" .git/trace
> +'
> +
> +test_expect_success 'create some files' '
> +	test_when_finished "clean_up_repo_and_stop_daemon" &&
> +
> +	(
> +		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
> +		export GIT_TRACE_FSMONITOR &&
> +
> +		start_daemon
> +	) &&
> +
> +	create_files &&
> +
> +	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
> +
> +	grep "^event: dir1/new$" .git/trace &&
> +	grep "^event: dir2/new$" .git/trace &&
> +	grep "^event: new$"      .git/trace
> +'

I wonder if we can scan the trace for the number of events
and ensure we have the right count, to ensure we aren't getting
_extra_ events that we don't want?

The rest of the tests seem similarly structured and testing
important cases. I'll delay thinking of new tests until I see
the rest of the tests you are adding.

Thanks,
-Stolee
