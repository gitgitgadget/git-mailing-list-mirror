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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBF0C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA2364F6B
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhBDTHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbhBDTHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:07:04 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431C7C0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:06:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lw17so5485771pjb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9F6vU7A32uYF8EHTzD1fSoszSFNvqyjvUzPWRZs1dM8=;
        b=ZVpkGG44HKftLh214vBef/XxO/yiSyzWXoC0O6G3aO/gQ3b2F3ggiwD9ze+/2+Vp/Z
         3hO620rEK8j2BrCg0Ju1NEqDOjeTIfyfukpkLY4R1/5QhN4kiUNPAwaA9zE5xQVPif2b
         LzxJY5CrM2T+Te4NUrxSjwktB/km43i+AXpbXqN+D2sNtPdLls2KfYm9VJCEadxUgc5k
         vatCxIXzvkB5DPVJ5WTgg4icobtyLU5/cIQrboHrF5tLXxVCoi4ku2L4K+ZI8+57YbY5
         0ADk+/RHlV4o0rYPrPb0/AGMzT4EYh8T7oMP9dNd8SYhxFTVqkEkp0QrdhBKkqgvCtuH
         qJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9F6vU7A32uYF8EHTzD1fSoszSFNvqyjvUzPWRZs1dM8=;
        b=DGH0L7NoIwDbmGWcARyj3Lz3SbFVmh1x7sR1USIvr5DYBpjzSouiLnoHAhVI6AUAKF
         qJG12H3uzZn13I1bMLlqv+4m+V4iMW1iz9wyVQoNqNhfAwQBpK15rLDX2pIIv8U/XMlo
         YUpzaPQeIxX+nNCIjhc92B8f/j2IseqYWekrbhnG7INWUirdRno/a4Zeqq508B68Ki06
         oMZdq/kLlbCEmUZ5L8lTL3rEDpUKiaR6O7MqmT2ft6pHEsfp4CTVUs6u3go6iALG8/ga
         HLkR3h6Mh6gk91VEXn/47Iau1fR0VUIfwoR1TVpufBRRMEm+b8tx6UifX3WfUI6sr+4A
         oNFw==
X-Gm-Message-State: AOAM531esDrwtTAEmNc3ivzoVI2cf1VXIhA8GeFyMBTmcpNGD39L1Lxy
        0pkYYaFS+q8f2pEIdqw1ukaGDF+ccDsrvg==
X-Google-Smtp-Source: ABdhPJwwodszYkOiyhZY+34K5LGOJXB9N5gusPCMzRP7uXOTQaZxbDMbQW7hx2e71J1j0pByLlTryA==
X-Received: by 2002:a17:90a:468e:: with SMTP id z14mr443296pjf.174.1612465583346;
        Thu, 04 Feb 2021 11:06:23 -0800 (PST)
Received: from localhost.localdomain ([2405:204:332c:6caa:c21:291b:12a6:463f])
        by smtp.googlemail.com with ESMTPSA id 9sm6729524pfo.1.2021.02.04.11.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:06:22 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 6/8] rebase -i: add fixup [-C | -c] command
Date:   Fri,  5 Feb 2021 00:35:05 +0530
Message-Id: <20210204190507.26487-7-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210204190507.26487-1-charvi077@gmail.com>
References: <20210129182050.26143-1-charvi077@gmail.com>
 <20210204190507.26487-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add options to `fixup` command to fixup both the commit contents and
message. `fixup -C` command is used to replace the original commit
message and `fixup -c`, additionally allows to edit the commit message.

This convention is similar to the existing `merge` command in the
interactive rebase, that also supports `-c` and `-C` options with
similar meanings.

Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 rebase-interactive.c |   4 +-
 sequencer.c          | 211 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 195 insertions(+), 20 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 762853bc7e..13e7a6c475 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -44,7 +44,9 @@ void append_todo_help(int command_count,
 "r, reword <commit> = use commit, but edit the commit message\n"
 "e, edit <commit> = use commit, but stop for amending\n"
 "s, squash <commit> = use commit, but meld into previous commit\n"
-"f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
+"f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
+"                   commit's log message; use -C to replace with this\n"
+"                   commit message or -c to edit this commit message\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
 "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
 "d, drop <commit> = remove commit\n"
diff --git a/sequencer.c b/sequencer.c
index 6d9a10afcf..324fc5698a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1718,6 +1718,12 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
+enum todo_item_flags {
+	TODO_EDIT_MERGE_MSG    = (1 << 0),
+	TODO_REPLACE_FIXUP_MSG = (1 << 1),
+	TODO_EDIT_FIXUP_MSG    = (1 << 2),
+};
+
 static size_t subject_length(const char *body)
 {
 	const char *p = body;
@@ -1734,32 +1740,174 @@ static size_t subject_length(const char *body)
 
 static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
 static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
+static const char skip_first_commit_msg_str[] = N_("The 1st commit message will be skipped:");
 static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
 static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
 
-static void append_squash_message(struct strbuf *buf, const char *body,
-				  struct replay_opts *opts)
+static int is_fixup_flag(enum todo_command command, unsigned flag)
+{
+	return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
+					 (flag & TODO_EDIT_FIXUP_MSG));
+}
+
+/*
+ * Wrapper around strbuf_add_commented_lines() which avoids double
+ * commenting commit subjects.
+ */
+static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
+{
+	const char *s = str;
+	while (len > 0 && s[0] == comment_line_char) {
+		size_t count;
+		const char *n = memchr(s, '\n', len);
+		if (!n)
+			count = len;
+		else
+			count = n - s + 1;
+		strbuf_add(buf, s, count);
+		s += count;
+		len -= count;
+	}
+	strbuf_add_commented_lines(buf, s, len);
+}
+
+/* Does the current fixup chain contain a squash command? */
+static int seen_squash(struct replay_opts *opts)
+{
+	return starts_with(opts->current_fixups.buf, "squash") ||
+		strstr(opts->current_fixups.buf, "\nsquash");
+}
+
+static void update_comment_bufs(struct strbuf *buf1, struct strbuf *buf2, int n)
 {
-	size_t commented_len = 0;
+	strbuf_setlen(buf1, 2);
+	strbuf_addf(buf1, _(nth_commit_msg_fmt), n);
+	strbuf_addch(buf1, '\n');
+	strbuf_setlen(buf2, 2);
+	strbuf_addf(buf2, _(skip_nth_commit_msg_fmt), n);
+	strbuf_addch(buf2, '\n');
+}
 
-	unlink(rebase_path_fixup_msg());
-	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
+/*
+ * Comment out any un-commented commit messages, updating the message comments
+ * to say they will be skipped but do not comment out the empty lines that
+ * surround commit messages and their comments.
+ */
+static void update_squash_message_for_fixup(struct strbuf *msg)
+{
+	void (*copy_lines)(struct strbuf *, const void *, size_t) = strbuf_add;
+	struct strbuf buf1 = STRBUF_INIT, buf2 = STRBUF_INIT;
+	const char *s, *start;
+	char *orig_msg;
+	size_t orig_msg_len;
+	int i = 1;
+
+	strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
+	strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));
+	s = start = orig_msg = strbuf_detach(msg, &orig_msg_len);
+	while (s) {
+		const char *next;
+		size_t off;
+		if (skip_prefix(s, buf1.buf, &next)) {
+			/*
+			 * Copy the last message, preserving the blank line
+			 * preceding the current line
+			 */
+			off = (s > start + 1 && s[-2] == '\n') ? 1 : 0;
+			copy_lines(msg, start, s - start - off);
+			if (off)
+				strbuf_addch(msg, '\n');
+			/*
+			 * The next message needs to be commented out but the
+			 * message header is already commented out so just copy
+			 * it and the blank line that follows it.
+			 */
+			strbuf_addbuf(msg, &buf2);
+			if (*next == '\n')
+				strbuf_addch(msg, *next++);
+			start = s = next;
+			copy_lines = add_commented_lines;
+			update_comment_bufs(&buf1, &buf2, ++i);
+		} else if (skip_prefix(s, buf2.buf, &next)) {
+			off = (s > start + 1 && s[-2] == '\n') ? 1 : 0;
+			copy_lines(msg, start, s - start - off);
+			start = s - off;
+			s = next;
+			copy_lines = strbuf_add;
+			update_comment_bufs(&buf1, &buf2, ++i);
+		} else {
+			s = strchr(s, '\n');
+			if (s)
+				s++;
+		}
+	}
+	copy_lines(msg, start, orig_msg_len - (start - orig_msg));
+	free(orig_msg);
+	strbuf_release(&buf1);
+	strbuf_release(&buf2);
+}
+
+static int append_squash_message(struct strbuf *buf, const char *body,
+			 enum todo_command command, struct replay_opts *opts,
+			 unsigned flag)
+{
+	const char *fixup_msg;
+	size_t commented_len = 0, fixup_off;
+	/*
+	 * fixup -C is non-interactive and not normally used with fixup!
+	 * or squash! commits, so only comment out those subjects when
+	 * squashing commit messages.
+	 */
+	if ((command == TODO_SQUASH || seen_squash(opts)) &&
+	    (starts_with(body, "squash!") || starts_with(body, "fixup!")))
 		commented_len = subject_length(body);
+
 	strbuf_addf(buf, "\n%c ", comment_line_char);
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
 	strbuf_add_commented_lines(buf, body, commented_len);
+	/* buf->buf may be reallocated so store an offset into the buffer */
+	fixup_off = buf->len;
 	strbuf_addstr(buf, body + commented_len);
+
+	/* fixup -C after squash behaves like squash */
+	if (is_fixup_flag(command, flag) && !seen_squash(opts)) {
+		/*
+		 * We're replacing the commit message so we need to
+		 * append the Signed-off-by: trailer if the user
+		 * requested '--signoff'.
+		 */
+		if (opts->signoff)
+			append_signoff(buf, 0, 0);
+
+		if ((command == TODO_FIXUP) &&
+		    (flag & TODO_REPLACE_FIXUP_MSG) &&
+		    (file_exists(rebase_path_fixup_msg()) ||
+		     !file_exists(rebase_path_squash_msg()))) {
+			fixup_msg = skip_blank_lines(buf->buf + fixup_off);
+			if (write_message(fixup_msg, strlen(fixup_msg),
+					rebase_path_fixup_msg(), 0) < 0)
+				return error(_("cannot write '%s'"),
+					rebase_path_fixup_msg());
+		} else {
+			unlink(rebase_path_fixup_msg());
+		}
+	} else  {
+		unlink(rebase_path_fixup_msg());
+	}
+
+	return 0;
 }
 
 static int update_squash_messages(struct repository *r,
 				  enum todo_command command,
 				  struct commit *commit,
-				  struct replay_opts *opts)
+				  struct replay_opts *opts,
+				  unsigned flag)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int res;
+	int res = 0;
 	const char *message, *body;
 	const char *encoding = get_commit_output_encoding();
 
@@ -1779,6 +1927,8 @@ static int update_squash_messages(struct repository *r,
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
+		if (is_fixup_flag(command, flag) && !seen_squash(opts))
+			update_squash_message_for_fixup(&buf);
 	} else {
 		struct object_id head;
 		struct commit *head_commit;
@@ -1792,18 +1942,22 @@ static int update_squash_messages(struct repository *r,
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
-		if (command == TODO_FIXUP && write_message(body, strlen(body),
+		if (command == TODO_FIXUP && !flag && write_message(body, strlen(body),
 							rebase_path_fixup_msg(), 0) < 0) {
 			unuse_commit_buffer(head_commit, head_message);
 			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
-
 		strbuf_addf(&buf, "%c ", comment_line_char);
 		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addstr(&buf, _(first_commit_msg_str));
+		strbuf_addstr(&buf, is_fixup_flag(command, flag) ?
+			      _(skip_first_commit_msg_str) :
+			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
-		strbuf_addstr(&buf, body);
+		if (is_fixup_flag(command, flag))
+			strbuf_add_commented_lines(&buf, body, strlen(body));
+		else
+			strbuf_addstr(&buf, body);
 
 		unuse_commit_buffer(head_commit, head_message);
 	}
@@ -1813,8 +1967,8 @@ static int update_squash_messages(struct repository *r,
 			     oid_to_hex(&commit->object.oid));
 	find_commit_subject(message, &body);
 
-	if (command == TODO_SQUASH) {
-		append_squash_message(&buf, body, opts);
+	if (command == TODO_SQUASH || is_fixup_flag(command, flag)) {
+		res = append_squash_message(&buf, body, command, opts, flag);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
@@ -1825,7 +1979,9 @@ static int update_squash_messages(struct repository *r,
 		return error(_("unknown command: %d"), command);
 	unuse_commit_buffer(commit, message);
 
-	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
+	if (!res)
+		res = write_message(buf.buf, buf.len, rebase_path_squash_msg(),
+				    0);
 	strbuf_release(&buf);
 
 	if (!res) {
@@ -2026,7 +2182,8 @@ static int do_pick_commit(struct repository *r,
 	if (command == TODO_REWORD)
 		reword = 1;
 	else if (is_fixup(command)) {
-		if (update_squash_messages(r, command, commit, opts))
+		if (update_squash_messages(r, command, commit,
+					   opts, item->flags))
 			return -1;
 		flags |= AMEND_MSG;
 		if (!final_fixup)
@@ -2191,10 +2348,6 @@ static int read_and_refresh_cache(struct repository *r,
 	return 0;
 }
 
-enum todo_item_flags {
-	TODO_EDIT_MERGE_MSG = 1
-};
-
 void todo_list_release(struct todo_list *todo_list)
 {
 	strbuf_release(&todo_list->buf);
@@ -2281,6 +2434,18 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 		return 0;
 	}
 
+	if (item->command == TODO_FIXUP) {
+		if (skip_prefix(bol, "-C", &bol) &&
+		   (*bol == ' ' || *bol == '\t')) {
+			bol += strspn(bol, " \t");
+			item->flags |= TODO_REPLACE_FIXUP_MSG;
+		} else if (skip_prefix(bol, "-c", &bol) &&
+				  (*bol == ' ' || *bol == '\t')) {
+			bol += strspn(bol, " \t");
+			item->flags |= TODO_EDIT_FIXUP_MSG;
+		}
+	}
+
 	if (item->command == TODO_MERGE) {
 		if (skip_prefix(bol, "-C", &bol))
 			bol += strspn(bol, " \t");
@@ -5287,6 +5452,14 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
 					  short_commit_name(item->commit) :
 					  oid_to_hex(&item->commit->object.oid);
 
+			if (item->command == TODO_FIXUP) {
+				if (item->flags & TODO_EDIT_FIXUP_MSG)
+					strbuf_addstr(buf, " -c");
+				else if (item->flags & TODO_REPLACE_FIXUP_MSG) {
+					strbuf_addstr(buf, " -C");
+				}
+			}
+
 			if (item->command == TODO_MERGE) {
 				if (item->flags & TODO_EDIT_MERGE_MSG)
 					strbuf_addstr(buf, " -c");
-- 
2.29.0.rc1

