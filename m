Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9549020248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCETSs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33854 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETSs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id o10so2812240wmc.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0aga4nAShWzMhgt4F24MqQfjEz7+MkIxCEO1FmPNcng=;
        b=UGPIIKmnra9jY1bouHqqOk7xoZncwgXbvEhylog3dLo6aatKbfcdOBmKpJxthvEACo
         k+W1pHMw0peny2VEtuPuQZ76wdUJWZPT0g+5CTLzvKJYR5rk9eUmQaaoanzm5O3Bvu1M
         hBaXbOWlKhWfX16gGpLDgWbA6vTVCQaRmhhIABjtxfoiChGRrHtZ02Wna3s6NYyc0eFD
         G5e4H5HpQalSBZVZM8d0dWWzMhXDfI4irSTaVD2yAcEg8SSthLWto2lKgYOQczz1LfYo
         TMtzm+oic/n/OSk5Zn7x94KqwNMEMllOGduxqhI7fhA2zbfF+x9gIiixtYKxhGFQqFOq
         n8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aga4nAShWzMhgt4F24MqQfjEz7+MkIxCEO1FmPNcng=;
        b=GeqPT+KiQ0zJLfVFs4sz1Kc7S1o4ZLUTigAgRvuEKRuZDgxmjZLKwMmSjAcQTnVNQX
         ezX623tGobFjWXiF4woZH4eKxU0QK3QOf26Mwm8cWQ0upi2zeAwZ2bY5XxNymhQsCiVD
         v9XGTjDNe+TJWJaff5shzlo52XK+DgP3G5SHRtJ9EjLByfEegp/LAVzSkqse2PnLQsjy
         5T8TLxEP2fogej1QujJcsndzbrN/KLOmvmwQHBsa2YHTIWUOmVUiv1cFiziNksRmxL4G
         ITdTpgUEEYR+kol8GpA2EMw57oAJAMjaDtEa444zv4gAELlLs1U4Bievz/w7pYMMctj9
         xACA==
X-Gm-Message-State: APjAAAU9IEx/3BuDDJUo20qUXz2FlRbNRRQDn9pYe1TXWPo3vn0n6b5K
        FPRbbhc5N+zWNKjKU15qMe+ZDsAA
X-Google-Smtp-Source: APXvYqxMoZ2YaQUslbPebf2rmH0LroiY+775u53F21A7TMvlITAikJjbOd2G1EGaKDCGsF/cpeKXEg==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr81251wmj.108.1551813525169;
        Tue, 05 Mar 2019 11:18:45 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:44 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 11/18] rebase--interactive: move sequencer_add_exec_commands()
Date:   Tue,  5 Mar 2019 20:17:58 +0100
Message-Id: <20190305191805.13561-12-alban.gruin@gmail.com>
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

As sequencer_add_exec_commands() is only needed inside of
rebase--interactive.c for `rebase -p', it is moved there from
sequencer.c.

The parameter r (repository) is dropped along the way.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
New commit, but was a part of "rebase--interactive: move several
functions to rebase--interactive.c" from the v7.

 builtin/rebase--interactive.c | 27 ++++++++++++++++++++++++++-
 sequencer.c                   | 28 ++--------------------------
 sequencer.h                   |  4 ++--
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index ffbe14cef5..3bf1da6940 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -13,6 +13,31 @@ static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
 static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 
+static int add_exec_commands(struct string_list *commands)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+					&todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	todo_list_add_exec_commands(&todo_list, commands);
+	res = todo_list_write_to_file(the_repository, &todo_list,
+				      todo_file, NULL, NULL, -1, 0);
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
@@ -266,7 +291,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = rearrange_squash_in_todo_file(the_repository);
 		break;
 	case ADD_EXEC:
-		ret = sequencer_add_exec_commands(the_repository, &commands);
+		ret = add_exec_commands(&commands);
 		break;
 	default:
 		BUG("invalid command '%d'", command);
diff --git a/sequencer.c b/sequencer.c
index 1d5cd2fc27..280d9bcce7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4500,8 +4500,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
  * Add commands after pick and (series of) squash/fixup commands
  * in the todo list.
  */
-static void todo_list_add_exec_commands(struct todo_list *todo_list,
-					struct string_list *commands)
+void todo_list_add_exec_commands(struct todo_list *todo_list,
+				 struct string_list *commands)
 {
 	struct strbuf *buf = &todo_list->buf;
 	size_t base_offset = buf->len;
@@ -4567,30 +4567,6 @@ static void todo_list_add_exec_commands(struct todo_list *todo_list,
 	todo_list->alloc = alloc;
 }
 
-int sequencer_add_exec_commands(struct repository *r,
-				struct string_list *commands)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	todo_list_add_exec_commands(&todo_list, commands);
-	res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
 static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
 				struct strbuf *buf, int num, unsigned flags)
 {
diff --git a/sequencer.h b/sequencer.h
index 7029b39cd6..0c4b7c80f8 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -145,9 +145,9 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
 
-int sequencer_add_exec_commands(struct repository *r,
-				struct string_list *commands);
 int transform_todo_file(struct repository *r, unsigned flags);
+void todo_list_add_exec_commands(struct todo_list *todo_list,
+				 struct string_list *commands);
 int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-- 
2.20.1

