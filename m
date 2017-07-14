Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CF8520357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932096AbdGNOpu (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:45:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:64284 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932070AbdGNOpt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:45:49 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmrUq-1e8Ms50fGO-00h88v; Fri, 14
 Jul 2017 16:45:33 +0200
Date:   Fri, 14 Jul 2017 16:45:31 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v6 10/10] rebase -i: rearrange fixup/squash lines using the
 rebase--helper
In-Reply-To: <cover.1500043436.git.johannes.schindelin@gmx.de>
Message-ID: <79a6c70b25e2461e8f2a058932f6c2481a8411f6.1500043437.git.johannes.schindelin@gmx.de>
References: <cover.1500043436.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:m+fNMT+0ZtaZFSZqR8jWMBrMJ0kZOVmCYGnsMWSbq4ZLiVu9ONv
 VI1rN16gFo7cUj32ShOntFdG9F4FY6/FgeLNubje2YanL/FW3sFOzutWdB9+Oqj/o4ggZ0e
 IaoOML4UTY0kz0NAo7h0IGF/6awdZF/SSiLJVAOdIY+0b0tcyu7AMpFwerjhWHjrDUYc709
 KRwo5PlqC0YkVq7+zbChQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Lot+3J/PgY=:12MeDROd+XLoYdE38xlkdS
 J/2sk5dAf/9GGebHCs6KeJCRq9RVwE+r6Q+r1maEyNUI5H5HYMhVLKeEZwCOy7H7gY4bOe3ZF
 APsXCWd+NdY0BFYn+G3HKd5+imeQOiygS8Gq/582lKe6xbupW6c03hcvPIc+zEPHck7GxO2pe
 eltGjgsQeOJze0dntF6sG/goTI6iaOt9sXXY403sp0q2oGJN+0AeVwwZFNSDOL5QT0p8k3Tv8
 OYthT13WmIizNW1eag/X7Tmt2jB10AHatSDIj/yky2UuvaJr2ZC5PE1N4u+jcs0qmWbAVt5cr
 ZJgbkPINMdalGSVy8bBqaCUYLgy3u02UQlwp4BFS5kWThGry5y4RAk5gyKV/04uOWsIIGkMRC
 1ZDizhfV5Gby6tD9TM+6h/jv8JMHG5zRmuyKfegz+gjutP8uNc7QDS+0PZGY1ZBYa89z88cNQ
 df6d0GaXz2e2NSOL77nInaV6iD3ezw3fOPUxE3tX5bwujZ7715tFMmiBdEOIaiRVJTUF9Odu4
 nIY0UmKthXuxiHg/PvbGU1C/g2QtA1MNTxgRTrvdah35loVuIF4jTjkrKu1WdEA41L8ax3YXr
 3yd/14+kbxMD9qlFjaXOQGkxhlw9SRB1FXqivUIvoKCFfPc+FiGKhzlKsVy2xXgrDi8CO/Eyn
 AJ5FQqOnRT8+kUW10m+cJJl4n1Utd9QgTsfd+lgdYkmJ7Sor2RncnLjie7qaV74VrN2oWxEIr
 EKGNiGG0rLWbuTyjeeOsFwhdbrMDHW1PQnumPqBa7sam2zRV/RQ0Am4MujxCjK9+HGv8gvFI2
 x4YhXCXWz0L1tOk85ErfkhOTTshxZ0xaMcob3dG4yPHNSyobDI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This operation has quadratic complexity, which is especially painful
on Windows, where shell scripts are *already* slow (mainly due to the
overhead of the POSIX emulation layer).

Let's reimplement this with linear complexity (using a hash map to
match the commits' subject lines) for the common case; Sadly, the
fixup/squash feature's design neglected performance considerations,
allowing arbitrary prefixes (read: `fixup! hell` will match the
commit subject `hello world`), which means that we are stuck with
quadratic performance in the worst case.

The reimplemented logic also happens to fix a bug where commented-out
lines (representing empty patches) were dropped by the previous code.

While at it, clarify how the fixup/squash feature works in `git rebase
-i`'s man page.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt |  16 ++--
 builtin/rebase--helper.c     |   6 +-
 git-rebase--interactive.sh   |  90 +-------------------
 sequencer.c                  | 196 +++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                  |   1 +
 t/t3415-rebase-autosquash.sh |   2 +-
 6 files changed, 213 insertions(+), 98 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 4f6bed61a92..a3c01dfdc8a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -430,13 +430,15 @@ without an explicit `--interactive`.
 --autosquash::
 --no-autosquash::
 	When the commit log message begins with "squash! ..." (or
-	"fixup! ..."), and there is a commit whose title begins with
-	the same ..., automatically modify the todo list of rebase -i
-	so that the commit marked for squashing comes right after the
-	commit to be modified, and change the action of the moved
-	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
-	"fixup! " or "squash! " after the first, in case you referred to an
-	earlier fixup/squash with `git commit --fixup/--squash`.
+	"fixup! ..."), and there is already a commit in the todo list that
+	matches the same `...`, automatically modify the todo list of rebase
+	-i so that the commit marked for squashing comes right after the
+	commit to be modified, and change the action of the moved commit
+	from `pick` to `squash` (or `fixup`).  A commit matches the `...` if
+	the commit subject matches, or if the `...` refers to the commit's
+	hash. As a fall-back, partial matches of the commit subject work,
+	too.  The recommended way to create fixup/squash commits is by using
+	the `--fixup`/`--squash` options of linkgit:git-commit[1].
 +
 This option is only valid when the `--interactive` option is used.
 +
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 057ae7102ff..f8519363a39 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -15,7 +15,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	int keep_empty = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
-		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS
+		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -34,6 +34,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("check the todo list"), CHECK_TODO_LIST),
 		OPT_CMDMODE(0, "skip-unnecessary-picks", &command,
 			N_("skip unnecessary picks"), SKIP_UNNECESSARY_PICKS),
+		OPT_CMDMODE(0, "rearrange-squash", &command,
+			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
 		OPT_END()
 	};
 
@@ -60,5 +62,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!check_todo_list();
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
 		return !!skip_unnecessary_picks();
+	if (command == REARRANGE_SQUASH && argc == 1)
+		return !!rearrange_squash();
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index af8d7bd77fb..3b0340e7cc9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -721,94 +721,6 @@ collapse_todo_ids() {
 	git rebase--helper --shorten-ids
 }
 
-# Rearrange the todo list that has both "pick sha1 msg" and
-# "pick sha1 fixup!/squash! msg" appears in it so that the latter
-# comes immediately after the former, and change "pick" to
-# "fixup"/"squash".
-#
-# Note that if the config has specified a custom instruction format
-# each log message will be re-retrieved in order to normalize the
-# autosquash arrangement
-rearrange_squash () {
-	format=$(git config --get rebase.instructionFormat)
-	# extract fixup!/squash! lines and resolve any referenced sha1's
-	while read -r pick sha1 message
-	do
-		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
-		case "$message" in
-		"squash! "*|"fixup! "*)
-			action="${message%%!*}"
-			rest=$message
-			prefix=
-			# skip all squash! or fixup! (but save for later)
-			while :
-			do
-				case "$rest" in
-				"squash! "*|"fixup! "*)
-					prefix="$prefix${rest%%!*},"
-					rest="${rest#*! }"
-					;;
-				*)
-					break
-					;;
-				esac
-			done
-			printf '%s %s %s %s\n' "$sha1" "$action" "$prefix" "$rest"
-			# if it's a single word, try to resolve to a full sha1 and
-			# emit a second copy. This allows us to match on both message
-			# and on sha1 prefix
-			if test "${rest#* }" = "$rest"; then
-				fullsha="$(git rev-parse -q --verify "$rest" 2>/dev/null)"
-				if test -n "$fullsha"; then
-					# prefix the action to uniquely identify this line as
-					# intended for full sha1 match
-					echo "$sha1 +$action $prefix $fullsha"
-				fi
-			fi
-		esac
-	done >"$1.sq" <"$1"
-	test -s "$1.sq" || return
-
-	used=
-	while read -r pick sha1 message
-	do
-		case " $used" in
-		*" $sha1 "*) continue ;;
-		esac
-		printf '%s\n' "$pick $sha1 $message"
-		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
-		used="$used$sha1 "
-		while read -r squash action msg_prefix msg_content
-		do
-			case " $used" in
-			*" $squash "*) continue ;;
-			esac
-			emit=0
-			case "$action" in
-			+*)
-				action="${action#+}"
-				# full sha1 prefix test
-				case "$msg_content" in "$sha1"*) emit=1;; esac ;;
-			*)
-				# message prefix test
-				case "$message" in "$msg_content"*) emit=1;; esac ;;
-			esac
-			if test $emit = 1; then
-				if test -n "${format}"
-				then
-					msg_content=$(git log -n 1 --format="${format}" ${squash})
-				else
-					msg_content="$(echo "$msg_prefix" | sed "s/,/! /g")$msg_content"
-				fi
-				printf '%s\n' "$action $squash $msg_content"
-				used="$used$squash "
-			fi
-		done <"$1.sq"
-	done >"$1.rearranged" <"$1"
-	cat "$1.rearranged" >"$1"
-	rm -f "$1.sq" "$1.rearranged"
-}
-
 # Add commands after a pick or after a squash/fixup serie
 # in the todo list.
 add_exec_commands () {
@@ -1068,7 +980,7 @@ then
 fi
 
 test -s "$todo" || echo noop >> "$todo"
-test -n "$autosquash" && rearrange_squash "$todo"
+test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
 test -n "$cmd" && add_exec_commands "$todo"
 
 todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
diff --git a/sequencer.c b/sequencer.c
index 96d43aec764..c54596f9699 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -20,6 +20,7 @@
 #include "trailer.h"
 #include "log-tree.h"
 #include "wt-status.h"
+#include "hashmap.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2748,3 +2749,198 @@ int skip_unnecessary_picks(void)
 
 	return 0;
 }
+
+struct subject2item_entry {
+	struct hashmap_entry entry;
+	int i;
+	char subject[FLEX_ARRAY];
+};
+
+static int subject2item_cmp(const void *fndata,
+			    const struct subject2item_entry *a,
+			    const struct subject2item_entry *b, const void *key)
+{
+	return key ? strcmp(a->subject, key) : strcmp(a->subject, b->subject);
+}
+
+/*
+ * Rearrange the todo list that has both "pick commit-id msg" and "pick
+ * commit-id fixup!/squash! msg" in it so that the latter is put immediately
+ * after the former, and change "pick" to "fixup"/"squash".
+ *
+ * Note that if the config has specified a custom instruction format, each log
+ * message will have to be retrieved from the commit (as the oneline in the
+ * script cannot be trusted) in order to normalize the autosquash arrangement.
+ */
+int rearrange_squash(void)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	struct hashmap subject2item;
+	int res = 0, rearranged = 0, *next, *tail, fd, i;
+	char **subjects;
+
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0)
+		return error_errno(_("could not open '%s'"), todo_file);
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		return error(_("could not read '%s'."), todo_file);
+	}
+	close(fd);
+	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+		todo_list_release(&todo_list);
+		return -1;
+	}
+
+	/*
+	 * The hashmap maps onelines to the respective todo list index.
+	 *
+	 * If any items need to be rearranged, the next[i] value will indicate
+	 * which item was moved directly after the i'th.
+	 *
+	 * In that case, last[i] will indicate the index of the latest item to
+	 * be moved to appear after the i'th.
+	 */
+	hashmap_init(&subject2item, (hashmap_cmp_fn) subject2item_cmp,
+		     NULL, todo_list.nr);
+	ALLOC_ARRAY(next, todo_list.nr);
+	ALLOC_ARRAY(tail, todo_list.nr);
+	ALLOC_ARRAY(subjects, todo_list.nr);
+	for (i = 0; i < todo_list.nr; i++) {
+		struct strbuf buf = STRBUF_INIT;
+		struct todo_item *item = todo_list.items + i;
+		const char *commit_buffer, *subject, *p;
+		size_t subject_len;
+		int i2 = -1;
+		struct subject2item_entry *entry;
+
+		next[i] = tail[i] = -1;
+		if (item->command >= TODO_EXEC) {
+			subjects[i] = NULL;
+			continue;
+		}
+
+		if (is_fixup(item->command)) {
+			todo_list_release(&todo_list);
+			return error(_("the script was already rearranged."));
+		}
+
+		item->commit->util = item;
+
+		parse_commit(item->commit);
+		commit_buffer = get_commit_buffer(item->commit, NULL);
+		find_commit_subject(commit_buffer, &subject);
+		format_subject(&buf, subject, " ");
+		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
+		unuse_commit_buffer(item->commit, commit_buffer);
+		if ((skip_prefix(subject, "fixup! ", &p) ||
+		     skip_prefix(subject, "squash! ", &p))) {
+			struct commit *commit2;
+
+			for (;;) {
+				while (isspace(*p))
+					p++;
+				if (!skip_prefix(p, "fixup! ", &p) &&
+				    !skip_prefix(p, "squash! ", &p))
+					break;
+			}
+
+			if ((entry = hashmap_get_from_hash(&subject2item,
+							   strhash(p), p)))
+				/* found by title */
+				i2 = entry->i;
+			else if (!strchr(p, ' ') &&
+				 (commit2 =
+				  lookup_commit_reference_by_name(p)) &&
+				 commit2->util)
+				/* found by commit name */
+				i2 = (struct todo_item *)commit2->util
+					- todo_list.items;
+			else {
+				/* copy can be a prefix of the commit subject */
+				for (i2 = 0; i2 < i; i2++)
+					if (subjects[i2] &&
+					    starts_with(subjects[i2], p))
+						break;
+				if (i2 == i)
+					i2 = -1;
+			}
+		}
+		if (i2 >= 0) {
+			rearranged = 1;
+			todo_list.items[i].command =
+				starts_with(subject, "fixup!") ?
+				TODO_FIXUP : TODO_SQUASH;
+			if (next[i2] < 0)
+				next[i2] = i;
+			else
+				next[tail[i2]] = i;
+			tail[i2] = i;
+		} else if (!hashmap_get_from_hash(&subject2item,
+						strhash(subject), subject)) {
+			FLEX_ALLOC_MEM(entry, subject, subject, subject_len);
+			entry->i = i;
+			hashmap_entry_init(entry, strhash(entry->subject));
+			hashmap_put(&subject2item, entry);
+		}
+	}
+
+	if (rearranged) {
+		struct strbuf buf = STRBUF_INIT;
+
+		for (i = 0; i < todo_list.nr; i++) {
+			enum todo_command command = todo_list.items[i].command;
+			int cur = i;
+
+			/*
+			 * Initially, all commands are 'pick's. If it is a
+			 * fixup or a squash now, we have rearranged it.
+			 */
+			if (is_fixup(command))
+				continue;
+
+			while (cur >= 0) {
+				int offset = todo_list.items[cur].offset_in_buf;
+				int end_offset = cur + 1 < todo_list.nr ?
+					todo_list.items[cur + 1].offset_in_buf :
+					todo_list.buf.len;
+				char *bol = todo_list.buf.buf + offset;
+				char *eol = todo_list.buf.buf + end_offset;
+
+				/* replace 'pick', by 'fixup' or 'squash' */
+				command = todo_list.items[cur].command;
+				if (is_fixup(command)) {
+					strbuf_addstr(&buf,
+						todo_command_info[command].str);
+					bol += strcspn(bol, " \t");
+				}
+
+				strbuf_add(&buf, bol, eol - bol);
+
+				cur = next[cur];
+			}
+		}
+
+		fd = open(todo_file, O_WRONLY);
+		if (fd < 0)
+			res = error_errno(_("could not open '%s'"), todo_file);
+		else if (write(fd, buf.buf, buf.len) < 0)
+			res = error_errno(_("could not read '%s'."), todo_file);
+		else if (ftruncate(fd, buf.len) < 0)
+			res = error_errno(_("could not finish '%s'"),
+					   todo_file);
+		close(fd);
+		strbuf_release(&buf);
+	}
+
+	free(next);
+	free(tail);
+	for (i = 0; i < todo_list.nr; i++)
+		free(subjects[i]);
+	free(subjects);
+	hashmap_free(&subject2item, 1);
+	todo_list_release(&todo_list);
+
+	return res;
+}
diff --git a/sequencer.h b/sequencer.h
index 04a57e09a1d..6f3d3df82c0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -51,6 +51,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 int transform_todo_ids(int shorten_ids);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
+int rearrange_squash(void);
 
 extern const char sign_off_header[];
 
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 62cb977e4ec..e364c12622f 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -290,7 +290,7 @@ set_backup_editor () {
 	test_set_editor "$PWD/backup-editor.sh"
 }
 
-test_expect_failure 'autosquash with multiple empty patches' '
+test_expect_success 'autosquash with multiple empty patches' '
 	test_tick &&
 	git commit --allow-empty -m "empty" &&
 	test_tick &&
-- 
2.13.3.windows.1.13.gaf0c2223da0
