Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D314FC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 23:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCB8206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 23:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV3ewaNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfLIXkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:40:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53256 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLIXkX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 18:40:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id n9so1196849wmd.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 15:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LVOI/1fWh87YrDuc8B32C2GDOuyowtYiHiguiYgOXYw=;
        b=gV3ewaNSgZUrBVpTNLB2auhnyQryNCHrHrDSA2gFx56l8+9aMCoNNeyELqRcq12vJG
         h0Bbhx00RkWeYpwPgIpVdvcJV+gr6YTRoNM8ZVTsYGSm/oRrFjIyq03hH6kKMSH9LETG
         J40+XhO87SVwYm4xsRVxF/NHCZ2bbK8SB5jmD3OMf0neJwfam4H/XuHugVvA09BrM6aV
         IIYJ3l9gS4VcbbP4muxCkV7cSbGu9j8ySmUaUsqvQw/OhABEjYcmnXJr6GvfHSGUEaH6
         Z/vViCvhZ3LHXlHv4Uvs0mCKQ35iVU7t4JSCqqCSGLlvQZHlHuNXHULY+6IrI4jY/NA0
         yg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LVOI/1fWh87YrDuc8B32C2GDOuyowtYiHiguiYgOXYw=;
        b=E6ZAhg8I16N8JHOYuFXrSgIuj1/WI79fNYB/fKV5WRKvMMFtDGnYh+pNcrkcSvxdg+
         vGg0fCuP/V6WmkZS0mHhHC74iDj+K129PPgspGpkwg4fDHvSjlbW4O9zGL6QAsHK3BUo
         RsMjKcw3jArDXhhdU/zmfXfRRChj/QiZ2K522Pjmx2yw4a9nj2O94SKlmxvcKgStgv22
         sENUAipe5Nk/RRaYhvvQ4aCtMeh0Cn1Ol7YU9MS9gVFCyMiVK4fu+2mf7GG1xz7gkGgN
         /oamTumaeANOV3iYxbBXEROPTKa04z+VRkpUJQpNEM9LhAQSnTqHbkrI+JGcFPGDT9c8
         lipw==
X-Gm-Message-State: APjAAAXrUm7Qu/bUI1mq9O8yWhuf+xYgpTKCV58GczdKz3YFn77QAL3U
        z4W0MFY2LvDd14486GHwH5A=
X-Google-Smtp-Source: APXvYqyQRyHix7wefd+mTiHCa/S1zpBSSKww3m7/bpG/2Yyl20VJdLrVn7GlovqMUa0fH5cToz6pzA==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr1654693wmk.157.1575934821937;
        Mon, 09 Dec 2019 15:40:21 -0800 (PST)
Received: from szeder.dev (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id g69sm1118849wmg.13.2019.12.09.15.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 15:40:21 -0800 (PST)
Date:   Tue, 10 Dec 2019 00:40:16 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/11] test-lib: clear watchman watches at test completion
Message-ID: <20191209234016.GA6527@szeder.dev>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <47cecb4a83a3f726088ffba0b00679384c7349ae.1574374826.git.gitgitgadget@gmail.com>
 <20191122010645.GX23183@szeder.dev>
 <93325ecb-0bbe-e7fb-3b60-8fff81768f8f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93325ecb-0bbe-e7fb-3b60-8fff81768f8f@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 09, 2019 at 09:12:37AM -0500, Derrick Stolee wrote:
> >> +		watchman watch-list |
> > 
> > Then with the above fixed, trying to run 'watchman' triggers another
> > error if it's not installed:
> > 
> >   $ GIT_TEST_FSMONITOR="$PWD"/t7519/fsmonitor-none ./t5570-git-daemon.sh 
> >   [...]
> >   ok 21 - hostname interpolation works after LF-stripping
> >   ./t5570-git-daemon.sh: 1484: ./t5570-git-daemon.sh: watchman: not found
> >   # failed 1 among 21 test(s)
> > 
> > I think we need an additional condition to run this only if
> > 't7519/fsmonitor-watchman' is used in the tests.
> 
> The intention is to enable a test-suite-wide run using GIT_TEST_FSMONITOR,
> and that can only use watchman (currently).

I've just run 'GIT_TEST_FSMONITOR=$(pwd)/t7519/fsmonitor-all make',
and it only failed one test in 't0090-cache-tree.sh', but the fix is
already in 'pu' in 61eea521fe (fsmonitor: do not compare bitmap size
with size of split index, 2019-11-13).


> >> diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> index 30b07e310f..067a432ea5 100644
> >> --- a/t/test-lib.sh
> >> +++ b/t/test-lib.sh
> >> @@ -1072,6 +1072,8 @@ test_atexit_handler () {
> >>  	# sure that the registered cleanup commands are run only once.
> >>  	test : != "$test_atexit_cleanup" || return 0
> >>  
> >> +	test_clear_watchman
> > 
> > I'm not sure where to put this call, but this is definitely not the
> > right place for it.  See that 'return 0' above in the context?  That's
> > where the test_atexit_handler function returns early when no atexit
> > handler commands are set, i.e. in all test scripts that don't involve
> > some kind of daemons, thus this call is not invoked in the majority of
> > test scripts.
> 
> Ah, I misunderstood the point of test_atexit_handler.
> 
> > Simply moving this call before that early return is not good, because
> > then it would be invoked twice.
> > 
> > An option would be to register this call as an atexit command
> > somewhere late in 'test-lib.sh' (around where GIT_TEST_GETTEXT_POISON
> > is restored, perhaps).  That way it would be invoked most of the time,
> > and it would be invoked only once, but I'm not sure how it would work
> > out with test scripts that unset GIT_TEST_FSMONITOR somewhere in the
> > middle for the remainder of the test script.  However, register the
> > atexit command only if GIT_TEST_FSMONITOR is set (to something
> > watchman-specific), so it won't be invoked at all if
> > GIT_TEST_FSMONITOR is not set, and thus it won't generate additional
> > test output and trace.
> > 
> > I don't have a better idea.
> 
> Shouldn't it be sufficient to add it into test_done? If the test fails,
> then we could leave watches open, but that's no worse than we had without
> this test_clear_watchman method.

I don't know enough about watchman to have an informed opinion.

I think the answer mainly depends on what we want to achive and what
happens when a test script run with GIT_TEST_FSMONITOR exits without
invoking 'test_done' is re-executed (e.g. after a test case fails with
'--immediate' or when the user hits ctrl-c or closes the terminal
window mid-test).

As far as I understand the commit message of v2 of this patch [1], we
mainly want two things:

  - Avoid overloading watchman's watch queue.  For this it might
    indeed be sufficient to clear watches in 'test_done', because most
    test scripts tend to succeed most of the time.

  - Make GIT_TEST_FSMONITOR work reliably on Windows.  For this, I'm
    afraid it's not enough in general, because a failure with
    '--immediate' or after a ctrl-c we won't run 'test_done', so we
    won't clear the watches, and watchman will keep the fd to the
    trash dir open, and, consequently, will interfere with subsequent
    executions of the same test script as it can't delete the still
    existing trash dir left over from the previous run.
    
    It could still be sufficient for fsmonitor-enabled CI builds,
    though, because there we don't re-run tests, don't hit ctrl-c, and
    (at least on Azure Pipelines) don't use '--immediate', and the
    whole VM/container/whatever is thrown away at end anyway.

    On Linux/Unix-y systems it probably doesn't matter much, because
    they can delete open directories, but I wonder what happens with a
    watch when the directory it is supposed observe gets deleted.  If
    the watch is removed in this case, great; if it isn't, then...
    well, then what happens with it?  Will it be overwritten with the
    next test run, or will there be duplicate watches for the same
    dir?

[1] https://public-inbox.org/git/e51165f260d564ccb7a9b8e696691eccb184c01a.1575907804.git.gitgitgadget@gmail.com/

