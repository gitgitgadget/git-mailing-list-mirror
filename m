Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5B0C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43AC1613D1
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 15:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhGDPly (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhGDPly (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 11:41:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A9C061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 08:39:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id he13so6373792ejc.11
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3p1wvspqzEEtHU6j+1MiPfhGz9iO2FvEbjGJUTuOqM=;
        b=nuNO7nZYjxxJIF7cnQXJE4FfbX2qZGNeKItBQodbjLz0fSuim4VqGLOHZCEH2egSTy
         hz6z2IIuehevo+0G1XFunFxv+zGT36+HFqxCjUbW+8pE+rUSpBWi/c8MqBdfWPIxlcV6
         GR7Q++Tc+wxW86ZWfPTxEH3vV2ynl3dHnLAfK80IjudUroLErqDGDBtmBHcINTTKmgcc
         gwTos1UDXv+9cdmcM45/OZswwlrRIESa3lZpORu14QlUAsVA3Fnsk89n2wmoJ6u5LwAg
         b3DYewebZqBOrM0Mp2whuBC7/mDlhDe6PMH7cD2N4UsfVb8cG5QyMPSgMPYztqAmwCuP
         gLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3p1wvspqzEEtHU6j+1MiPfhGz9iO2FvEbjGJUTuOqM=;
        b=hCb4+WSKtSuwQoN7WW4pHBsJWkzXdPCb7jc9Zvpv7wZQnp+HpT/FA+oUeAF0a+sdm2
         x/Q6rsAcDeKiEkmBN5Gic54UHLl4AxwwKbXd06SeWScDB1N+CtJD7IejMeehXifkr67G
         LnFOdn9UHv1bKnfUtYcSrYRErZ0EwGSe2u2by/sndOLzqXsNQ/LbJTXwSbY9HxdTY9zW
         DY9r88d/z+eV7uFTGGNL+9Calk+t6pKzy3d7AuDwSv7udq+5aaWrzNRNgfD7ZmrBZkIs
         /fqcJCr2Edz+c6sR6a77CBE0NDo7B1oTL/gDH3HTqr33oV8AfwN1ZRPBMnYlgoKhDnFs
         XiXw==
X-Gm-Message-State: AOAM530XgTEBYgRYGOirrrItTiXRaP0YvSOqxXtdFn3rVmvD/dHEzhr7
        0UZimkKAnzS37wgO+YY3M43pi8Npg9lbjw==
X-Google-Smtp-Source: ABdhPJwLPOead5/BexPoIzAMJ9C+Co74ZRTrvNABq+NqHhjR26haiKu7EAKSfFQxv+Jr7734yMV/qA==
X-Received: by 2002:a17:907:3f08:: with SMTP id hq8mr9225384ejc.150.1625413155264;
        Sun, 04 Jul 2021 08:39:15 -0700 (PDT)
Received: from localhost.localdomain ([212.102.57.156])
        by smtp.gmail.com with ESMTPSA id j5sm3301274ejn.19.2021.07.04.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 08:39:14 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH resend] help: convert git_cmd to page in one place
Date:   Sun,  4 Jul 2021 17:39:12 +0200
Message-Id: <20210704153912.2742106-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210626163219.4137317-1-rybak.a.v@gmail.com>
References: <20210626163219.4137317-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Depending on the chosen format of help pages, git-help uses function
show_man_page, show_info_page, or show_html_page.  The first thing all
three functions do is to convert given `git_cmd` to a `page` using
function cmd_to_page.

Move the common part of these three functions to function cmd_help to
avoid code duplication.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Resending to make sure that this patch isn't forgotten.
Originally sent as https://lore.kernel.org/git/20210626163219.4137317-1-rybak.a.v@gmail.com/

 builtin/help.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index bb339f0fc8..b7eec06c3d 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -436,10 +436,9 @@ static void exec_viewer(const char *name, const char *page)
 		warning(_("'%s': unknown man viewer."), name);
 }
 
-static void show_man_page(const char *git_cmd)
+static void show_man_page(const char *page)
 {
 	struct man_viewer_list *viewer;
-	const char *page = cmd_to_page(git_cmd);
 	const char *fallback = getenv("GIT_MAN_VIEWER");
 
 	setup_man_path();
@@ -453,9 +452,8 @@ static void show_man_page(const char *git_cmd)
 	die(_("no man viewer handled the request"));
 }
 
-static void show_info_page(const char *git_cmd)
+static void show_info_page(const char *page)
 {
-	const char *page = cmd_to_page(git_cmd);
 	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
 	execlp("info", "info", "gitman", page, (char *)NULL);
 	die(_("no info viewer handled the request"));
@@ -486,9 +484,8 @@ static void open_html(const char *path)
 	execl_git_cmd("web--browse", "-c", "help.browser", path, (char *)NULL);
 }
 
-static void show_html_page(const char *git_cmd)
+static void show_html_page(const char *page)
 {
-	const char *page = cmd_to_page(git_cmd);
 	struct strbuf page_path; /* it leaks but we exec bellow */
 
 	get_html_page_path(&page_path, page);
@@ -548,6 +545,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
 	enum help_format parsed_help_format;
+	const char *page;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
@@ -606,16 +604,17 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	argv[0] = check_git_cmd(argv[0]);
 
+	page = cmd_to_page(argv[0]);
 	switch (help_format) {
 	case HELP_FORMAT_NONE:
 	case HELP_FORMAT_MAN:
-		show_man_page(argv[0]);
+		show_man_page(page);
 		break;
 	case HELP_FORMAT_INFO:
-		show_info_page(argv[0]);
+		show_info_page(page);
 		break;
 	case HELP_FORMAT_WEB:
-		show_html_page(argv[0]);
+		show_html_page(page);
 		break;
 	}
 
-- 
2.32.0

