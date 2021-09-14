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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BB5C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8168603E8
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhINOqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhINOpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:45:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182C6C061150
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u16so20623202wrn.5
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LhySsHfzZ3Pk6fo/CeRm0RMkRB5eXUuQvBWfa1uVkPg=;
        b=EMPX1tTF/Ov+kwjwo2A/qPhqnlDW6ITBMR6POqnnzcKGXnzKSPZY6Oh08JCI+f1enW
         zljTXFu7azceJk5uBT9LM1MUasPiXmKThqYTtGRkK8O53PpPnZtsz1uX0vLUdqq+WGY4
         r/TDZj/PCRyY33tZQ7+DDj7msHWQOHBxbObnK1NmS5Jb3CGSThXQXVIXJ6MUFs+ZQzkk
         s0dxMJwvbvC42e6S2FmeOucBo8+8kKYwFlaCgaSv5fVVn5yb2JijJIS2qKUzp3u2XU9N
         xP+dLLY8PdewUIrq8DY2SrirgjFSMSqiS+rqLKiF9+lknquESyz1xMb24wKedtjidO0H
         +3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LhySsHfzZ3Pk6fo/CeRm0RMkRB5eXUuQvBWfa1uVkPg=;
        b=FXwppQMEGgDq9tB3q3ANRLAxlJRZ6vm/RNptgUG1z/mXljXsLeTpyDgEL3Tz1GpGNM
         qiUJi0mFSHWN5PY8+6yTiq6nVA9+v+Vs9xnS05BYvSVr9f9QlNeB3R/NCPBjxjTlnwlf
         KVI+ROlej13bIuBGWJbbjvG9F8ZMz3D68IOEwlkT5mk6zGqL9zHMJx6oE05xmasKOhVj
         8xCu0XxptCXXj7rLhq63vykBJ/dQfsUsyn9/+Pz5xD7ZdvTSA7feTlTN755R5A3iHtMw
         9l8A2dEDbyobXrt5zz9To6g4ZVk+6djoCYBc9LckE5BuqKRNspU77IJsKnzIoxieBrOs
         RT3A==
X-Gm-Message-State: AOAM531nWWaOmqtHzwHzzU0v79HmTtU5PooFZEgAr7YRV42z7REF9Cit
        1V/1N7mvHNL1ikTiA/bf6FtsBGUF6dc=
X-Google-Smtp-Source: ABdhPJy+TtjJrqxnUIBBl00OYYWan5r/QM/COsDsfFeAn7/dM+oagED5954JNboCO6RujswkONbHPg==
X-Received: by 2002:adf:d214:: with SMTP id j20mr19484898wrh.119.1631630367777;
        Tue, 14 Sep 2021 07:39:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm10559002wrc.55.2021.09.14.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:27 -0700 (PDT)
Message-Id: <7539725bb4f1cf560b604d2b32a3682b4cdde46d.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:16 +0000
Subject: [PATCH v4 15/15] scalar: accept -C and -c options before the
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index 728166aa97a..76a77ca1ed0 100644
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
index 6fc57707718..3a80f829edc 100644
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
