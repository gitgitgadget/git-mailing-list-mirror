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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1955C43460
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E58613A3
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbhDENEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbhDENE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 09:04:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E50C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 06:04:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x7so10862626wrw.10
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5L7gpGfJ37qujqIwEpILGJe44hZo32Ph3clz45KGZjY=;
        b=VbGxMv8LhwRMKZUYcu6ozGYMUmn1f0omcMYV4MFKFcueq7RFmzJH5t79d6jYm/SnIN
         FhsSGm31lgIdfE+AMKeZZVX3sGP8PEleKtocy+faoXgySZhbPFYg3jnnla8S3kBc6noE
         UZacba21vW5IQLNw78glZbpY0pdRAcMfDwCIHEFDZfk+rb2K1yNncRDMXhA8pEfPwWG0
         BKTy6iFZ5Ksa6VVR1vUBaEhuxZpivQdY2CRYv3xNpGfM0PE/fP31mBwoOkxCXebPVFT4
         Mf48Ey1wd+HkBmGxOXR5JOg5TYinY+pYqYYUm5/apBWS86W87Heqrpjf41m7QtpmHfk2
         lpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5L7gpGfJ37qujqIwEpILGJe44hZo32Ph3clz45KGZjY=;
        b=EPWzv+bXRC6uyWvj6KDytZlCqaEpv7O92gJu2WzM5U+NB77CjaY6Ru5bu8hvFkjabE
         9gfKXEKqHfQIrihb0i7xZTWNCIO5AYNk/4CDH9bOCnmQBgQ7DYSpmfgmKlzS+xg1So/c
         ObVXNveJ2THa8bH2virNzFxRoEHL1o59dKTMyP2dJJJWj6eHw7dnAZzDlsckyjkf+PO5
         FliQ3UY2DVmH41CgQKESxgaDeYugEKeyzUYT04i4UtkiEbw0r2YtpDo9Dmm8ZQPvxbBb
         mhVyv/zyt8bk2L41Kv+9FFJIUMeFhG4ksTd26LCiFG02akxbbM2gl57nOLh27SiOt0e+
         GGRQ==
X-Gm-Message-State: AOAM533ciHO+t5MNb+cc33Gja4dwA5yhNq2O4E0n7urqbhDnGIjF9zO0
        xT2ammDbLj/7+YKQdnYQO9FtjlCbuV0=
X-Google-Smtp-Source: ABdhPJzDMSoKGk8PDA8OUjTpC6MTl910SHjrtThJfAy2bqSBpjxMLmkbf5n7kYr/Nlgm0VvlgeAdYw==
X-Received: by 2002:adf:f14b:: with SMTP id y11mr1901235wro.79.1617627860601;
        Mon, 05 Apr 2021 06:04:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6sm15704676wrr.21.2021.04.05.06.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 06:04:20 -0700 (PDT)
Message-Id: <c8d1de06f84499f2f56b3a06df665630806f94ce.1617627856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.git.1617627856.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Apr 2021 13:04:14 +0000
Subject: [PATCH 4/5] test-tool: test refspec input/output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
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
 t/helper/test-refspec.c | 39 +++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c    |  1 +
 t/helper/test-tool.h    |  1 +
 t/t5511-refspec.sh      | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+)
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
index 000000000000..08cf441a0a06
--- /dev/null
+++ b/t/helper/test-refspec.c
@@ -0,0 +1,39 @@
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
+
+		if (!refspec_item_init(&rsi, line.buf, fetch)) {
+			printf("failed to parse %s\n", line.buf);
+			continue;
+		}
+
+		printf("%s\n", refspec_item_format(&rsi));
+		refspec_item_clear(&rsi);
+	}
+
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
index be025b90f989..7614b6adf932 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -93,4 +93,45 @@ test_refspec fetch "refs/heads/${good}"
 bad=$(printf '\011tab')
 test_refspec fetch "refs/heads/${bad}"				invalid
 
+test_expect_success 'test input/output round trip' '
+	cat >input <<-\EOF &&
+		+refs/heads/*:refs/remotes/origin/*
+		refs/heads/*:refs/remotes/origin/*
+		refs/heads/main:refs/remotes/frotz/xyzzy
+		:refs/remotes/frotz/deleteme
+		^refs/heads/secrets
+		refs/heads/secret:refs/heads/translated
+		refs/heads/secret:heads/translated
+		refs/heads/secret:remotes/translated
+		secret:translated
+		refs/heads/*:remotes/xxy/*
+		refs/heads*/for-linus:refs/remotes/mine/*
+		2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
+		HEAD
+		@
+		:
+	EOF
+	cat >expect <<-\EOF &&
+		+refs/heads/*:refs/remotes/origin/*
+		refs/heads/*:refs/remotes/origin/*
+		refs/heads/main:refs/remotes/frotz/xyzzy
+		:refs/remotes/frotz/deleteme
+		^refs/heads/secrets
+		refs/heads/secret:refs/heads/translated
+		refs/heads/secret:heads/translated
+		refs/heads/secret:remotes/translated
+		secret:translated
+		refs/heads/*:remotes/xxy/*
+		refs/heads*/for-linus:refs/remotes/mine/*
+		2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
+		HEAD
+		HEAD
+		:
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

