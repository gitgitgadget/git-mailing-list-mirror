Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3491FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 13:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1431365AbdDYNwe (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 09:52:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:49839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1430832AbdDYNwb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 09:52:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhwLy-1cGDsi3fXe-00nCrd; Tue, 25
 Apr 2017 15:52:06 +0200
Date:   Tue, 25 Apr 2017 15:52:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 6/9] rebase -i: check for missing commits in the
 rebase--helper
In-Reply-To: <cover.1493128210.git.johannes.schindelin@gmx.de>
Message-ID: <01e494b3c7a713ba42c6a197e91e0d62ec19709f.1493128210.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <cover.1493128210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eMnTRwNh86dDM2/rUEIM5sKLavdx6Sc7v5R74JqkWBdfIVNG16n
 qCvPbZsZDVu+Qp6Bki/UYT8QTMRTDUVBS64P4+hmYMmI013m9EbP+557nVAa8vJaPcMjGrl
 wcMMSqdakEoBCVJWKmL+WZ4IIVN/AfGgVDfXbloZzeNkUltMrOihQ626vYGQU/YnsFuaXoe
 hBb8K1ng0K2UpSqlxjTxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vcF7udEidvE=:pUOJ5y1ClF17xyPPvT1K8V
 hSEh9ObA4kmw5QtDgywHttkDksRdZQXXffSPq0QVTfieFOT3UVQtWqpRg++Is8ea/+TzpNvnV
 +eqKI9YyZwy7ADXKx/lGskFNGunoF6rVRYeBMHopYCyzRYuTnLINe+R5n0DX476nAcbtmKzQf
 JWAFv6IswdPgixSmjjSc7zrQZw+Y3Wn4hrK9g3UPVMfSgBMy4ojwbBIO310grJCySYzC8bGaQ
 fC75dvVEm1SPIOaJjA5dBxfPkowiSuSEq4ZlWq0mq8mUaXnErQlONdyHgqpRUlX7lGDS8DNAx
 QvB9LIqIWhg++NdUvFDIsLAsBpFeJR5aKKpqHjJn7JOO/8Zlja/P0z8Z+ySiaQVr9iy0QtUUD
 rPnscWiFww/RVpVzaDhK6xmjtLSU4AMuvNrz7aqqDGT57xecHqVN/2WR4q2GxBiHStK3F/2hd
 qlW5HSLvLbrzpmyZsLQMBYJAqPQ8potMqvs2t/ieIAqCcO92z1G/eErj55JBlhfK7GIG4NPse
 UAWQqhgJV+Cnl/q2UgCHJDfNDibzC7WHHKJzBrla38bnITOSRyFzlnDN+Ab9PCG7Rm/SaNfuh
 rD0MpogthB5SYMcnR9A1UtW8Lj+EBs9G6fCO6439ZMzMf7D/wM6r+EyoyRRjxh+CzBVF9z/cg
 GMcIDFYmUQAD5PhdY2NdVCyl2tijQNDpoOrO7WNnKNELKr28Ysj7UaFK46+joST5MWhN943As
 uvwgIeE75YDTn+pfDTJBwKxWQj8ej7+BmMkT+wR4AyPr37sF5qxS2jaPe+Kvlljg0i6e6kuVs
 crPkJ3P
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
 sequencer.c                | 125 ++++++++++++++++++++++++++++++++++
 sequencer.h                |   1 +
 4 files changed, 137 insertions(+), 160 deletions(-)

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
index 52a19e0bdb3..1649506e1e4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -890,96 +890,6 @@ add_exec_commands () {
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
@@ -994,74 +904,6 @@ get_missing_commit_check_level () {
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
@@ -1322,7 +1164,11 @@ git_sequence_editor "$todo" ||
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
index d6ae6407546..3a935fa4cbc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2491,3 +2491,128 @@ int transform_todo_ids(int shorten_sha1s)
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
+	struct commit_list *missing = NULL;
+	int raise_error = 0, res = 0, fd, i;
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
2.12.2.windows.2.406.gd14a8f8640f


