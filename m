Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1845320D24
	for <e@80x24.org>; Tue, 20 Jun 2017 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdFTTVF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:21:05 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33384 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdFTTUn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:43 -0400
Received: by mail-pg0-f41.google.com with SMTP id f185so66735362pgc.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nD6IbT9uvQ5yOPmz/5VxlyU6gTvDfVww+HTjP71icXc=;
        b=AO6QAbmly/2uhaTAkp3Nhr4fppHbkkAUjRjrrxKGYwwd0pxONxwgk/2VOhKd/6sXSt
         +dbqQ/ISD39tCDfBWYOH7prJ+fjP2pbJQSiCnR7SJX3n8P7Xp03oU838NG++I5bOTy6T
         Z4l2jQcE+81Vlskok/pszSDsFiLsqi/lN8l8aZ1YTage7DSVppSrLx/8wd1anKtstQmL
         pvbeXs1tBVf4RXy8dVN0rsTqUjHPuGQyeLKoCZL27zqB6mW7T4EK0IxZSrHep98iH8kd
         K+imAlSP2Q7jJRFOS3sAOvM1F+FOTXwe8ZjjVkh+w2j37VtSKaUrJL4wGSevsmnHmGVR
         dKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nD6IbT9uvQ5yOPmz/5VxlyU6gTvDfVww+HTjP71icXc=;
        b=J48W3dnU3y6V05GBI9wF9XykEcugw63qbCJd1j3NyaquJlklOq3dPnfSxb91PaUuzO
         QzS0/VWCv3eY0zmL0kiHp7YW4SiiYGrCoagNmlY9ztPdcUfdnGbOO+uwPHRs0MYdPnZS
         6CdhOu/Lz7emo4r/8kSSims3qXS7SCXCs3es0Vsg7nJd1inpUjhUQ2nnOWXiV738MxOL
         VJLN9PNPIYBcTv/N1DibiweWJK6TYn8aKNSmR712/UkGO3TgAeQCyH55219etWCjtLb+
         A6VKO0Ezc9bV/Ms8doxlfYv71mGgEhhpbkx4Mb5F5+ETy9brDMwwiqBbDTO4HJaHJnnh
         EHtg==
X-Gm-Message-State: AKS2vOyxjnNQITHCLwILh8ocH2cojQkq6Hfq4Gx+bPjFyug7vkcBMLJp
        XefntD0EgzMsTZhkMnhG1A==
X-Received: by 10.99.165.14 with SMTP id n14mr9491422pgf.14.1497986442240;
        Tue, 20 Jun 2017 12:20:42 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:41 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 19/20] repository: enable initialization of submodules
Date:   Tue, 20 Jun 2017 12:19:50 -0700
Message-Id: <20170620191951.84791-20-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce 'repo_submodule_init()' which performs initialization of a
'struct repository' as a submodule of another 'struct repository'.

The resulting submodule can be in one of three states:

  1. The submodule is initialized and has a worktree.

  2. The submodule is initialized but does not have a worktree.  This
     would occur when the submodule's gitdir is present in the
     superproject's 'gitdir/modules/' directory yet the submodule has not
     been checked out in superproject's worktree.

  3. The submodule remains uninitialized due to an error in the
     initialization process or there is no matching submodule at the
     provided path in the superproject.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 repository.h | 10 ++++++++++
 2 files changed, 54 insertions(+)

diff --git a/repository.c b/repository.c
index 317041a4a..673b35ca5 100644
--- a/repository.c
+++ b/repository.c
@@ -155,6 +155,48 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	return -1;
 }
 
+/*
+ * Initialize 'submodule' as the submodule given by 'path' in parent repository
+ * 'superproject'.
+ * Return 0 upon success and a non-zero value upon failure.
+ */
+int repo_submodule_init(struct repository *submodule,
+			struct repository *superproject,
+			const char *path)
+{
+	const struct submodule *sub;
+	struct strbuf submodule_path = STRBUF_INIT;
+	int ret = 0;
+
+	sub = submodule_from_cache(superproject, null_sha1, path);
+	if (!sub) {
+		ret = -1;
+		goto out;
+	}
+
+	strbuf_repo_worktree_path(&submodule_path, superproject, "%s", path);
+
+	if (repo_init(submodule, submodule_path.buf, submodule_path.buf)) {
+		strbuf_reset(&submodule_path);
+		strbuf_repo_git_path(&submodule_path, superproject,
+				     "modules/%s", sub->name);
+
+		if (repo_init(submodule, submodule_path.buf, NULL)) {
+			ret = -1;
+			goto out;
+		}
+	}
+
+	submodule->submodule_prefix = xstrfmt("%s%s/",
+					      superproject->submodule_prefix ?
+					      superproject->submodule_prefix :
+					      "", path);
+
+out:
+	strbuf_release(&submodule_path);
+	return ret;
+}
+
 void repo_clear(struct repository *repo)
 {
 	free(repo->gitdir);
@@ -169,6 +211,8 @@ void repo_clear(struct repository *repo)
 	repo->index_file = NULL;
 	free(repo->worktree);
 	repo->worktree = NULL;
+	free(repo->submodule_prefix);
+	repo->submodule_prefix = NULL;
 
 	if (repo->config) {
 		git_configset_clear(repo->config);
diff --git a/repository.h b/repository.h
index 4bc70ebc5..7b352accb 100644
--- a/repository.h
+++ b/repository.h
@@ -25,6 +25,13 @@ struct repository {
 	/* Path to the working directory */
 	char *worktree;
 
+	/*
+	 * Path from the root of the top-level superproject down to this
+	 * repository.  This is only non-NULL if the repository is initialized
+	 * as a submodule of another repository.
+	 */
+	char *submodule_prefix;
+
 	/* Subsystems */
 	/*
 	 * Repository's config which contains key-value pairs from the usual
@@ -59,6 +66,9 @@ extern struct repository *the_repository;
 extern void repo_set_gitdir(struct repository *repo, const char *path);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
+extern int repo_submodule_init(struct repository *submodule,
+			       struct repository *superproject,
+			       const char *path);
 extern void repo_clear(struct repository *repo);
 
 extern int repo_read_index(struct repository *repo);
-- 
2.13.1.611.g7e3b11ae1-goog

