Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238011F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfGQOmF (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:42:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52268 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfGQOmE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:42:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so22436778wms.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ziQkMtRJNKMT2OPbJgfukivTaU1CF27jG7EemtvEwis=;
        b=Z7G5GnhCFcBW2ZRYkGA5pHwjy3RffLGk5Mkx+MLMT3wU0fCEhBOijAnUHkobEzM8JP
         XRuq4Leu/LHYkadLOr30NjIBFbP9rXrurKllWQCGjNLnAJtFxEJl+Vtx8CuvYLnNWPAi
         gN6Ybc9GQoy1lGPUUXz/p9GDRSrhLBuDo+9WDguLeuUA1VxSq+UmZpU5YwRLeTREnHAh
         q6c0My4qFVgm2vIrl+6QHgJzFNpQU8dZdxyMprsBw12p1zT16hmo+Cxuahi7ge8ITIrD
         z+mRXreRXEXR8eXxGUcXdjIx4t1kb98p/750j2bYsxZbUqB9tRJ4PAJrNjvMrzt0i2S0
         dXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziQkMtRJNKMT2OPbJgfukivTaU1CF27jG7EemtvEwis=;
        b=bZ+zWEU8iQvj/kapy9x7H1iOB7TkqjNaK7jyDFs0TMUhd6zmknJ+Ps04doMqV980qq
         4CCtce+QaIwJVCk3hC5aSvUZAIFG4ztMy4kPHStS2IKWIvADqTlNd/jSDKV+l40uVY1F
         ygDaKuwatcs6zogryEBfWPpnmV0/Q3CNYrmAkqhbZQXdsjcQCVOKBtYhi7OFkZox3H6W
         ND3CQZ6EZUCWVJSfbXUGYHM6419N0FYIGp+tg/4tA/rd6igyd+3MNyFkjcoNc3cDMO/f
         49iW8n6/OrgZhL3F57lsJFWPSuNbWrsIfO4xR/zpFHspGYmVMfoZ5G3u6N9G3/i3tQiT
         iD1Q==
X-Gm-Message-State: APjAAAU4y58Z81iTnIQJQ02AW98rKLBDC66MCbMKiaHAHXurERbycod4
        JvgbkeybwRs2zmLYPFJWkoR0F1qa
X-Google-Smtp-Source: APXvYqy+P1wkcc/KvCjaR7WS8N6uUoaNNtygRebRoTxdkj0sQ09qyBZOlo4fMf11PkEiomD0vhsQcg==
X-Received: by 2002:a05:600c:214c:: with SMTP id v12mr37061080wml.28.1563374522332;
        Wed, 17 Jul 2019 07:42:02 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:42:01 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 6/9] sequencer: add a parameter to sequencer_continue() to accept a todo list
Date:   Wed, 17 Jul 2019 16:39:15 +0200
Message-Id: <20190717143918.7406-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As it is called by sequencer_continue() or after an exec command,
read_populate_todo() is a great place to check for dropped commits in
the todo list, but complete_action() (a caller of sequencer_continue())
already does.  Double-checking would show the message twice.

This adds a parameter to sequencer_continue() to accept a todo list.  If
a valid list is provided, read_populate_todo() won't be called.
complete_action() is modified to pass its todo list to
sequencer_continue().

This also avoids reloading the todo list from the disk just after
releasing it.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase.c |  2 +-
 builtin/revert.c |  2 +-
 sequencer.c      | 26 +++++++++++++++-----------
 sequencer.h      |  3 ++-
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 89fc4b8153..205916ca11 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -393,7 +393,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
 	case ACTION_CONTINUE: {
 		struct replay_opts replay_opts = get_replay_opts(opts);
 
-		ret = sequencer_continue(the_repository, &replay_opts);
+		ret = sequencer_continue(the_repository, &replay_opts, NULL);
 		break;
 	}
 	case ACTION_EDIT_TODO:
diff --git a/builtin/revert.c b/builtin/revert.c
index 4e71b2f2aa..45a5c6217d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -207,7 +207,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		return ret;
 	}
 	if (cmd == 'c')
-		return sequencer_continue(the_repository, opts);
+		return sequencer_continue(the_repository, opts, NULL);
 	if (cmd == 'a')
 		return sequencer_rollback(the_repository, opts);
 	return sequencer_pick_revisions(the_repository, opts);
diff --git a/sequencer.c b/sequencer.c
index d66b80d49f..3fb15ff8d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4147,9 +4147,11 @@ static int commit_staged_changes(struct repository *r,
 	return 0;
 }
 
-int sequencer_continue(struct repository *r, struct replay_opts *opts)
+int sequencer_continue(struct repository *r, struct replay_opts *opts,
+		       struct todo_list *p_todo_list)
 {
-	struct todo_list todo_list = TODO_LIST_INIT;
+	struct todo_list todo_list = TODO_LIST_INIT,
+		*ptr_todo = (p_todo_list) ? p_todo_list : &todo_list;
 	int res;
 
 	if (read_and_refresh_cache(r, opts))
@@ -4158,13 +4160,13 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
-		if ((res = read_populate_todo(r, &todo_list, opts)))
+		if (!p_todo_list && (res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
-		if (commit_staged_changes(r, opts, &todo_list))
+		if (commit_staged_changes(r, opts, ptr_todo))
 			return -1;
 	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick(r);
-	else if ((res = read_populate_todo(r, &todo_list, opts)))
+	else if (!p_todo_list && (res = read_populate_todo(r, &todo_list, opts)))
 		goto release_todo_list;
 
 	if (!is_rebase_i(opts)) {
@@ -4179,18 +4181,18 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			res = error_dirty_index(r, opts);
 			goto release_todo_list;
 		}
-		todo_list.current++;
+		ptr_todo->current++;
 	} else if (file_exists(rebase_path_stopped_sha())) {
 		struct strbuf buf = STRBUF_INIT;
 		struct object_id oid;
 
 		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
 		    !get_oid_committish(buf.buf, &oid))
-			record_in_rewritten(&oid, peek_command(&todo_list, 0));
+			record_in_rewritten(&oid, peek_command(ptr_todo, 0));
 		strbuf_release(&buf);
 	}
 
-	res = pick_commits(r, &todo_list, opts);
+	res = pick_commits(r, ptr_todo, opts);
 release_todo_list:
 	todo_list_release(&todo_list);
 	return res;
@@ -5025,15 +5027,17 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error_errno(_("could not write '%s'"), todo_file);
 	}
 
-	todo_list_release(&new_todo);
-
 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
 		return -1;
 
 	if (require_clean_work_tree(r, "rebase", "", 1, 1))
 		return -1;
 
-	return sequencer_continue(r, opts);
+	todo_list_write_total_nr(&new_todo);
+	res = sequencer_continue(r, opts, &new_todo);
+	todo_list_release(&new_todo);
+
+	return res;
 }
 
 struct subject2item_entry {
diff --git a/sequencer.h b/sequencer.h
index 3d0b68c34c..858816f94a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -127,7 +127,8 @@ const char *todo_item_get_arg(struct todo_list *todo_list,
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct repository *repo,
 			     struct replay_opts *opts);
-int sequencer_continue(struct repository *repo, struct replay_opts *opts);
+int sequencer_continue(struct repository *repo, struct replay_opts *opts,
+		       struct todo_list *p_todo_list);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
-- 
2.22.0

