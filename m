Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B476FC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6140861606
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhBRSxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhBRSuq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 13:50:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E20C06178B
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 10:50:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s16so1734539plr.9
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ndEX1tawrNEAGbhOUO3DEcfPOOoZbcddnMpKT+aM3ms=;
        b=mNr7gUOD1a7g91sTF7wat8xmtyD33sMloAji6xO0upz6MghIPiu1zY1CdYVYVsTlIJ
         1nLbxH8MzPoDYfkRsJVlleNElhrJ6KLIsA26siJllfjVPkrzYMKALw/lNJOS4X+58Una
         wDkTvzVRbPWd6R4hrHsXCbfo598iRZg1zKrzuUBwEI2e2KkOa51AL27joNTiytrpWOBh
         QxUOrnRodlgqvSR/WjfZYHJ/qK6LSL5oDGS3akxEI2buifBKh8wn8FMsrxeh6cBVjZaD
         R2H+Ghv5549vb2+TGTr35zauJaYQukOmV/1o1O8bcktwKsRQgRFyKLyvPbIbFG/+lGyV
         x4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ndEX1tawrNEAGbhOUO3DEcfPOOoZbcddnMpKT+aM3ms=;
        b=ezLay3XO1tJ66qHuPiWwfbDHXI1h+5yho4xb4h+Lm9bWWTa4UA8N53gsgm+ydYtZeq
         R+pHgwXtWCID80qH2smVayf54YMBqISluKu0tlk0M+2O/5Z3TWGmApLGGdyMlwv3wuhU
         Z40hPN3GibxZluz8GIBugCEoxBt36HnKWbWuHxyF2vt43xxPdjNQyVPms4uWfWJ0t5j5
         MQ/C06EOT1VtrRS2YESSpqYcs9AKWrSG09Jn5UYE4UGx8H5HwnRnDk+Db6TudjojJdDR
         yeR/KavRw+N4rWn47+qSsNc7xx6tT0IFvGjyI0NjtdIFqZLxmJlELO9tuZeicBaIS5mH
         eqVQ==
X-Gm-Message-State: AOAM532wtCpIy/ApCkUszsErIvl6c3PfFk9PRE3PyQ3kgRMKHdiJSDWq
        NhKxCGY2gxj04ukDhd+IeR7y6hUQ17I=
X-Google-Smtp-Source: ABdhPJxtvHtBHXPg2syyPBG4EiF6fFlrniP1b6pJDfaDw6Qnahu8Wk04VYPfHi63N4jDfEaBU8Js8Q==
X-Received: by 2002:a17:90b:1bcf:: with SMTP id oa15mr5235240pjb.78.1613674204946;
        Thu, 18 Feb 2021 10:50:04 -0800 (PST)
Received: from localhost.localdomain ([122.176.159.190])
        by smtp.gmail.com with ESMTPSA id s22sm6790879pfe.133.2021.02.18.10.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:50:04 -0800 (PST)
From:   Shourya Shukla <periperidip@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com,
        Shourya Shukla <periperidip@gmail.com>,
        Javier Mora <javier.moradesambricio@rtx.com>
Subject: [PATCH 1/2] rm: changes in the '.gitmodules' are staged after using '--cached'
Date:   Fri, 19 Feb 2021 00:19:30 +0530
Message-Id: <20210218184931.83613-2-periperidip@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218184931.83613-1-periperidip@gmail.com>
References: <20210218184931.83613-1-periperidip@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier, on doing a 'git rm --cached <submodule>' did not modify the
'.gitmodules' entry of the submodule in question hence the file was not
staged. Change this behaviour to remove the entry of the submodule from
the '.gitmodules', something which might be more expected of the
command.

Reported-by: Javier Mora <javier.moradesambricio@rtx.com>
Signed-off-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/rm.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f..0b74f50bfe 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -254,7 +254,7 @@ static struct option builtin_rm_options[] = {
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	struct lock_file lock_file = LOCK_INIT;
-	int i;
+	int i, removed = 0, gitmodules_modified = 0;
 	struct pathspec pathspec;
 	char *seen;
 
@@ -365,30 +365,32 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (show_only)
 		return 0;
 
-	/*
-	 * Then, unless we used "--cached", remove the filenames from
-	 * the workspace. If we fail to remove the first one, we
-	 * abort the "git rm" (but once we've successfully removed
-	 * any file at all, we'll go ahead and commit to it all:
-	 * by then we've already committed ourselves and can't fail
-	 * in the middle)
-	 */
-	if (!index_only) {
-		int removed = 0, gitmodules_modified = 0;
-		struct strbuf buf = STRBUF_INIT;
-		for (i = 0; i < list.nr; i++) {
-			const char *path = list.entry[i].name;
-			if (list.entry[i].is_submodule) {
+	for (i = 0; i < list.nr; i++) {
+		const char *path = list.entry[i].name;
+		if (list.entry[i].is_submodule) {
+			/*
+			 * Then, unless we used "--cached", remove the filenames from
+			 * the workspace. If we fail to remove the first one, we
+			 * abort the "git rm" (but once we've successfully removed
+			 * any file at all, we'll go ahead and commit to it all:
+			 * by then we've already committed ourselves and can't fail
+			 * in the middle)
+			 */
+			if (!index_only) {
+				struct strbuf buf = STRBUF_INIT;
 				strbuf_reset(&buf);
 				strbuf_addstr(&buf, path);
 				if (remove_dir_recursively(&buf, 0))
 					die(_("could not remove '%s'"), path);
 
 				removed = 1;
-				if (!remove_path_from_gitmodules(path))
-					gitmodules_modified = 1;
-				continue;
+				strbuf_release(&buf);
 			}
+			if (!remove_path_from_gitmodules(path))
+				gitmodules_modified = 1;
+			continue;
+		}
+		if (!index_only) {
 			if (!remove_path(path)) {
 				removed = 1;
 				continue;
@@ -396,11 +398,15 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			if (!removed)
 				die_errno("git rm: '%s'", path);
 		}
-		strbuf_release(&buf);
-		if (gitmodules_modified)
-			stage_updated_gitmodules(&the_index);
 	}
 
+	/*
+	 * Remove the entry of the submodule from the ".gitmodules" irrespective
+	 * whether "--cached" was passed or not.
+	 */
+	if (gitmodules_modified)
+		stage_updated_gitmodules(&the_index);
+
 	if (write_locked_index(&the_index, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
-- 
2.25.1

