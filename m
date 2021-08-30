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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE7BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BD260F6B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbhH3VgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbhH3Vf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:35:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5EAC061292
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:35:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x6so16173504wrv.13
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zmz8nWXZNfNdqu82PzDBTh4nFSBTwpc1DZZJqoDUUGo=;
        b=mz3LkuktG97qpEOZDfA8l6qBpeCHJk2rMQ4/Yzsxyn0KTaO7noyiEKRPXHBy6aklwx
         z9UBQNz+AVQTBdVl8pbkboy5LJYlKux4B9ZfATwUDcdV8Bnd14IakRR4K2JMVGe5m/JT
         IMqUUVWbNFKmNK4+nKjIejePmvviEYmXN2LtHGKEHSzoNZIxBUhV/yuhWsGMRCPODLjU
         EeLrg8c68vnvFogR/0sakiIhxNOTCk7L7kOvka2FgYBKieipRJbREtxeBzCTS9/FIvl6
         Zr473+g/YjVMFaB7ZM3e3okIXVG1Ob5JQTMgKSIEdFfVlSyG60O6J66Zb/cfRtSfGsvW
         huKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zmz8nWXZNfNdqu82PzDBTh4nFSBTwpc1DZZJqoDUUGo=;
        b=dg1226LnS/vGTJoXJx1Bw6X/N3rKWpIcyO6Mk30DJrbZDoPzUmeaLItFsl218tbcpq
         5hiu1DhcLAbyVNrkRjWS1913sqdfvwVtcxXKpcC8lQvxkW6EnIn5nc4PVBV2JodMPhw5
         npFb3jhBcF+outwH1Sf6G1EdeIpBflrLlvTUEA/zEGsTvpfQZ0tQkQwG7S4bmmhUQXmp
         QAOMsfCsP0lHsGNK7krrnhYrzFMh8FZpGDtFTeHzHvAvJcn1wjteqQZwjVb+N0wjO4xw
         OGfBhw1u2Qk3vvh+jJ/wVaUH+wojxlheuoXNxmCXyqhFYT6RPcLcXzH43dWtSvLxLrw7
         N8lA==
X-Gm-Message-State: AOAM531Bd2PKt5y6UE2gmNyYLeJTfXUWZEbYnVwEtAe3KFrpAplnIYt/
        Dih7Atk75VZvbZZcnbvEporCv/YEnyc=
X-Google-Smtp-Source: ABdhPJz52wvL8SQ1PGrcH9urXsA3/phOyPVIKiQ5UbPufp7ADzOI5HAyeTNiYEYSaI63DH+MofhlSg==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr27878240wrp.351.1630359299564;
        Mon, 30 Aug 2021 14:34:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm678328wmj.9.2021.08.30.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:34:59 -0700 (PDT)
Message-Id: <6455b18f1b623032b9066c1730dee045fbe7a3f3.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 21:34:50 +0000
Subject: [PATCH 15/15] scalar: accept -C and -c options before the subcommand
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
index be0a49b0d75..41ba4b2f3b1 100644
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
index 00923023243..6d85640ef42 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -36,6 +36,16 @@ The `scalar` command implements various subcommands, and different options
 depending on the subcommand. With the exception of `clone`, `list` and
 `reconfigure --all`, all subcommands expect to be run in an enlistment.
 
+The following options can be specified _before_ the subcommand:
+
+-C <directory>::
+    Before running the subcommand, change the working directory. This
+    option imitates the same option of linkgit:git[1].
+
+-c <key>=<value>::
+    For the duration of running the specified subcommand, configure this
+    setting. This option imitates the same option of linkgit:git[1].
+
 COMMANDS
 --------
 
-- 
gitgitgadget
