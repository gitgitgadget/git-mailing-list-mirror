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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D222EC4320A
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE27A60EB9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhHKE5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 00:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhHKE5y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 00:57:54 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7FDC061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:31 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s13so2784328oie.10
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKQXCP1g+/+Ob4egcu0oIyMr9O//ZOcWYi2mif1VNf8=;
        b=CWHJsCiVqS5M7njHNbHfu/a86qkIw4atFO49xutat5leiT/YePvFEWMLQ4lbaD2jgN
         4ulYgTPqw88bKnJTsV2klEIkme8EhkoozWdBZ4IQs1rJf+XJZtQ5j9U02qE4TVYgzYEv
         klHEn1Dr19fs3NQ8Z4pad1bSjETbigUcQaqSUEodgxKMMRJFMeV25ju7oOYjRqa690vG
         ISPxIC4BL5zd7n+2tTutNaX4bpbldOynNqs7aAw0c++pUu5Wg7nZY5kK2u4+SxsuuQ+Z
         wdoM8n2M0gDje4J1DOT2qfhNhen+Pa1zNxbklx9NNwcbu8PUvWQjLJlz4wVVXRnM7y3A
         hErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKQXCP1g+/+Ob4egcu0oIyMr9O//ZOcWYi2mif1VNf8=;
        b=PRIG7PjdwipVtFkk15A7o/AePqoN5koMENBXLRfo+NcKnas1I4/kOhXk1XClXefX2i
         ROZSTlO8Cr24tSIMY/yyHPwzuFm5xTafo0NjltGyM42REIrNLLfK/ucSozJdxjJdvsjp
         UGXuvTiTk3zKMHGUGShY7aUBKZOKCBXBidHrinrNoya4AOXunEtGlKsCHKkiw15aATVb
         wDsQImIg8JaWHsG5xgNc7b0lOF1HqdY+sdbMZG9G70IyEs8uY5mfmgATA5MwSBQPdiz8
         Dx+MlF9nxEB7tHsyh7kEPIT1PqGhsyt8UcB2zx7JoxVwOLW7o8J4hTfthoWOX7/2hxJa
         CnmQ==
X-Gm-Message-State: AOAM533XCCw1/u72G20BMm1Mt7etini/FgoWByEbhhDrzlTaal/j1zoC
        yJ0RKOVCkjREVmn2mz7vkZY7B7Zcut7qxQ==
X-Google-Smtp-Source: ABdhPJxdkLc6KwjUMa3shu0qWzae1zlQ0IM9bhlWvBKxzNzDLhgeV4AgkQ8g5fuuBWmxdnh8CCO+Rg==
X-Received: by 2002:aca:4ed6:: with SMTP id c205mr356841oib.57.1628657850521;
        Tue, 10 Aug 2021 21:57:30 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id r15sm4180211otn.33.2021.08.10.21.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:57:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/7] stage: add proper 'stage' command
Date:   Tue, 10 Aug 2021 23:57:21 -0500
Message-Id: <20210811045727.2381-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
In-Reply-To: <20210811045727.2381-1-felipe.contreras@gmail.com>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is still basically the same as `git add`, but now more easily
extendable.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stage.txt | 11 ++++++++---
 Makefile                    |  2 +-
 builtin.h                   |  1 +
 builtin/stage.c             | 23 +++++++++++++++++++++++
 git.c                       |  2 +-
 t/t3710-stage.sh            | 20 ++++++++++++++++++++
 6 files changed, 54 insertions(+), 5 deletions(-)
 create mode 100644 builtin/stage.c
 create mode 100755 t/t3710-stage.sh

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index 25bcda936d..3f7b036901 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -9,14 +9,19 @@ git-stage - Add file contents to the staging area
 SYNOPSIS
 --------
 [verse]
-'git stage' args...
+'git stage' [options] [--] [<paths>...]
 
 
 DESCRIPTION
 -----------
 
-This is a synonym for linkgit:git-add[1].  Please refer to the
-documentation of that command.
+The staging area is a location where changes are stored in preparation for a commit.
+
+This is a synonym for linkgit:git-add[1].
+
+SEE ALSO
+--------
+linkgit:git-add[1]
 
 GIT
 ---
diff --git a/Makefile b/Makefile
index c3565fc0f8..0223ed7cb1 100644
--- a/Makefile
+++ b/Makefile
@@ -779,7 +779,6 @@ BUILT_INS += git-maintenance$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-restore$X
 BUILT_INS += git-show$X
-BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-switch$X
 BUILT_INS += git-whatchanged$X
@@ -1153,6 +1152,7 @@ BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
 BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/sparse-checkout.o
+BUILTIN_OBJS += builtin/stage.o
 BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
diff --git a/builtin.h b/builtin.h
index 16ecd5586f..d08d803c4f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -218,6 +218,7 @@ int cmd_show(int argc, const char **argv, const char *prefix);
 int cmd_show_branch(int argc, const char **argv, const char *prefix);
 int cmd_show_index(int argc, const char **argv, const char *prefix);
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix);
+int cmd_stage(int argc, const char **argv, const char *prefix);
 int cmd_status(int argc, const char **argv, const char *prefix);
 int cmd_stash(int argc, const char **argv, const char *prefix);
 int cmd_stripspace(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stage.c b/builtin/stage.c
new file mode 100644
index 0000000000..4dcefbedba
--- /dev/null
+++ b/builtin/stage.c
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2013-2021 Felipe Contreras
+ */
+
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char *const stage_usage[] = {
+	N_("git stage [options] [--] <paths>..."),
+	NULL
+};
+
+int cmd_stage(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, stage_usage,
+		PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
+
+	return cmd_add(argc, argv, prefix);
+}
diff --git a/git.c b/git.c
index 18bed9a996..3b92e60329 100644
--- a/git.c
+++ b/git.c
@@ -599,7 +599,7 @@ static struct cmd_struct commands[] = {
 	{ "show-index", cmd_show_index, RUN_SETUP_GENTLY },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP | NEED_WORK_TREE },
-	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "stage", cmd_stage, RUN_SETUP | NEED_WORK_TREE },
 	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
diff --git a/t/t3710-stage.sh b/t/t3710-stage.sh
new file mode 100755
index 0000000000..2bf59905ca
--- /dev/null
+++ b/t/t3710-stage.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+#
+# Copyright (C) 2021 Felipe Contreras
+#
+
+test_description='Tests of git stage'
+
+. ./test-lib.sh
+
+in_stage () {
+	test "$(git ls-files "$1")" == "$1"
+}
+
+test_expect_success 'basic' '
+	touch foo &&
+	git stage foo &&
+	in_stage foo
+'
+
+test_done
-- 
2.32.0.48.g096519100f

