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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CEC4332B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F193622D58
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405706AbhALItP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405698AbhALItO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:49:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4391C0617A7
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:54 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r7so1558408wrc.5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NU5cRWKPa7y72/DAFZ0IkJ1rHgTHjR0ZzUrJGlMlpPc=;
        b=DWH3Gu2SOuLILdNezAXyAY7a5Zd2qzdtTHTJA3fqRbCgpc46/pR/sUk+nQW7yV7WRI
         5RBRFDWEGUw5/WTMXDMdW5DHwzAiNda/0Z9t3mr/bitvw7VmPyPSbSnXFLV9d37kLk8s
         u5d3H+OqdeD+Vyo2VukMdbccR6ai17LCz1JvFrDRF2+pdkgCYblI9IsYXDtTCFWkWN0C
         /hr468GchNorpLMWENlYXNdY/jdBNRfV37bcejhcKbPtNAuj8GACZlC55DUm4hJnTBN+
         /SH+1XbtsJL/u+9tCifllupnJf1U9R89Wh3ZD8WKLFasC7x9m1Wt3hlSp/SXYSJkOHup
         uTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NU5cRWKPa7y72/DAFZ0IkJ1rHgTHjR0ZzUrJGlMlpPc=;
        b=Uiadoxwoopb6kxSOMU4XEMVXvtb0cCHix/yXZLJi0nk13/DaoN5+nGZcwd6TfnBs2C
         F0JDhtuBjZB1j0O9uRQnFLvXzXqYrUqTLzZ/owB7rNeESbr7a2ujcPIDzyYamJFHt3to
         PeI3jGO4vuNs6voajfvvkb6JdNbGItjRS05GqpQITj4uGFzPL55QAzUwSaiFIJMrpoHY
         Z2skj5JrbCJ/lIKDcaSfqO8wHCPA1uqIxbJWcdJFlO54pL/IcFVjYYHTdXZcbSdtq2P8
         Uln57BwG7n1aplx8hPjvaMDltqvzk3yzYe4/9mFfvo9TPhqJNICjXy5V0uPyI65eStz6
         KuPA==
X-Gm-Message-State: AOAM533o5A2AkVHj4t+81eYQmbNn8SMy78tu3y8VdDq3gyFcKgYR0wyc
        3/QAxAGJ0Jx2ytKIHkzX9aiZUL+kkK4=
X-Google-Smtp-Source: ABdhPJzERHDziXVDH+KssatenSJ0bxX4yCDvwe9ycpFeNu/xEbx1JKkB6cjbqz60VhYpK73fjXPUng==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr3117936wre.408.1610441273385;
        Tue, 12 Jan 2021 00:47:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm2867346wmb.40.2021.01.12.00.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:52 -0800 (PST)
Message-Id: <0a56ebfcad79a03a6a8701db367cabb7953a5fa4.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:41 +0000
Subject: [PATCH 10/11] GETTEXT_POISON=rot13: perform actual checks in
 `test_i18ngrep`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-i18n.c    | 42 ++++++++++++++++++++++++++++++++++++++++-
 t/test-lib-functions.sh |  6 ++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-i18n.c b/t/helper/test-i18n.c
index 4b572e6efad..8a16df6b40f 100644
--- a/t/helper/test-i18n.c
+++ b/t/helper/test-i18n.c
@@ -1,8 +1,10 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "grep.h"
 
 static const char *usage_msg = "\n"
-"  test-tool i18n cmp <file1> <file2>\n";
+"  test-tool i18n cmp <file1> <file2>\n"
+"  test-tool i18n grep <regex> <file>\n";
 
 static inline char do_rot13(char c)
 {
@@ -75,6 +77,42 @@ static int i18n_cmp(const char **argv)
 	return 0;
 }
 
+static int i18n_grep(const char **argv)
+{
+	int dont_match = 0;
+	const char *pattern, *path;
+
+	struct grep_opt opt;
+	struct grep_source source;
+	struct strbuf buf = STRBUF_INIT;
+	int hit;
+
+	if (*argv && !strcmp("!", *argv)) {
+		dont_match = 1;
+		argv++;
+	}
+
+	pattern = *(argv++);
+	path = *(argv++);
+
+	if (!pattern || !path || *argv)
+		usage(usage_msg);
+
+	grep_init(&opt, the_repository, NULL);
+	append_grep_pattern(&opt, pattern, "command line", 0, GREP_PATTERN);
+	compile_grep_patterns(&opt);
+
+	if (strbuf_read_file(&buf, path, 0) < 0)
+		die_errno("could not read %s", path);
+	unrot13_strbuf(&buf);
+	grep_source_init(&source, GREP_SOURCE_BUF, path, path, path);
+	source.buf = buf.buf;
+	source.size = buf.len;
+	hit = grep_source(&opt, &source);
+	strbuf_release(&buf);
+	return dont_match ^ !hit;
+}
+
 int cmd__i18n(int argc, const char **argv)
 {
 	argv++;
@@ -82,6 +120,8 @@ int cmd__i18n(int argc, const char **argv)
 		usage(usage_msg);
 	if (!strcmp(*argv, "cmp"))
 		return i18n_cmp(argv+1);
+	else if (!strcmp(*argv, "grep"))
+		return i18n_grep(argv+1);
 	else
 		usage(usage_msg);
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 08731bae854..394fd2ef5be 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1021,6 +1021,12 @@ test_i18ngrep () {
 
 	if test_have_prereq !C_LOCALE_OUTPUT
 	then
+		if test rot13 = "$GIT_TEST_GETTEXT_POISON"
+		then
+			test-tool i18n grep "$@"
+			return $?
+		fi
+
 		# pretend success
 		return 0
 	fi
-- 
gitgitgadget

