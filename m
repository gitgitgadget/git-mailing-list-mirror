Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75437C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4409B20716
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8rwvET2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgHQRlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731468AbgHQRkS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:40:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B9C061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p20so15828304wrf.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=iRyWgiT0ooiuZMK38WqdfYp3Q+fakYYMH5ljbfFQ72A=;
        b=a8rwvET2KETORd3+d0VKfKmfjQDpPErKcI/lbibVTAr5Z/E8OzlJEq9zgghewS1Ccw
         0MDvhB6Nx+3KYyYT6NtxVlWa210+m8h9LmtEBo4RYXKdBJtq1SVKLRdR9gmLowJDXWwT
         LTfPoayFmgW9qCAPAXGbVB2ZvLnezlwDRl5rs0GrqXX4BFtE2N5PoGqrN4hulphLDfat
         Q0GAUh6+CX28r/tP+wtjF9avy2VMudFjdErzVba6r81IOKTMIJ/1VTAntecCzx2Iqpxk
         MzrMrAUwD8lT/CH8fDFG574Pzj58hKqSX0ULT3090ssaFvb3TSzE/GpzU4spLfIIUE+R
         XR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=iRyWgiT0ooiuZMK38WqdfYp3Q+fakYYMH5ljbfFQ72A=;
        b=tkBOkGRMSDUpsQ891MaDCXqLge9X8zsDdYdxooS3EsjJOj8TQy72xrAEpkClcLM9/9
         yll2SP7TELJkSx0RkXQxXIkMVVpR1DlIeButo0sQz02/ui3Vss2loQ5rf9c5pXLxvdUG
         MctGRFCn+M2E7hR21nLtx6i+Yt8simXwejPIa3SVmzqF37mhRLUuvGwW7R5cDgKKWX+e
         NCOSXmBGkHwfUh4+BZnLQ/THE3+dpnUP9AkZtGOTKrxgFF7UH5UP7MaWozR1lfZzz5LQ
         Yzdh24sBQKFZRuTP6BrkXqyjes1LqNy5q2pNX5VSouuKE/5foE1PKDGCFok6xYh6nc56
         VwKw==
X-Gm-Message-State: AOAM533IsLquEUQBVvF5CoVMSCXV8XGd18ewupKD0iDaqdMZjtubLyQ1
        tr6HnpoFotUMkAIDrAkMjg0=
X-Google-Smtp-Source: ABdhPJxVQUNuTyB7n3fIKXAK3IDd2pf8J5c6AKCodbQ1Yg/tbOurotwqLrdMMWoskDJW2BGXKc5/qA==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr17522157wrb.53.1597686013061;
        Mon, 17 Aug 2020 10:40:13 -0700 (PDT)
Received: from localhost.localdomain (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id l10sm31252058wru.3.2020.08.17.10.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:40:11 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 0/5] cleanup ra/rebase-i-more-options
Date:   Mon, 17 Aug 2020 18:39:59 +0100
Message-Id: <20200817174004.92455-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to dscho for his comments on v7. Patch 2 is new, it extends
commit_tree_extended() to take an explicit committer and changes am to
use that rather than exporting GIT_COMMITTER_DATE. The old patch 3 is
gone as it renamed a variable in preparation for repurposing it in the
next patch but it is no longer repurposed. The changes in patches 3 &
4 use the new argument to commit_tree_extended() rather than exporting
GIT_COMMITTER_DATE in try_to_commit().

Phillip Wood (3):
  am: stop exporting GIT_COMMITTER_DATE
  rebase -i: support --committer-date-is-author-date
  rebase -i: support --ignore-date

Rohit Ashiwal (2):
  rebase -i: add --ignore-whitespace flag
  rebase: add --reset-author-date

 Documentation/git-rebase.txt           |  33 ++++-
 builtin/am.c                           |  28 +++-
 builtin/commit.c                       |   4 +-
 builtin/rebase.c                       |  47 +++++--
 commit.c                               |  11 +-
 commit.h                               |   7 +-
 ident.c                                |  24 ++--
 sequencer.c                            | 130 +++++++++++++++++-
 sequencer.h                            |   4 +
 t/t3422-rebase-incompatible-options.sh |   2 -
 t/t3436-rebase-more-options.sh         | 180 +++++++++++++++++++++++++
 11 files changed, 422 insertions(+), 48 deletions(-)
 create mode 100755 t/t3436-rebase-more-options.sh

Range-diff against v7:
1:  5bb4226007 = 1:  5bb4226007 rebase -i: add --ignore-whitespace flag
-:  ---------- > 2:  33f62dd2a0 am: stop exporting GIT_COMMITTER_DATE
2:  e5fdb574ed ! 3:  34431945c8 rebase -i: support --committer-date-is-author-date
    @@ Documentation/git-rebase.txt: if the other side had no changes that conflicted.
      --committer-date-is-author-date::
     +	Instead of using the current time as the committer date, use
     +	the author date of the commit being rebased as the committer
    -+	date. This option implies --force-rebase.
    ++	date. This option implies `--force-rebase`.
     +
      --ignore-date::
     -	These flags are passed to 'git am' to easily change the dates
    @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs
      static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
      static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
      static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
    +@@ sequencer.c: int sequencer_remove_state(struct replay_opts *opts)
    + 		}
    + 	}
    + 
    ++	free(opts->committer_name);
    ++	free(opts->committer_email);
    + 	free(opts->gpg_sign);
    + 	free(opts->strategy);
    + 	for (i = 0; i < opts->xopts_nr; i++)
     @@ sequencer.c: static char *get_author(const char *message)
      	return NULL;
      }
    @@ sequencer.c: static int run_git_commit(struct repository *r,
      
      	if (!(flags & VERIFY_MSG))
     @@ sequencer.c: static int try_to_commit(struct repository *r,
    - 		commit_list_insert(current_head, &parents);
    + 	struct strbuf err = STRBUF_INIT;
    + 	struct strbuf commit_msg = STRBUF_INIT;
    + 	char *amend_author = NULL;
    ++	const char *committer = NULL;
    + 	const char *hook_commit = NULL;
    + 	enum commit_msg_cleanup_mode cleanup;
    + 	int res = 0;
    +@@ sequencer.c: static int try_to_commit(struct repository *r,
    + 		goto out;
      	}
      
    +-	reset_ident_date();
     +	if (opts->committer_date_is_author_date) {
    -+		struct ident_split ident;
    ++		struct ident_split id;
     +		struct strbuf date = STRBUF_INIT;
     +
    -+		if (split_ident_line(&ident, author, (int)strlen(author)) < 0) {
    -+			res = error(_("malformed ident line '%s'"), author);
    ++		if (split_ident_line(&id, author, (int)strlen(author)) < 0) {
    ++			res = error(_("invalid author identity '%s'"), author);
     +			goto out;
     +		}
    -+		if (!ident.date_begin) {
    -+			res = error(_("corrupted author without date information"));
    ++		if (!id.date_begin) {
    ++			res = error(_("corrupt author: missing date information"));
     +			goto out;
     +		}
    -+
     +		strbuf_addf(&date, "@%.*s %.*s",
    -+			    (int)(ident.date_end - ident.date_begin),
    -+			    ident.date_begin,
    -+			    (int)(ident.tz_end - ident.tz_begin),
    -+			    ident.tz_begin);
    -+		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
    ++			    (int)(id.date_end - id.date_begin), id.date_begin,
    ++			    (int)(id.tz_end - id.tz_begin), id.tz_begin);
    ++		committer = fmt_ident(opts->committer_name,
    ++				      opts->committer_email,
    ++				      WANT_COMMITTER_IDENT, date.buf,
    ++				      IDENT_STRICT);
     +		strbuf_release(&date);
    -+
    -+		if (res)
    -+			goto out;
    ++	} else {
    ++		reset_ident_date();
     +	}
    -+
    - 	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
    - 		res = error(_("git write-tree failed to write a tree"));
    + 
    + 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents, oid,
    +-				 author, NULL, opts->gpg_sign, extra)) {
    ++				 author, committer, opts->gpg_sign, extra)) {
    + 		res = error(_("failed to write commit object"));
      		goto out;
    + 	}
     @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
      			opts->signoff = 1;
      		}
    @@ sequencer.c: static int pick_commits(struct repository *r,
      	if (opts->allow_ff)
      		assert(!(opts->signoff || opts->no_commit ||
     -				opts->record_origin || opts->edit));
    -+				opts->record_origin || opts->edit ||
    -+				opts->committer_date_is_author_date));
    ++			 opts->record_origin || opts->edit ||
    ++			 opts->committer_date_is_author_date));
      	if (read_and_refresh_cache(r, opts))
      		return -1;
      
    +@@ sequencer.c: static int commit_staged_changes(struct repository *r,
    + 	return 0;
    + }
    + 
    ++static int init_committer(struct replay_opts *opts)
    ++{
    ++	struct ident_split id;
    ++	const char *committer;
    ++
    ++	committer = git_committer_info(IDENT_STRICT);
    ++	if (split_ident_line(&id, committer, strlen(committer)) < 0)
    ++		return error(_("invalid committer '%s'"), committer);
    ++	opts->committer_name =
    ++		xmemdupz(id.name_begin, id.name_end - id.name_begin);
    ++	opts->committer_email =
    ++		xmemdupz(id.mail_begin, id.mail_end - id.mail_end);
    ++
    ++	return 0;
    ++}
    ++
    + int sequencer_continue(struct repository *r, struct replay_opts *opts)
    + {
    + 	struct todo_list todo_list = TODO_LIST_INIT;
    +@@ sequencer.c: int sequencer_continue(struct repository *r, struct replay_opts *opts)
    + 	if (read_populate_opts(opts))
    + 		return -1;
    + 	if (is_rebase_i(opts)) {
    ++		if (opts->committer_date_is_author_date && init_committer(opts))
    ++			return -1;
    ++
    + 		if ((res = read_populate_todo(r, &todo_list, opts)))
    + 			goto release_todo_list;
    + 
    +@@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
    + 
    + 	res = -1;
    + 
    ++	if (opts->committer_date_is_author_date && init_committer(opts))
    ++		goto cleanup;
    ++
    + 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
    + 		goto cleanup;
    + 
     
      ## sequencer.h ##
     @@ sequencer.h: struct replay_opts {
    @@ sequencer.h: struct replay_opts {
      
      	int mainline;
      
    ++	char *committer_name;
    ++	char *committer_email;
    + 	char *gpg_sign;
    + 	enum commit_msg_cleanup_mode default_msg_cleanup;
    + 	int explicit_cleanup;
     
      ## t/t3422-rebase-incompatible-options.sh ##
     @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
3:  cf5c9a2456 < -:  ---------- sequencer: rename amend_author to author_to_free
4:  3865fdf461 ! 4:  060c0ea2d0 rebase -i: support --ignore-date
    @@ Commit message
     
      ## Documentation/git-rebase.txt ##
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
    - 	date. This option implies --force-rebase.
    + 	date. This option implies `--force-rebase`.
      
      --ignore-date::
     -	This flag is passed to 'git am' to change the author date
    @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs
      static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
      static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
      static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
    -@@ sequencer.c: static const char *author_date_from_env_array(const struct argv_array *env)
    - 	BUG("GIT_AUTHOR_DATE missing from author script");
    - }
    - 
    -+/* Construct a free()able author string with current time as the author date */
    -+static char *ignore_author_date(const char *author)
    -+{
    -+	int len;
    -+	struct ident_split ident;
    -+	struct strbuf new_author = STRBUF_INIT;
    -+
    -+	if (split_ident_line(&ident, author, strlen(author)) < 0) {
    -+		error(_("invalid author identity: %s"), author);
    -+		return NULL;
    -+	}
    -+
    -+	len = ident.mail_end - ident.name_begin + 1;
    -+	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
    -+	datestamp(&new_author);
    -+	return strbuf_detach(&new_author, NULL);
    -+}
    -+
    - static const char staged_changes_advice[] =
    - N_("you have staged changes in your working tree\n"
    - "If these changes are meant to be squashed into the previous commit, run:\n"
     @@ sequencer.c: static int run_git_commit(struct repository *r,
      
      	if (opts->committer_date_is_author_date)
    @@ sequencer.c: static int run_git_commit(struct repository *r,
      	argv_array_push(&cmd.args, "commit");
      
     @@ sequencer.c: static int try_to_commit(struct repository *r,
    - 			    ident.date_begin,
    - 			    (int)(ident.tz_end - ident.tz_begin),
    - 			    ident.tz_begin);
    --		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
    -+		res = setenv("GIT_COMMITTER_DATE",
    -+			     opts->ignore_date ? "" : date.buf, 1);
    + 		struct ident_split id;
    + 		struct strbuf date = STRBUF_INIT;
    + 
    +-		if (split_ident_line(&id, author, (int)strlen(author)) < 0) {
    +-			res = error(_("invalid author identity '%s'"), author);
    +-			goto out;
    ++		if (!opts->ignore_date) {
    ++			if (split_ident_line(&id, author, (int)strlen(author)) < 0) {
    ++				res = error(_("invalid author identity '%s'"),
    ++					    author);
    ++				goto out;
    ++			}
    ++			if (!id.date_begin) {
    ++				res = error(_(
    ++					"corrupt author: missing date information"));
    ++				goto out;
    ++			}
    ++			strbuf_addf(&date, "@%.*s %.*s",
    ++				    (int)(id.date_end - id.date_begin),
    ++				    id.date_begin,
    ++				    (int)(id.tz_end - id.tz_begin),
    ++				    id.tz_begin);
    ++		} else {
    ++			reset_ident_date();
    + 		}
    +-		if (!id.date_begin) {
    +-			res = error(_("corrupt author: missing date information"));
    +-			goto out;
    +-		}
    +-		strbuf_addf(&date, "@%.*s %.*s",
    +-			    (int)(id.date_end - id.date_begin), id.date_begin,
    +-			    (int)(id.tz_end - id.tz_begin), id.tz_begin);
    + 		committer = fmt_ident(opts->committer_name,
    + 				      opts->committer_email,
    +-				      WANT_COMMITTER_IDENT, date.buf,
    ++				      WANT_COMMITTER_IDENT,
    ++				      opts->ignore_date ? NULL : date.buf,
    + 				      IDENT_STRICT);
      		strbuf_release(&date);
    - 
    - 		if (res)
    -@@ sequencer.c: static int try_to_commit(struct repository *r,
    - 
    - 	reset_ident_date();
    + 	} else {
    + 		reset_ident_date();
    + 	}
      
     +	if (opts->ignore_date) {
    -+		author = ignore_author_date(author);
    -+		if (!author) {
    -+			res = -1;
    ++		struct ident_split id;
    ++		char *name, *email;
    ++
    ++		if (split_ident_line(&id, author, strlen(author)) < 0) {
    ++			error(_("invalid author identity '%s'"), author);
     +			goto out;
     +		}
    -+		free(author_to_free);
    -+		author_to_free = (char *)author;
    ++		name = xmemdupz(id.name_begin, id.name_end - id.name_begin);
    ++		email = xmemdupz(id.mail_begin, id.mail_end - id.mail_begin);
    ++		author = fmt_ident(name, email, WANT_AUTHOR_IDENT, NULL,
    ++				   IDENT_STRICT);
    ++		free(name);
    ++		free(email);
     +	}
     +
    - 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
    - 				 oid, author, opts->gpg_sign, extra)) {
    + 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents, oid,
    + 				 author, committer, opts->gpg_sign, extra)) {
      		res = error(_("failed to write commit object"));
     @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
      			opts->committer_date_is_author_date = 1;
    @@ sequencer.c: static int do_merge(struct repository *r,
     @@ sequencer.c: static int pick_commits(struct repository *r,
      	if (opts->allow_ff)
      		assert(!(opts->signoff || opts->no_commit ||
    - 				opts->record_origin || opts->edit ||
    --				opts->committer_date_is_author_date));
    -+				opts->committer_date_is_author_date ||
    -+				opts->ignore_date));
    + 			 opts->record_origin || opts->edit ||
    +-			 opts->committer_date_is_author_date));
    ++			 opts->committer_date_is_author_date ||
    ++			 opts->ignore_date));
      	if (read_and_refresh_cache(r, opts))
      		return -1;
      
5:  0b6b19cb68 ! 5:  92ed3bed9f rebase: add --reset-author-date
    @@ Commit message
     
      ## Documentation/git-rebase.txt ##
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
    - 	date. This option implies --force-rebase.
    + 	date. This option implies `--force-rebase`.
      
      --ignore-date::
     +--reset-author-date::
-- 
2.28.0

