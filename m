Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE90E1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfGQOmD (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:42:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36310 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfGQOmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:42:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so25167454wrs.3
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7tobFTg7AVZQDvPzSsfhTT1tJ9CUQC01AcBkkA0DAlI=;
        b=QuIvPJPUG4v0mkbnwcbJxiioS0Etki+lSqcdBSTQbHNzPb0FMHPMm+8dHfbxAD8lKN
         KPfLjXgkfGsrK7phqqCNNWffNxlhFJiNnJIg/uioftfvvYauQHvVoKGZxRM3wKEM21Po
         rkBVMHde/dd1NXXWxczIDenVE5p8bDk9uxLLfS12w8h0+FCNu8AJ9SupoMyPJweHFSbG
         bW41cF8jJ/QGWomcAh5P/7Ble1CoJfRO6mA3Y2tdQtqKClQ/Nne3ND+a8TxQq55Uro4C
         TPck1WP37AEALoqhVlTq5h227FLsQKJVyVCR7RrYvwWOLfo43zrBSjFCJ7r4+9IeYF6w
         NnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tobFTg7AVZQDvPzSsfhTT1tJ9CUQC01AcBkkA0DAlI=;
        b=hun49hndDdysdRqTIw2CfADCwgFzmSrZ2/OYrrx8ckfzleX4jN6xIUUO3447s6MmVa
         74o9jzBz88AkBvOxHP4AQpih28he+pHIHgWkCiQ2jEEu4H5zcmX6ADjER2+wdFGiRU9e
         o5ttNrgBUydGCyyuGlf6aUFVhTnPKMPLG/lSXHZRazsUb3TkS7Nq+I69EJXvibMe7sQs
         hMp2EOq/+zJ9uogC23acKGOYEB/6nhIJponBLBDIaYgxe6XcYAHt1TxvRczCR9az0LKN
         v6FCtqDlpOhuFHXaOxpb5laTFhuNbDB79caqQjfQvKzuNKdiuuFaduXW1ST2ZanBz5tm
         7WUw==
X-Gm-Message-State: APjAAAWY6D1I3LXvgGUqGFbvSXJ9sPjv86Ba8t2mLwX3CpjIu6iMjJV6
        AMBG0J1EeajHyLtlkRfy1OWIqWUC
X-Google-Smtp-Source: APXvYqztzoIZ3k2lIjC+jnQVdQQJ/mB2KEknkrufW0uUE7iLu4s2ekFJSRF5v3TFh09E1Yn1dhFEkQ==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr8991559wro.133.1563374520357;
        Wed, 17 Jul 2019 07:42:00 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:41:59 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 5/9] sequencer: move the code writing total_nr on the disk to a new function
Date:   Wed, 17 Jul 2019 16:39:14 +0200
Message-Id: <20190717143918.7406-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The total amount of commands can be used to show the progression of the
rebasing in a shell.  This number is written to the disk by
read_populate_todo() when the todo list is loaded from
sequencer_continue() or pick_commits(), but not by complete_action(),
which releases its todo list before calling sequencer_continue(), which
reloads it immediatly afterwards.

To avoid to reload the todo list from the disk, sequencer_continue()
will be modified to accept a todo list, and if it is not null,
read_populate_todo() will not be called.

This moves the part writing total_nr to a new function so it can be
called by complete_action().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ec9c3d4dc5..d66b80d49f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2343,6 +2343,16 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 	sequencer_remove_state(&opts);
 }
 
+static void todo_list_write_total_nr(struct todo_list *todo_list)
+{
+	FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
+
+	if (f) {
+		fprintf(f, "%d\n", todo_list->total_nr);
+		fclose(f);
+	}
+}
+
 static int read_populate_todo(struct repository *r,
 			      struct todo_list *todo_list,
 			      struct replay_opts *opts)
@@ -2388,7 +2398,6 @@ static int read_populate_todo(struct repository *r,
 
 	if (is_rebase_i(opts)) {
 		struct todo_list done = TODO_LIST_INIT;
-		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
 		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
@@ -2400,10 +2409,7 @@ static int read_populate_todo(struct repository *r,
 			+ count_commands(todo_list);
 		todo_list_release(&done);
 
-		if (f) {
-			fprintf(f, "%d\n", todo_list->total_nr);
-			fclose(f);
-		}
+		todo_list_write_total_nr(todo_list);
 	}
 
 	return 0;
-- 
2.22.0

