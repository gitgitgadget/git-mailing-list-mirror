Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F16C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345819AbiHITJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344826AbiHITJH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED11FCD1
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so15333834wrh.3
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Cit47d/USdckqIdFx1bqdLYm9Vxj3ZE//AEQ78K9c/w=;
        b=q1SAHeZaMjL1j5ZBv0yibRrpfMqkPw0SSJamRBW8Lfh5ib0nOjhPw/+kGM0XGllJJU
         n5Z4T+jm4DktWSqLY+wmzo5dDzWC4823EiLvPQ+5QW8THcyTawJ7fu7kv+21XXCNgpi8
         Z3fJLNtqCWD9rwX1CGvMz5eX6OZ9qiIoVAgdOcnG+AslP19gVoPrGGDSqV1ncknf3UCQ
         rQ67g6sNJ/3U0YrlwY3hFER1gcLRQWG31CH4S8ELGa3vqQYmZD1hLbDaMOj3/r0FlkEz
         vFJILan3m33eyRG+6ZunrJKZoGrUJoCnPZsOxFh25p8VufxPPOPOEuuU3bonN3XR65PQ
         80tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Cit47d/USdckqIdFx1bqdLYm9Vxj3ZE//AEQ78K9c/w=;
        b=yfQsGEV4693I7LP7XN9kPaqaCBXpRToB50j4HcNV9ZHVihL8KndaYWx4vqGQ2sdH1y
         CIvt8x2vJ1o3R0TzbUl+tt/B1s7Ty3+/KAoE4iWXreTGwhCQ/xGFUtgvnMxTvLVjMXAh
         psIb+Dem6HNHpoxdez1GCLeETC7ZMh9VIznXJu4y0i+fpabHUy+m9PUXQhgGMSWW4tij
         5QcQszVrwg88dppaMuwqNy3eGVNz22gNyG+WDkyIxuvOmJVMO14h/3ZD4UoiG+AQpayQ
         QBJWy0mCVniGxllyS/J2BL00VaMDY/r0fJAPz0vDDXomvfZvoEGBkHJEKl5Rwto0ewPR
         to9Q==
X-Gm-Message-State: ACgBeo068Pyse3quEo47Tb2cR/sIgk/enERJI7D6+MvtRH7PLlExodFD
        n5K3xPqeDySRoKtxfKRropWmKpUNfEE=
X-Google-Smtp-Source: AA6agR6zORK365bS1rmmieLr7Gkk4VGTAt+WhYeUZhCupnwFVz/c1GV4xvBON/2xHmcA2+JdhdGZfQ==
X-Received: by 2002:a5d:4889:0:b0:21d:eab7:f798 with SMTP id g9-20020a5d4889000000b0021deab7f798mr15129392wrq.96.1660071327726;
        Tue, 09 Aug 2022 11:55:27 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:27 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 04/14] merge-index: drop the index
Date:   Tue,  9 Aug 2022 20:54:19 +0200
Message-Id: <20220809185429.20098-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an effort to reduce the usage of the global index throughout the
codebase, this removes references to it in `git merge-index'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-index.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index f66cc515d8..9d74b6e85c 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "merge-strategies.h"
 #include "run-command.h"
@@ -38,6 +37,7 @@ static int merge_one_file_spawn(struct index_state *istate,
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
+	struct repository *r = the_repository;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -47,10 +47,11 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	if (argc < 3)
 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
 
-	read_cache();
+	if (repo_read_index(r) < 0)
+		die("invalid index");
 
 	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
+	ensure_full_index(r->index);
 
 	i = 1;
 	if (!strcmp(argv[i], "-o")) {
@@ -72,13 +73,13 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "-a")) {
-				err |= merge_all_index(&the_index, one_shot, quiet,
+				err |= merge_all_index(r->index, one_shot, quiet,
 						       merge_one_file_spawn, NULL);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
-		err |= merge_index_path(&the_index, one_shot, quiet, arg,
+		err |= merge_index_path(r->index, one_shot, quiet, arg,
 					merge_one_file_spawn, NULL);
 	}
 
-- 
2.37.1.412.gcfdce49ffd

