Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F4C7EE37
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 19:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbjFFTtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbjFFTs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 15:48:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403111B
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 12:48:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568a8704f6dso96884067b3.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686080936; x=1688672936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIiUv9DIIsygv4/ml+WGhsRtYlJ6Qq19t0jg1JIhX8Q=;
        b=5MYYIswO5Q3B9zrjYU8XuoAO4kX+mMk0bslwg1v8pS8qfhcORxNhnaQrKrfHmR2K3b
         C/qY6Rq+zTdmG5tiWJ6z/xYh311KweRV4uBICarhR1Q0JM9wv6bo1bIMwi6OFIL13aFz
         kxW5kgebCmdEUVg5jFZAPGcAU5WVfDVnrHm9iiiI8qSsM/bOiQ4BNqLIGahSpgU70xHy
         zzF1gcLG6l5mv7UcQV15AEM8KhbW7mbdvV6dOpO2xKlpQk8WAZa285hOoFoJ24rl7Pi0
         yeg9nk58a6OHWuDbrd7V9zhyOQnQXH8EUfOGkNudcDH/l4ZVQW6bXz6AXYcEfygOqb2h
         H1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080936; x=1688672936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIiUv9DIIsygv4/ml+WGhsRtYlJ6Qq19t0jg1JIhX8Q=;
        b=Cyz9uxijN2uhMb0b4/2Tws4VCHCGabL2H12eMoTpBq2Iu2YPcrK0GnidB2l2FUWqmS
         55xyUGcElJJ7b+AJXeVIrnmly07BclI5vzbzK/a/r1u9XvDCLUTFlXj80uYjywWA4SoQ
         PrMyj+1B6TaVXs8UloIkmdExLV+W+5Nh4CXfkyrONCd9zFRs4Pxe6gjyol22BtRvkMRq
         eCIMn/i51vSfaZfH9Koi++H8H3VYNZ03I12K5ibjY75ubx1F4UDJeaKMsicwOME3lgZS
         DJRGS3BVWe91j2QYDEpAnUSaPxQlO6ZDNPe0xK98Dg7QuUdsDZIJZPZUxEoBi4o2YV4n
         SzxA==
X-Gm-Message-State: AC+VfDz9mNY1K/BOJ9OAKgS5XuEivgrk60T2uzAxgbiyBvamPyOjdqaY
        X56rNKu564gfzPXJIg9jlmB8b6yBalbk7Le9d7pxHPyhP0gHvg6Q9XQnmbZe8mX7/OLXRQWsEgM
        UjM/3NjzaOlZZIQAfqyhMAuXcObZI/0sDiVc2PqcFBi0kt5AOkcEhCgPlYKn1bjOaJw==
X-Google-Smtp-Source: ACHHUZ5Iii61M+A4denOhW3XHYt5Kzbp7LIkKhjXAF+8p95euI1+7FfkjdJWWDhs+Y7VV6v9B6Y+sHV5wg24/8o=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:9d90:0:b0:bb3:8945:d6fa with SMTP id
 v16-20020a259d90000000b00bb38945d6famr1118422ybp.7.1686080936612; Tue, 06 Jun
 2023 12:48:56 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:48:43 +0000
In-Reply-To: <20230606194720.2053551-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606194720.2053551-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230606194843.2054314-7-calvinwan@google.com>
Subject: [PATCH v7 7/7] strbuf: remove global variable
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a library that only interacts with other primitives, strbuf should
not utilize the comment_line_char global variable within its
functions. Therefore, add an additional parameter for functions that use
comment_line_char and refactor callers to pass it in instead.
strbuf_stripspace() removes the skip_comments boolean and checks if
comment_line_char is a non-NUL character to determine whether to skip
comments or not.

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
 strbuf.c             | 18 ++++++++++--------
 strbuf.h             | 14 ++++++++------
 wt-status.c          |  6 +++---
 16 files changed, 90 insertions(+), 64 deletions(-)

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
index 5c83f2e003..9ece2e3066 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1283,7 +1283,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	strbuf_addstr(&msg, "\n\n");
 	strbuf_addbuf(&msg, &mi.log_message);
-	strbuf_stripspace(&msg, 0);
+	strbuf_stripspace(&msg, '\0');
 
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
diff --git a/builtin/branch.c b/builtin/branch.c
index e6c2655af6..40a79e60f5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -674,7 +674,7 @@ static int edit_branch_description(const char *branch_name)
 	exists = !read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
-	strbuf_commented_addf(&buf,
+	strbuf_commented_addf(&buf, comment_line_char,
 		    _("Please edit the description for the branch\n"
 		      "  %s\n"
 		      "Lines starting with '%c' will be stripped.\n"),
@@ -685,7 +685,7 @@ static int edit_branch_description(const char *branch_name)
 		strbuf_release(&buf);
 		return -1;
 	}
-	strbuf_stripspace(&buf, 1);
+	strbuf_stripspace(&buf, comment_line_char);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 	if (buf.len || exists)
diff --git a/builtin/commit.c b/builtin/commit.c
index e67c4be221..e002ebf070 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -893,7 +893,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	s->hints = 0;
 
 	if (clean_message_contents)
-		strbuf_stripspace(&sb, 0);
+		strbuf_stripspace(&sb, '\0');
 
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
index d5788352b6..3bad5b458b 100644
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
+		strbuf_stripspace(&d->buf, comment_line_char);
 	}
 }
 
@@ -225,7 +227,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 	strbuf_addstr(&d->buf, arg);
-	strbuf_stripspace(&d->buf, 0);
+	strbuf_stripspace(&d->buf, '\0');
 
 	d->given = 1;
 	return 0;
@@ -244,7 +246,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 			die_errno(_("cannot read '%s'"), arg);
 	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
 		die_errno(_("could not open or read '%s'"), arg);
-	strbuf_stripspace(&d->buf, 0);
+	strbuf_stripspace(&d->buf, '\0');
 
 	d->given = 1;
 	return 0;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ace1d5e8d1..b1ba9fb05d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -209,7 +209,7 @@ static int edit_todo_file(unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	strbuf_stripspace(&todo_list.buf, 1);
+	strbuf_stripspace(&todo_list.buf, comment_line_char);
 	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
 	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
 					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 9451eb69ff..1987752359 100644
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
+		strbuf_stripspace(&buf,
+			  mode == STRIP_COMMENTS ? comment_line_char : '\0');
 	else
 		comment_lines(&buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 1850a6a6fd..b79e0a88e6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -311,9 +311,11 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addch(&buf, '\n');
 			if (opt->cleanup_mode == CLEANUP_ALL)
-				strbuf_commented_addf(&buf, _(tag_template), tag, comment_line_char);
+				strbuf_commented_addf(&buf, comment_line_char,
+				      _(tag_template), tag, comment_line_char);
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
+		strbuf_stripspace(buf,
+		  opt->cleanup_mode == CLEANUP_ALL ? comment_line_char : '\0');
 
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
index 19a3471a0b..6a3817bbca 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -13,6 +13,7 @@
 #include "tempfile.h"
 #include "alias.h"
 #include "wrapper.h"
+#include "environment.h"
 
 static int git_gpg_config(const char *, const char *, void *);
 
@@ -586,8 +587,8 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		}
 	}
 
-	strbuf_stripspace(&ssh_keygen_out, 0);
-	strbuf_stripspace(&ssh_keygen_err, 0);
+	strbuf_stripspace(&ssh_keygen_out, '\0');
+	strbuf_stripspace(&ssh_keygen_err, '\0');
 	/* Add stderr outputs to show the user actual ssh-keygen errors */
 	strbuf_add(&ssh_keygen_out, ssh_principals_err.buf, ssh_principals_err.len);
 	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 852a331318..f286404d4b 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -72,13 +72,14 @@ void append_todo_help(int command_count,
 
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
@@ -87,7 +88,7 @@ void append_todo_help(int command_count,
 		msg = _("\nIf you remove a line here "
 			 "THAT COMMIT WILL BE LOST.\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
 
 	if (edit_todo)
 		msg = _("\nYou are editing the todo file "
@@ -98,7 +99,7 @@ void append_todo_help(int command_count,
 		msg = _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg));
+	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
 }
 
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
@@ -130,7 +131,7 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
 		return -2;
 
-	strbuf_stripspace(&new_todo->buf, 1);
+	strbuf_stripspace(&new_todo->buf, comment_line_char);
 	if (initial && new_todo->buf.len == 0)
 		return -3;
 
diff --git a/sequencer.c b/sequencer.c
index bceb6abcb6..a8a70ab235 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -660,11 +660,12 @@ void append_conflicts_hint(struct index_state *istate,
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
@@ -1143,7 +1144,8 @@ void cleanup_message(struct strbuf *msgbuf,
 	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
 		strbuf_setlen(msgbuf, wt_status_locate_end(msgbuf->buf, msgbuf->len));
 	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(msgbuf, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+		strbuf_stripspace(msgbuf,
+		  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
 }
 
 /*
@@ -1174,7 +1176,8 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 	if (!template_file || strbuf_read_file(&tmpl, template_file, 0) <= 0)
 		return 0;
 
-	strbuf_stripspace(&tmpl, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+	strbuf_stripspace(&tmpl,
+	  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
 	if (!skip_prefix(sb->buf, tmpl.buf, &start))
 		start = sb->buf;
 	strbuf_release(&tmpl);
@@ -1546,7 +1549,8 @@ static int try_to_commit(struct repository *r,
 		cleanup = opts->default_msg_cleanup;
 
 	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
+		strbuf_stripspace(msg,
+		  cleanup == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
 	if ((flags & EDIT_MSG) && message_is_empty(msg, cleanup)) {
 		res = 1; /* run 'git commit' to display error message */
 		goto out;
@@ -1840,7 +1844,7 @@ static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
 		s += count;
 		len -= count;
 	}
-	strbuf_add_commented_lines(buf, s, len);
+	strbuf_add_commented_lines(buf, s, len, comment_line_char);
 }
 
 /* Does the current fixup chain contain a squash command? */
@@ -1939,7 +1943,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
-	strbuf_add_commented_lines(buf, body, commented_len);
+	strbuf_add_commented_lines(buf, body, commented_len, comment_line_char);
 	/* buf->buf may be reallocated so store an offset into the buffer */
 	fixup_off = buf->len;
 	strbuf_addstr(buf, body + commented_len);
@@ -2029,7 +2033,8 @@ static int update_squash_messages(struct repository *r,
 			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		if (is_fixup_flag(command, flag))
-			strbuf_add_commented_lines(&buf, body, strlen(body));
+			strbuf_add_commented_lines(&buf, body, strlen(body),
+						   comment_line_char);
 		else
 			strbuf_addstr(&buf, body);
 
@@ -2048,7 +2053,8 @@ static int update_squash_messages(struct repository *r,
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
index d5978fee4e..67e399b60a 100644
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
 
@@ -1051,10 +1052,10 @@ static size_t cleanup(char *line, size_t len)
  *
  * If last line does not have a newline at the end, one is added.
  *
- * Enable skip_comments to skip every line starting with comment
- * character.
+ * Pass a non-NUL comment_line_char to skip every line starting
+ * with it.
  */
-void strbuf_stripspace(struct strbuf *sb, int skip_comments)
+void strbuf_stripspace(struct strbuf *sb, char comment_line_char)
 {
 	size_t empties = 0;
 	size_t i, j, len, newlen;
@@ -1067,7 +1068,8 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
 		eol = memchr(sb->buf + i, '\n', sb->len - i);
 		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
 
-		if (skip_comments && len && sb->buf[i] == comment_line_char) {
+		if (comment_line_char && len &&
+		    sb->buf[i] == comment_line_char) {
 			newlen = 0;
 			continue;
 		}
diff --git a/strbuf.h b/strbuf.h
index 5d97e27b99..da91c17257 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -291,7 +291,8 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
  * by a comment character and a blank.
  */
 void strbuf_add_commented_lines(struct strbuf *out,
-				const char *buf, size_t size);
+				const char *buf, size_t size,
+				char comment_line_char);
 
 
 /**
@@ -420,8 +421,8 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
  * Add a formatted string prepended by a comment character and a
  * blank to the buffer.
  */
-__attribute__((format (printf, 2, 3)))
-void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+void strbuf_commented_addf(struct strbuf *sb, char comment_line_char, const char *fmt, ...);
 
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
@@ -543,10 +544,11 @@ int strbuf_getcwd(struct strbuf *sb);
 int strbuf_normalize_path(struct strbuf *sb);
 
 /**
- * Strip whitespace from a buffer. The second parameter controls if
- * comments are considered contents to be removed or not.
+ * Strip whitespace from a buffer. If comment_line_char is non-NUL,
+ * then lines beginning with that character are considered comments,
+ * thus removed.
  */
-void strbuf_stripspace(struct strbuf *buf, int skip_comments);
+void strbuf_stripspace(struct strbuf *buf, char comment_line_char);
 
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
diff --git a/wt-status.c b/wt-status.c
index 068b76ef6d..677465b10c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1024,7 +1024,7 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	if (s->display_comment_prefix) {
 		size_t len;
 		summary_content = strbuf_detach(&summary, &len);
-		strbuf_add_commented_lines(&summary, summary_content, len);
+		strbuf_add_commented_lines(&summary, summary_content, len, comment_line_char);
 		free(summary_content);
 	}
 
@@ -1099,8 +1099,8 @@ void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
-	strbuf_commented_addf(buf, "%s", cut_line);
-	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
+	strbuf_commented_addf(buf, comment_line_char, "%s", cut_line);
+	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
 }
 
 void wt_status_add_cut_line(FILE *fp)
-- 
2.41.0.162.gfafddb0af9-goog

