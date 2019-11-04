Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1AB1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKDJzp (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 04:55:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40575 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDJzo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 04:55:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id o28so16228795wro.7
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 01:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dqtQwKMpXi112y3c3omdlozpf7XYHaHLc47a2yF/ew=;
        b=pCEjT3WsM0ZR9cK+R4ZfXhq+ubL8xdGXF1fMPwPZKmVgWxw1YXyFD0UqBj5M7sUNHl
         IF4Zu5/yjE6bhMDC9+tKOAeQJ4mVPrLAOH8Mt65HLb8jI75kNFIsjbGicGBNXKmRQEHz
         7XPS2k/or6AcLcdAmybOeAVTnW/tSAYh6QJa1/ijpOhs3+CncHW5Le0YukF/TvnHo128
         mhq8oZFhLhKqgo0Tgu7sYMg+EWIWei5Rn6PJwNQNCuKh5ypbc0eSXfGks1NdyF9joIiu
         g7mAB0ZLD8hHZDQowYQM+tR1/JHzTacSMU39XW1ejssqATvrZNgdLC8uZVm+Wcns8hel
         eAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dqtQwKMpXi112y3c3omdlozpf7XYHaHLc47a2yF/ew=;
        b=nL4dsv0ZBF5FBsdZuILkOgocGsTvLBlYb3RmfdmJ9lMci9BHBv0+0axoOOH3/o3JZ6
         J33v8AdJ0zxwkaMIGhVCSlp2t0WmyIhm3v5yV7lUU9EQo4p1N5nyUKceEb8/W2vKTOlh
         +zTCNWrm9xOvsHVRZVsGReF6Df6FwO5vvvsvMsFOAxRHsLtN6p5tsFJ9wWO+whSHhsUO
         ZHUnR4wy01IN/F0iOUHMdErcrAcKexgW/ISEC9QnmR3ju9juQX+E88D0XgmImVglUwnB
         yeMcao8dvbKgIrmTQ58Qssl+/Sx3SuU9ZPddnUVFkCyoqlpO8yMuXcHRb0YPbjQv7xKC
         JrnQ==
X-Gm-Message-State: APjAAAXu1kyjEurCOLdCq5pK3fKqvAVSM9IJFa0Zizjwu4Acc+ym6+JD
        yu+Bfht5BQTiv73KVFL+kAhuD+pd
X-Google-Smtp-Source: APXvYqxzZ4c+uQSUc8IsDpgkmE/QbQaWfqc3rIPZJPW7BRBN41YqiBrJAdP2Vo/l7kAUdXMfH0E0hg==
X-Received: by 2002:a5d:4986:: with SMTP id r6mr13041792wrq.307.1572861341931;
        Mon, 04 Nov 2019 01:55:41 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-9-104.w86-222.abo.wanadoo.fr. [86.222.152.104])
        by smtp.googlemail.com with ESMTPSA id d16sm19263539wmb.27.2019.11.04.01.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 01:55:41 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v2 2/2] rebase-interactive: warn if commit is dropped with --edit-todo
Date:   Mon,  4 Nov 2019 10:54:49 +0100
Message-Id: <20191104095449.9964-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104095449.9964-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
 <20191104095449.9964-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the ability for --edit-todo to check if commits were dropped
by the user.  As both edit_todo_list() and complete_action() parse the
todo list and check for dropped commits, the code doing so in the latter
is removed to reduce duplication.

Tests added previously should work now.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 rebase-interactive.c          | 7 +++----
 sequencer.c                   | 5 +----
 t/t3404-rebase-interactive.sh | 4 ++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index aa18ae82b7..1b8d7f25bf 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -115,10 +115,9 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	if (initial && new_todo->buf.len == 0)
 		return -3;
 
-	/* For the initial edit, the todo list gets parsed in
-	 * complete_action(). */
-	if (!initial)
-		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
+	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo) ||
+	    todo_list_check(todo_list, new_todo))
+		return -4;
 
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 9d5964fd81..92f2e6f6a0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5062,10 +5062,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		todo_list_release(&new_todo);
 
 		return error(_("nothing to do"));
-	}
-
-	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
-	    todo_list_check(todo_list, &new_todo)) {
+	} else if (res == -4) {
 		fprintf(stderr, _(edit_todo_list_advice));
 		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
 		todo_list_release(&new_todo);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index be8badf7b3..040ec616f3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1366,7 +1366,7 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ig
 		actual
 '
 
-test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
 	cat >expect <<-EOF &&
 	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
 	Warning: some commits may have been dropped accidentally.
@@ -1395,7 +1395,7 @@ test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = wa
 		actual
 '
 
-test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
 	cat >expect <<-EOF &&
 	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
 	Warning: some commits may have been dropped accidentally.
-- 
2.24.0.2.ga4a700ce8b

