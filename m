Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144DEC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6706137F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbhHWMO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbhHWMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6B3C0611F9
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h13so26008957wrp.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsFNB4672AflYQ2bGOc0TShLbF6K++ZmZ6/fh+3QM9Q=;
        b=f096dRBDk/CZRuLFthEaVH3QZFosyTOKjxNa8LhVUFAs5ReiTv8Ug0qjdGWoD0oeUS
         S+7zr1Kk2km9bA8eLwka4hkv2RpD92h7GP0LwmUnnqIIRSolp3E+vhWmUB/BUjotAl7T
         SWEBA6SPv3FCbv2fLc0rLAcHksQoe0XsH+KW8ZQafBQUhuygoKrS3n1GuUoO8oRAJjLU
         DjUcwh4KG2yCR+fp2tze8NUYyqC+otDwBDWs091g/ZnlD/lcbbJqSQLiIt/dWqPIjyTZ
         87a04zII8+lT4W1sFv4uvjJPmlG4dguMGM1wIFK11M0Rh+fEphEnmqnqodWoXIo8kjQ/
         Eukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsFNB4672AflYQ2bGOc0TShLbF6K++ZmZ6/fh+3QM9Q=;
        b=oTsFlbK1aVoH8gDU26a5+wnVTc1ZAYwhH1SfQYr84KeQ3/NQQDVTvzNioTzksF91cg
         7gQgkZcRTu1nv7KaWiZZauY/C+0aMOJtPjFe0HjOzrGyUM0l5tFseG6CRQaj3wqIhFKg
         MHZiNqTkpbk1XVOFsL9tgMA442MEJ/q6/SY/T0z++LxIWxxSwMVc9z8NaS2F7V232biD
         bDqnhLcOwasBhDW+1jCB57lheGl84Foq0IstVvuHcJ2DiQXFEh7pHYn+ynGZpBKLgYCe
         p4/s4QMYeehIq5r/i34/VEQACXwHBvfXMaLdbfwcEYaBkuPp89KHAEuI4oQPshjRqe4H
         hdBQ==
X-Gm-Message-State: AOAM531W2dTsMq1m1TPiBSRVG8n8Izz+dKxr5kG+/fMKIjGWmFRYqozK
        HptUS7mT29EqchuGKCV227YhNYfVAU0YO4Zd
X-Google-Smtp-Source: ABdhPJx2AQvwUgW+tbNTkbhx9FXhlVHt61AeIwNU+XWDl1ClsUrI9Ffm5oL5YzObKQ2uoeREgpeosA==
X-Received: by 2002:a5d:64ce:: with SMTP id f14mr13142831wri.17.1629720794629;
        Mon, 23 Aug 2021 05:13:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 22/28] Add "test-tool dump-reftable" command.
Date:   Mon, 23 Aug 2021 14:12:33 +0200
Message-Id: <patch-v4-22.28-f76e7a7bd10-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.33.0.662.gbaddc25a55e

