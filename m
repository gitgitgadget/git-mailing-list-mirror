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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F902C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688E5610F8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350769AbhIHT00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350652AbhIHT0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:26:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B6C0612A9
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:24:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v10so4872892wrd.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DzWaDgTXC1omxOfvIpIv6ED7EgUWF84GI2Icdo7yhYA=;
        b=a1hqkVEjG9EepFjUFarM5HydwSo0axIWjnYQFwxViCbOsxRAoViWGnkv6GnQ2d8HOo
         4vV6T+q8dCXPhPkTSKI2+NkGxTuEi4lNcr43t+dcqkj/3VSRlyOTgE4clBjw2VbKjaVT
         MOM1TtwYc+Ou66R3RxUkchDAdzlYUIJsC0tbxnJAlk2b4P1JjF5WpFngNr6KEwUyPmQY
         fIF1FwH6Yf7UdjaRWU4lm9AacMsDMSw4pyF/66pjDJAoniE383Ne+jxJpN489toHuQZw
         yNlpT95aIc+/M/mRvpV+uQPU3IniSeH5Sf/XjxE4JT/EHK8t+CcDVIB6PmiZXwjqOcld
         WM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DzWaDgTXC1omxOfvIpIv6ED7EgUWF84GI2Icdo7yhYA=;
        b=GC1RPkD9akREt9nBQ24IZ5TldRFPRnqT0hvoCAaZRRlEwlNPZAguZYnTi2/7jpCHng
         JcCVESdSGInLFdE2GabjsAtduB97Mra0qDHJAMDGvVJd97OPpgAzvq+IuLVO/JKO+Hzj
         dStXfUXOkGRYXewjyGy4kApCfajSLRgoKYino6tzaLciSmG8EpLRq2Uh0UNjZ11Izc6n
         i8NlYWaRKF9oPQyiq8Y6cgD3BpfqjeLwhU4beC4ek/3wAMN4geLuwuL4XkpL25p0vAjX
         OHk3BoI3rYCuRrS+j8+My+jxYvamChzakeBk66DH8urV9bLnYW6XXz8AoKXwM6PlHb5B
         5LpA==
X-Gm-Message-State: AOAM533DIjsCKsSiq6uTB/p25ZzuW0RAh8C9GRarOkwfuJwgCcOPdCg3
        ql+aI5oeaxBzmCsdlNXSgXpIkUdFZEo=
X-Google-Smtp-Source: ABdhPJxWAJYZSXeASPGv4rWiHngYjT5dF9IqboCp07Xjth7gwt35Yw7IB5XcpUwlQoOAUWnmvL3xMw==
X-Received: by 2002:adf:8b03:: with SMTP id n3mr5751200wra.439.1631129095857;
        Wed, 08 Sep 2021 12:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm20859wra.37.2021.09.08.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:24:55 -0700 (PDT)
Message-Id: <d2cd2b7094b5a727a0d57f94b51caf7c6d8a44fc.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 19:24:44 +0000
Subject: [PATCH v3 14/15] scalar: implement the `version` command
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

