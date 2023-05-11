Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3438EC77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbjEKTth (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbjEKTtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:49:12 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6403A8A6B
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-528ab71c95cso4447530a12.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683834516; x=1686426516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwGOOePX/KjpVMn4jR+IiJHZcC7bbhFFV5ADGuEyf0c=;
        b=YJVU7ZkQ3Iyzp3erxr8WojiikkAej64Ja4yo+VM3X/a7qJ+88m55i0BVl8iN1TL3e3
         gMu+jGWGV1HBkKO+I6W9Na1dPy0t9Ao6ViZ088TIluN2u40vtFUkaT+v+nepSh4nW9Aw
         Ka48/w9GkzpR9dWR1sj0HikpI5f+GKMzel9WUY/WzNZjEmZyFYlcGOa3SJ9S/wMYdiZd
         Sk/Njx2pBXjA+bzgn5BqcXh4JQoFMN27FfRFDKf7HvYXtElyHigO42HPRwqQKUKYFYaA
         Gv7sTml4eIFQ4z0fvVgSMEBZOJNFhvAEUI7u0gzf1vjS5sjF59EWXmEs/o4OM8vW7+QD
         rYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834516; x=1686426516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwGOOePX/KjpVMn4jR+IiJHZcC7bbhFFV5ADGuEyf0c=;
        b=WvbJBkIuQUZHR1HUEtSWGihfFQVDReJNy5w+OLzir3PrZSeEARZP+zctJwVutsfrtM
         cv0upcMExvq6ChaQtWTKfgxfUAlHWpwnTGhP6ZCuoCHyaa+6Q68wUyfvdWz18kUbGc3a
         qHlIVtkAJ6ExE09fSSb3IA/Rn5ywLrw1/rztekh9+IkEyjaA46Nbv737rFZBj+KkFq+0
         Ch5DcTn/Vb67M5uQoAalikgg6g42+cVwqP7MjJXSInZCA1b3MCzPBafVH3Z6DJ8zSGA+
         x/LH0NUUszkZTVdFbOudqyauNbjydm+GrWQeRxqriQ9xsh9tS8wYPhC1E9syQbKyq/36
         zCpg==
X-Gm-Message-State: AC+VfDyVjAgaDtJRJRJYwaiClCrRmINlN6zLCFQ9gY4V5nZhuI03IQtA
        d8ao5a43SUp3Tc97tsgk27C8JQ5eO14B6Bn3xEyT3QUD6c1H678qFLjNpJZlkSUC8CIBrGlTnu9
        eVQCArUEGMT7ySh8T/JDIgDTtOsCpT3UgA7+ElAgJDeDMWt9B+vYbqfFkmFURug/aPg==
X-Google-Smtp-Source: ACHHUZ7GlOJAT43nyMaLR37mAqSYivDbnZkyMD9+Rswkk5EZZfFEYa51BI5Mb+CsMJfdO+nG9gJDRU3Gu13aX60=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:c115:b0:1a6:d9db:9382 with SMTP
 id 21-20020a170902c11500b001a6d9db9382mr7455486pli.11.1683834516561; Thu, 11
 May 2023 12:48:36 -0700 (PDT)
Date:   Thu, 11 May 2023 19:48:22 +0000
In-Reply-To: <20230511194446.1492907-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511194822.1493798-7-calvinwan@google.com>
Subject: [PATCH v5 7/7] strbuf: remove global variable
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a library that only interacts with other primitives, strbuf should
not utilize the comment_line_char global variable within its
functions. Therefore, add an additional parameter for functions that use
comment_line_char and refactor callers to pass it in instead.
strbuf_stripspace() removes the skip_comments boolean and checks if
comment_line_char is a non-NULL character to determine whether to skip
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
 strbuf.h             | 15 +++++++++------
 wt-status.c          |  6 +++---
 16 files changed, 91 insertions(+), 64 deletions(-)

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
index 501c47657c..4560610d09 100644
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
index f3ac5acdd9..c27a751b70 100644
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
+	strbuf_stripspace(&ssh_keygen_out, '\0');
+	strbuf_stripspace(&ssh_keygen_err, '\0');
 	/* Add stderr outputs to show the user actual ssh-keygen errors */
 	strbuf_add(&ssh_keygen_out, ssh_principals_err.buf, ssh_principals_err.len);
 	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 789f407361..012defbb53 100644
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
+	strbuf_stripspace(&new_todo->buf, comment_line_char);
 	if (initial && new_todo->buf.len == 0)
 		return -3;
 
diff --git a/sequencer.c b/sequencer.c
index c88d1d9553..eae4563ef7 100644
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
+		strbuf_stripspace(msgbuf,
+		  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
 }
 
 /*
@@ -1173,7 +1175,8 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 	if (!template_file || strbuf_read_file(&tmpl, template_file, 0) <= 0)
 		return 0;
 
-	strbuf_stripspace(&tmpl, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+	strbuf_stripspace(&tmpl,
+	  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
 	if (!skip_prefix(sb->buf, tmpl.buf, &start))
 		start = sb->buf;
 	strbuf_release(&tmpl);
@@ -1545,7 +1548,8 @@ static int try_to_commit(struct repository *r,
 		cleanup = opts->default_msg_cleanup;
 
 	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
+		strbuf_stripspace(msg,
+		  cleanup == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
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
index d5978fee4e..9348ac6863 100644
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
+ * Pass a non-NULL comment_line_char to skip every line starting
+ * with it
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
+		if (comment_line_char != '\0' && len &&
+		    sb->buf[i] == comment_line_char) {
 			newlen = 0;
 			continue;
 		}
diff --git a/strbuf.h b/strbuf.h
index b38bfd34af..89ae30b620 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -292,7 +292,8 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
  * by a comment character and a blank.
  */
 void strbuf_add_commented_lines(struct strbuf *out,
-				const char *buf, size_t size);
+				const char *buf, size_t size,
+				char comment_line_char);
 
 
 /**
@@ -421,8 +422,8 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
  * Add a formatted string prepended by a comment character and a
  * blank to the buffer.
  */
-__attribute__((format (printf, 2, 3)))
-void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+void strbuf_commented_addf(struct strbuf *sb, char comment_line_char, const char *fmt, ...);
 
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
@@ -544,10 +545,12 @@ int strbuf_getcwd(struct strbuf *sb);
 int strbuf_normalize_path(struct strbuf *sb);
 
 /**
- * Strip whitespace from a buffer. The second parameter controls if
- * comments are considered contents to be removed or not.
+ * Strip whitespace from a buffer. The second parameter is the comment
+ * character that determines whether a line is a comment or not. If the
+ * second parameter is a non-NULL character, comments are considered
+ * contents to be removed.
  */
-void strbuf_stripspace(struct strbuf *buf, int skip_comments);
+void strbuf_stripspace(struct strbuf *buf, char comment_line_char);
 
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
2.40.1.606.ga4b1b128d6-goog

