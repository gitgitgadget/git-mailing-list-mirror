Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C82C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B84760EE5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbhIWP2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbhIWP16 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 11:27:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE1C061760
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:26:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d6so18187590wrc.11
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ibBQ+7uaw6ueHo7XYx4nlC0yYyK8Q0lpvoaB4wSy1eI=;
        b=mG9zcACYd4I4kc07D1GXKpXVgHYEMTLU2382LUjCR4jRnCEOdC4b1EcFkMTFM72qaD
         lwHh7tnpH8HcahdANIIU0OV5627cCiS9BzntcUmfqJG0v93cmYh2a4tTZ3++2I51GpAD
         AGmJ86YNqWsqoyyGy1Mlk0kFvrI+LoAuMn4TBcwKSMsfW5PLSODhR3BsKQH1tDwcTR4t
         6dRVUgUW2za4TENxH4Yh/5wCIv0IrHSYdh9rTzpEVH7Buex86e3/h3u+jUWbzgTqCmcJ
         vxtDe77+KUtJZfOmm9mLEiHMdytIdhx0jtOMVivBSw1yTAECSb9qKj1kEDA3jAxx+ST3
         VkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ibBQ+7uaw6ueHo7XYx4nlC0yYyK8Q0lpvoaB4wSy1eI=;
        b=LUpYyFFslj5g54X88A9/+UcGyV1+3HpJihGtN7IarruDMVW9Ydq3j3iN5ouYhhKQtI
         hnxHp1fKBvEpulzxgpXtRSbtbFZrAT7ONelA6TGyKJxqL66Rjle8VtQ5/x28IywspFKn
         vSxdkbTdn0t/x/k1oXRJXQGnYKARVlqaEJhZhPoL+cjq3j8YpRVimdUBJMA1UJl3FYjS
         jxkvg0DMU29V/uxgKggY5H0JAfG2D9YkXIOXcM+Ysn8+4qaoiYjLXZXC6jYKPDG2ve5V
         yevOWTH43ntQpxClxO8mL2NWJzFGstS7IVAuTTts9Ew7GQqZsz10uHlyEc+iV0O1Mh4q
         yLmQ==
X-Gm-Message-State: AOAM530lFHU6Yn/BOmVpXzFWxcFu5B50bv50fV5AT3lUE5vE42fve41P
        HBAp5H3wyGxFfITml0Jh9nk1FwP+ua0=
X-Google-Smtp-Source: ABdhPJzWT2SfhDxnmArCqsRiRm26qdiw3uNOWyqhpgg8BtYHapUUYKmOqTCVzmAbCxxEqH/WYp6MCg==
X-Received: by 2002:a1c:9d4e:: with SMTP id g75mr16958997wme.20.1632410784699;
        Thu, 23 Sep 2021 08:26:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a72sm9852276wme.5.2021.09.23.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:26:24 -0700 (PDT)
Message-Id: <0d89c506192a84822a3fbd6c76befac187129ad4.1632410782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1034.v2.git.1632410782.gitgitgadget@gmail.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
        <pull.1034.v2.git.1632410782.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Sep 2021 15:26:21 +0000
Subject: [PATCH v2 2/2] rebase: fix todo-list rereading
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
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
