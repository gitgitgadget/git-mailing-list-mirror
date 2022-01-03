Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54F0C433FE
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 15:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiACPU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 10:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiACPU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 10:20:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43657C061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 07:20:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e5so70526691wrc.5
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 07:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k+rG/v9aLEtZ0h6ndB7EIVU4qGXxeiiAWb06AjkPJI8=;
        b=Wf/5AdnfICzBVL0i/6yCriLfIbZl/dGgSkTUxHNv95jDW8nRrVeh1wY4IohgTx/e5v
         vrAoJu9v0h0nVSK5I0WTDjVRInBpZfeKhe+C6O048bYmGeTdb3iieO7reyi1KaFldQG0
         uLhU1WCnoG6fyfHSuB7Jols9UVEA42bxB2u5u35vc5IpuY7UOQd0vTqnQ7T4hmmYxvr1
         Al1lDsIxdVmX+kaj8g0IF9UqSSPwLSNuugQr6fUZh/u9b/3LzBpYWljZo8KIcRU8beRt
         Aqqs/mBgJOwsTsB9E1psUMDVVcReg1946sYmKPczUAMZcsjvakrTPqpJmbgS99SSeEv6
         R6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k+rG/v9aLEtZ0h6ndB7EIVU4qGXxeiiAWb06AjkPJI8=;
        b=SJnnc6wfs76NPNvm5gddHhTEka/ZQBeE49Bs01XvLW6dhGfLmp5042Mn1CdLMOJ2D7
         fF/Y8HobnJ3Sl9VVrfR2zCbhYF2ooLyWSuQRosCSuRNtfCsJj3TMWFcJCNYggO88L4TM
         OY98XO286vD1XF+fKKyzCNvF1Ui3cl7eZyiHX0q3mw9U0gSlgFBTPMUMe+czFLubHpB5
         tv5EvsUyD8/ilsHXRYiYFSyevfNLhblwTwJuH3q72xJ/OjRv0tnw47qOsFFvEL96Lqc2
         PongTbSqhg40n8njURXThDMMHdjSLSEQ687TDe86RKssm+yCAhydU2/+yALt7lMBfGpk
         y4EQ==
X-Gm-Message-State: AOAM530RwDxKhaFx/iVGqjssjj4sOQJfl71sny9PeSTjHVfIufKvHwvo
        CsedQRMU12zRlVa/MkkprU/kZB/Oi/4=
X-Google-Smtp-Source: ABdhPJyQhsPxeTh/VktYkbKTYRrlg8aHkopjQfCKRrWFzuLwFJQdSyEV9+kU6/OTtN4rUaBoKAWHmw==
X-Received: by 2002:adf:facb:: with SMTP id a11mr37831461wrs.18.1641223225551;
        Mon, 03 Jan 2022 07:20:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm39928245wrc.55.2022.01.03.07.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:20:25 -0800 (PST)
Message-Id: <f9de21e0f26fd8411ffee141ec67916b1440ad67.1641223223.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
        <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 15:20:22 +0000
Subject: [PATCH v2 2/2] builtin/reflog.c: switch to use parse-options API for
 delete subcommand
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

Address NEEDSWORK by switching out manual arg parsing for the
parse-options API for the delete subcommand.

Moves explicit_expiry flag into cmd_reflog_expire_cb struct so a
callback can set both the value of the expiration as well as the
explicit_expiry flag.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 builtin/reflog.c | 168 ++++++++++++++++++++++++-----------------------
 1 file changed, 87 insertions(+), 81 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 175c83e7cc2..3552d749e4b 100644
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
 
@@ -30,6 +21,7 @@ static timestamp_t default_reflog_expire_unreachable;
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int stalefix;
+	int explicit_expiry;
 	timestamp_t expire_total;
 	timestamp_t expire_unreachable;
 	int recno;
@@ -504,18 +496,17 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, const char *ref)
+static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, const char *ref)
 {
 	struct reflog_expire_cfg *ent;
-
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
@@ -525,27 +516,75 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
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
+	cmd->explicit_expiry |= EXPIRE_UNREACH;
+	return parse_opt_expiry_date(&cmd->expire_unreachable, arg, unset);
+}
+
+static int expire_total_callback(const struct option *opt,
+				 const char *arg,
+				 int unset)
+{
+	struct cmd_reflog_expire_cb *cmd = opt->value;
+	cmd->explicit_expiry |= EXPIRE_TOTAL;
+	return parse_opt_expiry_date(&cmd->expire_total, arg, unset);
+}
+
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct expire_reflog_policy_cb cb;
 	timestamp_t now = time(NULL);
 	int i, status, do_all, all_worktrees = 1;
-	int explicit_expiry = 0;
 	unsigned int flags = 0;
+	const struct option options[] = {
+		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
+				EXPIRE_REFLOGS_DRY_RUN),
+		OPT_BIT(0, "rewrite", &flags,
+				N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
+				EXPIRE_REFLOGS_REWRITE),
+		OPT_BIT(0, "updateref", &flags,
+				N_("update the reference to the value of the top reflog entry"),
+				EXPIRE_REFLOGS_UPDATE_REF),
+		OPT_BIT(0, "verbose", &flags, N_("print extra information on screen."),
+				EXPIRE_REFLOGS_VERBOSE),
+		OPT_CALLBACK(0, "expire", &cb.cmd, N_("timestamp"),
+				N_("prune entries older than the specified time"), expire_total_callback),
+		OPT_CALLBACK(0, "expire-unreachable", &cb.cmd, N_("timestamp"),
+			N_("prune entries older than <time> that are not reachable from the current tip of the branch"),
+			expire_unreachable_callback),
+		OPT_BOOL(0, "stale-fix", &cb.cmd.stalefix,
+				N_("prune any reflog entries that point to broken commits")),
+		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
+		OPT_BOOL(1, "single-worktree", &all_worktrees,
+				N_("limits processing to reflogs from the current worktree only.")),
+		OPT_END()
+	};
 
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
@@ -555,46 +594,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	do_all = status = 0;
 	memset(&cb, 0, sizeof(cb));
 
+	cb.cmd.explicit_expiry = 0;
 	cb.cmd.expire_total = default_reflog_expire;
 	cb.cmd.expire_unreachable = default_reflog_expire_unreachable;
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			flags |= EXPIRE_REFLOGS_DRY_RUN;
-		else if (skip_prefix(arg, "--expire=", &arg)) {
-			if (parse_expiry_date(arg, &cb.cmd.expire_total))
-				die(_("'%s' is not a valid timestamp"), arg);
-			explicit_expiry |= EXPIRE_TOTAL;
-		}
-		else if (skip_prefix(arg, "--expire-unreachable=", &arg)) {
-			if (parse_expiry_date(arg, &cb.cmd.expire_unreachable))
-				die(_("'%s' is not a valid timestamp"), arg);
-			explicit_expiry |= EXPIRE_UNREACH;
-		}
-		else if (!strcmp(arg, "--stale-fix"))
-			cb.cmd.stalefix = 1;
-		else if (!strcmp(arg, "--rewrite"))
-			flags |= EXPIRE_REFLOGS_REWRITE;
-		else if (!strcmp(arg, "--updateref"))
-			flags |= EXPIRE_REFLOGS_UPDATE_REF;
-		else if (!strcmp(arg, "--all"))
-			do_all = 1;
-		else if (!strcmp(arg, "--single-worktree"))
-			all_worktrees = 0;
-		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
-		else if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		else if (arg[0] == '-')
-			usage(_(reflog_expire_usage));
-		else
-			break;
-	}
-
+	argc = parse_options(argc, argv, prefix, options, reflog_expire_usage, 0);
 	/*
 	 * We can trust the commits and objects reachable from refs
 	 * even in older repository.  We cannot trust what's reachable
@@ -630,7 +634,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 
-			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
+			set_reflog_expiry_param(&cb.cmd,  e->reflog);
 			status |= reflog_expire(e->reflog, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
@@ -641,13 +645,13 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free(collected.e);
 	}
 
-	for (; i < argc; i++) {
+	for (i = 0; i < argc; i++) {
 		char *ref;
 		if (!dwim_log(argv[i], strlen(argv[i]), NULL, &ref)) {
 			status |= error(_("%s points nowhere!"), argv[i]);
 			continue;
 		}
-		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
+		set_reflog_expiry_param(&cb.cmd, ref);
 		status |= reflog_expire(ref, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
@@ -668,38 +672,40 @@ static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
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
 	struct expire_reflog_policy_cb cb;
-	int i, status = 0;
+	int status = 0;
 	unsigned int flags = 0;
 
+	const struct option options[] = {
+		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
+				EXPIRE_REFLOGS_DRY_RUN),
+		OPT_BIT(0, "rewrite", &flags,
+				N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
+				EXPIRE_REFLOGS_REWRITE),
+		OPT_BIT(0, "updateref", &flags,
+				N_("update the reference to the value of the top reflog entry"),
+				EXPIRE_REFLOGS_UPDATE_REF),
+		OPT_BIT(0, "verbose", &flags, N_("print extra information on screen."),
+				EXPIRE_REFLOGS_VERBOSE),
+		OPT_END()
+	};
+
 	memset(&cb, 0, sizeof(cb));
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			flags |= EXPIRE_REFLOGS_DRY_RUN;
-		else if (!strcmp(arg, "--rewrite"))
-			flags |= EXPIRE_REFLOGS_REWRITE;
-		else if (!strcmp(arg, "--updateref"))
-			flags |= EXPIRE_REFLOGS_UPDATE_REF;
-		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
-		else if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		else if (arg[0] == '-')
-			usage(_(reflog_delete_usage));
-		else
-			break;
-	}
+	argc = parse_options(argc, argv, prefix, options, reflog_delete_usage, 0);
 
-	if (argc - i < 1)
+	if (argc < 1)
 		return error(_("no reflog specified to delete"));
 
-	for ( ; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		const char *spec = strstr(argv[i], "@{");
 		char *ep, *ref;
 		int recno;
-- 
gitgitgadget
