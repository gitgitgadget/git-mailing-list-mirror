Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205F5C43215
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AD1206ED
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSsfqGg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLBXse (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:48:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33510 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLBXsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 18:48:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so1503126wrq.0
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 15:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCQ608+YtJjzyJ+RDmqlwR9TSXTs5Id9DK4Pfy2fWds=;
        b=TSsfqGg7djapjGI5XyNQG76fyaPzE14v8MP6hfLMQDx4l0KSOwWSYRSVAiu+EpyVL5
         wboNqoJ/8O3Gz7HSg5+G2+Uqi7CKvxQt2WIZjAqa5TyyfTwch9tu3O++ksIMlHxHzjAa
         93SsGBsZLns+lv9DwAMn12DvBIFB25Etv7xXCwLwTytlX5dEF3VwFMtz3BfMtQx43m1E
         poz2lM9Hxw7l70g7FHG81N+0z7XlG7ETYCGEjCjF4DkCUQsK4iTqTj4wPfI1g7YrLSp+
         2ZiIkK9OsRUyWHY+M1BuCbPrT1O7i5U5LRQE2SbkBWgRJeIYDFuz8QwcUMv4TFlc1wgh
         C2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCQ608+YtJjzyJ+RDmqlwR9TSXTs5Id9DK4Pfy2fWds=;
        b=kINUdcMPmyAPlofq30eZF+yrvryS3SY/aMGwJKXsuZPMz8/gjB6iHM1bIak8LDnRWs
         BkFTYO3UjbRTba9o55Siz4Sfpe4NjBjQPDz7W97IlmSXFLGHmHFj++YGLpqfs1eQXkyV
         arpYCWZfi/+TpDdlr3vlWbxG6NoWnxZZhbhec5v+FTP/7aE5PZBBXmKwVWyApkvI/WBl
         jmcm2l+/dhs+fGpY3qqDmKCVeN2CRcOdaNk18Rr5gyf9IiL4RBaJL9/9WTQChP2Mn7c8
         ba4X/gNWwfkat2b9SR+2zcaOT9wodaCYJPItQPN7ay6osm4FM1TaNmugMdvn5M9ZSH2T
         P8/Q==
X-Gm-Message-State: APjAAAWRT4qKwfzB/SMel7ZQgH10hFWgVIBI7KOagUJluNlK6RXWmvI5
        lArqconqnSMoWNfP6AskYoFSTuh7
X-Google-Smtp-Source: APXvYqzp0vdOyv53Avyh6LWSofa/jUMJd0Kbty+MvszxBFCPUWRCsmz7yv6emctO3KKnGCcDAx5Eng==
X-Received: by 2002:adf:cd03:: with SMTP id w3mr1663622wrm.191.1575330511106;
        Mon, 02 Dec 2019 15:48:31 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-25-142.w86-222.abo.wanadoo.fr. [86.222.24.142])
        by smtp.googlemail.com with ESMTPSA id e16sm1148360wrj.80.2019.12.02.15.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 15:48:30 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 1/2] sequencer: move check_todo_list_from_file() to rebase-interactive.c
Date:   Tue,  3 Dec 2019 00:47:58 +0100
Message-Id: <20191202234759.26201-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202234759.26201-1-alban.gruin@gmail.com>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191202234759.26201-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The message contained in `edit_todo_list_advice' (sequencer.c) is
printed after the initial edit of the todo list if it can't be parsed or
if commits were dropped.  This is done either in complete_action() for
`rebase -i', or in check_todo_list_from_file() for `rebase -p'.

Since we want to add this check when editing the list, we also want to
use this message from edit_todo_list() (rebase-interactive.c).  To this
end, check_todo_list_from_file() is moved to rebase-interactive.c, and
`edit_todo_list_advice' is copied there.  In the next commit,
complete_action() will stop using it, and `edit_todo_list_advice' will
be removed from sequencer.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 rebase-interactive.c | 35 +++++++++++++++++++++++++++++++++++
 rebase-interactive.h |  2 ++
 sequencer.c          | 29 -----------------------------
 sequencer.h          |  1 -
 4 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index aa18ae82b7..ad5dd49c31 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -6,6 +6,12 @@
 #include "commit-slab.h"
 #include "config.h"
 
+static const char edit_todo_list_advice[] =
+N_("You can fix this with 'git rebase --edit-todo' "
+"and then run 'git rebase --continue'.\n"
+"Or you can abort the rebase with 'git rebase"
+" --abort'.\n");
+
 enum missing_commit_check_level {
 	MISSING_COMMIT_CHECK_IGNORE = 0,
 	MISSING_COMMIT_CHECK_WARN,
@@ -187,3 +193,32 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
 	clear_commit_seen(&commit_seen);
 	return res;
 }
+
+int check_todo_list_from_file(struct repository *r)
+{
+	struct todo_list old_todo = TODO_LIST_INIT, new_todo = TODO_LIST_INIT;
+	int res = 0;
+
+	if (strbuf_read_file(&new_todo.buf, rebase_path_todo(), 0) < 0) {
+		res = error(_("could not read '%s'."), rebase_path_todo());
+		goto out;
+	}
+
+	if (strbuf_read_file(&old_todo.buf, rebase_path_todo_backup(), 0) < 0) {
+		res = error(_("could not read '%s'."), rebase_path_todo_backup());
+		goto out;
+	}
+
+	res = todo_list_parse_insn_buffer(r, old_todo.buf.buf, &old_todo);
+	if (!res)
+		res = todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo);
+	if (!res)
+		res = todo_list_check(&old_todo, &new_todo);
+	if (res)
+		fprintf(stderr, _(edit_todo_list_advice));
+out:
+	todo_list_release(&old_todo);
+	todo_list_release(&new_todo);
+
+	return res;
+}
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 44dbb06311..5f41bf5a28 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -13,4 +13,6 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 		   const char *shortonto, unsigned flags);
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 
+int check_todo_list_from_file(struct repository *r);
+
 #endif
diff --git a/sequencer.c b/sequencer.c
index ec0b793fc5..181bb35f5f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4992,35 +4992,6 @@ N_("You can fix this with 'git rebase --edit-todo' "
 "Or you can abort the rebase with 'git rebase"
 " --abort'.\n");
 
-int check_todo_list_from_file(struct repository *r)
-{
-	struct todo_list old_todo = TODO_LIST_INIT, new_todo = TODO_LIST_INIT;
-	int res = 0;
-
-	if (strbuf_read_file_or_whine(&new_todo.buf, rebase_path_todo()) < 0) {
-		res = -1;
-		goto out;
-	}
-
-	if (strbuf_read_file_or_whine(&old_todo.buf, rebase_path_todo_backup()) < 0) {
-		res = -1;
-		goto out;
-	}
-
-	res = todo_list_parse_insn_buffer(r, old_todo.buf.buf, &old_todo);
-	if (!res)
-		res = todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo);
-	if (!res)
-		res = todo_list_check(&old_todo, &new_todo);
-	if (res)
-		fprintf(stderr, _(edit_todo_list_advice));
-out:
-	todo_list_release(&old_todo);
-	todo_list_release(&new_todo);
-
-	return res;
-}
-
 /* skip picking commits whose parents are unchanged */
 static int skip_unnecessary_picks(struct repository *r,
 				  struct todo_list *todo_list,
diff --git a/sequencer.h b/sequencer.h
index 574260f621..75ddc5db3a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -155,7 +155,6 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 
 void todo_list_add_exec_commands(struct todo_list *todo_list,
 				 struct string_list *commands);
-int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const char *orig_head, struct string_list *commands,
-- 
2.24.0

