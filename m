Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C21C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FA920672
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="or45Ts/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgDEPYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:24:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35409 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgDEPYq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 11:24:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so12049704wrx.2
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KHYtTZU7PN3pl+3vLZ2ABZiFvk7rvGj7Qa912rcnf/8=;
        b=or45Ts/0LBsG9tPpGeLNmGStE8NAmuY/bcOQ0+mjM3/ioh1NTVL9oCB2MSbHQ6ahPJ
         cCA8djv0U2U0GLAOubaKlHCSYbv6Z/69e5cey49FBl2/QXbw4bHdKebiBfvtqt1tOlRh
         snr7Wn4LfRnD4WGikeYuEcmGeEeyaJHp9tVfo1xRhIfN6yQLOcMTbDnMVIr6mPkH2B/I
         iIeBL2cXWeiQO38DEfNuYghMdMYs2zi0CLqDM9YBeJXGNR2emHx7nROnMQuj/M4Ojrex
         IEnVtWOxQ/8CUBXwASHH4dIcSz626eODjqBNesmCCn9Wd86MkUxXHcrFmxd3VIv/fatg
         Ih3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KHYtTZU7PN3pl+3vLZ2ABZiFvk7rvGj7Qa912rcnf/8=;
        b=P7vgqU7wVgEMlsCpPMXhupMC4dgjHiDcl1qZJCiu87tAf9uxqms2p5PYAjBPueK6pP
         QLvWkO4DhrYmtVm2AKhJT03f6+lkhbr0qqN26nHuWMvQKARzM60zXkIvhWiZBqQbeJUe
         0P/b5NHRRNzsccZNtRI1x4uOdljQdvSL4AfIV9usZGQIiHNvanWaUBrR4jbONoppiqfO
         byDiq7Jx6jU1FSZeMwS01gham+p1eefHp4ZcG/ZRYQyHOns+KSnddOA8RYd47dTdOrno
         ZDwHPFLYx9c2ru140KQ0RNIsfSF/+49fcPuXEMsoHia+RFafHB8S1bdL5WWS9VkSwo+h
         fyQw==
X-Gm-Message-State: AGi0Pub6T24fx+s5FwqmOT92LTPFfC5pwQuG/FerP4CTN2GGlQUn+Spm
        fpboiwQQNBggjk4JbWO15s8=
X-Google-Smtp-Source: APiQypL0+QFojymNRGV9cNBP4M7OqfVe1FLlEQcjo00jeWzC6GGBRVf5HHp25r9cka4ugHvSCjukGA==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr17292585wrp.387.1586100282539;
        Sun, 05 Apr 2020 08:24:42 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id c17sm16477932wrp.28.2020.04.05.08.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 08:24:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/15] job-runner: use config to limit job frequency
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <18429182ffcf4cb56fcf3d8c76e41652a6c45adc.1585946894.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ca28ee06-aab1-a72b-7b7e-1a0c9a732cdb@gmail.com>
Date:   Sun, 5 Apr 2020 16:24:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <18429182ffcf4cb56fcf3d8c76e41652a6c45adc.1585946894.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 03/04/2020 21:48, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> We want to run different maintenance tasks at different rates. That
> means we cannot rely only on the time between job-runner loop pauses
> to reduce the frequency of specific jobs. This means we need to
> persist a timestamp for the previous run somewhere. A natural place
> is the Git config file for that repo.
> 
> Create the job.<job-namme>.lastRun config option to store the
> timestamp of the previous run of that job. Set this config option
> after a successful run of 'git -C <repo> run-job <job-name>'.
> 
> To maximize code reuse, we dynamically construct the config key
> and parse the config value into a timestamp in a generic way. This
> makes the introduction of another config option extremely trivial:
> 
> The job.<job-name>.interval option allows a user to specify a
> minimum number of seconds between two calls to 'git run-job
> <job-name>' on a given repo. This could be stored in the global
> or system config to provide an update on the default for all repos,
> or could be updated on a per-repo basis. This is checked on every
> iteration of the job loop, so a user could update this and see the
> effect without restarting the job-runner process.
> 
> RFC QUESTION: I'm using a 'git -C <repo> config <option>' process
> to test if enough time has elapsed before running the 'run-job'
> process. These 'config' processes are pretty light-weight, so
> hopefully they are not too noisy. An alternative would be to
> always run 'git -C <repo> run-job <job-name>' and rely on that
> process to no-op based on the configured values and how recently
> they were run.

You're still executing another process so it doesn't really save 
anything in the 'noop' case. In the case where something needs to be 
done I think the extra config process is unlikely to be noticed 
(especially as 'git job' forks a lot anyway)

Best Wishes

Phillip

> However, that will likely interrupt users who want
> to test the jobs in the foreground. Finally, that user disruption
> would be mitigated by adding a "--check-latest" option. A user
> running a job manually would not include that argument by default
> and would succeed. However, any logging that we might do for the
> job-runner would make it look like we are running the run-job
> commands all the time even if they are no-ops. Advice welcome!
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   Documentation/config/job.txt  |  10 ++
>   Documentation/git-run-job.txt |   3 +
>   builtin/job-runner.c          | 177 +++++++++++++++++++++++++++++++++-
>   3 files changed, 189 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/job.txt b/Documentation/config/job.txt
> index 2dfed3935fa..7c799d66221 100644
> --- a/Documentation/config/job.txt
> +++ b/Documentation/config/job.txt
> @@ -1,3 +1,13 @@
> +job.<job-name>.interval::
> +	The minimum number of seconds between runs of
> +	`git run-job <job-name>` when running `git job-runner`.
> +
> +job.<job-name>.lastRun::
> +	The Unix epoch for the timestamp of the previous run of
> +	`git run-job <job-name>` when running `git job-runner`. You
> +	can manually update this to a later time to delay a specific
> +	job on this repository.
> +
>   job.pack-files.batchSize::
>   	This string value `<size>` will be passed to the
>   	`git multi-pack-index repack --batch-size=<size>` command as
> diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
> index cdd6417f7c9..c6d5674d699 100644
> --- a/Documentation/git-run-job.txt
> +++ b/Documentation/git-run-job.txt
> @@ -90,6 +90,9 @@ pack-files, the job does not attempt to repack. Otherwise, the batch
>   size is the sum of all pack-file sizes minus the largest pack-file size.
>   The batch size is capped at two gigabytes. This intends to pack all
>   small pack-files into a single pack-file.
> ++
> +The `--batch-size=<size>` option will override the dynamic or configured
> +batch size.
>   
>   
>   GIT
> diff --git a/builtin/job-runner.c b/builtin/job-runner.c
> index bed401f94bf..aee55c106e8 100644
> --- a/builtin/job-runner.c
> +++ b/builtin/job-runner.c
> @@ -4,11 +4,175 @@
>   #include "run-command.h"
>   #include "string-list.h"
>   
> +#define MAX_TIMESTAMP ((timestamp_t)-1)
> +
>   static char const * const builtin_job_runner_usage[] = {
>   	N_("git job-runner [<options>]"),
>   	NULL
>   };
>   
> +static char *config_name(const char *prefix,
> +			 const char *job,
> +			 const char *postfix)
> +{
> +	int postfix_dot = 0;
> +	struct strbuf name = STRBUF_INIT;
> +
> +	if (prefix) {
> +		strbuf_addstr(&name, prefix);
> +		strbuf_addch(&name, '.');
> +	}
> +
> +	if (job) {
> +		strbuf_addstr(&name, job);
> +		postfix_dot = 1;
> +	}
> +
> +	if (postfix) {
> +		if (postfix_dot)
> +			strbuf_addch(&name, '.');
> +		strbuf_addstr(&name, postfix);
> +	}
> +
> +	return strbuf_detach(&name, NULL);
> +}
> +
> +static int try_get_config(const char *job,
> +			  const char *repo,
> +			  const char *postfix,
> +			  char **value)
> +{
> +	int result = 0;
> +	FILE *proc_out;
> +	struct strbuf line = STRBUF_INIT;
> +	char *cname = config_name("job", job, postfix);
> +	struct child_process *config_proc = xmalloc(sizeof(*config_proc));
> +
> +	child_process_init(config_proc);
> +
> +	argv_array_push(&config_proc->args, "git");
> +	argv_array_push(&config_proc->args, "-C");
> +	argv_array_push(&config_proc->args, repo);
> +	argv_array_push(&config_proc->args, "config");
> +	argv_array_push(&config_proc->args, cname);
> +	free(cname);
> +
> +	config_proc->out = -1;
> +
> +	if (start_command(config_proc)) {
> +		warning(_("failed to start process for repo '%s'"),
> +			repo);
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	proc_out = xfdopen(config_proc->out, "r");
> +
> +	/* if there is no line, leave the value as given */
> +	if (!strbuf_getline(&line, proc_out))
> +		*value = strbuf_detach(&line, NULL);
> +	else
> +		*value = NULL;
> +
> +	strbuf_release(&line);
> +
> +	fclose(proc_out);
> +
> +	result = finish_command(config_proc);
> +
> +cleanup:
> +	free(config_proc);
> +	return result;
> +}
> +
> +static int try_get_timestamp(const char *job,
> +			     const char *repo,
> +			     const char *postfix,
> +			     timestamp_t *t)
> +{
> +	char *value;
> +	int result = try_get_config(job, repo, postfix, &value);
> +
> +	if (!result) {
> +		*t = atol(value);
> +		free(value);
> +	}
> +
> +	return result;
> +}
> +
> +static timestamp_t get_last_run(const char *job,
> +				const char *repo)
> +{
> +	timestamp_t last_run = 0;
> +
> +	/* In an error state, do not run the job */
> +	if (try_get_timestamp(job, repo, "lastrun", &last_run))
> +		return MAX_TIMESTAMP;
> +
> +	return last_run;
> +}
> +
> +static timestamp_t get_interval(const char *job,
> +				const char *repo)
> +{
> +	timestamp_t interval = MAX_TIMESTAMP;
> +
> +	/* In an error state, do not run the job */
> +	if (try_get_timestamp(job, repo, "interval", &interval))
> +		return MAX_TIMESTAMP;
> +
> +	if (interval == MAX_TIMESTAMP) {
> +		/* load defaults for each job */
> +		if (!strcmp(job, "commit-graph") || !strcmp(job, "fetch"))
> +			interval = 60 * 60; /* 1 hour */
> +		else
> +			interval = 24 * 60 * 60; /* 1 day */
> +	}
> +
> +	return interval;
> +}
> +
> +static int set_last_run(const char *job,
> +			const char *repo,
> +			timestamp_t last_run)
> +{
> +	int result = 0;
> +	struct strbuf last_run_string = STRBUF_INIT;
> +	struct child_process *config_proc = xmalloc(sizeof(*config_proc));
> +	char *cname = config_name("job", job, "lastrun");
> +
> +	strbuf_addf(&last_run_string, "%"PRItime, last_run);
> +
> +	child_process_init(config_proc);
> +
> +	argv_array_push(&config_proc->args, "git");
> +	argv_array_push(&config_proc->args, "-C");
> +	argv_array_push(&config_proc->args, repo);
> +	argv_array_push(&config_proc->args, "config");
> +	argv_array_push(&config_proc->args, cname);
> +	argv_array_push(&config_proc->args, last_run_string.buf);
> +	free(cname);
> +	strbuf_release(&last_run_string);
> +
> +	if (start_command(config_proc)) {
> +		warning(_("failed to start process for repo '%s'"),
> +			repo);
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	if (finish_command(config_proc)) {
> +		warning(_("failed to finish process for repo '%s'"),
> +			repo);
> +		result = 1;
> +	}
> +
> +cleanup:
> +	free(config_proc);
> +	return result;
> +}
> +
>   static struct string_list arg_repos = STRING_LIST_INIT_DUP;
>   
>   static int arg_repos_append(const struct option *opt,
> @@ -54,9 +218,20 @@ static int load_active_repos(struct string_list *repos)
>   
>   static int run_job(const char *job, const char *repo)
>   {
> +	int result;
>   	struct argv_array cmd = ARGV_ARRAY_INIT;
> +	timestamp_t now = time(NULL);
> +	timestamp_t last_run = get_last_run(job, repo);
> +	timestamp_t interval = get_interval(job, repo);
> +
> +	if (last_run + interval > now)
> +		return 0;
> +
>   	argv_array_pushl(&cmd, "-C", repo, "run-job", job, NULL);
> -	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +
> +	set_last_run(job, repo, now);
> +	return result;
>   }
>   
>   static int run_job_loop_step(struct string_list *list)
> 
