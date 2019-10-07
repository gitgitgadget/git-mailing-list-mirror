Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3981D1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 09:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfJGJ1E (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 05:27:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35018 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfJGJ1E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 05:27:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so14372631wrt.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/HNJ4oa/khQQUfeg3XoK7zRdCWG38Uj0B1kt+9pIes=;
        b=qwgIh+kn4rK0ob8xIfclUitP/8jgPVoKw56GbFkGMeNGTLvmSR0m56MjaB9rTxYdwU
         ZMlX7NuN7647N4UPHDTNfdpCmyk3pBOjrt0281t7+6h7FqzI6joHllkkICTIKoyCzVbm
         FInmaD81vOrW+zg7fl6dqsxtFnlf59iDDoHVlC6hDWFiQD5XgV7WvgSIcOo+T4RlBkhP
         sESZXt0xSwq8ff84lY7iJmCJ1YHg14Iba+g4HODTmrIqRV8P4UAgKQHcmJMWQkM1t521
         abWBrTA2kMgagCIS0wdsBaelUZJSuCd2pOOFeV5kIP4ipliShoKQmm5tDTdmj4bcwPa0
         pdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/HNJ4oa/khQQUfeg3XoK7zRdCWG38Uj0B1kt+9pIes=;
        b=Qd9t7utzoUJ4OGFatCbwL5FqohW3y3WG+cph8PXUJ4ABBfCgQoXxZzMrlvLynOLfHV
         4pPRN1rWG81mkpCTCdZkINg7LkhUFgvOo4VTCBDqH1HJ4luC1vyMEZPlbtQDzJeEexcv
         mGP4hTX+wtN5wqjy6pIiQdaOwRJ2I5jI6r7V1fZsCBlVODFVZJk4apZL1bO6i/XL1h2J
         cdn5BlVmV0VgRtDYkwxZsUeM1N1LOn7OMPSwPU7CVEcMaX12/iOTKnADwswcMjniHnhc
         803orwDYRs6Y0Pnw/jmQpMutgyRqRhMascOKrr6jM8MF1kDhCW0pB1oLL171dyh7WsZm
         uHrg==
X-Gm-Message-State: APjAAAWKRn3YQnr8DgxsXYHwpgxx9+CEkjIZA5+UV3zJ8HJoeNMGJQcd
        5MW7CK2uqf18cZj6cb2PasP0cW/v
X-Google-Smtp-Source: APXvYqwg6Vdx0Y5dMyEfBfU9RYiTI6U5WnHsVYp50QC+YBqDLPamESMztVF9956OE+gwL5d8Lu8MgA==
X-Received: by 2002:a5d:61c8:: with SMTP id q8mr15544434wrv.325.1570440421870;
        Mon, 07 Oct 2019 02:27:01 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-47-220.w86-221.abo.wanadoo.fr. [86.221.54.220])
        by smtp.googlemail.com with ESMTPSA id w125sm25250914wmg.32.2019.10.07.02.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 02:27:01 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 3/5] sequencer: move the code writing total_nr on the disk to a new function
Date:   Mon,  7 Oct 2019 11:26:39 +0200
Message-Id: <20191007092641.12661-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007092641.12661-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20191007092641.12661-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The total amount of commands can be used to show the progression of the
rebasing in a shell.  It is written to the disk by read_populate_todo()
when the todo list is loaded from sequencer_continue() or
pick_commits(), but not by complete_action().

This moves the part writing total_nr to a new function so it can be
called from complete_action().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 42313f8de6..ec7ea8d9e5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2342,6 +2342,16 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
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
@@ -2387,7 +2397,6 @@ static int read_populate_todo(struct repository *r,
 
 	if (is_rebase_i(opts)) {
 		struct todo_list done = TODO_LIST_INIT;
-		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
 		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
@@ -2399,10 +2408,7 @@ static int read_populate_todo(struct repository *r,
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
2.23.0

