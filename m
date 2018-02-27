Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF121F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeB0Va5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:30:57 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36051 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeB0Vaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:30:55 -0500
Received: by mail-wm0-f67.google.com with SMTP id 188so1288535wme.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=prQneit6WTuIEJ2GV5w8PnZJvuBVk5cEoarGz5KQ0as=;
        b=fzz27UWQWGtOnbKFvIcU/GsiS0rksGQi+F5Ywe9LwQeJBPpiV20lN96R5Lp7FQ7F0t
         wR8qfBA2ufacsVp/gVkG4K/hi2OZaQxd9B/LnbCzJsgYF1GaFjGJ/344naG45J1OkE+z
         XNRTry1a1Z8BxLjc4lyb/0eVnlCWhvDfsnWEsE75Jio+I+tzuldb4zTl1t8HOk9cwun3
         y1knz262DMBuwMW6pRCd1EQkoV4pEClWIbfnWusJbBhOoq4tM2AaiiRdyLbLHYlFH+qE
         DdgqbFHSZTLI8UVz/55mJM0wPRGhf+4h29I/mJu0BwkieK/JK4Ol7DomNqIgeVKy6uA5
         DGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prQneit6WTuIEJ2GV5w8PnZJvuBVk5cEoarGz5KQ0as=;
        b=IQypx45OROr6A/kSTrlNSpdkMKhg0pvLJhPkjNYgTaF9TohD6E4EA//A/TSiWpS6T3
         ZgGBMZNXoBWyPpNoKy7K4a4VIrSdXa7hg8AoIkYpH8zKAp3Wvx52+lfrreZpvCw61TZY
         YZQ01QE6dIw3eQLWfzvwwGb3zjiblgkZWNbybJTAqQ5S2DXWB2KmJTSjJlHXyhaAY7M3
         sFLr83dkPu0TnRRJMaNt5ux+KVpBDBH8NEfRABgjUdoNT3dar32cyLnM0vMcOoYwQ5tZ
         kcxqvIDp55pu+ymRS3eNw+Xmxo73BtbJo5gZczRRj7vTdhjVQap8koxV9d6F51Ayt34t
         JSag==
X-Gm-Message-State: APf1xPAbWQ/Hirf5nH0AB/DbFbM6jw5hneFcfNVwcjTe2MtnWgtqJqDR
        eqwHUN6Ek3/LIWKGJhUmr01LIBVv
X-Google-Smtp-Source: AG47ELuxYxtP+0dT/UoJ8H/1j5H9X+cJk4LzIXE0trgZl71/4vl5RHRQ7/gQfAQNhx/NRRbapZ6B9g==
X-Received: by 10.28.214.144 with SMTP id n138mr2880154wmg.126.1519767054076;
        Tue, 27 Feb 2018 13:30:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t91sm126888wrc.21.2018.02.27.13.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 13:30:53 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/5] sequencer: do not roll back lockfile unnecessarily
Date:   Tue, 27 Feb 2018 22:30:13 +0100
Message-Id: <d1dbf0b0a4742d8afeabd3acb0848e679c88eb50.1519763396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519763396.git.martin.agren@gmail.com>
References: <cover.1519763396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `commit_lock_file()` or `hold_lock_file_for_update()` fail, there is
no need to call `rollback_lock_file()` on the lockfile. It doesn't hurt
either, but it does make different callers in this file inconsistent,
which might be confusing.

While at it, remove a trailing '.' from a recurring error message.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 sequencer.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e6bac4692a..0e6d04e4ce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -303,10 +303,8 @@ static int write_message(const void *buf, size_t len, const char *filename,
 		rollback_lock_file(&msg_file);
 		return error_errno(_("could not write eol to '%s'"), filename);
 	}
-	if (commit_lock_file(&msg_file) < 0) {
-		rollback_lock_file(&msg_file);
-		return error(_("failed to finalize '%s'."), filename);
-	}
+	if (commit_lock_file(&msg_file) < 0)
+		return error(_("failed to finalize '%s'"), filename);
 
 	return 0;
 }
@@ -1585,10 +1583,8 @@ static int save_head(const char *head)
 	ssize_t written;
 
 	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
-	if (fd < 0) {
-		rollback_lock_file(&head_lock);
+	if (fd < 0)
 		return error_errno(_("could not lock HEAD"));
-	}
 	strbuf_addf(&buf, "%s\n", head);
 	written = write_in_full(fd, buf.buf, buf.len);
 	strbuf_release(&buf);
@@ -1597,10 +1593,8 @@ static int save_head(const char *head)
 		return error_errno(_("could not write to '%s'"),
 				   git_path_head_file());
 	}
-	if (commit_lock_file(&head_lock) < 0) {
-		rollback_lock_file(&head_lock);
-		return error(_("failed to finalize '%s'."), git_path_head_file());
-	}
+	if (commit_lock_file(&head_lock) < 0)
+		return error(_("failed to finalize '%s'"), git_path_head_file());
 	return 0;
 }
 
@@ -1724,7 +1718,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 			todo_list->buf.len - offset) < 0)
 		return error_errno(_("could not write to '%s'"), todo_path);
 	if (commit_lock_file(&todo_lock) < 0)
-		return error(_("failed to finalize '%s'."), todo_path);
+		return error(_("failed to finalize '%s'"), todo_path);
 
 	if (is_rebase_i(opts)) {
 		const char *done_path = rebase_path_done();
-- 
2.16.2.246.ga4ee44448f

