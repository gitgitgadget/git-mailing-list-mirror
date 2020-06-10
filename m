Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE07C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC4020760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxRDf897"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFJGcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgFJGcE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 02:32:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7D6C03E96B
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 23:32:04 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id c8so916739iob.6
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 23:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+xcHyuPhg6SK//5Suj/L9/GdfySTIIoSEgRhmG8Ea8=;
        b=FxRDf897A86xnu6Lb1e0lIkanJzN3ls+Q/Pp6IqTv8WtCwYVOO2vRh75jenG9bzr0/
         /H+AN/cMie9i48Dl0pc6f0mIip14NqXXDe9JC+q+x+FdjQs5HEA7nykpchir9Mu8NcI8
         t77stvsNbtI3x93RN3+rU3POfPCYxgm5IDStl9gPo16LFGZrtQSHhUpzeKKvK4EhJKQX
         TdIKWRIaoZA2qnw9I8f8qbojWW68xekdqcO7ucRYRFrOv2JO+urkJhRWb+w8thjQGmUp
         c6xrB37s+ZNzHxdcmoxHOPMutMUl4YswQN9yVDzxGVlgW9qsSi5pzVz2GGt2YxQEOXID
         jg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t+xcHyuPhg6SK//5Suj/L9/GdfySTIIoSEgRhmG8Ea8=;
        b=hAafd5iOG3ld+cksJgchRG1unOEj5/J8aJMkbqFomgIJnZFRr6b2Kfq1EzArNo6ndA
         f68OZrZak+WiRWMLi7LhG0LXS8XA+Qeg25jf1wKazOOiVXm4cEwdhk4zZ7zV5tPCr8bZ
         NAgv7o6VJvtlloZcLwJIOUudexJ9H+XHlveFFtQFcvdMKi4eO0TQyOioNrNeg4JcXNn1
         hYTwJ6Pu5VNilSkhoj46yUO2x1nsy2GZrFrpCVY0a69WKDyjjAdklYKWwfcZgTRD8Yze
         r5HxyBtMvY6B0/2fL0bRqW58wSw1/fonI9LWnnrWR0CNWkDmnzAQyado3r/0rTzjPG/O
         iigg==
X-Gm-Message-State: AOAM5332gpEOcFcn6r9lJTvf9GdH2i0TkQSd8nLyifl/qhpyfbKyq8L+
        4VtqXt3xMmRwndEk1fJ5cPcnoS6elZg=
X-Google-Smtp-Source: ABdhPJxsZm22a6wu9+QoFM/5Qw97PjocsxKXbadGGsdDTcM4jrYWkRubCCfAClgQO9sZD8Qqzc77LQ==
X-Received: by 2002:a02:810:: with SMTP id 16mr1755095jac.17.1591770723009;
        Tue, 09 Jun 2020 23:32:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id f22sm8497868iob.18.2020.06.09.23.32.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:32:02 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/7] worktree: generalize candidate worktree path validation
Date:   Wed, 10 Jun 2020 02:30:48 -0400
Message-Id: <20200610063049.74666-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200610063049.74666-1-sunshine@sunshineco.com>
References: <20200610063049.74666-1-sunshine@sunshineco.com>
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
index 350108eba0..8fcf3f38fb 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -280,34 +280,33 @@ static const char *worktree_basename(const char *path, int *olen)
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
@@ -324,8 +323,12 @@ static int add_worktree(const char *path, const char *refname,
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
2.27.0.90.gabb59f83a2

