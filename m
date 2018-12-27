Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E518A211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 15:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeL0P4Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 10:56:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33227 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeL0P4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 10:56:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so16624374ljd.0
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 07:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZ0Ofw8sweD/19NW/wZFG0bPF1tm+6oPRGzNIZ2chJY=;
        b=UKMRChEEAJhxV1GbCv50jiSNax2ysC2tGqmvXAcknknoP8mGV9bMLdnNcfkMy/UnuV
         +F+Dcu+gke/bQlTxya0QNe5GsDwXHIbVcV94h6yM4NPPTQ7gUbO96oCo9cGelHvL6Bux
         mmHZ3V2Zwsa4hlcqj7BwhYheWFtK3TZ1qIwniNjV30aCI/em9qcXkA7LAnCEGHdefd7V
         62fpSAU/ncFSsF0BWArLlArk+viX0Pb6zHkcIjjM6OEGhTeOUdtALEoANih7kj89sUsa
         sQhbFtu41DtT4CW6E21sts7aiccEtjJKOVCIsQLAda4EfVI0O1JMBQPqMw8XP9xEjW0q
         iXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZ0Ofw8sweD/19NW/wZFG0bPF1tm+6oPRGzNIZ2chJY=;
        b=BXucd2t1GCWkyTr2AlLljhsbKjhyphz6aBYXbUD82SOw5PIPyeT7AcGJQhZ6OsDuWY
         8t4lp2KVDR/uNPGg1zRZR11sKdoefDYvq0aqOJUrwTjnUDgmyqjyNkBY6J/Eviyn05or
         xro/yFVKqxqBVWO1eKm9yec6lfR59gkGQn+lLdDhaaikh51NYtTinmoL37ipmdKeRslC
         j7+1Tq7vTfK9gtNZjk7SBjY8oDjgcfPW9tMfM7IGiS8VQzLEJJQSgs90MP1///LPd8L0
         yIVuJKESLg2poQ1Drz/9BWWwHCn6By3nmaL0Q5A+4FRLfB/G+RPNnzAumSCxBy+h2EWX
         1y2Q==
X-Gm-Message-State: AJcUukfGNu2gQ8YeIQhm9nT5LEt+7vwDLMz02R38gxfooUz7rN8ktcGJ
        H1gjbXZ3tb1DO8X4KCRDBJ9yHTCe
X-Google-Smtp-Source: ALg8bN6W/I6/Sd7fm2CldcmAA96AiRrMndjaw+ZX0pb2dKNP3DZ7NXL8TA8T+XYQqMwkw0fA6JtLuA==
X-Received: by 2002:a2e:3a04:: with SMTP id h4-v6mr13739773lja.81.1545926182132;
        Thu, 27 Dec 2018 07:56:22 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id p77-v6sm9095367lja.0.2018.12.27.07.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 07:56:21 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/6] config.c: avoid git_path() in do_git_config_sequence()
Date:   Thu, 27 Dec 2018 16:56:06 +0100
Message-Id: <20181227155611.10585-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227155611.10585-1-pclouds@gmail.com>
References: <20181227155611.10585-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function has both $GIT_COMMON_DIR and $GIT_DIR in "opts". Use it
to construct config.worktree path instead because git_pathdup() is
tied to the current worktree, but the given $GIT_DIR could be from
another one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index ff521eb27a..79fbe65da8 100644
--- a/config.c
+++ b/config.c
@@ -1665,6 +1665,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig", 0);
 	char *repo_config;
+	char *worktree_config;
 
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
@@ -1672,6 +1673,10 @@ static int do_git_config_sequence(const struct config_options *opts,
 		BUG("git_dir without commondir");
 	else
 		repo_config = NULL;
+	if (repository_format_worktree_config)
+		worktree_config = mkpathdup("%s/config.worktree", opts->git_dir);
+	else
+		worktree_config = NULL;
 
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
@@ -1693,12 +1698,8 @@ static int do_git_config_sequence(const struct config_options *opts,
 	 * Note: this should have a new scope, CONFIG_SCOPE_WORKTREE.
 	 * But let's not complicate things before it's actually needed.
 	 */
-	if (repository_format_worktree_config) {
-		char *path = git_pathdup("config.worktree");
-		if (!access_or_die(path, R_OK, 0))
-			ret += git_config_from_file(fn, path, data);
-		free(path);
-	}
+	if (worktree_config && !access_or_die(worktree_config, R_OK, 0))
+		ret += git_config_from_file(fn, worktree_config, data);
 
 	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
 	if (git_config_from_parameters(fn, data) < 0)
@@ -1708,6 +1709,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	free(xdg_config);
 	free(user_config);
 	free(repo_config);
+	free(worktree_config);
 	return ret;
 }
 
-- 
2.20.0.482.g66447595a7

