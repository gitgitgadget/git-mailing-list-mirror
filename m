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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7189FC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7AE610F8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350455AbhIHT01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351992AbhIHT0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:26:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0293C0612AC
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:24:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso1985127wme.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LhySsHfzZ3Pk6fo/CeRm0RMkRB5eXUuQvBWfa1uVkPg=;
        b=SIqYEuzDASsR58XiF40VKK/Hor0MluVwtkFnk2k4LHsH9sKxhafqEn3l9iN+xtqzT9
         3hQm2BjAz+hfMb2S52sadl3tQADc227///AX/+zCmmgYgkNlessFOjVcHGPzDcYnC96i
         3T3nfoLwQ0LcuxjckaETfbWC2eDlQP7Qm0a+E/Li1UInImu0fycyN28EGGOjcXPmYYw2
         fDDg2lcZyPjrXnMGxoNzXwjWLYBxC6Tw9PRWbWZh7tCewxXqp+H2z50Q8nVIWL19CaIL
         QHZL8TSCxjHrO4WwnPim+N6OjFg/mYJ5vuG4m94sm8w1muK7XaZj7ijBw2fYyr3LVguS
         2zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LhySsHfzZ3Pk6fo/CeRm0RMkRB5eXUuQvBWfa1uVkPg=;
        b=LWlNIlJvouukmVzXawKqKFC9+DFCMl6wCWQ7rz3uKsYBy80knWOzgcMl1q627XHfgD
         yguqna8LlIj/XDbWN3EIIY3VkpSgtXvEiij0LodE/vsHiWQE1AXA4RGSstwHo07TVQKU
         +lCN/oqrT6ppII+5P8xnawbvgU6HbGSElZJFyEtUavl/gW4XQPRyCd68MU24zpeNdhqg
         kELm+EC3WVu/MNeWqReHhhMSaPA2XpjJklDeQeJdVdiPhH/VelZFEGqVhfoW3Ib1sYP+
         MgDjYWHUePGB9NfBlg4exrzusx68OHzneCPauPD95Ywsw5kFTStsVpVaXOwrkgrl52eq
         4Nuw==
X-Gm-Message-State: AOAM531IfSmgQn0eammG/Tk2XfaNwL18OhfuUGMHrB8khdI7dOGGI7Yw
        ED/GQvTeOQPC6gElamHiZbBYRJFMHCE=
X-Google-Smtp-Source: ABdhPJwkVfXWBFggyTZnCy7HkxPTY/9Qqah72PUQiK+dK2wuUiaVXJpNIiGXkiE9tNbuDqepY4SRSg==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr5047894wmd.160.1631129096473;
        Wed, 08 Sep 2021 12:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11sm47821wrx.9.2021.09.08.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:24:56 -0700 (PDT)
Message-Id: <7ccc4f8b9b0f5b33aafeac460bcc646e7236aa4a.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 19:24:45 +0000
Subject: [PATCH v3 15/15] scalar: accept -C and -c options before the
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
