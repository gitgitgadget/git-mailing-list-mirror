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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ADBC4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A36060E97
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhH3O7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbhH3O7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:59:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24DEC06179A
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:58:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u9so22850099wrg.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Tx5k9d8cN1SY5mIofDnF0yHom8a5/TcLCrLRdI22f0=;
        b=c3pfcNHh5hd69A6lrmjNL0ZAdkCB/Sngz3e5fR/6FedL9/DwL37p+gXvud+tgtUiP4
         kbOzfJkk8zYhA3ro2FeccDc6kKYpHXrP/FUZ7nfwIpm0T2bPmG6fkWbhlTUeeYVSIEF5
         J2g5wzDhj+KoDRbGaHN8kjud/X8TuaBCPpnmcvYkRBrXiZYi2+bEgHdkDIO/mlWIFJfI
         iERgyQHRu8GrDe3NWrPV+FGA/ALIGVtoE685x54kNGce5vauItw4I2L3C7TxS4IdQQ0K
         f0amVuQJ8/DDpY1RAOhJx7uIpNKGzYGdDQ+kQvTCgl8YBbrM+MHhS/t9Waffu36HG5vb
         J+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Tx5k9d8cN1SY5mIofDnF0yHom8a5/TcLCrLRdI22f0=;
        b=tLKoS2rdICNr8N1Q6LrjPQWw6RY8pc6A/y4GXkqQsERb9wYXLlS/Ywn9gyy5krIWlb
         A/CY4hritYdFUz844JTXvY3jl5CORNGm0Kqf/B2IPFl+mO3VaGnO0zt0fgHZKFVn1TDv
         FoEtNxACk2VT/vjXwpRjmTKIzpqqO7AaXqMLUZxNvXjSQB/JqHM/3v6MnuuD2BU2tX/s
         QomtXcA3bHjY6d0YE3+aP4wSMW/jENuNI7/+hwDKUGz7thkoarjTcoaci4iYF0z0WPhj
         XCAjACEL/IR5HO7InfeOH9T6DtX6nt01YkpvXAwZjyPZRjxSZtE32AwEGR9d81c1Qaua
         A46Q==
X-Gm-Message-State: AOAM5333vnwwNkhg+sxi2uSe6o2u+6vCE+4M6ABpOxTPuIzwXnEI2PgL
        E2viZ2HoyKGQNsZCZaXIyzwv12Wm6mw=
X-Google-Smtp-Source: ABdhPJw1889oiMMeJS6RdPqECnOjX9cDaNJejHYdMWeBKgnQLpEF8p8RKp4o0jbiBB7MKyRMoGL8nw==
X-Received: by 2002:adf:82b0:: with SMTP id 45mr26927171wrc.161.1630335488681;
        Mon, 30 Aug 2021 07:58:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm11400200wmr.8.2021.08.30.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:58:08 -0700 (PDT)
Message-Id: <4fc6b5cbf1674907f9b36cc6bd678d289b83b48c.1630335476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:57:55 +0000
Subject: [PATCH 19/19] Add "test-tool dump-reftable" command.
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
 4 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 8be7e05ff99..3d80975c706 100644
--- a/Makefile
+++ b/Makefile
@@ -2474,6 +2474,7 @@ REFTABLE_OBJS += reftable/writer.o
 
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
-- 
gitgitgadget
