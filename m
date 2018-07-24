Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08971F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbeGXRmB (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:42:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35359 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388350AbeGXRmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:42:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so3198971wmc.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3SPA9+vc25GH4cBynvOe8tMpQ36/LFtWvmqyKEHMVaA=;
        b=eQR6kIFPXOQv7rbmo7scLgz3L/bgvqxgrg6I2ODWmWdVGCxTiFDcvlxqjmqv1IONUZ
         lGgsvF1cg3t7T0ZjLZRQ4a7E7cmop40FAf4sc/SNTSxlZ6zcw26c8juXA4D8JkTFgirS
         Ou21h2NY6FEyFT/3Oa96lwELFx6oaNh4WKdVfuagubHYpZHBqkLA3B9EoW37FbMDyx9a
         /FC+SmZNWeAEfISDuljr6aADNsuwcYbwlM3R/ZmLsrg0E40wmIeExhL4Jx2lkKKJyXbO
         t0qMLNM4AEuje4pwDRqEbhjJox10mJBtIActJG1hJIwIeCdzF/HzUM3806eVF2H6obLR
         8Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3SPA9+vc25GH4cBynvOe8tMpQ36/LFtWvmqyKEHMVaA=;
        b=B13EPVouo6Ac0QqtgaiyDc8411RXlQHfQiwIkkaMaQYZJhAbb38xwjlFl4aNYZI6G9
         PIxA3wSkYDrU6PMpyp/TQ3iSdjTaPF9XnSaBuhC0rlcC9bsHP5cIeTOXkKZ6VDushdYb
         nVgCdKzoqpm/d+erE/BWTLZBMEBqJ7xbWCu2hdz19EXyMMxaEMioE2iBJxkxrfbz5dcu
         PwNyXVoH3jwXy5rXmOIaVPaAnhtXPE/g0TMxBbbgwQwa4K3Bvq7CuCo2CJClc2C23Il9
         SW6d8wv+MjwLG4fXNPZKGjDhseVUt9f4QvcgH1DhDT/NnXybR/0UO9/QTOBUveucB9T5
         z04w==
X-Gm-Message-State: AOUpUlG8cSf8tXFRdXwC1905rfAOr73zTU+dkyEDWH7xiblfYxN3rvZG
        62XtkeSTLXfxOq8WWKs2vRpKeEJq
X-Google-Smtp-Source: AAOMgpf/DT00DC6hyOUx5+B33R27AH+za+1mBgsHhYpUtOBjC669Cay06DXuFSS8Wh8ynsyA2qdCug==
X-Received: by 2002:a1c:864c:: with SMTP id i73-v6mr2550480wmd.40.1532450082144;
        Tue, 24 Jul 2018 09:34:42 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:41 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 18/20] rebase--interactive2: rewrite the submodes of interactive rebase in C
Date:   Tue, 24 Jul 2018 18:32:19 +0200
Message-Id: <20180724163221.15201-19-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
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
 builtin/rebase--interactive2.c | 47 +++++++++++++++++++++++++++++++---
 git-rebase.sh                  | 45 +++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase--interactive2.c b/builtin/rebase--interactive2.c
index e89ef71499..53b4f7483d 100644
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
index 86da3816be..65e909d7bd 100755
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

