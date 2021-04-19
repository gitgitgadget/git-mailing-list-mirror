Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A759EC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5033461221
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbhDSLlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbhDSLiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70397C061357
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g9so17635223wrx.0
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fMDF4rANn7GPOR2A3+eumJh7eqb0eB7ePDnxO/909Qk=;
        b=YOJBtb97cHTcmHc2rY0wvAtH1jNXKITDVxSkXu1tWf8BOEI3hLI2cOXQqF+gDGYjB8
         PS+zJHC6HsZt6i6YsA/gDMbIAIP+7pdfkRDxOXzogFzeesMFpKVl4iHz0QMT3un+3z/p
         2PnDjv9EzkikfFRoej7TTZ+CSA5k0Dp/vaPREwTeeQUjjWYwwEVg9TlSNjRmBedp+wL9
         nwb2h0cqy24iP47JFF+EjBKlrO3wWxxsydSBoBOMRliPgcPAj2ru/FaTWKDWVf4DVqTu
         mW5sKLemYuLm9j5rXV5tPJs+4oFNMZqdnqWtaYMhjBok4ZG/Lgn3w61sP/q3B97Yj6N8
         c6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fMDF4rANn7GPOR2A3+eumJh7eqb0eB7ePDnxO/909Qk=;
        b=T1qAncpzw7Tvc1gmHQ9PAZQdgQrykdQW06Bm5Ghq8qvYqzUvtEygQ8tTfyHxG+8Ihp
         g1XF/sUD2eSl3m3A4m7tTTQQGwclFB0kP+gokKHw+fg2OBsCzalCqVU8qqenrJ3ICD3D
         DOUyzsqzvr9Y3p0VkiqX8oY9OJK+x1JaG/R7ktciqz90Okc3uLqXoPIawsCBHks85OYW
         CsupYTwtjyUwhFlfePt8TDxgwZD3apYCEOb6KB9BMRJmeeLKPJgaX0qmV41bRF8v1ZQQ
         tRcPaAyHy4w5GG0BCd/Rg6LsvT52Rvm95mQb4GviODjvbJhp2djZiM7LU5PRZSnu38gp
         6saA==
X-Gm-Message-State: AOAM530lRHiNuH1EmgnNUQwCZ5WUDczU4/1HKuHQpUlTjGWayEYVTt/E
        7ktZp4TYwl5JIZo1Gz3tGC4T7mZ4D3I=
X-Google-Smtp-Source: ABdhPJzaODKmdP3ZRM7B6DFV44/ycNvaPd4IOJHNw3dujgDDRzzPgOb3vs6ULw5JJFONKom9Zn12vw==
X-Received: by 2002:adf:b650:: with SMTP id i16mr14307110wre.189.1618832296246;
        Mon, 19 Apr 2021 04:38:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm5749533wrt.14.2021.04.19.04.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:15 -0700 (PDT)
Message-Id: <aca82763e72caa7b4b5eb93ceb428a6c18ab8b31.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:53 +0000
Subject: [PATCH v7 25/28] Add "test-tool dump-reftable" command.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
 4 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index cffcf3496978..115ba0ccba0a 100644
--- a/Makefile
+++ b/Makefile
@@ -2427,6 +2427,7 @@ REFTABLE_OBJS += reftable/writer.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 996da85f7b5c..26b03d7b7892 100644
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
index bea3285eed9f..6922f64c1683 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -58,6 +58,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 90f935310788..3ccc869f4595 100644
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
-- 
gitgitgadget

