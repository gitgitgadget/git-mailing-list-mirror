Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B0EC433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 15:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiACPU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 10:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiACPU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 10:20:26 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0DC061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 07:20:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k18so33808191wrg.11
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 07:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MLCWkVOIU88dF5AjOgj4irLRBITh8K3hvedUwiZ/AR4=;
        b=k98eS09AB6i5+QTwyakeB8dbebgomkOPILB4AueubtWTXGIhxnI4+mm+etvjr0cwyK
         D+Fd9Ujhk66W1sojCsyvQoqk6LB+iHSad5wyRGWGX54lZqSNAlMrSGyh6B4rcxbIzZ78
         tiKRQ8nHhr64YQgKcJJtmWrWN59mPOUa97NbDhC02hCwq5MmAvRE5e1CArgPkQwRRJGg
         DiTMOdeRk0YWs1ipHkPaJrDTz0ZSgudFw5yG+qSU+aZdQ1maKibovWu+mujhsfgXGpJ6
         sRqKEK0EWvDCl9wNyPambYUiOXyJK0oM3YGx8g/WB8wLwp8tGPNQ9tFrqJtZDng/PO+V
         OP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MLCWkVOIU88dF5AjOgj4irLRBITh8K3hvedUwiZ/AR4=;
        b=fwBeIq8QQmHK8sQsSduUP7aTdjZgcOq8SbzdbMK6iUsh2WPVmoBW8JYk8j0H4K1qp1
         NwEcAWqNqYhlCP45eHEeBjckT/4KU+LfLmN/iGt2CULdCGFlKQ1uJKkNbksZjlims0dP
         QZNDAVp8eUOTtzJXwWoKcp496HpSGJX59HZYN2Dfui1ozUd127taLNvQE/SZb51UccX6
         0CA4hxldW0TSK0/lICRpUM77qrw8uK+9W9PUSo/5ZXdlVVpl8sQDmQ04oolM0EWuasOS
         a8vvraxiAwWwwDERx0TXNvYj1dUQ8sHHU87LX/Nn1ifNa0C2Cs7UUxQvEaDBmkBjk2KO
         O3sw==
X-Gm-Message-State: AOAM531Hh8A8LXlYFtQnhtzH3qrzFuLxgqmcWVAxugDkLc+GWOkoS+IF
        7Tmzc3t3PQkrbgv8rnvvGq+GsEWxXkk=
X-Google-Smtp-Source: ABdhPJzJMB12e2JjlfmmT/zIh+dcygxzNYRpgWKUKMCk5orN4PR/de+Q8+/iyjDxydivAEpVv5vnug==
X-Received: by 2002:adf:d1cc:: with SMTP id b12mr41467005wrd.282.1641223224104;
        Mon, 03 Jan 2022 07:20:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm39035930wrd.100.2022.01.03.07.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:20:23 -0800 (PST)
Message-Id: <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
In-Reply-To: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 15:20:20 +0000
Subject: [PATCH v2 0/2] reflog.c: switch to use parse-options API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch out manual argv parsing for the reflog expire subcommand to use the
parse-options API. This reduces code redundancy by consolidating option
parsing logic.

changes since v1:

 * add helper parse_opt_expiry_date so we can use this shared logic to parse
   the expire date option.
 * place explicit_expiry inside of cmd_reflog_expire_cb to make it easier to
   use a callback to set both the value of the timestamp and the
   explicit_expiry flag.

John Cai (2):
  parse-options.h: add parse_opt_expiry_date helper
  builtin/reflog.c: switch to use parse-options API for delete
    subcommand

 builtin/reflog.c   | 168 +++++++++++++++++++++++----------------------
 parse-options-cb.c |   7 +-
 parse-options.h    |   1 +
 3 files changed, 94 insertions(+), 82 deletions(-)


base-commit: 55b058a8bbcc54bd93c733035c995abc7967e539
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1175%2Fjohn-cai%2Fjc%2Freflog-switch-to-option-parse-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1175/john-cai/jc/reflog-switch-to-option-parse-v2
Pull-Request: https://github.com/git/git/pull/1175

Range-diff vs v1:

 1:  9bd3c6672c4 < -:  ----------- builtin/reflog.c: use parse-options for expire subcommand
 -:  ----------- > 1:  bcd74559c24 parse-options.h: add parse_opt_expiry_date helper
 2:  fffea298642 ! 2:  f9de21e0f26 builtin/reflog.c: switch to use parse-options API for delete subcommand
     @@ Commit message
          Address NEEDSWORK by switching out manual arg parsing for the
          parse-options API for the delete subcommand.
      
     +    Moves explicit_expiry flag into cmd_reflog_expire_cb struct so a
     +    callback can set both the value of the expiration as well as the
     +    explicit_expiry flag.
     +
          Signed-off-by: "John Cai" <johncai86@gmail.com>
      
       ## builtin/reflog.c ##
      @@
     - #include "revision.h"
       #include "reachable.h"
       #include "worktree.h"
     --#include "parse-options.h"
       
     +-/* NEEDSWORK: switch to using parse_options */
     +-static const char reflog_expire_usage[] =
     +-N_("git reflog expire [--expire=<time>] "
     +-   "[--expire-unreachable=<time>] "
     +-   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
     +-   "[--verbose] [--all] <refs>...");
      -static const char reflog_delete_usage[] =
      -N_("git reflog delete [--rewrite] [--updateref] "
      -   "[--dry-run | -n] [--verbose] <refs>...");
       static const char reflog_exists_usage[] =
       N_("git reflog exists <ref>");
       
     +@@ builtin/reflog.c: static timestamp_t default_reflog_expire_unreachable;
     + struct cmd_reflog_expire_cb {
     + 	struct rev_info revs;
     + 	int stalefix;
     ++	int explicit_expiry;
     + 	timestamp_t expire_total;
     + 	timestamp_t expire_unreachable;
     + 	int recno;
     +@@ builtin/reflog.c: static int reflog_expire_config(const char *var, const char *value, void *cb)
     + 	return 0;
     + }
     + 
     +-static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, const char *ref)
     ++static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, const char *ref)
     + {
     + 	struct reflog_expire_cfg *ent;
     +-
     +-	if (slot == (EXPIRE_TOTAL|EXPIRE_UNREACH))
     ++	if (cb->explicit_expiry == (EXPIRE_TOTAL|EXPIRE_UNREACH))
     + 		return; /* both given explicitly -- nothing to tweak */
     + 
     + 	for (ent = reflog_expire_cfg; ent; ent = ent->next) {
     + 		if (!wildmatch(ent->pattern, ref, 0)) {
     +-			if (!(slot & EXPIRE_TOTAL))
     ++			if (!(cb->explicit_expiry & EXPIRE_TOTAL))
     + 				cb->expire_total = ent->expire_total;
     +-			if (!(slot & EXPIRE_UNREACH))
     ++			if (!(cb->explicit_expiry & EXPIRE_UNREACH))
     + 				cb->expire_unreachable = ent->expire_unreachable;
     + 			return;
     + 		}
     +@@ builtin/reflog.c: static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
     + 	 * If unconfigured, make stash never expire
     + 	 */
     + 	if (!strcmp(ref, "refs/stash")) {
     +-		if (!(slot & EXPIRE_TOTAL))
     ++		if (!(cb->explicit_expiry & EXPIRE_TOTAL))
     + 			cb->expire_total = 0;
     +-		if (!(slot & EXPIRE_UNREACH))
     ++		if (!(cb->explicit_expiry & EXPIRE_UNREACH))
     + 			cb->expire_unreachable = 0;
     + 		return;
     + 	}
     + 
     + 	/* Nothing matched -- use the default value */
     +-	if (!(slot & EXPIRE_TOTAL))
     ++	if (!(cb->explicit_expiry & EXPIRE_TOTAL))
     + 		cb->expire_total = default_reflog_expire;
     +-	if (!(slot & EXPIRE_UNREACH))
     ++	if (!(cb->explicit_expiry & EXPIRE_UNREACH))
     + 		cb->expire_unreachable = default_reflog_expire_unreachable;
     + }
     + 
     ++static const char * reflog_expire_usage[] = {
     ++	N_("git reflog expire [--expire=<time>] "
     ++   "[--expire-unreachable=<time>] "
     ++   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
     ++   "[--verbose] [--all] <refs>..."),
     ++	NULL
     ++};
     ++
     ++static int expire_unreachable_callback(const struct option *opt,
     ++				 const char *arg,
     ++				 int unset)
     ++{
     ++	struct cmd_reflog_expire_cb *cmd = opt->value;
     ++	cmd->explicit_expiry |= EXPIRE_UNREACH;
     ++	return parse_opt_expiry_date(&cmd->expire_unreachable, arg, unset);
     ++}
     ++
     ++static int expire_total_callback(const struct option *opt,
     ++				 const char *arg,
     ++				 int unset)
     ++{
     ++	struct cmd_reflog_expire_cb *cmd = opt->value;
     ++	cmd->explicit_expiry |= EXPIRE_TOTAL;
     ++	return parse_opt_expiry_date(&cmd->expire_total, arg, unset);
     ++}
     ++
     + static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
     + {
     + 	struct expire_reflog_policy_cb cb;
     + 	timestamp_t now = time(NULL);
     + 	int i, status, do_all, all_worktrees = 1;
     +-	int explicit_expiry = 0;
     + 	unsigned int flags = 0;
     ++	const struct option options[] = {
     ++		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
     ++				EXPIRE_REFLOGS_DRY_RUN),
     ++		OPT_BIT(0, "rewrite", &flags,
     ++				N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
     ++				EXPIRE_REFLOGS_REWRITE),
     ++		OPT_BIT(0, "updateref", &flags,
     ++				N_("update the reference to the value of the top reflog entry"),
     ++				EXPIRE_REFLOGS_UPDATE_REF),
     ++		OPT_BIT(0, "verbose", &flags, N_("print extra information on screen."),
     ++				EXPIRE_REFLOGS_VERBOSE),
     ++		OPT_CALLBACK(0, "expire", &cb.cmd, N_("timestamp"),
     ++				N_("prune entries older than the specified time"), expire_total_callback),
     ++		OPT_CALLBACK(0, "expire-unreachable", &cb.cmd, N_("timestamp"),
     ++			N_("prune entries older than <time> that are not reachable from the current tip of the branch"),
     ++			expire_unreachable_callback),
     ++		OPT_BOOL(0, "stale-fix", &cb.cmd.stalefix,
     ++				N_("prune any reflog entries that point to broken commits")),
     ++		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
     ++		OPT_BOOL(1, "single-worktree", &all_worktrees,
     ++				N_("limits processing to reflogs from the current worktree only.")),
     ++		OPT_END()
     ++	};
     + 
     + 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
     + 	default_reflog_expire = now - 90 * 24 * 3600;
     +@@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
     + 	do_all = status = 0;
     + 	memset(&cb, 0, sizeof(cb));
     + 
     ++	cb.cmd.explicit_expiry = 0;
     + 	cb.cmd.expire_total = default_reflog_expire;
     + 	cb.cmd.expire_unreachable = default_reflog_expire_unreachable;
     + 
     +-	for (i = 1; i < argc; i++) {
     +-		const char *arg = argv[i];
     +-
     +-		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
     +-			flags |= EXPIRE_REFLOGS_DRY_RUN;
     +-		else if (skip_prefix(arg, "--expire=", &arg)) {
     +-			if (parse_expiry_date(arg, &cb.cmd.expire_total))
     +-				die(_("'%s' is not a valid timestamp"), arg);
     +-			explicit_expiry |= EXPIRE_TOTAL;
     +-		}
     +-		else if (skip_prefix(arg, "--expire-unreachable=", &arg)) {
     +-			if (parse_expiry_date(arg, &cb.cmd.expire_unreachable))
     +-				die(_("'%s' is not a valid timestamp"), arg);
     +-			explicit_expiry |= EXPIRE_UNREACH;
     +-		}
     +-		else if (!strcmp(arg, "--stale-fix"))
     +-			cb.cmd.stalefix = 1;
     +-		else if (!strcmp(arg, "--rewrite"))
     +-			flags |= EXPIRE_REFLOGS_REWRITE;
     +-		else if (!strcmp(arg, "--updateref"))
     +-			flags |= EXPIRE_REFLOGS_UPDATE_REF;
     +-		else if (!strcmp(arg, "--all"))
     +-			do_all = 1;
     +-		else if (!strcmp(arg, "--single-worktree"))
     +-			all_worktrees = 0;
     +-		else if (!strcmp(arg, "--verbose"))
     +-			flags |= EXPIRE_REFLOGS_VERBOSE;
     +-		else if (!strcmp(arg, "--")) {
     +-			i++;
     +-			break;
     +-		}
     +-		else if (arg[0] == '-')
     +-			usage(_(reflog_expire_usage));
     +-		else
     +-			break;
     +-	}
     +-
     ++	argc = parse_options(argc, argv, prefix, options, reflog_expire_usage, 0);
     + 	/*
     + 	 * We can trust the commits and objects reachable from refs
     + 	 * even in older repository.  We cannot trust what's reachable
     +@@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
     + 		for (i = 0; i < collected.nr; i++) {
     + 			struct collected_reflog *e = collected.e[i];
     + 
     +-			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
     ++			set_reflog_expiry_param(&cb.cmd,  e->reflog);
     + 			status |= reflog_expire(e->reflog, flags,
     + 						reflog_expiry_prepare,
     + 						should_expire_reflog_ent,
      @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
       		free(collected.e);
       	}
     @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
       		char *ref;
       		if (!dwim_log(argv[i], strlen(argv[i]), NULL, &ref)) {
       			status |= error(_("%s points nowhere!"), argv[i]);
     + 			continue;
     + 		}
     +-		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
     ++		set_reflog_expiry_param(&cb.cmd, ref);
     + 		status |= reflog_expire(ref, flags,
     + 					reflog_expiry_prepare,
     + 					should_expire_reflog_ent,
      @@ builtin/reflog.c: static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
       	return 0;
       }

-- 
gitgitgadget
