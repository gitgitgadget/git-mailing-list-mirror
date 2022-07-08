Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC625C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 20:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbiGHU25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 16:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiGHU24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 16:28:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69062814A0
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 13:28:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b26so31972067wrc.2
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CJqauzFXvmbpi9VbxrKwucknUmXcHDXeNEKP6Tfo78=;
        b=pYDzFR7BtniwPQWYDy4WzrV4wxWY8LdqubJs7iNkBojJR+3ByM45+L6p7AGnb6dMFi
         lDw/xYtsRmoJiN1DHanURLfKM/yRNAcLzDbhqP5AwZTUpdakF841JlD9mq5q33ykZyG2
         3LxP+vV9BS2uCcTnQDhkb+p1WkOO337E2XBKjOwP1ALE2MXvl2ZdSg5P68cCPGVMHAIg
         xWtt3sIHvTh8Ry6eg7UiGvc9i+RV3k0pjj00aan+RmGxTH8PgNmGXyO8BxKRdFPIjmsS
         mcMcLbqKnRVUyDRUM0YvkdsyhE7h1MICyLXH3UvF3fcAy17ynOjyNKjjblznja9O8yJ8
         0Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CJqauzFXvmbpi9VbxrKwucknUmXcHDXeNEKP6Tfo78=;
        b=GNumnPu14aiAVb+eqTuuOCyFBxiM1+KtMqp5b53sva+FHdTdN5er4bVrFfCxwgPlGA
         MgkKp5sqEOVviF9A9i9HCBDk1En76Sj8wWN0qildh5ZofnxVcC9jqIkzFvW88Sz1L2QM
         7LxIpc453Z6fQuLIcR9kNZm06ta07r6hwQ0BYPU054F3+YQNAPQfJXf7B18yXztk8mWN
         JrvIX2vLZmPh2Wf+dROKMSe2RPag6OhjsWJRbGV2z8Q+uYfS0yR+sG/H6u+ENebdglYZ
         CNOstQQ+8qxFr+MmkwKFYFE5y/eEniHYDgxZjaDtmXFoFaUC0s+nOKKFpquPLtGvwBdR
         IUHQ==
X-Gm-Message-State: AJIora+y3jGWkE6bkuZ94/kH4fql0WQDRMnnwtR9z4XGYgCZ4UtHsja5
        rtDrEgQs8dknc1KrSSjpAxTT+bun9vs=
X-Google-Smtp-Source: AGRyM1uO6dcUWAam+DWpnORcZgSSpXnFhSlpJeCANXwt9REVscxS2J3lFOb61tUHHc5hU7kSsGgBrw==
X-Received: by 2002:a05:6000:2cc:b0:21d:76d7:995d with SMTP id o12-20020a05600002cc00b0021d76d7995dmr5197253wry.339.1657312133943;
        Fri, 08 Jul 2022 13:28:53 -0700 (PDT)
Received: from localhost (94-21-146-223.pool.digikabel.hu. [94.21.146.223])
        by smtp.gmail.com with ESMTPSA id f10-20020a1cc90a000000b003a0231af43csm2948132wmb.48.2022.07.08.13.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:28:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] multi-pack-index: simplify handling of unknown --options
Date:   Fri,  8 Jul 2022 22:28:47 +0200
Message-Id: <20220708202847.662319-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.0.340.g5e8d960d32
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although parse_options() can handle unknown --options just fine, none
of 'git multi-pack-index's subcommands rely on it, but do it on their
own: they invoke parse_options() with the PARSE_OPT_KEEP_UNKNOWN flag,
then check whether there are any unparsed arguments left, and print
usage and quit if necessary.

Let parse_options() handle unknown options instead, which, besides
simpler code, has the additional benefit that it prints not only the
usage but an "error: unknown option `foo'" message as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/multi-pack-index.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5edbb7fe86..97a87ad8cb 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -134,10 +134,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_write_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
-	if (argc)
-		usage_with_options(builtin_multi_pack_index_write_usage,
-				   options);
+			     0);
 
 	FREE_AND_NULL(options);
 
@@ -176,10 +173,7 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_verify_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
-	if (argc)
-		usage_with_options(builtin_multi_pack_index_verify_usage,
-				   options);
+			     0);
 
 	FREE_AND_NULL(options);
 
@@ -202,10 +196,7 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_expire_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
-	if (argc)
-		usage_with_options(builtin_multi_pack_index_expire_usage,
-				   options);
+			     0);
 
 	FREE_AND_NULL(options);
 
@@ -232,10 +223,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL,
 			     options,
 			     builtin_multi_pack_index_repack_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
-	if (argc)
-		usage_with_options(builtin_multi_pack_index_repack_usage,
-				   options);
+			     0);
 
 	FREE_AND_NULL(options);
 
-- 
2.37.0.340.g5e8d960d32

