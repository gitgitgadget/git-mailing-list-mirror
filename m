Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD24EC433E1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B747220776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMxa8fzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgFPTVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbgFPTVC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:21:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8215C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:21:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g10so3927550wmh.4
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xTzsf3V4vFQhCC/P9xGWFdWFp0Vso2rP5UjMEdsQw0Y=;
        b=tMxa8fzRyYmNVpZvuUiEN3Cswa+hn8AibuoI6iolHuI0hc+FDi9o9p0glRlpONFEIV
         VpVhOzYqWdgiLywnTxCTvr9GTNHz1Ug+oyX15HIg/WIr5L5WwrxVQekLTva2I+3SzeCI
         uML7c7YuPBMOPMJoycU9W/8E5lvhkseQTiAiHKOFUcY4yRuscKxRrjMpbyh6iLKBNo6j
         OYmjhG7jGO2s0NI838kb4sqaX3Q2Ww9h5UBL60GX60W+4xCXKrnXiih3oxbVyRMezJoC
         xc605j8xkOei8FobSr3Jwpio+5tbluu1m2yqDoykajuI8DGWfyak8hOubFymAEyUuvuv
         YAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xTzsf3V4vFQhCC/P9xGWFdWFp0Vso2rP5UjMEdsQw0Y=;
        b=e5L7iUuuogwjg52dNJ4iyp33d6fcEIqRys1XDPPr3vOTOEjp5zHCaOR1F67GwwUgQf
         gk5SQ3BaYsLmaTAoyK5zjVnx4qJgnRLR+GKTarUdgTDJya4DdFKJ5d3rk9D8kk7ZLzL3
         EmOUD9xOXBVVQjBJvpSFSZm81em38Z9y+UO+nTND8UV2JwX9aKbAUj7m25u+p2BGyX7w
         NhdIWUpijtPQJZXcRaYSSpQSCs1XtgBNMSWOCgbZcHYfcdrn49ehhJmloP1cawOh2Sgh
         qM9zV30fU/+B1U917GcwWtnNw23D8pQYWkyW2w8qzMrXibUSXG4jZeFjlzyckRlvWV8S
         SWCQ==
X-Gm-Message-State: AOAM532kaUelcbrAsKct0jm9/RDlrRoSG424AlXhfR38b0dzKBgVe4P8
        JArv0SBK/ldqiRoFIsv8CcoqmpKc
X-Google-Smtp-Source: ABdhPJwtd8v6cc385Qa57OUOaElkgn/b0XBojFtq1a80wTgxNzqYCaXZWoSPU1yQ52azILwcYXXUfw==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr5128894wmj.137.1592335259491;
        Tue, 16 Jun 2020 12:20:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm31315247wrv.48.2020.06.16.12.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:59 -0700 (PDT)
Message-Id: <ad5658ffc51d2f82f5f8dc166e19e90792caa114.1592335243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:42 +0000
Subject: [PATCH v17 17/17] Add "test-tool dump-reftable" command.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This command dumps individual tables or a stack of of tables.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 | 1 +
 t/helper/test-reftable.c | 5 +++++
 t/helper/test-tool.c     | 1 +
 t/helper/test-tool.h     | 1 +
 4 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 9c71bbdcbb8..c79b3d83876 100644
--- a/Makefile
+++ b/Makefile
@@ -2375,6 +2375,7 @@ REFTABLE_OBJS += reftable/writer.o
 REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/refname_test.o
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 95d18ba1fa9..339f4e148d7 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -13,3 +13,8 @@ int cmd__reftable(int argc, const char **argv)
 	tree_test_main(argc, argv);
 	return 0;
 }
+
+int cmd__dump_reftable(int argc, const char **argv)
+{
+	return reftable_dump_main(argc, (char *const *)argv);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 10366b7b762..9e689f9d2b3 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -53,6 +53,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d52ba2f5e57..bf833e01d45 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -17,6 +17,7 @@ int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
+int cmd__dump_reftable(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
-- 
gitgitgadget
