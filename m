Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13BEECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiHaXTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiHaXSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C049C8E5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso452735wmb.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SS7w0G1W7I9X3+yMaX12gVHMTuMHeLtsAhcXqbY58ao=;
        b=VBf0I+zWBRa8W2GZ2zUt8vD5PTKJ7cb1NIs9Re+Z+AuesbhqditKIhRMKzDwXwNFko
         JoSWzP6Fi7bropH/OOd/OtVDTuus3UxCgYbFB23V7++Xs3R8LEThUCFjxxToof5ARKSV
         MON9YpDN/3sd2X1l4xtAcKYYcfTos5EZ+AbJ834Df6NnHq6CWQZ8gKYRXJeImVDsn2xR
         YYfICrddFsG67wbTIMnJvjuu54MqHTIgZOLvYgBnycxwqi5AxCtDAPgsCrQtQ2QdlpY+
         NAeiO9h3LYJzOBQO52fm31YHkuE7H9rXuLH4H/j8766h0tC9xsiYBINQKEgKat8XP3ED
         GgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SS7w0G1W7I9X3+yMaX12gVHMTuMHeLtsAhcXqbY58ao=;
        b=DptB+gPWz7h8FmJRMrW1tecIbd9Kxfb0lnrEJoUJQ7xLqK8NcpuxnE/tomn+O/fcub
         WODugnvo41WYmFWYJGLLPtTgFpP9LGbhU9ghp515ZjdVQSdtDmim3htAOp74OLvSfERI
         NHJUAQc5ujJBO2MXmYX/mC5Sb+WYUNJo5GmKUkQyeqz20K8uf9UwYJgeDVN7E1emSTY/
         Z+Ie2A2RNdzwhWhJUeOGCgpEtL/x0EjJn3mn/ArMBvzUHA7+elfMgL0EajktjuMKDYae
         BfEb1OrEH+6JE9aZYoZa1aEqIw3JZrAABRcCbuix/YVT+vo2+rKWZM3piFKK1GE2XwRx
         VXEg==
X-Gm-Message-State: ACgBeo2fjxGWtwnuCqz8FZeTA9GwAIC9oiRKttnD1XqpsyfND86dZvJG
        UcRNmNFvifVLdXMsQ6CP6HW+2OBnnu00Qg==
X-Google-Smtp-Source: AA6agR5RzoWrkN/TYwHauit1s+hGSqhqpSnO5z7zdT2jlNzOXI5NTgIteW02Ueunv1t3BV7vIfO6Bw==
X-Received: by 2002:a05:600c:a09:b0:3a6:8900:c651 with SMTP id z9-20020a05600c0a0900b003a68900c651mr3290479wmp.145.1661987924407;
        Wed, 31 Aug 2022 16:18:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 30/33] submodule--helper: check repo{_submodule,}_init() return values
Date:   Thu,  1 Sep 2022 01:18:12 +0200
Message-Id: <patch-v4-30.33-ba5c170c3a4-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix code added in ce125d431aa (submodule: extract path to submodule
gitdir func, 2021-09-15) and a77c3fcb5ec (submodule--helper: get
remote names from any repository, 2022-03-04) which failed to check
the return values of repo_init() and repo_submodule_init(). If we
failed to initialize the repository or submodule we could segfault
when trying to access the invalid repository structs.

Let's also check that these were the only such logic errors in the
codebase by making use of the "warn_unused_result" attribute. This is
valid as of GCC 3.4.0 (and clang will catch it via its faking of
__GNUC__ ).

As the comment being added to git-compat-util.h we're piggy-backing on
the LAST_ARG_MUST_BE_NULL version check out of lazyness. See
9fe3edc47f1 (Add the LAST_ARG_MUST_BE_NULL macro, 2013-07-18) for its
addition. The marginal benefit of covering gcc 3.4.0..4.0.0 is
near-zero (or zero) at this point. It mostly matters that we catch
this somewhere.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 9 +++++++--
 git-compat-util.h           | 3 +++
 repository.h                | 3 +++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b99fb7a244e..dfd71f0f2b2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -63,7 +63,10 @@ static char *get_default_remote_submodule(const char *module_path)
 {
 	struct repository subrepo;
 
-	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
+	if (repo_submodule_init(&subrepo, the_repository, module_path,
+				null_oid()) < 0)
+		die(_("could not get a repository handle for submodule '%s'"),
+		    module_path);
 	return repo_get_default_remote(&subrepo);
 }
 
@@ -1483,7 +1486,9 @@ static int add_possible_reference_from_superproject(
 		struct strbuf err = STRBUF_INIT;
 		strbuf_add(&sb, odb->path, len);
 
-		repo_init(&alternate, sb.buf, NULL);
+		if (repo_init(&alternate, sb.buf, NULL) < 0)
+			die(_("could not get a repository handle for gitdir '%s'"),
+			    sb.buf);
 
 		/*
 		 * We need to end the new path with '/' to mark it as a dir,
diff --git a/git-compat-util.h b/git-compat-util.h
index 4e51a1c48bc..7ebae122d40 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -569,8 +569,11 @@ static inline int git_has_dir_sep(const char *path)
 /* The sentinel attribute is valid from gcc version 4.0 */
 #if defined(__GNUC__) && (__GNUC__ >= 4)
 #define LAST_ARG_MUST_BE_NULL __attribute__((sentinel))
+/* warn_unused_result exists as of gcc 3.4.0, but be lazy and check 4.0 */
+#define RESULT_MUST_BE_USED __attribute__ ((warn_unused_result))
 #else
 #define LAST_ARG_MUST_BE_NULL
+#define RESULT_MUST_BE_USED
 #endif
 
 #define MAYBE_UNUSED __attribute__((__unused__))
diff --git a/repository.h b/repository.h
index 797f471cce9..24316ac944e 100644
--- a/repository.h
+++ b/repository.h
@@ -1,6 +1,7 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
+#include "git-compat-util.h"
 #include "path.h"
 
 struct config_set;
@@ -186,6 +187,7 @@ void repo_set_gitdir(struct repository *repo, const char *root,
 void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
 void initialize_the_repository(void);
+RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
 
 /*
@@ -197,6 +199,7 @@ int repo_init(struct repository *r, const char *gitdir, const char *worktree);
  * Return 0 upon success and a non-zero value upon failure.
  */
 struct object_id;
+RESULT_MUST_BE_USED
 int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
 			const char *path,
-- 
2.37.3.1420.g76f8a3d556c

