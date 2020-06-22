Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70EEC433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05672073E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu06CDEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbgFVVzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbgFVVzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FA1C061797
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j18so1070714wmi.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7J3eDDSt9At599hablxNMerE+aBPUP5p9HlFvhhKBEo=;
        b=Eu06CDEnuQ07Npn0Xni3+UqNQ8m2pFpH2d3us4E90HP2baYGrgn3RJhNCKR5BAwJew
         XZAZ8mAL5fHFnsBy/zfXpGvkMAZ1AVtJZaEGryuxf4+Rqz+HNc5RSrabl6w3ikgRMTyB
         OYrSt89SBWKCHkI4IG/DkylusBpRlCHIopm0LxeARvL/CFATYioKqIgpukhqVQ7KoNUS
         YRh3UQxSiAzuqzxUzHc48L80+TG5T7cLOHneaAyVoVTIJYZcoyx+gBV774YOkhslPcl0
         ++n8z+MotsJXR/mikdDpl9TUxUdp0iR0mo3EQwqVdVJQIAwltc1zDa4V9I9b169kmwc3
         Fmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7J3eDDSt9At599hablxNMerE+aBPUP5p9HlFvhhKBEo=;
        b=m/gPFUEUOLyEJrxlzHz5t1Z076ADrx6Sex2KZpDwWXakVUxBxMcxEdUEz22Tr3qWBq
         7hzcDspMOnBeUooAbMt4KgojLx32ZFdjigheCIvV4RJkRyc121kpYlFN+tAK8/aCm3uS
         evOrzIusoT4Kq5OdOrOrUBOZNAXHdERayp3kK9KT6mXmqAH+5RtPOkX3G2p2qEdVQtEw
         vkrfYmufdkNrsXuwkIYEPsX76SftgGR8g56p+lVFUA33tlpYj22me+aPqfwTlIp8+Tpg
         VuwJ1XACczs/c0TnI0ykccLc2QXIWWFKY/fYmTCLjumMXB1G8jh0yDrg/ar5+AfnEGVR
         7Icw==
X-Gm-Message-State: AOAM533JHPlpbZ2i6I7BjQSrWL/MiJ4Jl5EN9hq7X8hJF0u4PzLo87Rs
        qan/5pseLZJVbtAeqDqA34Bdjh/L
X-Google-Smtp-Source: ABdhPJwF6QawqFSGg9JxZFIl6Xkr3EAzwtidoDVv129I8L3ysB2ncZo/KpZoy9ttBiS2BTEH2/pPfw==
X-Received: by 2002:a1c:254:: with SMTP id 81mr20245873wmc.93.1592862941037;
        Mon, 22 Jun 2020 14:55:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm3066827wrm.17.2020.06.22.14.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:40 -0700 (PDT)
Message-Id: <991abf9e1b277127d6d870a90821501c69686b98.1592862921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:20 +0000
Subject: [PATCH v18 19/19] Add "test-tool dump-reftable" command.
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
index 700ba10b01a..d949b79720c 100644
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
index def88834396..aff4fbccda1 100644
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
