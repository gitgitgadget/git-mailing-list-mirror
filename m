Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63878C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbjEKTrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbjEKTq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:46:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C5C100F2
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:46:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24deb9c5f8dso4817563a91.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683834307; x=1686426307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hx7WWf35ygBMyzS6BQtZLb1hl4VmbIdiDgdU3N5Ffac=;
        b=vO90xh4X86UtY8kycxxBpyHbeB+8FRs8pAVUIwVeIm2TOXMdUzUugr734seu3ZEKc8
         dDP4BaHuuEvyaB2yupJUxB1fxYf9zsHK/yK+QY4O5Diww35JXszkWmccMGbAYTSwZcxc
         xJOenFCiTnGRbOA/RHljAvls7QCZ7l0zn8a/zdk/tcwCnmNbXU/pWR0mw+X6C1GlDURY
         GZLRsS+pD87BBvhPiUZHoOkRFm9FAiQq2llxLnMMiqUJF5R9xiZUPf+RVA+oqyT/Lf5L
         +TDnupEQ8I/cwCO3+ICEkDhz4ukGLPBCHH1MrYMnFMYR1u8h0sLtXGKB7+XziR0/y62L
         tzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834307; x=1686426307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hx7WWf35ygBMyzS6BQtZLb1hl4VmbIdiDgdU3N5Ffac=;
        b=LO6eFk0hPOw+8I58eB/eOTWV3VKx81V/EwWQ60HZE/I5qIYzb1yYlOPxePm6NPYTih
         rk1RUJlCZs/8X5KLPMasd7i8afaBIekZCxr8Joa7MyMH+Fu8EvZh7O3aVAu44v3M82fT
         z3VZExV8XZ90ldT3DzlruZY47QumucB59HpFjItAmT4FH1bl1qXWNypzKYt+Xsc2qD45
         sDwG/pFlENB/vQs9WkBWpVzCQW+dbPL2WHcrQy7E6bWDD3PacEbWYU1GTWy2YczwWxZS
         j/snp1pkYclmuBp9bXXbqxK+qTpv0+PTd5zX7PTZvk/AM29Sije9nOxj7v6C4yOYueZq
         ISyA==
X-Gm-Message-State: AC+VfDzpddPvGEwujObT/xGxy5OdbL8HPH3wyOUnz7KgbR69AVrSVcqp
        kEmoa00y9ULtseZVoj4ktMpEsMWzFFrhqQa8HTVsTNfMmxUk6vUl/HwDnFGewt2fOPjaqwQY8EF
        LRopoAL11e47DwTFV4Fw5MZKD8CmJvDhfaUbZNs2TJZ9q391Yk9Rg59CuFCtPQ8d4XQ==
X-Google-Smtp-Source: ACHHUZ5C8P3mmOKavxkcM5Rra30iTPQ8Cboc/e0BYP6pWt05rykuBA9VERCUQv7Yi+Zu1/LVUzrnnCK77+Bwvaw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:eac3:b0:250:43a8:183b with SMTP
 id ev3-20020a17090aeac300b0025043a8183bmr6387708pjb.6.1683834307202; Thu, 11
 May 2023 12:45:07 -0700 (PDT)
Date:   Thu, 11 May 2023 19:44:46 +0000
In-Reply-To: <20230508165728.525603-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230508165728.525603-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511194446.1492907-1-calvinwan@google.com>
Subject: [PATCH v5 0/7] strbuf cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reroll includes suggestions made by Eric and Phillip for better
documentation on patch 1 and removal of an extraneous parameter in patch 7.

Calvin Wan (7):
  strbuf: clarify API boundary
  abspath: move related functions to abspath
  credential-store: move related functions to credential-store file
  object-name: move related functions to object-name
  path: move related function to path
  strbuf: clarify dependency
  strbuf: remove global variable

 abspath.c                  |  36 ++++++++++++
 abspath.h                  |  21 +++++++
 add-patch.c                |  12 ++--
 builtin/am.c               |   2 +-
 builtin/branch.c           |   4 +-
 builtin/commit.c           |   2 +-
 builtin/credential-store.c |  19 +++++++
 builtin/merge.c            |  10 ++--
 builtin/notes.c            |  16 +++---
 builtin/rebase.c           |   2 +-
 builtin/stripspace.c       |   6 +-
 builtin/tag.c              |   9 ++-
 fmt-merge-msg.c            |   9 ++-
 gpg-interface.c            |   5 +-
 hook.c                     |   1 +
 object-name.c              |  15 +++++
 object-name.h              |   9 +++
 path.c                     |  20 +++++++
 path.h                     |   5 ++
 pretty.c                   |   1 +
 rebase-interactive.c       |  15 ++---
 sequencer.c                |  24 +++++---
 strbuf.c                   | 112 ++++---------------------------------
 strbuf.h                   |  59 ++++++-------------
 tempfile.c                 |   1 +
 wt-status.c                |   6 +-
 26 files changed, 229 insertions(+), 192 deletions(-)

Range-diff against v4:
1:  e0dd3f5295 ! 1:  287e787c9c strbuf: clarify API boundary
    @@ Commit message
         strbuf: clarify API boundary
     
         strbuf, as a generic and widely used structure across the codebase,
    -    should be limited as a libary to only interact with primitives. Add
    -    documentation so future functions can be appropriately be placed. Older
    +    should be limited as a library to only interact with primitives. Add
    +    documentation so future functions can appropriately be placed. Older
         functions that do not follow this boundary should eventually be moved or
         refactored.
     
      ## strbuf.h ##
    -@@ strbuf.h: struct string_list;
    +@@
    + #ifndef STRBUF_H
    + #define STRBUF_H
    + 
    ++/*
    ++ * NOTE FOR STRBUF DEVELOPERS
    ++ *
    ++ * The objects that this API interacts with should be limited to other
    ++ * primitives, however, there are older functions in here that interact
    ++ * with non-primitive objects which should eventually be moved out or
    ++ * refactored.
    ++ */
    ++
    + struct string_list;
      
      /**
    -  * strbuf's are meant to be used with all the usual C string and memory
    -- * APIs. Given that the length of the buffer is known, it's often better to
    -+ * APIs. The objects that this API interacts with in this file should be 
    -+ * limited to other primitives, however, there are older functions in here 
    -+ * that should eventually be moved out or refactored. 
    -+ * 
    -+ * Given that the length of the buffer is known, it's often better to
    -  * use the mem* functions than a str* one (memchr vs. strchr e.g.).
    -  * Though, one has to be careful about the fact that str* functions often
    -  * stop on NULs and that strbufs may have embedded NULs.
2:  48fb5db28b = 2:  5bd27cad7a abspath: move related functions to abspath
3:  a663f91819 = 3:  08e3e40de6 credential-store: move related functions to credential-store file
4:  ccef9dd5f2 = 4:  1a21d4fdd1 object-name: move related functions to object-name
5:  0d6b9cf0f7 = 5:  03b20f3384 path: move related function to path
6:  5655c56a6d = 6:  b55f4a39e1 strbuf: clarify dependency
7:  874d0efac3 ! 7:  6ea36d7730 strbuf: remove global variable
    @@ Commit message
         not utilize the comment_line_char global variable within its
         functions. Therefore, add an additional parameter for functions that use
         comment_line_char and refactor callers to pass it in instead.
    +    strbuf_stripspace() removes the skip_comments boolean and checks if
    +    comment_line_char is a non-NULL character to determine whether to skip
    +    comments or not.
     
      ## add-patch.c ##
     @@ add-patch.c: static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
    @@ builtin/am.c: static int parse_mail(struct am_state *state, const char *mail)
      	strbuf_addstr(&msg, "\n\n");
      	strbuf_addbuf(&msg, &mi.log_message);
     -	strbuf_stripspace(&msg, 0);
    -+	strbuf_stripspace(&msg, 0, comment_line_char);
    ++	strbuf_stripspace(&msg, '\0');
      
      	assert(!state->author_name);
      	state->author_name = strbuf_detach(&author_name, NULL);
    @@ builtin/branch.c: static int edit_branch_description(const char *branch_name)
      		return -1;
      	}
     -	strbuf_stripspace(&buf, 1);
    -+	strbuf_stripspace(&buf, 1, comment_line_char);
    ++	strbuf_stripspace(&buf, comment_line_char);
      
      	strbuf_addf(&name, "branch.%s.description", branch_name);
      	if (buf.len || exists)
    @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      
      	if (clean_message_contents)
     -		strbuf_stripspace(&sb, 0);
    -+		strbuf_stripspace(&sb, 0, comment_line_char);
    ++		strbuf_stripspace(&sb, '\0');
      
      	if (signoff)
      		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
    @@ builtin/notes.c: static void prepare_note_data(const struct object_id *object, s
      			die(_("please supply the note contents using either -m or -F option"));
      		}
     -		strbuf_stripspace(&d->buf, 1);
    -+		strbuf_stripspace(&d->buf, 1, comment_line_char);
    ++		strbuf_stripspace(&d->buf, comment_line_char);
      	}
      }
      
    @@ builtin/notes.c: static int parse_msg_arg(const struct option *opt, const char *
      		strbuf_addch(&d->buf, '\n');
      	strbuf_addstr(&d->buf, arg);
     -	strbuf_stripspace(&d->buf, 0);
    -+	strbuf_stripspace(&d->buf, 0, comment_line_char);
    ++	strbuf_stripspace(&d->buf, '\0');
      
      	d->given = 1;
      	return 0;
    @@ builtin/notes.c: static int parse_file_arg(const struct option *opt, const char
      	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
      		die_errno(_("could not open or read '%s'"), arg);
     -	strbuf_stripspace(&d->buf, 0);
    -+	strbuf_stripspace(&d->buf, 0, comment_line_char);
    ++	strbuf_stripspace(&d->buf, '\0');
      
      	d->given = 1;
      	return 0;
    @@ builtin/rebase.c: static int edit_todo_file(unsigned flags)
      		return error_errno(_("could not read '%s'."), todo_file);
      
     -	strbuf_stripspace(&todo_list.buf, 1);
    -+	strbuf_stripspace(&todo_list.buf, 1, comment_line_char);
    ++	strbuf_stripspace(&todo_list.buf, comment_line_char);
      	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
      	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
      					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
    @@ builtin/stripspace.c: int cmd_stripspace(int argc, const char **argv, const char
      
      	if (mode == STRIP_DEFAULT || mode == STRIP_COMMENTS)
     -		strbuf_stripspace(&buf, mode == STRIP_COMMENTS);
    -+		strbuf_stripspace(&buf, mode == STRIP_COMMENTS,
    -+				  comment_line_char);
    ++		strbuf_stripspace(&buf,
    ++			  mode == STRIP_COMMENTS ? comment_line_char : '\0');
      	else
      		comment_lines(&buf);
      
    @@ builtin/tag.c: static void create_tag(const struct object_id *object, const char
      
      	if (opt->cleanup_mode != CLEANUP_NONE)
     -		strbuf_stripspace(buf, opt->cleanup_mode == CLEANUP_ALL);
    -+		strbuf_stripspace(buf, opt->cleanup_mode == CLEANUP_ALL,
    -+				  comment_line_char);
    ++		strbuf_stripspace(buf,
    ++		  opt->cleanup_mode == CLEANUP_ALL ? comment_line_char : '\0');
      
      	if (!opt->message_given && !buf->len)
      		die(_("no tag message?"));
    @@ gpg-interface.c: static int verify_ssh_signed_buffer(struct signature_check *sig
      
     -	strbuf_stripspace(&ssh_keygen_out, 0);
     -	strbuf_stripspace(&ssh_keygen_err, 0);
    -+	strbuf_stripspace(&ssh_keygen_out, 0, comment_line_char);
    -+	strbuf_stripspace(&ssh_keygen_err, 0, comment_line_char);
    ++	strbuf_stripspace(&ssh_keygen_out, '\0');
    ++	strbuf_stripspace(&ssh_keygen_err, '\0');
      	/* Add stderr outputs to show the user actual ssh-keygen errors */
      	strbuf_add(&ssh_keygen_out, ssh_principals_err.buf, ssh_principals_err.len);
      	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
    @@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list
      		return -2;
      
     -	strbuf_stripspace(&new_todo->buf, 1);
    -+	strbuf_stripspace(&new_todo->buf, 1, comment_line_char);
    ++	strbuf_stripspace(&new_todo->buf, comment_line_char);
      	if (initial && new_todo->buf.len == 0)
      		return -3;
      
    @@ sequencer.c: void cleanup_message(struct strbuf *msgbuf,
      		strbuf_setlen(msgbuf, wt_status_locate_end(msgbuf->buf, msgbuf->len));
      	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
     -		strbuf_stripspace(msgbuf, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
    -+		strbuf_stripspace(msgbuf, cleanup_mode == COMMIT_MSG_CLEANUP_ALL,
    -+				  comment_line_char);
    ++		strbuf_stripspace(msgbuf,
    ++		  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
      }
      
      /*
    @@ sequencer.c: int template_untouched(const struct strbuf *sb, const char *templat
      		return 0;
      
     -	strbuf_stripspace(&tmpl, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
    -+	strbuf_stripspace(&tmpl, cleanup_mode == COMMIT_MSG_CLEANUP_ALL,
    -+			  comment_line_char);
    ++	strbuf_stripspace(&tmpl,
    ++	  cleanup_mode == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
      	if (!skip_prefix(sb->buf, tmpl.buf, &start))
      		start = sb->buf;
      	strbuf_release(&tmpl);
    @@ sequencer.c: static int try_to_commit(struct repository *r,
      
      	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
     -		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
    -+		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL,
    -+				  comment_line_char);
    ++		strbuf_stripspace(msg,
    ++		  cleanup == COMMIT_MSG_CLEANUP_ALL ? comment_line_char : '\0');
      	if ((flags & EDIT_MSG) && message_is_empty(msg, cleanup)) {
      		res = 1; /* run 'git commit' to display error message */
      		goto out;
    @@ strbuf.c: void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...)
      		sb->buf[--sb->len] = '\0';
      
     @@ strbuf.c: static size_t cleanup(char *line, size_t len)
    -  * Enable skip_comments to skip every line starting with comment
    -  * character.
    +  *
    +  * If last line does not have a newline at the end, one is added.
    +  *
    +- * Enable skip_comments to skip every line starting with comment
    +- * character.
    ++ * Pass a non-NULL comment_line_char to skip every line starting
    ++ * with it
       */
     -void strbuf_stripspace(struct strbuf *sb, int skip_comments)
    -+void strbuf_stripspace(struct strbuf *sb, int skip_comments,
    -+		       char comment_line_char)
    ++void strbuf_stripspace(struct strbuf *sb, char comment_line_char)
      {
      	size_t empties = 0;
      	size_t i, j, len, newlen;
    +@@ strbuf.c: void strbuf_stripspace(struct strbuf *sb, int skip_comments)
    + 		eol = memchr(sb->buf + i, '\n', sb->len - i);
    + 		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
    + 
    +-		if (skip_comments && len && sb->buf[i] == comment_line_char) {
    ++		if (comment_line_char != '\0' && len &&
    ++		    sb->buf[i] == comment_line_char) {
    + 			newlen = 0;
    + 			continue;
    + 		}
     
      ## strbuf.h ##
     @@ strbuf.h: void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
    @@ strbuf.h: void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
      
      __attribute__((format (printf,2,0)))
      void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
    -@@ strbuf.h: int strbuf_normalize_path(struct strbuf *sb);
    +@@ strbuf.h: int strbuf_getcwd(struct strbuf *sb);
    + int strbuf_normalize_path(struct strbuf *sb);
      
      /**
    -  * Strip whitespace from a buffer. The second parameter controls if
    +- * Strip whitespace from a buffer. The second parameter controls if
     - * comments are considered contents to be removed or not.
    -+ * comments are considered contents to be removed or not. The third parameter
    -+ * is the comment character that determines whether a line is a comment or not.
    ++ * Strip whitespace from a buffer. The second parameter is the comment
    ++ * character that determines whether a line is a comment or not. If the
    ++ * second parameter is a non-NULL character, comments are considered
    ++ * contents to be removed.
       */
     -void strbuf_stripspace(struct strbuf *buf, int skip_comments);
    -+void strbuf_stripspace(struct strbuf *buf, int skip_comments, char comment_line_char);
    ++void strbuf_stripspace(struct strbuf *buf, char comment_line_char);
      
      static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
      {
-- 
2.40.1.606.ga4b1b128d6-goog

