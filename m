Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B15C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 16:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159CE619C4
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 16:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFZQes (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 12:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFZQes (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 12:34:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C4FC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 09:32:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b3so14311311wrm.6
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBKgEfWkhRzK3JSxR69psk85qt07oqQqC2u4cXwusww=;
        b=mk+5HsxqChcs0ozR+SNp16sNKKu4rd+q4S2vxHQQ09IA8i/Mjc2BD9ms7CYd51gVvH
         eIqnZiQO3mIVX2/EtPGKS2BuLJdu44sc4pVkapFxplCgsL0SySZaFkRVhqF9GdecDsGh
         TiYTD3xtO11OF1VySsTdNcGIzeuc8pJ9UMSSKr99RpdUfHWwjvfbEhFUVLGt4OVXjsPt
         dn1J10eoWzFRR787DUh8dfeiiYXG99Lubda9Xh4AjuXxCvJAkWXxSTSPyQVTkiOp7gA3
         +1WB1z77zhcys6NEiaQyJFq1RY8/ZY3LGUWWbjTYIWRpuLGsM1e4o2hKzCv4cXX24MTG
         c12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBKgEfWkhRzK3JSxR69psk85qt07oqQqC2u4cXwusww=;
        b=Yggo/L2i7TZem3IB9P6OpRiY2iJmr7BsSuXDNQe5FNZHO8fsJ2bvBLdwP/RWvWy4Ol
         3Ys4mAJ+36YUfGh97UK3m1BDDVyyrHfVnBKjVOybISWYSLQucQQhHUphmZ/R6uYrwL/p
         yF8xNOQRCDbw+BwUQYTOL7vkttFYxw2t2lv5SOBXfW59GXY7OZ2YuGaCJ3Hegq/Dda9n
         nGB9ZUKORu+L75l8W+slaOWnWKIC4/tReNNjWzpRaPpdSpq+XL2f0Lc8T8mYHtjDSpHF
         8dUdVARijE73ANR2Pvb1BW7oAwStzOEs6wulT8HNvDJZrJhxYt6zX0SYxTiWmu3bpg30
         fxhA==
X-Gm-Message-State: AOAM533EILI51i6PCpe+nG/yvD1cDBG+lJoxujdBpDtK9m2fqGLCuNv1
        mVSO12RiNktNPcehgCnXoG5cJk2HV9QHAOphoCo=
X-Google-Smtp-Source: ABdhPJzUtH7ID+5/JUecapGqz1T43rh4tQrMeuBiFSGBJQBnIWMmw303gIq14o1i+/G097kBgpjmjA==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr17632313wrq.202.1624725142967;
        Sat, 26 Jun 2021 09:32:22 -0700 (PDT)
Received: from localhost.localdomain ([195.246.120.98])
        by smtp.gmail.com with ESMTPSA id u15sm11286178wmq.1.2021.06.26.09.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:32:22 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] help: convert git_cmd to page in one place
Date:   Sat, 26 Jun 2021 18:32:19 +0200
Message-Id: <20210626163219.4137317-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.32.0
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
---
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

