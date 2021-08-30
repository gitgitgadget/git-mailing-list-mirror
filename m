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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B55C4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1986560F6B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhH3VgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbhH3Vf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:35:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C0C0613A3
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:35:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n5so24300502wro.12
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MWZdHmohQeQE2UCXWW/9nDlOfuPr71XLREstSuWpq+Q=;
        b=XqyPgTJtu2z9z2ydRaj0Zl66Xos6vvcNqWAALPDYVDdta/xnBTA4IOKlWQJogzS7FW
         KLH/1V0/3WacB+0qV5CKK7QaayykpNw4JrF5a2K165OtxkO/SWa+feHvA9J6upeIsN2t
         aoRfa1OX5iy8RJyRmp9vogJkWPSVkarNlVSKwzWzPLDBv7DsEYr+t35WI+DSq2XvCNQf
         /eQ4R65HBVHIDGBwvOBDIKma4Qf7SFOqcn0tJGI5jHMAuyNSbD6jqMma6c1HswZvBZt3
         nrJq1puNxzhS5aGQA4RBcgk7UHRf9jOXPrdRFI04i+r8X8PpApjuHxwj2peYmYpyt3kS
         YwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MWZdHmohQeQE2UCXWW/9nDlOfuPr71XLREstSuWpq+Q=;
        b=m9kUNL9NqF4SW2tpJA33Ita8cNm4n4h7QlKDeHQcDH8eTrdo2pz7GdBXH30EADVFcv
         p8+w8807pyL95H+l0dIg5SJr0aaVi5T1QS15XO9drjfTCyYNYC6RCPUUfb4RjQvKKjRX
         yMlgibnuGJlH1s/VsRACxyxDUZN+F0VIqzZyH26i9LFumc5MUim4qVrRZI8aH66WxJ6z
         THjmrbpotR3cqUTjR6jjupqzf/ZE4HBwuL6TQlgseaAjHcSkA+lM+NzSjTsPY2QGBqLi
         oxCENvRaKUu+gEyZDV3QTEtTbpwWRLmJyGHUdqOzS6SfDtIz0Z5REjzBh4hQ0igSLiEa
         WiGg==
X-Gm-Message-State: AOAM533IFfAZYJQ62TxzmGj4APulGCpwhBmsLieOUi9fuS0dc7ggy4wE
        p3nM3yim8hAIb06y16T8JGVS80DJHH4=
X-Google-Smtp-Source: ABdhPJy51LvgUFFC3rvdUDYTUKDEufmqCN1MrZjTd+xYMaxu3G4xr4EqoIOoVggSMIikd2O+8dWdZw==
X-Received: by 2002:a5d:55cd:: with SMTP id i13mr27879766wrw.366.1630359299052;
        Mon, 30 Aug 2021 14:34:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm19544124wro.81.2021.08.30.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:34:58 -0700 (PDT)
Message-Id: <73d08c0c8948340f6c08c1689b40900062db5b4a.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 21:34:49 +0000
Subject: [PATCH 14/15] scalar: implement the `version` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The .NET version of Scalar has a `version` command. This was necessary
because it was versioned independently of Git.

Since Scalar is now tightly coupled with Git, it does not make sense for
them to show different versions. Therefore, it shows the same output as
`git versions`. For backwards-compatibility with the .NET version,
`scalar version` prints to `stderr`, though (`git version` prints to
`stdout` instead).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index c616e91231a..be0a49b0d75 100644
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

