Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171A1C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EAF6054F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbhHXOHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbhHXOHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 10:07:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEBCC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 07:06:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n12so875004plk.10
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0A7fK7ncYVGLKTRy8YNYBpCHX1hQ2hoencWoO0sTpg=;
        b=nuw2mJfR/qhHaSacp16J+XF4koWNEUPre5b4uvOJhDfs7IVtQIuJgwTsPkAhemXj5B
         6Td5/olPhfKWeMMiL/Cja+0LChPHpIqjl+oln/0IQF9fgvxUijtr/mA3iS3AzkfgvxAf
         B08+B3RpqDuH5GJrXaxJauPp7101fyMxc3o6Q91B+LZaeV4V/VZbG4NRGkR7+5icaU0X
         4nzL+AkXSwC2NVuukK9MU1lZCok9t/9+WM5kW8MPUtfz9g8Mlga/ihwzQax0uGJGOMJZ
         PqksH//a6qsUBj+3PhPQ51ik6eMdeGvV0StITTd0TuKPypxv+ewCyrGGGcMxMwL5P7s/
         SFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0A7fK7ncYVGLKTRy8YNYBpCHX1hQ2hoencWoO0sTpg=;
        b=E1iOHT70tIFwI5EBewMobPmJywRn0hdpD1J2eGDNpkVseQgRizdHQD651dr6HYTaRi
         Vg5O1EGU0gfSafd1azNtjEyQqikhcrD+WZKAUXhYhDXdra9z24hadAPdMufR1nhmHlX7
         WKQTVx2i0sPDU7206bNlfbKIzojoa1sxwy49eZ1sRwLfMdI9IYETOwSqdXLd//qCVzTK
         nZbPR9mZRWDieErurAdoOmJJ0W3iAIx7VwU5xnXLfks45xy3y6VV12tAl/5squgjByTr
         ekwN6K/LC7qDPplvgvt48W5IRtTIoE2doB2ZJA92R/cLc0xOsmOLyDz3oE48KhIsR9UI
         oQcA==
X-Gm-Message-State: AOAM531AN9d8xAIJab67Y0+iJ9/0P4q4tFdoe4fTKbnKB2XXlmx7pH/o
        10Yyychm3F5K0M4XYFDACbQjbN/+HKEanQ==
X-Google-Smtp-Source: ABdhPJxLjJT3Af9BVOvR/U0H1RxK7S49ndg78pDdSEA+sNH9OQh3iuZTKUkyOIxtix4U5WXefO1EQw==
X-Received: by 2002:a17:902:9b95:b0:130:6a7b:4570 with SMTP id y21-20020a1709029b9500b001306a7b4570mr21597471plp.27.1629813983021;
        Tue, 24 Aug 2021 07:06:23 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id f9sm2709403pjq.36.2021.08.24.07.06.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:06:22 -0700 (PDT)
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
Subject: [PATCH v4] submodule--helper: run update procedures from C
Date:   Tue, 24 Aug 2021 19:36:09 +0530
Message-Id: <20210824140609.1496-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813075653.56817-1-raykar.ath@gmail.com>
References: <20210813075653.56817-1-raykar.ath@gmail.com>
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---

This patch addresses the concerns raised by Junio. The important changes are:

* Fix error message handling of the output of 'run-update-procedure'. While at
  it, ensure the "checkout" mode error message is stored and printed
  appropriately.

* In 'run_update_command()' switch from 'run_command()' to
  'run_command_v_opt_cd_env()' to ensure quoted command update modes are handled
  correctly.

* Code style and hygiene changes.

* Introduce a NEEDSWORK comment, because the printf() and error return is
  correct only because the shell caller in the other end redirects it to the
  correct output stream. Once we switch this completely to C (ie, in the
  follow-up series), I need to remember to die() instead (or print to stderr) to
  reproduce the original behaviour.

Range-diff against v3:
1:  2ff48f8790 ! 1:  2729834e43 submodule--helper: run update procedures from C
    @@ Commit message
         This change is more focused on doing a faithful conversion, so for now we
         are not too concerned with trying to reduce subprocess spawns.
     
    -    Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
    +    Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: struct submodule_update_clone {
    @@ builtin/submodule--helper.c: static int git_update_clone_config(const char *var,
     +
     +static int run_update_command(struct update_data *ud, int subforce)
     +{
    -+	struct child_process cp = CHILD_PROCESS_INIT;
    ++	struct strvec args = STRVEC_INIT;
    ++	struct strvec child_env = STRVEC_INIT;
     +	char *oid = oid_to_hex(&ud->oid);
     +	int must_die_on_failure = 0;
    ++	int git_cmd;
     +
    -+	cp.dir = xstrdup(ud->sm_path);
     +	switch (ud->update_strategy.type) {
     +	case SM_UPDATE_CHECKOUT:
    -+		cp.git_cmd = 1;
    -+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
    ++		git_cmd = 1;
    ++		strvec_pushl(&args, "checkout", "-q", NULL);
     +		if (subforce)
    -+			strvec_push(&cp.args, "-f");
    ++			strvec_push(&args, "-f");
     +		break;
     +	case SM_UPDATE_REBASE:
    -+		cp.git_cmd = 1;
    -+		strvec_push(&cp.args, "rebase");
    ++		git_cmd = 1;
    ++		strvec_push(&args, "rebase");
     +		if (ud->quiet)
    -+			strvec_push(&cp.args, "--quiet");
    ++			strvec_push(&args, "--quiet");
     +		must_die_on_failure = 1;
     +		break;
     +	case SM_UPDATE_MERGE:
    -+		cp.git_cmd = 1;
    -+		strvec_push(&cp.args, "merge");
    ++		git_cmd = 1;
    ++		strvec_push(&args, "merge");
     +		if (ud->quiet)
    -+			strvec_push(&cp.args, "--quiet");
    ++			strvec_push(&args, "--quiet");
     +		must_die_on_failure = 1;
     +		break;
     +	case SM_UPDATE_COMMAND:
    -+		/* NOTE: this does not handle quoted arguments */
    -+		strvec_split(&cp.args, ud->update_strategy.command);
    ++		git_cmd = 0;
    ++		strvec_push(&args, ud->update_strategy.command);
     +		must_die_on_failure = 1;
     +		break;
    -+	case SM_UPDATE_NONE:
    -+		BUG("this should have been handled before. How did we reach here?");
    -+		break;
    -+	case SM_UPDATE_UNSPECIFIED:
    -+		BUG("update strategy should have been specified");
    ++	default:
    ++		BUG("unexpected update strategy type: %s",
    ++		    submodule_strategy_to_string(&ud->update_strategy));
     +	}
    -+
    -+	strvec_push(&cp.args, oid);
    -+
    -+	prepare_submodule_repo_env(&cp.env_array);
    -+
    -+	if (run_command(&cp)) {
    -+		if (must_die_on_failure) {
    -+			switch (ud->update_strategy.type) {
    -+			case SM_UPDATE_CHECKOUT:
    -+				die(_("Unable to checkout '%s' in submodule path '%s'"),
    -+				      oid, ud->displaypath);
    -+				break;
    -+			case SM_UPDATE_REBASE:
    -+				die(_("Unable to rebase '%s' in submodule path '%s'"),
    -+				      oid, ud->displaypath);
    -+				break;
    -+			case SM_UPDATE_MERGE:
    -+				die(_("Unable to merge '%s' in submodule path '%s'"),
    -+				      oid, ud->displaypath);
    -+				break;
    -+			case SM_UPDATE_COMMAND:
    -+				die(_("Execution of '%s %s' failed in submodule path '%s'"),
    -+				      ud->update_strategy.command, oid, ud->displaypath);
    -+				break;
    -+			case SM_UPDATE_NONE:
    -+				BUG("this should have been handled before. How did we reach here?");
    -+				break;
    -+			case SM_UPDATE_UNSPECIFIED:
    -+				BUG("update strategy should have been specified");
    -+			}
    ++	strvec_push(&args, oid);
    ++
    ++	prepare_submodule_repo_env(&child_env);
    ++	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_SHELL,
    ++				     ud->sm_path, child_env.v)) {
    ++		switch (ud->update_strategy.type) {
    ++		case SM_UPDATE_CHECKOUT:
    ++			printf(_("Unable to checkout '%s' in submodule path '%s'"),
    ++			       oid, ud->displaypath);
    ++			break;
    ++		case SM_UPDATE_REBASE:
    ++			printf(_("Unable to rebase '%s' in submodule path '%s'"),
    ++			       oid, ud->displaypath);
    ++			break;
    ++		case SM_UPDATE_MERGE:
    ++			printf(_("Unable to merge '%s' in submodule path '%s'"),
    ++			       oid, ud->displaypath);
    ++			break;
    ++		case SM_UPDATE_COMMAND:
    ++			printf(_("Execution of '%s %s' failed in submodule path '%s'"),
    ++			       ud->update_strategy.command, oid, ud->displaypath);
    ++			break;
    ++		default:
    ++			BUG("unexpected update strategy type: %s",
    ++			    submodule_strategy_to_string(&ud->update_strategy));
     +		}
     +		/*
    -+		 * This signifies to the caller in shell that
    -+		 * the command failed without dying
    ++		 * NEEDSWORK: We are currently printing to stdout with error
    ++		 * return so that the shell caller handles the error output
    ++		 * properly. Once we start handling the error messages within
    ++		 * C, we should use die() instead.
    ++		 */
    ++		if (must_die_on_failure)
    ++			return 2;
    ++		/*
    ++		 * This signifies to the caller in shell that the command
    ++		 * failed without dying
     +		 */
     +		return 1;
     +	}
    @@ builtin/submodule--helper.c: static int git_update_clone_config(const char *var,
     +		printf(_("Submodule path '%s': '%s %s'\n"),
     +		       ud->displaypath, ud->update_strategy.command, oid);
     +		break;
    -+	case SM_UPDATE_NONE:
    -+		BUG("this should have been handled before. How did we reach here?");
    -+		break;
    -+	case SM_UPDATE_UNSPECIFIED:
    -+		BUG("update strategy should have been specified");
    ++	default:
    ++		BUG("unexpected update strategy type: %s",
    ++		    submodule_strategy_to_string(&ud->update_strategy));
     +	}
     +
     +	return 0;
    @@ builtin/submodule--helper.c: static int git_update_clone_config(const char *var,
     +		 * Run fetch only if `oid` isn't present or it
     +		 * is not reachable from a ref.
     +		 */
    -+		if (!is_tip_reachable(ud->sm_path, &ud->oid))
    -+			if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, NULL) &&
    -+			    !ud->quiet)
    -+				fprintf_ln(stderr,
    -+					   _("Unable to fetch in submodule path '%s'; "
    -+					     "trying to directly fetch %s:"),
    -+					   ud->displaypath, oid_to_hex(&ud->oid));
    ++		if (!is_tip_reachable(ud->sm_path, &ud->oid) &&
    ++		    fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, NULL) &&
    ++		    !ud->quiet)
    ++			fprintf_ln(stderr,
    ++				   _("Unable to fetch in submodule path '%s'; "
    ++				     "trying to directly fetch %s:"),
    ++				   ud->displaypath, oid_to_hex(&ud->oid));
     +		/*
     +		 * Now we tried the usual fetch, but `oid` may
     +		 * not be reachable from any of the refs.
     +		 */
    -+		if (!is_tip_reachable(ud->sm_path, &ud->oid))
    -+			if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
    -+				die(_("Fetched in submodule path '%s', but it did not "
    -+				      "contain %s. Direct fetching of that commit failed."),
    -+				    ud->displaypath, oid_to_hex(&ud->oid));
    ++		if (!is_tip_reachable(ud->sm_path, &ud->oid) &&
    ++		    fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
    ++			die(_("Fetched in submodule path '%s', but it did not "
    ++			      "contain %s. Direct fetching of that commit failed."),
    ++			    ud->displaypath, oid_to_hex(&ud->oid));
     +	}
     +
     +	return run_update_command(ud, subforce);
    @@ builtin/submodule--helper.c: static int update_clone(int argc, const char **argv
     +
     +	free(prefixed_path);
     +
    -+	if ((!is_null_oid(&update_data.oid) && !is_null_oid(&update_data.suboid) &&
    -+	     !oideq(&update_data.oid, &update_data.suboid)) ||
    -+	    is_null_oid(&update_data.suboid) || update_data.force)
    ++	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
     +		return do_run_update_procedure(&update_data);
     +
     +	return 3;
    @@ git-submodule.sh: cmd_update()
     +
     +		# exit codes for run-update-procedure:
     +		# 0: update was successful, say command output
    -+		# 128: subcommand died during execution
     +		# 1: update procedure failed, but should not die
    ++		# 2 or 128: subcommand died during execution
     +		# 3: no update procedure was run
     +		res="$?"
     +		case $res in
     +		0)
     +			say "$out"
     +			;;
    -+		128)
    -+			exit $res
    -+			;;
     +		1)
    -+			err="${err};$out"
    ++			err="${err};fatal: $out"
     +			continue
     +			;;
    ++		2|128)
    ++			die_with_status $res "fatal: $out"
    ++			;;
     +		esac
      
      		if test -n "$recursive"

 builtin/submodule--helper.c | 257 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 104 +++++----------
 2 files changed, 289 insertions(+), 72 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e4..80619361fc 100644
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
+	struct strvec args = STRVEC_INIT;
+	struct strvec child_env = STRVEC_INIT;
+	char *oid = oid_to_hex(&ud->oid);
+	int must_die_on_failure = 0;
+	int git_cmd;
+
+	switch (ud->update_strategy.type) {
+	case SM_UPDATE_CHECKOUT:
+		git_cmd = 1;
+		strvec_pushl(&args, "checkout", "-q", NULL);
+		if (subforce)
+			strvec_push(&args, "-f");
+		break;
+	case SM_UPDATE_REBASE:
+		git_cmd = 1;
+		strvec_push(&args, "rebase");
+		if (ud->quiet)
+			strvec_push(&args, "--quiet");
+		must_die_on_failure = 1;
+		break;
+	case SM_UPDATE_MERGE:
+		git_cmd = 1;
+		strvec_push(&args, "merge");
+		if (ud->quiet)
+			strvec_push(&args, "--quiet");
+		must_die_on_failure = 1;
+		break;
+	case SM_UPDATE_COMMAND:
+		git_cmd = 0;
+		strvec_push(&args, ud->update_strategy.command);
+		must_die_on_failure = 1;
+		break;
+	default:
+		BUG("unexpected update strategy type: %s",
+		    submodule_strategy_to_string(&ud->update_strategy));
+	}
+	strvec_push(&args, oid);
+
+	prepare_submodule_repo_env(&child_env);
+	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_SHELL,
+				     ud->sm_path, child_env.v)) {
+		switch (ud->update_strategy.type) {
+		case SM_UPDATE_CHECKOUT:
+			printf(_("Unable to checkout '%s' in submodule path '%s'"),
+			       oid, ud->displaypath);
+			break;
+		case SM_UPDATE_REBASE:
+			printf(_("Unable to rebase '%s' in submodule path '%s'"),
+			       oid, ud->displaypath);
+			break;
+		case SM_UPDATE_MERGE:
+			printf(_("Unable to merge '%s' in submodule path '%s'"),
+			       oid, ud->displaypath);
+			break;
+		case SM_UPDATE_COMMAND:
+			printf(_("Execution of '%s %s' failed in submodule path '%s'"),
+			       ud->update_strategy.command, oid, ud->displaypath);
+			break;
+		default:
+			BUG("unexpected update strategy type: %s",
+			    submodule_strategy_to_string(&ud->update_strategy));
+		}
+		/*
+		 * NEEDSWORK: We are currently printing to stdout with error
+		 * return so that the shell caller handles the error output
+		 * properly. Once we start handling the error messages within
+		 * C, we should use die() instead.
+		 */
+		if (must_die_on_failure)
+			return 2;
+		/*
+		 * This signifies to the caller in shell that the command
+		 * failed without dying
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
+	default:
+		BUG("unexpected update strategy type: %s",
+		    submodule_strategy_to_string(&ud->update_strategy));
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
+		if (!is_tip_reachable(ud->sm_path, &ud->oid) &&
+		    fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, NULL) &&
+		    !ud->quiet)
+			fprintf_ln(stderr,
+				   _("Unable to fetch in submodule path '%s'; "
+				     "trying to directly fetch %s:"),
+				   ud->displaypath, oid_to_hex(&ud->oid));
+		/*
+		 * Now we tried the usual fetch, but `oid` may
+		 * not be reachable from any of the refs.
+		 */
+		if (!is_tip_reachable(ud->sm_path, &ud->oid) &&
+		    fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
+			die(_("Fetched in submodule path '%s', but it did not "
+			      "contain %s. Direct fetching of that commit failed."),
+			    ud->displaypath, oid_to_hex(&ud->oid));
+	}
+
+	return run_update_command(ud, subforce);
+}
+
 static void update_submodule(struct update_clone_data *ucd)
 {
 	fprintf(stdout, "dummy %s %d\t%s\n",
@@ -2395,6 +2584,73 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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
+	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
+		return do_run_update_procedure(&update_data);
+
+	return 3;
+}
+
 static int resolve_relative_path(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -2951,6 +3207,7 @@ static struct cmd_struct commands[] = {
 	{"add-clone", add_clone, 0},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
+	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index dbd2ec2050..f703cddce8 100755
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
+		# 1: update procedure failed, but should not die
+		# 2 or 128: subcommand died during execution
+		# 3: no update procedure was run
+		res="$?"
+		case $res in
+		0)
+			say "$out"
+			;;
+		1)
+			err="${err};fatal: $out"
+			continue
+			;;
+		2|128)
+			die_with_status $res "fatal: $out"
+			;;
+		esac
 
 		if test -n "$recursive"
 		then
-- 
2.32.0

