Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E5EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243605AbiBWRz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbiBWRzv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0660762F7
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n25-20020a05600c3b9900b00380f41e51e6so1863249wms.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=banR2/YPRedUlMEFqceTdv5AzXLOH8Pv1nIbKygHUss=;
        b=YkOU9nof693tJHtqH8BEYrEOacDjNnsMVa6/YaRMsfPZMwYd05hWbChGltvoP3RSvC
         3qA4n5RCXOKeBlbLZVcjKbca4bSWURhROaokW/jUFCbF1A+kPruI69l/45lJtE1DYC3E
         ddBAFVVfcOXjUKbY/1U/KmTeEnWDOUYLzdoNaWbE4gXs2FTVW8YVChciYMBxj6Ma/g3w
         69WJGVhJGs3qe2Zo2ll9s7mT21PmX6zPOqxJtpyE6dkmNJD0cn2gsz8RUiDCLMyqIw+J
         ACINqDgNK9ZlY9YK7xupbL0VYFxUcjqGXdt9U8tWt9B3I9pghbEcrhocliy6wJ6F6iE+
         /vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=banR2/YPRedUlMEFqceTdv5AzXLOH8Pv1nIbKygHUss=;
        b=u6Ev/cjhxGFmu264Li8d3RrleIhFESaLcHN+O4XRqqlfgxDtdZfsAK2kvUkU9QInU4
         il/xLdKq4Ui5pkMljAjOhX0OVBr+pD1yydXrGQ6jtCmJQOkPMEdvVB+/kv45yeYK58s5
         jejwp7RFvQ/Cg6t+CTeY4doFArq8SxuPtHMgejG5vY5pYVIZsrIhDZ9frROUpDujSojk
         33zPb4Pfuu4AiRVrXE6Wc51BoAa1LoV+8J//UO0pD1qYGj/yLFBI4oVJjLVqlaoxicGb
         Upx5e0xcXKghogVJR1SgTJg82IA6xRqVps2/VbluJkNQjzonQOydT58dvE6GPVRghFx+
         93pQ==
X-Gm-Message-State: AOAM530Sc3d1GHj/7LV4/mNEXOIVKqB6De79CiiKj5XYKNU/aCnFMTrF
        zsi6tAKt4PIWgK5OPrb645j004HW3DQ=
X-Google-Smtp-Source: ABdhPJwuNL3Dckv4GjzOQGrUdYwHcI0EZRp8xnjKTA1O2DoehXN14rrSWcUVH1T2o+YfVyPG1li8dg==
X-Received: by 2002:a1c:4d09:0:b0:380:e340:bfba with SMTP id o9-20020a1c4d09000000b00380e340bfbamr6262039wmh.80.1645638921500;
        Wed, 23 Feb 2022 09:55:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm255825wrc.98.2022.02.23.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:21 -0800 (PST)
Message-Id: <22c4fe9d4bc84bb7c9e6cd3c837a1d18647ad6ee.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:09 +0000
Subject: [PATCH 09/11] rev-list: move --filter parsing into revision.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Now that 'struct rev_info' has a 'filter' member and most consumers of
object filtering are using that member instead of an external struct,
move the parsing of the '--filter' option out of builtin/rev-list.c and
into revision.c.

This use within handle_revision_pseudo_opt() allows us to find the
option within setup_revisions() if the arguments are passed directly. In
the case of a command such as 'git blame', the arguments are first
scanned and checked with parse_revision_opt(), which complains about the
option, so 'git blame --filter=blob:none <file>' does not become valid
with this change.

Some commands, such as 'git diff' gain this option without having it
make an effect. And 'git diff --objects' was already possible, but does
not actually make sense in that builtin.

The key addition that is coming is 'git bundle create --filter=<X>' so
we can create bundles containing promisor packs. More work is required
to make them fully functional, but that will follow.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/rev-list.c | 15 ---------------
 revision.c         | 11 +++++++++++
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3ab727817fd..640828149c5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -591,21 +591,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
-
-		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
-			if (!revs.filter)
-				CALLOC_ARRAY(revs.filter, 1);
-			parse_list_objects_filter(revs.filter, arg);
-			if (revs.filter->choice && !revs.blob_objects)
-				die(_("object filtering requires --objects"));
-			continue;
-		}
-		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
-			if (!revs.filter)
-				CALLOC_ARRAY(revs.filter, 1);
-			list_objects_filter_set_no_filter(revs.filter);
-			continue;
-		}
 		if (!strcmp(arg, "--filter-provided-objects")) {
 			filter_provided_objects = 1;
 			continue;
diff --git a/revision.c b/revision.c
index ad4286fbdde..1d612c1c102 100644
--- a/revision.c
+++ b/revision.c
@@ -32,6 +32,7 @@
 #include "utf8.h"
 #include "bloom.h"
 #include "json-writer.h"
+#include "list-objects-filter-options.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2669,6 +2670,14 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 		revs->no_walk = 0;
 	} else if (!strcmp(arg, "--single-worktree")) {
 		revs->single_worktree = 1;
+	} else if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+		if (!revs->filter)
+			CALLOC_ARRAY(revs->filter, 1);
+		parse_list_objects_filter(revs->filter, arg);
+	} else if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
+		if (!revs->filter)
+			CALLOC_ARRAY(revs->filter, 1);
+		list_objects_filter_set_no_filter(revs->filter);
 	} else {
 		return 0;
 	}
@@ -2872,6 +2881,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die("cannot combine --walk-reflogs with history-limiting options");
 	if (revs->rewrite_parents && revs->children.name)
 		die(_("options '%s' and '%s' cannot be used together"), "--parents", "--children");
+	if (revs->filter && revs->filter->choice && !revs->blob_objects)
+		die(_("object filtering requires --objects"));
 
 	/*
 	 * Limitations on the graph functionality
-- 
gitgitgadget

