Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCEAC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 01:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7493C6112F
	for <git@archiver.kernel.org>; Mon, 10 May 2021 01:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhEJBVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 21:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhEJBVh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 21:21:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36990C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 18:20:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h20so8325457plr.4
        for <git@vger.kernel.org>; Sun, 09 May 2021 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sXmEFE1Tnt8bef1N+vf5SDpxvTGb6GNoKd/Bz4xXZgU=;
        b=qtTCNMVfpIgpe6Bdbj0NSlOQ4+Z9G7bbAoCKTKPqXC6MbpiznlTyBNq2U1ffTJaQDk
         7EOVfONaSFK6B9DQyk6Bszp93PXFYcZCHgvSrPhZ1ZjPYttt+6Sa0313NXbSLy6S5RUU
         yB6UOcbFsL5zc8wqITE+ckfl27HUNgcaqjaSt32f5zNQqhurd3haufqT0DTGaEAgaYp/
         FzhrgetaD5HdDP4WRtNSJN7BfdDZwpz7LsSOmAgCt48WH4B+sdPMcM5Z3f1qdwGneAfx
         O/eTN5h9KMy/CsDh55nNW6+ZVNQg/BI//NQE7nunO4uJXLPMOoLEs+aw4y1EVEBD26Pm
         5IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sXmEFE1Tnt8bef1N+vf5SDpxvTGb6GNoKd/Bz4xXZgU=;
        b=jFKsuzsf5M1IQozng12AtMqUIMcDmud+vgKEnZhrn657mGVRd5tcFy8Lwd+1D0zTT+
         KIijvyFveWS7jQnTk3eHuqWT2POe+YLK6r9iMowyk+3vUCgBaq9TZdF6UyFJElCC/Wbi
         JUvSG/DQbd/z/jy2Og/LTEVXa/R6MgsXz4ccfO9l8uf+CFb+JhF7I+nqvwAfgx0OweIT
         VGKQZPy88clWC/EH1P9DVwFRvm3hfRnCJkWYPspTrHq06Jdz3z0jN5OTyjBGjW7cHqJ/
         qj0p/UFqsammOPVyOIWMgz2xvG4/Ol4nTJtnsBT8ZkK9AgYmZV0H/0yIdPYELalQLMyS
         QbuQ==
X-Gm-Message-State: AOAM533+rNvUyzv8FOHAvy23RneLZdSC+zvTMvtQoje3FL5pl7qOiwKs
        RscyQF9EoE18XPIwkzau6QiAh+ByT2sVEw==
X-Google-Smtp-Source: ABdhPJxIBxh4jquzWhizwUpGjjHg2Amf5/jPtOrr3NiT5ZzRKpbTWW4eGljbbYNUcRCm7x9qmdp1og==
X-Received: by 2002:a17:90a:5995:: with SMTP id l21mr36880583pji.79.1620609632527;
        Sun, 09 May 2021 18:20:32 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id x90sm17937180pjj.55.2021.05.09.18.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 18:20:32 -0700 (PDT)
Date:   Mon, 10 May 2021 08:20:29 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
Message-ID: <YJiKXRywBhhGXC5Q@danh.dev>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210509213217.449489-2-lenaic@lhuard.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-09 23:32:17+0200, Lénaïc Huard <lenaic@lhuard.fr> wrote:
> The existing mechanism for scheduling background maintenance is done
> through cron. On Linux systems managed by systemd, systemd provides an
> alternative to schedule recurring tasks: systemd timers.
> 
> +static int systemd_timer_enable_unit(int enable,
> +				     enum schedule_priority schedule,
> +				     const char *cmd)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	const char *frequency = get_frequency(schedule);
> +
> +	strvec_split(&child.args, cmd);
> +	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
> +		     "--now", NULL);
> +	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
> +
> +	if (start_command(&child))
> +		die(_("failed to run systemctl"));
> +	return finish_command(&child);
> +}
> +
> +static int systemd_timer_delete_unit_templates(void)
> +{
> +	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
> +	unlink(filename);
> +	free(filename);
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.service");
> +	unlink(filename);
> +	free(filename);
> +
> +	return 0;
> +}
> +
> +static int systemd_timer_delete_units(const char *cmd)
> +{
> +	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, cmd) ||
> +	       systemd_timer_enable_unit(0, SCHEDULE_DAILY, cmd) ||
> +	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, cmd) ||
> +	       systemd_timer_delete_unit_templates();
> +}

I'm not using any systemd-based distros. However, isn't this try to
enable all systemd's {hourly,daily,weekly} user's timer, then delete
the templates?^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W^W

Argh, we're disabling those systemd timer units first, by passing 0 as
first argument of systemd_timer_delete_units.

The fact that I read that twice, and still wrote down above reply
makes me think that above code is not self-explanatory enough.
May we switch to something else? Let's say using enum?


> +static int systemd_timer_write_unit_templates(const char *exec_path)
> +{
> +	char *filename;
> +	FILE *file;
> +	const char *unit;
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.timer");
> +	if (safe_create_leading_directories(filename))
> +		die(_("failed to create directories for '%s'"), filename);

This message is used by other codes, less works for translator, nice!

> +	file = xfopen(filename, "w");
> +	free(filename);

I'm sure if we should use FREE_AND_NULL(filename) instead?
Since, filename will be reused later.

> +
> +	unit = "# This file was created and is maintained by Git.\n"
> +	       "# Any edits made in this file might be replaced in the future\n"
> +	       "# by a Git command.\n"
> +	       "\n"
> +	       "[Unit]\n"
> +	       "Description=Optimize Git repositories data\n"
> +	       "\n"
> +	       "[Timer]\n"
> +	       "OnCalendar=%i\n"
> +	       "Persistent=true\n"
> +	       "\n"
> +	       "[Install]\n"
> +	       "WantedBy=timers.target\n";
> +	fputs(unit, file);
> +	fclose(file);
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.service");
> +	if (safe_create_leading_directories(filename))
> +		die(_("failed to create directories for '%s'"), filename);
> +	file = xfopen(filename, "w");
> +	free(filename);
> +
> +	unit = "# This file was created and is maintained by Git.\n"
> +	       "# Any edits made in this file might be replaced in the future\n"
> +	       "# by a Git command.\n"
> +	       "\n"
> +	       "[Unit]\n"
> +	       "Description=Optimize Git repositories data\n"
> +	       "\n"
> +	       "[Service]\n"
> +	       "Type=oneshot\n"
> +	       "ExecStart=\"%1$s/git\" --exec-path=\"%1$s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
> +	       "LockPersonality=yes\n"
> +	       "MemoryDenyWriteExecute=yes\n"
> +	       "NoNewPrivileges=yes\n"
> +	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6\n"
> +	       "RestrictNamespaces=yes\n"
> +	       "RestrictRealtime=yes\n"
> +	       "RestrictSUIDSGID=yes\n"
> +	       "SystemCallArchitectures=native\n"
> +	       "SystemCallFilter=@system-service\n";
> +	fprintf(file, unit, exec_path);

I think others have strong opinion on not using "%1$s",
and prefer simple "%s" and using "exec_path" twice instead.

> +	fclose(file);
> +
> +	return 0;
> +}
> +
> +static int systemd_timer_setup_units(const char *cmd)
> +{
> +	const char *exec_path = git_exec_path();
> +
> +	return systemd_timer_write_unit_templates(exec_path) ||
> +	       systemd_timer_enable_unit(1, SCHEDULE_HOURLY, cmd) ||
> +	       systemd_timer_enable_unit(1, SCHEDULE_DAILY, cmd) ||
> +	       systemd_timer_enable_unit(1, SCHEDULE_WEEKLY, cmd);
> +}
> +
> +static int systemd_timer_update_schedule(int run_maintenance, int fd,
> +					 const char *cmd)
> +{
> +	if (run_maintenance)
> +		return systemd_timer_setup_units(cmd);
> +	else
> +		return systemd_timer_delete_units(cmd);
> +}
> +
> +enum scheduler {
> +	SCHEDULER_INVALID = -1,
> +	SCHEDULER_AUTO = 0,
> +	SCHEDULER_CRON = 1,
> +	SCHEDULER_SYSTEMD = 2,
> +	SCHEDULER_LAUNCHCTL = 3,
> +	SCHEDULER_SCHTASKS = 4,

I think explicitly writing down values doesn't make things clearer,
-1 would be nice, not a strong opinion, though.

Anyway, would it be better to move those type declaration to top of
file?

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
> +
> +static int maintenance_opt_scheduler(const struct option *opt, const char *arg,
> +				     int unset)
> +{
> +	enum scheduler *scheduler = opt->value;
> +
> +	if (unset)
> +		die(_("--no-scheduler is not allowed"));

I think it's better to use OPT_CALLBACK_F in the options list and
we will write below code instead:

	BUG_ON_OPT_NEG(unset)

> +
> +	*scheduler = parse_scheduler(arg);
> +
> +	if (*scheduler == SCHEDULER_INVALID)
> +		die(_("unrecognized --scheduler argument '%s'"), arg);

Most of other callbacks do this instead:

	return error(_("messsage.... '%s'"), arg);

> +
> +	return 0;
> +}
> +
> +struct maintenance_start_opts {
> +	enum scheduler scheduler;
> +};
> +
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
> +	struct option builtin_maintenance_start_options[] = {
> +		OPT_CALLBACK(
> +			0, "scheduler", &opts.scheduler, N_("scheduler"),
> +			N_("scheduler to use to trigger git maintenance run"),
> +			maintenance_opt_scheduler),

Following up my comment above, we're better to use:

		OPT_CALLBACK_F(0, "scheduler", &opts.scheduler, N_("scheduler"),
			N_("............"),
			PARSE_OPT_NONEG, maintenance_opt_scheduler),

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
> +
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
> @@ -20,6 +20,20 @@ test_xmllint () {
>  	fi
>  }
>  
> +test_lazy_prereq SYSTEMD_ANALYZE '
> +	systemd-analyze --help >out &&
> +	grep verify out
> +'
> +
> +test_systemd_analyze_verify () {
> +	if test_have_prereq SYSTEMD_ANALYZE
> +	then
> +		systemd-analyze verify "$@"
> +	else
> +		true

The "else" leg is not necessary.

> +	fi
> +}
> +
>  test_expect_success 'help text' '
>  	test_expect_code 129 git maintenance -h 2>err &&
>  	test_i18ngrep "usage: git maintenance <subcommand>" err &&
> @@ -615,6 +629,43 @@ test_expect_success 'start and stop Windows maintenance' '
>  	test_cmp expect args
>  '
>  
> +test_expect_success 'start and stop Linux/systemd maintenance' '
> +	write_script print-args <<-\EOF &&
> +	echo $* >>args

To avoid any possible incompatibility with zillion echo implementation
out there. printf should be prefered over echo. Not a in this test
case, however, it costs us nothing anyway.

	printf "%s\n" "$*"

> +	EOF
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemd:./print-args" git maintenance start &&
> +
> +	# start registers the repo
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> +
> +	test_systemd_analyze_verify "$HOME/.config/systemd/user/git-maintenance@.service" &&
> +
> +	rm -f expect &&
> +	for frequency in hourly daily weekly
> +	do
> +		echo "--user enable --now git-maintenance@${frequency}.timer" >>expect || return 1
> +	done &&

And here, we can have a nicer syntax with printf:

	printf "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&

With printf, we don't even need "rm -f expect" above.

> +	test_cmp expect args &&
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemd:./print-args" git maintenance stop &&
> +
> +	# stop does not unregister the repo
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> +
> +	test_path_is_missing "$HOME/.config/systemd/user/git-maintenance@.timer" &&
> +	test_path_is_missing "$HOME/.config/systemd/user/git-maintenance@.service" &&
> +
> +	rm -f expect &&
> +	for frequency in hourly daily weekly
> +	do
> +		echo "--user disable --now git-maintenance@${frequency}.timer" >>expect || return 1
> +	done &&

Ditto.

All of this was written without testing, because I don't have any
systemd based system near my hand, right now.

So, please take it with a grain of salt.


-- 
Danh
