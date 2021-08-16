Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95BEC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31E860F22
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhHPUSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbhHPUSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:18:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E548C0612AD
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g138so12283479wmg.4
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jj9DwCQIpGbnYzigSuv8p5aLQnNcenzfOzKplhIMnXw=;
        b=RTggT2TPrxdrNZ99TwYF24sZFQoB7Ja1WStdTXAicG0U7BziR/VFALuhBY/AcU+AoA
         OPXuLU8ACZId2aXGGEAYzlLEC5KXPJxRyAC2vGz7B82HEdzdErXB4yzxvUtG/iWRTT3p
         WeyK+mgjWvmX7NgRUCgfau3YeZNgf3FPzTqQTQq0gKDQ99gq7vG8jyZ8R7yNjxErVbDk
         sF0MiNqboc1tpDqQZth2JFq1k7SdfyuQ/XLKfAGb/+rHJYplSWnldoG6ZMz/bT1WUHrr
         0QnmCQjHI8DfPt3JI3q4NS6IlFduNRDClHEul6ndw0X5JkT97Nc9qf1oOWfoVYQhhUVL
         yPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jj9DwCQIpGbnYzigSuv8p5aLQnNcenzfOzKplhIMnXw=;
        b=XnMJTFSuP1WkmR/LfyB5TearwNonSBIxNasLyQ8LZZ+eu4GKsi9ecQjAXPaslOsl0V
         P+roPM64Lty76+VIsXF1pBtO1xHqstiVgdbunG8hme6brS5AU+j7Xf2F723M8pyfUJYR
         cklOlP1ctb3jFR0yPOcf+4owkPVodccEJOtJOfZ3MaC54WYy8G4gtW2ZS6eJvtNHEgBF
         NHQub4dQ/LWXXeUExFGEdeo+omLOZye/HS1769naWcSv8Uov649SAmgMrpuw/Jw7pSXx
         ob22n5dNK551KnfbcfK94fsZZNiMn6TG/IvMrtCYA0Ar3UPtLxhVir4ZPIjgC8Ip6fsl
         Dywg==
X-Gm-Message-State: AOAM530qL5HHPtYFveUzhyZ7C9bpiZ0Uakw7+Z5aSQXrPN1166hvPyDI
        5QvbKAgKvHbNMTgAmoroyF/rl1X62xs=
X-Google-Smtp-Source: ABdhPJwpIqspmO+VK+HAFJAAWViQ+Xy3x+Hxjfmpf9W2aC13rMdtur5ZEFaLOMrxQOZIzHsE9Wdb9g==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr10646wme.13.1629145060394;
        Mon, 16 Aug 2021 13:17:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm161629wmi.42.2021.08.16.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:39 -0700 (PDT)
Message-Id: <1f48091e549d2d6b8c1e0da2c232624ac0fd47b3.1629145037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:17:13 +0000
Subject: [PATCH v2 22/25] Add "test-tool dump-reftable" command.
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
index 6d0074939e5..98b8f1a1f9f 100644
--- a/Makefile
+++ b/Makefile
@@ -2471,6 +2471,7 @@ REFTABLE_OBJS += reftable/writer.o
 
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
index f7c888ffda7..338a57b104d 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -61,6 +61,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 25f77469146..48cee1f4a2d 100644
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
index d2b398ba5dc..c76e9042e1d 100755
--- a/t/t0031-reftable.sh
+++ b/t/t0031-reftable.sh
@@ -288,6 +288,12 @@ test_expect_success 'FETCH_HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success 'dump reftable' '
+	initialize &&
+	hash_id=$(git config extensions.objectformat) &&
+	test-tool dump-reftable $(test "${hash_id}" = "sha256" && echo "-6") -s .git/reftable
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

