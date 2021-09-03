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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286A8C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A40660EB7
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350326AbhICR4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349828AbhICR4F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:56:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBEC06179A
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:55:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b6so9286542wrh.10
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BsAGDFGLhRqYi9vTVMUW8yX9i6zMEpw9zNCA9SH9xFs=;
        b=esA9Nt2w0NEpEZx+TNNSJau05VpzDYSVK8WkldoOSpRiA8uDCDh3gUeNJJLJLjtGDv
         rsk8rHTgmnAEaIueHkS19gpRhQs0Sp2xSVYP2eWdPpGOymFfFpvqVExXsqqYx98vI6WL
         +IzlhV1xwOMg+AfRW0R7cTHYKUhvk3gzSgoHtN3b7xhpo4XACWDmpr8I2gudUVAv7QVy
         MrSeOCz1rmSxO81oPGudGdaMTnSCF/+pxghW4c9MY1EGya8/fE2VNeczgfXxsL1pi3kV
         OkX98FQ2wJ1lMwAP4+eseTsKXrLsGZCWiZcVORjg6Q2SmDmNyJNzDUn3k+SMyJRl+D6k
         7M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BsAGDFGLhRqYi9vTVMUW8yX9i6zMEpw9zNCA9SH9xFs=;
        b=ii/rNa54Dr0MQnOjg3gQTcirEdTPeZNWW74IQsWS+OKFhWRs6s9fQDxb8iLXqeZ3HZ
         kZt3b5b4H51SjrNT3piLhe6dlLTusnJSPtnrmxWA6IhCzWHCu7cX8fIFOykxwBqYBv7+
         E4WMmssfClPIadmmDw4bQFyXRKCnbhFIC3MO5gefTXy4Xi1IxlkZJPHX+l2L3lsA/8aZ
         Tp+w2XrZ7Z7AFMo9YYe299PPZRoOxYGWPOLvAYuPl+TnpVmcZtXM1eAJAUMzPoIeo4Pj
         LORcv3U8eNu0JIZBZw8eyAT4CBWIy4LhJ7KhboHMc95vxWFVud8i2/z358BIJUGmL40A
         R9Lg==
X-Gm-Message-State: AOAM532JGm07cR6TV2ys8RxCKBwisXIhrUcj0cWKby75P3zaXngCRJWO
        wwFBIpmNG5D3LOv+IjjGjSuY0csCXAg=
X-Google-Smtp-Source: ABdhPJwQsL6TkkrUGpdYLwGWV+rD12ag+BR9x4fer/KqyVve1KOUse8e88rvZXcPQyR7dXFfj/ELhQ==
X-Received: by 2002:adf:dd81:: with SMTP id x1mr319299wrl.362.1630691699207;
        Fri, 03 Sep 2021 10:54:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm45285wmi.24.2021.09.03.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:58 -0700 (PDT)
Message-Id: <707d8e19683c5381c989a3f5dc32148bba3715bc.1630691688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:46 +0000
Subject: [PATCH v2 14/15] scalar: implement the `version` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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
index 822d7c39903..e3349dce47b 100644
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

