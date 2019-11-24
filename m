Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE54C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A36207DD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp7oiJMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKXRpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:45:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37753 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKXRpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 12:45:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so14732966wrv.4
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 09:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mekNizc+QYov6l5tYkqIXNBZekBtF2NpGZtEvg3RkkY=;
        b=Tp7oiJMsc2UT8yNLI4xe7hWeIytld8hv+3VYY5mooGVILB1QlwuL6lFBIp7QegMPqD
         FTHK3kg5kjS+JcN7VqtETJjtMyBN9Vb6C1/x/JLYS6OFg1LlY4pJo2JQGSFJa4ToK03b
         pTuOmntz7cQNpVzRL3CB6TG4//f8IQDFrdksydwEF2m4LnYKOXruuGel9F0gcwQ2kHhv
         K7wc0Vm+W81s/KRYrLs+WhJIgeONg9dpN1DpQn+cIpHuwegUXh/GE37t0TEEcUIGitFg
         m5r7MsCWU2H0g2SFPr6mTgFm/M2Llus+w9thnI4RpntkpHq4L30DX1TSIlk/TPW9HH3C
         R7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mekNizc+QYov6l5tYkqIXNBZekBtF2NpGZtEvg3RkkY=;
        b=pEU3m67xzaM9TWpaAfpbnr5kngTgMGG54pMNzDh7Hzxn4ic1TvyNM4v/Ii7r2no0JK
         NBLP/KOVVDfMyC9oFKVNxCxaM+iVSz2gXEEb/iVeVW8VqUhdTdVpkGpqKwoDHwm9EWZ9
         dSIoyYVUPLv1Kt9NPasf5AglFry882M+Rv+L3HIyKjK1lTQ8qEBb2LT9+d6I2hAa6IIQ
         bjxIV5MWY7BWv6l5TzSJhvEtQhfZzxIpzTcGgyi/ezLsD3H6PmXE921hHn/OWQZlOkvT
         fKAsO/YUSq6xmmnkOw4BhjqNtdUhuYo8DD8twDQaJPZHDC8R2v+sLNIUxEujWSu7PizI
         wCDA==
X-Gm-Message-State: APjAAAWQPW0rZKUHJ1oEl1xUaxUTsAoeOMV+D626xK73qx9GXfRopy+Q
        4Y9K3b1grHTbw3EYOVlYQgcQf7uB
X-Google-Smtp-Source: APXvYqz5AYugB7C9Vazd2tPfH4p13Pdak1cAEYQaV8zcMUaoCkKhaPrZJBuCO6No+UVeRgLBk9MJ9w==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr11858288wrw.16.1574617540355;
        Sun, 24 Nov 2019 09:45:40 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id a2sm7171315wrt.79.2019.11.24.09.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 09:45:39 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 3/5] sequencer: move the code writing total_nr on the disk to a new function
Date:   Sun, 24 Nov 2019 18:43:30 +0100
Message-Id: <20191124174332.30887-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191124174332.30887-1-alban.gruin@gmail.com>
References: <20191123143705.17280-1-alban.gruin@gmail.com>
 <20191124174332.30887-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The total number of commands can be used to show the progression of the
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

