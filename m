Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D5C1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 22:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbcLSWA0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 17:00:26 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:35744 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbcLSWAY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 17:00:24 -0500
Received: by mail-it0-f46.google.com with SMTP id c20so69160009itb.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 14:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WtQAhifFMlqp3EMoy0eFAOX650ppB09qq/EqwrOcwnw=;
        b=RfYv9KuF6Yi6NWCHl+ODnD1pZ5U8VkQYmeWtZDwXFALCf2EOCJBMLxkBtztKnXkU7d
         pLoo4frTXAIJiMQZgFvFVnWMG0gMOzVCurU5o2Espgbdcu2ucRNBkbDh7ulUv241oP/7
         Qw8SPGTfW39zQjoQ3M50CmQ9qTUmgN75qxoeV6zwdjxUaTVHf8XFaBtZBYp4A2dASjJS
         SlYjtL4R/cuISFwPQwSv3b3uXOLYX40PpTiJv2k1OmprNEbANkOWpXuTpmQqmz6CbO/3
         J/c/aZZyIOoeAOQnCY78Xd4lXb62gKGq71J2PYcIvuYt9sE1z0a9h1Uaq05uTJuPn+nA
         g89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WtQAhifFMlqp3EMoy0eFAOX650ppB09qq/EqwrOcwnw=;
        b=WhIqxE6EmUAuOoYycftOgRh+504mDtNEQRV7a9IXZkvob3zALB9DmQjq2R54W3S1ud
         nBH9w/A/njw2W06lPgabwu/GuEwPYWsYS1SibL+rdZVAu6oYMBMUWRoDh8qrepHeZzHU
         xfAlAVEEyDRW/oXDGLcRj7k2Mnli/S0Yt+HsbZIcqdnkT1qpOVstyXPrIEXCsh4Q/Jj9
         tjzYZOGGvsF0dHwbEiU7wQ5bzdAPlk1ydyM0MSP/cYc2agKDJxpZPB2MNbAmN7VYLo1C
         bsWM16+9zDvB3P/WRlpvAn19XNPIfZhpgQDR97BGSxGOxavpPQ53rV/GofKpD1sPuKMA
         +KEg==
X-Gm-Message-State: AKaTC00INToN5iwHPEBZgSKvg9XjSFDb/6cHvltC5R/gtmisLJ2qp37RBmfC3lWdYOW0b1r/
X-Received: by 10.36.13.82 with SMTP id 79mr18510639itx.66.1482184818193;
        Mon, 19 Dec 2016 14:00:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2c2e:3e21:f7c2:2ccc])
        by smtp.gmail.com with ESMTPSA id v74sm9049760ioi.2.2016.12.19.14.00.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 14:00:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] dir.c: split up connect_work_tree_and_git_dir
Date:   Mon, 19 Dec 2016 13:57:08 -0800
Message-Id: <20161219215709.24620-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161219215709.24620-1-sbeller@google.com>
References: <20161219215709.24620-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to treat the failures of each of the two steps
differently, so split them up first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 dir.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index d872cc1570..b2cb23fe88 100644
--- a/dir.c
+++ b/dir.c
@@ -2749,27 +2749,41 @@ void untracked_cache_add_to_index(struct index_state *istate,
 	untracked_cache_invalidate_path(istate, path);
 }
 
-/* Update gitfile and core.worktree setting to connect work tree and git dir */
-void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
+static void point_gitlink_file_to(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	char *git_dir = xstrdup(real_path(git_dir_));
-	char *work_tree = xstrdup(real_path(work_tree_));
 
-	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
 		   relative_path(git_dir, work_tree, &rel_path));
 
-	/* Update core.worktree setting */
-	strbuf_reset(&file_name);
+	strbuf_release(&file_name);
+	strbuf_release(&rel_path);
+}
+
+static void set_core_work_tree_to_connect(const char *work_tree, const char *git_dir)
+{
+	struct strbuf file_name = STRBUF_INIT;
+	struct strbuf rel_path = STRBUF_INIT;
+
 	strbuf_addf(&file_name, "%s/config", git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
 			       relative_path(work_tree, git_dir, &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
+}
+
+/* Update gitfile and core.worktree setting to connect work tree and git dir */
+void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
+{
+	char *git_dir = xstrdup(real_path(git_dir_));
+	char *work_tree = xstrdup(real_path(work_tree_));
+
+	point_gitlink_file_to(work_tree, git_dir);
+	set_core_work_tree_to_connect(work_tree, git_dir);
+
 	free(work_tree);
 	free(git_dir);
 }
-- 
2.11.0.rc2.53.gb7b3fba.dirty

