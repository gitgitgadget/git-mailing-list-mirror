Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56217C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 02:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243826AbiBBChp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 21:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiBBChm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 21:37:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9A7C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 18:37:42 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v13so35473228wrv.10
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 18:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d9k6H4wsEoq0GmByUI0p7NXqXRYaCSz94mZMecym4D0=;
        b=WSNw1iGT04MycFc8GqZOkC67qzRMnbwNav5BJOpyvPdF3RPB+6NDpfuwVeitvpFyot
         Q+6OQWv5AUMC4Jcmc75+9UUtXUaBtkt5mo9Pp/NF7TCb2h8POcD6YBFUSEuHwriGh0Ji
         XhuScyIuXHkDcUN5ysAEmtxGmP/7oTmOt3Zl7bmY4+7EiCwkSJ6lOUCP77bJFSRk2dch
         dmyxR3thUzupOhjqZn0hY5xuyR+Mcgn9mBZ+zxyHlnFq08T4LVEyBISeUBfpzYENF4u7
         BexB7CXU4z/ksohOk1AmOW6PC7jPSiTWpD1mu07FyBy3gz1NsO5gDEa+8jCf72pjFmTJ
         sfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d9k6H4wsEoq0GmByUI0p7NXqXRYaCSz94mZMecym4D0=;
        b=lsCwRbGa4Wq0YRtC5rYn05VEpEtPzWu+tGdRmZeqiqkqgI+lbu2p6ClewayFxQQXxZ
         Mrz4+jt5rskU/kkee2gypJZ4aSot0JJnoO/Kt8RVvxUw4Nt0YZw6VkHiXpvoLP3AcovS
         nbT/IRM60NKbKuPjSDYcbY30JbZbMiC8zZGKlEHAQHWV0Fz/iwFElsnZkpiyedJvIkVZ
         bSI1zT5dR5kqdJO7iqH1jKcfOeKenVXKiMCT7F5Xo2zWYcMj3JSoW+HJ646PWXZWi1Z0
         C/lrSPy/xHXIO/0v3AaG7j7ubTvgUEEKS/d12kYNjB0jXSYwNPGWti5ejL4x+lmQ03Au
         aRVg==
X-Gm-Message-State: AOAM531WQ7WAYUpZ8xZa1XhXpngqf35SO/EwThzVqGza45ZbUikan1me
        46Ugv1oErQt1sg+XaNAWI/PVO8CXRto=
X-Google-Smtp-Source: ABdhPJz01LiMOPHCqJ0j53+r+zmiOKM44w/EFGfecY7LUVayqZjPZQluvr5QLG+2GNuqb7ieHMb2/Q==
X-Received: by 2002:adf:dc44:: with SMTP id m4mr23868707wrj.355.1643769460867;
        Tue, 01 Feb 2022 18:37:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17sm15715939wrm.62.2022.02.01.18.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 18:37:40 -0800 (PST)
Message-Id: <ed0d60de24cf2538af3880f014fd5e10bd0275c1.1643769457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
References: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
        <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 02:37:29 +0000
Subject: [PATCH v5 02/10] log: clean unneeded objects during `log
 --remerge-diff`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The --remerge-diff option will need to create new blobs and trees
representing the "automatic merge" state.  If one is traversing a
long project history, one can easily get hundreds of thousands of
loose objects generated during `log --remerge-diff`.  However, none of
those loose objects are needed after we have completed our diff
operation; they can be summarily deleted.

Add a new helper function to tmp_objdir to discard all the contained
objects, and call it after each merge is handled.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/log.c | 13 +++++++------
 log-tree.c    |  8 +++++++-
 revision.h    |  3 +++
 tmp-objdir.c  |  5 +++++
 tmp-objdir.h  |  6 ++++++
 5 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 846ba0f995a..ac550e1ae62 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -407,13 +407,12 @@ static int cmd_log_walk(struct rev_info *rev)
 	struct commit *commit;
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
-	struct tmp_objdir *remerge_objdir = NULL;
 
 	if (rev->remerge_diff) {
-		remerge_objdir = tmp_objdir_create("remerge-diff");
-		if (!remerge_objdir)
+		rev->remerge_objdir = tmp_objdir_create("remerge-diff");
+		if (!rev->remerge_objdir)
 			die(_("unable to create temporary object directory"));
-		tmp_objdir_replace_primary_odb(remerge_objdir, 1);
+		tmp_objdir_replace_primary_odb(rev->remerge_objdir, 1);
 	}
 
 	if (rev->early_output)
@@ -458,8 +457,10 @@ static int cmd_log_walk(struct rev_info *rev)
 	rev->diffopt.no_free = 0;
 	diff_free(&rev->diffopt);
 
-	if (rev->remerge_diff)
-		tmp_objdir_destroy(remerge_objdir);
+	if (rev->remerge_diff) {
+		tmp_objdir_destroy(rev->remerge_objdir);
+		rev->remerge_objdir = NULL;
+	}
 
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    rev->diffopt.flags.check_failed) {
diff --git a/log-tree.c b/log-tree.c
index 84ed864fc81..89da7de5dbf 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "object-store.h"
 #include "repository.h"
+#include "tmp-objdir.h"
 #include "commit.h"
 #include "tag.h"
 #include "graph.h"
@@ -944,7 +945,12 @@ static int do_remerge_diff(struct rev_info *opt,
 	strbuf_release(&parent1_desc);
 	strbuf_release(&parent2_desc);
 	merge_finalize(&o, &res);
-	/* TODO: clean up the temporary object directory */
+
+	/* Clean up the contents of the temporary object directory */
+	if (opt->remerge_objdir)
+		tmp_objdir_discard_objects(opt->remerge_objdir);
+	else
+		BUG("did a remerge diff without remerge_objdir?!?");
 
 	return !opt->loginfo;
 }
diff --git a/revision.h b/revision.h
index 13178e6b8f3..44efce3f410 100644
--- a/revision.h
+++ b/revision.h
@@ -318,6 +318,9 @@ struct rev_info {
 
 	/* misc. flags related to '--no-kept-objects' */
 	unsigned keep_pack_cache_flags;
+
+	/* Location where temporary objects for remerge-diff are written. */
+	struct tmp_objdir *remerge_objdir;
 };
 
 int ref_excluded(struct string_list *, const char *path);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 3d38eeab66b..adf6033549e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -79,6 +79,11 @@ static void remove_tmp_objdir_on_signal(int signo)
 	raise(signo);
 }
 
+void tmp_objdir_discard_objects(struct tmp_objdir *t)
+{
+	remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
+}
+
 /*
  * These env_* functions are for setting up the child environment; the
  * "replace" variant overrides the value of any existing variable with that
diff --git a/tmp-objdir.h b/tmp-objdir.h
index cda5ec76778..76efc7edee5 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -46,6 +46,12 @@ int tmp_objdir_migrate(struct tmp_objdir *);
  */
 int tmp_objdir_destroy(struct tmp_objdir *);
 
+/*
+ * Remove all objects from the temporary object directory, while leaving it
+ * around so more objects can be added.
+ */
+void tmp_objdir_discard_objects(struct tmp_objdir *);
+
 /*
  * Add the temporary object directory as an alternate object store in the
  * current process.
-- 
gitgitgadget

