Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF8C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiHUOAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiHUN7l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77B23BD0
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n4so10275185wrp.10
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lyvvF6qI7M7IDR7FeV1qOXZaYpmd3ZeHHnYdmFxqkMQ=;
        b=BEWSF+faNaq2M6zpQUV6yir8a+K+ltZLuIgGZCGTbLUz9iFkwPFdfGAN/tUYwpetHK
         5T3l/ZmilJQQh8XWOmdvR6GY1YBAlS2C7euhw4HWqxv24UeUEoOyGHSC4fnOdQEJkhAE
         l0XLJZj6f64ylarP7uDUCeqkIq4AHdqQeVk7QQTjiPQkxuKwsxSiPG+UbVC7IS39zlnm
         Zy/iTkZXbVxLsK3k5UEAVf3yzaSkD9iiqDYV2m6Tv7DWcia18jI3939oAzJ/0RU5o52c
         boE0+IBLKLiiRyncf0M0fqgprAYFP5MITQzvW8YJoaIYGYz/hEfYyAmVNXDPA3iKZEWo
         VtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lyvvF6qI7M7IDR7FeV1qOXZaYpmd3ZeHHnYdmFxqkMQ=;
        b=FpW/Ha1qSoU0dk6xLi/vTbetv8i45A889iZQ0Fp4upR+lmxfrSexPkFYGshEHfTZl7
         evJlS4BAGc621OjmjNJ/KbX0i648R59aWUoQIZLxfZ9FrqP7cTWSsA5Qrx+d0s8TE9tc
         VnmD5Mi9lfW+NnvzO2kbLAHhaT387eeJHPQTPLRb2+rhJKrF/KNXDBp9RWzoUvhFuANb
         /39EvFJnWnsHpQcCxeeevSZVau0FOX/G9EaiRQMIOFItoaef7uwG+gYNp4gEohA8VLE6
         bvvog8MSrbft0JK+KgJ431CmuBOpsJNkbRK4uOS5qgLggTllR7UUNKjrBeEOVGNWqZ08
         +a1A==
X-Gm-Message-State: ACgBeo3yE9ZgVJSgZlynmHUw88/L7LnxjoNvgzxgN3Vg6JqJrhhrP5QR
        Mk4pu1Bc5R/RskauBgpM9Cg+yGdf6QCCzIix
X-Google-Smtp-Source: AA6agR61YJXWVwQLurSpX3gJDF94mTE23DfP/DwUU571wKt4ZBF2YCye1tMi2cnYEmhS8Eccu3fNqQ==
X-Received: by 2002:a5d:4305:0:b0:225:55ed:9654 with SMTP id h5-20020a5d4305000000b0022555ed9654mr1263536wrq.709.1661090336129;
        Sun, 21 Aug 2022 06:58:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 29/32] submodule--helper: check repo{_submodule,}_init() return values
Date:   Sun, 21 Aug 2022 15:57:38 +0200
Message-Id: <patch-v3-29.32-d4b55f07a30-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
index 5f109d422ea..88fc01320f3 100644
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
index 36a25ae252f..01d88650ba3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -568,8 +568,11 @@ static inline int git_has_dir_sep(const char *path)
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
2.37.2.1279.g64dec4e13cf

