Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A618C432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 01:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FE720672
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 01:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyTgXJsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKVBGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:06:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37513 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKVBGv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 20:06:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so4433799wmf.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 17:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FvI3Xslltrre0xe96arIETfH4bFxiejaeGK6G9snGc4=;
        b=GyTgXJsVUT70M5RAOXlObkt0cgaVOEzTyQmGpTYiCLt6miusA0WEv3zjwUS3U/1zNB
         XOXDi9bHxMQ5Gvq8FlCLOjCEzUcZKPev1mLQ6N3/s0a71m1d316UhAK2Q/rdApoTWoyV
         xvDScZMrmEVAw12eYAiG7+Y5eNBveBk1EtwP46eFGb11in3kDwxhDoBDmXlD9iwqYbuy
         Ju0xYSDZC9hs6QnzE9d/QUfnNgmpVAPIU0X7r6reHnbDY12J+efpYKfhgF3IE6VltT5Y
         gQd8CwRBX0xv2lpDdcZxNwY0mYybcMt3oHXXQfhFPVKp0wJ+E4U2RWBUycgMY4j1uvpc
         yofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FvI3Xslltrre0xe96arIETfH4bFxiejaeGK6G9snGc4=;
        b=Uj2PlQiwyNgytX3W+geyNuENL9YMzLQ2QcRJGGvMHzEU0BjlvHAivTeuSHWUcYcEn2
         ND/KlC35L84UOvJ0trDMENH1Y+GUQvA/QxwizQf7z0f/azKKaDb2ovVoQ4CyooE5lRkP
         ePjoQUCQwT3nmu2GRyrhbz6Q/kXuO5hLg456M/KYG93nZbZo4CuSPOP30UwnkxOlGSBe
         Hu1OKVJzMlvUImdSxbFV1yjl9al3CedD7lyUxEnpmq36VC+n9lu6ZcR63tKRyFTuY79s
         jz2NCZqX8ugP58MT8LZhLYkYVkIisFDCxIPSSeP8CEIdd6FwWseMYQxQgUzHodjKtNO3
         Z+IA==
X-Gm-Message-State: APjAAAUx9YM8jQmzFomUetK652pf8unbnJz48AXpMHd+1vff18cg3U9M
        P+3/Gr6nJby31zPOjkp+JuA=
X-Google-Smtp-Source: APXvYqzwe5MnG/pSeJ6XZ90/ghfpSnPn7MvyGUxK9damI+g2YPrUShhN0adZL72AypIMRgku1ACBGw==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr14249928wmc.130.1574384808343;
        Thu, 21 Nov 2019 17:06:48 -0800 (PST)
Received: from szeder.dev (x4db6680d.dyn.telefonica.de. [77.182.104.13])
        by smtp.gmail.com with ESMTPSA id c10sm1548655wml.37.2019.11.21.17.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 17:06:47 -0800 (PST)
Date:   Fri, 22 Nov 2019 02:06:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/11] test-lib: clear watchman watches at test completion
Message-ID: <20191122010645.GX23183@szeder.dev>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <47cecb4a83a3f726088ffba0b00679384c7349ae.1574374826.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47cecb4a83a3f726088ffba0b00679384c7349ae.1574374826.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 10:20:26PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/test-lib-functions.sh | 15 +++++++++++++++
>  t/test-lib.sh           |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index e0b3f28d3a..03573caf42 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1475,3 +1475,18 @@ test_set_port () {
>  	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
>  	eval $var=$port
>  }
> +
> +test_clear_watchman () {
> +	if test $GIT_TEST_FSMONITOR -ne ""

In the rare cases when this function is invoked (see below) this
condition triggers an error from the shell running test script:

  - when the variable is not set, because of the lack of quotes around
    the variable name:

      $ ./t5570-git-daemon.sh 
      [....]
      ok 21 - hostname interpolation works after LF-stripping
      ./t5570-git-daemon.sh: 1482: test: -ne: unexpected operator
      # passed all 21 test(s)
      1..21

  - when the variable is set, because the '-ne' operator does integer
    comparison:

      $ GIT_TEST_FSMONITOR="$PWD"/t7519/fsmonitor-none ./t5570-git-daemon.sh
      [...]
      ok 21 - hostname interpolation works after LF-stripping
      ./t5570-git-daemon.sh: 1482: test: Illegal number: /home/szeder/src/git/t/t7519/fsmonitor-none
      # failed 1 among 21 test(s)
      1..21

Please use 'if test -n "$GIT_TEST_FSMONITOR"' instead.

> +	then
> +		watchman watch-list |

Then with the above fixed, trying to run 'watchman' triggers another
error if it's not installed:

  $ GIT_TEST_FSMONITOR="$PWD"/t7519/fsmonitor-none ./t5570-git-daemon.sh 
  [...]
  ok 21 - hostname interpolation works after LF-stripping
  ./t5570-git-daemon.sh: 1484: ./t5570-git-daemon.sh: watchman: not found
  # failed 1 among 21 test(s)

I think we need an additional condition to run this only if
't7519/fsmonitor-watchman' is used in the tests.

> +			grep "$TRASH_DIRECTORY" |
> +			sed "s/\t\"//g" |
> +			sed "s/\",//g" >repo-list
> +
> +		for repo in $(cat repo-list)
> +		do
> +			watchman watch-del "$repo"
> +		done
> +	fi
> +}
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 30b07e310f..067a432ea5 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1072,6 +1072,8 @@ test_atexit_handler () {
>  	# sure that the registered cleanup commands are run only once.
>  	test : != "$test_atexit_cleanup" || return 0
>  
> +	test_clear_watchman

I'm not sure where to put this call, but this is definitely not the
right place for it.  See that 'return 0' above in the context?  That's
where the test_atexit_handler function returns early when no atexit
handler commands are set, i.e. in all test scripts that don't involve
some kind of daemons, thus this call is not invoked in the majority of
test scripts.

Simply moving this call before that early return is not good, because
then it would be invoked twice.

An option would be to register this call as an atexit command
somewhere late in 'test-lib.sh' (around where GIT_TEST_GETTEXT_POISON
is restored, perhaps).  That way it would be invoked most of the time,
and it would be invoked only once, but I'm not sure how it would work
out with test scripts that unset GIT_TEST_FSMONITOR somewhere in the
middle for the remainder of the test script.  However, register the
atexit command only if GIT_TEST_FSMONITOR is set (to something
watchman-specific), so it won't be invoked at all if
GIT_TEST_FSMONITOR is not set, and thus it won't generate additional
test output and trace.

I don't have a better idea.

> +
>  	setup_malloc_check
>  	test_eval_ "$test_atexit_cleanup"
>  	test_atexit_cleanup=:
> -- 
> gitgitgadget
