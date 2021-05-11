Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21445C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5EE611CA
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhEKRcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 13:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKRcy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 13:32:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36FC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:31:47 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u1so10568903qvg.11
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aCS+qMQJ/OjPxf88J3uE/VfbuyLawc8KKdiWdi7J5c8=;
        b=DSaaVTzwJMdFQ/I0wwLjLYYGnNPBRjX88IfxweDHZ7gpTU0Ignf643QpB5N5yv6nPv
         8nu+Chd2audVukOOhHoKXnptSk0VTkhPLyXZhTteO2sxDIX9Y7lF+sLn5BhIV99Wr9aC
         MIfrm95nEU3VeiZqxh9xjVg1jMcyItVFg0joUANxJofjNH1UeKsWjkD3bIaRyGGuMA6H
         tpfnwkmXHBIQJ3WHJAy0buiBYY961v1ohFnBxH7tCdPLN8ZLCNxL/LpSwpucQ3Vkca4Z
         gPfSe2Rjj2P7QAWsMqqQPllurCMmbQ1mTzouS0qjyT22QA8dEoIyelqlsZMxkjHeNEjE
         cV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aCS+qMQJ/OjPxf88J3uE/VfbuyLawc8KKdiWdi7J5c8=;
        b=DPom5aiEVOjnrv/zUj32M1VjEB4K4TbYFR2Uc9eMEzpw+PHYgSuW1U2mZMxbRQpen+
         hkvjFy6E7O+Q+4goq2th4xMVDz3RpGN5s6qdenBQa76dhFblcMXsdwgst2HSTY2HFVQQ
         w9F0V/vfGMTEmMj1xsYNH/5SQrSVHDuClTf9bX4iqtHPw3d735GYCovbKzu/975vz0Xq
         9flmortDlbIMnPnp+t2qjU51y9C9ojUMNcJLsTFUKa+sr8dpyXiv7J0xsicLnJPEmjmS
         DzjKIb08w4gEr33VeTZUiDRgLg0MFrxXJCMk8vBQpioT+zeED6vtw3P55y0UWmS+ULch
         Lzaw==
X-Gm-Message-State: AOAM532MgT5BnzYTE3p47KvzuUvrZa/Ayx6pG5ssPfZH2p1q+Xt6Nea4
        Ma8PrMePFAKnDsvylRxQ3UY=
X-Google-Smtp-Source: ABdhPJzbs4B9afOLw3bqDhiCczAH8cJ0XHjYy60Bx/h39l4THRMr/L1f00UQJ2juiWCOf2MjJZQmnw==
X-Received: by 2002:a0c:bf4b:: with SMTP id b11mr31043831qvj.11.1620754306749;
        Tue, 11 May 2021 10:31:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d53c:1a94:49a3:bce7? ([2600:1700:e72:80a0:d53c:1a94:49a3:bce7])
        by smtp.gmail.com with ESMTPSA id f26sm14525834qtg.17.2021.05.11.10.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 10:31:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1873c650-e9b3-b6d2-b67b-bd09a90e6782@gmail.com>
Date:   Tue, 11 May 2021 13:31:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210509213217.449489-2-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2021 5:32 PM, Lénaïc Huard wrote:
> The existing mechanism for scheduling background maintenance is done
> through cron. On Linux systems managed by systemd, systemd provides an
> alternative to schedule recurring tasks: systemd timers.

Thank you for working so hard on this systemd integration. I see you
have already received significant feedback on that portion, so I
wanted to focus my review on the other piece that exists in this patch.

> In order to choose which scheduler to use between `cron` and user
> systemd timers, a new option
> `--scheduler=auto|cron|systemd|launchctl|schtasks` has been added to
> `git maintenance start`.
> When `git maintenance start --scheduler=XXX` is run, it not only
> registers `git maintenance run` tasks in the scheduler XXX, it also
> removes the `git maintenance run` tasks from all the other schedulers to
> ensure we cannot have two schedulers launching concurrent identical
> tasks.
> 
> The default value is `auto` which chooses a suitable scheduler for the
> system.

This addition of the --scheduler option should be split into a patch
on its own. It requires significant refactoring of the existing code
in a way that distracts from your systemd work.

I'll highlight the portions of the diff that you could include in
a preliminary patch and save the systemd stuff for an addition on top
of that.

> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 80ddd33ceb..f012923333 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -181,6 +181,20 @@ OPTIONS
>  	`maintenance.<task>.enabled` configured as `true` are considered.
>  	See the 'TASKS' section for the list of accepted `<task>` values.
>  
> +--scheduler=auto|crontab|systemd-timer|launchctl|schtasks::
> +	When combined with the `start` subcommand, specify the scheduler
> +	to use to run the hourly, daily and weekly executions of
> +	`git maintenance run`.
> +	The possible values for `<scheduler>` depend on the system: `crontab`
> +	is available on POSIX systems, `systemd-timer` is available on Linux
> +	systems, `launchctl` is available on MacOS and `schtasks` is available
> +	on Windows.
> +	By default or when `auto` is specified, the most appropriate scheduler
> +	for the system is used. On MacOS, `launchctl` is used. On Windows,
> +	`schtasks` is used. On Linux, `systemd-timers` is used if user systemd
> +	timers are available, otherwise, `crontab` is used. On all other systems,
> +	`crontab` is used.
> +

This portion of the docs can be updated on its own (minus the systemd bits).
> diff --git a/builtin/gc.c b/builtin/gc.c
> index ef7226d7bc..7c72aa3b99 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1544,6 +1544,15 @@ static const char *get_frequency(enum schedule_priority schedule)
>  	}
>  }
>  
> +static int is_launchctl_available(const char *cmd)
> +{
> +#ifdef __APPLE__
> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}
> +
>  static char *launchctl_service_name(const char *frequency)
>  {
>  	struct strbuf label = STRBUF_INIT;
> @@ -1710,6 +1719,15 @@ static int launchctl_update_schedule(int run_maintenance, int fd, const char *cm
>  		return launchctl_remove_plists(cmd);
>  }
>  
> +static int is_schtasks_available(const char *cmd)
> +{
> +#ifdef GIT_WINDOWS_NATIVE
> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}
> +
>  static char *schtasks_task_name(const char *frequency)
>  {
>  	struct strbuf label = STRBUF_INIT;
> @@ -1872,6 +1890,28 @@ static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd
>  		return schtasks_remove_tasks(cmd);
>  }
>  
> +static int is_crontab_available(const char *cmd)
> +{
> +	static int cached_result = -1;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	if (cached_result != -1)
> +		return cached_result;
> +
> +	strvec_split(&child.args, cmd);
> +	strvec_push(&child.args, "-l");
> +	child.no_stdin = 1;
> +	child.no_stdout = 1;
> +	child.no_stderr = 1;
> +	child.silent_exec_failure = 1;
> +
> +	if (start_command(&child))
> +		return cached_result = 0;
> +	/* Ignore exit code, as an empty crontab will return error. */
> +	finish_command(&child);
> +	return cached_result = 1;
> +}
> +

These is_X_available() methods are valuable helpers. Adding
is_systemd_timer_available() in the second patch will be
simpler with this framework in place.

> +enum scheduler {
> +	SCHEDULER_INVALID = -1,
> +	SCHEDULER_AUTO = 0,
> +	SCHEDULER_CRON = 1,
> +	SCHEDULER_SYSTEMD = 2,
> +	SCHEDULER_LAUNCHCTL = 3,
> +	SCHEDULER_SCHTASKS = 4,
> +};
> +
> +static const struct {
> +	int (*is_available)(const char *cmd);
> +	int (*update_schedule)(int run_maintenance, int fd, const char *cmd);
> +	const char *cmd;
> +} scheduler_fn[] = {
> +	[SCHEDULER_CRON] = { is_crontab_available, crontab_update_schedule,
> +			     "crontab" },
> +	[SCHEDULER_SYSTEMD] = { is_systemd_timer_available,
> +				systemd_timer_update_schedule, "systemctl" },
> +	[SCHEDULER_LAUNCHCTL] = { is_launchctl_available,
> +				  launchctl_update_schedule, "launchctl" },
> +	[SCHEDULER_SCHTASKS] = { is_schtasks_available,
> +				 schtasks_update_schedule, "schtasks" },
> +};

This is also good to include, minus the systemd lines.

I would also like to see this declaration reformatted.
Something like this would be good:

static const struct {
	int (*is_available)(const char *cmd);
	int (*update_schedule)(int run_maintenance, int fd, const char *cmd);
	const char *cmd;
} scheduler_fn[] = {
	[SCHEDULER_CRON] = {
		.is_available = is_crontab_available,
		.update_schedule = crontab_update_schedule,
		.cmd = "crontab",
	},
	[SCHEDULER_LAUNCHCTL] = {
		.is_available = is_launchctl_available,
		.update_schedule = launchctl_update_schedule,
		.cmd = "launchctl",
	},
	[SCHEDULER_SCHTASKS] = {
		.is_available = is_schtasks_available,
		.update_schedule = schtasks_update_schedule,
		.cmd = "schtasks",
	},
};

The use of member names can help if we need to augment this
struct later, and the use of commas after the final terms of
each block helps the future diff if we add items to the end.

> +
> +static enum scheduler parse_scheduler(const char *value)
> +{
> +	if (!value)
> +		return SCHEDULER_INVALID;
> +	else if (!strcasecmp(value, "auto"))
> +		return SCHEDULER_AUTO;
> +	else if (!strcasecmp(value, "cron") || !strcasecmp(value, "crontab"))
> +		return SCHEDULER_CRON;
> +	else if (!strcasecmp(value, "systemd") ||
> +		 !strcasecmp(value, "systemd-timer"))
> +		return SCHEDULER_SYSTEMD;
> +	else if (!strcasecmp(value, "launchctl"))
> +		return SCHEDULER_LAUNCHCTL;
> +	else if (!strcasecmp(value, "schtasks"))
> +		return SCHEDULER_SCHTASKS;
> +	else
> +		return SCHEDULER_INVALID;
> +}

Good. The systemd stuff can be added in the second patch,
making a clear integration point.

> +static int maintenance_opt_scheduler(const struct option *opt, const char *arg,
> +				     int unset)
> +{
> +	enum scheduler *scheduler = opt->value;
> +
> +	if (unset)
> +		die(_("--no-scheduler is not allowed"));
> +
> +	*scheduler = parse_scheduler(arg);
> +
> +	if (*scheduler == SCHEDULER_INVALID)
> +		die(_("unrecognized --scheduler argument '%s'"), arg);
> +
> +	return 0;
> +}
> +
> +struct maintenance_start_opts {
> +	enum scheduler scheduler;
> +};

This struct that contains only the enum seems confusing to me.
Maybe it will make sense later.

> +static void resolve_auto_scheduler(enum scheduler *scheduler)
> +{
> +	if (*scheduler != SCHEDULER_AUTO)
> +		return;
> +
>  #if defined(__APPLE__)
> -static const char platform_scheduler[] = "launchctl";
> +	*scheduler = SCHEDULER_LAUNCHCTL;
> +	return;
> +
>  #elif defined(GIT_WINDOWS_NATIVE)
> -static const char platform_scheduler[] = "schtasks";
> +	*scheduler = SCHEDULER_SCHTASKS;
> +	return;
> +
> +#elif defined(__linux__)
> +	if (is_systemd_timer_available("systemctl"))
> +		*scheduler = SCHEDULER_SYSTEMD;
> +	else if (is_crontab_available("crontab"))
> +		*scheduler = SCHEDULER_CRON;
> +	else
> +		die(_("neither systemd timers nor crontab are available"));
> +	return;
> +
>  #else
> -static const char platform_scheduler[] = "crontab";
> +	*scheduler = SCHEDULER_CRON;
> +	return;
>  #endif
> +}

This diff looks pretty rough. I see that you are making
systemctl the default for Linux. Ok. This also seems like
it will not be testable in the test suite.

>  
> -static int update_background_schedule(int enable)
> +static void validate_scheduler(enum scheduler scheduler)
>  {
> -	int result;
> -	const char *scheduler = platform_scheduler;
> -	const char *cmd = scheduler;
> +	const char *cmd;
> +
> +	if (scheduler == SCHEDULER_INVALID)
> +		BUG("invalid scheduler");
> +	if (scheduler == SCHEDULER_AUTO)
> +		BUG("resolve_auto_scheduler should have been called before");
> +
> +	cmd = scheduler_fn[scheduler].cmd;
> +	if (!scheduler_fn[scheduler].is_available(cmd))
> +		die(_("%s scheduler is not available"), cmd);
> +}
> +
> +static int update_background_schedule(const struct maintenance_start_opts *opts,
> +				      int enable)
> +{
> +	unsigned int i;
> +	int res, result = 0;
> +	enum scheduler scheduler;
> +	const char *cmd = NULL;
>  	char *testing;
>  	struct lock_file lk;
>  	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
>  
> +	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
> +		return error(_("another process is scheduling background maintenance"));
> +
>  	testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
>  	if (testing) {
>  		char *sep = strchr(testing, ':');
>  		if (!sep)
>  			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
>  		*sep = '\0';
> -		scheduler = testing;
> +		scheduler = parse_scheduler(testing);
>  		cmd = sep + 1;
> +		result = scheduler_fn[scheduler].update_schedule(
> +			enable, get_lock_file_fd(&lk), cmd);
> +		goto done;

I see this 'goto done' is the reason we need to take the lock earlier. The
other option would be to put the 'goto done' after the rollback_lock_file(),
but this is fine, too.

>  	}
>  
> -	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
> -		return error(_("another process is scheduling background maintenance"));
> -
> -	if (!strcmp(scheduler, "launchctl"))
> -		result = launchctl_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> -	else if (!strcmp(scheduler, "schtasks"))
> -		result = schtasks_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> -	else if (!strcmp(scheduler, "crontab"))
> -		result = crontab_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> -	else
> -		die("unknown background scheduler: %s", scheduler);
> +	for (i = 1; i < ARRAY_SIZE(scheduler_fn); i++) {
> +		int enable_scheduler = enable && (opts->scheduler == i);
> +		cmd = scheduler_fn[i].cmd;
> +		if (!scheduler_fn[i].is_available(cmd))
> +			continue;
> +		res = scheduler_fn[i].update_schedule(
> +			enable_scheduler, get_lock_file_fd(&lk), cmd);
> +		if (enable_scheduler)
> +			result = res;
> +	}

This loop is cleaner than the list of else-ifs.

>  
> +done:
>  	rollback_lock_file(&lk);
>  	free(testing);
>  	return result;
>  }
>  
> -static int maintenance_start(void)
> +static const char *const builtin_maintenance_start_usage[] = {
> +	N_("git maintenance start [--scheduler=<scheduler>]"), NULL
> +};
> +
> +static int maintenance_start(int argc, const char **argv, const char *prefix)
>  {
> +	struct maintenance_start_opts opts;

I see you using the struct now and in the helper methods above.
While the creation of the struct looks a little strange now, this
use matches other patterns in this file and is more flexible to
additional options in the future. Thanks.

> +	struct option builtin_maintenance_start_options[] = {
> +		OPT_CALLBACK(
> +			0, "scheduler", &opts.scheduler, N_("scheduler"),
> +			N_("scheduler to use to trigger git maintenance run"),
> +			maintenance_opt_scheduler),

nit: these would typically be aligned with the end of the
OPT_CALLBACK( opener, with the first set of parameters being on
the same line:

		OPT_CALLBACK(0, "scheduler", &opts.scheduler, N_("scheduler"),
			     N_("scheduler to use to trigger 'git maintenance run'"),
			     maintenance_opt_scheduler),

These options frequently run a little long on the line width,
which might have been your motivation in adding an extra line.

> +		OPT_END()
> +	};
> +	memset(&opts, 0, sizeof(opts));
> +
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_maintenance_start_options,
> +			     builtin_maintenance_start_usage, 0);
> +
> +	resolve_auto_scheduler(&opts.scheduler);
> +	validate_scheduler(opts.scheduler);
> +
> +	if (argc > 0)
> +		usage_with_options(builtin_maintenance_start_usage,
> +				   builtin_maintenance_start_options);

nit: "if (argc)" is the more typical pattern in the Git codebase.

Also, this check should come right after parse_options().

>  	if (maintenance_register())
>  		warning(_("failed to add repo to global config"));
> -
> -	return update_background_schedule(1);
> +	return update_background_schedule(&opts, 1);
>  }
>  
>  static int maintenance_stop(void)
>  {
> -	return update_background_schedule(0);
> +	return update_background_schedule(NULL, 0);
>  }
>  
>  static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
> @@ -2027,7 +2354,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
>  	if (!strcmp(argv[1], "run"))
>  		return maintenance_run(argc - 1, argv + 1, prefix);
>  	if (!strcmp(argv[1], "start"))
> -		return maintenance_start();
> +		return maintenance_start(argc - 1, argv + 1, prefix);
>  	if (!strcmp(argv[1], "stop"))
>  		return maintenance_stop();
>  	if (!strcmp(argv[1], "register"))
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 2412d8c5c0..6e6316cd90 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh

I'm not sure how we could achieve it, but it might be good to demonstrate
a use of the --scheduler option here in the test script.

Thanks,
-Stolee
