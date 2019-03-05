Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B695C20248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCETSY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50701 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETSY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so3678324wmj.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYzde3qRwzU3jCzcSXoXt7gkWFWMZ87jCW/W8JOGagQ=;
        b=XWQko/pxH120PfyoPGVUvvy/H4Nn7tiMfyYhSwHnTbXAqKT5NOiyag45BnlC3BYHWm
         urxCK0CDV/r/rrbbWGr/bMF6IUXSTurDenkEbz6jnYZJzCuL6AbZI18JTdxSDFJfNcQN
         g6s7FcGe6COfkQbjW5XyXLeayHKb+QFtb15HSN3Okxb5SAMZ8BTFvoOit6LQcvVZEGZS
         aPxKGDDgB7BNLD941o8D/zXgvWinRgECdoCNrtcb3vl+zCFrijpqKzpuXL84ztv52Jkt
         RfxfRIdmh2rJRqOZL8JH7JVrkgKrRTUfj9xfhMm+uD6rwoAKSCgwdOeAoSA6Ow8I058p
         hx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYzde3qRwzU3jCzcSXoXt7gkWFWMZ87jCW/W8JOGagQ=;
        b=A2Scyto8fbzQQymROlG2SA5jYk0s85labA14k4Ax76RnSpOGxujZsBVs43C2/+hKye
         /sI+LY+UMXhvzPqGG/bmGvUGtDMwKYoZYg9Arahg+Uc23kxNsQkaVTS2TZEUHrx2gvUn
         pqYHSRLVoFD2AGG85HTj3lk0FyIEd0jinkR+tpk7bLLmRLMsViLLuzLpFIyry25C5s7j
         w9pU9rtZAFkt9VD8jWIVOHDEy9BFeKDau+XOJe91m7QVye9ZBVlIm9nV95Ov3bQCY+ud
         218i5LxEMV0rJjSyYZ2gZ+VmkO2S958O2BN0lEIhxM0ZPVZkPmgoBI16uXUBXbl9hD86
         jkww==
X-Gm-Message-State: APjAAAUwrzu6vSc9Go9uKyTjjkEJH6gN3fN/4Y2i6fDj81PT5cPS1Eig
        pkib5qUMAyKrEMg08SeLd8kzId8B
X-Google-Smtp-Source: APXvYqwXsLxB8UqHDUyI4HcXpbnepAC2WD6rDLMCqPBi34UYCj8VlsLAGCGkmja5aEVs+hWERwVoxw==
X-Received: by 2002:a1c:eb1a:: with SMTP id j26mr67420wmh.43.1551813500583;
        Tue, 05 Mar 2019 11:18:20 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:19 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 00/18] sequencer: refactor functions working on a todo_list
Date:   Tue,  5 Mar 2019 20:17:47 +0100
Message-Id: <20190305191805.13561-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210132648.12821-1-alban.gruin@gmail.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the center of the "interactive" part of the interactive rebase lies
the todo list.  When the user starts an interactive rebase, a todo list
is generated, presented to the user (who then edits it using a text
editor), read back, and then is checked and processed before the actual
rebase takes place.

Some of this processing includes adding execs commands, reordering
fixup! and squash! commits, and checking if no commits were accidentally
dropped by the user.

Before I converted the interactive rebase in C, these functions were
called by git-rebase--interactive.sh through git-rebase--helper.  Since
the only way to pass around a large amount of data between a shell
script and a C program is to use a file (or any declination of a file),
the functions that checked and processed the todo list were directly
working on a file, the same file that the user edited.

During the conversion, I did not address this issue, which lead to a
complete_action() that reads the todo list file, does some computation
based on its content, and writes it back to the disk, several times in
the same function.

As it is not an efficient way to handle a data structure, this patch
series refactor the functions that processes the todo list to work on a
todo_list structure instead of reading it from the disk.

Some commits consists in modifying edit_todo_list() (initially used by
--edit-todo) to handle the initial edition of the todo list, to increase
code sharing.

This is based on nd/the-index (cde555480b, "Merge branch
'nd/the-index'").

Changes since v7:

 - Add some comments to clarify some assumptions.

 - Use `string_list_remove_empty_items()` instead of `--commands.nr` to
   remove empty commands.

 - Split the last commit ("rebase--interactive: move several functions
   to rebase--interactive.c") into three, one for each function.

The tip of this series is tagged as "refactor-todo-list-v8" in
https://github.com/agrn/git.

The range diff is included below.

Alban Gruin (18):
  sequencer: changes in parse_insn_buffer()
  sequencer: make the todo_list structure public
  sequencer: remove the 'arg' field from todo_item
  sequencer: refactor transform_todos() to work on a todo_list
  sequencer: introduce todo_list_write_to_file()
  sequencer: refactor check_todo_list() to work on a todo_list
  sequencer: refactor sequencer_add_exec_commands() to work on a
    todo_list
  sequencer: refactor rearrange_squash() to work on a todo_list
  sequencer: make sequencer_make_script() write its script to a strbuf
  sequencer: change complete_action() to use the refactored functions
  rebase--interactive: move sequencer_add_exec_commands()
  rebase--interactive: move rearrange_squash_in_todo_file()
  sequencer: refactor skip_unnecessary_picks() to work on a todo_list
  rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
  rebase-interactive: append_todo_help() changes
  rebase-interactive: rewrite edit_todo_list() to handle the initial
    edit
  sequencer: use edit_todo_list() in complete_action()
  rebase--interactive: move transform_todo_file()

 builtin/rebase--interactive.c | 144 ++++++--
 rebase-interactive.c          | 146 ++++++--
 rebase-interactive.h          |   9 +-
 sequencer.c                   | 655 ++++++++++++----------------------
 sequencer.h                   |  81 ++++-
 5 files changed, 553 insertions(+), 482 deletions(-)

Range-diff against v7:
 1:  0bc5f714e5 =  1:  0bc5f714e5 sequencer: changes in parse_insn_buffer()
 2:  34d149ff25 =  2:  34d149ff25 sequencer: make the todo_list structure public
 3:  8200f7a6be =  3:  8200f7a6be sequencer: remove the 'arg' field from todo_item
 4:  ce8ca23ee0 =  4:  ce8ca23ee0 sequencer: refactor transform_todos() to work on a todo_list
 5:  67ebea475e =  5:  67ebea475e sequencer: introduce todo_list_write_to_file()
 6:  370c153ebe =  6:  370c153ebe sequencer: refactor check_todo_list() to work on a todo_list
 7:  66e7b65509 !  7:  95ae0f36d2 sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
    @@ -60,7 +60,10 @@
      
     +	if (cmd && *cmd) {
     +		string_list_split(&commands, cmd, '\n', -1);
    -+		--commands.nr;
    ++
    ++		/* rebase.c adds a new line to cmd after every command,
    ++		 * so here the last command is always empty */
    ++		string_list_remove_empty_items(&commands, 0);
     +	}
     +
      	switch (command) {
    @@ -86,7 +89,7 @@
      		BUG("invalid command '%d'", command);
      	}
      
    -+	string_list_clear(&commands, 1);
    ++	string_list_clear(&commands, 0);
      	return !!ret;
      }
     
    @@ -133,9 +136,16 @@
      	}
      
      	/*
    -@@
    + 	 * Insert <commands> after every pick. Here, fixup/squash chains
      	 * are considered part of the pick, so we insert the commands *after*
      	 * those chains if there are any.
    ++	 *
    ++	 * As we insert the exec commands immediatly after rearranging
    ++	 * any fixups and before the user edits the list, a fixup chain
    ++	 * can never contain comments (any comments are empty picks that
    ++	 * have been commented out because the user did not specify
    ++	 * --keep-empty).  So, it is safe to insert an exec command
    ++	 * without looking at the command following a comment.
      	 */
     -	insert = -1;
     -	for (i = 0; i < todo_list.nr; i++) {
    @@ -165,12 +175,11 @@
     +			insert = 0;
      		}
      
    --		if (command == TODO_PICK || command == TODO_MERGE)
    --			insert = i + 1;
     +		ALLOC_GROW(items, nr + 1, alloc);
     +		items[nr++] = todo_list->items[i];
     +
    -+		if (command == TODO_PICK || command == TODO_MERGE || is_fixup(command))
    + 		if (command == TODO_PICK || command == TODO_MERGE)
    +-			insert = i + 1;
     +			insert = 1;
      	}
      
    @@ -192,8 +201,7 @@
     +	todo_list->nr = nr;
     +	todo_list->alloc = alloc;
     +}
    - 
    --	i = write_message(buf->buf, buf->len, todo_file, 0);
    ++
     +int sequencer_add_exec_commands(struct repository *r,
     +				struct string_list *commands)
     +{
    @@ -203,7 +211,8 @@
     +
     +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
     +		return error_errno(_("could not read '%s'."), todo_file);
    -+
    + 
    +-	i = write_message(buf->buf, buf->len, todo_file, 0);
     +	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
     +		todo_list_release(&todo_list);
     +		return error(_("unusable todo list: '%s'"), todo_file);
 8:  640cb7aa54 =  8:  144eb32743 sequencer: refactor rearrange_squash() to work on a todo_list
 9:  bef1970c88 =  9:  1501c26317 sequencer: make sequencer_make_script() write its script to a strbuf
10:  48ee37a32a = 10:  121b270c4d sequencer: change complete_action() to use the refactored functions
16:  f57a7405d0 ! 11:  a3763ecb0e rebase--interactive: move several functions to rebase--interactive.c
    @@ -1,13 +1,12 @@
     Author: Alban Gruin <alban.gruin@gmail.com>
     
    -    rebase--interactive: move several functions to rebase--interactive.c
    +    rebase--interactive: move sequencer_add_exec_commands()
     
    -    As sequencer_add_exec_commands(), rearrange_squash_in_todo_file(), and
    -    transform_todo_file() are only needed inside of rebase--interactive.c
    -    for rebase -p, they are moved there from sequencer.c.
    +    As sequencer_add_exec_commands() is only needed inside of
    +    rebase--interactive.c for `rebase -p', it is moved there from
    +    sequencer.c.
     
    -    The parameter r (repository) is dropped from them, and the error
    -    handling of rearrange_squash_in_todo_file() is slightly improved.
    +    The parameter r (repository) is dropped along the way.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
    @@ -43,72 +42,11 @@
     +	return 0;
     +}
     +
    -+static int rearrange_squash_in_todo_file(void)
    -+{
    -+	const char *todo_file = rebase_path_todo();
    -+	struct todo_list todo_list = TODO_LIST_INIT;
    -+	int res = 0;
    -+
    -+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
    -+		return error_errno(_("could not read '%s'."), todo_file);
    -+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
    -+					&todo_list)) {
    -+		todo_list_release(&todo_list);
    -+		return error(_("unusable todo list: '%s'"), todo_file);
    -+	}
    -+
    -+	res = todo_list_rearrange_squash(&todo_list);
    -+	if (!res)
    -+		res = todo_list_write_to_file(the_repository, &todo_list,
    -+					      todo_file, NULL, NULL, -1, 0);
    -+
    -+	todo_list_release(&todo_list);
    -+
    -+	if (res)
    -+		return error_errno(_("could not write '%s'."), todo_file);
    -+	return 0;
    -+}
    -+
    -+static int transform_todo_file(unsigned flags)
    -+{
    -+	const char *todo_file = rebase_path_todo();
    -+	struct todo_list todo_list = TODO_LIST_INIT;
    -+	int res;
    -+
    -+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
    -+		return error_errno(_("could not read '%s'."), todo_file);
    -+
    -+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
    -+					&todo_list)) {
    -+		todo_list_release(&todo_list);
    -+		return error(_("unusable todo list: '%s'"), todo_file);
    -+	}
    -+
    -+	res = todo_list_write_to_file(the_repository, &todo_list, todo_file,
    -+				      NULL, NULL, -1, flags);
    -+	todo_list_release(&todo_list);
    -+
    -+	if (res)
    -+		return error_errno(_("could not write '%s'."), todo_file);
    -+	return 0;
    -+}
    -+
    - static int edit_todo_file(unsigned flags)
    - {
    - 	const char *todo_file = rebase_path_todo();
    + static int get_revision_ranges(const char *upstream, const char *onto,
    + 			       const char **head_hash,
    + 			       char **revisions, char **shortrevisions)
     @@
    - 	}
    - 	case SHORTEN_OIDS:
    - 	case EXPAND_OIDS:
    --		ret = transform_todo_file(the_repository, flags);
    -+		ret = transform_todo_file(flags);
    - 		break;
    - 	case CHECK_TODO_LIST:
    - 		ret = check_todo_list_from_file(the_repository);
    - 		break;
    - 	case REARRANGE_SQUASH:
    --		ret = rearrange_squash_in_todo_file(the_repository);
    -+		ret = rearrange_squash_in_todo_file();
    + 		ret = rearrange_squash_in_todo_file(the_repository);
      		break;
      	case ADD_EXEC:
     -		ret = sequencer_add_exec_commands(the_repository, &commands);
    @@ -162,82 +100,6 @@
      static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
      				struct strbuf *buf, int num, unsigned flags)
      {
    -@@
    - 	return res;
    - }
    - 
    --int transform_todo_file(struct repository *r, unsigned flags)
    --{
    --	const char *todo_file = rebase_path_todo();
    --	struct todo_list todo_list = TODO_LIST_INIT;
    --	int res;
    --
    --	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
    --		return error_errno(_("could not read '%s'."), todo_file);
    --
    --	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
    --		todo_list_release(&todo_list);
    --		return error(_("unusable todo list: '%s'"), todo_file);
    --	}
    --
    --	res = todo_list_write_to_file(r, &todo_list, todo_file,
    --				      NULL, NULL, -1, flags);
    --	todo_list_release(&todo_list);
    --
    --	if (res)
    --		return error_errno(_("could not write '%s'."), todo_file);
    --	return 0;
    --}
    --
    - static const char edit_todo_list_advice[] =
    - N_("You can fix this with 'git rebase --edit-todo' "
    - "and then run 'git rebase --continue'.\n"
    -@@
    - 	return 0;
    - }
    - 
    --static int todo_list_rearrange_squash(struct todo_list *todo_list);
    --
    - int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
    - 		    const char *shortrevisions, const char *onto_name,
    - 		    const char *onto, const char *orig_head, struct string_list *commands,
    -@@
    -  * message will have to be retrieved from the commit (as the oneline in the
    -  * script cannot be trusted) in order to normalize the autosquash arrangement.
    -  */
    --static int todo_list_rearrange_squash(struct todo_list *todo_list)
    -+int todo_list_rearrange_squash(struct todo_list *todo_list)
    - {
    - 	struct hashmap subject2item;
    - 	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
    -@@
    - 
    - 	return 0;
    - }
    --
    --int rearrange_squash_in_todo_file(struct repository *r)
    --{
    --	const char *todo_file = rebase_path_todo();
    --	struct todo_list todo_list = TODO_LIST_INIT;
    --	int res = 0;
    --
    --	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
    --		return -1;
    --	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
    --		todo_list_release(&todo_list);
    --		return -1;
    --	}
    --
    --	res = todo_list_rearrange_squash(&todo_list);
    --	if (!res)
    --		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
    --
    --	todo_list_release(&todo_list);
    --
    --	if (res)
    --		return error_errno(_("could not write '%s'."), todo_file);
    --	return 0;
    --}
     
      diff --git a/sequencer.h b/sequencer.h
      --- a/sequencer.h
    @@ -248,16 +110,9 @@
      
     -int sequencer_add_exec_commands(struct repository *r,
     -				struct string_list *commands);
    --int transform_todo_file(struct repository *r, unsigned flags);
    + int transform_todo_file(struct repository *r, unsigned flags);
     +void todo_list_add_exec_commands(struct todo_list *todo_list,
     +				 struct string_list *commands);
      int check_todo_list_from_file(struct repository *r);
      int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
      		    const char *shortrevisions, const char *onto_name,
    - 		    const char *onto, const char *orig_head, struct string_list *commands,
    - 		    unsigned autosquash, struct todo_list *todo_list);
    --int rearrange_squash_in_todo_file(struct repository *r);
    -+int todo_list_rearrange_squash(struct todo_list *todo_list);
    - 
    - extern const char sign_off_header[];
    - 
 -:  ---------- > 12:  e03663ed04 rebase--interactive: move rearrange_squash_in_todo_file()
11:  bc89fbfea6 = 13:  d9cf3d7d2f sequencer: refactor skip_unnecessary_picks() to work on a todo_list
12:  a754d0da96 = 14:  bf6cc5978c rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
13:  031e4de856 = 15:  1c9d1cb3c9 rebase-interactive: append_todo_help() changes
14:  268998924b ! 16:  b98b07dae0 rebase-interactive: rewrite edit_todo_list() to handle the initial edit
    @@ -16,8 +16,8 @@
      --- a/builtin/rebase--interactive.c
      +++ b/builtin/rebase--interactive.c
     @@
    - static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
    - static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
    + 	return 0;
    + }
      
     +static int edit_todo_file(unsigned flags)
     +{
    @@ -87,6 +87,9 @@
     -		todo_list_release(&todo_list);
     -		return -1;
     -	}
    ++	/* If the user is editing the todo list, we first try to parse
    ++	 * it.  If there is an error, we do not return, because the user
    ++	 * might want to fix it in the first place. */
     +	if (!initial)
     +		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
      
    @@ -110,6 +113,8 @@
     +	if (initial && new_todo->buf.len == 0)
     +		return -3;
     +
    ++	/* For the initial edit, the todo list gets parsed in
    ++	 * complete_action(). */
     +	if (!initial)
     +		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
     +
15:  6f1274a33c = 17:  406e971e56 sequencer: use edit_todo_list() in complete_action()
 -:  ---------- > 18:  51d44a8200 rebase--interactive: move transform_todo_file()
-- 
2.20.1

