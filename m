Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84C1C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC7620715
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wku40FN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgIPTLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgIPTKd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:10:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A58C06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k15so8012613wrn.10
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rde3O/LHRCWTHzvd7vIDTReTMaUxb5ou4EjAgI1N1Qc=;
        b=Wku40FN4uiI5VLeNPYaiMDA25+kOvBT9Se2xVpGCh2owhY1ocI/8ESFjLitIXoC3Dx
         05iRjnT9xjOOG5N4PPdV3tJFZ+sCGGG/9ADCAExEvVnF1irdR9l4G4rdtqCuWdoJN7q+
         +xOiRs1RcDI4sDX/Gu1YQ3DECUrcg7xYrLOfwrtZEz7eBS6nSYTdzGdKrweN9xjyEQw3
         7+cSJTfiXwBtywK1qpOvjBdDbnLmvldTcSKQj9krpno2nocDA0F5ecHa1XqexlVsFPa2
         Rv1LWmf7Kb8PkkKREu1XoQ6SurGB3i2lnlm9INzujVksP/fo4bU1TIVvvfUN+bdv5PB9
         F/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rde3O/LHRCWTHzvd7vIDTReTMaUxb5ou4EjAgI1N1Qc=;
        b=aMr1uEblYBaobfe6UOcrfQgTkv+6yPi1VlCnoLIgBaYUn5IEJu9L3XBIqyt/fC0dkJ
         MymQwreIhHQ+sRR+r9WiPLVSlIRMqzUj1ZmAiez1hlfvbaMS5zY2KMjV93kxLfqTwlxb
         lLV2Xct2sb3Ye0oO//9VP/G9Y4H/XkuyCCN/mInxnUGSS3tD9MUaS6B8EIemdAADMQVh
         J9ELKY/85UNTY3gzlQO+g0ErKAQrjUsdhlgnxfMaHJlXhnwa1LDJBbOHYhDgvgEPDn36
         UaEVnZpXWVRm1IGyIN/VXlWVEf0zz/SUjaaH0RJU7VvULhclO+cFfxjfjo+QU/aVqtVS
         0+MA==
X-Gm-Message-State: AOAM532Ec2TIby0MkUkOoRGAXcvkhTmF4E1OfsZKEimb07kKAVDgbMHO
        IkEGIX+pbLTDwioUtqDAgoaYfZp6FI8=
X-Google-Smtp-Source: ABdhPJyWDCcF4Ds7RcKBjt4iLByoZWm6lfbJIMCd2ObC06/z4dYZ+hhGxSEp0ZKoqFYVGnrnAH8Aig==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr27680138wrn.209.1600283428058;
        Wed, 16 Sep 2020 12:10:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h76sm7772845wme.10.2020.09.16.12.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:10:27 -0700 (PDT)
Message-Id: <b8729fee9e7609abba6fe21c1f37873fb33e3c48.1600283416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 19:10:16 +0000
Subject: [PATCH 13/13] reftable: "test-tool dump-reftable" command.
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
 Makefile                 | 2 ++
 t/helper/test-reftable.c | 5 +++++
 t/helper/test-tool.c     | 1 +
 t/helper/test-tool.h     | 1 +
 4 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index 6652259baf..ee82ff2915 100644
--- a/Makefile
+++ b/Makefile
@@ -2363,6 +2363,8 @@ REFTABLE_OBJS += reftable/writer.o
 REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/dump.o
+REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/refname_test.o
 REFTABLE_TEST_OBJS += reftable/reftable_test.o
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index def8883439..aff4fbccda 100644
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
index 10366b7b76..9e689f9d2b 100644
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
index d52ba2f5e5..bf833e01d4 100644
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
