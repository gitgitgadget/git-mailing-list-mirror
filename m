Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D05C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AB920706
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbfsfgJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKWOrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:47:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35612 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKWOrf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 09:47:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id n5so797446wmc.0
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raobcgxZIeCMIufQzXkhKjVYw9ZZcAw8TdKexUZshJE=;
        b=fbfsfgJ0XWeDlXiBp735/ettcBvWqMN4l3KLHQd80gYkc8JiKIzbnivxQwW7tC0xlz
         a2ghT3fAWWWDBmZskH1E4Vtzf91kzK85j/5T0iQfydf8PTlGEc3wxgSZ992bJR8hoHi3
         1yn1HDkAp+D1mJ+g1TT1Rdow4SarUZ8tud3ILicDbWaoPuwgdwCzoQ70L82ocyQuPTug
         EUR8jwAMLWcI46IRj1gtBWtIAkctHkVr0NW5M/iGgzGY/ljf9AeWQmasEgPxWvhV9Ge9
         lwUeXxVHwKTeSsG5aIOAJtt2AD+U5HvVeQ9DfQScOXeO6dyz9iu6oF2iSO7qPDZokpwg
         qnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raobcgxZIeCMIufQzXkhKjVYw9ZZcAw8TdKexUZshJE=;
        b=QLVf29ZJKyWdb9zrrvU86NuHGAIFwIxFWmQCdbilVEQ4oUKM5ag9ks1xwWerZNyOso
         Q5OUBbMOyqRTsPU1/gSiCu3dyebojPpMbiJMrXwTBQk3BTok15KQohIi+ChtJeJXnRFD
         U4aJRjuFn4p5NsBd1eWG2tdfSv5PhhxDRC8Xg4bV2/O/5Cbavrf+Hj3BQnl9s2HTDusZ
         c0k8CTPAFdJXbHUXagfz/XUlHqXj1grbmkMwSpJ7sHZkDfwbTk6osAHTXjh5CtlHAR8q
         hOFT3Tn36e9rZrrK3kxDqxlSMRr4H1rHI6szkV4r68CL/LBwpnFJ2BLQZVpiNOBairsz
         lNTQ==
X-Gm-Message-State: APjAAAX9SXYbVZQEAki98x/G9y693gew08qcznRAeIZoU9mWGWuhICC+
        FQCrbm5W+Xkd7Gr90ZI0JdPD8v+U
X-Google-Smtp-Source: APXvYqwhzml+BCUw1qRs6HEKqDJOeIy2/K9C46XLULsXhfa/tiUX+CLtK6mY5Fq8avEJsE1cdPdwDA==
X-Received: by 2002:a05:600c:22c3:: with SMTP id 3mr20888311wmg.139.1574520041893;
        Sat, 23 Nov 2019 06:40:41 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id b10sm2399298wrw.53.2019.11.23.06.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 06:40:41 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 3/5] sequencer: move the code writing total_nr on the disk to a new function
Date:   Sat, 23 Nov 2019 15:37:03 +0100
Message-Id: <20191123143705.17280-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123143705.17280-1-alban.gruin@gmail.com>
References: <20191007092641.12661-1-alban.gruin@gmail.com>
 <20191123143705.17280-1-alban.gruin@gmail.com>
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
2.24.0

