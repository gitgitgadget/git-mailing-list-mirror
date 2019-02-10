Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972D51F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfBJN1J (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51075 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfBJN1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id z5so12198285wmf.0
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYXFVy4j6w1+lOB4ZfqyqnqKPLbHjc63gxjdCJ8juFE=;
        b=QmSyDbGDRLAfpb0FuSJRuPrHu9egoBen6pOdMvTNaCA1tBFsCK0JhV1IrVkqA+ir+y
         3KvoDimPZ7Dnvkw2hFh4cRvvi5pnvnZn17X7AeR7KE4wqimxIXXumVE6/lee9VNBGMMs
         AGYJv7eKywW7dP2wz563Fr7SIb7nxqorlqTWqTFIf6u9Dr3ksTq2U9ZjA+NECzzvShhD
         OCXYZ2DrliCVeuXzg0yLDJWhxBcGW87wpn8EdB0ppuO1nuhsrGwmXAIsoMGf6rmZIFOu
         FI40er7hU3lTzxtAV7T+DrUBS9yl1RjPL004Va+H/NvRvLmPkpstgDr6ibGhoRU15yRB
         m/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYXFVy4j6w1+lOB4ZfqyqnqKPLbHjc63gxjdCJ8juFE=;
        b=ONO6ToAaaDVqh+0aj8UUDWUZm7OsE7VSVSgGwpJTjq49Md7xrwHrXdyD/JV4/i7j4C
         bAxZ1a9UeeJMxfBcwAZdZbuHYcgUGGnkfbBTRcrTkje++RoKx7mzfgef7BCqj1O4dWmo
         Zt5D/pv4IB2aXLkmAzKg0k7yJ9vfM/vTH6G1BJZpbifIg+nM9KpQe18uO01NIsxbvuFP
         PX/Kg4Ij5nVWf3IbGnIShDCiF+GQZxKM9AnJ9GOzfiPjheKYKO3ZI/YhKdSPjWTWFTWx
         xGLQbeUoIJAeIeOOC0gkQavuRJqyL/gQed/CMwVYRR+JRYVUstlVdxD6hUTpItoQzgJs
         aGhw==
X-Gm-Message-State: AHQUAuZUuy9DHJjKszTBtHzUYsSRuNT2Shaz8TBsRTgsHORd2cOPG2YN
        tNf7TXUN98RL5PkGNBP8bXrv9JQD
X-Google-Smtp-Source: AHgI3IY79NUs4E0LuXwwqX1FYYG8/UWAChxxOznZm0a0SUvs4iwDwCuC8RIQfz3osd9U9rY0nhd49Q==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr23206294wrr.329.1549805226061;
        Sun, 10 Feb 2019 05:27:06 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:05 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 00/16] sequencer: refactor functions working on a todo_list
Date:   Sun, 10 Feb 2019 14:26:32 +0100
Message-Id: <20190210132648.12821-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
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

Changes since v6:

 - The series has been rebased onto cde555480b (this affects the patch
   10/16).

 - [07/16] rebase--interactive does no longer check if the last command
   is empty before decrementing the size of the command list, and frees
   the list before exiting.

 - [07/16] `insert' (in todo_list_add_exec_commands()) is treated as a
   flag instead of an integer.

 - [07/16] Styling change (++i -> i++).

 - [07/16] `exec' commands are inserted before comments, not after.

 - [11/16] Renaming `output_oid' to `base_oid'.

 - [14/16] Better error handling in edit_todo_list() and
   edit_todo_file().

 - [16/16] Move sequencer_add_exec_commands() and
   rearrange_squash_in_todo_file() to rebase--interactive.c.

The tip of this series is tagged as "refactor-todo-list-v7" in
https://github.com/agrn/git.

The range diff is included below.

Alban Gruin (16):
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
  sequencer: refactor skip_unnecessary_picks() to work on a todo_list
  rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
  rebase-interactive: append_todo_help() changes
  rebase-interactive: rewrite edit_todo_list() to handle the initial
    edit
  sequencer: use edit_todo_list() in complete_action()
  rebase--interactive: move several functions to rebase--interactive.c

 builtin/rebase--interactive.c | 141 ++++++--
 rebase-interactive.c          | 141 ++++++--
 rebase-interactive.h          |   9 +-
 sequencer.c                   | 650 ++++++++++++----------------------
 sequencer.h                   |  81 ++++-
 5 files changed, 539 insertions(+), 483 deletions(-)

Range-diff against v6:
 1:  f5d6bb72fa =  1:  0bc5f714e5 sequencer: changes in parse_insn_buffer()
 2:  68dcdd233b =  2:  34d149ff25 sequencer: make the todo_list structure public
 3:  74152c4d60 =  3:  8200f7a6be sequencer: remove the 'arg' field from todo_item
 4:  aff98ea435 =  4:  ce8ca23ee0 sequencer: refactor transform_todos() to work on a todo_list
 5:  e4c85dd743 =  5:  67ebea475e sequencer: introduce todo_list_write_to_file()
 6:  5b1735671b =  6:  370c153ebe sequencer: refactor check_todo_list() to work on a todo_list
 7:  f0734897af !  7:  66e7b65509 sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
    @@ -60,8 +60,7 @@
      
     +	if (cmd && *cmd) {
     +		string_list_split(&commands, cmd, '\n', -1);
    -+		if (strlen(commands.items[commands.nr - 1].string) == 0)
    -+			--commands.nr;
    ++		--commands.nr;
     +	}
     +
      	switch (command) {
    @@ -85,18 +84,19 @@
      		break;
      	default:
      		BUG("invalid command '%d'", command);
    + 	}
    + 
    ++	string_list_clear(&commands, 1);
    + 	return !!ret;
    + }
     
      diff --git a/sequencer.c b/sequencer.c
      --- a/sequencer.c
      +++ b/sequencer.c
     @@
    - 	return 0;
    - }
    - 
    --/*
    -- * Add commands after pick and (series of) squash/fixup commands
    -- * in the todo list.
    -- */
    +  * Add commands after pick and (series of) squash/fixup commands
    +  * in the todo list.
    +  */
     -int sequencer_add_exec_commands(struct repository *r,
     -				const char *commands)
     +static void todo_list_add_exec_commands(struct todo_list *todo_list,
    @@ -115,7 +115,7 @@
     -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
     -		return error(_("could not read '%s'."), todo_file);
     +	base_items = xcalloc(commands->nr, sizeof(struct todo_item));
    -+	for (i = 0; i < commands->nr; ++i) {
    ++	for (i = 0; i < commands->nr; i++) {
     +		size_t command_len = strlen(commands->items[i].string);
      
     -	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
    @@ -134,9 +134,10 @@
      
      	/*
     @@
    + 	 * are considered part of the pick, so we insert the commands *after*
      	 * those chains if there are any.
      	 */
    - 	insert = -1;
    +-	insert = -1;
     -	for (i = 0; i < todo_list.nr; i++) {
     -		enum todo_command command = todo_list.items[i].command;
     -
    @@ -152,21 +153,25 @@
     -				      todo_list.items[insert].offset_in_buf +
     -				      offset, commands, commands_len);
     -			offset += commands_len;
    +-			insert = -1;
    ++	insert = 0;
     +	for (i = 0; i < todo_list->nr; i++) {
     +		enum todo_command command = todo_list->items[i].command;
    -+		if (insert >= 0 && command != TODO_COMMENT && !is_fixup(command)) {
    ++		if (insert && !is_fixup(command)) {
     +			ALLOC_GROW(items, nr + commands->nr, alloc);
     +			COPY_ARRAY(items + nr, base_items, commands->nr);
     +			nr += commands->nr;
    - 			insert = -1;
    ++
    ++			insert = 0;
      		}
      
     -		if (command == TODO_PICK || command == TODO_MERGE)
    +-			insert = i + 1;
     +		ALLOC_GROW(items, nr + 1, alloc);
     +		items[nr++] = todo_list->items[i];
     +
     +		if (command == TODO_PICK || command == TODO_MERGE || is_fixup(command))
    - 			insert = i + 1;
    ++			insert = 1;
      	}
      
      	/* insert or append final <commands> */
    @@ -175,7 +180,7 @@
     -			      offset, commands, commands_len);
     -	else if (insert >= 0 || !offset)
     -		strbuf_add(buf, commands, commands_len);
    -+	if (insert >= 0 || nr == todo_list->nr) {
    ++	if (insert || nr == todo_list->nr) {
     +		ALLOC_GROW(items, nr + commands->nr, alloc);
     +		COPY_ARRAY(items + nr, base_items, commands->nr);
     +		nr += commands->nr;
    @@ -189,10 +194,6 @@
     +}
      
     -	i = write_message(buf->buf, buf->len, todo_file, 0);
    -+/*
    -+ * Add commands after pick and (series of) squash/fixup commands
    -+ * in the todo list.
    -+ */
     +int sequencer_add_exec_commands(struct repository *r,
     +				struct string_list *commands)
     +{
 8:  ecc684c833 =  8:  640cb7aa54 sequencer: refactor rearrange_squash() to work on a todo_list
 9:  4de36e9e76 =  9:  bef1970c88 sequencer: make sequencer_make_script() write its script to a strbuf
10:  d5af79282c ! 10:  48ee37a32a sequencer: change complete_action() to use the refactored functions
    @@ -197,14 +197,6 @@
      
      	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
      		return error(_("could not skip unnecessary pick commands"));
    - 
    - 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
    - 		return -1;
    --;
    -+
    - 	if (require_clean_work_tree(r, "rebase", "", 1, 1))
    - 		return -1;
    - 
     
      diff --git a/sequencer.h b/sequencer.h
      --- a/sequencer.h
11:  b04e1fc692 ! 11:  bc89fbfea6 sequencer: refactor skip_unnecessary_picks() to work on a todo_list
    @@ -38,7 +38,7 @@
     -static int skip_unnecessary_picks(struct repository *r, struct object_id *output_oid)
     +static int skip_unnecessary_picks(struct repository *r,
     +				  struct todo_list *todo_list,
    -+				  struct object_id *output_oid)
    ++				  struct object_id *base_oid)
      {
     -	const char *todo_file = rebase_path_todo();
     -	struct strbuf buf = STRBUF_INIT;
    @@ -77,7 +77,14 @@
      				oid_to_hex(&item->commit->object.oid));
      		}
     @@
    - 		oidcpy(output_oid, &item->commit->object.oid);
    + 		if (item->commit->parents->next)
    + 			break; /* merge commit */
    + 		parent_oid = &item->commit->parents->item->object.oid;
    +-		if (!oideq(parent_oid, output_oid))
    ++		if (!oideq(parent_oid, base_oid))
    + 			break;
    +-		oidcpy(output_oid, &item->commit->object.oid);
    ++		oidcpy(base_oid, &item->commit->object.oid);
      	}
      	if (i > 0) {
     -		int offset = get_item_line_offset(&todo_list, i);
    @@ -112,7 +119,7 @@
     -		if (is_fixup(peek_command(&todo_list, 0)))
     -			record_in_rewritten(output_oid, peek_command(&todo_list, 0));
     +		if (is_fixup(peek_command(todo_list, 0)))
    -+			record_in_rewritten(output_oid, peek_command(todo_list, 0));
    ++			record_in_rewritten(base_oid, peek_command(todo_list, 0));
      	}
      
     -	todo_list_release(&todo_list);
12:  7cc97f77a8 = 12:  a754d0da96 rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
13:  77056f58a2 = 13:  031e4de856 rebase-interactive: append_todo_help() changes
14:  3591e06b7d ! 14:  268998924b rebase-interactive: rewrite edit_todo_list() to handle the initial edit
    @@ -24,21 +24,21 @@
     +	const char *todo_file = rebase_path_todo();
     +	struct todo_list todo_list = TODO_LIST_INIT,
     +		new_todo = TODO_LIST_INIT;
    ++	int res = 0;
     +
     +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
     +		return error_errno(_("could not read '%s'."), todo_file);
     +
     +	strbuf_stripspace(&todo_list.buf, 1);
    -+	if (!edit_todo_list(the_repository, &todo_list,
    -+			    &new_todo, NULL, NULL, flags) &&
    -+	    todo_list_write_to_file(the_repository, &new_todo, todo_file, NULL, NULL,
    -+				    -1, flags & ~(TODO_LIST_SHORTEN_IDS)) < 0)
    -+		return error_errno(_("could not write '%s'"), todo_file);
    ++	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
    ++	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
    ++					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
    ++		res = error_errno(_("could not write '%s'"), todo_file);
     +
     +	todo_list_release(&todo_list);
     +	todo_list_release(&new_todo);
     +
    -+	return 0;
    ++	return res;
     +}
     +
      static int get_revision_ranges(const char *upstream, const char *onto,
    @@ -79,40 +79,39 @@
     -				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP)) {
     -		todo_list_release(&todo_list);
     -		return -1;
    +-	}
     +	unsigned initial = shortrevisions && shortonto;
    -+
    -+	if (initial) {
    -+		todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
    -+					-1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);
    -+
    -+		if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
    -+			return error(_("could not copy '%s' to '%s'."), todo_file,
    -+				     rebase_path_todo_backup());
    -+	} else {
    -+		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
    -+		todo_list_write_to_file(r, todo_list, todo_file, NULL, NULL, -1,
    -+					flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);
    - 	}
      
     -	strbuf_reset(&todo_list.buf);
     -	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
     -		todo_list_release(&todo_list);
     -		return -1;
     -	}
    -+	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
    -+		return -2;
    ++	if (!initial)
    ++		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
      
     -	if (!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list))
     -		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
     -					      flags & ~(TODO_LIST_SHORTEN_IDS));
    -+	strbuf_stripspace(&new_todo->buf, 1);
    -+	if (initial && new_todo->buf.len == 0)
    -+		return -3;
    ++	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
    ++				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
    ++		return error_errno(_("could not write '%s'"), todo_file);
      
     -	todo_list_release(&todo_list);
     -	return res;
    ++	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
    ++		return error(_("could not copy '%s' to '%s'."), todo_file,
    ++			     rebase_path_todo_backup());
    ++
    ++	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
    ++		return -2;
    ++
    ++	strbuf_stripspace(&new_todo->buf, 1);
    ++	if (initial && new_todo->buf.len == 0)
    ++		return -3;
    ++
     +	if (!initial)
    -+		todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
    ++		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
     +
     +	return 0;
      }
15:  0b29fca27f = 15:  6f1274a33c sequencer: use edit_todo_list() in complete_action()
16:  5ab34416af <  -:  ---------- rebase--interactive: move transform_todo_file() to rebase--interactive.c
 -:  ---------- > 16:  f57a7405d0 rebase--interactive: move several functions to rebase--interactive.c
-- 
2.20.1

