Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF26F207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2992660AbdD1Vc7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:32:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:64236 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2992569AbdD1Vc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:32:56 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiWzQ-1dga3f0ZX2-00cfNQ; Fri, 28
 Apr 2017 23:32:47 +0200
Date:   Fri, 28 Apr 2017 23:32:45 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 07/10] rebase -i: check for missing commits in the
 rebase--helper
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
Message-ID: <feceef9a82dbb198e965074b518db6170f5c8892.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TbgIwrVc4glJuRCwmADLXPcLiy3vwxPdhUZzBpld1FgsZkQi/e+
 Ea3TTtK+rdPQjM+63S44h65Wd+zzvtNqlxJ7SLeMOFgmbjuSHN5Z+1IdMKYRL8M8Es1+G3k
 /5tznTnlQ4wFYC5H9HsCXCn1zKfS0nwMMI4Kp9+EoumRtiK+L7BT/IDJ6b5FSeElgKhuHEm
 xdJ0cV0QJ4HfN7K7DaMlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1fNxoAEbyt4=:vQ9XpnKwGGaDqiEL6s3VHm
 8i7QAeXarNpBGEEXmO6s6Y6uwwPJn6Yqt28N6uC0Z7r6sk38Mb7HkdezjECzfo3I2lAxo3B0K
 N9Y74xNhHQAOTOYqQL+ivauP0K+Fvehqglr8WPmG1Y+ine3oPAUJIEAm997mc19hOCDWthrjl
 losLQszlm0MNQrpboos8dxno/rMWlBl3ddp3wBy5yo06uysmdBn3MgaH0XegnxuVk515HGFZZ
 gZNnqpZGScLbcUwSZd2x+PlPzKLitJ8QJkMGwHc4ahon5j6mrlCFZQEghYMQRDQjPcIalaldU
 oRfLIg2MA9BZlK+RPL+q2PBGnFRL8Ok5hHqDtJh5AgGbARIGqvKXT9MAYBvR+EZy1ne+nvXqv
 rxdJkaWX3QmYQc7kAbWP5thgGNMhrbZZvxbSNis1DiUxRGCmPJVj9pA16jdCNRS6czRMg04/N
 rOeuCDucmteL2RF95R53jWq4RDd9o3Sg80COVqBa2pNTRoEJ69h8mkSPdZXV/EEFc/kVsMn0E
 VtUtY6Yb6Crv5rLvAYP/SHBBfzKgI9mKR5SVFY7Mi2HfMygPm5+KTxj5sw7AGHIK33ZbSEtq0
 zGW27HlI4fO+xReV5QIEYSMqruypevz67dxOhMwISdNq/5tsdDH/s7OxGnwZNFo7HLbjBXnnH
 YB0GNTWMyBCYyKu45rTryy2udrweEXLWOC6RKbprAhlsZwSfd+vRjxXZGk4FJFwgvYYhaTjAV
 r24WmaTnTCbi0QFklnC9QwfCXctEl+6p151Z7M/rd478tdz6Q9HQvvo4+X3vowdCMj/yK7aqJ
 oRYjyhY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular on Windows, where shell scripts are even more expensive
than on MacOSX or Linux, it makes sense to move a loop that forks
Git at least once for every line in the todo list into a builtin.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase--helper.c   |   7 +-
 git-rebase--interactive.sh | 164 ++-------------------------------------------
 sequencer.c                | 122 +++++++++++++++++++++++++++++++++
 sequencer.h                |   1 +
 4 files changed, 134 insertions(+), 160 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 9444c8d6c60..e706eac710d 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,7 +13,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int keep_empty = 0;
 	enum {
-		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S
+		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
+		CHECK_TODO_LIST
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -28,6 +29,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("shorten SHA-1s in the todo list"), SHORTEN_SHA1S),
 		OPT_CMDMODE(0, "expand-sha1s", &command,
 			N_("expand SHA-1s in the todo list"), EXPAND_SHA1S),
+		OPT_CMDMODE(0, "check-todo-list", &command,
+			N_("check the todo list"), CHECK_TODO_LIST),
 		OPT_END()
 	};
 
@@ -50,5 +53,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!transform_todo_ids(1);
 	if (command == EXPAND_SHA1S && argc == 1)
 		return !!transform_todo_ids(0);
+	if (command == CHECK_TODO_LIST && argc == 1)
+		return !!check_todo_list();
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 82a1941c42c..08168a0d46b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -867,96 +867,6 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
 
-# Check if the SHA-1 passed as an argument is a
-# correct one, if not then print $2 in "$todo".badsha
-# $1: the SHA-1 to test
-# $2: the line number of the input
-# $3: the input filename
-check_commit_sha () {
-	badsha=0
-	if test -z "$1"
-	then
-		badsha=1
-	else
-		sha1_verif="$(git rev-parse --verify --quiet $1^{commit})"
-		if test -z "$sha1_verif"
-		then
-			badsha=1
-		fi
-	fi
-
-	if test $badsha -ne 0
-	then
-		line="$(sed -n -e "${2}p" "$3")"
-		warn "$(eval_gettext "\
-Warning: the SHA-1 is missing or isn't a commit in the following line:
- - \$line")"
-		warn
-	fi
-
-	return $badsha
-}
-
-# prints the bad commits and bad commands
-# from the todolist in stdin
-check_bad_cmd_and_sha () {
-	retval=0
-	lineno=0
-	while read -r command rest
-	do
-		lineno=$(( $lineno + 1 ))
-		case $command in
-		"$comment_char"*|''|noop|x|exec)
-			# Doesn't expect a SHA-1
-			;;
-		"$cr")
-			# Work around CR left by "read" (e.g. with Git for
-			# Windows' Bash).
-			;;
-		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
-			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"
-			then
-				retval=1
-			fi
-			;;
-		*)
-			line="$(sed -n -e "${lineno}p" "$1")"
-			warn "$(eval_gettext "\
-Warning: the command isn't recognized in the following line:
- - \$line")"
-			warn
-			retval=1
-			;;
-		esac
-	done <"$1"
-	return $retval
-}
-
-# Print the list of the SHA-1 of the commits
-# from stdin to stdout
-todo_list_to_sha_list () {
-	git stripspace --strip-comments |
-	while read -r command sha1 rest
-	do
-		case $command in
-		"$comment_char"*|''|noop|x|"exec")
-			;;
-		*)
-			long_sha=$(git rev-list --no-walk "$sha1" 2>/dev/null)
-			printf "%s\n" "$long_sha"
-			;;
-		esac
-	done
-}
-
-# Use warn for each line in stdin
-warn_lines () {
-	while read -r line
-	do
-		warn " - $line"
-	done
-}
-
 # Switch to the branch in $into and notify it in the reflog
 checkout_onto () {
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
@@ -971,74 +881,6 @@ get_missing_commit_check_level () {
 	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
 }
 
-# Check if the user dropped some commits by mistake
-# Behaviour determined by rebase.missingCommitsCheck.
-# Check if there is an unrecognized command or a
-# bad SHA-1 in a command.
-check_todo_list () {
-	raise_error=f
-
-	check_level=$(get_missing_commit_check_level)
-
-	case "$check_level" in
-	warn|error)
-		# Get the SHA-1 of the commits
-		todo_list_to_sha_list <"$todo".backup >"$todo".oldsha1
-		todo_list_to_sha_list <"$todo" >"$todo".newsha1
-
-		# Sort the SHA-1 and compare them
-		sort -u "$todo".oldsha1 >"$todo".oldsha1+
-		mv "$todo".oldsha1+ "$todo".oldsha1
-		sort -u "$todo".newsha1 >"$todo".newsha1+
-		mv "$todo".newsha1+ "$todo".newsha1
-		comm -2 -3 "$todo".oldsha1 "$todo".newsha1 >"$todo".miss
-
-		# Warn about missing commits
-		if test -s "$todo".miss
-		then
-			test "$check_level" = error && raise_error=t
-
-			warn "$(gettext "\
-Warning: some commits may have been dropped accidentally.
-Dropped commits (newer to older):")"
-
-			# Make the list user-friendly and display
-			opt="--no-walk=sorted --format=oneline --abbrev-commit --stdin"
-			git rev-list $opt <"$todo".miss | warn_lines
-
-			warn "$(gettext "\
-To avoid this message, use \"drop\" to explicitly remove a commit.
-
-Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
-The possible behaviours are: ignore, warn, error.")"
-			warn
-		fi
-		;;
-	ignore)
-		;;
-	*)
-		warn "$(eval_gettext "Unrecognized setting \$check_level for option rebase.missingCommitsCheck. Ignoring.")"
-		;;
-	esac
-
-	if ! check_bad_cmd_and_sha "$todo"
-	then
-		raise_error=t
-	fi
-
-	if test $raise_error = t
-	then
-		# Checkout before the first commit of the
-		# rebase: this way git rebase --continue
-		# will work correctly as it expects HEAD to be
-		# placed before the commit of the next action
-		checkout_onto
-
-		warn "$(gettext "You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.")"
-		die "$(gettext "Or you can abort the rebase with 'git rebase --abort'.")"
-	fi
-}
-
 # The whole contents of this file is run by dot-sourcing it from
 # inside a shell function.  It used to be that "return"s we see
 # below were not inside any function, and expected to return
@@ -1299,7 +1141,11 @@ git_sequence_editor "$todo" ||
 has_action "$todo" ||
 	return 2
 
-check_todo_list
+git rebase--helper --check-todo-list || {
+	ret=$?
+	checkout_onto
+	exit $ret
+}
 
 expand_todo_ids
 
diff --git a/sequencer.c b/sequencer.c
index 201d45b1677..4535ba9d12f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2494,3 +2494,125 @@ int transform_todo_ids(int shorten_sha1s)
 	todo_list_release(&todo_list);
 	return 0;
 }
+
+enum check_level {
+	CHECK_IGNORE = 0, CHECK_WARN, CHECK_ERROR
+};
+
+static enum check_level get_missing_commit_check_level(void)
+{
+	const char *value;
+
+	if (git_config_get_value("rebase.missingcommitscheck", &value) ||
+			!strcasecmp("ignore", value))
+		return CHECK_IGNORE;
+	if (!strcasecmp("warn", value))
+		return CHECK_WARN;
+	if (!strcasecmp("error", value))
+		return CHECK_ERROR;
+	warning(_("unrecognized setting %s for option"
+		  "rebase.missingCommitsCheck. Ignoring."), value);
+	return CHECK_IGNORE;
+}
+
+/*
+ * Check if the user dropped some commits by mistake
+ * Behaviour determined by rebase.missingCommitsCheck.
+ * Check if there is an unrecognized command or a
+ * bad SHA-1 in a command.
+ */
+int check_todo_list(void)
+{
+	enum check_level check_level = get_missing_commit_check_level();
+	struct strbuf todo_file = STRBUF_INIT;
+	struct todo_list todo_list = TODO_LIST_INIT;
+	struct strbuf missing = STRBUF_INIT;
+	int advise_to_edit_todo = 0, res = 0, fd, i;
+
+	strbuf_addstr(&todo_file, rebase_path_todo());
+	fd = open(todo_file.buf, O_RDONLY);
+	if (fd < 0) {
+		res = error_errno(_("could not open '%s'"), todo_file.buf);
+		goto leave_check;
+	}
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		res = error(_("could not read '%s'."), todo_file.buf);
+		goto leave_check;
+	}
+	close(fd);
+	advise_to_edit_todo = res =
+		parse_insn_buffer(todo_list.buf.buf, &todo_list);
+
+	if (res || check_level == CHECK_IGNORE)
+		goto leave_check;
+
+	/* Mark the commits in git-rebase-todo as seen */
+	for (i = 0; i < todo_list.nr; i++) {
+		struct commit *commit = todo_list.items[i].commit;
+		if (commit)
+			commit->util = (void *)1;
+	}
+
+	todo_list_release(&todo_list);
+	strbuf_addstr(&todo_file, ".backup");
+	fd = open(todo_file.buf, O_RDONLY);
+	if (fd < 0) {
+		res = error_errno(_("could not open '%s'"), todo_file.buf);
+		goto leave_check;
+	}
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		res = error(_("could not read '%s'."), todo_file.buf);
+		goto leave_check;
+	}
+	close(fd);
+	strbuf_release(&todo_file);
+	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
+
+	/* Find commits in git-rebase-todo.backup yet unseen */
+	for (i = todo_list.nr - 1; i >= 0; i--) {
+		struct todo_item *item = todo_list.items + i;
+		struct commit *commit = item->commit;
+		if (commit && !commit->util) {
+			strbuf_addf(&missing, " - %s %.*s\n",
+				    short_commit_name(commit),
+				    item->arg_len, item->arg);
+			commit->util = (void *)1;
+		}
+	}
+
+	/* Warn about missing commits */
+	if (!missing.len)
+		goto leave_check;
+
+	if (check_level == CHECK_ERROR)
+		advise_to_edit_todo = res = 1;
+
+	fprintf(stderr,
+		_("Warning: some commits may have been dropped accidentally.\n"
+		"Dropped commits (newer to older):\n"));
+
+	/* Make the list user-friendly and display */
+	fputs(missing.buf, stderr);
+	strbuf_release(&missing);
+
+	fprintf(stderr, _("To avoid this message, use \"drop\" to "
+		"explicitly remove a commit.\n\n"
+		"Use 'git config rebase.missingCommitsCheck' to change "
+		"the level of warnings.\n"
+		"The possible behaviours are: ignore, warn, error.\n\n"));
+
+leave_check:
+	strbuf_release(&todo_file);
+	todo_list_release(&todo_list);
+
+	if (advise_to_edit_todo)
+		fprintf(stderr,
+			_("You can fix this with 'git rebase --edit-todo' "
+			  "and then run 'git rebase --continue'.\n"
+			  "Or you can abort the rebase with 'git rebase"
+			  " --abort'.\n"));
+
+	return res;
+}
diff --git a/sequencer.h b/sequencer.h
index 47a81034e76..4978a61b83b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -49,6 +49,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 		int argc, const char **argv);
 
 int transform_todo_ids(int shorten_sha1s);
+int check_todo_list(void);
 
 extern const char sign_off_header[];
 
-- 
2.12.2.windows.2.800.gede8f145e06


