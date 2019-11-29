Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BF9C43215
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5513021771
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCGr/Fzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfK2VMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:12:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32908 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfK2VL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:11:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so7063855wrq.0
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+QwmTjeBBSw/1wGMzOC2xILLCccj1/8uexq+NGioUpI=;
        b=lCGr/Fzhky3evxmaBKiS8SNMAq+ZvrPtKJRqtL4QV3+Z0SKXgDDvvVKLqXhBmq7yT4
         B+jkViGzad8tB5qMo/YzvfwoXEbwQESLxFRU4KIGNP52kNNxSzKCvER5w2f5gI0gi4LY
         dk4qwN0P4j4oPOmNs4suHKqTpmvSsTHe6ELqIpr7ze9EAwzNLog2JHiBIFBMeCroJptw
         xxz/zzazeu72m1JX6G7Q7sUqN4We/M3NoRlVh74wNOuR5QsWiqpU38WsWkGsDgkqsZIF
         RcHuQ/zV8r1y52z2pGClL5xd5ynXODlDGFpQlx5T6XoMSnNp+e090CYC+Gmsi+0+Ba34
         5Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+QwmTjeBBSw/1wGMzOC2xILLCccj1/8uexq+NGioUpI=;
        b=q+sa8CcMgRxW+nFGoXT3vT5u3XcC6DkjubbP4isSCrXdyNKCtYZa0NGJpnHCRTGWbP
         8COwRg/rYJosKLdWAy1aQU57vr/vfnrEYJmm/wIZD/Jlo+BOTkN9HhdShRNKyTFPzexO
         OZIIG7ThXh5AV5D2qmqCxHKcdgatOYeBg/7nG8B72HL0p0DIIe08/E70gMnZGKxBLXRk
         jVAmo9vQO59fsNY0ZvxzDTaCOqzhA8V8YdjNUlEu28jpi5GvPmEJpC5wHI/5TmizcFZD
         i1mz4qFuO0rMp4o+wFblLq7KA+YSZTo/9NL8Vl/EJM+mSRXPyX3LPqExqq9AsbHdNgWo
         SCiQ==
X-Gm-Message-State: APjAAAXVkuCqJYrWVdWZVycq/7oUtS9jkjUuAGqimxCY6DRfb1Yst14K
        mSuyEtdbOJNN09Pf/9QDE3WBeZ6n
X-Google-Smtp-Source: APXvYqxeOE4kAE3I5lml31XnpMk7OteT8k3M1mk0DOkU/3Z8iXznLGU/SNTVqIo4YewWPVkAKQ41fg==
X-Received: by 2002:adf:e2cd:: with SMTP id d13mr57318245wrj.221.1575061915503;
        Fri, 29 Nov 2019 13:11:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x125sm427834wmx.43.2019.11.29.13.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:11:55 -0800 (PST)
Message-Id: <952fbc8f79760554b3f45ca9a935541a5dbd1a33.1575061909.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:11:46 +0000
Subject: [PATCH v2 6/9] built-in add -i: re-implement `add-untracked` in C
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

This is yet another command, ported to C. It builds nicely on the
support functions introduced for other commands, with the notable
difference that only names are displayed for untracked files, no
file type or diff summary.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index adab17a635..a719d30b0b 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "lockfile.h"
+#include "dir.h"
 
 struct add_i_state {
 	struct repository *r;
@@ -563,6 +564,7 @@ static int is_valid_prefix(const char *prefix, size_t prefix_len)
 struct print_file_item_data {
 	const char *modified_fmt, *color, *reset;
 	struct strbuf buf, name, index, worktree;
+	unsigned only_names:1;
 };
 
 static void print_file_item(int i, int selected, struct string_list_item *item,
@@ -586,6 +588,12 @@ static void print_file_item(int i, int selected, struct string_list_item *item,
 		highlighted = d->name.buf;
 	}
 
+	if (d->only_names) {
+		printf("%c%2d: %s", selected ? '*' : ' ', i + 1,
+		       highlighted ? highlighted : item->string);
+		return;
+	}
+
 	render_adddel(&d->worktree, &c->worktree, _("nothing"));
 	render_adddel(&d->index, &c->index, _("unchanged"));
 
@@ -765,6 +773,88 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
+static int get_untracked_files(struct repository *r,
+			       struct prefix_item_list *files,
+			       const struct pathspec *ps)
+{
+	struct dir_struct dir = { 0 };
+	size_t i;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (repo_read_index(r) < 0)
+		return error(_("could not read index"));
+
+	prefix_item_list_clear(files);
+	setup_standard_excludes(&dir);
+	add_pattern_list(&dir, EXC_CMDL, "--exclude option");
+	fill_directory(&dir, r->index, ps);
+
+	for (i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+
+		if (index_name_is_other(r->index, ent->name, ent->len)) {
+			strbuf_reset(&buf);
+			strbuf_add(&buf, ent->name, ent->len);
+			add_file_item(&files->items, buf.buf);
+		}
+	}
+
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
+		      struct prefix_item_list *files,
+		      struct list_and_choose_options *opts)
+{
+	struct print_file_item_data *d = opts->list_opts.print_item_data;
+	int res = 0, fd;
+	size_t count, i;
+	struct lock_file index_lock;
+
+	if (get_untracked_files(s->r, files, ps) < 0)
+		return -1;
+
+	if (!files->items.nr) {
+		printf(_("No untracked files.\n"));
+		goto finish_add_untracked;
+	}
+
+	opts->prompt = N_("Add untracked");
+	d->only_names = 1;
+	count = list_and_choose(s, files, opts);
+	d->only_names = 0;
+	if (count <= 0)
+		goto finish_add_untracked;
+
+	fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
+	if (fd < 0) {
+		res = -1;
+		goto finish_add_untracked;
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
+	if (!res &&
+	    write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
+		res = error(_("could not write index"));
+
+	if (!res)
+		printf(Q_("added %d path\n",
+			  "added %d paths\n", count), (int)count);
+
+finish_add_untracked:
+	putchar('\n');
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
 		    struct prefix_item_list *unused_files,
 		    struct list_and_choose_options *unused_opts)
@@ -861,6 +951,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		{ "status", run_status },
 		{ "update", run_update },
 		{ "revert", run_revert },
+		{ "add untracked", run_add_untracked },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
-- 
gitgitgadget

