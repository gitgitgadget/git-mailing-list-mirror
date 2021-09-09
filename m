Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDE9C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B8D61100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhIISuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245645AbhIIStP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:49:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA8AC06175F
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q11so3939455wrr.9
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vy4P0I34I90yBXSPW4HKvPnrTIWXoEj7lGW0PFnr3ZQ=;
        b=B8wmPhbqicsngZIkHwOMrxheZS4USFz2VjKv5W5EQ3pDCH20ymYANTQDzZBEcSwWHL
         3aAz++ZgMRTHT3+FvlqP1Z8dQhzIsXjlYsk1ZKVLDPyiTfT4uU/8kvfyEk8hdR38Z1Ew
         9eRWMT0qOqKgrmdpM9s9JEjDYqR8RJjszKwz5QEK3a3F00hyGu214OVhu67Tnql22Xjq
         Ve/YJtjCX1wslAo26XUld7D28dBISNHrE5hak1w5jZukxMIB0Jq4mCUyria1nRAIuhNd
         yJbtLHPLElpd5UbzQBHM2kF6J6fK+CnTY/8MbWWvPnavLgtEyPKMJbu8c30TtfhpwYAE
         bicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vy4P0I34I90yBXSPW4HKvPnrTIWXoEj7lGW0PFnr3ZQ=;
        b=GB0gObLe56b1MJZ3YAqKn5Vfco7fnuV/rYn0TnmfAM8UIg0e94PacrdKNaAZfq6NBq
         1lbGQKKxQAuSGiw9rj0h/XRTPlKbXJOT5AAihF3s+9gh3z4Ulq0cyxtX1bbQKVsjC1+e
         w3tGhmtM3mL9m7tq3WRnS9N1FMLiqnj5PABVAnNdK6kvoIyH6ksEMuYmOUSa7FjcfB9T
         +COnupRpuqo7UGMZKxtx6utYEg5fDPujCW+eHzW8Fox4+izpxHG6bAiNE5YiRSXO8tNJ
         MerERaRd3117GEDHuFkMqHZZ7ey/B88pL1iis702nWLyjDaonMVgSlerM/+bjgGIS/ng
         umNg==
X-Gm-Message-State: AOAM531fU4NX8YTwvceQUjnkJQ+KUOFtXaJHXlLrWvduChc8TQJVmLUh
        A7nySIqTDXCtarrtCohlM1zB/ozuiwY=
X-Google-Smtp-Source: ABdhPJzEnn0qI/oJbijcIXm5GzkCEBeeqP3ycZ8VdzcmDa1XPFhEk1s3bjIaTTNJ9TQoZgWpFYL2oQ==
X-Received: by 2002:a5d:5241:: with SMTP id k1mr5460798wrc.14.1631213278116;
        Thu, 09 Sep 2021 11:47:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18sm2372907wrp.97.2021.09.09.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:57 -0700 (PDT)
Message-Id: <104fbc7502ffe3258d74bef240c7e2f5d91219b4.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:44 +0000
Subject: [PATCH v2 19/19] Add "test-tool dump-reftable" command.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index 619b1b15ce0..8ec68a70405 100644
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
