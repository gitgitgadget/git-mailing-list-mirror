Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D6C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20136109F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344264AbhIHNmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhIHNmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:42:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3C2C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:41:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1665722wmb.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ibBQ+7uaw6ueHo7XYx4nlC0yYyK8Q0lpvoaB4wSy1eI=;
        b=NxqrTWr+xepyGAXp+y//wA39T57491/FG0bCPUndFk/eTavVxv7luF0VKRlzx5Cr3j
         fCNdbhxFOySRtqnHIMVDSnMY+Fowo9TfWzFQ+zLdVf2WvXpZQ3EvC4Nnxp/dErKxIr7D
         T3NXwOoX1xNei7RHKpWbnCXKJ99IUEB9TwtIooGRrES78Mv5sd5MYYzji/pmYUp4+vu8
         sAJJzCVnOQi4PlEurr8sGlueo8nKW6kceTvauFWFe94eysr+sZSXDc/emSkA3pfaN/sP
         c/++gPlY+31p9L/x9G9hR+wSmlMSHz3aLx+tYqdXGaLyiYEr/FvINQs+1NqZIsuOnrUj
         0JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ibBQ+7uaw6ueHo7XYx4nlC0yYyK8Q0lpvoaB4wSy1eI=;
        b=Be/LpyLL8+OU/JwhAzM5oG7dJLl38FBBIxwtqTns/itctiMIgNv0QqFdL21h9rDRRo
         PXOIYP0qTGOp6Ruau0lQbdvEi1ERUbXyV9VggLQyPapeOKVuq20G9vrjU5l92sF+E0A0
         /IpftjQH5s07/SZeA1yn4FLpD116lMgfeXLSnCQutlS2XoFR6SM9Soi1uGCS97erTGPG
         tB69c9XdJh9KCbdL9wTM0ZluUN7wtuC/IWebU+hMPwcEky++C9s22xsWNk3AifVf+5pV
         SGj9S0BfNDrPrtofkEYYn84+N3gQsSaUB1ZCKLyAZVTEzBX0oY25er3V2haLzoKAoV6H
         w+bQ==
X-Gm-Message-State: AOAM533ZkQDm3LtuX+uLXXxgUjhKsOCQurcGtpGPVf707WSPFROCkS0I
        YfYaj6yPtZh6b4Vdy4TVrbyEvll/xnA=
X-Google-Smtp-Source: ABdhPJyabq6h1xtuEJOoR3WU3amjIk1HkHCAHaGYWw3FVP1CQ2rhPW5EBsUc9r5LkapbxIWCBLd3+g==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr3742118wme.91.1631108475021;
        Wed, 08 Sep 2021 06:41:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm2228150wrb.11.2021.09.08.06.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:41:14 -0700 (PDT)
Message-Id: <3b17a4e3d3fa620638299294a56adb9237fd5c56.1631108472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 13:41:09 +0000
Subject: [PATCH 2/5] rebase: fix todo-list rereading
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

54fd3243da ("rebase -i: reread the todo list if `exec` touched it",
2017-04-26) sought to reread the todo list after running an exec
command only if it had been changed. To accomplish this it checks the
stat data of the todo list after running an exec command to see if it
has changed. Unfortunately there are two problems, firstly the
implementation is buggy we actually reread the list after each exec
which is quadratic in the number of commit lookups and secondly the
design is predicated on using nanosecond time stamps which are not the
default.

The implementation bug stems from the fact that we write a new todo
list to disk before running each command but do not update the stat
data to reflect this[1].

The design problem is that it is possible for the user to edit the
todo list without changing its size or inode which means we have to
rely on the mtime to tell us if it has changed. Unfortunately unless
git is built with USE_NSEC it is possible for the original and edited
list to share the same mtime.

Ideally "git rebase --edit-todo" would set a flag that we would then
check in sequencer.c. Unfortunately this is approach will not work as
there are scripts in the wild that write to the todo list directly
without running "git rebase --edit-todo". Instead of relying on stat
data this patch simply reads the possibly edited todo list and
compares it to the original with memcmp(). This is much faster than
reparsing the todo list each time. This patch reduces the time to run

   git rebase -r -xtrue v2.32.0~100 v2.32.0

which runs 419 exec commands by 6.6%. For comparison fixing the
implementation bug in stat based approach reduces the time by a
further 1.4% and is indistinguishable from never rereading the todo
list.

[1] https://lore.kernel.org/git/20191125131833.GD23183@szeder.dev/

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 19 ++++++++-----------
 sequencer.h |  1 -
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a248c886c27..d51440ddcd9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2671,7 +2671,6 @@ static int read_populate_todo(struct repository *r,
 			      struct todo_list *todo_list,
 			      struct replay_opts *opts)
 {
-	struct stat st;
 	const char *todo_file = get_todo_path(opts);
 	int res;
 
@@ -2679,11 +2678,6 @@ static int read_populate_todo(struct repository *r,
 	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
 		return -1;
 
-	res = stat(todo_file, &st);
-	if (res)
-		return error(_("could not stat '%s'"), todo_file);
-	fill_stat_data(&todo_list->stat, &st);
-
 	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
@@ -4258,12 +4252,14 @@ static int reread_todo_if_changed(struct repository *r,
 				  struct todo_list *todo_list,
 				  struct replay_opts *opts)
 {
-	struct stat st;
+	int offset;
+	struct strbuf buf = STRBUF_INIT;
 
-	if (stat(get_todo_path(opts), &st)) {
-		return error_errno(_("could not stat '%s'"),
-				   get_todo_path(opts));
-	} else if (match_stat_data(&todo_list->stat, &st)) {
+	if (strbuf_read_file_or_whine(&buf, get_todo_path(opts)) < 0)
+		return -1;
+	offset = get_item_line_offset(todo_list, todo_list->current + 1);
+	if (buf.len != todo_list->buf.len - offset ||
+	    memcmp(buf.buf, todo_list->buf.buf + offset, buf.len)) {
 		/* Reread the todo file if it has changed. */
 		todo_list_release(todo_list);
 		if (read_populate_todo(r, todo_list, opts))
@@ -4271,6 +4267,7 @@ static int reread_todo_if_changed(struct repository *r,
 		/* `current` will be incremented on return */
 		todo_list->current = -1;
 	}
+	strbuf_release(&buf);
 
 	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index d57d8ea23d7..cdeb0c6be47 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -116,7 +116,6 @@ struct todo_list {
 	struct todo_item *items;
 	int nr, alloc, current;
 	int done_nr, total_nr;
-	struct stat_data stat;
 };
 
 #define TODO_LIST_INIT { STRBUF_INIT }
-- 
gitgitgadget

