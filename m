Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 514B41FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbdFVSog (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:36 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36019 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753692AbdFVSof (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:35 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so12536485pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1TzkVPDD36NK0XDZjEaO54xVsqHbRV4reFOsr96B2s=;
        b=onvFRY5bRSoGslOdN63NK7ev+xaY34cNBkYS5i0/sllZ0WdaUs73TuANe3DfDT2nLu
         vGi/K74xjnOOjrrjkctE+Pt9o2VCWfHooQXGOySw4lZBkizpYqCnIV0wdTsuDLYstrrg
         L3jFXo60uCeDV3eVEGCjLtdDXmDWTla/NhSQOcvE7oAibVjF7KIsUizZ3KepIPGhfjAr
         lcCzVnYQPAFzk37bpDCqFpSbG6yD0nVZRkJQYM9MtLMinFGFSr6DXP7EccJRZbDcHvc6
         KjNp7mnsbJxU5Oau7VazoZC6g8pcUi2vcH7SKxJ+vJmSXLufhQKm14QqQR2I2X3RUbot
         khfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r1TzkVPDD36NK0XDZjEaO54xVsqHbRV4reFOsr96B2s=;
        b=mOOCkiT+pd8j6YhBiSk3MFVoR2GitU01pbd+DVyiFDYQIC+En7rLA9BxxVFSevEnOj
         52271AWJ75v2FkutY8v780TKutEHsvIJSR1PujdaKpD6IpUe0PtW5P7eijCvIJXwXiUS
         RgijduH3d/t12bfLxgPuCNT1i7ZOKYfxK9K0kny1kdyVz7VDdhU//fxyyRUqPotYzrVd
         8l/R+pMYOWEZ1BXywITTl+7Y9eUQU6Vn4dvyKFjwOtXEJneZahHSyLqikfcAzT4GhdMl
         XFeiUKgCwn5mYp/4YF5FrDAZjBXWBys+VDaU8l7UxB68GwM00t50SzrjaazB8thmHGcN
         XQ7Q==
X-Gm-Message-State: AKS2vOzv4yLvSHj8OG6skgFZ5Fabx3S9mRJivThLaXLbPS14bDEh0z3L
        3e6PQPnFVzQtDgYkuGCldA==
X-Received: by 10.84.198.35 with SMTP id o32mr4497464pld.194.1498157073949;
        Thu, 22 Jun 2017 11:44:33 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:32 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 19/20] repository: enable initialization of submodules
Date:   Thu, 22 Jun 2017 11:43:47 -0700
Message-Id: <20170622184348.56497-20-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce 'repo_submodule_init()' which performs initialization of a
'struct repository' as a submodule of another 'struct repository'.

The resulting submodule 'struct repository' can be in one of three states:

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
 repository.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 repository.h | 10 ++++++++++
 2 files changed, 64 insertions(+)

diff --git a/repository.c b/repository.c
index 358c17517..edca90740 100644
--- a/repository.c
+++ b/repository.c
@@ -144,6 +144,58 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
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
+	struct strbuf gitdir = STRBUF_INIT;
+	struct strbuf worktree = STRBUF_INIT;
+	int ret = 0;
+
+	sub = submodule_from_cache(superproject, null_sha1, path);
+	if (!sub) {
+		ret = -1;
+		goto out;
+	}
+
+	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", path);
+	strbuf_repo_worktree_path(&worktree, superproject, "%s", path);
+
+	if (repo_init(submodule, gitdir.buf, worktree.buf)) {
+		/*
+		 * If initilization fails then it may be due to the submodule
+		 * not being populated in the superproject's worktree.  Instead
+		 * we can try to initilize the submodule by finding it's gitdir
+		 * in the superproject's 'modules' directory.  In this case the
+		 * submodule would not have a worktree.
+		 */
+		strbuf_reset(&gitdir);
+		strbuf_repo_git_path(&gitdir, superproject,
+				     "modules/%s", sub->name);
+
+		if (repo_init(submodule, gitdir.buf, NULL)) {
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
+	strbuf_release(&gitdir);
+	strbuf_release(&worktree);
+	return ret;
+}
+
 void repo_clear(struct repository *repo)
 {
 	free(repo->gitdir);
@@ -158,6 +210,8 @@ void repo_clear(struct repository *repo)
 	repo->index_file = NULL;
 	free(repo->worktree);
 	repo->worktree = NULL;
+	free(repo->submodule_prefix);
+	repo->submodule_prefix = NULL;
 
 	if (repo->config) {
 		git_configset_clear(repo->config);
diff --git a/repository.h b/repository.h
index c40738ceb..417787f3e 100644
--- a/repository.h
+++ b/repository.h
@@ -43,6 +43,13 @@ struct repository {
 	 */
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
@@ -80,6 +87,9 @@ extern struct repository *the_repository;
 extern void repo_set_gitdir(struct repository *repo, const char *path);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
+extern int repo_submodule_init(struct repository *submodule,
+			       struct repository *superproject,
+			       const char *path);
 extern void repo_clear(struct repository *repo);
 
 extern int repo_read_index(struct repository *repo);
-- 
2.13.1.704.gde00cce3c-goog

