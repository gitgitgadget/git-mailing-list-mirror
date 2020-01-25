Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDE2C2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 17:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933EC20716
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 17:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCqUzNVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAYR5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 12:57:30 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40144 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAYR5a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 12:57:30 -0500
Received: by mail-wr1-f44.google.com with SMTP id c14so5900730wrn.7
        for <git@vger.kernel.org>; Sat, 25 Jan 2020 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0y3StVA6LM1UA5o04Bv+iNlVg7yg+GhUk6F0GQAMoXU=;
        b=pCqUzNVDGgtg1jwWupXtLi1Es+yf+T6KMcy70Idp6NRdwldex5SsYwjXMOEP3v2eXa
         fpurn97f/ssNrNHxZHa58pzZcD0rHNOHZ2gq2A9jRTy7UgJnzzX9+pXhStD6FHbRVR5d
         86KrZyzZiQ7F0aMFEwXbbJI49uOpuGAv0SUALbnIMbrZgR2XWXIhtw37tK7Wfw9U2RDV
         rCfgBOomcsGdSt080k1YkoD9trHi09rshZoFwTNjGsKAZYWJ7GND1mVasxej80c9tP71
         2AUKSjPtej1j0Dm9SB0c3QhyQpsp9CJre1FQIcImVRElrBmrxzEABxnBC3OHB9TwnQyA
         Zskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0y3StVA6LM1UA5o04Bv+iNlVg7yg+GhUk6F0GQAMoXU=;
        b=IM+Tu7GvRZs/ukjyWZe7x2WAcj2zmZYrMLTwKcvvmrUR1XYukz7zDULDYxrtvih6ur
         bc2yg5pGj4rtEGkKE4Nfyu4prGdXNipEQVuiiLeUWnOBGgTTFCnrpBe5AngNHtg79E0k
         IFmDFNTKEoaaR5CnT+zcyLzrDyavPHu3WoNtnYHGMcOa8MOhKriC0hqqDK4l4T3+YyWl
         9sLg/2lVhh5b3jTRw2ALPFUUP6rnQGmaNshRIUWYscMzWg7S3eax1aQOvVW1Zy97iXWc
         srLY95Cmgtx6N+w2iUjc9H1XAjFd66tMXwExnNPfz5YYuauGETBCJsQ2ANl+12V+OFJU
         hQsQ==
X-Gm-Message-State: APjAAAXouNO4Mrmzn6cEZ0eqcSPbIPBHLAjPxw7EMVuJlcrHn3008h8V
        EpdtJ08FiRibZWMfjlDIeD8bwbcG
X-Google-Smtp-Source: APXvYqwVWPrDEoqFvqcSvZWT/cSgwZ+CVXzlQ/UlBaRWUWnW99Vgbq8OPAkNwlViyBU9IzWf4vloPA==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr11980195wrp.292.1579975047424;
        Sat, 25 Jan 2020 09:57:27 -0800 (PST)
Received: from localhost.localdomain (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.googlemail.com with ESMTPSA id h2sm13940107wrt.45.2020.01.25.09.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2020 09:57:26 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 0/2] rebase -i: extend rebase.missingCommitsCheck
Date:   Sat, 25 Jan 2020 18:54:34 +0100
Message-Id: <20200125175436.29786-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111173917.15690-1-alban.gruin@gmail.com>
References: <20200111173917.15690-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prevent mistakes when editing a branch, rebase features a knob,
rebase.missingCommitsCheck, to warn the user if a commit was dropped.
Unfortunately, this check is only effective for the initial edit, which
means that if you edit the todo list at a later point of the rebase and
drop a commit, no warnings or errors would be issued.

This adds the ability to check if commits were dropped when editing the
todo list with `--edit-todo', and when resuming a rebase.

The first patch moves moves check_todo_list_from_file() and
`edit_todo_list_advice' from sequencer.c to rebase-interactive.c so the
latter can be used by edit_todo_list() and todo_list_check().  The
second patch adds the check to `--edit-todo' and `--continue' and tests.

This is based on 393adf7a6f ("sequencer: directly call pick_commits()
from complete_action()", 2019-11-24).

The tip of this series is tagged as "edit-todo-drop-v5" at
https://github.com/agrn/git.

Changes since v4:

 - Added a test to check that no errors are raised when editing the todo
   list after pausing the rebase; it was provided by Phillip Wood.

 - Fixed the issue pointed out by this test by creating a backup of the
   todo list even if the edited list is incorrect.  This step was moved
   before the user edits the list, so the backup can be created with
   copy_file() instead of todo_list_write_to_file().

 - In edit_todo_list(), `incorrect' is set to 0 by default.  This only
   concerns the initial edit case; instead of opening and parsing the
   backup, we use directly `old_todo' as a reference.

 - Don't check if the "dropped" file flag exists at the initial edit.

Alban Gruin (2):
  sequencer: move check_todo_list_from_file() to rebase-interactive.c
  rebase-interactive: warn if commit is dropped with `rebase
    --edit-todo'

 rebase-interactive.c          |  90 ++++++++++++++++++++++---
 rebase-interactive.h          |   5 ++
 sequencer.c                   |  51 ++++----------
 sequencer.h                   |   2 +-
 t/t3404-rebase-interactive.sh | 121 ++++++++++++++++++++++++++++++++++
 5 files changed, 219 insertions(+), 50 deletions(-)

Range-diff against v4:
1:  996045a300 = 1:  996045a300 sequencer: move check_todo_list_from_file() to rebase-interactive.c
2:  11b0e1e78c ! 2:  6dbaa8cbe6 rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
    @@ Commit message
         `edit_todo_list_advice' is removed from sequencer.c as it is no longer
         used there.
     
    -    This changes when a backup of the todo list is made.  Until now, it
    -    was saved only once, before the initial edit.  Now, it is also made if
    -    after the user edited the list, if it has no errors or if no commits
    -    were dropped and `rebase.missingCommitsCheck' is set.  Thus, the
    +    This changes when a backup of the todo list is made.  Until now, it was
    +    saved only once, before the initial edit.  Now, it is also made if the
    +    original todo list has no errors or no dropped commits.  Thus, the
         backup should be error-free.  Without this, sequencer_continue()
         (`rebase --continue') could only compare the current todo list against
         the original, unedited list.  Before this change, this file was only
    @@ Commit message
         no errors were found at the last edition, so any missing commits here
         have already been picked.
     
    -    Four tests are added to t3404.  The tests for
    +    Five tests are added to t3404.  The tests for
         `rebase.missingCommitsCheck = warn' and `rebase.missingCommitsCheck =
         error' have a similar structure.  First, we start a rebase with an
         incorrect command on the first line.  Then, we edit the todo list,
    @@ Commit message
         has been dropped.  Then, the actual rebase takes place.  In the third
         test, it is also checked that `--continue' will refuse to resume the
         rebase if commits were dropped.  The fourth test checks that no errors
    -    are raised when resuming a rebase after resolving a conflict.
    +    are raised when resuming a rebase after resolving a conflict, the fifth
    +    checks that no errors are raised when editing the todo list after
    +    pausing the rebase.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
         I don't think the way I create `expect.3' files in "rebase --edit-todo
    @@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list
     +	const char *todo_file = rebase_path_todo(),
     +		*todo_backup = rebase_path_todo_backup();
      	unsigned initial = shortrevisions && shortonto;
    -+	int incorrect = 1;
    ++	int incorrect = 0;
      
      	/* If the user is editing the todo list, we first try to parse
      	 * it.  If there is an error, we do not return, because the user
      	 * might want to fix it in the first place. */
      	if (!initial)
     -		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
    -+		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
    -+
    -+	incorrect |= file_exists(rebase_path_dropped());
    ++		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list) |
    ++			file_exists(rebase_path_dropped());
      
      	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
      				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
    @@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list
     -	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
     -		return error(_("could not copy '%s' to '%s'."), todo_file,
     -			     rebase_path_todo_backup());
    -+	if (initial && copy_file(todo_backup, todo_file, 0666))
    -+		return error(_("could not copy '%s' to '%s'."), todo_file, todo_backup);
    ++	if (initial || !incorrect) {
    ++		if (!initial)
    ++			unlink(todo_backup);
    ++
    ++		if (copy_file(todo_backup, todo_file, 0666))
    ++		    return error(_("could not copy '%s' to '%s'."), todo_file, todo_backup);
    ++	}
      
      	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
      		return -2;
    @@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list
     +	} else if (todo_list_check(todo_list, new_todo)) {
     +		write_file(rebase_path_dropped(), "");
     +		return -4;
    -+	} else {
    -+		todo_list_write_to_file(r, todo_list, todo_backup, shortrevisions, shortonto,
    -+					-1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);
     +	}
      
      	return 0;
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.mi
     +	git add file1 &&
     +	git rebase --continue
     +'
    ++
    ++test_expect_success 'rebase.missingCommitsCheck = error when editing for a second time' '
    ++	test_config rebase.missingCommitsCheck error &&
    ++	(
    ++		set_fake_editor &&
    ++		FAKE_LINES="1 break 2 3" git rebase -i A D &&
    ++		cp .git/rebase-merge/git-rebase-todo todo &&
    ++		test_must_fail env FAKE_LINES=2 git rebase --edit-todo &&
    ++		GIT_SEQUENCE_EDITOR="cp todo" git rebase --edit-todo &&
    ++		git rebase --continue
    ++	)
    ++'
     +
      test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and exec' '
      	rebase_setup_and_clean abbrevcmd &&
-- 
2.24.1

