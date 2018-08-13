Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2A11F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeHMS6O (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46960 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHMS6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id l16-v6so11637445lfc.13
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UIDL0kFJArNnQOgg+KPqv+13Wfmlvm9pj4HVHedjIs0=;
        b=hzMo8MwV4urrci4aTuOMKustfPVgdC1yBeTsJo+cRxOxMx8trUiP0ibUm/CHaZzWqv
         n9tR9RdrIR//V/ua8yj4WGrvSqVufG1iVdWRZL2Yt8G5uHxm8ELgT59Pe0+8kDLQszsI
         nR1MYTxj0UW5fhynTCYZ3TiWUft2OD4D1qNDQjUGjJLGjs4gEkPLfOgSFAW20EIDtNZ2
         2Dsazo5xqkdAv1BuUWzz8F6tBNppWCQb/JCAmXajL+/GaMsxHDKY51xJny7Eac6iyVIo
         n4BHmp2JPWwnc08s1dF8j6cDIxJ92bRIGjHnByLi53ClQ+ynbuHeQayMLWxbTs9E0sam
         pe9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UIDL0kFJArNnQOgg+KPqv+13Wfmlvm9pj4HVHedjIs0=;
        b=Qlp+IX1WS3A3CR0P2qFXDYSk0pZT9ZbGrCfZ8Cw9FSQz1KchBC9DEFNZWg7WsxFthG
         VPeii7ZiXk47YMYaVRSryTWQ+tFCt6hq+PlJpky8ot7nDxg5JejrfL6SAuX5b0nD4/pF
         rBSdAddtTdGGzMH/7nnUXpKrzV+DiHpECp+FDyNM2rdzveMZY7ifLzjfIU3R3dRwcBS5
         rKbA21v63F+QAojJUo7U2sVyFm2n2AFsmhVxWkoSwglYozqLwbzEHzbDYknInECpUZ8k
         9ENSGUEq7w1ZK1FOCfKQss0naHG4sfUpJ6DGQ+TRocIgO0w+upIJoo/FVYoI9BzzEQLE
         z8FQ==
X-Gm-Message-State: AOUpUlHECj/DDfUTRvUZNGGXCweMsBtQoMEa/F1FqAOSU55gfa4LroYB
        hTCD9C+8CyrGcfw0/XGECKU+D6eN
X-Google-Smtp-Source: AA+uWPza4zZ/mm+ZTwCs11DAYPMtNEabBJsH6v3vb0ejKXcy/bwJQViIOXCjqSLJ1FoSJxuL3q5ATA==
X-Received: by 2002:a19:ef13:: with SMTP id n19-v6mr11908830lfh.48.1534176919697;
        Mon, 13 Aug 2018 09:15:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/24] diff.c: move read_index() code back to the caller
Date:   Mon, 13 Aug 2018 18:14:18 +0200
Message-Id: <20180813161441.16824-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code is only needed for diff-tree (since f0c6b2a2fd ([PATCH]
Optimize diff-tree -[CM] --stdin - 2005-05-27)). Let the caller do the
preparation instead and avoid read_index() in diff.c code.

read_index() should be avoided (in addition to the_index) because it
uses get_index_file() underneath to get the path $GIT_DIR/index. This
effectively pulls the_repository in and may become the only reason to
pull a 'struct repository *' in diff.c. Let's keep the dependencies as
few as possible and kick it back to diff-tree.c

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/diff-tree.c |  8 +++++---
 diff.c              | 10 ----------
 diff.h              |  1 -
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 91ba67070e..d07bf2e4c4 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -163,9 +163,11 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		int saved_nrl = 0;
 		int saved_dcctc = 0;
 
-		if (opt->diffopt.detect_rename)
-			opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
-					       DIFF_SETUP_USE_CACHE);
+		if (opt->diffopt.detect_rename) {
+			if (!the_index.cache)
+				read_index(&the_index);
+			opt->diffopt.setup |= DIFF_SETUP_USE_SIZE_CACHE;
+		}
 		while (fgets(line, sizeof(line), stdin)) {
 			struct object_id oid;
 
diff --git a/diff.c b/diff.c
index 04d044bbb6..72ce8007fd 100644
--- a/diff.c
+++ b/diff.c
@@ -4414,16 +4414,6 @@ void diff_setup_done(struct diff_options *options)
 
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit = diff_rename_limit_default;
-	if (options->setup & DIFF_SETUP_USE_CACHE) {
-		if (!active_cache)
-			/* read-cache does not die even when it fails
-			 * so it is safe for us to do this here.  Also
-			 * it does not smudge active_cache or active_nr
-			 * when it fails, so we do not have to worry about
-			 * cleaning it up ourselves either.
-			 */
-			read_cache();
-	}
 	if (hexsz < options->abbrev)
 		options->abbrev = hexsz; /* full */
 
diff --git a/diff.h b/diff.h
index 20c697dbfe..3ada6ad33c 100644
--- a/diff.h
+++ b/diff.h
@@ -312,7 +312,6 @@ void diff_change(struct diff_options *,
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
 #define DIFF_SETUP_REVERSE      	1
-#define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
 /*
-- 
2.18.0.1004.g6639190530

