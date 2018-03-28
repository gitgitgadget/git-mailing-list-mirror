Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AFB71F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbeC1R4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:40 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39515 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeC1R4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:56:35 -0400
Received: by mail-lf0-f66.google.com with SMTP id p142-v6so4727437lfd.6
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNKA41YeHbBPLjV5ZZxjpSNtvhkyEie7XC/C/6xtfek=;
        b=K6NvX2yaKPDxsvHVQvY2Z4nArw9DMrsLo0hd/AbB9QeSC7B+RM+70BOrWYZCC/euD1
         GyO2DhfG1D4bT8WldzGYaUP5fh80sfvAJgDP5Kd4L5QOyjdDCzpC3VCjPHW1ET+hFHG4
         53tX1J5S7Vi/682n3SdXssSiFHgu7i+RD0J3TMe2lfTN6cNt2/faUjsLAzIRM83Mr8MK
         8TOZaX6XXAOIaVEgexKrfjzyfAjmKwWjk1VhF1kmvsaFNP5dBYZPowReU6cHSV15TqhJ
         cGTcPBPQ8A2jHhXqsPzTLoApe4JDeDlgbN3mgbuaKOKUDu8HVuLG31EBzSXk07chXhbm
         dxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNKA41YeHbBPLjV5ZZxjpSNtvhkyEie7XC/C/6xtfek=;
        b=j+RhLx32WJHdNppsA023g2zEpHcyCpc1BFalfjVJBrYLKVCaOyRkwlybjE/+0N9sKC
         /aOiQtilSvL0/FibUeqEQFcCZlpZGIyTEkErKPwT7FJOrmvUflD9Wt+5a3OagAbjXo8Y
         NYxGnvQARX0wW/dp2Vkalgh2yaQ7VuMCGfSGwp714WKPbQ2Filh2AoxitORpfui1DfdV
         dnq+BSYkxA/d8pcHiJmbcHHbdDIb22ItR70XcKIlgvRRaHCyVXH8ywsFPHMUWBdIYn12
         wYu+2DAykE6yjkh9aMzcj+gfDeJXIGSOYaa/11YTBOPnjXERtBSQabibdItLawy/R0v7
         x4YA==
X-Gm-Message-State: AElRT7GJtbiL8UhrCB+lEQgKxDybC4C+B6J10e5sSkbbGyTx9AmWSqBv
        gcEeWB/0kODd6Jud+Y8I50HBVg==
X-Google-Smtp-Source: AIpwx490w3PS/LOlhSS+z1Ju0e+1VX9M1ch5wbMYMyaS87cEJ4pGEphcsgo0/rrNCWrU9Shx7jZIew==
X-Received: by 2002:a19:e202:: with SMTP id z2-v6mr3199298lfg.58.1522259792759;
        Wed, 28 Mar 2018 10:56:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s12sm706658ljj.49.2018.03.28.10.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 10:56:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rafael Ascensao <rafa.almas@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 6/8] environment.c: adjust env containing relpath when $CWD is moved
Date:   Wed, 28 Mar 2018 19:55:35 +0200
Message-Id: <20180328175537.17450-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Duy Nguyen <pclouds@gmail.com>

As noted in the previous patch, when $CWD is moved, we recognize the
problem with relative paths and update $GIT_WORK_TREE and $GIT_DIR
with new ones.

We have plenty more environment variables that can contain paths
though. If they are read and cached before setup_work_tree() is
called, nobody will update them and they become bad paths.

Hook into setup_work_tree() and update all those env variables. The
code to update $GIT_WORK_TREE is no longer needed and removed.

Technically we should remove the setenv() in set_git_dir() as well,
but that is also called _not_ by setup_work_tree() and we should keep
the behavior the same in that case for safety. set_git_dir() will be
removed from setup_work_tree() soon, which achieves the same goal.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 environment.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 setup.c       |  7 -------
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/environment.c b/environment.c
index 39b3d906c8..f9dcc1b99e 100644
--- a/environment.c
+++ b/environment.c
@@ -128,6 +128,20 @@ const char * const local_repo_env[] = {
 	NULL
 };
 
+/* A subset of local_repo_env[] that contains path */
+const char * const local_repo_path_env[] = {
+	ALTERNATE_DB_ENVIRONMENT,
+	CONFIG_ENVIRONMENT,
+	DB_ENVIRONMENT,
+	GIT_COMMON_DIR_ENVIRONMENT,
+	GIT_DIR_ENVIRONMENT,
+	GIT_SHALLOW_FILE_ENVIRONMENT,
+	GIT_WORK_TREE_ENVIRONMENT,
+	GRAFT_ENVIRONMENT,
+	INDEX_ENVIRONMENT,
+	NULL
+};
+
 static char *expand_namespace(const char *raw_namespace)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -149,6 +163,32 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
+static void update_path_envs(const char *old_cwd, const char *new_cwd,
+			     void *cb)
+{
+	int i;
+
+	/*
+	 * FIXME: special treatment needed for
+	 * GIT_ALTERNATE_OBJECT_DIRECTORIES because it can contain
+	 * multiple paths.
+	 */
+	for (i = 0; local_repo_path_env[i]; i++) {
+		const char *name = local_repo_path_env[i];
+		const char *value = getenv(name);
+		char *new_value;
+
+		if (!value)
+			continue;
+		if (is_absolute_path(value))
+			continue;
+		new_value = xstrdup(value);
+		setup_adjust_path(name, &new_value, old_cwd, new_cwd);
+		if (setenv(name, new_value, 10))
+			error(_("could not set %s to '%s'"), name, value);
+		free(new_value);
+	}
+}
 /*
  * Wrapper of getenv() that returns a strdup value. This value is kept
  * in argv to be freed later.
@@ -170,6 +210,12 @@ void setup_git_env(const char *git_dir)
 	const char *replace_ref_base;
 	struct set_gitdir_args args = { NULL };
 	struct argv_array to_free = ARGV_ARRAY_INIT;
+	static int added_cwd_callback;
+
+	if (!added_cwd_callback) {
+		add_cwd_update_callback(update_path_envs, NULL);
+		added_cwd_callback = 1;
+	}
 
 	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
 	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
diff --git a/setup.c b/setup.c
index e340ee2130..23b8f89ce2 100644
--- a/setup.c
+++ b/setup.c
@@ -435,13 +435,6 @@ void setup_work_tree(void)
 	if (!work_tree || chdir(work_tree))
 		die(_("this operation must be run in a work tree"));
 
-	/*
-	 * Make sure subsequent git processes find correct worktree
-	 * if $GIT_WORK_TREE is set relative
-	 */
-	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
-		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
-
 	for (i = 0; i < nr_cwd_callbacks; i++)
 		cwd_callbacks[i].fn(old_cwd.buf, work_tree,
 				    cwd_callbacks[i].cb_data);
-- 
2.17.0.rc1.439.gca064e2955

