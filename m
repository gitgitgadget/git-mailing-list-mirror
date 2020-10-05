Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E6FC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 19:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8AD212CC
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 19:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+pRx5pC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgJET5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgJET5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 15:57:23 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8009DC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 12:57:23 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y2so12340127lfy.10
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 12:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2NdEI23vLXnc+2M/PryR54apt4wk8SbijkTvWCcfPQ=;
        b=g+pRx5pCA1G3JI360buoC+kwcYrWpM66VLsDdDPRysjBqkw7yJgywpaZY8sCq04BTu
         JCv7sCpfII6GAsYV7shyE3wqHJN0Xty/nt/YbPvGmxchF3jUbot8pF9VP93RNd54q1GE
         eXzUPewg+Rs4GRICJ3XuUA9KxUk1mAkxm7gJzI8WhG9M4Iw8jlWu7KreznFBA2ZFCfZ4
         EdDTAAHPUEsKsHf2lSrmlnlihG2aU1W9t6VUmWTFig+hy5Z3v4k6uABS8z5LiUXnCBkt
         HpJCvVF8ZxnMjRKOJ6pDc+BO4vpoLXDtPWzzH16Fhrnp7y5y3QddSLVo34eOPYJORlMN
         zNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2NdEI23vLXnc+2M/PryR54apt4wk8SbijkTvWCcfPQ=;
        b=LFEJW273aw9zcaGz8du7iJ9pJzCLcYyDbv8nO6YzRjnYfQ2L05UXhoPPUJPI986lkf
         8+iaVPaxSWh0fbVv6KwewpmrjvmnnGv+/8ksbREjwMKXZbW1XptPeMOxsl/xRlWnocOu
         5SYRFyu5Gj5qaHek3QCClrEMFFHAI6lBUZeyZFZ5mApP0TZVww+0m8ZGmTHdDIHx0fbl
         aEBHosPDZCPcyU2A0mXwcPZ+42I2sCqI/z2vRF8MK2Rq+LuuwfylchG3U4SpwET43H5U
         HauG7V5yWCaxsTE6SPE/RljzaMD8+tfBZCpdsyh8SNHbfzZUJX4aeVz0QlrFr3UYcr7x
         7qqw==
X-Gm-Message-State: AOAM530sx/afEfoyUrxKcAgehHSbxT98dp1I+/+JsGTUvf6fA82SKdY7
        kqI0blOECDgWIjgSNfk9ybs=
X-Google-Smtp-Source: ABdhPJz2ki6MjCb5VZelKXx4fyTt3QdxW9kQaPoZvW2DB79k0N8tYSTWl31DWOY9ECgNFMWqzZiOpw==
X-Received: by 2002:a19:6b08:: with SMTP id d8mr328295lfa.218.1601927841832;
        Mon, 05 Oct 2020 12:57:21 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id z24sm213158lfe.54.2020.10.05.12.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 12:57:20 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "Derrick Stolee" <stolee@gmail.com>,
        "Derrick Stolee" <derrickstolee@github.com>,
        "Derrick Stolee" <dstolee@microsoft.com>
Subject: Re: [PATCH v3 6/7] maintenance: use default schedule if not configured
Date:   Mon,  5 Oct 2020 21:57:01 +0200
Message-Id: <20201005195701.14268-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <d833fffe89c94ecf3551c075960ba6d7607e9b17.1601902635.git.gitgitgadget@gmail.com>
References: <d833fffe89c94ecf3551c075960ba6d7607e9b17.1601902635.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 5 Oct 2020 at 15:07, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> The 'git maintenance (register|start)' subcommands add the current
> repository to the global Git config so maintenance will operate on that
> repository. It does not specify what maintenance should occur or how
> often.

I see that you posted a "how about this?" some days ago. I was offline
for the weekend with some margin on both sides, so I didn't see it until
now. Good that you just went ahead and posted the whole series anyway.

> If a user sets any 'maintenance.<task>.schedule' config value, then
> they have chosen a specific schedule for themselves and Git should
> respect that when running 'git maintenance run --schedule=<frequency>'.
>
> To make this process extremely simple for users, assume a default
> schedule when no 'maintenance.<task>.schedule' or '...enabled' config
> settings are concretely set. This is only an in-process assumption, so
> future versions of Git could adjust this expected schedule.

This obviously makes sense to me. ;-) One thing it does mean though is
that something like this:

  $ git maintenance register
  # Time goes by...
  # Someone said to try this:
  $ git config --add maintenance.commit-graph.schedule hourly
  $ git config --add maintenance.commit-graph.enable true
  # That could have been a no-op, since we were already on
  # such an hourly schedule, but it will effectively turn off
  # all other scheduled tasks. So some time later:
  # -- Why are my fetches so slow all of a sudden? :-(

That could be different if `git maintenance register` would turn on,
say, `maintenance.baseSchedule = standard` where setting those
`maintenance.commit-graph.*` would tweak that "standard" "base
schedule" (in a no-op way as it happens).

> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -37,6 +37,21 @@ register::

Adding some more context manually:

register::
	Initialize Git config values so any scheduled maintenance will
	start running on this repository. This adds the repository to the
	`maintenance.repo` config variable in the current user's global
	config and enables some recommended configuration values for
> 	`maintenance.<task>.schedule`. The tasks that are enabled are safe
> 	for running in the background without disrupting foreground
> 	processes.

The part about "and enables some recommended configuration values"
should probably be in this patch, not an earlier one, and maybe it
shouldn't even be here. With the new approach of this version, this
doesn't really enable some recommended configuration values. Or maybe
it does, I can't make up my mind, nor can I come up with an alternative
formulation.

> ++
> +If your repository has no `maintenance.<task>.schedule` configuration
> +values set, then Git will use a recommended default schedule that performs
> +background maintenance that will not interrupt foreground commands. The
> +default schedule is as follows:
> ++

If you add a line of "--" here...

> +* `gc`: disabled.
> +* `commit-graph`: hourly.
> +* `prefetch`: hourly.
> +* `loose-objects`: daily.
> +* `incremental-repack`: daily.

... and one here, you'll drop some indentation at this point so that
the next paragraph doesn't align with the list above. (See patch below.)

> ++
> +`git maintenance register` will also disable foreground maintenance by
> +setting `maintenance.auto = false` in the current repository. This config
> +setting will remain after a `git maintenance unregister` command.

That last paragraph does belong here. The part about the different
tasks ... maybe. With this new approach of not actually setting any
`schedule`/`enabled` configuration variables, that list doesn't
obviously have its natural home here. Maybe under `--schedule`, which is
where the detection actually happens and the default defaults are
imposed? Or maybe in a separate "CONFIGURATION" section. It could
include config/maintenance.txt, then go on to define the whole fallback
mechanism without having to worry about breaking the reader's flow. (The
way it is now, this `register` command is fairly heavy compared to the
surrounding parts.)

> +static int has_schedule_config(void)
> +{
> +       int i, found = 0;
> +       struct strbuf config_name = STRBUF_INIT;
> +       size_t prefix;
> +
> +       strbuf_addstr(&config_name, "maintenance.");
> +       prefix = config_name.len;
> +
> +       for (i = 0; !found && i < TASK__COUNT; i++) {
> +               char *value;
> +
> +               strbuf_setlen(&config_name, prefix);
> +               strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
> +
> +               if (!git_config_get_string(config_name.buf, &value)) {
> +                       found = 1;
> +                       FREE_AND_NULL(value);
> +               }
> +
> +               strbuf_setlen(&config_name, prefix);
> +               strbuf_addf(&config_name, "%s.enabled", tasks[i].name);
> +
> +               if (!git_config_get_string(config_name.buf, &value)) {
> +                       found = 1;
> +                       FREE_AND_NULL(value);
> +               }
> +       }
> +
> +       strbuf_release(&config_name);
> +       return found;
> +}

I had the same reaction to `FREE_AND_NULL()` as on my previous reading.
If you have $reasons for doing it this way, not a big deal. I offer a
suggestion in patch form below anyway. Feel free to squash, adapt or
ignore as you see fit.

> +
> +static void set_recommended_schedule(void)
> +{
> +       if (has_schedule_config())
> +               return;
> +
> +       tasks[TASK_GC].enabled = 0;
> +
> +       tasks[TASK_PREFETCH].enabled = 1;
> +       tasks[TASK_PREFETCH].schedule = SCHEDULE_HOURLY;
> +
> +       tasks[TASK_COMMIT_GRAPH].enabled = 1;
> +       tasks[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY;
> +
> +       tasks[TASK_LOOSE_OBJECTS].enabled = 1;
> +       tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
> +
> +       tasks[TASK_INCREMENTAL_REPACK].enabled = 1;
> +       tasks[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY;
> +}
> +

One thing I can't make up my mind about is how these `enabled` are used
for two purposes: Deciding what to do on `git maintenance run` without
any `--task`, and deciding what to do on `git maintenance run
--scheduled`.

>  static int maintenance_run_tasks(struct maintenance_run_opts *opts)
>  {
>         int i, found_selected = 0;
> @@ -1280,6 +1333,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
>
>         if (found_selected)
>                 QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
> +       else if (opts->schedule != SCHEDULE_NONE)
> +               set_recommended_schedule();

... And especially how we only impose the magic
`maintenance.<task>.enabled` values when we are running with
`--schedule`. So the answer to "what is the default value of
`maintenance.commit-graph.enabled`?" is "it depends on several factors".

Sort of related: The presence of a `maintenance.<task>.schedule` is not
sufficient to schedule the task. This looks like something that one
could easily trip on. Maybe you have already considered letting a zero
value for `maintenance.<task>.schedule` mean "disabled" and ignoring the
`enabled` config item for the scheduled runs, but rejected that for good
reasons?

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 7715e40391..7154987fd2 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -305,11 +305,14 @@ test_expect_success 'register and unregister' '
>         git config --global --add maintenance.repo /existing1 &&
>         git config --global --add maintenance.repo /existing2 &&
>         git config --global --get-all maintenance.repo >before &&
> +
>         git maintenance register &&
> -       git config --global --get-all maintenance.repo >actual &&
> -       cp before after &&
> -       pwd >>after &&
> -       test_cmp after actual &&
> +       test_cmp_config false maintenance.auto &&
> +       git config --global --get-all maintenance.repo >between &&
> +       cp before expect &&
> +       pwd >>expect &&
> +       test_cmp expect between &&
> +
>         git maintenance unregister &&
>         git config --global --get-all maintenance.repo >actual &&
>         test_cmp before actual

This tests the one-time config tweaking. But we don't test any of the
"detect no config and impose a default" logic. Neither that it kicks in
at all, nor that it doesn't when it shouldn't.

As mentioned above, I end with some minor suggestions.

Martin

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 738a4c7ebd..2085b53dc5 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -43,11 +43,13 @@ values set, then Git will use a recommended default schedule that performs
 background maintenance that will not interrupt foreground commands. The
 default schedule is as follows:
 +
+--
 * `gc`: disabled.
 * `commit-graph`: hourly.
 * `prefetch`: hourly.
 * `loose-objects`: daily.
 * `incremental-repack`: daily.
+--
 +
 `git maintenance register` will also disable foreground maintenance by
 setting `maintenance.auto = false` in the current repository. This config
diff --git a/builtin/gc.c b/builtin/gc.c
index 965690704b..63f4c102b1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1253,35 +1253,31 @@ static int compare_tasks_by_selection(const void *a_, const void *b_)
 
 static int has_schedule_config(void)
 {
-	int i, found = 0;
+	int i;
 	struct strbuf config_name = STRBUF_INIT;
 	size_t prefix;
+	char *value = NULL;
 
 	strbuf_addstr(&config_name, "maintenance.");
 	prefix = config_name.len;
 
-	for (i = 0; !found && i < TASK__COUNT; i++) {
-		char *value;
-
+	for (i = 0; i < TASK__COUNT; i++) {
 		strbuf_setlen(&config_name, prefix);
 		strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
 
-		if (!git_config_get_string(config_name.buf, &value)) {
-			found = 1;
-			FREE_AND_NULL(value);
-		}
+		if (!git_config_get_string(config_name.buf, &value))
+			break;
 
 		strbuf_setlen(&config_name, prefix);
 		strbuf_addf(&config_name, "%s.enabled", tasks[i].name);
 
-		if (!git_config_get_string(config_name.buf, &value)) {
-			found = 1;
-			FREE_AND_NULL(value);
-		}
+		if (!git_config_get_string(config_name.buf, &value))
+			break;
 	}
 
 	strbuf_release(&config_name);
-	return found;
+	free(value);
+	return i < TASK__COUNT;
 }
 
 static void set_recommended_schedule(void)
-- 
2.28.0.297.g1956fa8f8d

