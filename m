Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B37C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BA821741
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjjaBihF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgIHTjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgIHPzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 11:55:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E21C0612A6
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 06:07:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e33so10022152pgm.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5JDXnmiZ3KT9K+DwmYweEGlu8Ft/PcX3PxTJWAn7UqM=;
        b=AjjaBihFoWTWcUZpDY67CHKc//BfVPEHk44D8YmBu2LESHW/b96qOPlIPbMHtpYU6C
         w3cjZXYGqJ8ChYcIzDgGmZwiUqRHfOvjzCJMwzT+OCadBlT7BxIrjY9j9vtC5yJj3o1+
         WPvASDwoPCqNJfW7FcrWsmzVzMLJzmYuY4vM1g7j4lnsHJpuf+GvDcgF/+DgbnuF+8Eb
         byIw2G2BG7YBJ8jeZIV3mj/9GU0+psKGH/W+CsE2tQaG2S0APx9eg8mXb8eCzF07rAHc
         6E4HCRJN68Vq32SsK6tAWkfD9Ii4bKcXMaURhiVdwG1fBAwasgrfmt/An1p1hAU0y8nh
         mYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5JDXnmiZ3KT9K+DwmYweEGlu8Ft/PcX3PxTJWAn7UqM=;
        b=Olyao1hmFMa0zWFKNGLjvsm6LbIvRkDoS8VfPPeon2WwgGMjWU/YmGg1m7/r5azfZk
         BnucnBVIdZLKEci32zaygdpr4c9LQLj+bTZ8cDrgwJ/U/vXuahbyayPBgFPmdVffW1QU
         kHM2ETbkDCXfHO9R9sSt5lZI/d8ZqAssv0W9B577CurUp4wfbIJirYag4XpPMY63iLin
         a0B9fAii/OTfsphFfukxLe/4IefFOVDy9YZYC7qBE+lNzKDiq0s+HBVs2xmI8k5njBkw
         U7XNGjjp65zlp5WSYx2NHxBraD0prtj+g73tGVDYz7aT6+qaGNfZ8JcMRuqkT8gfUbaV
         DJiQ==
X-Gm-Message-State: AOAM533SDtUAAtGl9nl0F2c3k0HvdSAsS7TUYyUh1TqpZJx11dnnbzR9
        QunSVjsVvZ687pe8VcUGUVE=
X-Google-Smtp-Source: ABdhPJx/7S7uPDE4vRdmQxFFXUJtHb4InyH7sIRtRoYEJjX2q4WoX1zTUDi0lq3TWaXNhFZqKc/W/w==
X-Received: by 2002:a17:902:ee03:: with SMTP id z3mr24159127plb.68.1599570474520;
        Tue, 08 Sep 2020 06:07:54 -0700 (PDT)
Received: from localhost ([2402:800:63a8:ba63:875b:77ee:3774:2c12])
        by smtp.gmail.com with ESMTPSA id l22sm18985146pfc.27.2020.09.08.06.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:07:53 -0700 (PDT)
Date:   Tue, 8 Sep 2020 20:07:49 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/7] maintenance: add --schedule option and config
Message-ID: <20200908130738.GB25593@danh.dev>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <1783e80b8d3b8361d1d62947a49ba584685dacc4.1599234126.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1783e80b8d3b8361d1d62947a49ba584685dacc4.1599234126.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-04 15:42:01+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> A user may want to run certain maintenance tasks based on frequency, not
> conditions given in the repository. For example, the user may want to

Hm, sorry but I couldn't decipher "not conditions" here. :|

> perform a 'prefetch' task every hour, or 'gc' task every day. To assist,

I think it's better to say: "To assist those users", at least it's
easier to read for non-native English like me.

> update the 'git maintenance run' command to include a
> '--schedule=<frequency>' option. The allowed frequencies are 'hourly',

So, we have "--schedule=" here, ...

> 'daily', and 'weekly'. These values are also allowed in a new config
> value 'maintenance.<task>.schedule'.
> 
> The 'git maintenance run --schedule=<frequency>' checks the '*.schedule'

and here, ...

> config value for each enabled task to see if the configured frequency is
> at least as frequent as the frequency from the '--schedule' argument. We
> use the following order, for full clarity:
> 
> 	'hourly' > 'daily' > 'weekly'
> 
> Use new 'enum schedule_priority' to track these values numerically.
> 
> The following cron table would run the scheduled tasks with the correct
> frequencies:
> 
>   0 1-23 * * *    git -C <repo> maintenance run --scheduled=hourly
>   0 0    * * 1-6  git -C <repo> maintenance run --scheduled=daily
>   0 0    * * 0    git -C <repo> maintenance run --scheduled=weekly

but it's spelt with "--scheduled=", here and below, mispell, I guess.

Reading the patch, it looks like "--scheduled=" is mispelt.

> This cron schedule will run --scheduled=hourly every hour except at
> midnight. This avoids a concurrent run with the --scheduled=daily that
> runs at midnight every day except the first day of the week. This avoids
> a concurrent run with the --scheduled=weekly that runs at midnight on
> the first day of the week. Since --scheduled=daily also runs the
> 'hourly' tasks and --scheduled=weekly runs the 'hourly' and 'daily'
> tasks, we will still see all tasks run with the proper frequencies.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config/maintenance.txt |  5 +++
>  Documentation/git-maintenance.txt    | 13 +++++-
>  builtin/gc.c                         | 67 +++++++++++++++++++++++++---
>  t/t7900-maintenance.sh               | 40 +++++++++++++++++
>  4 files changed, 119 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
> index 06db758172..70585564fa 100644
> --- a/Documentation/config/maintenance.txt
> +++ b/Documentation/config/maintenance.txt
> @@ -10,6 +10,11 @@ maintenance.<task>.enabled::
>  	`--task` option exists. By default, only `maintenance.gc.enabled`
>  	is true.
>  
> +maintenance.<task>.schedule::
> +	This config option controls whether or not the given `<task>` runs
> +	during a `git maintenance run --schedule=<frequency>` command. The
> +	value must be one of "hourly", "daily", or "weekly".
> +
>  maintenance.commit-graph.auto::
>  	This integer config option controls how often the `commit-graph` task
>  	should be run as part of `git maintenance run --auto`. If zero, then
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index b44efb05a3..3af5907b01 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -107,7 +107,18 @@ OPTIONS
>  	only if certain thresholds are met. For example, the `gc` task
>  	runs when the number of loose objects exceeds the number stored
>  	in the `gc.auto` config setting, or when the number of pack-files
> -	exceeds the `gc.autoPackLimit` config setting.
> +	exceeds the `gc.autoPackLimit` config setting. Not compatible with
> +	the `--schedule` option.
> +
> +--schedule::
> +	When combined with the `run` subcommand, run maintenance tasks
> +	only if certain time conditions are met, as specified by the
> +	`maintenance.<task>.schedule` config value for each `<task>`.
> +	This config value specifies a number of seconds since the last
> +	time that task ran, according to the `maintenance.<task>.lastRun`
> +	config value. The tasks that are tested are those provided by
> +	the `--task=<task>` option(s) or those with
> +	`maintenance.<task>.enabled` set to true.
>  
>  --quiet::
>  	Do not report progress or other information over `stderr`.
> diff --git a/builtin/gc.c b/builtin/gc.c
> index f8459df04c..85a3370692 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -704,14 +704,51 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static const char * const builtin_maintenance_run_usage[] = {
> -	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>]"),
> +static const char *const builtin_maintenance_run_usage[] = {
> +	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>] [--schedule]"),
>  	NULL
>  };
>  
> +enum schedule_priority {
> +	SCHEDULE_NONE = 0,
> +	SCHEDULE_WEEKLY = 1,
> +	SCHEDULE_DAILY = 2,
> +	SCHEDULE_HOURLY = 3,
> +};
> +
> +static enum schedule_priority parse_schedule(const char *value)
> +{
> +	if (!value)
> +		return SCHEDULE_NONE;
> +	if (!strcasecmp(value, "hourly"))
> +		return SCHEDULE_HOURLY;
> +	if (!strcasecmp(value, "daily"))
> +		return SCHEDULE_DAILY;
> +	if (!strcasecmp(value, "weekly"))
> +		return SCHEDULE_WEEKLY;
> +	return SCHEDULE_NONE;
> +}
> +
> +static int maintenance_opt_schedule(const struct option *opt, const char *arg,
> +				    int unset)
> +{
> +	enum schedule_priority *priority = opt->value;
> +
> +	if (unset)
> +		die(_("--no-schedule is not allowed"));
> +
> +	*priority = parse_schedule(arg);
> +
> +	if (!*priority)
> +		die(_("unrecognized --schedule argument '%s'"), arg);
> +
> +	return 0;
> +}
> +
>  struct maintenance_run_opts {
>  	int auto_flag;
>  	int quiet;
> +	enum schedule_priority schedule;
>  };
>  
>  /* Remember to update object flag allocation in object.h */
> @@ -1159,6 +1196,8 @@ struct maintenance_task {
>  	maintenance_auto_fn *auto_condition;
>  	unsigned enabled:1;
>  
> +	enum schedule_priority schedule;
> +
>  	/* -1 if not selected. */
>  	int selected_order;
>  };
> @@ -1250,8 +1289,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
>  			continue;
>  
>  		if (opts->auto_flag &&
> -		    (!tasks[i].auto_condition ||
> -		     !tasks[i].auto_condition()))
> +		    (!tasks[i].auto_condition || !tasks[i].auto_condition()))
> +			continue;

This line only add unnecessary noise to this patch.

-- 
Danh
> +
> +		if (opts->schedule && tasks[i].schedule < opts->schedule)
>  			continue;
>  
>  		trace2_region_enter("maintenance", tasks[i].name, r);
> @@ -1274,13 +1315,23 @@ static void initialize_task_config(void)
>  
>  	for (i = 0; i < TASK__COUNT; i++) {
>  		int config_value;
> +		char *config_str;
>  
> -		strbuf_setlen(&config_name, 0);
> +		strbuf_reset(&config_name);
>  		strbuf_addf(&config_name, "maintenance.%s.enabled",
>  			    tasks[i].name);
>  
>  		if (!git_config_get_bool(config_name.buf, &config_value))
>  			tasks[i].enabled = config_value;
> +
> +		strbuf_reset(&config_name);
> +		strbuf_addf(&config_name, "maintenance.%s.schedule",
> +			    tasks[i].name);
> +
> +		if (!git_config_get_string(config_name.buf, &config_str)) {
> +			tasks[i].schedule = parse_schedule(config_str);
> +			free(config_str);
> +		}
>  	}
>  
>  	strbuf_release(&config_name);
> @@ -1324,6 +1375,9 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
>  	struct option builtin_maintenance_run_options[] = {
>  		OPT_BOOL(0, "auto", &opts.auto_flag,
>  			 N_("run tasks based on the state of the repository")),
> +		OPT_CALLBACK(0, "schedule", &opts.schedule, N_("frequency"),
> +			     N_("run tasks based on frequency"),
> +			     maintenance_opt_schedule),
>  		OPT_BOOL(0, "quiet", &opts.quiet,
>  			 N_("do not report progress or other information over stderr")),
>  		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
> @@ -1344,6 +1398,9 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
>  			     builtin_maintenance_run_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  
> +	if (opts.auto_flag && opts.schedule)
> +		die(_("use at most one of --auto and --schedule=<frequency>"));
> +
>  	if (argc != 0)
>  		usage_with_options(builtin_maintenance_run_usage,
>  				   builtin_maintenance_run_options);
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index e0ba19e1ff..328bbaa830 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -264,4 +264,44 @@ test_expect_success 'maintenance.incremental-repack.auto' '
>  	done
>  '
>  
> +test_expect_success '--auto and --schedule incompatible' '
> +	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
> +	test_i18ngrep "at most one" err
> +'
> +
> +test_expect_success 'invalid --schedule value' '
> +	test_must_fail git maintenance run --schedule=annually 2>err &&
> +	test_i18ngrep "unrecognized --schedule" err
> +'
> +
> +test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
> +	git config maintenance.loose-objects.enabled true &&
> +	git config maintenance.loose-objects.schedule hourly &&
> +	git config maintenance.commit-graph.enabled true &&
> +	git config maintenance.commit-graph.schedule daily &&
> +	git config maintenance.incremental-repack.enabled true &&
> +	git config maintenance.incremental-repack.schedule weekly &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/hourly.txt" \
> +		git maintenance run --schedule=hourly 2>/dev/null &&
> +	test_subcommand git prune-packed --quiet <hourly.txt &&
> +	test_subcommand ! git commit-graph write --split --reachable \
> +		--no-progress <hourly.txt &&
> +	test_subcommand ! git multi-pack-index write --no-progress <hourly.txt &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/daily.txt" \
> +		git maintenance run --schedule=daily 2>/dev/null &&
> +	test_subcommand git prune-packed --quiet <daily.txt &&
> +	test_subcommand git commit-graph write --split --reachable \
> +		--no-progress <daily.txt &&
> +	test_subcommand ! git multi-pack-index write --no-progress <daily.txt &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/weekly.txt" \
> +		git maintenance run --schedule=weekly 2>/dev/null &&
> +	test_subcommand git prune-packed --quiet <weekly.txt &&
> +	test_subcommand git commit-graph write --split --reachable \
> +		--no-progress <weekly.txt &&
> +	test_subcommand git multi-pack-index write --no-progress <weekly.txt
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 

-- 
Danh
