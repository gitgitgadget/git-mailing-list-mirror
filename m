Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD40C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C034A60C40
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhHKE6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 00:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbhHKE6G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 00:58:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B575BC06179E
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c23-20020a0568301af7b029050cd611fb72so1970365otd.3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YyOgyO63SOQpzUzoJpNqPxCcQclSmwcjLeVz1LtpnVM=;
        b=k19SIQ5VEeNuLy7kjQkTYNrPBrLhdRecIN6p7FHlK23FJprilH328fUWGmpI3oYNVw
         dnqd1yhrnaP9LzADBDRVUr8ltVvsbC7FGCHgLq2cMtXHFr/Ip3TyLDghKPZQh5kgN+2O
         uqz7KxfBOMKBJaXxLV6ISNSVNqs+YrIJ87rTCslz+L88/JbwhzbDY8dOizQPYP2pj8dU
         J7+JhYqNpu5jh6NsAQ/MD8rVcxXIty+W2o5IRbwrWVgMwHuxOlciNlrPbwES52LstifI
         nDg4N1UgY9Z9jUZowYx1u3Hav/E21Qj4/4ysWLXktHCmpYg6sNWRdc8STmcl9KfAUQ0z
         QzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YyOgyO63SOQpzUzoJpNqPxCcQclSmwcjLeVz1LtpnVM=;
        b=V3xUwfQZPPAB85v/B5LNn+OOtgNcjA81WZGchzjXDga6GfsLyez249E3MKeke50eV+
         mNhy9u2zqy7t3wJQJO8aTP+hr2wQznj3Tdnlcz/kX3vnmmXDMSxopE0zBDB395k8e58H
         fv1C7q00UjhF0/ZqZflMuePv9vc9LxogtavfhG5jWkncbWFBUnMX2PlEalHUz+kJGpJv
         mfp0W56Rjse50FuaTTtWil3fFkBFPa0sv2mwUMf0KPIqfEnjvY5A+DN9Dxj4AJpsAxfg
         4qJui6LMhAPw1UyPqULZtAIV8FJDVHq9WfTBVe94ytKAFTGRVEMuQrPKHXXNo4Qw5pmU
         h2gA==
X-Gm-Message-State: AOAM531ERsiIfzCFdXSvVI/pjF7mBpwjPafXtzgLec4NzqMjk2ROVx6r
        GKwZeUMWtFk4mjRc2EvmS/YGI8u3Fos/vA==
X-Google-Smtp-Source: ABdhPJwJV8uYvqSyRSR2TfTJ2Fm1kwoXcDWguGNPlexi3a5/mXGaLFAugNlwCE1mAhEEooTIJKEzLg==
X-Received: by 2002:a05:6830:1dae:: with SMTP id z14mr11298704oti.348.1628657860876;
        Tue, 10 Aug 2021 21:57:40 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id h9sm1108060otr.67.2021.08.10.21.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:57:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/7] stage: add 'edit' command
Date:   Tue, 10 Aug 2021 23:57:27 -0500
Message-Id: <20210811045727.2381-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
In-Reply-To: <20210811045727.2381-1-felipe.contreras@gmail.com>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stage.txt |  5 +++
 builtin/stage.c             | 76 ++++++++++++++++++++++++++++++++++++-
 t/t3710-stage.sh            |  6 +++
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index 460a8d6228..baea9d96e0 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git stage' (-a | --add) [options] [--] [<paths>...]
 'git stage' (-r | --remove) [options] [--] [<paths>...]
 'git stage' (-d | --diff) [options] [--] [<paths>...]
+'git stage' (-e | --edit)
 
 
 DESCRIPTION
@@ -37,6 +38,10 @@ OPTIONS
 --diff::
 	View the changes staged for the next commit. See linkgit:git-diff[1].
 
+-e::
+--edit::
+	Edit the changes in the staging area.
+
 SEE ALSO
 --------
 linkgit:git-add[1]
diff --git a/builtin/stage.c b/builtin/stage.c
index c57bb2d683..49af18dda7 100644
--- a/builtin/stage.c
+++ b/builtin/stage.c
@@ -5,6 +5,9 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
 
 static const char *const stage_usage[] = {
 	N_("git stage [options] [--] <paths>..."),
@@ -40,14 +43,83 @@ static int rerun(int argc, const char **argv, ...)
 	return ret;
 }
 
+static int do_reset(const char *prefix)
+{
+	const char *argv[] = { "reset", "--quiet", NULL };
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
+static int do_apply(const char *file, const char *prefix)
+{
+	const char *argv[] = { "apply", "--recount", "--cached", file, NULL };
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
+static int run_edit(int argc, const char **argv, const char *prefix)
+{
+	char *file = git_pathdup("STAGE_EDIT.patch");
+	int out;
+	struct rev_info rev;
+	int ret = 0;
+	struct stat st;
+
+	repo_read_index(the_repository);
+
+	repo_init_revisions(the_repository, &rev, prefix);
+	rev.diffopt.context = 7;
+
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	add_head_to_pending(&rev);
+	if (!rev.pending.nr) {
+		struct tree *tree;
+		tree = lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
+		add_pending_object(&rev, &tree->object, "HEAD");
+	}
+
+	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	rev.diffopt.use_color = 0;
+	rev.diffopt.flags.ignore_dirty_submodules = 1;
+
+	out = open(file, O_CREAT | O_WRONLY, 0666);
+	if (out < 0)
+		die(_("Could not open '%s' for writing."), file);
+	rev.diffopt.file = xfdopen(out, "w");
+	rev.diffopt.close_file = 1;
+
+	if (run_diff_index(&rev, DIFF_INDEX_CACHED))
+		die(_("Could not write patch"));
+	if (launch_editor(file, NULL, NULL))
+		exit(1);
+
+	if (stat(file, &st))
+		die_errno(_("Could not stat '%s'"), file);
+
+	ret = do_reset(prefix);
+	if (ret)
+		goto leave;
+
+	if (!st.st_size)
+		goto leave;
+
+	ret = do_apply(file, prefix);
+	if (ret)
+		goto leave;
+
+leave:
+	unlink(file);
+	free(file);
+	return ret;
+}
+
 int cmd_stage(int argc, const char **argv, const char *prefix)
 {
-	int add = 0, remove = 0, diff = 0;
+	int add = 0, remove = 0, diff = 0, edit = 0;
 
 	struct option options[] = {
 		OPT_BOOL_F('a', "add", &add, N_("add changes"), PARSE_OPT_NONEG),
 		OPT_BOOL_F('r', "remove", &remove, N_("remove changes"), PARSE_OPT_NONEG),
 		OPT_BOOL_F('d', "diff", &diff, N_("show changes"), PARSE_OPT_NONEG),
+		OPT_BOOL_F('e', "edit", &edit, N_("edit changes"), PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -58,6 +130,8 @@ int cmd_stage(int argc, const char **argv, const char *prefix)
 		return rerun(argc, argv, "reset", NULL);
 	if (diff)
 		return rerun(argc, argv, "diff", "--staged", NULL);
+	if (edit)
+		return run_edit(argc, argv, prefix);
 
 	return rerun(argc, argv, "add", NULL);
 }
diff --git a/t/t3710-stage.sh b/t/t3710-stage.sh
index aab979c20c..3c9522249f 100755
--- a/t/t3710-stage.sh
+++ b/t/t3710-stage.sh
@@ -42,4 +42,10 @@ test_expect_success 'diff' '
 	test_file_not_empty out
 '
 
+test_expect_success 'edit' '
+	GIT_EDITOR="sed -i -e \"s/^+foo$/+edit/\"" git stage --edit &&
+	git stage --diff > out &&
+	grep "^+edit$" out
+'
+
 test_done
-- 
2.32.0.48.g096519100f

