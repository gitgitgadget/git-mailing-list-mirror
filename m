Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F311120248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCETSu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40580 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCETSt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id g20so3629848wmh.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgRvZKtLd1Oumv21BWBkHRVu2exWC/DaF1AbPmZ8V2E=;
        b=CVBHKt0lzrPvFI0jUNQsTrDRjeoOI61Eine5fZWbHvf0FzttN3nRiVC4M3PwAQ/Swn
         9Jv7wRFQ21aDmPcV5xzFCbQqrBV0MXBUE+TKJKZKP3XX/g6+p2dFXhletac7siNmjPRJ
         vg8ehuQf0SRC0DUlEpYPmJFbDI6GIPpTgGzmmcWqFC0+bPqo2FmoGSto/Y9Wvx4WmhtL
         oxGgpJd/ETRlpLA+Oqn+Avn/+pwah5QEicgbPmUCwwGckxTy/i6X5e7V7mKsDmmYQw3M
         ff8mgWUWeZrBlUBh5FCNpTn5AR4ngzdNQumwT1scyH6gY33+XIREJb1vnm+px7pAWeVm
         Otvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgRvZKtLd1Oumv21BWBkHRVu2exWC/DaF1AbPmZ8V2E=;
        b=cZ7nfpVzHJXM/NDgyYzua3jGBA1Ru4Q7TgCducIPeuOPbC/3O1nPFvrajL0ZgqetqZ
         gy2CiAjSCHBbvp67LZ5qnHnG8od5LbZ1iU8+berLotMJ/BQX6knmaG2USUAX24l4YyJh
         YCcGvzDTG+YO7e5MxdP+A8sFJT472c6WsHLSC2QkrYZcAHxejwqb7m5kSCgx36z4cVRP
         z1047qm/HS/oiiB/jIcGaK/x9OmJDoC+l9gwl+kkEMfe+WWe2KQTTHOkFEsFNbTXsAzo
         EwY+4CQmcLz6WTmZfEGsQs0FgLz6QfeGproRtGjq7yAj0NXDcpKxwbTdYDy6/yN2fUeQ
         WoQQ==
X-Gm-Message-State: APjAAAVESzg9NuPwW8GgmmgWw3eDXD55dmuEPHvLJYaEHDWj2BL0IX/b
        VoTGdW74EaPe0LAdN8ieAQq6xOVK
X-Google-Smtp-Source: APXvYqxqVxQ4QJNbJqawUvu5pEXO9jygzXV8lBHDODzMkvADr9LPAw+w9lSaVePQujgDLf0MQcA/Kg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr87568wma.32.1551813526737;
        Tue, 05 Mar 2019 11:18:46 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:46 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 12/18] rebase--interactive: move rearrange_squash_in_todo_file()
Date:   Tue,  5 Mar 2019 20:17:59 +0100
Message-Id: <20190305191805.13561-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305191805.13561-1-alban.gruin@gmail.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190305191805.13561-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As rearrange_squash_in_todo_file() is only needed inside of
rebase--interactive.c for `rebase -p', it is moved there from
sequencer.c.

The parameter r (repository) is dropped along the way, and the error
handling is slightly improved.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
New commit, but was a part of "rebase--interactive: move several
functions to rebase--interactive.c" from the v7.

 builtin/rebase--interactive.c | 28 +++++++++++++++++++++++++++-
 sequencer.c                   | 28 +---------------------------
 sequencer.h                   |  2 +-
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 3bf1da6940..ab2c6fcd99 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -38,6 +38,32 @@ static int add_exec_commands(struct string_list *commands)
 	return 0;
 }
 
+static int rearrange_squash_in_todo_file(void)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res = 0;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+					&todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	res = todo_list_rearrange_squash(&todo_list);
+	if (!res)
+		res = todo_list_write_to_file(the_repository, &todo_list,
+					      todo_file, NULL, NULL, -1, 0);
+
+	todo_list_release(&todo_list);
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
+}
+
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
 			       char **revisions, char **shortrevisions)
@@ -288,7 +314,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = check_todo_list_from_file(the_repository);
 		break;
 	case REARRANGE_SQUASH:
-		ret = rearrange_squash_in_todo_file(the_repository);
+		ret = rearrange_squash_in_todo_file();
 		break;
 	case ADD_EXEC:
 		ret = add_exec_commands(&commands);
diff --git a/sequencer.c b/sequencer.c
index 280d9bcce7..ffa4334982 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4793,8 +4793,6 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
 	return 0;
 }
 
-static int todo_list_rearrange_squash(struct todo_list *todo_list);
-
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
@@ -4906,7 +4904,7 @@ define_commit_slab(commit_todo_item, struct todo_item *);
  * message will have to be retrieved from the commit (as the oneline in the
  * script cannot be trusted) in order to normalize the autosquash arrangement.
  */
-static int todo_list_rearrange_squash(struct todo_list *todo_list)
+int todo_list_rearrange_squash(struct todo_list *todo_list)
 {
 	struct hashmap subject2item;
 	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
@@ -5044,27 +5042,3 @@ static int todo_list_rearrange_squash(struct todo_list *todo_list)
 
 	return 0;
 }
-
-int rearrange_squash_in_todo_file(struct repository *r)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res = 0;
-
-	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
-		return -1;
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
-
-	res = todo_list_rearrange_squash(&todo_list);
-	if (!res)
-		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
-
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
diff --git a/sequencer.h b/sequencer.h
index 0c4b7c80f8..13c5676c24 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -153,7 +153,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
 		    unsigned autosquash, struct todo_list *todo_list);
-int rearrange_squash_in_todo_file(struct repository *r);
+int todo_list_rearrange_squash(struct todo_list *todo_list);
 
 extern const char sign_off_header[];
 
-- 
2.20.1

