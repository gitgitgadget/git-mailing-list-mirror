Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C0CC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbhL3XgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242352AbhL3XgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:36:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E1C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so53145529wrw.10
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A5qqLaGVIKKOcCtwdRsMs07OIduoT4iPGoxTIoSUZ0I=;
        b=WpUAlq8JQhZt0dgKBRycdyS88mMM5Mxq7chyUNxnbyL4Rl2yD/CfJn4SvzS5THkmIW
         YAbKuYov9fE/dnlYcHiiX+7HhoAnbIrM9uLmrpNtSRFamv+op7k2uuBjNluI3RhXYkr1
         M87yiz/NKIPInbl4VPiqLFyjgkQQQGyrB8RXDBvDfhR9qepYJB26sBuS2rgk+ap3SaV2
         GYNi2Q/C+oAA7B+Abmzt6sGVMs8RBG6vJr15xna2gTiM7fcFjeY7vj71TqjRqPFTc1Lg
         yYGN8+krg/htOvLq0KPo1St524fvlX01+DclgnndS0Z/GKpLLcewPNvaHJ9RSFugmXri
         WOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A5qqLaGVIKKOcCtwdRsMs07OIduoT4iPGoxTIoSUZ0I=;
        b=SKwhM+sA2/S5JrS+sHwTgfDgTbaC9FRuUhn3OWdFIE+akKkTFgkywazouKT1OBRzol
         wUWYNdliyIkhaU3BRO61xmzJSUX6H9GLU5nZObHPyLM9SsmrShzCeEb6YMZ05fokEq4P
         T6mxWNn5ct2bs9nWaCa/rEGfVjumEY+qx7VQd/WrJLKgTE8k8ZFIu0LrKxx/HvtQ7DK5
         yWXbiWjQdZFQ0mgfUSsEXfWjrsKQOmqP8dEl9dmcIWS95SFbx9h4y2LsfhMBgfoZGxOQ
         W7PxvqulPKZPG284sf2r5Z/K+342UCMMpNjIsru//a1a+YHYFNVkztoCbURobB6KsQQ7
         uQbA==
X-Gm-Message-State: AOAM530/NZHapsNyPzd8DauFPHRQnQTsNzs6cMPFzpdzkLE9gd4QJoHY
        5ANTGBaXLvcYmuQu6spQ1wdF9PVR2yE=
X-Google-Smtp-Source: ABdhPJxAKLTazasqbrEc7TULVMXuHRAlqrzKXGj+46bk6SGccDO2Ouo7nB+nggQg+UC8Z2cqXaP+tw==
X-Received: by 2002:adf:c7d2:: with SMTP id y18mr26764434wrg.717.1640907372121;
        Thu, 30 Dec 2021 15:36:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm24640206wru.66.2021.12.30.15.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:36:11 -0800 (PST)
Message-Id: <798625b53f2ee4860364e3898c3a1612f7b4e100.1640907369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 23:36:02 +0000
Subject: [PATCH v3 2/9] log: clean unneeded objects during `log
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
index d053418fddd..e6a080df914 100644
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
 			die_errno(_("unable to create temporary object directory"));
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
index 84ed864fc81..d4655b63d75 100644
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
+		BUG("unable to remove temporary object directory");
 
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

