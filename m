Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7037C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4EE2067B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P31MRcdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgFHGZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgFHGZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:07 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7F1C08C5C6
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 23:25:07 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v11so15645098ilh.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+bz1xhM48KvzNHMIasj+815fr8XmjW0JGhd0x4mBIc=;
        b=P31MRcdl8FeRFcNWwFsVMMXnO/0qikYjb0ps47f9geFkKN7xR23PscGxk5qHjTtdR+
         qZDjFEpvj1iJ+qJDaklEvFP7mWrccggRNFgTcQwqlWRpNB8Iq3pZO3uA25QkwqtVPwUg
         xqsNQt27Jr85YeGixyqiWxkueAjrkt4NAWEi8WglR6BT64lmuJq2y2Puv675VtEK+5jK
         qdr0wiBsaGspwgL9X9sfYfQD3jE+znSXLuJHERNZslpLz0QuWWVmAjuDJ9FjswUIaTQg
         vAiKJzAk6bQ9hUAKb1OdrCQV6teXLIGPN+1uz6XFKya1WkwphMvqsswunQmcd/5Bsw7P
         5K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=k+bz1xhM48KvzNHMIasj+815fr8XmjW0JGhd0x4mBIc=;
        b=lOqzWHfcY0qyeNVlzJMkCcx2HwygtlStI826O4IJ4YWpcy1NPsNc3lcl78AwOIfaqP
         OLb8ReI72vJ2FU9yprDQG6p1mz6FIC+UzP4Rwj8B7kqUxnSLS6ofudEAeha/AjD4ONzh
         VC6oIV0KUccvM10dBsOPQTHhp7bjeeSx+Fkwx+cQIL1fpKXYqT4RQeAoKfXxOIJERFYu
         rG4r7D7zzl0+a31EwE4ipqpk/OA5xb29i+6FQebvyZqyKKzb6JuWLidRvG03VBjEqICh
         WFPTjmxo/Xpd9IoodXVu3Xf2uXYkBPnf5xXSNL9WA4cqrd8J0kAr9PJOkuylUZwSXyxw
         qZfw==
X-Gm-Message-State: AOAM531czWgKFqR8fYNHruU2Rajp4Mu6eQ+pQr+//rc9qK6bBPQQg7So
        jWhnIMsH1Qtf3MzhoCGvbld7nZfWcsY=
X-Google-Smtp-Source: ABdhPJz6gcbgsxlNfiVhYsDOBHM/p66GaX1BftIm0ewOj+u2jYk+RvY9C0s3wdnwS7jdEAyegrkTdg==
X-Received: by 2002:a92:8b13:: with SMTP id i19mr20918334ild.46.1591597506131;
        Sun, 07 Jun 2020 23:25:06 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s73sm7477948ilk.41.2020.06.07.23.25.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 23:25:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 7/8] worktree: generalize candidate worktree path validation
Date:   Mon,  8 Jun 2020 02:23:55 -0400
Message-Id: <20200608062356.40264-8-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da
In-Reply-To: <20200608062356.40264-1-sunshine@sunshineco.com>
References: <20200608062356.40264-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git worktree add" checks that the specified path is a valid location
for a new worktree by ensuring that the path does not already exist and
is not already registered to another worktree (a path can be registered
but missing, for instance, if it resides on removable media). Since "git
worktree add" is not the only command which should perform such
validation ("git worktree move" ought to also), generalize the the
validation function for use by other callers, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index eebd77c46d..7c0637234e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -274,34 +274,33 @@ static const char *worktree_basename(const char *path, int *olen)
 	return name;
 }
 
-static void validate_worktree_add(const char *path, const struct add_opts *opts)
+/* check that path is viable location for worktree */
+static void check_candidate_path(const char *path,
+				 int force,
+				 struct worktree **worktrees,
+				 const char *cmd)
 {
-	struct worktree **worktrees;
 	struct worktree *wt;
 	int locked;
 
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
-	worktrees = get_worktrees(0);
 	wt = find_worktree_by_path(worktrees, path);
 	if (!wt)
-		goto done;
+		return;
 
 	locked = !!worktree_lock_reason(wt);
-	if ((!locked && opts->force) || (locked && opts->force > 1)) {
+	if ((!locked && force) || (locked && force > 1)) {
 		if (delete_git_dir(wt->id))
-		    die(_("unable to re-add worktree '%s'"), path);
-		goto done;
+		    die(_("unusable worktree destination '%s'"), path);
+		return;
 	}
 
 	if (locked)
-		die(_("'%s' is a missing but locked worktree;\nuse 'add -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), path);
+		die(_("'%s' is a missing but locked worktree;\nuse '%s -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), cmd, path);
 	else
-		die(_("'%s' is a missing but already registered worktree;\nuse 'add -f' to override, or 'prune' or 'remove' to clear"), path);
-
-done:
-	free_worktrees(worktrees);
+		die(_("'%s' is a missing but already registered worktree;\nuse '%s -f' to override, or 'prune' or 'remove' to clear"), cmd, path);
 }
 
 static int add_worktree(const char *path, const char *refname,
@@ -318,8 +317,12 @@ static int add_worktree(const char *path, const char *refname,
 	struct commit *commit = NULL;
 	int is_branch = 0;
 	struct strbuf sb_name = STRBUF_INIT;
+	struct worktree **worktrees;
 
-	validate_worktree_add(path, opts);
+	worktrees = get_worktrees(0);
+	check_candidate_path(path, opts->force, worktrees, "add");
+	free_worktrees(worktrees);
+	worktrees = NULL;
 
 	/* is 'refname' a branch or commit? */
 	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
-- 
2.27.0.290.gba653c62da

