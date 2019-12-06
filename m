Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B2FC2BBE2
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B8E24659
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNIafgW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFQIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:08:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39048 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLFQIh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:08:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so7873900wmh.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 08:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=TCQU2DKHEVOPy3Lfp3LqKeXOREm8ZdiIZgF89ow4lDY=;
        b=fNIafgW/1/8Buu9axLO9WpdJRZAL22LDbuj6PkwsGZT7iRBzhtFi5XNY9gp4+Kb+y2
         boENL84Q7mRIfD6vLr68jGUh3XYbZuPiE6wgs/uKXgo3OtUoqb045KJ/jZr8Xlu9ejb+
         pfJ/asabGFR1UE+ZtF34tMqLVjUmXt0G30mgFUVHMnbvWUvrVQ8qDkkJc7Ba3EwbANUN
         ryhXqW1h4Jf2o/fOBmf+uziEQS5Nghy138iqoPjd3YISqzjpdCjq3yOrU3hrKVXcTRgK
         RXtEOE76kr4/BRu9u/it2wefZEtZGl7Qzyljv+ptkxQHymnh0A0K2mt9kl+xcC5n2FqX
         FhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=TCQU2DKHEVOPy3Lfp3LqKeXOREm8ZdiIZgF89ow4lDY=;
        b=j8+x5SYekGYx1z8PBY/JGU5YiaRVvc2CQD2dlSoDYAWaFhVWlDbeHLWo49sY/ouIXD
         701hIXkXp3TFzanVscsLzsXOH5hE4/nvr3jOWIKr87/Y60ckIgnc6dC5oCIRPawtcF/4
         IIO6acRlN70sYpH3fnVcTQsE6NvPxZ3ED0KP7RidupR1HMkp1STauLSGxgp2qEk8b6t+
         p8dxZ1gdm0cAyGSTtABDxIKDQVSbEAlNu8uI5Vzs+tEPO5uli1gC0d2h1AkZhDKwwL0F
         VJF/ayJVpVQLzcbFiTt4S2BUynl5HIdpdbP6xIpHKKQdE8yRzBH+hFwPrwcO3ybU7cRD
         DVCg==
X-Gm-Message-State: APjAAAXiQCtOpbObqsb5li2KSj+IvlSc1OCjbZgq9CePUtioE8DN6WUF
        nWLzoLB4P/L8V1xwiNAR6zn2u0M2
X-Google-Smtp-Source: APXvYqwcSCWh6LfHCXMV6M0mBkhgeod3eO2Hb3dpuCzEXHaPEvWEwpOI2da3gIc+F4EcKMpX9F/cCQ==
X-Received: by 2002:a1c:7910:: with SMTP id l16mr11107195wme.27.1575648515786;
        Fri, 06 Dec 2019 08:08:35 -0800 (PST)
Received: from localhost.localdomain (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id q15sm16649799wrr.11.2019.12.06.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:08:35 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 6/9] commit: encapsulate determine_whence() for sequencer
Date:   Fri,  6 Dec 2019 16:06:11 +0000
Message-Id: <20191206160614.631724-7-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206160614.631724-1-phillip.wood123@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Working out which command wants to create a commit requires detailed
knowledge of the sequencer internals and that knowledge is going to
increase in subsequent commits. With that in mind lets encapsulate that
knowledge in sequencer.c rather than spreading it into builtin/commit.c.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c |  5 +----
 sequencer.c      | 13 ++++++++++++-
 sequencer.h      |  3 ++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3b463522be..d8d4c8e419 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -178,10 +178,7 @@ static void determine_whence(struct wt_status *s)
 {
 	if (file_exists(git_path_merge_head(the_repository)))
 		whence = FROM_MERGE;
-	else if (file_exists(git_path_cherry_pick_head(the_repository)))
-		whence = file_exists(git_path_seq_dir()) ?
-			FROM_CHERRY_PICK_MULTI : FROM_CHERRY_PICK_SINGLE;
-	else
+	else if (!sequencer_determine_whence(the_repository, &whence))
 		whence = FROM_COMMIT;
 	if (s)
 		s->whence = whence;
diff --git a/sequencer.c b/sequencer.c
index 4e0370277b..98e007556c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -40,7 +40,7 @@ static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
 
-GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
+static GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
 
 static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
@@ -5256,3 +5256,14 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 
 	return 0;
 }
+
+int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
+{
+	if (file_exists(git_path_cherry_pick_head(r))) {
+		*whence = file_exists(git_path_seq_dir()) ?
+			FROM_CHERRY_PICK_MULTI : FROM_CHERRY_PICK_SINGLE;
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/sequencer.h b/sequencer.h
index 56881a6baa..8d451dbfcb 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,12 +3,12 @@
 
 #include "cache.h"
 #include "strbuf.h"
+#include "wt-status.h"
 
 struct commit;
 struct repository;
 
 const char *git_path_commit_editmsg(void);
-const char *git_path_seq_dir(void);
 const char *rebase_path_todo(void);
 const char *rebase_path_todo_backup(void);
 
@@ -202,4 +202,5 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 void sequencer_post_commit_cleanup(struct repository *r);
 int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
+int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
 #endif /* SEQUENCER_H */
-- 
2.24.0

