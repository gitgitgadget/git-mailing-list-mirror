Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF929C00A5A
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 22:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjAQWlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 17:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjAQWk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 17:40:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C54E5AB5F
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:55:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q10so12745259wrs.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dORI+9/EC1f6rAtiN/WltGyyFIdAN8LXahmKtjQv0Rc=;
        b=Jl4NCeDuSMZsYt4dJUlKwKEtR73O10f/RLtNVA1/YZGMQmK/1nM164LK26u8Ma1Oau
         zzcl5RdqkHCCQiLeS/lx/DH493GMSc5aOiLX19NQFg7/FQ3l0c5Yzt0KQJ2BijMc5aCe
         tpjYwBPJVi0Yo8FNJZuX/RKU1b4bnQQ1nq4Io2pYBglaWRBBatC5PimxWkgNWZtLrDZb
         XtM9LzsCy++tHOMSlrcaMe4Td+Tt2fDDMB2KtNhU73OjEdDszrsCIQ5QD2EYVV+M3iVR
         LAw3WzolYu4c/ZaHT1fE7rSITzuXZcz7Su3m6f3XnaVU/1lKVSYXgL+FxXZf+ivADxd7
         17Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dORI+9/EC1f6rAtiN/WltGyyFIdAN8LXahmKtjQv0Rc=;
        b=09uPJx6S9vsSAkJekCdlNWf5X/r78uHpPRh01Q0h6AUoj4JJ/CcoQcjK1D3g/uTgEW
         BiKqmSUMjH2qQLwUkEmuW1MYrp0cqRZKLMMGeEFg2KAdalAUBddotnNHfSNshxgHwq8c
         G1/wvPqW8Wxwc4WlbwUowav5KPPFjzgvhyG7A7aS4w+JKiRQorHlNqKRjn7WvdsKOvu4
         N0Gc2ZOn71heQv4z7VOfCQQM4F0KiKzxlc+tYiM1isT+rscdl6RUJ46xKIw0hSwyOtQD
         DM8jVeQm/AE44X10h0myzvZHnOM8aFKmKp1lTrRjI8mDIe4IKUpc5Y55DmNH1OINxxH0
         Rlbg==
X-Gm-Message-State: AFqh2krpuPnQRZJDluX4HoMplGpx4jj9I/3PcKpEXCqnKOZnbPLeOm1X
        FYAReyKAwxSxKD6oV+/rFcZtE6dczsE=
X-Google-Smtp-Source: AMrXdXssJYv0psgYgKDN5e1fNJ2VgRed0UTfJYI0dEPieodi8RWe9WXUmQTGL5B3GBtFQLAJPyNxkg==
X-Received: by 2002:a5d:4e90:0:b0:2be:a9f:797f with SMTP id e16-20020a5d4e90000000b002be0a9f797fmr4096780wru.18.1673992499580;
        Tue, 17 Jan 2023 13:54:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020adfdd0a000000b002bb6b45ab57sm27743396wrm.85.2023.01.17.13.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:54:59 -0800 (PST)
Message-Id: <pull.1436.git.git.1673992498572.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 21:54:58 +0000
Subject: [PATCH] git: replace strbuf_addstr with strbuf_addch for all strings
 of length 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

This helps reduce overhead of calculating the length

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: replace strbuf_addstr with strbuf_addch for all strings of length 2
    
    This helps reduce overhead of calculating the length
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1436%2FAtariDreams%2Fstrbuf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1436/AtariDreams/strbuf-v1
Pull-Request: https://github.com/git/git/pull/1436

 bisect.c                  |  2 +-
 builtin/am.c              |  6 ++----
 builtin/blame.c           |  8 +++-----
 builtin/ls-tree.c         |  2 +-
 diff.c                    |  2 +-
 log-tree.c                |  2 +-
 merge-ort.c               |  3 +--
 path.c                    |  2 +-
 protocol-caps.c           |  2 +-
 reftable/readwrite_test.c |  2 +-
 reftable/refname.c        |  2 +-
 reftable/stack.c          | 12 ++++++------
 reftable/stack_test.c     |  2 +-
 reftable/writer.c         |  2 +-
 sequencer.c               |  2 +-
 setup.c                   |  2 +-
 trace2/tr2_tgt_normal.c   |  2 +-
 17 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/bisect.c b/bisect.c
index ec7487e6836..ea534ad3777 100644
--- a/bisect.c
+++ b/bisect.c
@@ -443,7 +443,7 @@ static int register_ref(const char *refname, const struct object_id *oid,
 {
 	struct strbuf good_prefix = STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
-	strbuf_addstr(&good_prefix, "-");
+	strbuf_addch(&good_prefix, '-');
 
 	if (!strcmp(refname, term_bad)) {
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
diff --git a/builtin/am.c b/builtin/am.c
index 7e88d2426d7..c96886e0433 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -329,13 +329,11 @@ static void write_author_script(const struct am_state *state)
 
 	strbuf_addstr(&sb, "GIT_AUTHOR_NAME=");
 	sq_quote_buf(&sb, state->author_name);
-	strbuf_addch(&sb, '\n');
 
-	strbuf_addstr(&sb, "GIT_AUTHOR_EMAIL=");
+	strbuf_addstr(&sb, "\nGIT_AUTHOR_EMAIL=");
 	sq_quote_buf(&sb, state->author_email);
-	strbuf_addch(&sb, '\n');
 
-	strbuf_addstr(&sb, "GIT_AUTHOR_DATE=");
+	strbuf_addstr(&sb, "\nGIT_AUTHOR_DATE=");
 	sq_quote_buf(&sb, state->author_date);
 	strbuf_addch(&sb, '\n');
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 71f925e456c..3ab4cc0a56b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -143,11 +143,9 @@ static void get_ac_line(const char *inbuf, const char *what,
 
 	if (split_ident_line(&ident, tmp, len)) {
 	error_out:
-		/* Ugh */
-		tmp = "(unknown)";
-		strbuf_addstr(name, tmp);
-		strbuf_addstr(mail, tmp);
-		strbuf_addstr(tz, tmp);
+		strbuf_addstr(name, "(unknown)");
+		strbuf_addstr(mail, "(unknown)");
+		strbuf_addstr(tz, "(unknown)");
 		*time = 0;
 		return;
 	}
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c3ea09281af..73b755029ee 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -60,7 +60,7 @@ static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 	} else if (padded) {
 		strbuf_addf(line, "%7s", "-");
 	} else {
-		strbuf_addstr(line, "-");
+		strbuf_addch(line, '-');
 	}
 }
 
diff --git a/diff.c b/diff.c
index 329eebf16a0..b379660c42b 100644
--- a/diff.c
+++ b/diff.c
@@ -1702,7 +1702,7 @@ static void add_line_count(struct strbuf *out, int count)
 		strbuf_addstr(out, "0,0");
 		break;
 	case 1:
-		strbuf_addstr(out, "1");
+		strbuf_addch(out, '1');
 		break;
 	default:
 		strbuf_addf(out, "1,%d", count);
diff --git a/log-tree.c b/log-tree.c
index 1dd5fcbf7be..23f2a62c5ac 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -388,7 +388,7 @@ void fmt_output_subject(struct strbuf *filename,
 
 		strbuf_addf(&temp, "v%s", info->reroll_count);
 		format_sanitized_subject(filename, temp.buf, temp.len);
-		strbuf_addstr(filename, "-");
+		strbuf_addch(filename, '-');
 		strbuf_release(&temp);
 	}
 	strbuf_addf(filename, "%04d-%s", nr, subject);
diff --git a/merge-ort.c b/merge-ort.c
index d1611ca400a..3132ac22aba 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -801,8 +801,7 @@ static void path_msg(struct merge_options *opt,
 
 	va_start(ap, fmt);
 	if (opt->priv->call_depth) {
-		strbuf_addchars(dest, ' ', 2);
-		strbuf_addstr(dest, "From inner merge:");
+		strbuf_addstr(dest, "  From inner merge:");
 		strbuf_addchars(dest, ' ', opt->priv->call_depth * 2);
 	}
 	strbuf_vaddf(dest, fmt, ap);
diff --git a/path.c b/path.c
index 492e17ad121..05d3b6d9059 100644
--- a/path.c
+++ b/path.c
@@ -1082,7 +1082,7 @@ const char *remove_leading_path(const char *in, const char *prefix)
 
 	strbuf_reset(&buf);
 	if (!in[j])
-		strbuf_addstr(&buf, ".");
+		strbuf_addch(&buf, '.');
 	else
 		strbuf_addstr(&buf, in + j);
 	return buf.buf;
diff --git a/protocol-caps.c b/protocol-caps.c
index bbde91810ac..80ec75e1131 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -63,7 +63,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 
 		if (info->size) {
 			if (oid_object_info(r, &oid, &object_size) < 0) {
-				strbuf_addstr(&send_buffer, " ");
+				strbuf_addch(&send_buffer, ' ');
 			} else {
 				strbuf_addf(&send_buffer, " %lu", object_size);
 			}
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 469ab79a5ad..ed0f6058ba9 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -483,7 +483,7 @@ static void test_table_read_write_seek(int index, int hash_id)
 	}
 
 	strbuf_addstr(&pastLast, names[N - 1]);
-	strbuf_addstr(&pastLast, "/");
+	strbuf_addch(&pastLast, '/');
 
 	err = reftable_reader_seek_ref(&rd, &it, pastLast.buf);
 	if (err == 0) {
diff --git a/reftable/refname.c b/reftable/refname.c
index 95734969324..b6d5b76a8fe 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -179,7 +179,7 @@ int modification_validate(struct modification *mod)
 			goto done;
 		strbuf_reset(&slashed);
 		strbuf_addstr(&slashed, mod->add[i]);
-		strbuf_addstr(&slashed, "/");
+		strbuf_addch(&slashed, '/');
 
 		err = modification_has_ref_with_prefix(mod, slashed.buf);
 		if (err == 0) {
diff --git a/reftable/stack.c b/reftable/stack.c
index ddbdf1b9c8b..479658e428d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -35,7 +35,7 @@ static void stack_filename(struct strbuf *dest, struct reftable_stack *st,
 {
 	strbuf_reset(dest);
 	strbuf_addstr(dest, st->reftable_dir);
-	strbuf_addstr(dest, "/");
+	strbuf_addch(dest, '/');
 	strbuf_addstr(dest, name);
 }
 
@@ -547,11 +547,11 @@ int reftable_addition_commit(struct reftable_addition *add)
 
 	for (i = 0; i < add->stack->merged->stack_len; i++) {
 		strbuf_addstr(&table_list, add->stack->readers[i]->name);
-		strbuf_addstr(&table_list, "\n");
+		strbuf_addch(&table_list, '\n');
 	}
 	for (i = 0; i < add->new_tables_len; i++) {
 		strbuf_addstr(&table_list, add->new_tables[i]);
-		strbuf_addstr(&table_list, "\n");
+		strbuf_addch(&table_list, '\n');
 	}
 
 	err = write(add->lock_file_fd, table_list.buf, table_list.len);
@@ -1013,15 +1013,15 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 
 	for (i = 0; i < first; i++) {
 		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
-		strbuf_addstr(&ref_list_contents, "\n");
+		strbuf_addch(&ref_list_contents, '\n');
 	}
 	if (!is_empty_table) {
 		strbuf_addbuf(&ref_list_contents, &new_table_name);
-		strbuf_addstr(&ref_list_contents, "\n");
+		strbuf_addch(&ref_list_contents, '\n');
 	}
 	for (i = last + 1; i < st->merged->stack_len; i++) {
 		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
-		strbuf_addstr(&ref_list_contents, "\n");
+		strbuf_addch(&ref_list_contents, '\n');
 	}
 
 	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d0b717510fa..4fcaefd3ddb 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -181,7 +181,7 @@ static void test_reftable_stack_add_one(void)
 
 	strbuf_reset(&scratch);
 	strbuf_addstr(&scratch, dir);
-	strbuf_addstr(&scratch, "/");
+	strbuf_addch(&scratch, '/');
 	/* do not try at home; not an external API for reftable. */
 	strbuf_addstr(&scratch, st->readers[0]->name);
 	err = stat(scratch.buf, &stat_result);
diff --git a/reftable/writer.c b/reftable/writer.c
index 2e322a5683d..61d6f3229f3 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -351,7 +351,7 @@ int reftable_writer_add_log(struct reftable_writer *w,
 			err = REFTABLE_API_ERROR;
 			goto done;
 		}
-		strbuf_addstr(&cleaned_message, "\n");
+		strbuf_addch(&cleaned_message, '\n');
 		log->value.update.message = cleaned_message.buf;
 	}
 
diff --git a/sequencer.c b/sequencer.c
index bcb662e23be..27f41a027d2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2233,7 +2233,7 @@ static int do_pick_commit(struct repository *r,
 		} else {
 			strbuf_addstr(&msgbuf, "Revert \"");
 			strbuf_addstr(&msgbuf, msg.subject);
-			strbuf_addstr(&msgbuf, "\"");
+			strbuf_addch(&msgbuf, '\"');
 		}
 		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
 		refer_to_commit(opts, &msgbuf, commit);
diff --git a/setup.c b/setup.c
index cefd5f63c46..865ed8fbe98 100644
--- a/setup.c
+++ b/setup.c
@@ -1349,7 +1349,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
 				return GIT_DIR_INVALID_OWNERSHIP;
-			strbuf_addstr(gitdir, ".");
+			strbuf_addch(gitdir, '.');
 			return GIT_DIR_BARE;
 		}
 
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index fbbef68dfc0..e99ee58ca38 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -224,7 +224,7 @@ static void fn_child_start_fl(const char *file, int line,
 	if (cmd->dir) {
 		strbuf_addstr(&buf_payload, " cd ");
 		sq_quote_buf_pretty(&buf_payload, cmd->dir);
-		strbuf_addstr(&buf_payload, ";");
+		strbuf_addch(&buf_payload, ';');
 	}
 
 	/*

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
