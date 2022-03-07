Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808A1C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbiCGL3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242417AbiCGL2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:28:16 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417C21C101
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:08:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p15so31069041ejc.7
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uxR0e0Co5C43pX9olW2Ruxu0UcxbUu2WGlLjcXJAEJQ=;
        b=IfEQgYnyKnWPQvgNcSUAZByhVNgAXDUz+AfO78RukPLb1FwwipfztdkHbikNWm1/AO
         ZyAyV/N1aNBun6QHH1zF9FaWivWhqgKtVjcXh4znOPSoq6CelspZgRuEvZO2vVGWReV3
         7HmEb7QxXEBSwDVEEeRZ3KaY9H+Rc498RBfCrSq98+4rb5yKWpo7BzB+O9FPdJ4kRPvh
         Q9MFOHtsxV6O7SNFj5Dc5P82Uqx3KaGeaK4zhQJNRd3tr3MlB2qPhX5BIx0DK+PfJdxK
         7bu1QdKBRQgftQS5INuZxrOaKrYIfO4WkPO28adLlTr3nqFBbNXWh71B6uktkaItuHgQ
         wASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uxR0e0Co5C43pX9olW2Ruxu0UcxbUu2WGlLjcXJAEJQ=;
        b=w0ddkcozomomdhtAfKe3XLenhJGzou/S1JT7lhYzrmVf7vioyEUD09rgmuPg+Z7M6m
         I77tPviAKB7mYwE/1Vp5N3V2hq0kfL1K+1QnV4zofFExhC63T2OD5KdJaDz2tqZenEii
         iOq7T2EO+Ob7WyrZ5MdcVec6RzO661z6jgj65/SGdHX2ew0AywaOWC1w8aCiHiEunv4I
         oVEFmAfJj/GWatdHu4es4PnIPgZZwmN45AaCl5kCXmkrUNS28P19e3yizIAMOeojbJuO
         7luy5dNeTHolmkDHFN4Ye7mpReS8FUafh/mVwUidAgzrQ/8d43DY7xwfC1BKIBE2k5nR
         JXiQ==
X-Gm-Message-State: AOAM531iM1v9WhTqaIG96njcgM6vhGUS3tM86RwuKIPhnoUbqxCFmlXU
        i5OlwrKtQlYtX+B1v4gHRufeJIQjrqg=
X-Google-Smtp-Source: ABdhPJx/wK85Zu4D/KHNtGXFoN5SpgKj1iAFjG5I4TswUsr8/kK5oWJS2d1G4qCGhp9VJQpX+4v5Xg==
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id sd1-20020a1709076e0100b006d0562ce389mr8773616ejc.497.1646651298567;
        Mon, 07 Mar 2022 03:08:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r14-20020a1709067fce00b006db0edb8a80sm1647990ejs.225.2022.03.07.03.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:08:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRBDt-001R2O-8u;
        Mon, 07 Mar 2022 12:08:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 21/30] t7527: create test for fsmonitor--daemon
Date:   Mon, 07 Mar 2022 11:58:58 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <db8809da089f28282c6bce1752a25423811a374a.1646160212.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <db8809da089f28282c6bce1752a25423811a374a.1646160212.git.gitgitgadget@gmail.com>
Message-ID: <220307.864k4a2f6m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t7527-builtin-fsmonitor.sh | 511 +++++++++++++++++++++++++++++++++++
>  1 file changed, 511 insertions(+)
>  create mode 100755 t/t7527-builtin-fsmonitor.sh
>
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> new file mode 100755
> index 00000000000..5f7b8e54233
> --- /dev/null
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -0,0 +1,511 @@
> +#!/bin/sh
> +
> +test_description='built-in file system watcher'
> +
> +. ./test-lib.sh
> +
> +if ! test_have_prereq FSMONITOR_DAEMON
> +then
> +	skip_all="fsmonitor--daemon is not supported on this platform"
> +	test_done
> +fi
> +
> +stop_daemon_delete_repo () {
> +	r=$1
> +	git -C $r fsmonitor--daemon stop >/dev/null 2>/dev/null

Do we really need to quiet all its output? Why not just have the
--verbose option do its thing?

> +	rm -rf $1
> +	return 0

Missing &&-chaining
> +}
> +
> +start_daemon () {
> +	case "$#" in
> +		1) r="-C $1";;
> +		*) r="";

Our usual style is not to indent these.

But maybe just use the same pattern as test_commit et al use? It's a bit
more verbose, but IMO clearer.

> +	esac
> +
> +	git $r fsmonitor--daemon start || return $?
> +	git $r fsmonitor--daemon status || return $?

Maybe don't do all this "return" and just &&-chain these instead (including the case/esac)?

> +
> +	return 0
> +}
> +
> +# Is a Trace2 data event present with the given catetory and key?
> +# We do not care what the value is.
> +#
> +have_t2_data_event () {
> +	c=$1
> +	k=$2
> +
> +	grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
> +}

Optional & aside: But it would be really nice to just have this amend
the test_region function into something more general, so this could be:

    test_trace2 --event data --category "$c" --key "$k"

And have "test_region" then be a thin wrapper for that, and do the
appropriate "maybe only the start one, not the end one?" logic there.

> +test_expect_success 'explicit daemon start and stop' '
> +	test_when_finished "stop_daemon_delete_repo test_explicit" &&
> +
> +	git init test_explicit &&
> +	start_daemon test_explicit &&
> +
> +	git -C test_explicit fsmonitor--daemon stop &&
> +	test_must_fail git -C test_explicit fsmonitor--daemon status
> +'
> +
> +test_expect_success 'implicit daemon start' '
> +	test_when_finished "stop_daemon_delete_repo test_implicit" &&
> +
> +	git init test_implicit &&
> +	test_must_fail git -C test_implicit fsmonitor--daemon status &&
> +
> +	# query will implicitly start the daemon.
> +	#
> +	# for test-script simplicity, we send a V1 timestamp rather than
> +	# a V2 token.  either way, the daemon response to any query contains
> +	# a new V2 token.  (the daemon may complain that we sent a V1 request,
> +	# but this test case is only concerned with whether the daemon was
> +	# implicitly started.)
> +
> +	GIT_TRACE2_EVENT="$(pwd)/.git/trace" \

Better to use $PWD than $(pwd)

> +delete_files () {
> +	rm -f delete
> +	rm -f dir1/delete
> +	rm -f dir2/delete

More missing &&-chaining.

> +}
> +
> +create_files () {
> +	echo 1 >new
> +	echo 2 >dir1/new
> +	echo 3 >dir2/new
> +}
> +
> +rename_files () {
> +	mv rename renamed
> +	mv dir1/rename dir1/renamed
> +	mv dir2/rename dir2/renamed

ditto.


> +}
> +
> +file_to_directory () {
> +	rm -f delete
> +	mkdir delete
> +	echo 1 >delete/new

ditto.


> +}
> +
> +directory_to_file () {
> +	rm -rf dir1
> +	echo 1 >dir1

ditto.
> +}
> +
> +verify_status () {

This is used by nothing? Maybe it'll be used later, but that commit
could/should add it then?

Hrm, nope, just read ahead and nothing uses it at all.

> +clean_up_repo_and_stop_daemon () {
> +	git reset --hard HEAD
> +	git clean -fd
> +	git fsmonitor--daemon stop
> +	rm -f .git/trace

Missing &&-chaining (will stop noting these now, please look through the rest...)

> +}
> +
> +test_expect_success 'edit some files' '
> +	test_when_finished clean_up_repo_and_stop_daemon &&
> +
> +	(
> +		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
> +		export GIT_TRACE_FSMONITOR &&
> +
> +		start_daemon

Maybe have this "start_daemon" take an optional --trace argument or
something, allowing us to skip all these subsequent subshells.

> +	) &&
> +
> +	edit_files &&
> +
> +	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&

For these & the rest: just skip the quieting of the output? I.e. let the
test's --verbose do its job?


> +test_expect_success 'flush cached data' '
> +	test_when_finished "stop_daemon_delete_repo test_flush" &&
> +
> +	git init test_flush &&
> +
> +	(
> +		GIT_TEST_FSMONITOR_TOKEN=true &&
> +		export GIT_TEST_FSMONITOR_TOKEN &&
> +
> +		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace_daemon" &&
> +		export GIT_TRACE_FSMONITOR &&
> +
> +		start_daemon test_flush
> +	) &&
> +
> +	# The daemon should have an initial token with no events in _0 and
> +	# then a few (probably platform-specific number of) events in _1.
> +	# These should both have the same <token_id>.
> +
> +	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_0 &&
> +	nul_to_q <actual_0 >actual_q0 &&
> +
> +	touch test_flush/file_1 &&
> +	touch test_flush/file_2 &&

I may be missinga subtlety here, but is "touch" needed v.s. ">", i.e. we
just created "test_flush", so if we create a new file it'll have the
current timestamp.

Or did it get created by the helpers?
