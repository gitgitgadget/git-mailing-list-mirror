Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCCDC433E1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F47420663
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tu8nJb4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgF2S51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgF2S5T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF7AC031C40
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 17so17119870wmo.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4+GYIwg64XgTp2UucbUePBzYBR0cr8NZ9G3xhB1kVk0=;
        b=tu8nJb4k4tgtN5ArJ11br5gZ1Cbe1Y9dEo4eJKiNqGoRuzPmiNsExm5B9rQEcn7hPq
         kZWBB64knjJtevVsKcXyl5aB+AeYJnEk951jRxWwY21F9rV9P3YKpzc/UI5dDgLkcIdw
         qi41jMERmiZDioLWDHCEDSCpWeqrY0ZsyJoufeWaYGCoX1uqKFqWJLpNj4gBlWfyDlT0
         //m7QVQSS9va14ubN2M9KitsaxZT6+vrfsEJdjO8avYxYZdLDY3/FwtnEG2R3EgXotA6
         tbXpPUcAs8XRCuMU0WVDhfPigKs6o1T2JVOPTjeKTOoBV860eKmfccM49rdOfCqbxKja
         x9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4+GYIwg64XgTp2UucbUePBzYBR0cr8NZ9G3xhB1kVk0=;
        b=Opcdok6SHn2Ow2relnX9UNUYHSZ5MwqmTtNlGAr/m+JqTd9qTIy6Ceotwhwn2IFuLr
         kWM0+MRkp8zdrXU9V8ZHxLedyWkjsLVTgIK+Mwt477BRV4ROZPGy8EwohFlWUg3Fw3m0
         Ss+HBJUSiilHamouBzuLLdE1BrU+K7OAOmLSpWDG5N+bnL6F4uFnc0e50jFjazFfN9vE
         +CozcDhaAStPoOUEv6Vw0KWX3ThB3wa694FnMy9blT4Dn3YfnpWG7bmrMDhXHh9p3iu2
         rwpeI63YjwngmqKBBVK22KFxyzw1NYNEdLI67qCeUp0iRJZGk1TkgGVREKLXQPRpfDzJ
         cfcw==
X-Gm-Message-State: AOAM530no0q9X71WvY8kZFUcNHMGOHyS1PNRXG84oB38+N/yEJo8kqAW
        /mMugVr8lPfQDBdwVPLfaLKyranM2JQ=
X-Google-Smtp-Source: ABdhPJwWgocj6Sakv9slp62I0K5xSFvm0tiNlOvD6MS4Usjhzv17EB4LoPPrbee7a2bpE6hqqZbt1Q==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr18515096wmc.100.1593457038129;
        Mon, 29 Jun 2020 11:57:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm804684wra.42.2020.06.29.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:17 -0700 (PDT)
Message-Id: <0ebf7beb95c90cab3ea97bd2f13cda0eb47f7b54.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:58 +0000
Subject: [PATCH v19 20/20] Add "test-tool dump-reftable" command.
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
index 700ba10b01..d949b79720 100644
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
