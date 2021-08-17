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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC6C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C54860FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbhHQNnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbhHQNmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:42:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D314C0612AD
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so11573359wrn.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jj9DwCQIpGbnYzigSuv8p5aLQnNcenzfOzKplhIMnXw=;
        b=Wcz6l2jrbNHSX5oFsb5+Kiw/qFE9A6kmd8KkE7Ofr/EkVXpZaxSTFLAOlQCezo2lch
         eIZbfSAhgcuZGBQD2u6sfygif7A5Rm78cAFEHhMae7+wlh/EC8x6HX4bLyOCj0nnauvO
         fgh0N4CSjFy+mywMLmuiq9Rcr9NEl8GS8WEWYDG6ZykGxMJr0s6HxLUE1w3aLnuk5/Tq
         Bh/gg90BcUzVYoRYYWxmJfdAm/D9YIQxQjcUI1oluoqsAA5y/wyW8VN+ECAy4RlR62v2
         ckjRm4Nkc/uO81Rr+gHPG6Sx/aQVnnaSDwYUDTTOxKNFrNfpxjjY9cKn3XscAI18G4Hv
         qa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jj9DwCQIpGbnYzigSuv8p5aLQnNcenzfOzKplhIMnXw=;
        b=CQcnj+UDZ5EoJMMqCJDRtjgFCIzI1Co4s1Gcg8zgeN/lmCCKJrCZdgq5CXyQAxpDdB
         2Z+9kXvPQyn4/OVcKSVDZLBBMErL5BpkVHl+Ere3BOt2H0RWRlnVPxlBAMQTe7qFSJr/
         OfHmwWPaQDo3H8yzDLnnRC6jvB4G7j7Y95mDjQ4Y4flxiUcCcgWky/I7DF3sAghPHvcl
         19YUcE7+XaFYS/ws+ZmOqhe0QhoLPhIn7prytuqo8zgNrRG/DVAgJOqavhi+Q19QcuW9
         vJ1x7uuUzS8QTbHiWgEcJ8l7jDCROr14El784Iec+tiFTOIDTtUfvbWl3nPXdl0wFpcO
         SaUQ==
X-Gm-Message-State: AOAM530rQaFU8lKh/rgL0q3MvgyfdXy4sy3Y5cQlNTaakkiy1CwFO9tX
        gN/j5tzsareIXJnH0h6f3O5tgRXzaME=
X-Google-Smtp-Source: ABdhPJzN/SCzkZvmhZmlVV1eD0ZmKR7pHA8CYNZkuNqNvCRqNJ4gUZ6IInJbHDWoNcJmD0Mf9unHmg==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr4144405wrx.280.1629207648984;
        Tue, 17 Aug 2021 06:40:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm2522925wrq.6.2021.08.17.06.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:48 -0700 (PDT)
Message-Id: <b305fcd49f1911edc723948d7b2a0a444572c054.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:40:04 +0000
Subject: [PATCH v3 22/25] Add "test-tool dump-reftable" command.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
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

