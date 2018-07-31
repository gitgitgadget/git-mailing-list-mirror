Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD92C1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbeGaTmB (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:42:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37781 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbeGaTmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:42:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so4114371wmc.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k6q+eDXkEi/SCaZx86CYII/qX0r+E1ZqB/Cbqf24Vh4=;
        b=ZDCcyo50/zXOQJXKeD0YcqsRFsSQyPeNcyfJpbhQ9tBpt4kjxE5ZFjxNwT1nRUi4Qj
         xd7bQAAY17NrXQmTM0u5iF6MRVzt1Xa2Z6j3rbwZklOv7oYU0R7OlSKRCgSiv08Y5LXG
         gFRYG5rZI4Wv0Ma2GmvxDrLcFh+soePAUmeOSokk8dNtmc7ZaRab9jdAyoQnafwZRVwl
         G1sZwp/wQRp+SKL+ETGIrIzU7gale2jyAwFBFVNHWox2HdOT/dRVb6YnJcjyTXaayPJZ
         ztO2GkwrvtErLQAhdsGCv69TTUeO+1INSWG9DStlC6lSsRaZzT9oQJZMaXBg8I+prHh1
         spvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k6q+eDXkEi/SCaZx86CYII/qX0r+E1ZqB/Cbqf24Vh4=;
        b=M5YtRRbarhkTicM8wUp//wqgUAS/vF2vojtYdb8PC/nQWQ6ZTjkRFTBQzCAJAeFUx4
         lwap2Hr/UPV1xZWD+aJ77lfy3y6eKnJXcZi5pFGekxlvBUcfPpRvq3/t9DGtG+r3E0sg
         TsHCLxzKQedy7YfLrRresARIBkwvRIxy0sajwrMlZjtpxJbj7w3p2bUN7Lx/W+b4Y0Z2
         eRWdUVUePDIwXxHqnQ4DxE8dl/7u/jP82i09h3oCilSFENYGqK/KzNTtxpX/7kgmyV4H
         64DWMaJCen6YXWgL0W8Dxf5CZGWDVcnsWGn8w6LIQhcR+7DAONk3lFlShn6vkiVLZDaO
         9pxw==
X-Gm-Message-State: AOUpUlEInxg+K0U5FvPbJH6t1enaiESMVxtk78NwzK2vO7Qif53+TQSA
        w4bMR70WGh9B1tBkQ0TIRMTd0LEI
X-Google-Smtp-Source: AAOMgpc48ea41poHgSUTcvnpR99T9iORbShbdfF//vwpVqOFkJHvrEg9f8JEwnt9kTF/nJS3iX1QUw==
X-Received: by 2002:a1c:b286:: with SMTP id b128-v6mr430179wmf.121.1533060033014;
        Tue, 31 Jul 2018 11:00:33 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:32 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 09/20] sequencer: change the way skip_unnecessary_picks() returns its result
Date:   Tue, 31 Jul 2018 19:59:52 +0200
Message-Id: <20180731180003.5421-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
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
No changes since v4.

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
index 4285247810..a2e04b9eca 100644
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
index 11a5334612..f11dabfd65 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -88,7 +88,7 @@ int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
-int skip_unnecessary_picks(void);
+int skip_unnecessary_picks(struct object_id *output_oid);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
-- 
2.18.0

