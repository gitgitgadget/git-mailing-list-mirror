Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E5A207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2992769AbdD1VdX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:33:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:62107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2992569AbdD1VdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:33:21 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ8fw-1dPBm51MjM-00KyYD; Fri, 28
 Apr 2017 23:33:09 +0200
Date:   Fri, 28 Apr 2017 23:33:07 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 10/10] rebase -i: rearrange fixup/squash lines using the
 rebase--helper
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
Message-ID: <6825a2bb46f43687af0565e4d38224d472932203.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:q9OYN6n2ZHajfEyc9/bcdNt5o/Vdl0dgVWLXc0HrbpzZrBAEG6R
 13ydvQnxhikeFPky8xRMiK2Ooa0dyIWaTqZ/yx6M+HqdJqnUbZ/MK3pEhMWcKawPqiYUHC0
 Bl08VGYPwHxuHxeL36jwzQtfiwwahP+K8PVXWz6kWzr+RxxlKr6swS0+41gvzWM5eGPTKAQ
 an4cDtk9SLws/sWF5tNHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1XQRbJOTFh8=:fbY6iDNnJlDp0YH8OTm7qZ
 3dpurMyBHV9QBk+9QufuophSeZ60uuQicADO2l4p65XuyqvzxKXNAx9b6TvHHMgt95VsYLIhT
 +zYABQlzXmlJy8HdhPjGtagL1+4p+QZth0DgWSh/3YAHrSTCkbkLQCWzE62vQ8130yzIpUha1
 nZmgv3Ctlpf6P/U57LSUiWLhnqhxcaRamzVcSLWk0CKXqX9KpCVFWH+ToSGgCLhECfrYcqpUN
 Uu0zjcWTaBhrqLdZSEnU4moUh8T2id9BjMoysUiX5wK6upW9Og/srk/7xTs2hZLJHDkzcBPsP
 TXE8ba9cUPXflHVkBa+1lGAZWiD3hLo0BcNU3nnkyGpsDd+NyMnVC0CQdxMd9PiPDJn4KQnqF
 FsfaGo4rU/LbYFL7XySJu94Mm1orUuKotH8pHloRvuNXFEbUlFNHPnjZLzRIAWte977+aQ/Wv
 c+60hb+jK05WzfwO8m4RUcodasdpgL6boX6a65K3ilvK+kFDsFufSOWGYcHu/O8lGsqb1cCZW
 zUHCokGI7M9bMyyMm4QxNyQYloR6oIJpYbvOUNx37Bm1N49TZdWkdHsHm/XFpKhOk7Apj7PaI
 rVNA3WwBljowYjCpIXBD+054pkaLMkYvwU9flhepq0RQjGLtPPJMC2eNUYGEi1k9xpbys+hib
 u/gnca4yPcvz3Sq6Q4PFp6wswFvUOGKSZQ0u4z9+iL+AnD2Rhl7LrnU8rQ7QicImguDctvdIt
 ZU5mfbqoFrJf3qCBQBS17sLPLHcGJZppzFrh0gCz3NM0GmwTWSZ2aGenFIQK832ZFHYqHmrbd
 1BziLX+
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
 sequencer.c                  | 195 +++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                  |   1 +
 t/t3415-rebase-autosquash.sh |   2 +-
 6 files changed, 212 insertions(+), 98 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 53f4e144444..c5464aa5365 100644
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
index de3ccd9bfbc..e6591f01112 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -14,7 +14,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	int keep_empty = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
-		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS
+		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -33,6 +33,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("check the todo list"), CHECK_TODO_LIST),
 		OPT_CMDMODE(0, "skip-unnecessary-picks", &command,
 			N_("skip unnecessary picks"), SKIP_UNNECESSARY_PICKS),
+		OPT_CMDMODE(0, "rearrange-squash", &command,
+			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
 		OPT_END()
 	};
 
@@ -59,5 +61,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!check_todo_list();
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
 		return !!skip_unnecessary_picks();
+	if (command == REARRANGE_SQUASH && argc == 1)
+		return !!rearrange_squash();
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 92e3ca1de3b..84c6e62518f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -721,94 +721,6 @@ collapse_todo_ids() {
 	git rebase--helper --shorten-sha1s
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
index 72e3ad8d145..63a588f0916 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -19,6 +19,7 @@
 #include "trailer.h"
 #include "log-tree.h"
 #include "wt-status.h"
+#include "hashmap.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2723,3 +2724,197 @@ int skip_unnecessary_picks(void)
 
 	return 0;
 }
+
+struct subject2item_entry {
+	struct hashmap_entry entry;
+	int i;
+	char subject[FLEX_ARRAY];
+};
+
+static int subject2item_cmp(const struct subject2item_entry *a,
+	const struct subject2item_entry *b, const void *key)
+{
+	return key ? strcmp(a->subject, key) : strcmp(a->subject, b->subject);
+}
+
+/*
+ * Rearrange the todo list that has both "pick sha1 msg" and "pick sha1
+ * fixup!/squash! msg" in it so that the latter is put immediately after the
+ * former, and change "pick" to "fixup"/"squash".
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
+		     todo_list.nr);
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
index 28e1fc1e9bb..1c94bec7622 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -51,6 +51,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 int transform_todo_ids(int shorten_sha1s);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
+int rearrange_squash(void);
 
 extern const char sign_off_header[];
 
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 926bb3da788..2f88f50c057 100755
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
2.12.2.windows.2.800.gede8f145e06
