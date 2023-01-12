Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F007C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 10:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjALKnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjALKmc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 05:42:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01658337
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:36:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so16237313wms.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jEmVfAKOrxJI+FCagkRGmAanGepQQkKTfB7KhYTPLTI=;
        b=MGetepSSepw32nalH7S0/pDvPBaLv8UpUU7/KjxGNS0fHuUhcWjBC3SF3SVZ35xps1
         FwuVh3gw9XFx9ESs4QPFpqeLqrlEwlEH7pUzd2gkBKWcXSpZX4ib8RfAsUWOsrmyNVy/
         y+9FrRYh+XMztr9b8UwzAL/0owEFIRrZlMgGHjQSkqddONn1/ENCrQLVbLW+YAQgj8qo
         RkuxKBTMsPaTi0Ro3uqQwOZYxPiFQM9XfmKkLIPsLbKBQz0QPk1G4qesI2Y/A2LeU4qD
         H4QJKWGy4GPGV2WqfNy/uiDuXoNr/G7XPumQHOMGqXPihbTX1nl+Dmz2SW2y7hWMxTRD
         auhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEmVfAKOrxJI+FCagkRGmAanGepQQkKTfB7KhYTPLTI=;
        b=jEQHCgljjRfs/FbXAdAv2uXXCvqASyRyw+5LRlv1nJ0JnkTftItzg4N4V2ei7bJFsI
         g/X5X6J4QbqIHOWskPFmrWg12dsfO7eGspq8akryY8rQWUJ5m+dqnowHe1MttXkDGVmL
         /jxWUJPwbmoI8uqBEM3vgoVr78RzloBJUhp511o2B3XWW37O01ujBmBpr+w6Z2jZ3qK5
         L4eoKhYbT2DcOMyteL9wJq4ViXkRyCWEbXhyPEN4Xqdc10kl7KSixiKSiaugZvEx7bQQ
         vBEAqDcx6E+Lx7XbcWXpdp2LemMS4B9aMVQ9h6SF8DHYT3cO8gvlqWj92zR6zaM3ZySP
         t7LA==
X-Gm-Message-State: AFqh2kqyTiMjZIFBIbC9mL16Jq6Qvrk3sIY9MEZieQSXFTASq0nO6WgE
        cnLX315BWeqE/PAUcswztOd+meQR/qk=
X-Google-Smtp-Source: AMrXdXu5YwvvhQiqfiLBDkAFXhToT+7F+XsbLZzuuQ6MKz9UOprXHxhOXo2vB6c9soFtv3tty4HGcA==
X-Received: by 2002:a05:600c:4da0:b0:3d2:3a53:2cd6 with SMTP id v32-20020a05600c4da000b003d23a532cd6mr55532114wmp.9.1673519810669;
        Thu, 12 Jan 2023 02:36:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b002bbed1388a5sm10763101wrp.15.2023.01.12.02.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 02:36:50 -0800 (PST)
Message-Id: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Jan 2023 10:36:49 +0000
Subject: [PATCH] rebase -i: allow a comment after a "break" command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When adding a "break" command to a rebase todo list it can be helpful to
add a comment as a reminder as to what the user was planning to do when
the rebase stopped. Anything following the command is interpreted as an
argument to the command and results in an error. Change this so that a
"break command may be followed by "# <comment>" in the same way as
a "merge" command. Requiring the comment to begin with "# " allows the
break command to start taking an argument in the future if that turns
out to be useful.

Reported-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: allow a comment after a "break" command
    
    I'm open to suggestions for other ways to handle comments but copying
    what we do to separate merge parents from the merge commit subject
    seemed simplest.
    
    Should this print the comment when stopping for a break command?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1460%2Fphillipwood%2Fsequencer-allow-comment-after-break-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1460/phillipwood/sequencer-allow-comment-after-break-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1460

 Documentation/git-rebase.txt |  4 +++-
 sequencer.c                  |  7 +++++--
 t/lib-rebase.sh              |  2 +-
 t/t3418-rebase-continue.sh   | 16 ++++++++++++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f9675bd24e6..511ace43db0 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -869,7 +869,9 @@ the files and/or the commit message, amend the commit, and continue
 rebasing.
 
 To interrupt the rebase (just like an "edit" command would do, but without
-cherry-picking any commit first), use the "break" command.
+cherry-picking any commit first), use the "break" command. A "break"
+command may be followed by a comment beginning with `#` followed by a
+space.
 
 If you just want to edit the commit message for a commit, replace the
 command "pick" with the command "reword".
diff --git a/sequencer.c b/sequencer.c
index bcb662e23be..c66f382dfbc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2509,7 +2509,9 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	padding = strspn(bol, " \t");
 	bol += padding;
 
-	if (item->command == TODO_NOOP || item->command == TODO_BREAK) {
+	if (item->command == TODO_NOOP ||
+	    (item->command == TODO_BREAK &&
+	     (bol[0] != '#' || (bol[1] && !isspace (bol[1]))))) {
 		if (bol != eol)
 			return error(_("%s does not accept arguments: '%s'"),
 				     command_to_string(item->command), bol);
@@ -2524,7 +2526,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 			     command_to_string(item->command));
 
 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
-	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
+	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF ||
+	    item->command == TODO_BREAK) {
 		item->commit = NULL;
 		item->arg_offset = bol - buf;
 		item->arg_len = (int)(eol - bol);
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index b57541356bd..a648013f299 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -51,7 +51,7 @@ set_fake_editor () {
 		case $line in
 		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
 			action="$line";;
-		exec_*|x_*|break|b)
+		exec_*|x_*|break_*|b_*|break|b)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
 		merge_*|fixup_*)
 			action=$(echo "$line" | sed 's/_/ /g');;
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 130e2f9b553..18d82869b38 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -266,6 +266,22 @@ test_expect_success 'the todo command "break" works' '
 	test_path_is_file execed
 '
 
+test_expect_success 'the todo command "break" accepts a comment' '
+	rm -f execed &&
+	test_write_lines "break # comment" "break #" "exec >execed" >expect &&
+	write_script cat-todo.sh <<-\EOS &&
+	GIT_SEQUENCE_EDITOR="grep ^\[^#\]" git rebase --edit-todo >actual
+	EOS
+	FAKE_LINES="exec_./cat-todo.sh break_#_comment b_# exec_>execed" \
+		git rebase -i HEAD &&
+	test_cmp expect actual &&
+	test_path_is_missing execed &&
+	git rebase --continue &&
+	test_path_is_missing execed &&
+	git rebase --continue &&
+	test_path_is_file execed
+'
+
 test_expect_success '--reschedule-failed-exec' '
 	test_when_finished "git rebase --abort" &&
 	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&

base-commit: 8a4e8f6a67e7fc97048d4666eec38399b88e0e3b
-- 
gitgitgadget
