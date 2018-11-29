Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185621F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeK2Lbp (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:45 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:53625 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeK2Lbp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:45 -0500
Received: by mail-qk1-f201.google.com with SMTP id s19so153707qke.20
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IMRG8OwjQ6UrbAD3zjV+niybtLkNnzzjGnwtiwB748Q=;
        b=CQ6BdbOyB6+mdCVQ2QbfdPS4bpEPgbTyScJMtEmV4KVDmqgDNXDfWu9HmWoyUIFDIy
         gXYKlIuxW2W9QeGwh9SlKnH5XwPt4DxtJMqRDk132HblDC7ZFrK+LI6B76wJmxZwsgao
         lCrs2vwmjtdgdYdUB+QWR16452EL53b+kOYm9pHwEMRltchrQwUh939tFC18RPcTB9xH
         XlPN79SQEGHOtfxdtrk/4mkWmFNfDUrx7l/dUSl0DytnKZ6oXdKcPxm1eJzUTL0uP+D6
         q0qtHZ3HdrzavjYBtKN1jlKLvhwTM7YRwdlQpu5Q7NcWyIv8tFcChVomIy5kYvb11H9Y
         S73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IMRG8OwjQ6UrbAD3zjV+niybtLkNnzzjGnwtiwB748Q=;
        b=e/Ei75hUoe+B2RAb3b7XLn7fHem5GsbXjIMUGVZGmYtf/kr7nzrm4du5GfCPeApBSY
         U0GYVg+Cd/fKOYDOUXxYZa2vUx8/Wi+YRDYx+NNQxzFcaS0m5L/fUklg3d7YciJ1X4gW
         xjDi9r0RXbEonv/T0d1QnvC9nt/JPf9eh1tU9pLRvEqpNHPs3Q+JNzpSvnmEkCs3Klzf
         T8HiItyZy704azS37bItaSasnwwPfi5lAaRI4djVpYG5PcbukbXsvxcx/mQXpNgsVAUz
         sbrX+KPgGZeMTEOBDaVZZK7KdITwLK0X7lxejJiguy/x8Kyn89ZBJtEIIDfKUi9qjQSS
         hW8w==
X-Gm-Message-State: AA+aEWZtpOHYLjXknSRO1XvVYqr4/6bJnNg5Dw9PJGC0/0DPCleUkLGm
        faFlMDKMZ6XMxIY32jtrALI33MVDwe81CwB1LrVZLu6Xrz2JdEBlFZRiFElqeWsHbSk1/74zRYv
        gKH2exeM30SqmbRqzw2IeqVZ6fwjRE0CglrZbNZoNDYoB2ClLDJ7dPcSif3au
X-Google-Smtp-Source: AFSGD/XtRyOFV5Q3IgbWJOcWDZol6MXc15XUpyMjtAwgKv/615wyZQEiEBGaobb17rWsY1R2QVV35dB6+Wl3
X-Received: by 2002:a37:6386:: with SMTP id x128mr5021615qkb.43.1543451297517;
 Wed, 28 Nov 2018 16:28:17 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:54 -0800
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
Message-Id: <20181129002756.167615-8-sbeller@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH 7/9] submodule: migrate get_next_submodule to use repository structs
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used to recurse into submodules, even if they were broken having
only an objects directory. The child process executed in the submodule
would fail though if the submodule was broken. This is tested via
"fetching submodule into a broken repository" in t5526.

This patch tightens the check upfront, such that we do not need
to spawn a child process to find out if the submodule is broken.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 56 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0c81aca6f2..77ace5e784 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1253,6 +1253,30 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+static struct repository *get_submodule_repo_for(struct repository *r,
+						 const struct submodule *sub)
+{
+	struct repository *ret = xmalloc(sizeof(*ret));
+
+	if (repo_submodule_init(ret, r, sub)) {
+		/*
+		 * No entry in .gitmodules? Technically not a submodule,
+		 * but historically we supported repositories that happen to be
+		 * in-place where a gitlink is. Keep supporting them.
+		 */
+		struct strbuf gitdir = STRBUF_INIT;
+		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", sub->path);
+		if (repo_init(ret, gitdir.buf, NULL)) {
+			strbuf_release(&gitdir);
+			free(ret);
+			return NULL;
+		}
+		strbuf_release(&gitdir);
+	}
+
+	return ret;
+}
+
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
@@ -1260,12 +1284,11 @@ static int get_next_submodule(struct child_process *cp,
 	struct submodule_parallel_fetch *spf = data;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		struct strbuf submodule_path = STRBUF_INIT;
-		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
-		const char *git_dir, *default_argv;
+		const char *default_argv;
 		const struct submodule *submodule;
+		struct repository *repo;
 		struct submodule default_submodule = SUBMODULE_INIT;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -1300,15 +1323,11 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_repo_worktree_path(&submodule_path, spf->r, "%s", ce->name);
-		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		git_dir = read_gitfile(submodule_git_dir.buf);
-		if (!git_dir)
-			git_dir = submodule_git_dir.buf;
-		if (is_directory(git_dir)) {
+		repo = get_submodule_repo_for(spf->r, submodule);
+		if (repo) {
 			child_process_init(cp);
-			cp->dir = strbuf_detach(&submodule_path, NULL);
+			cp->dir = xstrdup(repo->worktree);
 			prepare_submodule_repo_env(&cp->env_array);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
@@ -1319,10 +1338,23 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_push(&cp->args, default_argv);
 			argv_array_push(&cp->args, "--submodule-prefix");
 			argv_array_push(&cp->args, submodule_prefix.buf);
+
+			repo_clear(repo);
+			free(repo);
 			ret = 1;
+		} else {
+			/*
+			 * An empty directory is normal,
+			 * the submodule is not initialized
+			 */
+			if (S_ISGITLINK(ce->ce_mode) &&
+			    !is_empty_dir(ce->name)) {
+				spf->result = 1;
+				strbuf_addf(err,
+					    _("Could not access submodule '%s'"),
+					    ce->name);
+			}
 		}
-		strbuf_release(&submodule_path);
-		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
-- 
2.20.0.rc1.387.gf8505762e3-goog

