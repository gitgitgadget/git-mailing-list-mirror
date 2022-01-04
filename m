Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D381AC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiADRlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiADRlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:41:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E109C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:41:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w20so68662642wra.9
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iyccWfqtoPFUuhiChwRzz858sJT1amFqmf2FYBKLwnU=;
        b=cAMcCA5xMS3WgSTsXoj3DEL3h/8zGW87coAaYNwspx5FRtYUCyW1nlC5aeve8xRzuR
         G1eDAy/JgNPS5err+zRCsX2kNQsGWVvZVNlfBPijIzW/cN94U7f1Cr/eX8aiHZmbivXm
         VsxT+LSkvvIrho7apuf+K/8ycfux35DfIIhnguQjETepBs/F7o5oi2altoPv033d1f56
         +ldA1K/8n7nHmxn/VbC0aEmM4MGAtTKMw9FgLKNlG/796s/fZNAHWVbC6GaiWOgTeYEH
         bH9RqR0vVKeUkhYETxBo6Hj6PuzLyvzwhk2/D6udTqzsvB4MeqFPshT+p3LqeSzXB6tL
         jM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iyccWfqtoPFUuhiChwRzz858sJT1amFqmf2FYBKLwnU=;
        b=3DYG0lmRF6N67ro6ws7azDdNN8+MZ7cguLWDkQ+izHrDugFH/tp2g9BzGL3w/q/3Ip
         z4R5xnpRBsxB0nQXw1FTV7nhdeCKHrc0HxBsGPItTUDNKr7wQK0cVD5eA0DB/opY5kuF
         LmSiw8+jJZtDi5hf77LKQSagabiSqz34bLqdsBjE6rRO3WcYzT5diabqEgP6beCegypU
         qX01sfz/FJrwQru+8Ohh830UyHS0K7Ot2pB3tMm64JUC2uDoORgFHrXhIIuu+CHgf7MZ
         clbjPCgNwKPXIPYdJyizbsAhmK6OO0sVS/8+zIdCwDmvPIBC45AGBHhCLDjtY0lLen9d
         NX5A==
X-Gm-Message-State: AOAM533ME14Q4XwgNfo1nnwIRicS7iz+M6YPyHILp1eXm8aoRp1xVO66
        qENaRQ9orE1t3gDT3E9ZS1Bk8URBB8U=
X-Google-Smtp-Source: ABdhPJxYjeztNaMWPOG0UlLA3IWMn3i5BBCyj2btgItbL2M8Xjc+3U/8I836mINjnI9FSgNetVv/QA==
X-Received: by 2002:a5d:64a1:: with SMTP id m1mr42318958wrp.503.1641318062472;
        Tue, 04 Jan 2022 09:41:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm3181062wri.89.2022.01.04.09.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:41:02 -0800 (PST)
Message-Id: <pull.1175.v3.git.git.1641318061821.gitgitgadget@gmail.com>
In-Reply-To: <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
References: <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:41:01 +0000
Subject: [PATCH v3] builtin/reflog.c: use parse-options api for expire, delete
 subcommands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Switching out manual arg parsing for the parse-options API for the
expire and delete subcommands.

Move explicit_expiry flag into cmd_reflog_expire_cb struct so callbacks
can set both the value of the timestamp as well as the explicit_expiry
flag.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
    reflog.c: switch to use parse-options API
    
    Switch out manual argv parsing for the reflog expire subcommand to use
    the parse-options API. This reduces code redundancy by consolidating
    option parsing logic.
    
    changes since v2:
    
     * got rid of parse_opt_expiry_date helper based on feedback from Junio.
       Just call parse_expiry_date directly in the callbacks, and don't
       worry about unset, as we can just set the PARSE_OPT_NONEG flag for
       --expire and --expire-unreachable since the original code didn't
       support a negated version of those flags anyway. The documentation
       also explicitly states to use "never" as the argument.
     * fix places where we set int i inside a for loop construct.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1175%2Fjohn-cai%2Fjc%2Freflog-switch-to-option-parse-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1175/john-cai/jc/reflog-switch-to-option-parse-v3
Pull-Request: https://github.com/git/git/pull/1175

Range-diff vs v2:

 1:  bcd74559c24 < -:  ----------- parse-options.h: add parse_opt_expiry_date helper
 2:  f9de21e0f26 ! 1:  99a97e6ee52 builtin/reflog.c: switch to use parse-options API for delete subcommand
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    builtin/reflog.c: switch to use parse-options API for delete subcommand
     +    builtin/reflog.c: use parse-options api for expire, delete subcommands
      
     -    Address NEEDSWORK by switching out manual arg parsing for the
     -    parse-options API for the delete subcommand.
     +    Switching out manual arg parsing for the parse-options API for the
     +    expire and delete subcommands.
      
     -    Moves explicit_expiry flag into cmd_reflog_expire_cb struct so a
     -    callback can set both the value of the expiration as well as the
     -    explicit_expiry flag.
     +    Move explicit_expiry flag into cmd_reflog_expire_cb struct so callbacks
     +    can set both the value of the timestamp as well as the explicit_expiry
     +    flag.
      
          Signed-off-by: "John Cai" <johncai86@gmail.com>
      
     @@ builtin/reflog.c
       N_("git reflog exists <ref>");
       
      @@ builtin/reflog.c: static timestamp_t default_reflog_expire_unreachable;
     + 
       struct cmd_reflog_expire_cb {
     - 	struct rev_info revs;
       	int stalefix;
      +	int explicit_expiry;
       	timestamp_t expire_total;
     @@ builtin/reflog.c: static int reflog_expire_config(const char *var, const char *v
      +static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, const char *ref)
       {
       	struct reflog_expire_cfg *ent;
     --
     + 
      -	if (slot == (EXPIRE_TOTAL|EXPIRE_UNREACH))
      +	if (cb->explicit_expiry == (EXPIRE_TOTAL|EXPIRE_UNREACH))
       		return; /* both given explicitly -- nothing to tweak */
     @@ builtin/reflog.c: static void set_reflog_expiry_param(struct cmd_reflog_expire_c
      +				 int unset)
      +{
      +	struct cmd_reflog_expire_cb *cmd = opt->value;
     ++
     ++	if (parse_expiry_date(arg, &cmd->expire_unreachable))
     ++			die(_("malformed expiration date '%s'"), arg);
     ++
      +	cmd->explicit_expiry |= EXPIRE_UNREACH;
     -+	return parse_opt_expiry_date(&cmd->expire_unreachable, arg, unset);
     ++	return 0;
      +}
      +
      +static int expire_total_callback(const struct option *opt,
     @@ builtin/reflog.c: static void set_reflog_expiry_param(struct cmd_reflog_expire_c
      +				 int unset)
      +{
      +	struct cmd_reflog_expire_cb *cmd = opt->value;
     ++
     ++	if (parse_expiry_date(arg, &cmd->expire_total))
     ++			die(_("malformed expiration date '%s'"), arg);
     ++
      +	cmd->explicit_expiry |= EXPIRE_TOTAL;
     -+	return parse_opt_expiry_date(&cmd->expire_total, arg, unset);
     ++	return 0;
      +}
      +
       static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
       {
     - 	struct expire_reflog_policy_cb cb;
     + 	struct cmd_reflog_expire_cb cmd = { 0 };
       	timestamp_t now = time(NULL);
       	int i, status, do_all, all_worktrees = 1;
      -	int explicit_expiry = 0;
       	unsigned int flags = 0;
     + 	int verbose = 0;
     + 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
      +	const struct option options[] = {
      +		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
     -+				EXPIRE_REFLOGS_DRY_RUN),
     ++			EXPIRE_REFLOGS_DRY_RUN),
      +		OPT_BIT(0, "rewrite", &flags,
     -+				N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
     -+				EXPIRE_REFLOGS_REWRITE),
     ++			N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
     ++			EXPIRE_REFLOGS_REWRITE),
      +		OPT_BIT(0, "updateref", &flags,
     -+				N_("update the reference to the value of the top reflog entry"),
     -+				EXPIRE_REFLOGS_UPDATE_REF),
     -+		OPT_BIT(0, "verbose", &flags, N_("print extra information on screen."),
     -+				EXPIRE_REFLOGS_VERBOSE),
     -+		OPT_CALLBACK(0, "expire", &cb.cmd, N_("timestamp"),
     -+				N_("prune entries older than the specified time"), expire_total_callback),
     -+		OPT_CALLBACK(0, "expire-unreachable", &cb.cmd, N_("timestamp"),
     ++			N_("update the reference to the value of the top reflog entry"),
     ++			EXPIRE_REFLOGS_UPDATE_REF),
     ++		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
     ++		OPT_CALLBACK_F(0, "expire", &cmd, N_("timestamp"),
     ++			N_("prune entries older than the specified time"),
     ++			PARSE_OPT_NONEG,
     ++			expire_total_callback),
     ++		OPT_CALLBACK_F(0, "expire-unreachable", &cmd, N_("timestamp"),
      +			N_("prune entries older than <time> that are not reachable from the current tip of the branch"),
     ++			PARSE_OPT_NONEG,
      +			expire_unreachable_callback),
     -+		OPT_BOOL(0, "stale-fix", &cb.cmd.stalefix,
     -+				N_("prune any reflog entries that point to broken commits")),
     ++		OPT_BOOL(0, "stale-fix", &cmd.stalefix,
     ++			N_("prune any reflog entries that point to broken commits")),
      +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
      +		OPT_BOOL(1, "single-worktree", &all_worktrees,
     -+				N_("limits processing to reflogs from the current worktree only.")),
     ++			N_("limits processing to reflogs from the current worktree only.")),
      +		OPT_END()
      +	};
       
       	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
       	default_reflog_expire = now - 90 * 24 * 3600;
      @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
     + 	save_commit_buffer = 0;
       	do_all = status = 0;
     - 	memset(&cb, 0, sizeof(cb));
       
     -+	cb.cmd.explicit_expiry = 0;
     - 	cb.cmd.expire_total = default_reflog_expire;
     - 	cb.cmd.expire_unreachable = default_reflog_expire_unreachable;
     ++	cmd.explicit_expiry = 0;
     + 	cmd.expire_total = default_reflog_expire;
     + 	cmd.expire_unreachable = default_reflog_expire_unreachable;
       
      -	for (i = 1; i < argc; i++) {
      -		const char *arg = argv[i];
     @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
      -		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
      -			flags |= EXPIRE_REFLOGS_DRY_RUN;
      -		else if (skip_prefix(arg, "--expire=", &arg)) {
     --			if (parse_expiry_date(arg, &cb.cmd.expire_total))
     +-			if (parse_expiry_date(arg, &cmd.expire_total))
      -				die(_("'%s' is not a valid timestamp"), arg);
      -			explicit_expiry |= EXPIRE_TOTAL;
      -		}
      -		else if (skip_prefix(arg, "--expire-unreachable=", &arg)) {
     --			if (parse_expiry_date(arg, &cb.cmd.expire_unreachable))
     +-			if (parse_expiry_date(arg, &cmd.expire_unreachable))
      -				die(_("'%s' is not a valid timestamp"), arg);
      -			explicit_expiry |= EXPIRE_UNREACH;
      -		}
      -		else if (!strcmp(arg, "--stale-fix"))
     --			cb.cmd.stalefix = 1;
     +-			cmd.stalefix = 1;
      -		else if (!strcmp(arg, "--rewrite"))
      -			flags |= EXPIRE_REFLOGS_REWRITE;
      -		else if (!strcmp(arg, "--updateref"))
     @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
      -		else if (!strcmp(arg, "--single-worktree"))
      -			all_worktrees = 0;
      -		else if (!strcmp(arg, "--verbose"))
     --			flags |= EXPIRE_REFLOGS_VERBOSE;
     +-			verbose = 1;
      -		else if (!strcmp(arg, "--")) {
      -			i++;
      -			break;
     @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
      -		else
      -			break;
      -	}
     --
      +	argc = parse_options(argc, argv, prefix, options, reflog_expire_usage, 0);
     - 	/*
     - 	 * We can trust the commits and objects reachable from refs
     - 	 * even in older repository.  We cannot trust what's reachable
     + 
     + 	if (verbose)
     + 		should_prune_fn = should_expire_reflog_ent_verbose;
      @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
     - 		for (i = 0; i < collected.nr; i++) {
     - 			struct collected_reflog *e = collected.e[i];
     + 				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
     + 			};
       
     --			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
     -+			set_reflog_expiry_param(&cb.cmd,  e->reflog);
     - 			status |= reflog_expire(e->reflog, flags,
     +-			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
     ++			set_reflog_expiry_param(&cb.cmd,  item->string);
     + 			status |= reflog_expire(item->string, flags,
       						reflog_expiry_prepare,
     - 						should_expire_reflog_ent,
     + 						should_prune_fn,
      @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
     - 		free(collected.e);
     + 		string_list_clear(&collected.reflogs, 0);
       	}
       
      -	for (; i < argc; i++) {
      +	for (i = 0; i < argc; i++) {
       		char *ref;
     - 		if (!dwim_log(argv[i], strlen(argv[i]), NULL, &ref)) {
     + 		struct expire_reflog_policy_cb cb = { .cmd = cmd };
     + 
     +@@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
       			status |= error(_("%s points nowhere!"), argv[i]);
       			continue;
       		}
     @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
      +		set_reflog_expiry_param(&cb.cmd, ref);
       		status |= reflog_expire(ref, flags,
       					reflog_expiry_prepare,
     - 					should_expire_reflog_ent,
     + 					should_prune_fn,
      @@ builtin/reflog.c: static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
       	return 0;
       }
     @@ builtin/reflog.c: static int count_reflog_ent(struct object_id *ooid, struct obj
      +
       static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
       {
     - 	struct expire_reflog_policy_cb cb;
     --	int i, status = 0;
     -+	int status = 0;
     + 	struct cmd_reflog_expire_cb cmd = { 0 };
     +@@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
       	unsigned int flags = 0;
     - 
     -+	const struct option options[] = {
     -+		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
     -+				EXPIRE_REFLOGS_DRY_RUN),
     -+		OPT_BIT(0, "rewrite", &flags,
     -+				N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
     -+				EXPIRE_REFLOGS_REWRITE),
     -+		OPT_BIT(0, "updateref", &flags,
     -+				N_("update the reference to the value of the top reflog entry"),
     -+				EXPIRE_REFLOGS_UPDATE_REF),
     -+		OPT_BIT(0, "verbose", &flags, N_("print extra information on screen."),
     -+				EXPIRE_REFLOGS_VERBOSE),
     -+		OPT_END()
     -+	};
     -+
     - 	memset(&cb, 0, sizeof(cb));
     - 
     + 	int verbose = 0;
     + 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
     +-
      -	for (i = 1; i < argc; i++) {
      -		const char *arg = argv[i];
      -		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
     @@ builtin/reflog.c: static int count_reflog_ent(struct object_id *ooid, struct obj
      -		else if (!strcmp(arg, "--updateref"))
      -			flags |= EXPIRE_REFLOGS_UPDATE_REF;
      -		else if (!strcmp(arg, "--verbose"))
     --			flags |= EXPIRE_REFLOGS_VERBOSE;
     +-			verbose = 1;
      -		else if (!strcmp(arg, "--")) {
      -			i++;
      -			break;
     @@ builtin/reflog.c: static int count_reflog_ent(struct object_id *ooid, struct obj
      -		else
      -			break;
      -	}
     ++	const struct option options[] = {
     ++		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
     ++				EXPIRE_REFLOGS_DRY_RUN),
     ++		OPT_BIT(0, "rewrite", &flags,
     ++				N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
     ++				EXPIRE_REFLOGS_REWRITE),
     ++		OPT_BIT(0, "updateref", &flags,
     ++				N_("update the reference to the value of the top reflog entry"),
     ++				EXPIRE_REFLOGS_UPDATE_REF),
     ++		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
     ++		OPT_END()
     ++	};
     ++
      +	argc = parse_options(argc, argv, prefix, options, reflog_delete_usage, 0);
       
     + 	if (verbose)
     + 		should_prune_fn = should_expire_reflog_ent_verbose;
     + 
      -	if (argc - i < 1)
      +	if (argc < 1)
       		return error(_("no reflog specified to delete"));
       
      -	for ( ; i < argc; i++) {
     -+	for (int i = 0; i < argc; i++) {
     ++	for (i = 0; i < argc; i++) {
       		const char *spec = strstr(argv[i], "@{");
       		char *ep, *ref;
       		int recno;


 builtin/reflog.c | 174 ++++++++++++++++++++++++++---------------------
 1 file changed, 95 insertions(+), 79 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index a4b1dd27e13..7f92fd6f7f7 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -12,15 +12,6 @@
 #include "reachable.h"
 #include "worktree.h"
 
-/* NEEDSWORK: switch to using parse_options */
-static const char reflog_expire_usage[] =
-N_("git reflog expire [--expire=<time>] "
-   "[--expire-unreachable=<time>] "
-   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
-   "[--verbose] [--all] <refs>...");
-static const char reflog_delete_usage[] =
-N_("git reflog delete [--rewrite] [--updateref] "
-   "[--dry-run | -n] [--verbose] <refs>...");
 static const char reflog_exists_usage[] =
 N_("git reflog exists <ref>");
 
@@ -29,6 +20,7 @@ static timestamp_t default_reflog_expire_unreachable;
 
 struct cmd_reflog_expire_cb {
 	int stalefix;
+	int explicit_expiry;
 	timestamp_t expire_total;
 	timestamp_t expire_unreachable;
 	int recno;
@@ -520,18 +512,18 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, const char *ref)
+static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, const char *ref)
 {
 	struct reflog_expire_cfg *ent;
 
-	if (slot == (EXPIRE_TOTAL|EXPIRE_UNREACH))
+	if (cb->explicit_expiry == (EXPIRE_TOTAL|EXPIRE_UNREACH))
 		return; /* both given explicitly -- nothing to tweak */
 
 	for (ent = reflog_expire_cfg; ent; ent = ent->next) {
 		if (!wildmatch(ent->pattern, ref, 0)) {
-			if (!(slot & EXPIRE_TOTAL))
+			if (!(cb->explicit_expiry & EXPIRE_TOTAL))
 				cb->expire_total = ent->expire_total;
-			if (!(slot & EXPIRE_UNREACH))
+			if (!(cb->explicit_expiry & EXPIRE_UNREACH))
 				cb->expire_unreachable = ent->expire_unreachable;
 			return;
 		}
@@ -541,29 +533,87 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 	 * If unconfigured, make stash never expire
 	 */
 	if (!strcmp(ref, "refs/stash")) {
-		if (!(slot & EXPIRE_TOTAL))
+		if (!(cb->explicit_expiry & EXPIRE_TOTAL))
 			cb->expire_total = 0;
-		if (!(slot & EXPIRE_UNREACH))
+		if (!(cb->explicit_expiry & EXPIRE_UNREACH))
 			cb->expire_unreachable = 0;
 		return;
 	}
 
 	/* Nothing matched -- use the default value */
-	if (!(slot & EXPIRE_TOTAL))
+	if (!(cb->explicit_expiry & EXPIRE_TOTAL))
 		cb->expire_total = default_reflog_expire;
-	if (!(slot & EXPIRE_UNREACH))
+	if (!(cb->explicit_expiry & EXPIRE_UNREACH))
 		cb->expire_unreachable = default_reflog_expire_unreachable;
 }
 
+static const char * reflog_expire_usage[] = {
+	N_("git reflog expire [--expire=<time>] "
+   "[--expire-unreachable=<time>] "
+   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
+   "[--verbose] [--all] <refs>..."),
+	NULL
+};
+
+static int expire_unreachable_callback(const struct option *opt,
+				 const char *arg,
+				 int unset)
+{
+	struct cmd_reflog_expire_cb *cmd = opt->value;
+
+	if (parse_expiry_date(arg, &cmd->expire_unreachable))
+			die(_("malformed expiration date '%s'"), arg);
+
+	cmd->explicit_expiry |= EXPIRE_UNREACH;
+	return 0;
+}
+
+static int expire_total_callback(const struct option *opt,
+				 const char *arg,
+				 int unset)
+{
+	struct cmd_reflog_expire_cb *cmd = opt->value;
+
+	if (parse_expiry_date(arg, &cmd->expire_total))
+			die(_("malformed expiration date '%s'"), arg);
+
+	cmd->explicit_expiry |= EXPIRE_TOTAL;
+	return 0;
+}
+
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cmd = { 0 };
 	timestamp_t now = time(NULL);
 	int i, status, do_all, all_worktrees = 1;
-	int explicit_expiry = 0;
 	unsigned int flags = 0;
 	int verbose = 0;
 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
+	const struct option options[] = {
+		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
+			EXPIRE_REFLOGS_DRY_RUN),
+		OPT_BIT(0, "rewrite", &flags,
+			N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
+			EXPIRE_REFLOGS_REWRITE),
+		OPT_BIT(0, "updateref", &flags,
+			N_("update the reference to the value of the top reflog entry"),
+			EXPIRE_REFLOGS_UPDATE_REF),
+		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
+		OPT_CALLBACK_F(0, "expire", &cmd, N_("timestamp"),
+			N_("prune entries older than the specified time"),
+			PARSE_OPT_NONEG,
+			expire_total_callback),
+		OPT_CALLBACK_F(0, "expire-unreachable", &cmd, N_("timestamp"),
+			N_("prune entries older than <time> that are not reachable from the current tip of the branch"),
+			PARSE_OPT_NONEG,
+			expire_unreachable_callback),
+		OPT_BOOL(0, "stale-fix", &cmd.stalefix,
+			N_("prune any reflog entries that point to broken commits")),
+		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
+		OPT_BOOL(1, "single-worktree", &all_worktrees,
+			N_("limits processing to reflogs from the current worktree only.")),
+		OPT_END()
+	};
 
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
@@ -572,45 +622,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	do_all = status = 0;
 
+	cmd.explicit_expiry = 0;
 	cmd.expire_total = default_reflog_expire;
 	cmd.expire_unreachable = default_reflog_expire_unreachable;
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			flags |= EXPIRE_REFLOGS_DRY_RUN;
-		else if (skip_prefix(arg, "--expire=", &arg)) {
-			if (parse_expiry_date(arg, &cmd.expire_total))
-				die(_("'%s' is not a valid timestamp"), arg);
-			explicit_expiry |= EXPIRE_TOTAL;
-		}
-		else if (skip_prefix(arg, "--expire-unreachable=", &arg)) {
-			if (parse_expiry_date(arg, &cmd.expire_unreachable))
-				die(_("'%s' is not a valid timestamp"), arg);
-			explicit_expiry |= EXPIRE_UNREACH;
-		}
-		else if (!strcmp(arg, "--stale-fix"))
-			cmd.stalefix = 1;
-		else if (!strcmp(arg, "--rewrite"))
-			flags |= EXPIRE_REFLOGS_REWRITE;
-		else if (!strcmp(arg, "--updateref"))
-			flags |= EXPIRE_REFLOGS_UPDATE_REF;
-		else if (!strcmp(arg, "--all"))
-			do_all = 1;
-		else if (!strcmp(arg, "--single-worktree"))
-			all_worktrees = 0;
-		else if (!strcmp(arg, "--verbose"))
-			verbose = 1;
-		else if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		else if (arg[0] == '-')
-			usage(_(reflog_expire_usage));
-		else
-			break;
-	}
+	argc = parse_options(argc, argv, prefix, options, reflog_expire_usage, 0);
 
 	if (verbose)
 		should_prune_fn = should_expire_reflog_ent_verbose;
@@ -657,7 +673,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
 			};
 
-			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
+			set_reflog_expiry_param(&cb.cmd,  item->string);
 			status |= reflog_expire(item->string, flags,
 						reflog_expiry_prepare,
 						should_prune_fn,
@@ -667,7 +683,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		string_list_clear(&collected.reflogs, 0);
 	}
 
-	for (; i < argc; i++) {
+	for (i = 0; i < argc; i++) {
 		char *ref;
 		struct expire_reflog_policy_cb cb = { .cmd = cmd };
 
@@ -675,7 +691,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			status |= error(_("%s points nowhere!"), argv[i]);
 			continue;
 		}
-		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
+		set_reflog_expiry_param(&cb.cmd, ref);
 		status |= reflog_expire(ref, flags,
 					reflog_expiry_prepare,
 					should_prune_fn,
@@ -696,6 +712,12 @@ static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
+static const char * reflog_delete_usage[] = {
+	N_("git reflog delete [--rewrite] [--updateref] "
+   "[--dry-run | -n] [--verbose] <refs>..."),
+	NULL
+};
+
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cmd = { 0 };
@@ -703,34 +725,28 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	unsigned int flags = 0;
 	int verbose = 0;
 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			flags |= EXPIRE_REFLOGS_DRY_RUN;
-		else if (!strcmp(arg, "--rewrite"))
-			flags |= EXPIRE_REFLOGS_REWRITE;
-		else if (!strcmp(arg, "--updateref"))
-			flags |= EXPIRE_REFLOGS_UPDATE_REF;
-		else if (!strcmp(arg, "--verbose"))
-			verbose = 1;
-		else if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		else if (arg[0] == '-')
-			usage(_(reflog_delete_usage));
-		else
-			break;
-	}
+	const struct option options[] = {
+		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
+				EXPIRE_REFLOGS_DRY_RUN),
+		OPT_BIT(0, "rewrite", &flags,
+				N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
+				EXPIRE_REFLOGS_REWRITE),
+		OPT_BIT(0, "updateref", &flags,
+				N_("update the reference to the value of the top reflog entry"),
+				EXPIRE_REFLOGS_UPDATE_REF),
+		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, reflog_delete_usage, 0);
 
 	if (verbose)
 		should_prune_fn = should_expire_reflog_ent_verbose;
 
-	if (argc - i < 1)
+	if (argc < 1)
 		return error(_("no reflog specified to delete"));
 
-	for ( ; i < argc; i++) {
+	for (i = 0; i < argc; i++) {
 		const char *spec = strstr(argv[i], "@{");
 		char *ep, *ref;
 		int recno;

base-commit: 194610f4cf2df839ebfd040c5da187c8c0162620
-- 
gitgitgadget
