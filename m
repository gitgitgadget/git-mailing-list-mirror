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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A831C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831C360F90
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350343AbhICR4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350317AbhICR4G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:56:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED3C0617AD
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:55:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b6so9286563wrh.10
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t/eIzhwovFI3t2Rg978t5CdOD1709srpEVkUHiGBJR0=;
        b=AMUcAYl9iVw0wuGyvopsuSkLxXZCZ9u2/JSCCGxIFyq+xMpzOBUqKz3s4TtynZaS2L
         bbpr3oLkDrM34HhzUCDXJ/9cvxavtHMAep9Ua7l4y9J5FXrr539JVah2hnh5MAKXyt38
         WEFzYYxfObsTQFfxxolxOxQvl2rKkt2I2yX8Uomsv8iiKlqvWfvWjgAdTdcmL7hue3dC
         L2dezQybjWKUKxODsNOI4KETOVXPUMW3EwWA8ZYj3DFx4V6+Cb3F4jArlhhexqRnKWbD
         1yfRg13c+9oN4Frx1MWofPI9h8y9ypsxJui2VPj37LzIHr5HB4SIy3ICdRoWIIl/AXvT
         SdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t/eIzhwovFI3t2Rg978t5CdOD1709srpEVkUHiGBJR0=;
        b=Ze1xSvhpFtllFzuXUT7vF4FJLNqsyEORHMttLfB0K3aPMV98gGlK1V8MbBJEnhlnWf
         SJAjHNhljZmhZnD2FwLmFvW9q2//Su8giDJKwTCBlYENUzS7SIoPmrnyuDT+O5gJY6JB
         G4D4qDQJrxOizIBrzmU4g7jqZ2MgYhgM9rCE0Aa/7gDzxEknXwIrIHI8Ufuic8O7zfOU
         0CAWeOK0K359QOJcf5IeOIFVaLEdh9wmhNZVsvxQ7iA4HJr/Qp2G+vF19v+IEG96OT+Y
         CF9bsmvyP9A809hH7PPrgS1BYhc6/mwVfhCCHPSN2Ok+/RVDfsxB4qiuPzOd//X7Zpvg
         jdxA==
X-Gm-Message-State: AOAM5326mtj70iT3oBOP54Yh5eHlAA3yc0YEcu018I1fLA1wNlAyhqv1
        ptQ5ZOe9VZZPx8MuinTrOSouq+4c97g=
X-Google-Smtp-Source: ABdhPJz5WRzs/A33ib5ToXrqtQw9MKSGImLWvclTdw0LGQZRhQywHClkThJq03+g8Gb9TFkSf7DPrg==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr289240wrv.117.1630691699736;
        Fri, 03 Sep 2021 10:54:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5sm5253762wrr.94.2021.09.03.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:59 -0700 (PDT)
Message-Id: <26e23b5c5e5ab8727465fe4a78e6d9bb2306d5ca.1630691688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:47 +0000
Subject: [PATCH v2 15/15] scalar: accept -C and -c options before the
 subcommand
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

The `git` executable has these two very useful options:

-C <directory>:
	switch to the specified directory before performing any actions

-c <key>=<value>:
	temporarily configure this setting for the duration of the
	specified scalar subcommand

With this commit, we teach the `scalar` executable the same trick.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 22 +++++++++++++++++++++-
 contrib/scalar/scalar.txt | 10 ++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index e3349dce47b..670a259a12c 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -806,6 +806,25 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf scalar_usage = STRBUF_INIT;
 	int i;
 
+	while (argc > 1 && *argv[1] == '-') {
+		if (!strcmp(argv[1], "-C")) {
+			if (argc < 3)
+				die(_("-C requires a <directory>"));
+			if (chdir(argv[2]) < 0)
+				die_errno(_("could not change to '%s'"),
+					  argv[2]);
+			argc -= 2;
+			argv += 2;
+		} else if (!strcmp(argv[1], "-c")) {
+			if (argc < 3)
+				die(_("-c requires a <key>=<value> argument"));
+			git_config_push_parameter(argv[2]);
+			argc -= 2;
+			argv += 2;
+		} else
+			break;
+	}
+
 	if (argc > 1) {
 		argv++;
 		argc--;
@@ -816,7 +835,8 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	strbuf_addstr(&scalar_usage,
-		      N_("scalar <command> [<options>]\n\nCommands:\n"));
+		      N_("scalar [-C <directory>] [-c <key>=<value>] "
+			 "<command> [<options>]\n\nCommands:\n"));
 	for (i = 0; builtins[i].name; i++)
 		strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index b7ace8b9f1f..5804baf7d70 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -36,6 +36,16 @@ The `scalar` command implements various subcommands, and different options
 depending on the subcommand. With the exception of `clone`, `list` and
 `reconfigure --all`, all subcommands expect to be run in an enlistment.
 
+The following options can be specified _before_ the subcommand:
+
+-C <directory>::
+	Before running the subcommand, change the working directory. This
+	option imitates the same option of linkgit:git[1].
+
+-c <key>=<value>::
+	For the duration of running the specified subcommand, configure this
+	setting. This option imitates the same option of linkgit:git[1].
+
 COMMANDS
 --------
 
-- 
gitgitgadget
