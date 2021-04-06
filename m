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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94BCC43461
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B188613C4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbhDFSsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240251AbhDFSsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:48:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854DC06175F
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 11:47:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1537409wma.0
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bG1nSp9rfJSVvBqkxvkScxaw7IeJkTmHeRV7jpB+hNs=;
        b=D0HMeO4Px56RQJK0vj4Oj3LWstIn5OnNmmaHVQXe4ScybtCSkLf3DrXTu7stj8BHMy
         N542KC7JE8GyNvNlwIChqqjZGi9/iYgsaMCbMf2ZdIIucO2IqNuMOtLPG2pnUWWHvf9g
         bVeyx1PHtBAkvE7W1k1o+UeALni3+1uGO7jrcu0NHMj8LRWE5oOyRBgT2nAkq7ir2WD5
         Y774zlA5ZpUdCk0QwMKDrfVTtjK6yoUfcDgWKxH5kq5VBTloFlUj/6ANEonyIfj2JcSN
         bXdUsGUZEDS57HuJJ3ekh1mKy+0V7jMRkYmuI1upharl78Ht0x1xwaLA1bGE0Vgr0imW
         fQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bG1nSp9rfJSVvBqkxvkScxaw7IeJkTmHeRV7jpB+hNs=;
        b=RocfV5GiBoh4d8QZB6OW3we/GaXMqWvYAm3wVC1HDCnxUusk9950lC8yNgmJz0nesp
         GQPzZWu6SqpS2Zo/YBV2O15s2Z60RYzaPn+bQhaOZMAI88kfv3S31/SHunx9r9lG+lhf
         x3DU1LKC7sXIkAUwoX58fqjMFhJNo+4/JgQb6lL53DkySKs4dnefczHBF3PHt9XuBjRW
         fXHj26wl5xjkQkwIcsh4R+BIRpDKvvlxoosC4EnYPe1w1R5kTFjbenkLRsol1p6/JJXr
         lfcXSLsnieCkZw3ivKeBII0lgWNvPMhe7OJmYOuoY8LL6WtQshKa6Y2ORpgvvAbwlVGU
         1ORQ==
X-Gm-Message-State: AOAM532EodeHHRAMkwYzUD2FXj6QKh08VNOgN/ZgCLLIvm0Lb3UZelBC
        lnMz8uHckbILiDVYCBrZnNMuRo6zqEI=
X-Google-Smtp-Source: ABdhPJzWwW2O/33iJixBZ0VHaacb54sN9n0qI1JWoYDBh7rJop7ER19ItcqgUKob+3RsUSKg/3ISBg==
X-Received: by 2002:a05:600c:3796:: with SMTP id o22mr5359783wmr.139.1617734874656;
        Tue, 06 Apr 2021 11:47:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm32895235wrt.56.2021.04.06.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:47:54 -0700 (PDT)
Message-Id: <bf296282323aa74f7c5b1a49c74d5aaa4b6f37ae.1617734870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Apr 2021 18:47:49 +0000
Subject: [PATCH v2 4/5] test-tool: test refspec input/output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a new test-helper, 'test-tool refspec', that currently reads stdin
line-by-line and translates the refspecs using the parsing logic of
refspec_item_init() and writes them to output.

Create a test in t5511-refspec.sh that uses this helper to test several
known special cases. This includes all of the special properties of the
'struct refspec_item', including:

 * force: The refspec starts with '+'.
 * pattern: Each side of the refspec has a glob character ('*')
 * matching: The refspec is simply the string ":".
 * exact_sha1: The 'src' string is a 40-character hex string.
 * negative: The refspec starts with '^' and 'dst' is NULL.

While the exact_sha1 property doesn't require special logic in
refspec_item_format, it is still tested here for completeness.

There is also the special-case refspec "@" which translates to "HEAD".

Note that if a refspec does not start with "refs/", then that is not
incorporated as part of the 'struct refspec_item'. This behavior is
confirmed by these tests. These refspecs still work in the wild because
the refs layer interprets them appropriately as branches, prepending
"refs/" or "refs/heads/" as necessary. I spent some time attempting to
insert these prefixes explicitly in parse_refspec(), but these are
several subtleties I was unable to overcome. If such a change were to be
made, then this new test in t5511-refspec.sh will need to be updated
with new output. For example, the input lines ending with "translated"
are designed to demonstrate these subtleties.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile                |  1 +
 t/helper/test-refspec.c | 44 +++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c    |  1 +
 t/helper/test-tool.h    |  1 +
 t/t5511-refspec.sh      | 41 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+)
 create mode 100644 t/helper/test-refspec.c

diff --git a/Makefile b/Makefile
index a6a73c574191..f858c9f25976 100644
--- a/Makefile
+++ b/Makefile
@@ -734,6 +734,7 @@ TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-graph.o
 TEST_BUILTINS_OBJS += test-read-midx.o
+TEST_BUILTINS_OBJS += test-refspec.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-repository.o
diff --git a/t/helper/test-refspec.c b/t/helper/test-refspec.c
new file mode 100644
index 000000000000..b06735ded208
--- /dev/null
+++ b/t/helper/test-refspec.c
@@ -0,0 +1,44 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "refspec.h"
+#include "strbuf.h"
+#include "test-tool.h"
+
+static const char * const refspec_usage[] = {
+	N_("test-tool refspec [--fetch]"),
+	NULL
+};
+
+int cmd__refspec(int argc, const char **argv)
+{
+	struct strbuf line = STRBUF_INIT;
+	int fetch = 0;
+
+	struct option refspec_options [] = {
+		OPT_BOOL(0, "fetch", &fetch,
+			 N_("enable the 'fetch' option for parsing refpecs")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, refspec_options,
+			     refspec_usage, 0);
+
+	while (strbuf_getline(&line, stdin) != EOF) {
+		struct refspec_item rsi;
+		char *buf;
+
+		if (!refspec_item_init(&rsi, line.buf, fetch)) {
+			printf("failed to parse %s\n", line.buf);
+			continue;
+		}
+
+		buf = refspec_item_format(&rsi);
+		printf("%s\n", buf);
+		free(buf);
+
+		refspec_item_clear(&rsi);
+	}
+
+	strbuf_release(&line);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 287aa6002307..f534ad1731a9 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -55,6 +55,7 @@ static struct test_cmd cmds[] = {
 	{ "read-cache", cmd__read_cache },
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
+	{ "refspec", cmd__refspec },
 	{ "ref-store", cmd__ref_store },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9ea4b31011dd..46a0b8850f17 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -44,6 +44,7 @@ int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
+int cmd__refspec(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index be025b90f989..489bec08d570 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -93,4 +93,45 @@ test_refspec fetch "refs/heads/${good}"
 bad=$(printf '\011tab')
 test_refspec fetch "refs/heads/${bad}"				invalid
 
+test_expect_success 'test input/output round trip' '
+	cat >input <<-\EOF &&
+	+refs/heads/*:refs/remotes/origin/*
+	refs/heads/*:refs/remotes/origin/*
+	refs/heads/main:refs/remotes/frotz/xyzzy
+	:refs/remotes/frotz/deleteme
+	^refs/heads/secrets
+	refs/heads/secret:refs/heads/translated
+	refs/heads/secret:heads/translated
+	refs/heads/secret:remotes/translated
+	secret:translated
+	refs/heads/*:remotes/xxy/*
+	refs/heads*/for-linus:refs/remotes/mine/*
+	2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
+	HEAD
+	@
+	:
+	EOF
+	cat >expect <<-\EOF &&
+	+refs/heads/*:refs/remotes/origin/*
+	refs/heads/*:refs/remotes/origin/*
+	refs/heads/main:refs/remotes/frotz/xyzzy
+	:refs/remotes/frotz/deleteme
+	^refs/heads/secrets
+	refs/heads/secret:refs/heads/translated
+	refs/heads/secret:heads/translated
+	refs/heads/secret:remotes/translated
+	secret:translated
+	refs/heads/*:remotes/xxy/*
+	refs/heads*/for-linus:refs/remotes/mine/*
+	2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
+	HEAD
+	HEAD
+	:
+	EOF
+	test-tool refspec <input >output &&
+	test_cmp expect output &&
+	test-tool refspec --fetch <input >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
gitgitgadget

