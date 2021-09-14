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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19305C4332F
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA88610CE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhINOqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhINOpT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:45:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B552C06114E
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso2298467wms.3
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DzWaDgTXC1omxOfvIpIv6ED7EgUWF84GI2Icdo7yhYA=;
        b=Dzmos/u0FphbGRWAnqPnAUiu/Ec5P/JxMkkKpSJDaCTv48Bi0Ut5PVoDTt33Hpb1uk
         59zD/EOax3COMMsPZeRvzG9T1e/2tGvpDpRsxY4+QhkABZ7sdy3QkdzvRkZ8AFvn8gZQ
         LmG2ChoXgaV3dKVFlaN/TLLOz+a7zNwwkkoy6gkv3K5Ezi4kMm0I8ghiRHp92qZmVOh0
         BSGaN1V5tHPQw+dJDjhu/wSkkjpB4gs8oK03LARZnZPXKWeI/xBBQi3Ooutwl3towGRv
         N6A2ydPWOJVggro/0J73ztHKGeb12jSHIPnVolWED3MeL52rMIe5CXskC8df76LPEzbw
         R5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DzWaDgTXC1omxOfvIpIv6ED7EgUWF84GI2Icdo7yhYA=;
        b=Q1b2CaGhxsd54F3Ps47/KEXQ/xgiVrpPTun3sz2zt1/RB5gMo1Cr22LCWIewTid+h7
         w4CAuQREP6IsaOVUxUyJJvfAmBoTV/zMpzP7Qsh8i4E5pyfoi/CGGSqa8Yk0S5Gk5IP9
         yaglGTZhWa1prkUEo0WMCOpgoccaQPJtZ9RwqA0L0Ah/NIWDkoM0M/Z1dP+Jv5ILu0BV
         iOYLzr/x+0RR62ft1AWFxFQHrDcs4AUfLi601zZiN1c9Z5Z5Lfmb6qUDXlt0sU4ZW0Fz
         X+Qu7yipMGfS9Mqr3gkETQwCktWHinzDTrkVcx+RmOCIBCDoO/eldSZerRBve75iAG+f
         jhNA==
X-Gm-Message-State: AOAM531jjfz5xnt4AbHkG/e6vSivuY6puogAiNby7sYtA7nM/vqZkuZZ
        AYc60KUSEan9OybcE/dsEttMgo2JUA4=
X-Google-Smtp-Source: ABdhPJz1TpQO4WiN2j88UROkvtZqyPSXpQeJNbkQDxvg30sjA7uneWh8qtrkqOpv/gzM1hAcSRNqEg==
X-Received: by 2002:a05:600c:ac5:: with SMTP id c5mr2000323wmr.191.1631630367224;
        Tue, 14 Sep 2021 07:39:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm1579327wmi.18.2021.09.14.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:26 -0700 (PDT)
Message-Id: <069957701204f311077c43af1fd4a42519ef758a.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:15 +0000
Subject: [PATCH v4 14/15] scalar: implement the `version` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The .NET version of Scalar has a `version` command. This was necessary
because it was versioned independently of Git.

Since Scalar is now tightly coupled with Git, it does not make sense for
them to show different versions. Therefore, it shows the same output as
`git version`. For backwards-compatibility with the .NET version,
`scalar version` prints to `stderr`, though (`git version` prints to
`stdout` instead).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 00bedb0bf66..728166aa97a 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -9,6 +9,7 @@
 #include "run-command.h"
 #include "refs.h"
 #include "dir.h"
+#include "help.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -362,6 +363,15 @@ static int delete_enlistment(struct strbuf *enlistment)
 	return 0;
 }
 
+/*
+ * Dummy implementation; Using `get_version_info()` would cause a link error
+ * without this.
+ */
+void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
+{
+	die("not implemented");
+}
+
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
@@ -748,6 +758,34 @@ static int cmd_delete(int argc, const char **argv)
 	return res;
 }
 
+static int cmd_version(int argc, const char **argv)
+{
+	int verbose = 0, build_options = 0;
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("include Git version")),
+		OPT_BOOL(0, "build-options", &build_options,
+			 N_("include Git's build options")),
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar verbose [-v | --verbose] [--build-options]"),
+		NULL
+	};
+	struct strbuf buf = STRBUF_INIT;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	if (argc != 0)
+		usage_with_options(usage, options);
+
+	get_version_info(&buf, build_options);
+	fprintf(stderr, "%s\n", buf.buf);
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
@@ -759,6 +797,7 @@ static struct {
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
+	{ "version", cmd_version },
 	{ NULL, NULL},
 };
 
-- 
gitgitgadget

