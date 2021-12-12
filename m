Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A1C433FE
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhLLUOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:37 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50924 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhLLUOg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:36 -0500
Received: by mail-wm1-f46.google.com with SMTP id 133so10640289wme.0
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7XuiZUdaAbPAZqdAqO4dXdWjSE3/wX8lirOgZI/+8Tw=;
        b=mPNqVHlVYYlGdSmBcm91nJeOLkRvhkTdDsATJBbtLIAfvuJJ5KZTC0K+guM3p85yNN
         +D1xXGsPjSqwSP9t1vLkg85BnU0tsSgx74/vtuCZ5Sg1sUh6CaUzbB/OolMj5lzl0oBs
         euxCtvvGPzEXd9SPaS7Wf+xGEtXGFOV3Dk6ibANM8W9Gv3lVKlwGFEjnnvIoDNl3DA4s
         vUQsjfR6WKjPdxYl2Z3IYtyEYf+8wNH5cIWu3PHqNqrzXBjB7Xhyp6h9IwMzko7sHH62
         P5NcJ3ugElBiWTj+yQlrzjeB/YdyTCp4zfMvqAFz9gPDjC0Kyv8VfML911ytKRfBCDYw
         bNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7XuiZUdaAbPAZqdAqO4dXdWjSE3/wX8lirOgZI/+8Tw=;
        b=i0KwJCPgqwil57gd8giix49lV1gyrTawrqyFP0Z/kBHdTRGYjF6jcLw2dkIYlmbnIj
         +T4mInXoTOwV6ZpJa+RilNyDvh6D5BMJVkaYmVwolMfoBeU18VqvDs+c7G50RtYgVS8d
         f7G1T39ZAci5X9tpRnUikg00IXaGZkvdP1e5AyF15MDzJD9tkt5vAwFdEP103FZM9RED
         ZbvJ57cCL/hsbweHudJm9m/LQVg3k4LCnq3ddP8QOss3MpUVyGoYaEFmH4/OrQk4UwcH
         3i79xj8q2TlKWM5U+IIvutxumZZBZ3LgejZnpLyqfKo2MQc5bk9KnXH4jakiBGe7dsMm
         2bng==
X-Gm-Message-State: AOAM5312pxcdircJ/n8PcaU9jIuye2Xfqyt/oTyGkgyTjqBWlTkKJ+6s
        fJGitY7V2YeeIw978UsG0uQblN8B1SKytg==
X-Google-Smtp-Source: ABdhPJz2ZKT+8zXsnx4YoyAEh4e0tDCe0L1sdV1LW1W6UuATpfRKf55rycc9WxAytOWw+Hwn2pOQVw==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr32167880wmh.107.1639340014748;
        Sun, 12 Dec 2021 12:13:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/13] init: split out template population from create_default_files()
Date:   Sun, 12 Dec 2021 21:13:12 +0100
Message-Id: <patch-02.13-ef2b67768cf-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The create_default_files() function only has one caller,
init_db(). Let's have it call a separate create_template_files()
function.

This refactoring changes nothing about how the repository is
initialized, but makes subsequent changes to create_template_files()
easier to read, e.g. because new variables we'll need will be scoped
to that function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/init-db.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2167796ff2a..3cf834eddd2 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -187,21 +187,9 @@ void initialize_repository_version(int hash_algo, int reinit)
 		git_config_set_gently("extensions.objectformat", NULL);
 }
 
-static int create_default_files(const char *template_path,
-				const char *original_git_dir,
-				const char *initial_branch,
-				const struct repository_format *fmt,
-				int quiet)
+static void create_template_files(const char *template_path)
 {
-	struct stat st1;
-	struct strbuf buf = STRBUF_INIT;
-	char *path;
-	char junk[2];
-	int reinit;
-	int filemode;
-	struct strbuf err = STRBUF_INIT;
 	const char *init_template_dir = NULL;
-	const char *work_tree = get_git_work_tree();
 
 	/*
 	 * First copy the templates -- we might have the default
@@ -218,6 +206,21 @@ static int create_default_files(const char *template_path,
 	git_config_clear();
 	reset_shared_repository();
 	git_config(git_default_config, NULL);
+}
+
+static int create_default_files(const char *original_git_dir,
+				const char *initial_branch,
+				const struct repository_format *fmt,
+				int quiet)
+{
+	struct stat st1;
+	struct strbuf buf = STRBUF_INIT;
+	char *path;
+	char junk[2];
+	int reinit;
+	int filemode;
+	struct strbuf err = STRBUF_INIT;
+	const char *work_tree = get_git_work_tree();
 
 	/*
 	 * We must make sure command-line options continue to override any
@@ -425,7 +428,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
-	reinit = create_default_files(template_dir, original_git_dir,
+	create_template_files(template_dir);
+	reinit = create_default_files(original_git_dir,
 				      initial_branch, &repo_fmt,
 				      flags & INIT_DB_QUIET);
 	if (reinit && initial_branch)
-- 
2.34.1.1020.gb1392dd1877

