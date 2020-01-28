Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC2C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 21:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC5222522
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 21:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/s7cWhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgA1VRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:17:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50459 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1VRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 16:17:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so4087749wmb.0
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HM4CjUkbW6li3TWWv0MNzHoHNOP0dyhd74PbVaepVIc=;
        b=M/s7cWhKwuBgGjHTy7h6WU+mfis2N77BxBHBkZZrMVBGPJmM51SIDbYg5PpigzI5Zo
         7Xrs/2Gir8bgezVNj79nG72fLSRrCduGkQWfIz6DxQIM24GBxfSCXatS8OMCOQVn3kGq
         D3m4+qW4lJj4TjYDPLoy2kDIVaFLC/wQiQ/mwBqFo+rlV9xUjQmWS/zacewGsk7/nbGO
         0x0TCPS5JKyRhFOXEmT09friQt28q2X0qCZNzlDXGpzEoH0U4osLS5cHoidBz1z2Loqf
         /xDVsx6iqlT7Q62RwQuAKHDLKvPkKgIaNc4lgKjvkfmMtg7RgAPBL63EdPNaXttEZlMA
         8USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HM4CjUkbW6li3TWWv0MNzHoHNOP0dyhd74PbVaepVIc=;
        b=hgHzXq+/VUk9+SsRyt9T/QxEGDGfGAOdBSZP616WnbmPjSkopl7BbGhz2RAVCeZhs6
         P4vxmszVABluG8boL6PhDHeaHXZRPlMR7xmT99IKiAiKmSQsxjS1DzBVhch2fl4eM5/j
         BoMZYM/U0VN5+HOA+rsqtGu1HpRQ3V2/jdIcSspXg5uxkaHmIOHRq06dY9xYj8P8Nfc5
         oNLGlfv0FM+IZVqjqkFrIgc6KD7LFQ4XaCqD02nFUeF+IUVPHSNXJlH+TCwOlMPtn5lv
         TRB+E/TbgYldeFTnJCZyliUoGz4cxZ07nH0dfkRH50kJ5yjcCZJMEOix+IIRSI7Gyhp8
         yqPQ==
X-Gm-Message-State: APjAAAVPNlKU7qgIs8qGVEyyNmYgDvgjXlYlEO+3mG8NVF1b66r5dB+H
        g+9yK4oa/+b+l+Dhyo8PJCbkA8w0
X-Google-Smtp-Source: APXvYqx1xF76rtBjP7VICZ6jVStdlD7as7QYM6MD/+yK2TRTE28q/3NEJO539JHuMKA4BnqCzApO8Q==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr6864407wmi.14.1580246262169;
        Tue, 28 Jan 2020 13:17:42 -0800 (PST)
Received: from localhost.localdomain (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.googlemail.com with ESMTPSA id y6sm27056035wrl.17.2020.01.28.13.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 13:17:41 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 1/2] sequencer: move check_todo_list_from_file() to rebase-interactive.c
Date:   Tue, 28 Jan 2020 22:12:45 +0100
Message-Id: <20200128211246.10855-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128211246.10855-1-alban.gruin@gmail.com>
References: <20200125175436.29786-1-alban.gruin@gmail.com>
 <20200128211246.10855-1-alban.gruin@gmail.com>
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
index 1259adc8ea..45f29c28a8 100644
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
@@ -189,3 +195,32 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
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
index 5f69b47e32..9365fc3e5a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4991,35 +4991,6 @@ N_("You can fix this with 'git rebase --edit-todo' "
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
index 9f9ae291e3..5d4df0807c 100644
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
2.24.1

