Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6323C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D9F61416
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbhGAWaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhGAWaR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:30:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03AC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 15:27:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t3so10540907edt.12
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Rod5NZepvdveOxElxTWdN38B5gy6fx+NzFlNM0TeCGI=;
        b=nS9Ob9tPuWZlxfv/U6goT6oGVQve/T4T+hTOhaMUEj05r+ag1U/5PfgYm8HbCcnQBZ
         x5fFb4jkGBdHjmt4UaXKODKIoVbT6aLXRKogG5RQQ5UbpFwE7/396vvSlV3vjooVDtzb
         J+YOifDYC+iazYKpT93LPm8zhTrj5tYJmswi4ctbgxcN32dylM1GwCOR1RbRMSJx43G4
         MBOolcsibCuYCe9v6cowUCCDRh7VwS2clRpZPvI+YOBFYL2OTmNSAte95jLYm3vS0w5O
         rn7/KCQecClwP3QPx1qg88jsykGZocVf32qkhg+NT73rffthLvb491NHkvzTciRYD7Vb
         nMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Rod5NZepvdveOxElxTWdN38B5gy6fx+NzFlNM0TeCGI=;
        b=t1QQujvKBoQDelKFv7Ik8suaJguFN5zh+Z2018OQN6HGITlx+K4RdzlNBvwVEivLki
         gv4Nwksf6wMHbFT+9+mkHraG6Lm/DwBT9F64r6Gj3N7n0lSLJooZYPaBNIvMOOBf0BMw
         mp2MYCF2bNMh1IIeCbkwtJW/O8TyCuvmVfs5vV1Zq7gDkjP/QSuEQ1r/mr+ldfwkdG4z
         swVXvn8DOz5Z7M6AOoAoofbQ7N4alV1gAimEbuRh48ZgKS9Hm7RKyC+95sJxW6SDerqo
         M7E3iAthzqY8ppTOuz8yEN04Dm7ZeD69xDUZi1fpa0BOhqAEDkou/IXVnCyZFGndLU2Y
         m/uw==
X-Gm-Message-State: AOAM5337IyQIORih+OlhVJclJuYdKp20dppnlgpmL0VCE8UpGFS2QXi9
        /EaxrIXue/1QKmRwi3MQFgSCrTrl+hONIA==
X-Google-Smtp-Source: ABdhPJzu5eK+pJKPFCQsPL6KloMH+qpN4Qx2a0vXdzxRH9AX7SS1y23txzHojYS9KW/T5X93wDdKDw==
X-Received: by 2002:a50:fd83:: with SMTP id o3mr2668491edt.95.1625178464432;
        Thu, 01 Jul 2021 15:27:44 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h7sm475805edb.13.2021.07.01.15.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:27:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 14/34] fsmonitor--daemon: implement 'start' command
Date:   Fri, 02 Jul 2021 00:18:01 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <9fe902aad87f1192705fb69ea212a2d066d0286d.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <9fe902aad87f1192705fb69ea212a2d066d0286d.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87a6n5d600.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> +#ifdef GIT_WINDOWS_NATIVE
> +/*
> + * Create a background process to run the daemon.  It should be completely
> + * disassociated from the terminal.
> + *
> + * Conceptually like `daemonize()` but different because Windows does not
> + * have `fork(2)`.  Spawn a normal Windows child process but without the
> + * limitations of `start_command()` and `finish_command()`.
> + *
> + * The child process execs the "git fsmonitor--daemon run" command.
> + *
> + * The current process returns so that the caller can wait for the child
> + * to startup before exiting.
> + */
> +static int spawn_background_fsmonitor_daemon(pid_t *pid)
> +{
> +	char git_exe[MAX_PATH];
> +	struct strvec args = STRVEC_INIT;
> +	int in, out;
> +
> +	GetModuleFileNameA(NULL, git_exe, MAX_PATH);
> +
> +	in = open("/dev/null", O_RDONLY);
> +	out = open("/dev/null", O_WRONLY);
> +
> +	strvec_push(&args, git_exe);
> +	strvec_push(&args, "fsmonitor--daemon");
> +	strvec_push(&args, "run");
> +	strvec_pushf(&args, "--ipc-threads=%d", fsmonitor__ipc_threads);
> +
> +	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
> +	close(in);
> +	close(out);
> +
> +	strvec_clear(&args);
> +
> +	if (*pid < 0)
> +		return error(_("could not spawn fsmonitor--daemon in the background"));
> +
> +	return 0;
> +}
> +#else
> +/*
> + * Create a background process to run the daemon.  It should be completely
> + * disassociated from the terminal.
> + *
> + * This is adapted from `daemonize()`.  Use `fork()` to directly
> + * create and run the daemon in the child process.
> + *
> + * The fork-child can just call the run code; it does not need to exec
> + * it.
> + *
> + * The fork-parent returns the child PID so that we can wait for the
> + * child to startup before exiting.
> + */
> +static int spawn_background_fsmonitor_daemon(pid_t *pid)
> +{
> +	*pid = fork();
> +
> +	switch (*pid) {
> +	case 0:
> +		if (setsid() == -1)
> +			error_errno(_("setsid failed"));
> +		close(0);
> +		close(1);
> +		close(2);
> +		sanitize_stdfds();
> +
> +		return !!fsmonitor_run_daemon();
> +
> +	case -1:
> +		return error_errno(_("could not spawn fsmonitor--daemon in the background"));
> +
> +	default:
> +		return 0;
> +	}
> +}
> +#endif

The spawn_background_fsmonitor_daemon() function here is almost the same
as daemonize(). I wonder if this & the Windows-specific one you have
here can't be refactored into an API from what's now in setup.c.

Then we could make builtin/gc.c and daemon.c use that, so Windows could
have background GC, and we'd have a more battle-tested central codepath
for this tricky bit.

It seems to me like the only limitations on it are to have this return
slightly more general things (e.g. not set its own errors, return
structured data), and maybe some callback for what to do in the
child/parent.

> +/*
> + * This is adapted from `wait_or_whine()`.  Watch the child process and
> + * let it get started and begin listening for requests on the socket
> + * before reporting our success.
> + */
> +static int wait_for_background_startup(pid_t pid_child)
> +{
> +	int status;
> +	pid_t pid_seen;
> +	enum ipc_active_state s;
> +	time_t time_limit, now;
> +
> +	time(&time_limit);
> +	time_limit += fsmonitor__start_timeout_sec;
> +
> +	for (;;) {
> +		pid_seen = waitpid(pid_child, &status, WNOHANG);
> +
> +		if (pid_seen == -1)
> +			return error_errno(_("waitpid failed"));
> +		else if (pid_seen == 0) {
> +			/*
> +			 * The child is still running (this should be
> +			 * the normal case).  Try to connect to it on
> +			 * the socket and see if it is ready for
> +			 * business.
> +			 *
> +			 * If there is another daemon already running,
> +			 * our child will fail to start (possibly
> +			 * after a timeout on the lock), but we don't
> +			 * care (who responds) if the socket is live.
> +			 */
> +			s = fsmonitor_ipc__get_state();
> +			if (s == IPC_STATE__LISTENING)
> +				return 0;
> +
> +			time(&now);
> +			if (now > time_limit)
> +				return error(_("fsmonitor--daemon not online yet"));
> +		} else if (pid_seen == pid_child) {
> +			/*
> +			 * The new child daemon process shutdown while
> +			 * it was starting up, so it is not listening
> +			 * on the socket.
> +			 *
> +			 * Try to ping the socket in the odd chance
> +			 * that another daemon started (or was already
> +			 * running) while our child was starting.
> +			 *
> +			 * Again, we don't care who services the socket.
> +			 */
> +			s = fsmonitor_ipc__get_state();
> +			if (s == IPC_STATE__LISTENING)
> +				return 0;
> +
> +			/*
> +			 * We don't care about the WEXITSTATUS() nor
> +			 * any of the WIF*(status) values because
> +			 * `cmd_fsmonitor__daemon()` does the `!!result`
> +			 * trick on all function return values.
> +			 *
> +			 * So it is sufficient to just report the
> +			 * early shutdown as an error.
> +			 */
> +			return error(_("fsmonitor--daemon failed to start"));
> +		} else
> +			return error(_("waitpid is confused"));
> +	}
> +}

Ditto this. could we extend the wait_or_whine() function (or some
extended version thereof) to do what you need with callbacks?

It seems the main difference is just being able to pass down a flag for
waitpid(), and the loop needing to check EINTR or not depending on
whether WNOHANG is passed.

For e.g. the "We don't care about the WEXITSTATUS()" you'd get that
behavior with an adjusted wait_or_whine(). Wouldn't it be better to
report what exit status it exits with e.g. if the top-level process is
signalled? We do so in trace2 for other things we spawn...
