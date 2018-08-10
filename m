Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691D21F405
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeHJTXY (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34232 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbeHJTXY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so8896841wrt.1
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aGqcbmtYwhWIgyxobTlIvb/C8h4ngjITnTXsrzjlZSI=;
        b=jeOcAn3kVD3Bvex4uC4gyAgf45+3UMBGloK4gxgXOBz/iXL12ZsAMcgzZyM7vqAxQy
         2tFEAFmM26i+9/Uxcq47AHcH3rL8JHI9NOk69YFJJBYspunODgt0P6N1yAgEhQtTsory
         RzohMMsFWyKuyuuk5ZH3glfyI1D4eONSPflNGairrlnitZdUHLaHD/F6AD7ml/Pp0WKe
         KLnI3jtsy1dnFE0U5tuw54za9zeXbYWZt9Z0Bdo4FPeY8SZREF9ekD7CKP0vIC69tmcS
         54JJdFCyvOQX0V5AfkchFr9Zr6eKFTddnOUZdQS3XXLT9fZd5f+ZJuR50L/tc7zzyhnB
         i1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aGqcbmtYwhWIgyxobTlIvb/C8h4ngjITnTXsrzjlZSI=;
        b=cmJx+9gOjdUrus1TXjsHtywT2zixrrwzpe2/YqsTNSfo60gr7HAHybBOIo2HhS5edU
         7qba7tM4NLVKTVWIorkMYGuEy3A97XniRhmNIaFQUeWa5Pdl3S5lZriekdvOPj8MrbkG
         q+nANXgYqaEijvxMAKPacRvZ6gjBZ1OnQnxVh899oMhZuYLtoRVxnGSYUPBFZwaZZtfg
         N0xcEiAtrjk18rUevP8eT/qYXm3rCVynqAWE70IV+EjaVR+fiiuh0Z0N61Hw45Hx0c/5
         tLzDtIsk7fnWy6lt4wBZn6IRSLdoGlCnw+5lbVNKGstSF9UB/89gyL1LVGIzVDzndOl4
         TJBw==
X-Gm-Message-State: AOUpUlFRiHa+QX1X2t0qh1B2OfZygdP83qd2w2yjnF2VAL/0rXPUr51o
        nDHrOjHomslqVmzXBXWRlOQHo1Vh
X-Google-Smtp-Source: AA+uWPwFpraEThS5nYltdcY0eC0AHJ6+laiYPAgN2MvnI2WSBtLZKoJpPBhkVK8tNGtUQcT0mB9jqg==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr4796410wra.120.1533919964274;
        Fri, 10 Aug 2018 09:52:44 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:43 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 18/20] rebase--interactive2: rewrite the submodes of interactive rebase in C
Date:   Fri, 10 Aug 2018 18:51:45 +0200
Message-Id: <20180810165147.4779-19-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the submodes of interactive rebase (`--continue`,
`--skip`, `--edit-todo`, and `--show-current-patch`) in C.

git-rebase.sh is then modified to call directly git-rebase--interactive2
instead of git-rebase--interactive.sh.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v5.

 builtin/rebase--interactive2.c | 47 +++++++++++++++++++++++++++++++---
 git-rebase.sh                  | 45 +++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase--interactive2.c b/builtin/rebase--interactive2.c
index b0a1ca25fe..9a21855ede 100644
--- a/builtin/rebase--interactive2.c
+++ b/builtin/rebase--interactive2.c
@@ -134,11 +134,14 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1;
+	int abbreviate_commands = 0, rebase_cousins = -1, ret = 0;
 	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
 		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
 		*switch_to = NULL, *cmd = NULL;
 	char *raw_strategies = NULL;
+	enum {
+		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH
+	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
 		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
@@ -151,6 +154,13 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			 N_("move commits that begin with squash!/fixup!")),
 		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
 		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
+		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
+			    CONTINUE),
+		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), SKIP),
+		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
+			    EDIT_TODO),
+		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
+			    SHOW_CURRENT_PATCH),
 		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
 		OPT_STRING(0, "restrict-revision", &restrict_revision,
 			   N_("restrict-revision"), N_("restrict revision")),
@@ -194,7 +204,36 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	return !!do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
-				       onto_name, squash_onto, head_name, restrict_revision,
-				       raw_strategies, cmd, autosquash);
+	switch (command) {
+	case NONE:
+		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
+					    onto_name, squash_onto, head_name, restrict_revision,
+					    raw_strategies, cmd, autosquash);
+		break;
+	case SKIP: {
+		struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+		rerere_clear(&merge_rr);
+		/* fallthrough */
+	case CONTINUE:
+		ret = sequencer_continue(&opts);
+		break;
+	}
+	case EDIT_TODO:
+		ret = edit_todo_list(flags);
+		break;
+	case SHOW_CURRENT_PATCH: {
+		struct child_process cmd = CHILD_PROCESS_INIT;
+
+		cmd.git_cmd = 1;
+		argv_array_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
+		ret = run_command(&cmd);
+
+		break;
+	}
+	default:
+		BUG("invalid command '%d'", command);
+	}
+
+	return !!ret;
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index 51a6db7daa..d5950a3012 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -200,19 +200,56 @@ finish_rebase () {
 	rm -rf "$state_dir"
 }
 
+run_interactive () {
+	GIT_CHERRY_PICK_HELP="$resolvemsg"
+	export GIT_CHERRY_PICK_HELP
+
+	test -n "$keep_empty" && keep_empty="--keep-empty"
+	test -n "$rebase_merges" && rebase_merges="--rebase-merges"
+	test -n "$rebase_cousins" && rebase_cousins="--rebase-cousins"
+	test -n "$autosquash" && autosquash="--autosquash"
+	test -n "$verbose" && verbose="--verbose"
+	test -n "$force_rebase" && force_rebase="--no-ff"
+	test -n "$restrict_revisions" && \
+		restrict_revisions="--restrict-revisions=^$restrict_revisions"
+	test -n "$upstream" && upstream="--upstream=$upstream"
+	test -n "$onto" && onto="--onto=$onto"
+	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
+	test -n "$onto_name" && onto_name="--onto-name=$onto_name"
+	test -n "$head_name" && head_name="--head-name=$head_name"
+	test -n "$strategy" && strategy="--strategy=$strategy"
+	test -n "$strategy_opts" && strategy_opts="--strategy-opts=$strategy_opts"
+	test -n "$switch_to" && switch_to="--switch-to=$switch_to"
+	test -n "$cmd" && cmd="--cmd=$cmd"
+	test -n "$action" && action="--$action"
+
+	exec git rebase--interactive2 "$action" "$keep_empty" "$rebase_merges" "$rebase_cousins" \
+		"$upstream" "$onto" "$squash_onto" "$restrict_revision" \
+		"$allow_empty_message" "$autosquash" "$verbose" \
+		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
+		"$strategy_opts" "$cmd" "$switch_to" \
+		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff"
+}
+
 run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
 		export GIT_EDITOR
 		autosquash=
 	fi
-	. git-rebase--$type
 
-	if test -z "$preserve_merges"
+	if test -n "$interactive_rebase" -a -z "$preserve_merges"
 	then
-		git_rebase__$type
+		run_interactive
 	else
-		git_rebase__preserve_merges
+		. git-rebase--$type
+
+		if test -z "$preserve_merges"
+		then
+			git_rebase__$type
+		else
+			git_rebase__preserve_merges
+		fi
 	fi
 
 	ret=$?
-- 
2.18.0

