Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39870C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13716206B6
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGymMEJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgGAKQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbgGAKQi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 06:16:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE5C061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 03:16:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so6482171wmc.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1LA2EokgOG3DsXWMN3W+eyTDAp3mYmZaHdPYYtbOmU=;
        b=rGymMEJo09XuMospa//1NpUs7Xou92OEqHOxSsLRT48eG8lzE+91EqTaS9X9196Bb/
         oODQuOjbYa14O1FCOqW851vs3eveK7Grb+S+v8kTjpg57nXQUpzKuSRo1hg0OBrn/WZr
         JLE/Aa63mdVyhdjO++D5sr30HcfprYL+8WJA5zPALAWkdUIIIVCrpXJ7MqgvajUafYXg
         tuO+QInr7mtFikasEpmFfBBRiWn3Aly2iAEv6jCVm0hj3OG2oV0d2gNY176Ivi2URCDf
         UxhzLk7XaNB8BOx7GThL0p20WZmQdfDHUKj7KmT+C59v6v+Kqpm9kNjugg5tjwUnO0Kc
         Vbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1LA2EokgOG3DsXWMN3W+eyTDAp3mYmZaHdPYYtbOmU=;
        b=csXcx06LM5Cd7y/hN1EVabYl5axuSqDrZNK3BCFHUKUBmjGs+BVG1H6Xe8QSfMFsGF
         7jMmgxKskk15E3PMNqoG4p/HfeZOV9vCAqP+SciThw/hTns6wBDfTkh5nSAnL7HBkgSM
         01y1t4WjWXbBVM0rQ9qFTNgVrpc0eR5EFDad9Qolvy4roguR/qv5eyOIoD/rhITamcOG
         V0ea9GMCOckKABTkoRSWcbzXsDGZDr4ycnn8BkHk1Iol/Z8kX3db9latp+36sC/2OiC3
         ymIirRo827enbYIoPzMfc9owwg0qqj1FdoUxqFW4ZFQFxqZmmOA+rBPCfQ2PqGQeBFsG
         Qx/A==
X-Gm-Message-State: AOAM533O5thOqTbK6j1dH4XU2bBhl7vg6cjQ58ljcR3zgptrjJ4vlKZV
        JUV1FKv1QYFuTduPfUpNFEcqPOLykIk=
X-Google-Smtp-Source: ABdhPJxQxn+td3/Kt3bOO4N/l/B1worPrQsZ3keUED0PooY4woap1+cmHweSa+7K+F0rG9oiDtjfgg==
X-Received: by 2002:a7b:cd18:: with SMTP id f24mr3232753wmj.40.1593598596468;
        Wed, 01 Jul 2020 03:16:36 -0700 (PDT)
Received: from localhost.localdomain ([193.56.244.51])
        by smtp.gmail.com with ESMTPSA id d63sm6945634wmc.22.2020.07.01.03.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:16:35 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] cat-file: add missing [=<format>] to usage/synopsis
Date:   Wed,  1 Jul 2020 12:16:18 +0200
Message-Id: <20200701101618.28761-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.221.ga08a83db2b.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When displaying cat-file usage, the fact that a <format> can
be specified is only visible when lookling at the --batch and
--batch-check options which are shown like this:

    --batch[=<format>]    show info and content of objects fed from the standard input
    --batch-check[=<format>]
                          show info about objects fed from the standard input

It seems more coherent and improves discovery to also show it
on the usage line.

In the documentation the DESCRIPTION tells us that "The output
format can be overridden using the optional <format> argument",
but we can't see the <format> argument in the SYNOPSIS above
the description which is confusing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-cat-file.txt | 2 +-
 builtin/cat-file.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 8eca671b82..8e192d87db 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--path=<path>] <object>
-'git cat-file' (--batch | --batch-check) [ --textconv | --filters ] [--follow-symlinks]
+'git cat-file' (--batch[=<format>] | --batch-check[=<format>]) [ --textconv | --filters ] [--follow-symlinks]
 
 DESCRIPTION
 -----------
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ae18e20a7c..5ebf13359e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -596,7 +596,7 @@ static int batch_objects(struct batch_options *opt)
 
 static const char * const cat_file_usage[] = {
 	N_("git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-type] | -e | -p | <type> | --textconv | --filters) [--path=<path>] <object>"),
-	N_("git cat-file (--batch | --batch-check) [--follow-symlinks] [--textconv | --filters]"),
+	N_("git cat-file (--batch[=<format>] | --batch-check[=<format>]) [--follow-symlinks] [--textconv | --filters]"),
 	NULL
 };
 
-- 
2.27.0.221.ga08a83db2b.dirty

