Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0E481F42F
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeH1QCj (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33007 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeH1QCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id i134-v6so1742974wmf.0
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LLGu/YKGjFOzxkLmdqoGE4NBEo2tsRz5EDUFVQf8T0s=;
        b=NnlV5//vW+7iDvPgkuaEE4CHYPD6RYK1u2UcejMFOydlEtsauNcb8Xk8cFPW1yRJDb
         Fp8GbxfxhFHwMcI4i+sQIZQX1CHP2MGkKie1jQn3ixa5LSoLfwMJG4O+68Y1Sz8eN801
         NUjloaSOr/uv0tpOwlkCC+0y3qpw7UaVR2WPhtp0/gZq4m/7b9nwpktZsaaaBFs9tTw7
         7RgP7uy5sdk4SfSwscRSguSPDUFlbeBjyHGiIQirUNsEY5ZU8Fzco8s7JqbQDaf2wC1R
         brkmguvbu5d401HLOpo1eV/6Q5vcBqpmA3xsvM+DTxqbL6fpdIHG07X6tsVAh/mUplMM
         yvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LLGu/YKGjFOzxkLmdqoGE4NBEo2tsRz5EDUFVQf8T0s=;
        b=kgpARJxMZineyf3QdptN8/4rDUFASjxqKu0liJA1hK65QPFQE+VmCyt2WjFqNJdylH
         o1nENpJHmvy+WVPAFOVwTuXG4nJa50xjGJ/TY7tD+3Njg/h4Q8MH8t4D6tpEvLtMs5Uj
         olTvtnzy1P/blC+ySbi2vfz0/MMnWkPvosrbHGCjif0HFoGFrCF9HTJumIkLjmpDUiqT
         ZorZEyH4OIb79EuPN7BwV6RgeWYiebZSnASctFpYwTHZhV521NnhEt+0kGR3ec5eyd6s
         5aQJ1L1GtSLWoN8Qx5Kc9gzuAKmhrYLcV5TDZMOqhFwpvyPfHcEqqkBjSuTMbyr0HzcK
         BWcw==
X-Gm-Message-State: APzg51BcA3R2CrNo3jKyJzEv67ejhzaZ6tC+khC0bVMDA35szcQDZDck
        jAmzY9R/y53R31gFeT8NpQNZIec8
X-Google-Smtp-Source: ANB0Vdbaz0CjHqLfTmYLE+MKKJCRHcCfLq4//MY2WwYSjct4tP8HGe22rSCWHXYQH1bgzTqCUWc+/g==
X-Received: by 2002:a1c:7fc6:: with SMTP id a189-v6mr1221597wmd.42.1535458275870;
        Tue, 28 Aug 2018 05:11:15 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:14 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 09/20] sequencer: change the way skip_unnecessary_picks() returns its result
Date:   Tue, 28 Aug 2018 14:10:34 +0200
Message-Id: <20180828121045.14933-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of skip_unnecessary_picks() printing its result to stdout, it
returns it into a struct object_id, as the rewrite of complete_action()
(to come in the next commit) will need it.

rebase--helper then is modified to fit this change.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v6.

 builtin/rebase--helper.c | 10 ++++++++--
 sequencer.c              | 13 ++++++-------
 sequencer.h              |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 313092c465..bed3dd2b95 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -90,8 +90,14 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
-	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
-		return !!skip_unnecessary_picks();
+	if (command == SKIP_UNNECESSARY_PICKS && argc == 1) {
+		struct object_id oid;
+		int ret = skip_unnecessary_picks(&oid);
+
+		if (!ret)
+			puts(oid_to_hex(&oid));
+		return !!ret;
+	}
 	if (command == REARRANGE_SQUASH && argc == 1)
 		return !!rearrange_squash();
 	if (command == ADD_EXEC && argc == 2)
diff --git a/sequencer.c b/sequencer.c
index 48447d7f0e..a56a781539 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4420,17 +4420,17 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-int skip_unnecessary_picks(void)
+int skip_unnecessary_picks(struct object_id *output_oid)
 {
 	const char *todo_file = rebase_path_todo();
 	struct strbuf buf = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
-	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
+	struct object_id *parent_oid;
 	int fd, i;
 
 	if (!read_oneliner(&buf, rebase_path_onto(), 0))
 		return error(_("could not read 'onto'"));
-	if (get_oid(buf.buf, &onto_oid)) {
+	if (get_oid(buf.buf, output_oid)) {
 		strbuf_release(&buf);
 		return error(_("need a HEAD to fixup"));
 	}
@@ -4460,9 +4460,9 @@ int skip_unnecessary_picks(void)
 		if (item->commit->parents->next)
 			break; /* merge commit */
 		parent_oid = &item->commit->parents->item->object.oid;
-		if (hashcmp(parent_oid->hash, oid->hash))
+		if (hashcmp(parent_oid->hash, output_oid->hash))
 			break;
-		oid = &item->commit->object.oid;
+		oidcpy(output_oid, &item->commit->object.oid);
 	}
 	if (i > 0) {
 		int offset = get_item_line_offset(&todo_list, i);
@@ -4491,11 +4491,10 @@ int skip_unnecessary_picks(void)
 
 		todo_list.current = i;
 		if (is_fixup(peek_command(&todo_list, 0)))
-			record_in_rewritten(oid, peek_command(&todo_list, 0));
+			record_in_rewritten(output_oid, peek_command(&todo_list, 0));
 	}
 
 	todo_list_release(&todo_list);
-	printf("%s\n", oid_to_hex(oid));
 
 	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index d2b54adf45..fcbcd246c2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -91,7 +91,7 @@ int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
-int skip_unnecessary_picks(void);
+int skip_unnecessary_picks(struct object_id *output_oid);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
-- 
2.18.0

