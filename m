Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF32EC63797
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01586135B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhGVNAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 09:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhGVM7w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:59:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2561C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 06:40:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j8-20020a17090aeb08b0290173bac8b9c9so4354816pjz.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QnMarEOwGSKrqVZlFeBkTub85DiaUZDyAeBQKEoxIzA=;
        b=gMPw1OTwx+47D5VZjaXASxct1W77MXL5epzzNbsk9NrhzPpEfuOilxy/6o4eaidNOx
         fVp7uSQXtQBPNjuOVjPUAQjR39Pj+el/YBmfE+LwD42HkGt+EoGF/HYOFho/cQcX7cdw
         rV2Ub/Syf5fRPS0u5A+0kqL7En++aNvqZlg1iGpIFepuz0+SgBVzsy3g/dnrQeEJildN
         HjZh/C5qr+FcJ1ZFNSLgcKej3LfochIvaD43T1F8V+da9UlhCT9JyJNi2kQBl1Sb2JbW
         kdhrak7963fO9ZvYHO2BYNMkgD72aMl98wfZ2/+dXAhtjBRuacEvdXSdc4WyatlobInO
         8wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QnMarEOwGSKrqVZlFeBkTub85DiaUZDyAeBQKEoxIzA=;
        b=Kzh1vw8ZvHI+KaK/6wNKj7hEeVXoTUVL1w6eH7F6L1eRvqK+lOWBG8Cq0/6uaEQ8ZB
         CQuccZqRT35T7MidU/PqgdV4XEHojLU6Ti3l+kij+ZInKF1rXY96uIFJrb82YxClflA7
         ajQe2YcC4QKNQWUiMhKtzXpcMjNT3+fodTT8CxyFC0TIAPdpi0mgpiXOYNOKjtXFaU/F
         UB5xN456S5sSFlbftIgoBTz+rp9qZA2J7QwC7Tz9j4clcwok2aaSYhBj7ov+c8Sf5OMK
         DRbbdB24RUTRiIcM9S8Jc+NvXK8muc16jDtOLX37AJh01KyU9oKEsbY/vzIDw9hADYD5
         9ihw==
X-Gm-Message-State: AOAM531TB1YFlfgHUc1yYWVvFId4JhoLwYlP/8EwYmBzoulnhlnsLmR7
        Pn257UTdoxL5uKMEQUCR306ABbPDovndDrQN
X-Google-Smtp-Source: ABdhPJy4kBw0WHab2vHKM9tMR/PFLV64nVpFayBjzK/E+yyrbOmeZmK8p5pysXmFfcP8w+z5FpSHqA==
X-Received: by 2002:a17:902:aa86:b029:116:3e3a:2051 with SMTP id d6-20020a170902aa86b02901163e3a2051mr58762plr.38.1626961226945;
        Thu, 22 Jul 2021 06:40:26 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id r10sm34152991pga.48.2021.07.22.06.40.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:40:26 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>
Subject: [GSoC] [PATCH] submodule--helper: run update procedures from C
Date:   Thu, 22 Jul 2021 19:10:12 +0530
Message-Id: <20210722134012.99457-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
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

This patch could have been approached differently, by first changing the
`is_tip_reachable` and `fetch_in_submodule` shell functions to be
`submodule--helper` subcommands, and then following up with a patch that
introduces the `run-update-procedure` subcommand. We have not done it
like that because those functions are trivial enough to convert directly
along with these other changes. This lets us avoid the boilerplate and
the cleanup patches that will need to be introduced in following that
approach.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---

This patch depends on changes introduced in 559e49fe5c (submodule: prefix die
messages with 'fatal', 2021-07-08), which belongs to the ar/submodule-add
(2021-07-12) series[1]. Other than that commit, it is independent of my other
'submodule add' conversion series.

Opinions on the following would be appreciated:

* Currently there is a lot of special meaning for the exit code, of this
  subcommand, which was needed to handle the various failures of running the
  update mode in the shell code that follows (note the extra handling of exit
  code 128, because a die() in C returns that value). I felt this was okay to do
  because in a later series that converts whatever is left, the handling of exit
  codes will be simplified.

* Is there a way to check if a sha1 is unreachable from all the refs?
  Currently 'is_tip_reachable()' spawns a subprocess with an incantation of:
  'git rev-list -n 1 $sha1 --not --all'
  I suppose I could do this with the revision-walk API [2], but it felt like
  a lot of boilerplate for something that was really succinct in the original
  shell implementation. Maybe worth looking into it for a later patch?

* I added a 'NOTE' comment for `case SM_UPDATE_COMMAND` in
  submodule--helper.c:run_update_command(). I wonder if that comment is
  unnecessary noise or worth mentioning. Is there an edge case where the
  !command in the 'submodule.update' configuration can be improperly handled by
  strvec_split()?

[1] https://lore.kernel.org/git/20210710074801.19917-1-raykar.ath@gmail.com/

Fetch-it-via:
git fetch https://github.com/tfidfwastaken/git.git submodule-run-update-proc-list-1

 builtin/submodule--helper.c | 247 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  95 ++++----------
 2 files changed, 269 insertions(+), 73 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..4e16561bf1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2029,6 +2029,20 @@ struct submodule_update_clone {
 	.max_jobs = 1, \
 }
 
+struct update_data {
+	const char *recursive_prefix;
+	const char *sm_path;
+	const char *displaypath;
+	struct object_id sha1;
+	struct object_id subsha1;
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
@@ -2282,6 +2296,165 @@ static int git_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
+/* NEEDSWORK: try to do this without creating a new process */
+static int is_tip_reachable(const char *path, struct object_id *sha1)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf rev = STRBUF_INIT;
+	char *sha1_hex = oid_to_hex(sha1);
+
+	cp.git_cmd = 1;
+	cp.dir = xstrdup(path);
+	cp.no_stderr = 1;
+	strvec_pushl(&cp.args, "rev-list", "-n", "1", sha1_hex, "--not", "--all", NULL);
+
+	prepare_submodule_repo_env(&cp.env_array);
+
+	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
+		return 0;
+
+	return 1;
+}
+
+static int fetch_in_submodule(const char *module_path, int depth, int quiet, struct object_id *sha1)
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
+	if (sha1) {
+		char *sha1_hex = oid_to_hex(sha1);
+		char *remote = get_default_remote();
+		strvec_pushl(&cp.args, remote, sha1_hex, NULL);
+	}
+
+	return run_command(&cp);
+}
+
+static int run_update_command(struct update_data *ud, int subforce)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf die_msg = STRBUF_INIT;
+	struct strbuf say_msg = STRBUF_INIT;
+	char *sha1 = oid_to_hex(&ud->sha1);
+	int retval, must_die_on_failure = 0;
+
+	cp.dir = xstrdup(ud->sm_path);
+	switch (ud->update_strategy.type) {
+	case SM_UPDATE_CHECKOUT:
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
+		if (subforce)
+			strvec_push(&cp.args, "-f");
+		strbuf_addf(&die_msg, "fatal: Unable to checkout '%s' in submodule path '%s'\n",
+			    sha1, ud->displaypath);
+		strbuf_addf(&say_msg, "Submodule path '%s': checked out '%s'\n",
+			    ud->displaypath, sha1);
+		break;
+	case SM_UPDATE_REBASE:
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "rebase");
+		if (ud->quiet)
+			strvec_push(&cp.args, "--quiet");
+		strbuf_addf(&die_msg, "fatal: Unable to rebase '%s' in submodule path '%s'\n",
+			    sha1, ud->displaypath);
+		strbuf_addf(&say_msg, "Submodule path '%s': rebased into '%s'\n",
+			    ud->displaypath, sha1);
+		must_die_on_failure = 1;
+		break;
+	case SM_UPDATE_MERGE:
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "merge");
+		if (ud->quiet)
+			strvec_push(&cp.args, "--quiet");
+		strbuf_addf(&die_msg, "fatal: Unable to merge '%s' in submodule path '%s'\n",
+			    sha1, ud->displaypath);
+		strbuf_addf(&say_msg, "Submodule path '%s': merged in '%s'\n",
+			    ud->displaypath, sha1);
+		must_die_on_failure = 1;
+		break;
+	case SM_UPDATE_COMMAND:
+		/* NOTE: this does not handle quoted arguments */
+		strvec_split(&cp.args, ud->update_strategy.command);
+		strbuf_addf(&die_msg, "fatal: Execution of '%s %s' failed in submodule path '%s'\n",
+			    ud->update_strategy.command, sha1, ud->displaypath);
+		strbuf_addf(&say_msg, "Submodule path '%s': '%s %s'\n",
+			    ud->displaypath, ud->update_strategy.command, sha1);
+		must_die_on_failure = 1;
+		break;
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_NONE:
+		BUG("update strategy should have been specified");
+	}
+
+	strvec_push(&cp.args, sha1);
+
+	prepare_submodule_repo_env(&cp.env_array);
+
+	if (run_command(&cp)) {
+		if (must_die_on_failure) {
+			retval = 2;
+			fputs(_(die_msg.buf), stderr);
+			goto cleanup;
+		}
+		/*
+		 * This signifies to the caller in shell that
+		 * the command failed without dying
+		 */
+		retval = 1;
+		goto cleanup;
+	}
+	retval = 0;
+	puts(_(say_msg.buf));
+
+cleanup:
+	strbuf_release(&die_msg);
+	strbuf_release(&say_msg);
+	return retval;
+}
+
+static int do_run_update_procedure(struct update_data *ud)
+{
+	if ((!is_null_oid(&ud->sha1) && !is_null_oid(&ud->subsha1) && !oideq(&ud->sha1, &ud->subsha1)) ||
+	    is_null_oid(&ud->subsha1) || ud->force) {
+		int subforce = is_null_oid(&ud->subsha1) || ud->force;
+
+		if (!ud->nofetch) {
+			/*
+			 * Run fetch only if `sha1` isn't present or it
+			 * is not reachable from a ref.
+			 */
+			if (!is_tip_reachable(ud->sm_path, &ud->sha1))
+				if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, NULL) &&
+				    !ud->quiet)
+					fprintf_ln(stderr,
+						   _("Unable to fetch in submodule path '%s'; "
+						     "trying to directly fetch %s:"),
+						   ud->displaypath, oid_to_hex(&ud->sha1));
+			/*
+			 * Now we tried the usual fetch, but `sha1` may
+			 * not be reachable from any of the refs.
+			 */
+			if (!is_tip_reachable(ud->sm_path, &ud->sha1))
+				if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->sha1))
+					die(_("Fetched in submodule path '%s', but it did not "
+					      "contain %s. Direct fetching of that commit failed."),
+					    ud->displaypath, oid_to_hex(&ud->sha1));
+		}
+
+		return run_update_command(ud, subforce);
+	}
+
+	return 3;
+}
+
 static void update_submodule(struct update_clone_data *ucd)
 {
 	fprintf(stdout, "dummy %s %d\t%s\n",
@@ -2379,6 +2552,79 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	return update_submodules(&suc);
 }
 
+static int run_update_procedure(int argc, const char **argv, const char *prefix)
+{
+	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
+	char *prefixed_path, *update = NULL;
+	char *sha1 = NULL, *subsha1 = NULL;
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
+		OPT_STRING(0, "sha1", &sha1, N_("string"),
+			   N_("SHA1 expected by superproject")),
+		OPT_STRING(0, "subsha1", &subsha1, N_("string"),
+			   N_("SHA1 of submodule's HEAD")),
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
+	if (sha1)
+		get_oid_hex(sha1, &update_data.sha1);
+	else
+		oidcpy(&update_data.sha1, null_oid());
+
+	if (subsha1)
+		get_oid_hex(subsha1, &update_data.subsha1);
+	else
+		oidcpy(&update_data.subsha1, null_oid());
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
+	return do_run_update_procedure(&update_data);
+}
+
 static int resolve_relative_path(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -2759,6 +3005,7 @@ static struct cmd_struct commands[] = {
 	{"clone", module_clone, 0},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
+	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 1187c21260..4d5437f5c2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -405,13 +405,6 @@ cmd_deinit()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${force:+--force} ${deinit_all:+--all} -- "$@"
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
@@ -555,14 +548,13 @@ cmd_update()
 
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
 			die "$(eval_gettext "fatal: Unable to find current revision in submodule path '\$displaypath'")"
@@ -583,70 +575,27 @@ cmd_update()
 			die "$(eval_gettext "fatal: Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
-		if test "$subsha1" != "$sha1" || test -n "$force"
-		then
-			subforce=$force
-			# If we don't already have a -f flag and the submodule has never been checked out
-			if test -z "$subsha1" && test -z "$force"
-			then
-				subforce="-f"
-			fi
+		out=$(git submodule--helper run-update-procedure ${wt_prefix:+--prefix "$wt_prefix"} ${GIT_QUIET:+--quiet} ${force:+--force} ${just_cloned:+--just-cloned} ${nofetch:+--no-fetch} ${depth:+"$depth"} ${update:+--update "$update"} ${prefix:+--recursive-prefix "$prefix"} ${sha1:+--sha1 "$sha1"} ${subsha1:+--subsha1 "$subsha1"} "$sm_path")
 
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
-				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
-			fi
-
-			must_die_on_failure=
-			case "$update_module" in
-			checkout)
-				command="git checkout $subforce -q"
-				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
-				;;
-			rebase)
-				command="git rebase ${GIT_QUIET:+--quiet}"
-				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
-				must_die_on_failure=yes
-				;;
-			merge)
-				command="git merge ${GIT_QUIET:+--quiet}"
-				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
-				must_die_on_failure=yes
-				;;
-			!*)
-				command="${update_module#!}"
-				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': '\$command \$sha1'")"
-				must_die_on_failure=yes
-				;;
-			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
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
+		# 1: update procedure failed and must die
+		# 2: update procedure failed, but should not die
+		# 3: no update procedure was run
+		res="$?"
+		case $res in
+		0)
+			say "$out"
+			;;
+		2|128)
+			exit $res
+			;;
+		1)
+			err="${err};$out"
+			continue
+			;;
+		esac
 
 		if test -n "$recursive"
 		then
@@ -661,7 +610,7 @@ cmd_update()
 			if test $res -gt 0
 			then
 				die_msg="$(eval_gettext "fatal: Failed to recurse into submodule path '\$displaypath'")"
-				if test $res -ne 2
+				if test $res -ne 2 && test $res -ne 128
 				then
 					err="${err};$die_msg"
 					continue
-- 
2.32.0

