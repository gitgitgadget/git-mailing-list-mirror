Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3FCC433E6
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6A23133
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbhASHrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbhASHpL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:45:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADEC0613C1
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u4so11611597pjn.4
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GY93thmu+TLDleeTaimA6c33MmULb0SjLaipY1LoLE=;
        b=vHp/TXh1mjywHAvxgdAJc1WrGYQcguHA+R9OgBzRek0zyFq93gZQsVl7reKRPWLg4n
         DAstrXkbhz6dAA0SelTYxbYoAVuPaumlNZlK8FVQbA/OZPpcf7OlaAIEdxGA4k33xOhN
         p0zFvm7LSaA1KIkHDQ7bg+CSwP3+ZMSGg/gdNLqWPdmWf95zlaRUvEPHzkUvqeegfxFp
         aeldEOX72x4ovX1lltCrgAcMfJM6BC7b9ekBPcFBxyvAe4ATUxEM2QUCTKv2M9ZVrNir
         /jlIjGlnDiNdIgPF8Dcn0f8qJ/i1HQSaEkVE70I6ik2XhkXzUKWdffJ1iFJFVCChlE5T
         QiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GY93thmu+TLDleeTaimA6c33MmULb0SjLaipY1LoLE=;
        b=UyG5uzIQmlAPm7p4vp1n+gIx1xzhipFyJFTzxNiOgFND4OcjD62iFRlig5JZHtlg4B
         4zkaaxvB2vNa01N+8VDTpGYeSVvVDh1IZm1OfESc4+BVBeZ0WWTd31vdehOeh4xCTTtr
         pE1WXRH7Dv5wJMnEURWGZ2KSfgJlQA2pV209rj3YJKMxsQ8zkGuRJ0Jcj3ci1peqB4QK
         U38B+i3uJ+lCO5F4WLqrJQBQW2bRL+Qztrp03daUqiWLIXAMUTAEWkIodWBsqOZl2ZFr
         8ijdk8LMIblTxTC1Ux9VZINk/qKS/iNCSnovk8qYvr7QAReeQGK0y1ydTRl+ryhGYQA+
         pz0Q==
X-Gm-Message-State: AOAM531iBUgJdPNx6fLnUHCKShFwna//CGdZCckYpBI/JjmyOWkozGBt
        dFnFCugVU1WUjbUULI5fYlqjM3WKPRjhYQ==
X-Google-Smtp-Source: ABdhPJwBFWu2+vM9V27CLmCE3sH8hV45sd3+Z6FWOepTLBllDp86h2g0czmeMwR9fKILkDW8VACj+Q==
X-Received: by 2002:a17:90a:b78a:: with SMTP id m10mr3896496pjr.164.1611042268138;
        Mon, 18 Jan 2021 23:44:28 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:55d6:8648:6f7a:9f93])
        by smtp.googlemail.com with ESMTPSA id x1sm19201525pgj.37.2021.01.18.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:44:27 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 6/9] rebase -i: add fixup [-C | -c] command
Date:   Tue, 19 Jan 2021 13:11:01 +0530
Message-Id: <20210119074102.21598-7-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add options to `fixup` command to fixup both the commit contents and
message. `fixup -C` command is used to replace the original commit
message and `fixup -c`, additionally allows to edit the commit message.

Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 rebase-interactive.c |   4 +-
 sequencer.c          | 211 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 195 insertions(+), 20 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 762853bc7e..c3bd02adee 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -44,7 +44,9 @@ void append_todo_help(int command_count,
 "r, reword <commit> = use commit, but edit the commit message\n"
 "e, edit <commit> = use commit, but stop for amending\n"
 "s, squash <commit> = use commit, but meld into previous commit\n"
-"f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
+"f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
+"                   commit's log message. Use -C to replace with this\n"
+"                   commit message or -c to edit the commit message\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
 "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
 "d, drop <commit> = remove commit\n"
diff --git a/sequencer.c b/sequencer.c
index 571000cf68..3c0cd487f9 100644
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
 	size_t i, len = 0;
@@ -1738,32 +1744,174 @@ static size_t subject_length(const char *body)
 
 static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
 static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
+static const char skip_first_commit_msg_str[] = N_("The 1st commit message will be skipped:");
 static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
 static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
 
-static void append_squash_message(struct strbuf *buf, const char *body,
-				  struct replay_opts *opts)
+static int check_fixup_flag(enum todo_command command,
+			    enum todo_item_flags flag)
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
+			 enum todo_item_flags flag)
+{
+	const char *fixup_msg;
+	size_t commented_len = 0, fixup_off;
+	/*
+	 * amend is non-interactive and not normally used with fixup!
+	 * or squash! commits, so only comment out those subjects when
+	 * squashing commit messages.
+	 */
+	if (starts_with(body, "amend!") ||
+	    ((command == TODO_SQUASH || seen_squash(opts)) &&
+	     (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
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
+	if (check_fixup_flag(command, flag) && !seen_squash(opts)) {
+		/*
+		 * We're replacing the commit message so we need to
+		 * append the Signed-off-by: trailer if the user
+		 * requested '--signoff'.
+		 */
+		if (opts->signoff)
+			append_signoff(buf, 0, 0);
+
+		if ((command == TODO_FIXUP) &&
+		    (flag & TODO_REPLACE_FIXUP_MSG)) {
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
+				  enum todo_item_flags flag)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int res;
+	int res = 0;
 	const char *message, *body;
 	const char *encoding = get_commit_output_encoding();
 
@@ -1783,6 +1931,8 @@ static int update_squash_messages(struct repository *r,
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
+		if (check_fixup_flag(command, flag) && !seen_squash(opts))
+			update_squash_message_for_fixup(&buf);
 	} else {
 		struct object_id head;
 		struct commit *head_commit;
@@ -1796,18 +1946,22 @@ static int update_squash_messages(struct repository *r,
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
+		strbuf_addstr(&buf, check_fixup_flag(command, flag) ?
+			      _(skip_first_commit_msg_str) :
+			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
-		strbuf_addstr(&buf, body);
+		if (check_fixup_flag(command, flag))
+			strbuf_add_commented_lines(&buf, body, strlen(body));
+		else
+			strbuf_addstr(&buf, body);
 
 		unuse_commit_buffer(head_commit, head_message);
 	}
@@ -1817,8 +1971,8 @@ static int update_squash_messages(struct repository *r,
 			     oid_to_hex(&commit->object.oid));
 	find_commit_subject(message, &body);
 
-	if (command == TODO_SQUASH) {
-		append_squash_message(&buf, body, opts);
+	if (command == TODO_SQUASH || check_fixup_flag(command, flag)) {
+		res = append_squash_message(&buf, body, command, opts, flag);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
@@ -1829,7 +1983,9 @@ static int update_squash_messages(struct repository *r,
 		return error(_("unknown command: %d"), command);
 	unuse_commit_buffer(commit, message);
 
-	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
+	if (!res)
+		res = write_message(buf.buf, buf.len, rebase_path_squash_msg(),
+				    0);
 	strbuf_release(&buf);
 
 	if (!res) {
@@ -2030,7 +2186,8 @@ static int do_pick_commit(struct repository *r,
 	if (command == TODO_REWORD)
 		reword = 1;
 	else if (is_fixup(command)) {
-		if (update_squash_messages(r, command, commit, opts))
+		if (update_squash_messages(r, command, commit,
+					   opts, item->flags))
 			return -1;
 		flags |= AMEND_MSG;
 		if (!final_fixup)
@@ -2195,10 +2352,6 @@ static int read_and_refresh_cache(struct repository *r,
 	return 0;
 }
 
-enum todo_item_flags {
-	TODO_EDIT_MERGE_MSG = 1
-};
-
 void todo_list_release(struct todo_list *todo_list)
 {
 	strbuf_release(&todo_list->buf);
@@ -2285,6 +2438,18 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
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
@@ -5291,6 +5456,14 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
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

