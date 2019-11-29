Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50B8C43215
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB9B21771
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1nb9rrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfK2VL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:11:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34170 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2VL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:11:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so36656805wrr.1
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qt805LzCRvf8hQTv3jeP+hGnw2D8tx37blftwW8nOP4=;
        b=N1nb9rrRYibTxwXO7p6BFuq6l2E2ZC5FnGJXtUxhVNVsq3V3vJNubDnZI93nZd4lRZ
         KWDf1fVSqYC0n34PQ18v8mGbz4Ojm1DISDG3uhUz8nOSkRry0ktVOd1o5pVvzq7mKCB4
         kowusa91g6u22IC1b4QcWceRMmH6CWLTu1hrL9PPdoN1DrRG0XIZxrfqHeNFBfdU6RY0
         AMWPcp0QBlJyT71wLoGVKUHUo95UhfF5t8y9SWGgmGFxGWyUWrNj1VRU9ZVmFLQhP3xB
         +T2ofvBqm4xJ04NMZy1Lw1yGI3b8gBMzOvANBqxs8IOLZHwctVhVoSahqkQ1WcievFXo
         2ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qt805LzCRvf8hQTv3jeP+hGnw2D8tx37blftwW8nOP4=;
        b=k3KYhZVBcxDmpmXy99p0Z7stKeJf+VI64f6iv9lgHp/0ghVz73swfKIJntBoSHYEUG
         lBtK5l072USjHn8y6kEV/C7eAuorrTpocX1kjqlBejWIHXhw3Kzeg66xx/M7xxsKMVUt
         QA1FoFxoK/7D4HdV7s/cEcZu3L/qsdOzOsgdeIt715KDAP5gQSWWBiQyvbHMfsEerGJP
         6T7FeHQC0FDyJQbRZDl58ThLeZVGObJ3mJTd4trfjX64Ufhsr4k3LLqFaOmvaZ6es1wS
         0cCZEY+Zo8hesrA2eQ20foMbygH7BWkZ9F2OuxWuvONGzt2XXBKc5UEqeZO11V8EBesJ
         cVCA==
X-Gm-Message-State: APjAAAXgUZ4dt2Qn5FUpKf2JZw9DJhJPFZOIak4KY7MmZtrPVYH4qDYi
        vF/j2FWEjZ6OVXbtq3r77g3WaR6R
X-Google-Smtp-Source: APXvYqwtXUgi2lQsA/fEfMXSX3qOKYLgVzoUaq1jTQ4bm8CvXPGX2PYQQGzdp2Yvz3LQ4Zgu0HQn5Q==
X-Received: by 2002:a5d:5050:: with SMTP id h16mr61097503wrt.380.1575061914033;
        Fri, 29 Nov 2019 13:11:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 76sm15222977wma.0.2019.11.29.13.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:11:53 -0800 (PST)
Message-Id: <c311a29c77f0c05bcb455d387a15ee9c77d765e4.1575061909.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:11:44 +0000
Subject: [PATCH v2 4/9] built-in add -i: implement the `update` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After `status` and `help`, it is now time to port the `update` command
to C, the second command that is shown in the main loop menu of `git add
-i`.

This `git add -i` command is the first one which lets the user choose a
subset of a list of files, and as such, this patch lays the groundwork
for the other commands of that category:

- It teaches the `print_file_item()` function to show a unique prefix
  if we found any (the code to find it had been added already in the
  previous patch where we colored the unique prefixes of the main loop
  commands, but that patch uses the `print_command_item()` function to
  display the menu items).

- This patch also adds the help text that is shown when the user input
  to select items from the shown list could not be parsed.

- As `get_modified_files()` clears the list of files, it now has to take
  care of clearing the _full_ `prefix_item_list` lest the `sorted` and
  `selected` fields go stale and inconsistent.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 130 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 110 insertions(+), 20 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index ea406e903b..1e34e88069 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -6,6 +6,7 @@
 #include "revision.h"
 #include "refs.h"
 #include "string-list.h"
+#include "lockfile.h"
 
 struct add_i_state {
 	struct repository *r;
@@ -377,6 +378,7 @@ struct adddel {
 };
 
 struct file_item {
+	size_t prefix_length;
 	struct adddel index, worktree;
 };
 
@@ -471,7 +473,7 @@ enum modified_files_filter {
 
 static int get_modified_files(struct repository *r,
 			      enum modified_files_filter filter,
-			      struct string_list *files,
+			      struct prefix_item_list *files,
 			      const struct pathspec *ps)
 {
 	struct object_id head_oid;
@@ -484,8 +486,8 @@ static int get_modified_files(struct repository *r,
 	    repo_read_index_preload(r, ps, 0) < 0)
 		return error(_("could not read index"));
 
-	string_list_clear(files, 1);
-	s.files = files;
+	prefix_item_list_clear(files);
+	s.files = &files->items;
 	hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
 
 	for (i = 0; i < 2; i++) {
@@ -524,7 +526,7 @@ static int get_modified_files(struct repository *r,
 	hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
 
 	/* While the diffs are ordered already, we ran *two* diffs... */
-	string_list_sort(files);
+	string_list_sort(&files->items);
 
 	return 0;
 }
@@ -559,8 +561,8 @@ static int is_valid_prefix(const char *prefix, size_t prefix_len)
 }
 
 struct print_file_item_data {
-	const char *modified_fmt;
-	struct strbuf buf, index, worktree;
+	const char *modified_fmt, *color, *reset;
+	struct strbuf buf, name, index, worktree;
 };
 
 static void print_file_item(int i, int selected, struct string_list_item *item,
@@ -568,34 +570,96 @@ static void print_file_item(int i, int selected, struct string_list_item *item,
 {
 	struct file_item *c = item->util;
 	struct print_file_item_data *d = print_file_item_data;
+	const char *highlighted = NULL;
 
 	strbuf_reset(&d->index);
 	strbuf_reset(&d->worktree);
 	strbuf_reset(&d->buf);
 
+	/* Format the item with the prefix highlighted. */
+	if (c->prefix_length > 0 &&
+	    is_valid_prefix(item->string, c->prefix_length)) {
+		strbuf_reset(&d->name);
+		strbuf_addf(&d->name, "%s%.*s%s%s", d->color,
+			    (int)c->prefix_length, item->string, d->reset,
+			    item->string + c->prefix_length);
+		highlighted = d->name.buf;
+	}
+
 	render_adddel(&d->worktree, &c->worktree, _("nothing"));
 	render_adddel(&d->index, &c->index, _("unchanged"));
-	strbuf_addf(&d->buf, d->modified_fmt,
-		    d->index.buf, d->worktree.buf, item->string);
+
+	strbuf_addf(&d->buf, d->modified_fmt, d->index.buf, d->worktree.buf,
+		    highlighted ? highlighted : item->string);
 
 	printf("%c%2d: %s", selected ? '*' : ' ', i + 1, d->buf.buf);
 }
 
 static int run_status(struct add_i_state *s, const struct pathspec *ps,
-		      struct string_list *files, struct list_options *opts)
+		      struct prefix_item_list *files,
+		      struct list_and_choose_options *opts)
 {
 	if (get_modified_files(s->r, NO_FILTER, files, ps) < 0)
 		return -1;
 
-	list(s, files, NULL, opts);
+	list(s, &files->items, NULL, &opts->list_opts);
 	putchar('\n');
 
 	return 0;
 }
 
+static int run_update(struct add_i_state *s, const struct pathspec *ps,
+		      struct prefix_item_list *files,
+		      struct list_and_choose_options *opts)
+{
+	int res = 0, fd;
+	size_t count, i;
+	struct lock_file index_lock;
+
+	if (get_modified_files(s->r, WORKTREE_ONLY, files, ps) < 0)
+		return -1;
+
+	if (!files->items.nr) {
+		putchar('\n');
+		return 0;
+	}
+
+	opts->prompt = N_("Update");
+	count = list_and_choose(s, files, opts);
+	if (count <= 0) {
+		putchar('\n');
+		return 0;
+	}
+
+	fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
+	if (fd < 0) {
+		putchar('\n');
+		return -1;
+	}
+
+	for (i = 0; i < files->items.nr; i++) {
+		const char *name = files->items.items[i].string;
+		if (files->selected[i] &&
+		    add_file_to_index(s->r->index, name, 0) < 0) {
+			res = error(_("could not stage '%s'"), name);
+			break;
+		}
+	}
+
+	if (!res && write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
+		res = error(_("could not write index"));
+
+	if (!res)
+		printf(Q_("updated %d path\n",
+			  "updated %d paths\n", count), (int)count);
+
+	putchar('\n');
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
-		    struct string_list *unused_files,
-		    struct list_options *unused_opts)
+		    struct prefix_item_list *unused_files,
+		    struct list_and_choose_options *unused_opts)
 {
 	color_fprintf_ln(stdout, s->help_color, "status        - %s",
 			 _("show paths with changes"));
@@ -613,9 +677,29 @@ static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
 	return 0;
 }
 
+static void choose_prompt_help(struct add_i_state *s)
+{
+	color_fprintf_ln(stdout, s->help_color, "%s",
+			 _("Prompt help:"));
+	color_fprintf_ln(stdout, s->help_color, "1          - %s",
+			 _("select a single item"));
+	color_fprintf_ln(stdout, s->help_color, "3-5        - %s",
+			 _("select a range of items"));
+	color_fprintf_ln(stdout, s->help_color, "2-3,6-9    - %s",
+			 _("select multiple ranges"));
+	color_fprintf_ln(stdout, s->help_color, "foo        - %s",
+			 _("select item based on unique prefix"));
+	color_fprintf_ln(stdout, s->help_color, "-...       - %s",
+			 _("unselect specified items"));
+	color_fprintf_ln(stdout, s->help_color, "*          - %s",
+			 _("choose all items"));
+	color_fprintf_ln(stdout, s->help_color, "           - %s",
+			 _("(empty) finish selecting"));
+}
+
 typedef int (*command_t)(struct add_i_state *s, const struct pathspec *ps,
-			 struct string_list *files,
-			 struct list_options *opts);
+			 struct prefix_item_list *files,
+			 struct list_and_choose_options *opts);
 
 struct command_item {
 	size_t prefix_length;
@@ -667,18 +751,21 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		command_t command;
 	} command_list[] = {
 		{ "status", run_status },
+		{ "update", run_update },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
 
 	struct print_file_item_data print_file_item_data = {
-		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+		"%12s %12s %s", NULL, NULL,
+		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
-	struct list_options opts = {
-		0, NULL, print_file_item, &print_file_item_data
+	struct list_and_choose_options opts = {
+		{ 0, NULL, print_file_item, &print_file_item_data },
+		NULL, 0, choose_prompt_help
 	};
 	struct strbuf header = STRBUF_INIT;
-	struct string_list files = STRING_LIST_INIT_DUP;
+	struct prefix_item_list files = PREFIX_ITEM_LIST_INIT;
 	ssize_t i;
 	int res = 0;
 
@@ -699,11 +786,13 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		data.color = s.prompt_color;
 		data.reset = s.reset_color;
 	}
+	print_file_item_data.color = data.color;
+	print_file_item_data.reset = data.reset;
 
 	strbuf_addstr(&header, "      ");
 	strbuf_addf(&header, print_file_item_data.modified_fmt,
 		    _("staged"), _("unstaged"), _("path"));
-	opts.header = header.buf;
+	opts.list_opts.header = header.buf;
 
 	if (discard_index(r->index) < 0 ||
 	    repo_read_index(r) < 0 ||
@@ -727,8 +816,9 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		}
 	}
 
-	string_list_clear(&files, 1);
+	prefix_item_list_clear(&files);
 	strbuf_release(&print_file_item_data.buf);
+	strbuf_release(&print_file_item_data.name);
 	strbuf_release(&print_file_item_data.index);
 	strbuf_release(&print_file_item_data.worktree);
 	strbuf_release(&header);
-- 
gitgitgadget

