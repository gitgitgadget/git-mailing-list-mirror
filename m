Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750DC636C9
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24F16113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhGTQ1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhGTQY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED676C061767
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r11so26758907wro.9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OsQSLvt2u3LVkRXrYhUjj9EbYAyMPEEngwbUfGEcNKY=;
        b=WbT5qXvenQV2oL05syz4DDviooyL/zNH1LjP+QVeO3Og8FK7HQEuVxSqBt5rrKF1og
         fEnzGLlMiXiBIGz54u2X+QCVip9ilugGRhvtGhNs/p0KNkET0wIgCTlJOyhxfbmXUXTW
         gEAXA0r7QU7/JUMb6JC2jwK8ZSxh+xyaIPjKFJNvO14KKAE2JFdVPiL/xRD2PS2s6gFb
         lvpjmPpLl1RxhFG+bL9OWqkgQIOYvdSH3Km5zbnco1zhIdjgOYXSH+47uFuUCk0bhBj6
         8weSPUvT3K9zPdBks4fTnR6W2y3z6BplEZa1FFcwkXDsYotTE3ytvaWOx+xSCLRX19q7
         90Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OsQSLvt2u3LVkRXrYhUjj9EbYAyMPEEngwbUfGEcNKY=;
        b=e+HeH7hxCLQcLp9sYRtp49C7MMEBOo2RNAj91aMBMroQ5DIIzHEQKKKEH70DcUofxO
         guYQLR2wuNYo6dqW8Zj1iNFklRU0RhpAZs0mjqnvz+UAYP0C/5GVT4iPdimM04kvKMJM
         otfx2pS9bdW/vVkC27951xJzsVEhDGI/id16c5yI3NHoZM50VgzmSNbHqruo06UAxSJF
         FXLc4livfNO2T5kwFRWGB/qnXNvlq30BsSLlM8ny8YDEwHPLs4Zu48VEReqrB2lHXU9S
         R3ys0eU5VIHUgdIodc0vMbs286+fkvk9wpawF/4zAlip2hL4+RS1iijNO9Lz/jpRiJPh
         ojpQ==
X-Gm-Message-State: AOAM533VG3FCp7/IIgK/YVhX406H+cftyXGXF9O3tLKwlnv2/uidINKv
        gQCqs87cLpuy6k/rC00pNlBlTESfNRk=
X-Google-Smtp-Source: ABdhPJwDcCK7q3oyT7bVHGxrmI44keo6n/tHSXWMPZGrKDNon4CHEJISK36sicslCZArVBEfmHJ5Pg==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr18150526wrv.293.1626800702588;
        Tue, 20 Jul 2021 10:05:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm20275752wmu.17.2021.07.20.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:05:02 -0700 (PDT)
Message-Id: <3c9c3a2d56df2ef525072ede5cb420b2690bb979.1626800687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:42 +0000
Subject: [PATCH 22/26] Add "test-tool dump-reftable" command.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
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
 t/t0031-reftable.sh      | 6 ++++++
 5 files changed, 14 insertions(+)

diff --git a/Makefile b/Makefile
index 19566c661f1..6014f74a1b8 100644
--- a/Makefile
+++ b/Makefile
@@ -2467,6 +2467,7 @@ REFTABLE_OBJS += reftable/writer.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 996da85f7b5..26b03d7b789 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -14,3 +14,8 @@ int cmd__reftable(int argc, const char **argv)
 	tree_test_main(argc, argv);
 	return 0;
 }
+
+int cmd__dump_reftable(int argc, const char **argv)
+{
+	return reftable_dump_main(argc, (char *const *)argv);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 01201629fca..ed543037bb8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -59,6 +59,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index cb90b7f4f7b..284cfe70d94 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -19,6 +19,7 @@ int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
+int cmd__dump_reftable(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
index 7899a1c580e..f024968ed66 100755
--- a/t/t0031-reftable.sh
+++ b/t/t0031-reftable.sh
@@ -288,4 +288,10 @@ test_expect_success 'FETCH_HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success 'dump reftable' '
+	initialize &&
+	hash_id=$(git config extensions.objectformat) &&
+	test-tool dump-reftable $(test "${hash_id}" = "sha256" && echo "-6") -s .git/reftable
+'
+
 test_done
-- 
gitgitgadget

