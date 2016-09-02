Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DFA1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 16:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbcIBQXh (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:23:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:49441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932495AbcIBQXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:23:36 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MI8iw-1bfJHu3oQI-003uqm; Fri, 02 Sep 2016 18:23:33
 +0200
Date:   Fri, 2 Sep 2016 18:23:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] rebase -i: check for missing commits in the
 rebase--helper
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <6d28acb59d7c217f1f8d6d364e5a52c8bde35085.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jGhD7Pfq50E7/zp8DANoAooO/IBE57o+UK2GV540MQAZKwaP0ZG
 yKcwA66WBKcYDw7Telz/voPS+MIE84mxyTIGX3e6qX1rHOOG/ar989MJq/FclRt9jCG/jin
 dUn/SAUZalHSpKLbWv4LG2Pei2DABCS3uP2FBhtOtZB2R2i1NuH3RitTDFvTdSaGDdNjDNP
 9uhLRUjCZ5lPnKKRH+jhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eiK4OtcSL2A=:x2aV8Gk3j2osk0OuBCfeO0
 yY/rDco3NzTBQ5XJgjlth9K4UVmQNqnFp3cVLeia5VumbdoEINuyS5QsqRLE8WbU+RnEAfJd4
 po6zEo3yyO5aQatiAAXxSaxAwnmZUWLhsl11htx5n6osm/Giu4xrFYHDyVeSmFdfrAFeQRPxh
 xSGKsO1vugaSJVaJe2i2MV6Rv0cdB6fitd8Qex1VXuhI+ux7bDm1c3wjdymd4Yv4c88Y0tz5T
 pGONQGhlWpWa4o3aLXrsbLIT6LNpg//jvsqk++hWaTB43t0q96EjTcpK2yWBkwVV1aAj3kUTW
 ZujaoYIQJOWdt+OIowdEdYRbKqmOSG3rZyvxcvZlk7Zc/GcfMH33/8Fk7Ik1JNS42LSjizkt4
 iko9mHZNyn5tbH3vUIfFn8Ki20FXXFWi77xc08EvQx0Sb2MJzp3VLZFIfqAC5XMGGwaneHuPF
 YU6N80o8h/UGB+bdvBfnZd5+fc4nhMQUDd7nVBxoZfpogt3Nd/GGWa/HfWXIgVN6ygFhYrkkE
 uU6O6XnMctWVKnsPWJxRDITjLbwhMXm8kclTd+3ChMyNDauQXALOp8w+Us+AWlPu6gv7SGUn+
 eiajoi076u8+/5tTsw4anhoJmeozG5C57ngZ9i3Ob64VQVLH/sY7AoXrLEZwkowNQ0rWBnN3R
 dYKe0lOybkR7jjDWt5YRmHJAIP+Lkv8/+kxwAaK2yd4sn+sTJhOIRRP9UsmRUQi6E8GHAwa6V
 7svvQf4HEUIuAvKp2odT+DetA2j48+LGJWU8qpP4H4DITbeIF+vXGda96i3wMjXPNZTi9tqbL
 5IPrnMr
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
 sequencer.c                | 124 ++++++++++++++++++++++++++++++++++
 sequencer.h                |   1 +
 4 files changed, 136 insertions(+), 160 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 9444c8d..e706eac 100644
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
index f642ec2..02a7698 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -880,96 +880,6 @@ add_exec_commands () {
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
@@ -984,74 +894,6 @@ get_missing_commit_check_level () {
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
-		warn "$(gettext "You can fix this with 'git rebase --edit-todo'.")"
-		die "$(gettext "Or you can abort the rebase with 'git rebase --abort'.")"
-	fi
-}
-
 # The whole contents of this file is run by dot-sourcing it from
 # inside a shell function.  It used to be that "return"s we see
 # below were not inside any function, and expected to return
@@ -1315,7 +1157,11 @@ git_sequence_editor "$todo" ||
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
index ee4fdb0..0c82925 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2450,3 +2450,127 @@ int transform_todo_ids(int shorten_sha1s)
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
+	warning(_("Unrecognized setting $check_level for option"
+			"rebase.missingCommitsCheck. Ignoring."));
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
+	struct commit_list *missing = NULL;
+	int raise_error = 0, res = 0, fd, i;
+
+	strbuf_addstr(&todo_file, rebase_path_todo());
+	fd = open(todo_file.buf, O_RDONLY);
+	if (fd < 0) {
+		res = error_errno(_("Could not open %s"), todo_file.buf);
+		goto leave_check;
+	}
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		res = error(_("Could not read %s."), todo_file.buf);
+		goto leave_check;
+	}
+	close(fd);
+	raise_error = res =
+		parse_insn_buffer(todo_list.buf.buf, &todo_list);
+
+	if (check_level == CHECK_IGNORE)
+		goto leave_check;
+
+	/* Get the SHA-1 of the commits */
+	for (i = 0; i < todo_list.nr; i++) {
+		struct commit *commit = todo_list.items[i].commit;
+		if (commit)
+			commit->util = todo_list.items + i;
+	}
+
+	todo_list_release(&todo_list);
+	strbuf_addstr(&todo_file, ".backup");
+	fd = open(todo_file.buf, O_RDONLY);
+	if (fd < 0) {
+		res = error_errno(_("Could not open %s"), todo_file.buf);
+		goto leave_check;
+	}
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		res = error(_("Could not read %s."), todo_file.buf);
+		goto leave_check;
+	}
+	close(fd);
+	strbuf_release(&todo_file);
+	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
+
+	/* Find commits that are missing after editing */
+	for (i = 0; i < todo_list.nr; i++) {
+		struct commit *commit = todo_list.items[i].commit;
+		if (commit && !commit->util) {
+			commit_list_insert(commit, &missing);
+			commit->util = todo_list.items + i;
+		}
+	}
+
+	/* Warn about missing commits */
+	if (!missing)
+		goto leave_check;
+
+	if (check_level == CHECK_ERROR)
+		raise_error = res = 1;
+
+	fprintf(stderr,
+		_("Warning: some commits may have been dropped accidentally.\n"
+		"Dropped commits (newer to older):\n"));
+
+	/* Make the list user-friendly and display */
+	while (missing) {
+		struct commit *commit = pop_commit(&missing);
+		struct todo_item *item = commit->util;
+
+		fprintf(stderr, " - %s %.*s\n", short_commit_name(commit),
+			item->arg_len, item->arg);
+	}
+	free_commit_list(missing);
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
+	if (raise_error)
+		fprintf(stderr,
+			_("You can fix this with 'git rebase --edit-todo'.\n"
+			"Or you can abort the rebase with 'git rebase"
+			" --abort'.\n"));
+
+	return res;
+}
diff --git a/sequencer.h b/sequencer.h
index 5feb525..8e3daf9 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -62,6 +62,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 		int argc, const char **argv);
 
 int transform_todo_ids(int shorten_sha1s);
+int check_todo_list(void);
 
 extern const char sign_off_header[];
 
-- 
2.9.3.windows.3


