Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F060C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08965613B9
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhFIPDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbhFIPDb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 11:03:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E5C06175F
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 08:01:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e11so15668669wrg.3
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ir7p4jcQfkBgKZTe5nRDccLX4ua5g01EnsBgSCgy4w=;
        b=s+3+XD2suBwTEcbAYir0NkwnPTSF0KegK33T1U6gBkguKhOM9zlJBXGr5a3RR5RmqN
         X1RdD8KlxgdUcrZAK5f6rk6ZVaYWw2T9qXAMRMB9XB3wkSRbM8EgHijoppnI64lOMj3n
         yQMUb+VuOeV99xt+kpYAiyOd0Zq34uayTKmq5Ctr7cYhZ8B8P3G7FXjVfI/AKZCRO4vr
         O2jqUpLswmqudPa8GzJQJ+asui1oZxl33NJXYJXqLXl/0RCMfUZ62UbuTizjgjDWyKPr
         wvHNVWIwGwDetZTZveFY17TX7RMLmvri1IVQ/hljUY32vJzH6qpuiQXXwBlRU+JQIDfZ
         VheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3ir7p4jcQfkBgKZTe5nRDccLX4ua5g01EnsBgSCgy4w=;
        b=M8/chdF8InVxG326bG+T1E93+jvCtQ/AblGK5cI991lCNWIuVJVNf78ZH2fzj5Xn2G
         EnmmfZgC0VnJJQfBxNUKJwfQRmsVfqgkgqRqxV7fVPizyb4vF8AurXHRxzXivqNwScgO
         1ZOKt5h5DaNg/jeLbaBzELtjrp4pFBeFzktU7CK9tHEfg5ILMpHUxurGegm0Nuabn9Us
         iX41d8QhYmp3W15wbnia3dInWwCcudQbYpM9udfQd/GluUOXKYB3DRL2I2Z6jPdrTidT
         lP4zVwhNItlpdf1GYuqFpEzzK/4YchrQZQ+VrKaruCJuZcIi2Q/LnV3q+aWLwOcR2XOT
         pmKA==
X-Gm-Message-State: AOAM532FJcfLYFsZV13M+IRYor8QDaGCzu7lNjCU5OxFzCc408quRNee
        DFgF4VrByDG+4keKFDkkYxU=
X-Google-Smtp-Source: ABdhPJxjx3Uwzq9zzU5QVX0qXQw7PB5F1cVpHZb3jGHsQcNeIWboPwGW23qFUphrwPMA7JZWvdI7Bg==
X-Received: by 2002:a5d:5082:: with SMTP id a2mr233818wrt.199.1623250883043;
        Wed, 09 Jun 2021 08:01:23 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id r7sm8586755wma.9.2021.06.09.08.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:01:22 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/3] maintenance: add support for systemd timers on
 Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210608134000.663398-1-lenaic@lhuard.fr>
 <20210608134000.663398-4-lenaic@lhuard.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <959c56a3-3290-b277-5d30-e16244ae44bf@gmail.com>
Date:   Wed, 9 Jun 2021 16:01:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608134000.663398-4-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/06/2021 14:40, Lénaïc Huard wrote:
> The existing mechanism for scheduling background maintenance is done
> through cron. On Linux systems managed by systemd, systemd provides an
> alternative to schedule recurring tasks: systemd timers.
> 
> The main motivations to implement systemd timers in addition to cron
> are:
> * cron is optional and Linux systems running systemd might not have it
>    installed.
> * The execution of `crontab -l` can tell us if cron is installed but not
>    if the daemon is actually running.
> * With systemd, each service is run in its own cgroup and its logs are
>    tagged by the service inside journald. With cron, all scheduled tasks
>    are running in the cron daemon cgroup and all the logs of the
>    user-scheduled tasks are pretended to belong to the system cron
>    service.
>    Concretely, a user that doesn’t have access to the system logs won’t
>    have access to the log of their own tasks scheduled by cron whereas
>    they will have access to the log of their own tasks scheduled by
>    systemd timer.
>    Although `cron` attempts to send email, that email may go unseen by
>    the user because these days, local mailboxes are not heavily used
>    anymore.
> 
> In order to schedule git maintenance, we need two unit template files:
> * ~/.config/systemd/user/git-maintenance@.service
>    to define the command to be started by systemd and
> * ~/.config/systemd/user/git-maintenance@.timer
>    to define the schedule at which the command should be run.
> 
> Those units are templates that are parameterized by the frequency.
> 
> Based on those templates, 3 timers are started:
> * git-maintenance@hourly.timer
> * git-maintenance@daily.timer
> * git-maintenance@weekly.timer
> 
> The command launched by those three timers are the same as with the
> other scheduling methods:
> 
> /path/to/git for-each-repo --exec-path=/path/to
> --config=maintenance.repo maintenance run --schedule=%i
> 
> with the full path for git to ensure that the version of git launched
> for the scheduled maintenance is the same as the one used to run
> `maintenance start`.
> 
> The timer unit contains `Persistent=true` so that, if the computer is
> powered down when a maintenance task should run, the task will be run
> when the computer is back powered on.
> 
> Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
> ---
>   Documentation/git-maintenance.txt |  57 +++++++-
>   builtin/gc.c                      | 228 ++++++++++++++++++++++++++++++
>   t/t7900-maintenance.sh            |  67 ++++++++-
>   3 files changed, 342 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 07065ed4f3..7b7dbbbca9 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -179,16 +179,19 @@ OPTIONS
>   	`maintenance.<task>.enabled` configured as `true` are considered.
>   	See the 'TASKS' section for the list of accepted `<task>` values.
>   
> ---scheduler=auto|crontab|launchctl|schtasks::
> +--scheduler=auto|crontab|systemd-timer|launchctl|schtasks::
>   	When combined with the `start` subcommand, specify the scheduler
>   	to use to run the hourly, daily and weekly executions of
>   	`git maintenance run`.
>   	The possible values for `<scheduler>` depend on the system: `crontab`
> -	is available on POSIX systems, `launchctl` is available on
> -	MacOS and `schtasks` is available on Windows.
> +	is available on POSIX systems, `systemd-timer` is available on Linux
> +	systems, `launchctl` is available on MacOS and `schtasks` is available
> +	on Windows.
>   	By default or when `auto` is specified, a suitable scheduler for
>   	the system is used. On MacOS, `launchctl` is used. On Windows,
> -	`schtasks` is used. On all other systems, `crontab` is used.
> +	`schtasks` is used. On Linux, `systemd-timer` is used if user systemd
> +	timers are available, otherwise, `crontab` is used. On all other systems,
> +	`crontab` is used.
>   
>   
>   TROUBLESHOOTING
> @@ -288,6 +291,52 @@ schedule to ensure you are executing the correct binaries in your
>   schedule.
>   
>   
> +BACKGROUND MAINTENANCE ON LINUX SYSTEMD SYSTEMS
> +-----------------------------------------------
> +
> +While Linux supports `cron`, depending on the distribution, `cron` may
> +be an optional package not necessarily installed. On modern Linux
> +distributions, systemd timers are superseding it.
> +
> +If user systemd timers are available, they will be used as a replacement
> +of `cron`.
> +
> +In this case, `git maintenance start` will create user systemd timer units
> +and start the timers. The current list of user-scheduled tasks can be found
> +by running `systemctl --user list-timers`. The timers written by `git
> +maintenance start` are similar to this:
> +
> +-----------------------------------------------------------------------
> +$ systemctl --user list-timers
> +NEXT                         LEFT          LAST                         PASSED     UNIT                         ACTIVATES
> +Thu 2021-04-29 19:00:00 CEST 42min left    Thu 2021-04-29 18:00:11 CEST 17min ago  git-maintenance@hourly.timer git-maintenance@hourly.service
> +Fri 2021-04-30 00:00:00 CEST 5h 42min left Thu 2021-04-29 00:00:11 CEST 18h ago    git-maintenance@daily.timer  git-maintenance@daily.service
> +Mon 2021-05-03 00:00:00 CEST 3 days left   Mon 2021-04-26 00:00:11 CEST 3 days ago git-maintenance@weekly.timer git-maintenance@weekly.service
> +-----------------------------------------------------------------------
> +
> +One timer is registered for each `--schedule=<frequency>` option.
> +
> +The definition of the systemd units can be inspected in the following files:
> +
> +-----------------------------------------------------------------------
> +~/.config/systemd/user/git-maintenance@.timer
> +~/.config/systemd/user/git-maintenance@.service
> +~/.config/systemd/user/timers.target.wants/git-maintenance@hourly.timer
> +~/.config/systemd/user/timers.target.wants/git-maintenance@daily.timer
> +~/.config/systemd/user/timers.target.wants/git-maintenance@weekly.timer
> +-----------------------------------------------------------------------
> +
> +`git maintenance start` will overwrite these files and start the timer
> +again with `systemctl --user`, so any customization should be done by
> +creating a drop-in file, i.e. a `.conf` suffixed file in the
> +`~/.config/systemd/user/git-maintenance@.service.d` directory.
> +
> +`git maintenance stop` will stop the user systemd timers and delete
> +the above mentioned files.
> +
> +For more details, see `systemd.timer(5)`.
> +
> +
>   BACKGROUND MAINTENANCE ON MACOS SYSTEMS
>   ---------------------------------------
>   
> diff --git a/builtin/gc.c b/builtin/gc.c
> index f2a81ecb44..5fe416c903 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2040,10 +2040,221 @@ static int crontab_update_schedule(int run_maintenance, int fd)
>   	return result;
>   }
>   
> +#ifdef __linux__
> +
> +static int real_is_systemd_timer_available(void)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	strvec_pushl(&child.args, "systemctl", "--user", "list-timers", NULL);
> +	child.no_stdin = 1;
> +	child.no_stdout = 1;
> +	child.no_stderr = 1;
> +	child.silent_exec_failure = 1;
> +
> +	if (start_command(&child))
> +		return 0;
> +	if (finish_command(&child))
> +		return 0;
> +	return 1;
> +}
> +
> +#else
> +
> +static int real_is_systemd_timer_available(void)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
> +static int is_systemd_timer_available(void)
> +{
> +	const char *cmd = "systemctl";
> +	int is_available;
> +
> +	if (get_schedule_cmd(&cmd, &is_available))
> +		return is_available;
> +
> +	return real_is_systemd_timer_available();
> +}
> +
> +static char *xdg_config_home_systemd(const char *filename)
> +{
> +	return xdg_config_home_for("systemd/user", filename);
> +}
> +
> +static int systemd_timer_enable_unit(int enable,
> +				     enum schedule_priority schedule)
> +{
> +	const char *cmd = "systemctl";
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	const char *frequency = get_frequency(schedule);
> +
> +	/*
> +	 * Disabling the systemd unit while it is already disabled makes
> +	 * systemctl print an error.
> +	 * Let's ignore it since it means we already are in the expected state:
> +	 * the unit is disabled.
> +	 *
> +	 * On the other hand, enabling a systemd unit which is already enabled
> +	 * produces no error.
> +	 */
> +	if (!enable)
> +		child.no_stderr = 1;
> +
> +	get_schedule_cmd(&cmd, NULL);
> +	strvec_split(&child.args, cmd);
> +	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
> +		     "--now", NULL);
> +	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
> +
> +	if (start_command(&child))
> +		return error(_("failed to start systemctl"));
> +	if (finish_command(&child))
> +		/*
> +		 * Disabling an already disabled systemd unit makes
> +		 * systemctl fail.
> +		 * Let's ignore this failure.
> +		 *
> +		 * Enabling an enabled systemd unit doesn't fail.
> +		 */
> +		if (enable)
> +			return error(_("failed to run systemctl"));
> +	return 0;
> +}
> +
> +static int systemd_timer_delete_unit_templates(void)
> +{
> +	int ret = 0;
> +	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
> +	if(unlink(filename) && !is_missing_file_error(errno))
> +		ret = error_errno(_("failed to delete '%s'"), filename);
> +	FREE_AND_NULL(filename);
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.service");
> +	if(unlink(filename) && !is_missing_file_error(errno))
> +		ret = error_errno(_("failed to delete '%s'"), filename);
> +
> +	free(filename);
> +	return ret;
> +}
> +
> +static int systemd_timer_delete_units(void)
> +{
> +	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
> +	       systemd_timer_enable_unit(0, SCHEDULE_DAILY) ||
> +	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY) ||
> +	       systemd_timer_delete_unit_templates();
> +}
> +
> +static int systemd_timer_write_unit_templates(const char *exec_path)
> +{
> +	char *filename;
> +	FILE *file;
> +	const char *unit;
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.timer");
> +	if (safe_create_leading_directories(filename)) {
> +		error(_("failed to create directories for '%s'"), filename);
> +		goto error;
> +	}
> +	file = fopen_or_warn(filename, "w");
> +	if (file == NULL)
> +		goto error;
> +	FREE_AND_NULL(filename);
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
> +	if (fputs(unit, file) == EOF) {
> +		error(_("failed to write to '%s'"), filename);
> +		fclose(file);
> +		goto error;
> +	}
> +	if (fclose(file) == EOF) {
> +		error_errno(_("failed to flush '%s'"), filename);
> +		goto error;
> +	}
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.service");
> +	file = fopen_or_warn(filename, "w");
> +	if (file == NULL)
> +		goto error;
> +	FREE_AND_NULL(filename);
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
> +	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
> +	       "LockPersonality=yes\n"
> +	       "MemoryDenyWriteExecute=yes\n"
> +	       "NoNewPrivileges=yes\n"
> +	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6\n"
> +	       "RestrictNamespaces=yes\n"
> +	       "RestrictRealtime=yes\n"
> +	       "RestrictSUIDSGID=yes\n"
> +	       "SystemCallArchitectures=native\n"
> +	       "SystemCallFilter=@system-service\n";
> +	if (fprintf(file, unit, exec_path, exec_path) < 0) {
> +		error(_("failed to write to '%s'"), filename);
> +		fclose(file);
> +		goto error;
> +	}
> +	if (fclose(file) == EOF) {
> +		error_errno(_("failed to flush '%s'"), filename);
> +		goto error;
> +	}
> +	return 0;
> +
> +error:
> +	free(filename);
> +	systemd_timer_delete_unit_templates();

One small comment just to show I have read the patches - I think 
systemd_timer_delete_unit_templates() ends up being called twice if we 
fail to write one of the template files as systemd_timer_setup_units() 
calls it if this function fails. I don't think this matters and there is 
no need to change it - from a future maintenance perspective it is 
probably safer to leave it as is.

Best Wishes

Phillip

> +	return -1;
> +}
> +
> +static int systemd_timer_setup_units(void)
> +{
> +	const char *exec_path = git_exec_path();
> +
> +	int ret = systemd_timer_write_unit_templates(exec_path) ||
> +	          systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
> +	          systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
> +	          systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);
> +	if (ret)
> +		systemd_timer_delete_units();
> +	return ret;
> +}
> +
> +static int systemd_timer_update_schedule(int run_maintenance, int fd)
> +{
> +	if (run_maintenance)
> +		return systemd_timer_setup_units();
> +	else
> +		return systemd_timer_delete_units();
> +}
> +
>   enum scheduler {
>   	SCHEDULER_INVALID = -1,
>   	SCHEDULER_AUTO,
>   	SCHEDULER_CRON,
> +	SCHEDULER_SYSTEMD,
>   	SCHEDULER_LAUNCHCTL,
>   	SCHEDULER_SCHTASKS,
>   };
> @@ -2058,6 +2269,11 @@ static const struct {
>   		.is_available = is_crontab_available,
>   		.update_schedule = crontab_update_schedule,
>   	},
> +	[SCHEDULER_SYSTEMD] = {
> +		.name = "systemctl",
> +		.is_available = is_systemd_timer_available,
> +		.update_schedule = systemd_timer_update_schedule,
> +	},
>   	[SCHEDULER_LAUNCHCTL] = {
>   		.name = "launchctl",
>   		.is_available = is_launchctl_available,
> @@ -2078,6 +2294,9 @@ static enum scheduler parse_scheduler(const char *value)
>   		return SCHEDULER_AUTO;
>   	else if (!strcasecmp(value, "cron") || !strcasecmp(value, "crontab"))
>   		return SCHEDULER_CRON;
> +	else if (!strcasecmp(value, "systemd") ||
> +		 !strcasecmp(value, "systemd-timer"))
> +		return SCHEDULER_SYSTEMD;
>   	else if (!strcasecmp(value, "launchctl"))
>   		return SCHEDULER_LAUNCHCTL;
>   	else if (!strcasecmp(value, "schtasks"))
> @@ -2116,6 +2335,15 @@ static void resolve_auto_scheduler(enum scheduler *scheduler)
>   	*scheduler = SCHEDULER_SCHTASKS;
>   	return;
>   
> +#elif defined(__linux__)
> +	if (is_systemd_timer_available())
> +		*scheduler = SCHEDULER_SYSTEMD;
> +	else if (is_crontab_available())
> +		*scheduler = SCHEDULER_CRON;
> +	else
> +		die(_("neither systemd timers nor crontab are available"));
> +	return;
> +
>   #else
>   	*scheduler = SCHEDULER_CRON;
>   	return;
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index b36b7f5fb0..b289cae6b9 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -20,6 +20,18 @@ test_xmllint () {
>   	fi
>   }
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
> +	fi
> +}
> +
>   test_expect_success 'help text' '
>   	test_expect_code 129 git maintenance -h 2>err &&
>   	test_i18ngrep "usage: git maintenance <subcommand>" err &&
> @@ -634,15 +646,56 @@ test_expect_success 'start and stop Windows maintenance' '
>   	test_cmp expect args
>   '
>   
> +test_expect_success 'start and stop Linux/systemd maintenance' '
> +	write_script print-args <<-\EOF &&
> +	printf "%s\n" "$*" >>args
> +	EOF
> +
> +	XDG_CONFIG_HOME="$PWD" &&
> +	export XDG_CONFIG_HOME &&
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance start --scheduler=systemd-timer &&
> +
> +	# start registers the repo
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> +
> +	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
> +
> +	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
> +	test_cmp expect args &&
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance stop &&
> +
> +	# stop does not unregister the repo
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> +
> +	test_path_is_missing "systemd/user/git-maintenance@.timer" &&
> +	test_path_is_missing "systemd/user/git-maintenance@.service" &&
> +
> +	printf -- "--user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
> +	test_cmp expect args
> +'
> +
>   test_expect_success 'start and stop when several schedulers are available' '
>   	write_script print-args <<-\EOF &&
>   	printf "%s\n" "$*" | sed "s:gui/[0-9][0-9]*:gui/[UID]:; s:\(schtasks /create .* /xml\).*:\1:;" >>args
>   	EOF
>   
>   	rm -f args &&
> -	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=launchctl &&
> -	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=systemd-timer &&
> +	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
>   		hourly daily weekly >expect &&
> +	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
> +		hourly daily weekly >>expect &&
> +	printf -- "systemctl --user enable --now git-maintenance@%s.timer\n" hourly daily weekly >>expect &&
> +	test_cmp expect args &&
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=launchctl &&
> +	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
> +	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
> +		hourly daily weekly >>expect &&
>   	for frequency in hourly daily weekly
>   	do
>   		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
> @@ -652,17 +705,19 @@ test_expect_success 'start and stop when several schedulers are available' '
>   	test_cmp expect args &&
>   
>   	rm -f args &&
> -	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=schtasks &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=schtasks &&
> +	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
>   	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
> -		hourly daily weekly >expect &&
> +		hourly daily weekly >>expect &&
>   	printf "schtasks /create /tn Git Maintenance (%s) /f /xml\n" \
>   		hourly daily weekly >>expect &&
>   	test_cmp expect args &&
>   
>   	rm -f args &&
> -	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance stop &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance stop &&
> +	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
>   	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
> -		hourly daily weekly >expect &&
> +		hourly daily weekly >>expect &&
>   	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
>   		hourly daily weekly >>expect &&
>   	test_cmp expect args
> 
