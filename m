Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C3C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 07:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249A86109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 07:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbhHMH5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 03:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhHMH5e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 03:57:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C2C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 00:57:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oa17so14167792pjb.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJMl1cAChG+0cnzVb2tZ0N8bylNyXqt4igVhB//X0m4=;
        b=e+A8KIWSsdWwtDpMrWfnZPg2MbZ/4uiEWjGJuhd1LND5W5k2mpL3cbn6hkw0We2V4Q
         yPeYED6qkTXB5yvedeqWVY4AiENbMj8JzVFPaIct8sKK81kysoFZ2JAIK1RNYlzQXeJg
         UXebwa/jW3BblUXwoES36pGl1liERke9S+ID6g3Gh7ugdzDOJbFA5EwEv7ge6R6TS8xl
         y6QWpHtg1Oul35g0awsxSerX+faqcICpGIwkMSXU+almy3EZH1eTidHOwisvdISfDB8w
         uvNzrxE7DztLVgbAyMNfgcUkpxhHztJbBkVf8+WpGMNp1HtPmx7NJDB28LVVKTvE/PwL
         g1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJMl1cAChG+0cnzVb2tZ0N8bylNyXqt4igVhB//X0m4=;
        b=puYBPFlur+HvZgeDj8byyIdamZYPnOSNY3ZBtFDMAhoPDfuXnP5wZJ1d9XdfQvc0A7
         bzmMCRy2Yay5XVy09JOnqfl+hdvYk8mxWGFf5swupc1rJF8UXlpAKuiD28HQTpFfewK4
         7Ilm5M78MMARxQEfmMwgiuWksUO0qFS6wOt864nZk0RsEVexVgVfP3M3oBO5pK0iBcSC
         cM0qWzlocIGSpvd3RhetrpMNWpjkvlVTP1tO8qHtZZJLKRW2JGLt2cZ8odtOXOBua3+D
         3gonH9ydgMMo3clayS+3IleaeszwGE+XvKs06a9DqCg+tYLOR8ogSfP60QfxL9aslxM5
         rkpA==
X-Gm-Message-State: AOAM531WaIF52XNxPzTWP646UiTr9pBzI5stFJhDDyD0azUo5v6KcMX+
        0v6HUEuhY93kFprc9vIHpRhjcA9CFs0=
X-Google-Smtp-Source: ABdhPJzkyJtclLOnXFG9nbQZLVfXmr5nLJ1GG13NcqAj4wmPQQJIRzFfB+sMIp1Lrb3jPkZd0jiQ9Q==
X-Received: by 2002:a17:90a:f416:: with SMTP id ch22mr1474046pjb.128.1628841427158;
        Fri, 13 Aug 2021 00:57:07 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id r8sm1524923pgp.30.2021.08.13.00.57.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:57:06 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC] [PATCH v3] submodule--helper: run update procedures from C
Date:   Fri, 13 Aug 2021 13:26:53 +0530
Message-Id: <20210813075653.56817-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802130627.36170-1-raykar.ath@gmail.com>
References: <20210802130627.36170-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new submodule--helper subcommand `run-update-procedure` that runs
the update procedure if the SHA1 of the submodule does not match what
the superproject expects.

This is an intermediate change that works towards total conversion of
`submodule update` from shell to C.

Specific error codes are returned so that the shell script calling the
subcommand can take a decision on the control flow, and preserve the
error messages across subsequent recursive calls of `cmd_update`.

This change is more focused on doing a faithful conversion, so for now we
are not too concerned with trying to reduce subprocess spawns.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---

This patch could have been approached differently, by first changing the
`is_tip_reachable` and `fetch_in_submodule` shell functions to be
`submodule--helper` subcommands, and then following up with a patch that
introduces the `run-update-procedure` subcommand. We have not done it
like that because those functions are trivial enough to convert directly
along with these other changes. This lets us avoid the boilerplate and
the cleanup patches that will need to be introduced in following that
approach.

Since v2:
* Different BUG messages in run_update_command() for the "Unspecified" and
  "None" update modes.
* Move the information about how the patch was approached out of the commit
  message.
* Rebase this patch on top of master (the previous one was based on a stale,
  unmerged topic branch). This patch no longer depends on a topic branch.

Fetch-it-Via:
git fetch https://github.com/tfidfwastaken/git submodule-run-update-proc-list-4

 builtin/submodule--helper.c | 259 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 104 +++++----------
 2 files changed, 291 insertions(+), 72 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e4..9b34b29ce2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2045,6 +2045,20 @@ struct submodule_update_clone {
 	.max_jobs = 1, \
 }
 
+struct update_data {
+	const char *recursive_prefix;
+	const char *sm_path;
+	const char *displaypath;
+	struct object_id oid;
+	struct object_id suboid;
+	struct submodule_update_strategy update_strategy;
+	int depth;
+	unsigned int force: 1;
+	unsigned int quiet: 1;
+	unsigned int nofetch: 1;
+	unsigned int just_cloned: 1;
+};
+#define UPDATE_DATA_INIT { .update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT }
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
 		struct strbuf *out, const char *displaypath)
@@ -2298,6 +2312,181 @@ static int git_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
+static int is_tip_reachable(const char *path, struct object_id *oid)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf rev = STRBUF_INIT;
+	char *hex = oid_to_hex(oid);
+
+	cp.git_cmd = 1;
+	cp.dir = xstrdup(path);
+	cp.no_stderr = 1;
+	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
+
+	prepare_submodule_repo_env(&cp.env_array);
+
+	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
+		return 0;
+
+	return 1;
+}
+
+static int fetch_in_submodule(const char *module_path, int depth, int quiet, struct object_id *oid)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = xstrdup(module_path);
+
+	strvec_push(&cp.args, "fetch");
+	if (quiet)
+		strvec_push(&cp.args, "--quiet");
+	if (depth)
+		strvec_pushf(&cp.args, "--depth=%d", depth);
+	if (oid) {
+		char *hex = oid_to_hex(oid);
+		char *remote = get_default_remote();
+		strvec_pushl(&cp.args, remote, hex, NULL);
+	}
+
+	return run_command(&cp);
+}
+
+static int run_update_command(struct update_data *ud, int subforce)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char *oid = oid_to_hex(&ud->oid);
+	int must_die_on_failure = 0;
+
+	cp.dir = xstrdup(ud->sm_path);
+	switch (ud->update_strategy.type) {
+	case SM_UPDATE_CHECKOUT:
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
+		if (subforce)
+			strvec_push(&cp.args, "-f");
+		break;
+	case SM_UPDATE_REBASE:
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "rebase");
+		if (ud->quiet)
+			strvec_push(&cp.args, "--quiet");
+		must_die_on_failure = 1;
+		break;
+	case SM_UPDATE_MERGE:
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "merge");
+		if (ud->quiet)
+			strvec_push(&cp.args, "--quiet");
+		must_die_on_failure = 1;
+		break;
+	case SM_UPDATE_COMMAND:
+		/* NOTE: this does not handle quoted arguments */
+		strvec_split(&cp.args, ud->update_strategy.command);
+		must_die_on_failure = 1;
+		break;
+	case SM_UPDATE_NONE:
+		BUG("this should have been handled before. How did we reach here?");
+		break;
+	case SM_UPDATE_UNSPECIFIED:
+		BUG("update strategy should have been specified");
+	}
+
+	strvec_push(&cp.args, oid);
+
+	prepare_submodule_repo_env(&cp.env_array);
+
+	if (run_command(&cp)) {
+		if (must_die_on_failure) {
+			switch (ud->update_strategy.type) {
+			case SM_UPDATE_CHECKOUT:
+				die(_("Unable to checkout '%s' in submodule path '%s'"),
+				      oid, ud->displaypath);
+				break;
+			case SM_UPDATE_REBASE:
+				die(_("Unable to rebase '%s' in submodule path '%s'"),
+				      oid, ud->displaypath);
+				break;
+			case SM_UPDATE_MERGE:
+				die(_("Unable to merge '%s' in submodule path '%s'"),
+				      oid, ud->displaypath);
+				break;
+			case SM_UPDATE_COMMAND:
+				die(_("Execution of '%s %s' failed in submodule path '%s'"),
+				      ud->update_strategy.command, oid, ud->displaypath);
+				break;
+			case SM_UPDATE_NONE:
+				BUG("this should have been handled before. How did we reach here?");
+				break;
+			case SM_UPDATE_UNSPECIFIED:
+				BUG("update strategy should have been specified");
+			}
+		}
+		/*
+		 * This signifies to the caller in shell that
+		 * the command failed without dying
+		 */
+		return 1;
+	}
+
+	switch (ud->update_strategy.type) {
+	case SM_UPDATE_CHECKOUT:
+		printf(_("Submodule path '%s': checked out '%s'\n"),
+		       ud->displaypath, oid);
+		break;
+	case SM_UPDATE_REBASE:
+		printf(_("Submodule path '%s': rebased into '%s'\n"),
+		       ud->displaypath, oid);
+		break;
+	case SM_UPDATE_MERGE:
+		printf(_("Submodule path '%s': merged in '%s'\n"),
+		       ud->displaypath, oid);
+		break;
+	case SM_UPDATE_COMMAND:
+		printf(_("Submodule path '%s': '%s %s'\n"),
+		       ud->displaypath, ud->update_strategy.command, oid);
+		break;
+	case SM_UPDATE_NONE:
+		BUG("this should have been handled before. How did we reach here?");
+		break;
+	case SM_UPDATE_UNSPECIFIED:
+		BUG("update strategy should have been specified");
+	}
+
+	return 0;
+}
+
+static int do_run_update_procedure(struct update_data *ud)
+{
+	int subforce = is_null_oid(&ud->suboid) || ud->force;
+
+	if (!ud->nofetch) {
+		/*
+		 * Run fetch only if `oid` isn't present or it
+		 * is not reachable from a ref.
+		 */
+		if (!is_tip_reachable(ud->sm_path, &ud->oid))
+			if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, NULL) &&
+			    !ud->quiet)
+				fprintf_ln(stderr,
+					   _("Unable to fetch in submodule path '%s'; "
+					     "trying to directly fetch %s:"),
+					   ud->displaypath, oid_to_hex(&ud->oid));
+		/*
+		 * Now we tried the usual fetch, but `oid` may
+		 * not be reachable from any of the refs.
+		 */
+		if (!is_tip_reachable(ud->sm_path, &ud->oid))
+			if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
+				die(_("Fetched in submodule path '%s', but it did not "
+				      "contain %s. Direct fetching of that commit failed."),
+				    ud->displaypath, oid_to_hex(&ud->oid));
+	}
+
+	return run_update_command(ud, subforce);
+}
+
 static void update_submodule(struct update_clone_data *ucd)
 {
 	fprintf(stdout, "dummy %s %d\t%s\n",
@@ -2395,6 +2584,75 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	return update_submodules(&suc);
 }
 
+static int run_update_procedure(int argc, const char **argv, const char *prefix)
+{
+	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
+	char *prefixed_path, *update = NULL;
+	struct update_data update_data = UPDATE_DATA_INIT;
+
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
+		OPT__FORCE(&force, N_("force checkout updates"), 0),
+		OPT_BOOL('N', "no-fetch", &nofetch,
+			 N_("don't fetch new objects from the remote site")),
+		OPT_BOOL(0, "just-cloned", &just_cloned,
+			 N_("overrides update mode in case the repository is a fresh clone")),
+		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch")),
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
+		OPT_STRING(0, "update", &update,
+			   N_("string"),
+			   N_("rebase, merge, checkout or none")),
+		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
+			   N_("path into the working tree, across nested "
+			      "submodule boundaries")),
+		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
+			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
+			       parse_opt_object_id),
+		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
+			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
+			       parse_opt_object_id),
+		OPT_END()
+	};
+
+	const char *const usage[] = {
+		N_("git submodule--helper run-update-procedure [<options>] <path>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (argc != 1)
+		usage_with_options(usage, options);
+
+	update_data.force = !!force;
+	update_data.quiet = !!quiet;
+	update_data.nofetch = !!nofetch;
+	update_data.just_cloned = !!just_cloned;
+	update_data.sm_path = argv[0];
+
+	if (update_data.recursive_prefix)
+		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
+	else
+		prefixed_path = xstrdup(update_data.sm_path);
+
+	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
+
+	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
+					    update_data.sm_path, update,
+					    &update_data.update_strategy);
+
+	free(prefixed_path);
+
+	if ((!is_null_oid(&update_data.oid) && !is_null_oid(&update_data.suboid) &&
+	     !oideq(&update_data.oid, &update_data.suboid)) ||
+	    is_null_oid(&update_data.suboid) || update_data.force)
+		return do_run_update_procedure(&update_data);
+
+	return 3;
+}
+
 static int resolve_relative_path(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -2951,6 +3209,7 @@ static struct cmd_struct commands[] = {
 	{"add-clone", add_clone, 0},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
+	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index dbd2ec2050..d8e30d1afa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -369,13 +369,6 @@ cmd_deinit()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
-is_tip_reachable () (
-	sanitize_submodule_env &&
-	cd "$1" &&
-	rev=$(git rev-list -n 1 "$2" --not --all 2>/dev/null) &&
-	test -z "$rev"
-)
-
 # usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
 # Because arguments are positional, use an empty string to omit <depth>
 # but include <sha1>.
@@ -519,14 +512,13 @@ cmd_update()
 
 		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
 
-		update_module=$(git submodule--helper update-module-mode $just_cloned "$sm_path" $update)
-
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 1
 		then
 			subsha1=
 		else
+			just_cloned=
 			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
 			die "fatal: $(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
@@ -547,70 +539,38 @@ cmd_update()
 			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
-		if test "$subsha1" != "$sha1" || test -n "$force"
-		then
-			subforce=$force
-			# If we don't already have a -f flag and the submodule has never been checked out
-			if test -z "$subsha1" && test -z "$force"
-			then
-				subforce="-f"
-			fi
+		out=$(git submodule--helper run-update-procedure \
+			  ${wt_prefix:+--prefix "$wt_prefix"} \
+			  ${GIT_QUIET:+--quiet} \
+			  ${force:+--force} \
+			  ${just_cloned:+--just-cloned} \
+			  ${nofetch:+--no-fetch} \
+			  ${depth:+"$depth"} \
+			  ${update:+--update "$update"} \
+			  ${prefix:+--recursive-prefix "$prefix"} \
+			  ${sha1:+--oid "$sha1"} \
+			  ${subsha1:+--suboid "$subsha1"} \
+			  "--" \
+			  "$sm_path")
 
-			if test -z "$nofetch"
-			then
-				# Run fetch only if $sha1 isn't present or it
-				# is not reachable from a ref.
-				is_tip_reachable "$sm_path" "$sha1" ||
-				fetch_in_submodule "$sm_path" $depth ||
-				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'; trying to directly fetch \$sha1:")"
-
-				# Now we tried the usual fetch, but $sha1 may
-				# not be reachable from any of the refs
-				is_tip_reachable "$sm_path" "$sha1" ||
-				fetch_in_submodule "$sm_path" "$depth" "$sha1" ||
-				die "fatal: $(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
-			fi
-
-			must_die_on_failure=
-			case "$update_module" in
-			checkout)
-				command="git checkout $subforce -q"
-				die_msg="fatal: $(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
-				;;
-			rebase)
-				command="git rebase ${GIT_QUIET:+--quiet}"
-				die_msg="fatal: $(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
-				must_die_on_failure=yes
-				;;
-			merge)
-				command="git merge ${GIT_QUIET:+--quiet}"
-				die_msg="fatal: $(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
-				must_die_on_failure=yes
-				;;
-			!*)
-				command="${update_module#!}"
-				die_msg="fatal: $(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': '\$command \$sha1'")"
-				must_die_on_failure=yes
-				;;
-			*)
-				die "fatal: $(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
-			esac
-
-			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
-			then
-				say "$say_msg"
-			elif test -n "$must_die_on_failure"
-			then
-				die_with_status 2 "$die_msg"
-			else
-				err="${err};$die_msg"
-				continue
-			fi
-		fi
+		# exit codes for run-update-procedure:
+		# 0: update was successful, say command output
+		# 128: subcommand died during execution
+		# 1: update procedure failed, but should not die
+		# 3: no update procedure was run
+		res="$?"
+		case $res in
+		0)
+			say "$out"
+			;;
+		128)
+			exit $res
+			;;
+		1)
+			err="${err};$out"
+			continue
+			;;
+		esac
 
 		if test -n "$recursive"
 		then
-- 
2.32.0

