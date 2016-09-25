Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8E7F1F935
	for <e@80x24.org>; Sun, 25 Sep 2016 03:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935875AbcIYDQS (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 23:16:18 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34493 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754548AbcIYDQR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 23:16:17 -0400
Received: by mail-pa0-f68.google.com with SMTP id i5so3783064pad.1
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 20:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecRjt7uiH0cGCQbXD3RvEVUSQO/k48CXBn/BVL1YNe8=;
        b=de8qW8BofXth/1d6a819Feo/UJJJ9az/LLBBWRapx65r15imLYodVD1BpxrFDYbwLK
         Orxa22M6xdtX+I7Jbf92E/WhingWiEFq5zG+PvBngGt1MSv6GKyZ1MsR8DA8Cp/6nrO2
         gTsD9tMCZhKKzfcokmZgLnmnRG7iyEWTAFBI6JSQh4RdYpIshsK9FbYJQz+7hiNWUWFb
         PhHI8dSl3KBWpoURekYH+4Hu0WpFBnd6bA4TqghogdgY2v1bcdIdLkTsMMpGgAtbv7YB
         t8+6qCwOQ4RdZjdCf8mzzSWL2/3QCw5NqbBqB2/ot8O697Mv/PybA50cnJvwJjV9hRY9
         dVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecRjt7uiH0cGCQbXD3RvEVUSQO/k48CXBn/BVL1YNe8=;
        b=Wj8lyt+elnlOJG7f+mH9I7TaFXrYHLJ2TP7L4XHb4LBDiJ+VkXkRN7JEKiCVHMEnb0
         pZNO5sm9Y4hiJnGRMQkOHGB2afczpWNAmO5Y3XAtke+A8vfXVKRsGvXFFSiSvyNFdc5D
         kQ3/5Z7vmiMjN0CohXIPW7hwWvxD+39oMgY1HC50C55d1NXrczV73BDCLSWtPakgASU6
         N3AIlRbaEb5BLRVehP+ENVYEoUIDZqr/n5a1kBlhv6UhZHCBR2zxtkhnrxZ8uZbvvbxg
         PfxW+eV8/P75eJ75h1J04nke6ToIGGGX8UapXQlwZZDl+1ba4gDFcylATxwfsgfbQsIt
         k/cA==
X-Gm-Message-State: AE9vXwOxUFJD/e6CBdNLmk6rkpvBSBzRM2QSG+9pW9dTww0OvbvvaVXaLMw0a2LT54IcLg==
X-Received: by 10.66.16.38 with SMTP id c6mr26242361pad.64.1474773376241;
        Sat, 24 Sep 2016 20:16:16 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id x9sm21231358pff.19.2016.09.24.20.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 20:16:15 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Sep 2016 10:16:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 2/5] init: call set_git_dir_init() from within init_db()
Date:   Sun, 25 Sep 2016 10:14:37 +0700
Message-Id: <20160925031440.10435-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160925031440.10435-1-pclouds@gmail.com>
References: <20160925031329.GA9124@ash>
 <20160925031440.10435-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next commit requires that set_git_dir_init() must be called before
init_db(). Let's make sure nobody can do otherwise.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clone.c   | 15 +++++++--------
 builtin/init-db.c | 18 +++++++++++-------
 cache.h           |  5 +++--
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 6616392..29b1832 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -928,23 +928,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		set_git_work_tree(work_tree);
 	}
 
-	junk_git_dir = git_dir;
+	junk_git_dir = real_git_dir ? real_git_dir : git_dir;
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die(_("could not create leading directories of '%s'"), git_dir);
 
-	set_git_dir_init(git_dir, real_git_dir, 0);
-	if (real_git_dir) {
-		git_dir = real_git_dir;
-		junk_git_dir = real_git_dir;
-	}
-
 	if (0 <= option_verbosity) {
 		if (option_bare)
 			fprintf(stderr, _("Cloning into bare repository '%s'...\n"), dir);
 		else
 			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
 	}
-	init_db(option_template, INIT_DB_QUIET);
+
+	init_db(git_dir, real_git_dir, option_template, INIT_DB_QUIET);
+
+	if (real_git_dir)
+		git_dir = real_git_dir;
+
 	write_config(&option_config);
 
 	git_config(git_default_config, NULL);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index d5d7558..5cb05d9 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -311,8 +311,9 @@ static void create_object_directory(void)
 	strbuf_release(&path);
 }
 
-int set_git_dir_init(const char *git_dir, const char *real_git_dir,
-		     int exist_ok)
+static int set_git_dir_init(const char *git_dir,
+			    const char *real_git_dir,
+			    int exist_ok)
 {
 	if (real_git_dir) {
 		struct stat st;
@@ -359,10 +360,14 @@ static void separate_git_dir(const char *git_dir)
 	write_file(git_link, "gitdir: %s", git_dir);
 }
 
-int init_db(const char *template_dir, unsigned int flags)
+int init_db(const char *git_dir, const char *real_git_dir,
+	    const char *template_dir, unsigned int flags)
 {
 	int reinit;
-	const char *git_dir = get_git_dir();
+
+	set_git_dir_init(git_dir, real_git_dir, flags & INIT_DB_EXIST_OK);
+
+	git_dir = get_git_dir();
 
 	if (git_link)
 		separate_git_dir(git_dir);
@@ -582,7 +587,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			set_git_work_tree(work_tree);
 	}
 
-	set_git_dir_init(git_dir, real_git_dir, 1);
-
-	return init_db(template_dir, flags);
+	flags |= INIT_DB_EXIST_OK;
+	return init_db(git_dir, real_git_dir, template_dir, flags);
 }
diff --git a/cache.h b/cache.h
index b2d77f3..7fc875f 100644
--- a/cache.h
+++ b/cache.h
@@ -525,9 +525,10 @@ extern void verify_non_filename(const char *prefix, const char *name);
 extern int path_inside_repo(const char *prefix, const char *path);
 
 #define INIT_DB_QUIET 0x0001
+#define INIT_DB_EXIST_OK 0x0002
 
-extern int set_git_dir_init(const char *git_dir, const char *real_git_dir, int);
-extern int init_db(const char *template_dir, unsigned int flags);
+extern int init_db(const char *git_dir, const char *real_git_dir,
+		   const char *template_dir, unsigned int flags);
 
 extern void sanitize_stdfds(void);
 extern int daemonize(void);
-- 
2.8.2.524.g6ff3d78

