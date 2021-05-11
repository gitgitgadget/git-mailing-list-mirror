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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE334C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDF5613C1
	for <git@archiver.kernel.org>; Tue, 11 May 2021 14:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhEKOwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 10:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhEKOwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 10:52:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF4EC061761
        for <git@vger.kernel.org>; Tue, 11 May 2021 07:51:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o127so11284025wmo.4
        for <git@vger.kernel.org>; Tue, 11 May 2021 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=inhYCrEv/JMKUzFRjOD7WcfWGGpV9LLSoAILzX21iLo=;
        b=S2ri9PS9Krrng4Ykj1OsEkxqW4mo55R8DhD8rtOcwDN+0KCsmS9MOFjPzhPXmjouaz
         sdb67uUJ/Yt7hkzQ5LWTJVgeTtRdk0T08drk2W8yNkv/cTkhaKdLAKyMZV/4KOZJ8Vk3
         lF87jWm2sbpkCXhY/vKcmdvoOaDb9/tycHZqouEb/BeA0mT+ZxbS6O/9uJptHEl+mDyl
         z/uryqSNx/9MsLB1SmFavNGfwQywjFpzUFEpo7key2h5lbyJt0tXF9xAkwCNjEiZDg/1
         EwcoTeQsDZv4oOpqC9booPZunze7NcN1xl7w3Z+wDThdhDoPuO8VgRhfhhWu2G9p6U03
         B8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=inhYCrEv/JMKUzFRjOD7WcfWGGpV9LLSoAILzX21iLo=;
        b=tSPtdbDIfUfqCcGXY/4CGxjb9j+aIal9lALVf1J/oGY5LC08pmtXeeceVWbJfnthNA
         Sxtiksk3VpmIVEV2HdvSIYD5tEnZJJkbU58/nhQzBs4C+SsHznjZV3Pber6RBg38kcJ7
         XAF7tk4of7GYjnoufnro0Karc2KrZtQBniu9SgACOZrOUL2STdjAuFuK45O+5VCR2oez
         1k743jenOldGQt2hDlgW0kfzrOFCR9yDVC8MkKGhwPCsqdVjrFKfvypAF7AFEM0BsCl6
         Iw95VurKWZ9Bizu5y56CMIylSfjVOr9ToXETaEOdt1IDRRdWnG7ta7qXaz5bzaF8u54E
         wfRA==
X-Gm-Message-State: AOAM5305jWBzOjpYdkU5F3azFOXGTd4EJn/QNsCMJSSWXQ9aSjDqFaqw
        to3ew4jCS2Ooz8bONBFd0QMDrgze7g0=
X-Google-Smtp-Source: ABdhPJyl6yFh1ZUhiu6A9XCugqph/3Erc+9Yu4mLvAXxK89ZLv/YGtogedaZ3k6Ou1mWa9Wxvy3Jbw==
X-Received: by 2002:a1c:f608:: with SMTP id w8mr6006404wmc.44.1620744658922;
        Tue, 11 May 2021 07:50:58 -0700 (PDT)
Received: from [192.168.1.240] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.gmail.com with ESMTPSA id y14sm27428226wrs.64.2021.05.11.07.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 07:50:58 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ba9ba56f-9253-afe5-aab5-514ce8ddb706@gmail.com>
Date:   Tue, 11 May 2021 15:50:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210509213217.449489-2-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lénaïc

I've added some comments about testing

On 09/05/2021 22:32, Lénaïc Huard wrote:
>[...]
> +struct maintenance_start_opts {
> +	enum scheduler scheduler;
> +};
> +
> +static void resolve_auto_scheduler(enum scheduler *scheduler)
> +{
> +	if (*scheduler != SCHEDULER_AUTO)
> +		return;
> +
>   #if defined(__APPLE__)
> -static const char platform_scheduler[] = "launchctl";
> +	*scheduler = SCHEDULER_LAUNCHCTL;
> +	return;
> +
>   #elif defined(GIT_WINDOWS_NATIVE)
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
>   #else
> -static const char platform_scheduler[] = "crontab";
> +	*scheduler = SCHEDULER_CRON;
> +	return;
>   #endif
> +}

As it stands this function is untested and there is no way to test it 
with the current setup. There are two difficulties with testing it (i) 
it uses conditional compilation and (ii) there is no way to fake crontab 
and systemctl with the current test setup. I think we can address the 
latter (see below) and handle the condition compilation issues using 
test prerequisites if necessary.

> -static int update_background_schedule(int enable)
> +static void validate_scheduler(enum scheduler scheduler)
>   {
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
>   	char *testing;
>   	struct lock_file lk;
>   	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
>   
> +	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
> +		return error(_("another process is scheduling background maintenance"));
> +
>   	testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
>   	if (testing) {
>   		char *sep = strchr(testing, ':');
>   		if (!sep)
>   			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
>   		*sep = '\0';
> -		scheduler = testing;
> +		scheduler = parse_scheduler(testing);
>   		cmd = sep + 1;
> +		result = scheduler_fn[scheduler].update_schedule(
> +			enable, get_lock_file_fd(&lk), cmd);
> +		goto done;
>   	}
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

This loop which is responsible for disabling the existing scheduler and 
enabling a new one is completely untested. I think that before this 
patch special casing the testing above still ran the important code, 
however now we fail to test an important aspect of the business logic. 
As we can only fake one command name the current test setup is 
insufficient to fix this. I think the best solution would be to mock 
systemctl, crontab, and the other commands in the test environment.

	mkdir bin &&
	PATH="$(pwd)/bin:$PATH" &&
	test_write_script systemctl <<-\EOF &&
	# Mock systemctl, set FAKE_SYSTEMD=0 in the
	# environment to fake systemctl missing
	case "$*" in
		"--user list-timers") test ${FAKE_SYSTEMD:-1} = 1;
				      exit $?;;
		*) printf "%s\n" "$*";;
	esac	
	EOF
	# and so on for crontab etc

Then it would be possible to test the various values 
--scheduler=<scheduler> including 'auto' (by setting FAKE_SYSTEMD=0 or 
FAKE_CRONTAB=0) and that we disable cron when enabling systemd and vice 
versa. Mocking the commands would also allow us to cleanup the code in 
gc.c as it would no longer need to pass command names around.

> +done:
>   	rollback_lock_file(&lk);
>   	free(testing);
>   	return result;
>   }
>   
> -static int maintenance_start(void)
> +static const char *const builtin_maintenance_start_usage[] = {
> +	N_("git maintenance start [--scheduler=<scheduler>]"), NULL
> +};
> +
> +static int maintenance_start(int argc, const char **argv, const char *prefix)
>   {
> +	struct maintenance_start_opts opts;
> +	struct option builtin_maintenance_start_options[] = {
> +		OPT_CALLBACK(
> +			0, "scheduler", &opts.scheduler, N_("scheduler"),
> +			N_("scheduler to use to trigger git maintenance run"),
> +			maintenance_opt_scheduler),
> +		OPT_END()
> +	};
> +	memset(&opts, 0, sizeof(opts));
> +
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_maintenance_start_options,
> +			     builtin_maintenance_start_usage, 0);

This new command line option is completely untested

Best Wishes

Phillip

> +
> +	resolve_auto_scheduler(&opts.scheduler);
> +	validate_scheduler(opts.scheduler);
> +
> +	if (argc > 0)
> +		usage_with_options(builtin_maintenance_start_usage,
> +				   builtin_maintenance_start_options);
> +
>   	if (maintenance_register())
>   		warning(_("failed to add repo to global config"));
> -
> -	return update_background_schedule(1);
> +	return update_background_schedule(&opts, 1);
>   }
>   
>   static int maintenance_stop(void)
>   {
> -	return update_background_schedule(0);
> +	return update_background_schedule(NULL, 0);
>   }
>   
>   static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
> @@ -2027,7 +2354,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
>   	if (!strcmp(argv[1], "run"))
>   		return maintenance_run(argc - 1, argv + 1, prefix);
>   	if (!strcmp(argv[1], "start"))
> -		return maintenance_start();
> +		return maintenance_start(argc - 1, argv + 1, prefix);
>   	if (!strcmp(argv[1], "stop"))
>   		return maintenance_stop();
>   	if (!strcmp(argv[1], "register"))
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 2412d8c5c0..6e6316cd90 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -20,6 +20,20 @@ test_xmllint () {
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
> +	else
> +		true
> +	fi
> +}
> +
>   test_expect_success 'help text' '
>   	test_expect_code 129 git maintenance -h 2>err &&
>   	test_i18ngrep "usage: git maintenance <subcommand>" err &&
> @@ -615,6 +629,43 @@ test_expect_success 'start and stop Windows maintenance' '
>   	test_cmp expect args
>   '
>   
> +test_expect_success 'start and stop Linux/systemd maintenance' '
> +	write_script print-args <<-\EOF &&
> +	echo $* >>args
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
> +	test_cmp expect args
> +'
> +
>   test_expect_success 'register preserves existing strategy' '
>   	git config maintenance.strategy none &&
>   	git maintenance register &&
> 
