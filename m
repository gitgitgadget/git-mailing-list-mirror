Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB37C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjECSvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjECSu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:50:59 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2FF83DD
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:50:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-52883b4d2c9so2764159a12.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683139847; x=1685731847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=doCS6yTMF1SkxtJ0zdaItO+EFaPvxl5SoMOzAG7qxCw=;
        b=RWEfuC2FA1YHNdCjvfRJvyQ9pHyAAmFdrdafaxLDFSxGJXilYLWqjA/uyYLnyHWYDI
         KARG5xDkbO48mr/FtNwCk7d+IT5hrtWGchlARiiciOIhQqmcr4sOtnROwsLArweB3lNO
         XPgrs1E2t8diCUnYVSMctiSilZwcQoRuxfNAWcSrV+fdxDGlgst27BaEOQMVl8GcMISk
         zEdCC7ppzk/ViOTsiaWposzRdQp59rDRvCTDDjnTx3nIw2hxw/M3WJ8S3LWuDrh2fO/d
         nQDnuyFM7ozRplEV8FIVNAA99rRry7+QcsL94u8352n1NtOsz14v3s9noInm+JpN2onF
         LdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139847; x=1685731847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doCS6yTMF1SkxtJ0zdaItO+EFaPvxl5SoMOzAG7qxCw=;
        b=a2F+7f4sbaetAQ05s8qy8vQCElIkEv0WtjG5w50h9UGgJwgovE1fIkBD8f1bqkIiir
         XXPBzR7s9QlKYtVvapVMVSdu/qRX6nAJbkgR5lb/Qtc+Jm5CxYgAg6P3PzvNQzTXSnGm
         LA9fSgAj9jX/RIzNWgW/CP/yYzzROUyuj4T9Aw42L8uQXsRJ5MO/oq44NXtozHW14SQW
         fXkcTSBOylCCjyCy1giVpWsiUQ5llvmhh1i0OHm3rAwZVrqUAiV5jyQlY7bCmmCipZ3F
         9RePzooETyf8H7dckZH/Hpm2mKSapwCbRJ3bEKkAfKsHN/UXhEHiuhtWKKO8GVxWPtMn
         ZYbg==
X-Gm-Message-State: AC+VfDytS+OzgZZLRf0AJhRMwm+qN1HsFavrFrCqfkw+yuuUoOjfypah
        2RfhwgQchzo6rUrYb6udS3FtibpkspjTiRfr5Bhy6RCBKYevAjWzZZ/boIzmRyszasMc5rEfJfQ
        AVjywDSXMYuF88pk0uDxhLCRiMR7om0NUKusT7Ry+GiedyUrhRN/ggpquyely1sW0Uw==
X-Google-Smtp-Source: ACHHUZ5GcyBwTpISeMA9NkxG9VF5mRhyi6pHwjWF1J8SaMWEMQQ0omWwHg+MFxnI3CLM7mcTbAO3IUeBFCdteh8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:a715:b0:1a6:42dc:9137 with SMTP
 id w21-20020a170902a71500b001a642dc9137mr284051plq.10.1683139846973; Wed, 03
 May 2023 11:50:46 -0700 (PDT)
Date:   Wed,  3 May 2023 18:50:31 +0000
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230503185031.1810078-7-calvinwan@google.com>
Subject: [PATCH v2 7/7] strbuf: remove environment variables
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a library that only interacts with other primitives, strbuf should
not directly access environment variables within its
functions. Therefore, add an additional variable to function signatures
for functions that use an environment variable and refactor callers to
pass in the environment variable.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 add-patch.c          | 12 +++++++-----
 builtin/am.c         |  2 +-
 builtin/branch.c     |  4 ++--
 builtin/commit.c     |  2 +-
 builtin/merge.c      | 10 ++++++----
 builtin/notes.c      | 16 +++++++++-------
 builtin/rebase.c     |  2 +-
 builtin/stripspace.c |  6 ++++--
 builtin/tag.c        |  9 ++++++---
 fmt-merge-msg.c      |  9 ++++++---
 gpg-interface.c      |  5 +++--
 rebase-interactive.c | 15 ++++++++-------
 sequencer.c          | 24 +++++++++++++++---------
 strbuf.c             | 12 +++++++-----
 strbuf.h             | 12 +++++++-----
 wt-status.c          |  6 +++---
 16 files changed, 86 insertions(+), 60 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 8d770d203f..9702c1aabd 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1105,10 +1105,11 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 	size_t i;
 
 	strbuf_reset(&s->buf);
-	strbuf_commented_addf(&s->buf, _("Manual hunk edit mode -- see bottom for "
-				      "a quick guide.\n"));
+	strbuf_commented_addf(&s->buf, comment_line_char,
+			      _("Manual hunk edit mode -- see bottom for "
+				"a quick guide.\n"));
 	render_hunk(s, hunk, 0, 0, &s->buf);
-	strbuf_commented_addf(&s->buf,
+	strbuf_commented_addf(&s->buf, comment_line_char,
 			      _("---\n"
 				"To remove '%c' lines, make them ' ' lines "
 				"(context).\n"
@@ -1117,12 +1118,13 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 			      s->mode->is_reverse ? '+' : '-',
 			      s->mode->is_reverse ? '-' : '+',
 			      comment_line_char);
-	strbuf_commented_addf(&s->buf, "%s", _(s->mode->edit_hunk_hint));
+	strbuf_commented_addf(&s->buf, comment_line_char, "%s",
+			      _(s->mode->edit_hunk_hint));
 	/*
 	 * TRANSLATORS: 'it' refers to the patch mentioned in the previous
 	 * messages.
 	 */
-	strbuf_commented_addf(&s->buf,
+	strbuf_commented_addf(&s->buf, comment_line_char,
 			      _("If it does not apply cleanly, you will be "
 				"given an opportunity to\n"
 				"edit again.  If all lines of the hunk are "
diff --git a/builtin/am.c b/builtin/am.c
index 5c83f2e003..306489db13 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1283,7 +1283,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	strbuf_addstr(&msg, "\n\n");
 	strbuf_addbuf(&msg, &mi.log_message);
-	strbuf_stripspace(&msg, 0);
+	strbuf_stripspace(&msg, 0, comment_line_char);
 
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
diff --git a/builtin/branch.c b/builtin/branch.c
index 501c47657c..e52afcf4d7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -629,7 +629,7 @@ static int edit_branch_description(const char *branch_name)
 	exists = !read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
-	strbuf_commented_addf(&buf,
+	strbuf_commented_addf(&buf, comment_line_char,
 		    _("Please edit the description for the branch\n"
 		      "  %s\n"
 		      "Lines starting with '%c' will be stripped.\n"),
@@ -640,7 +640,7 @@ static int edit_branch_description(const char *branch_name)
 		strbuf_release(&buf);
 		return -1;
 	}
-	strbuf_stripspace(&buf, 1);
+	strbuf_stripspace(&buf, 1, comment_line_char);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 	if (buf.len || exists)
diff --git a/builtin/commit.c b/builtin/commit.c
index e67c4be221..6d3cc4d9fe 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -893,7 +893,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	s->hints = 0;
 
 	if (clean_message_contents)
-		strbuf_stripspace(&sb, 0);
+		strbuf_stripspace(&sb, 0, comment_line_char);
 
 	if (signoff)
 		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
diff --git a/builtin/merge.c b/builtin/merge.c
index 8da3e46abb..1d14767c0c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -879,13 +879,15 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		strbuf_addch(&msg, '\n');
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			wt_status_append_cut_line(&msg);
-			strbuf_commented_addf(&msg, "\n");
+			strbuf_commented_addf(&msg, comment_line_char, "\n");
 		}
-		strbuf_commented_addf(&msg, _(merge_editor_comment));
+		strbuf_commented_addf(&msg, comment_line_char,
+				      _(merge_editor_comment));
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
-			strbuf_commented_addf(&msg, _(scissors_editor_comment));
+			strbuf_commented_addf(&msg, comment_line_char,
+					      _(scissors_editor_comment));
 		else
-			strbuf_commented_addf(&msg,
+			strbuf_commented_addf(&msg, comment_line_char,
 				_(no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
diff --git a/builtin/notes.c b/builtin/notes.c
index d5788352b6..0918b92752 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -11,6 +11,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "editor.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "notes.h"
@@ -157,7 +158,7 @@ static void write_commented_object(int fd, const struct object_id *object)
 
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
-	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len);
+	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_char);
 	write_or_die(fd, cbuf.buf, cbuf.len);
 
 	strbuf_release(&cbuf);
@@ -185,9 +186,10 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 			copy_obj_to_fd(fd, old_note);
 
 		strbuf_addch(&buf, '\n');
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
-		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
+		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)),
+					   comment_line_char);
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
 		write_or_die(fd, buf.buf, buf.len);
 
 		write_commented_object(fd, object);
@@ -199,7 +201,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 		if (launch_editor(d->edit_path, &d->buf, NULL)) {
 			die(_("please supply the note contents using either -m or -F option"));
 		}
-		strbuf_stripspace(&d->buf, 1);
+		strbuf_stripspace(&d->buf, 1, comment_line_char);
 	}
 }
 
@@ -225,7 +227,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 	strbuf_addstr(&d->buf, arg);
-	strbuf_stripspace(&d->buf, 0);
+	strbuf_stripspace(&d->buf, 0, comment_line_char);
 
 	d->given = 1;
 	return 0;
@@ -244,7 +246,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 			die_errno(_("cannot read '%s'"), arg);
 	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
 		die_errno(_("could not open or read '%s'"), arg);
-	strbuf_stripspace(&d->buf, 0);
+	strbuf_stripspace(&d->buf, 0, comment_line_char);
 
 	d->given = 1;
 	return 0;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ace1d5e8d1..d092e06dc7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -209,7 +209,7 @@ static int edit_todo_file(unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	strbuf_stripspace(&todo_list.buf, 1);
+	strbuf_stripspace(&todo_list.buf, 1, comment_line_char);
 	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
 	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
 					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 9451eb69ff..e182c2a14e 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "setup.h"
@@ -13,7 +14,7 @@ static void comment_lines(struct strbuf *buf)
 	size_t len;
 
 	msg = strbuf_detach(buf, &len);
-	strbuf_add_commented_lines(buf, msg, len);
+	strbuf_add_commented_lines(buf, msg, len, comment_line_char);
 	free(msg);
 }
 
@@ -58,7 +59,8 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		die_errno("could not read the input");
 
 	if (mode == STRIP_DEFAULT || mode == STRIP_COMMENTS)
-		strbuf_stripspace(&buf, mode == STRIP_COMMENTS);
+		strbuf_stripspace(&buf, mode == STRIP_COMMENTS,
+				  comment_line_char);
 	else
 		comment_lines(&buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 1850a6a6fd..c713d14489 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -311,9 +311,11 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addch(&buf, '\n');
 			if (opt->cleanup_mode == CLEANUP_ALL)
-				strbuf_commented_addf(&buf, _(tag_template), tag, comment_line_char);
+				strbuf_commented_addf(&buf, comment_line_char,
+				      _(tag_template), tag,comment_line_char);
 			else
-				strbuf_commented_addf(&buf, _(tag_template_nocleanup), tag, comment_line_char);
+				strbuf_commented_addf(&buf, comment_line_char,
+				      _(tag_template_nocleanup), tag, comment_line_char);
 			write_or_die(fd, buf.buf, buf.len);
 			strbuf_release(&buf);
 		}
@@ -327,7 +329,8 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 	}
 
 	if (opt->cleanup_mode != CLEANUP_NONE)
-		strbuf_stripspace(buf, opt->cleanup_mode == CLEANUP_ALL);
+		strbuf_stripspace(buf, opt->cleanup_mode == CLEANUP_ALL,
+				  comment_line_char);
 
 	if (!opt->message_given && !buf->len)
 		die(_("no tag message?"));
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5af0d4715b..5d15e2387d 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -508,7 +508,8 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 	strbuf_complete_line(tagbuf);
 	if (sig->len) {
 		strbuf_addch(tagbuf, '\n');
-		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len);
+		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len,
+					   comment_line_char);
 	}
 }
 
@@ -554,7 +555,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 				strbuf_addch(&tagline, '\n');
 				strbuf_add_commented_lines(&tagline,
 						origins.items[first_tag].string,
-						strlen(origins.items[first_tag].string));
+						strlen(origins.items[first_tag].string),
+						comment_line_char);
 				strbuf_insert(&tagbuf, 0, tagline.buf,
 					      tagline.len);
 				strbuf_release(&tagline);
@@ -562,7 +564,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			strbuf_addch(&tagbuf, '\n');
 			strbuf_add_commented_lines(&tagbuf,
 					origins.items[i].string,
-					strlen(origins.items[i].string));
+					strlen(origins.items[i].string),
+					comment_line_char);
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
 		strbuf_release(&payload);
diff --git a/gpg-interface.c b/gpg-interface.c
index f3ac5acdd9..b625f17460 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -11,6 +11,7 @@
 #include "tempfile.h"
 #include "alias.h"
 #include "wrapper.h"
+#include "environment.h"
 
 static int git_gpg_config(const char *, const char *, void *);
 
@@ -584,8 +585,8 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		}
 	}
 
-	strbuf_stripspace(&ssh_keygen_out, 0);
-	strbuf_stripspace(&ssh_keygen_err, 0);
+	strbuf_stripspace(&ssh_keygen_out, 0, comment_line_char);
+	strbuf_stripspace(&ssh_keygen_err, 0, comment_line_char);
 	/* Add stderr outputs to show the user actual ssh-keygen errors */
 	strbuf_add(&ssh_keygen_out, ssh_principals_err.buf, ssh_principals_err.len);
 	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 789f407361..c6027e73c1 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -71,13 +71,14 @@ void append_todo_help(int command_count,
 
 	if (!edit_todo) {
 		strbuf_addch(buf, '\n');
-		strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
-					      "Rebase %s onto %s (%d commands)",
-					      command_count),
+		strbuf_commented_addf(buf, comment_line_char,
+				      Q_("Rebase %s onto %s (%d command)",
+					 "Rebase %s onto %s (%d commands)",
+					 command_count),
 				      shortrevisions, shortonto, command_count);
 	}
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
 
 	if (get_missing_commit_check_level() == MISSING_COMMIT_CHECK_ERROR)
 		msg = _("\nDo not remove any line. Use 'drop' "
@@ -86,7 +87,7 @@ void append_todo_help(int command_count,
 		msg = _("\nIf you remove a line here "
 			 "THAT COMMIT WILL BE LOST.\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
 
 	if (edit_todo)
 		msg = _("\nYou are editing the todo file "
@@ -97,7 +98,7 @@ void append_todo_help(int command_count,
 		msg = _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
 }
 
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
@@ -129,7 +130,7 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
 		return -2;
 
-	strbuf_stripspace(&new_todo->buf, 1);
+	strbuf_stripspace(&new_todo->buf, 1, comment_line_char);
 	if (initial && new_todo->buf.len == 0)
 		return -3;
 
diff --git a/sequencer.c b/sequencer.c
index c88d1d9553..9675b62bcb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -659,11 +659,12 @@ void append_conflicts_hint(struct index_state *istate,
 	}
 
 	strbuf_addch(msgbuf, '\n');
-	strbuf_commented_addf(msgbuf, "Conflicts:\n");
+	strbuf_commented_addf(msgbuf, comment_line_char, "Conflicts:\n");
 	for (i = 0; i < istate->cache_nr;) {
 		const struct cache_entry *ce = istate->cache[i++];
 		if (ce_stage(ce)) {
-			strbuf_commented_addf(msgbuf, "\t%s\n", ce->name);
+			strbuf_commented_addf(msgbuf, comment_line_char,
+					      "\t%s\n", ce->name);
 			while (i < istate->cache_nr &&
 			       !strcmp(ce->name, istate->cache[i]->name))
 				i++;
@@ -1142,7 +1143,8 @@ void cleanup_message(struct strbuf *msgbuf,
 	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
 		strbuf_setlen(msgbuf, wt_status_locate_end(msgbuf->buf, msgbuf->len));
 	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(msgbuf, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+		strbuf_stripspace(msgbuf, cleanup_mode == COMMIT_MSG_CLEANUP_ALL,
+				  comment_line_char);
 }
 
 /*
@@ -1173,7 +1175,8 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 	if (!template_file || strbuf_read_file(&tmpl, template_file, 0) <= 0)
 		return 0;
 
-	strbuf_stripspace(&tmpl, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+	strbuf_stripspace(&tmpl, cleanup_mode == COMMIT_MSG_CLEANUP_ALL,
+			  comment_line_char);
 	if (!skip_prefix(sb->buf, tmpl.buf, &start))
 		start = sb->buf;
 	strbuf_release(&tmpl);
@@ -1545,7 +1548,8 @@ static int try_to_commit(struct repository *r,
 		cleanup = opts->default_msg_cleanup;
 
 	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
+		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL,
+				  comment_line_char);
 	if ((flags & EDIT_MSG) && message_is_empty(msg, cleanup)) {
 		res = 1; /* run 'git commit' to display error message */
 		goto out;
@@ -1839,7 +1843,7 @@ static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
 		s += count;
 		len -= count;
 	}
-	strbuf_add_commented_lines(buf, s, len);
+	strbuf_add_commented_lines(buf, s, len, comment_line_char);
 }
 
 /* Does the current fixup chain contain a squash command? */
@@ -1938,7 +1942,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
-	strbuf_add_commented_lines(buf, body, commented_len);
+	strbuf_add_commented_lines(buf, body, commented_len, comment_line_char);
 	/* buf->buf may be reallocated so store an offset into the buffer */
 	fixup_off = buf->len;
 	strbuf_addstr(buf, body + commented_len);
@@ -2028,7 +2032,8 @@ static int update_squash_messages(struct repository *r,
 			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		if (is_fixup_flag(command, flag))
-			strbuf_add_commented_lines(&buf, body, strlen(body));
+			strbuf_add_commented_lines(&buf, body, strlen(body),
+						   comment_line_char);
 		else
 			strbuf_addstr(&buf, body);
 
@@ -2047,7 +2052,8 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
-		strbuf_add_commented_lines(&buf, body, strlen(body));
+		strbuf_add_commented_lines(&buf, body, strlen(body),
+					   comment_line_char);
 	} else
 		return error(_("unknown command: %d"), command);
 	repo_unuse_commit_buffer(r, commit, message);
diff --git a/strbuf.c b/strbuf.c
index d5978fee4e..eba65ca421 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "alloc.h"
-#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "strbuf.h"
@@ -362,7 +361,8 @@ static void add_lines(struct strbuf *out,
 	strbuf_complete_line(out);
 }
 
-void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size)
+void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
+				size_t size, char comment_line_char)
 {
 	static char prefix1[3];
 	static char prefix2[2];
@@ -374,7 +374,8 @@ void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size
 	add_lines(out, prefix1, prefix2, buf, size);
 }
 
-void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...)
+void strbuf_commented_addf(struct strbuf *sb, char comment_line_char,
+			   const char *fmt, ...)
 {
 	va_list params;
 	struct strbuf buf = STRBUF_INIT;
@@ -384,7 +385,7 @@ void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...)
 	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
 
-	strbuf_add_commented_lines(sb, buf.buf, buf.len);
+	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_char);
 	if (incomplete_line)
 		sb->buf[--sb->len] = '\0';
 
@@ -1054,7 +1055,8 @@ static size_t cleanup(char *line, size_t len)
  * Enable skip_comments to skip every line starting with comment
  * character.
  */
-void strbuf_stripspace(struct strbuf *sb, int skip_comments)
+void strbuf_stripspace(struct strbuf *sb, int skip_comments,
+		       char comment_line_char)
 {
 	size_t empties = 0;
 	size_t i, j, len, newlen;
diff --git a/strbuf.h b/strbuf.h
index 1bae7e0f47..bc16fa4ef9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -287,7 +287,8 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
  * by a comment character and a blank.
  */
 void strbuf_add_commented_lines(struct strbuf *out,
-				const char *buf, size_t size);
+				const char *buf, size_t size,
+				char comment_line_char);
 
 
 /**
@@ -416,8 +417,8 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
  * Add a formatted string prepended by a comment character and a
  * blank to the buffer.
  */
-__attribute__((format (printf, 2, 3)))
-void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+void strbuf_commented_addf(struct strbuf *sb, char comment_line_char, const char *fmt, ...);
 
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
@@ -540,9 +541,10 @@ int strbuf_normalize_path(struct strbuf *sb);
 
 /**
  * Strip whitespace from a buffer. The second parameter controls if
- * comments are considered contents to be removed or not.
+ * comments are considered contents to be removed or not. The third parameter
+ * is the comment character that determines whether a line is a comment or not.
  */
-void strbuf_stripspace(struct strbuf *buf, int skip_comments);
+void strbuf_stripspace(struct strbuf *buf, int skip_comments, char comment_line_char);
 
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
diff --git a/wt-status.c b/wt-status.c
index 97b9c1c035..da7734866f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1023,7 +1023,7 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	if (s->display_comment_prefix) {
 		size_t len;
 		summary_content = strbuf_detach(&summary, &len);
-		strbuf_add_commented_lines(&summary, summary_content, len);
+		strbuf_add_commented_lines(&summary, summary_content, len, comment_line_char);
 		free(summary_content);
 	}
 
@@ -1098,8 +1098,8 @@ void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
-	strbuf_commented_addf(buf, "%s", cut_line);
-	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
+	strbuf_commented_addf(buf, comment_line_char, "%s", cut_line);
+	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
 }
 
 void wt_status_add_cut_line(FILE *fp)
-- 
2.40.1.521.gf1e218fcd8-goog

