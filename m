Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8921FEB3
	for <e@80x24.org>; Sun,  8 Jan 2017 09:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934823AbdAHJlZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 04:41:25 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34274 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934672AbdAHJkq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 04:40:46 -0500
Received: by mail-pg0-f66.google.com with SMTP id b1so48632552pgc.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 01:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z37+bSpkFY0KMAZUoOvGJ4gmYUpBMATHCOUw0Y0kI2I=;
        b=NnRuDe79oxu0lk4tWbqfBrxeywa9PTHnEPy9okJlJbg506qXozAYXJmbupAQny+6kW
         OUqshBFWYHmSv339vV1tOGN5QE1+HW0Ba7dy0kVdZI1YKNPHthTmXNqCrH3B4MQSEE+z
         5k0K3f+exBu3e/DNK65dCjVDTEl8kKGRyJaO9zeNB1BCi3SjTM33uABM4xiyqp5VunJV
         /WKwfRtAX9fiPAvdQJRHoGOLmE3eAC9VTYMeUcd5jGzkADrYlalXpzq+DINPxsf6eOFw
         ftqsH/hUGxp6CaQymKMKVw97uWCeBR0v8UBRgr5zjsru4tHkW5yVA3vKLtU+sSaFuGXc
         2t6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z37+bSpkFY0KMAZUoOvGJ4gmYUpBMATHCOUw0Y0kI2I=;
        b=hVqApI72aiL25y8sTofRATAqt+lDZVsPg7lbm15bYWoE2N2Cxn6tUfLtYCABId8swf
         GMJZVYQNWjp40WEnVq1Tk30YrCWkXhxGeWIF7R0ozIxTXOzzz49ZR7QYnUzVNEu9TfOp
         zFXCAGN9GEiu2Pdw9xqguY4HwsQ1Cj35CMGCEzRuVKsGFJ8JJmu2Jr+G2gl8agGQYHOS
         wkiEFrPWa/O5zib2kmQD0KNGLMAf6MAxdBzubEwRCu5im7OX/iIQ2WURxE2Gj0DBLAZA
         E/2dIG4Fmfn0wY4NssAWwnBUuBEc7LQWis+CX5ydQ+19cmcH+BHz9Ihk6UNw4i7XytKJ
         1XSg==
X-Gm-Message-State: AIkVDXKcI9P+L+fGhRsygcGTIFLxKRPiqpigEtUHCuNPpzhbqwgBhuxVmlbImg6odyFE1w==
X-Received: by 10.99.112.66 with SMTP id a2mr153809011pgn.43.1483868444615;
        Sun, 08 Jan 2017 01:40:44 -0800 (PST)
Received: from ash ([115.72.187.80])
        by smtp.gmail.com with ESMTPSA id r2sm170581269pfi.67.2017.01.08.01.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jan 2017 01:40:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 08 Jan 2017 16:40:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/6] worktree move: refuse to move worktrees with submodules
Date:   Sun,  8 Jan 2017 16:40:02 +0700
Message-Id: <20170108094003.637-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170108094003.637-1-pclouds@gmail.com>
References: <20170108094003.637-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodules contains .git files with relative paths. After a worktree
move, these files need to be updated or they may point to nowhere.

This is a bandage patch to make sure "worktree move" don't break
people's worktrees by accident. When .git file update code is in
place, this validate_no_submodules() could be removed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 900b68b..64d0264 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -525,6 +525,27 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static void validate_no_submodules(const struct worktree *wt)
+{
+	struct index_state istate = {0};
+	int i, found_submodules = 0;
+
+	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
+		for (i = 0; i < istate.cache_nr; i++) {
+			struct cache_entry *ce = istate.cache[i];
+
+			if (S_ISGITLINK(ce->ce_mode)) {
+				found_submodules = 1;
+				break;
+			}
+		}
+	}
+	discard_index(&istate);
+
+	if (found_submodules)
+		die(_("This working tree contains submodules and cannot be moved yet"));
+}
+
 static int move_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -565,6 +586,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
 
+	validate_no_submodules(wt);
+
 	if (is_directory(dst.buf)) {
 		const char *sep = find_last_dir_sep(wt->path);
 
-- 
2.8.2.524.g6ff3d78

