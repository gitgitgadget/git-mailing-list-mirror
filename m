Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66DAC433FE
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 06:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhLaG3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 01:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhLaG3R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 01:29:17 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7037DC06173E
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 22:29:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s1so54544743wrg.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 22:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TGeNXOTBhGbe3rrK0B1pDHJxHI3HTKp4RA4wkWLfnZo=;
        b=UlLavP1fPfZIomlj1lsRqbP4OlhzopJtT9ZOiND/VpSH8w6YZYXXV+UlBxe0Fpy2e4
         v2Zs9bDFncC8APv6WFX9qNwNyjJw9TlNJSeJfjTu6uubTn9JMJsJzE9XcflSlto5oGre
         9EMdaOwAWp1TDAEdmAQTBOXlq8M+1ZPwmO56Kzy882wqXUIxmwxmh6Fx8x0FhvGQU06w
         BGfhACRwWVavcupmIP4iD92Yf4rZI8nPEKPVHghLKSPGc9RY1hh7S4rZdn+gUG35aXFI
         omWzyti7IWwjr0+VnlkgB7d7nF2BjvxlKXEQbWHMVAPis5sVUFuZVtZOR9n1L27+Vmbp
         altQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TGeNXOTBhGbe3rrK0B1pDHJxHI3HTKp4RA4wkWLfnZo=;
        b=pGOEVu9LEjfBCS3wzxuO6xvV+idP/dPl2foAmlidvj8D8xLqjEBkRXWZD58wcBJkV+
         iiQUKfW3/Q7f4JiUpzSW9EhU6UB8Dn63UWfE0SCccyovRf9O+pHRiPh4yNpTLYC45wdu
         AypxJeE6ErVk03QTatQCa4VptJKNnOduUUBTmozgTpJXB9lvu5DYTz2elGYQh6Co7bwg
         Lz6Qg2+waZ8mxcOZSCgb6cL4FzuC0/fOMsufdGC16g5KBLZovCHjI4YjCiW39w9+8Fr+
         nL6ZOtaH/yRio5gah6VXKJrfTP4/2XtD5umB8gVa0x7hokYQXMBSS2w/GvfBCZ4Zn8xM
         iyZA==
X-Gm-Message-State: AOAM5337wC71DQi6VLrNkpxI+NdhpDxOJgc2UjX2VN1FuaAD0g48tuic
        y73nPNwd/sfli6SFRUBWvIaLJLusz8c=
X-Google-Smtp-Source: ABdhPJwzZRon/ewvb8V3NzKKt/aFuQf17ZdfrvtfbenImFga9seThTgtA5VaITX1pWGzgZRUWpvDjw==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr28711868wrz.490.1640932154744;
        Thu, 30 Dec 2021 22:29:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3sm26091897wro.22.2021.12.30.22.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 22:29:14 -0800 (PST)
Message-Id: <fffea298642efe85582e4d303bd483979ce64e1d.1640932151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 06:29:11 +0000
Subject: [PATCH 2/2] builtin/reflog.c: switch to use parse-options API for
 delete subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Address NEEDSWORK by switching out manual arg parsing for the
parse-options API for the delete subcommand.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 builtin/reflog.c | 52 +++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index afaf5ba67e2..a405c38a139 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -11,11 +11,7 @@
 #include "revision.h"
 #include "reachable.h"
 #include "worktree.h"
-#include "parse-options.h"
 
-static const char reflog_delete_usage[] =
-N_("git reflog delete [--rewrite] [--updateref] "
-   "[--dry-run | -n] [--verbose] <refs>...");
 static const char reflog_exists_usage[] =
 N_("git reflog exists <ref>");
 
@@ -641,7 +637,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free(collected.e);
 	}
 
-	for (; i < argc; i++) {
+	for (i = 0; i < argc; i++) {
 		char *ref;
 		if (!dwim_log(argv[i], strlen(argv[i]), NULL, &ref)) {
 			status |= error(_("%s points nowhere!"), argv[i]);
@@ -668,38 +664,40 @@ static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
+static const char * reflog_delete_usage[] = {
+	N_("git reflog delete [--rewrite] [--updateref] "
+   "[--dry-run | -n] [--verbose] <refs>..."),
+	NULL
+};
+
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
 	struct expire_reflog_policy_cb cb;
-	int i, status = 0;
+	int status = 0;
 	unsigned int flags = 0;
 
+	const struct option options[] = {
+		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
+				EXPIRE_REFLOGS_DRY_RUN),
+		OPT_BIT(0, "rewrite", &flags,
+				N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
+				EXPIRE_REFLOGS_REWRITE),
+		OPT_BIT(0, "updateref", &flags,
+				N_("update the reference to the value of the top reflog entry"),
+				EXPIRE_REFLOGS_UPDATE_REF),
+		OPT_BIT(0, "verbose", &flags, N_("print extra information on screen."),
+				EXPIRE_REFLOGS_VERBOSE),
+		OPT_END()
+	};
+
 	memset(&cb, 0, sizeof(cb));
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			flags |= EXPIRE_REFLOGS_DRY_RUN;
-		else if (!strcmp(arg, "--rewrite"))
-			flags |= EXPIRE_REFLOGS_REWRITE;
-		else if (!strcmp(arg, "--updateref"))
-			flags |= EXPIRE_REFLOGS_UPDATE_REF;
-		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
-		else if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		else if (arg[0] == '-')
-			usage(_(reflog_delete_usage));
-		else
-			break;
-	}
+	argc = parse_options(argc, argv, prefix, options, reflog_delete_usage, 0);
 
-	if (argc - i < 1)
+	if (argc < 1)
 		return error(_("no reflog specified to delete"));
 
-	for ( ; i < argc; i++) {
+	for (int i = 0; i < argc; i++) {
 		const char *spec = strstr(argv[i], "@{");
 		char *ep, *ref;
 		int recno;
-- 
gitgitgadget
