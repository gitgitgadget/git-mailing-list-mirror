Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FF51F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeKIRsH (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39589 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeKIRsH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so1076421wmc.4
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tfZ307nRgyEqbmBve6NkVsC8BXVcagI217eUrJjje0=;
        b=uQJs2jIdi8iUlQHEvU/9wMmtfomZHtUT7YJWl3/MJ1cX+N4uzw7N4OIzxQwouW0Clr
         +ZdkLMn0zO341F54QFc9PSvQN3umYaCkRlQJNHsnm6+jyYmlV3h0jRaKuz2PJkLxD8SM
         GTABn/8PqKuqNqmEaDbDhJnS5yxJ14AQz42G5RyEcW/Emnop3VtZz/pLbysDL4DGFu84
         ivG86kS8zUNf/Se2bgpZxxOsCS06qv0+z4nD9QPCqPuoZCqEbf07TVrxBCR8h0/jd6Vk
         SMtA6/lvi4/ZOxqSzeQNZIWBspug8xJCtiyV5s4fDs/3lqV/l/9c7rFoM3eExR4tusX5
         abLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tfZ307nRgyEqbmBve6NkVsC8BXVcagI217eUrJjje0=;
        b=Xv2apq7YCmnwQQycFCv4bkKaoB7+reUh0U7Z5nmMQ715k67gGHIYEFLhiy0Z5zdVBv
         c8d3T4dN4qR9wfAk6gsF0zfNa5haYOH0t/tRLorkhGwS0wlFl/CnrzgyRApHbvK1kOX+
         4V4ESGhEQqD73J0r7Jh7toPRit3fBzzWliA9+8Za0d303BB6nimTV4U57GTcs6lk5rc3
         m0dv7JufnX4oUmBDH81Uc7S+fGqj9nafr/BNR7/9MEepaEC3IlO3VJFoFA2Zrrd5kSTd
         0qPOvp6N1CboqUY1Xoi2xCO078OScJ+NGVVhAauqxL1HDkIO7fcc2wvePjQDmkbuxblt
         +Nsg==
X-Gm-Message-State: AGRZ1gJiwmuxAXE/C4Sx/0CF6DWUHb0PPkOcHcVwk7v+vDXqfCWq2rWf
        JebtshZPSSckUC1weQZ0YdmDnvhT
X-Google-Smtp-Source: AJdET5du5NKvC7marS6Bbdp7A/Um70PZBarSXgA7tUA5ZuwkssMlilhZsZlz50UhITSQ9V6gprCf4g==
X-Received: by 2002:a1c:3491:: with SMTP id b139-v6mr3468006wma.99.1541750918638;
        Fri, 09 Nov 2018 00:08:38 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:38 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 07/16] sequencer: refactor rearrange_squash() to work on a todo_list
Date:   Fri,  9 Nov 2018 09:07:56 +0100
Message-Id: <20181109080805.6350-8-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors rearrange_squash() to work on a todo_list to avoid
redundant reads and writes.  The function is renamed
todo_list_rearrange_squash().

The old version created a new buffer, which was directly written to the
disk.  This new version creates a new item list by just memcpying items
from the old item list, without creating a new buffer.  This eliminates
the need to reparse the todo list, but this also means its buffer cannot
be directly written to the disk.

As rebase -p still need to check the todo list from the disk, a new
function is introduced, rearrange_squash_in_todo_file().

complete_action() still uses rearrange_squash_in_todo_file() for now.
This will be changed in a future commit.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c |  2 +-
 sequencer.c                   | 87 +++++++++++++++++------------------
 sequencer.h                   |  2 +-
 3 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 1fb5a43c0d..a6d83a684e 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -265,7 +265,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		ret = check_todo_list_from_file();
 		break;
 	case REARRANGE_SQUASH:
-		ret = rearrange_squash();
+		ret = rearrange_squash_in_todo_file();
 		break;
 	case ADD_EXEC:
 		ret = sequencer_add_exec_commands(&commands);
diff --git a/sequencer.c b/sequencer.c
index 11692d0b98..fce97e5f11 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4722,7 +4722,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	    write_message("noop\n", 5, todo_file, 0))
 		return -1;
 
-	if (autosquash && rearrange_squash())
+	if (autosquash && rearrange_squash_in_todo_file())
 		return -1;
 
 	if (commands->nr)
@@ -4828,21 +4828,13 @@ define_commit_slab(commit_todo_item, struct todo_item *);
  * message will have to be retrieved from the commit (as the oneline in the
  * script cannot be trusted) in order to normalize the autosquash arrangement.
  */
-int rearrange_squash(void)
+static int todo_list_rearrange_squash(struct todo_list *todo_list)
 {
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
 	struct hashmap subject2item;
-	int res = 0, rearranged = 0, *next, *tail, i;
+	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
 	char **subjects;
 	struct commit_todo_item commit_todo;
-
-	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
-		return -1;
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	struct todo_item *items = NULL;
 
 	init_commit_todo_item(&commit_todo);
 	/*
@@ -4855,13 +4847,13 @@ int rearrange_squash(void)
 	 * be moved to appear after the i'th.
 	 */
 	hashmap_init(&subject2item, (hashmap_cmp_fn) subject2item_cmp,
-		     NULL, todo_list.nr);
-	ALLOC_ARRAY(next, todo_list.nr);
-	ALLOC_ARRAY(tail, todo_list.nr);
-	ALLOC_ARRAY(subjects, todo_list.nr);
-	for (i = 0; i < todo_list.nr; i++) {
+		     NULL, todo_list->nr);
+	ALLOC_ARRAY(next, todo_list->nr);
+	ALLOC_ARRAY(tail, todo_list->nr);
+	ALLOC_ARRAY(subjects, todo_list->nr);
+	for (i = 0; i < todo_list->nr; i++) {
 		struct strbuf buf = STRBUF_INIT;
-		struct todo_item *item = todo_list.items + i;
+		struct todo_item *item = todo_list->items + i;
 		const char *commit_buffer, *subject, *p;
 		size_t subject_len;
 		int i2 = -1;
@@ -4874,7 +4866,6 @@ int rearrange_squash(void)
 		}
 
 		if (is_fixup(item->command)) {
-			todo_list_release(&todo_list);
 			clear_commit_todo_item(&commit_todo);
 			return error(_("the script was already rearranged."));
 		}
@@ -4909,7 +4900,7 @@ int rearrange_squash(void)
 				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
 				i2 = *commit_todo_item_at(&commit_todo, commit2)
-					- todo_list.items;
+					- todo_list->items;
 			else {
 				/* copy can be a prefix of the commit subject */
 				for (i2 = 0; i2 < i; i2++)
@@ -4922,7 +4913,7 @@ int rearrange_squash(void)
 		}
 		if (i2 >= 0) {
 			rearranged = 1;
-			todo_list.items[i].command =
+			todo_list->items[i].command =
 				starts_with(subject, "fixup!") ?
 				TODO_FIXUP : TODO_SQUASH;
 			if (next[i2] < 0)
@@ -4940,10 +4931,8 @@ int rearrange_squash(void)
 	}
 
 	if (rearranged) {
-		struct strbuf buf = STRBUF_INIT;
-
-		for (i = 0; i < todo_list.nr; i++) {
-			enum todo_command command = todo_list.items[i].command;
+		for (i = 0; i < todo_list->nr; i++) {
+			enum todo_command command = todo_list->items[i].command;
 			int cur = i;
 
 			/*
@@ -4954,37 +4943,47 @@ int rearrange_squash(void)
 				continue;
 
 			while (cur >= 0) {
-				const char *bol =
-					get_item_line(&todo_list, cur);
-				const char *eol =
-					get_item_line(&todo_list, cur + 1);
-
-				/* replace 'pick', by 'fixup' or 'squash' */
-				command = todo_list.items[cur].command;
-				if (is_fixup(command)) {
-					strbuf_addstr(&buf,
-						todo_command_info[command].str);
-					bol += strcspn(bol, " \t");
-				}
-
-				strbuf_add(&buf, bol, eol - bol);
-
+				ALLOC_GROW(items, nr + 1, alloc);
+				items[nr++] = todo_list->items[cur];
 				cur = next[cur];
 			}
 		}
 
-		res = rewrite_file(todo_file, buf.buf, buf.len);
-		strbuf_release(&buf);
+		FREE_AND_NULL(todo_list->items);
+		todo_list->items = items;
+		todo_list->nr = nr;
+		todo_list->alloc = alloc;
 	}
 
 	free(next);
 	free(tail);
-	for (i = 0; i < todo_list.nr; i++)
+	for (i = 0; i < todo_list->nr; i++)
 		free(subjects[i]);
 	free(subjects);
 	hashmap_free(&subject2item, 1);
-	todo_list_release(&todo_list);
 
 	clear_commit_todo_item(&commit_todo);
+
+	return 0;
+}
+
+int rearrange_squash_in_todo_file(void)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res = 0;
+
+	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
+		return -1;
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+		todo_list_release(&todo_list);
+		return -1;
+	}
+
+	res = todo_list_rearrange_squash(&todo_list);
+	if (!res)
+		res = todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, -1, 0);
+
+	todo_list_release(&todo_list);
 	return res;
 }
diff --git a/sequencer.h b/sequencer.h
index d7b52044bd..1cd9d7f1e2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -147,7 +147,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
 		    unsigned autosquash);
-int rearrange_squash(void);
+int rearrange_squash_in_todo_file(void);
 
 extern const char sign_off_header[];
 
-- 
2.19.1.872.ga867da739e

