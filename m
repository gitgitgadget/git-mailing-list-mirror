Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB7C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiCWJPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243088AbiCWJP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3012575C30
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so1145836pjp.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vBdODXO6ATaNZ4WZ5hNMH/6g/FPAMQvNC5QptkE8s8s=;
        b=Sx9uSK6qOe/mwLn/XI5N8yu7zxDDpTcehvOAE1nzDDCACrtCUiPu7ewp7f8rQEKGOL
         kEsOiNTeLXAxImdIey6yQO151pRH6AI50oYsBm783RqP/gc2f+QokyKjFaIA+HxRuDTN
         iXM8omNYud0jT9y06U5626n8vC1+CUdFu3PC7XhtZP6i4gMJOnwWomK7vXTQryxxxwYj
         IOBnnRgbIyniowsJVqCG8BEzmnQkjZwUvYqwnJOtktz9i4mYc6nIUQ2R7/TP/AAU+9MI
         wVFAv5iEbNCesWggXnnOJTSe3dMb8qi/28H2L2Xj0rHW7ddNK9heFWjZEbz11/ZwEZ4a
         u3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vBdODXO6ATaNZ4WZ5hNMH/6g/FPAMQvNC5QptkE8s8s=;
        b=7xKAkGj8IPhI/o3nx96rz6ZZ3aLMYMsjwU8Ci/PJZW/iN3sPW842J/DQy3oBCfGg1d
         gFO7Poxw70RhepSEIcuceoqM7Ty50+orfgKUnBQiQKeThB3AtFSq9azkgwQdfQRwZGbZ
         1Sq/4b1+cJ31xQm6Xkrkcr+QgREBSZApoWw6JIcC9pCRQLAUuQip2yP23609Pbd78qAW
         kJn2e5KjwlGD8wEwTBcecZ3Ww/uvWJzlKWVBaKh06YQGKgX15MiCClwKO8/SA7FkASUE
         U4+E2YRnqY3y0aXonwiCRPqvsfh0LqrEhlJkXMdY+PFb1yvBGrDrttBxwK4KdVmHBRDX
         25zw==
X-Gm-Message-State: AOAM533lz255DOqGOy6f8FCpzz4WrPGdT/+2GY5Mm/el76OoIM5CJcwP
        pJ4F94e1sB12cuMTpTURY/8=
X-Google-Smtp-Source: ABdhPJzrUxubKx+Z4nLDj/BkEsASNWBBPrDMUQSiJcniauApuqZekau8lWunGsK5SWvlXezh1G56BQ==
X-Received: by 2002:a17:903:244d:b0:154:3bb0:7b8c with SMTP id l13-20020a170903244d00b001543bb07b8cmr19751068pls.115.1648026839468;
        Wed, 23 Mar 2022 02:13:59 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:59 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 14/15] ls-tree: detect and error on --name-only --name-status
Date:   Wed, 23 Mar 2022 17:13:14 +0800
Message-Id: <1d5d9470aba9564ef75abd550bc508cc173855f7.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The --name-only and --name-status options are synonyms, but let's
detect and error if both are provided.

In addition let's add explicit --format tests for the combination of
these various options.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c       | 11 ++++++++++-
 t/t3103-ls-tree-misc.sh | 15 +++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3474f8c3d6..6550f27dfe 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -41,6 +41,7 @@ static enum ls_tree_cmdmode {
 	MODE_DEFAULT = 0,
 	MODE_LONG,
 	MODE_NAME_ONLY,
+	MODE_NAME_STATUS,
 	MODE_OBJECT_ONLY,
 } cmdmode;
 
@@ -296,7 +297,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
 			    MODE_NAME_ONLY),
 		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
-			    MODE_NAME_ONLY),
+			    MODE_NAME_STATUS),
 		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
 			    MODE_OBJECT_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
@@ -322,6 +323,14 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		ls_tree_prefix = prefix = NULL;
 		chomp_prefix = 0;
 	}
+	/*
+	 * We wanted to detect conflicts between --name-only and
+	 * --name-status, but once we're done with that subsequent
+	 * code should only need to check the primary name.
+	 */
+	if (cmdmode == MODE_NAME_STATUS)
+		cmdmode = MODE_NAME_ONLY;
+
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index d979c0df5d..7454ebbb00 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -24,15 +24,18 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 '
 
 for opts in \
-	"--name-only --long" \
-	"--name-status --long" \
-	"--name-only --object-only" \
+	"--long --name-only" \
+	"--name-only --name-status" \
 	"--name-status --object-only" \
-	"--object-only --long" \
-	"--object-only --format"
+	"--object-only --long" 
 do
 	test_expect_success "usage: incompatible options: $opts" '
 		test_expect_code 129 git ls-tree $opts $tree
-    '
+	'
+
+	one_opt=$(echo "$opts" | cut -d' '  -f1)
+	test_expect_success "usage: incompatible options: $one_opt and --format" '
+		test_expect_code 129 git ls-tree $one_opt --format=fmt $tree
+	'
 done
 test_done
-- 
2.34.1.404.g92931a4a2c.dirty

