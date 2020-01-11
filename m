Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0887AC33CA4
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 17:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65F720866
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 17:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3X+9SKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgAKRkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 12:40:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34768 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbgAKRkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 12:40:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so4698145wrr.1
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1v/A2n8opMWrSFC79bMLmL0xv/O+qJpEEBpyNpmbcY=;
        b=m3X+9SKY2ZKDi9WQpt5Kq7AVqisfkiVovowj8O83904MZrjFxTu1c/ggn3DHtO87j/
         oYaSOc77nMhZ28iUUtX8WV/PCf+/4Y+ZXQMuOEr/C+MbPBLSHyfjQlS742jbC7TARLxv
         8hJAlhWOyzLJoXOoe53yzFq9YAQKdebB0cEreuAbeNXSH/REMUYNwa4Du4QqC6c6yQYe
         jBnQeZJNKpOnUI1QddhfDnka9714lAhWXbC7YNaqsRpyUVAPumSdLVqtLx2tO9xw7bVI
         6h6f7+SYCIflq+EMs2piajVcgvRLv73dpMHY/MRsvL0sF4Y0E1M96xOQj1JgCo1dd9AD
         2Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1v/A2n8opMWrSFC79bMLmL0xv/O+qJpEEBpyNpmbcY=;
        b=tvQSjS83lDR5aSiEffJ3898DnXsmk7R//e1VKMWAF6p/cowuo85o50eOfLYo9z3NDS
         OyIDlQ8tJOsa79bKpmPdmJ8Kfsf76GDreSV3N3ZqzaGIstybaxCyYf9JnRM1EwsXr7H7
         LlAjxu94brSBEW3b9ggtgLcwukJ+HuSdR5MJ861PpOJtF5ftgyU00XClKWFfMNegZ4rk
         LemWiCn27PstwwmZ/Bh+XK7iXqET+HlNg4Tip3ntIOZVwIHW83q20CwJ6WIzJpVs6dX1
         wJOM2AIFnSkbwcC7nSZpE5GlV5nTTpa7cK1VUIxtmd8GuEdizQP90rRL5UOxxhdBrhNJ
         WXbw==
X-Gm-Message-State: APjAAAUGDWyTY8qOOJpVPB324PajIZz6lK1Z0/TStV3PfH+ZmtxqDqFs
        vd5rtAztQc7YWI0MBsYMualdPrLm
X-Google-Smtp-Source: APXvYqytLgKUmTeHpOlbtuI6eRIhyk3KnNdmI8Dw3PR62zc9tigsVZYt7NWTXAUm3livGWspXM/EZQ==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr10292489wrr.74.1578764413613;
        Sat, 11 Jan 2020 09:40:13 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-29-116.w86-222.abo.wanadoo.fr. [86.222.28.116])
        by smtp.googlemail.com with ESMTPSA id m3sm7034543wrs.53.2020.01.11.09.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jan 2020 09:40:13 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 1/2] sequencer: move check_todo_list_from_file() to rebase-interactive.c
Date:   Sat, 11 Jan 2020 18:39:16 +0100
Message-Id: <20200111173917.15690-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111173917.15690-1-alban.gruin@gmail.com>
References: <20191202234759.26201-1-alban.gruin@gmail.com>
 <20200111173917.15690-1-alban.gruin@gmail.com>
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
2.24.1

