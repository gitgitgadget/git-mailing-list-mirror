Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB22C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiGYMjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiGYMjH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE3BBC98
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sz17so20330079ejc.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O19l2QxSTxz1j7njm/RHsChRirvJC3nIyI8fTNfW7yQ=;
        b=TGRZYnpDhk1sPeBHAMzJ2ijPs9rk2lXdwp71qR6Q9lOQPLqkYkTqyWklijs+42nJ85
         d6dvMETJ5I/ehQXbNeSvGSY1tQ3N5cYaY7KwyKI+mkYoRgYRKapcw6TgncRn+1XexK/A
         CzbzuP2L4oKkDSw5ukqIqaWf67cf+r1RM4+pwOHqP/iEqiy4ihYa0Og3eM7pwGBVBNpO
         qBdFspptMNO4+/1qi8V/MTWtujDyRSqtDYlU8IETfkRrildlaWdkvykkDvDjWw+1oCq8
         1SB5hxmhIGi+W0992LL75DRtLHlqh4cIkkn/dnBjv84G3kjq73stQ3IYTfx0vZvIPWTZ
         QINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O19l2QxSTxz1j7njm/RHsChRirvJC3nIyI8fTNfW7yQ=;
        b=M18gh4Nl0rDvLIs28KLCMS2j7YI9BdgHxuJirHCCIF2/JXnxD1J+sDNpH+F3mRZxW3
         Y6+qg1kb2KCjg0uYwCtdpv9Qj5hsmOiEmaQG9XQ7CvI/QrA/GZKwZdECxG6d0s/01cLt
         aWJc5TLeMv8V5LA6uW++cZcmAUoakBSN+XnGb4NR0pKEX/H+1HcnZ4z/qUmYoAOGdMs4
         kqFxQ40Tyl/QmxisgGVOXEqQmsC/b/XiT62E+lPyN3POhO56xjNPC38l1Z64BuCCXD9s
         rT58anLnXCzzdmBPYUsxg59xPwJe7Z/2WcWJGvU7HU5FC2cUyreUVTMkrTizrPbF0u6L
         RC2w==
X-Gm-Message-State: AJIora9HE31R0oGxGX9VZd9WkUWBm3vABbhD91D1u6eIKfUKT/x/Xvn9
        +LCZfpJHNIU7xUSFDEteTKHyaZId1yY=
X-Google-Smtp-Source: AGRyM1seOMPSygiUzSIynatlCe2JNtBDRRPQDLqS7TWfcDegsbvdVHixx5YCUK7pj2kpkI4OeefC1Q==
X-Received: by 2002:a17:906:478b:b0:72b:5cd6:3f50 with SMTP id cw11-20020a170906478b00b0072b5cd63f50mr9920308ejc.514.1658752744863;
        Mon, 25 Jul 2022 05:39:04 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906292a00b006fef0c7072esm5428142ejd.144.2022.07.25.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 01/20] git.c: update NO_PARSEOPT markings
Date:   Mon, 25 Jul 2022 14:38:38 +0200
Message-Id: <20220725123857.2773963-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our Bash completion script can complete --options for commands using
parse-options even when that command doesn't have a dedicated
completion function, but to do so the completion script must know
which commands use parse-options and which don't.  Therefore, commands
not using parse-options are marked in 'git.c's command list with the
NO_PARSEOPT flag.

Update this list, and remove this flag from the commands that by now
use parse-options.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 git.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index e5d62fa5a9..c4282f194a 100644
--- a/git.c
+++ b/git.c
@@ -489,14 +489,14 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
-	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
+	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
-	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
@@ -514,7 +514,7 @@ static struct cmd_struct commands[] = {
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 	{ "commit-graph", cmd_commit_graph, RUN_SETUP },
-	{ "commit-tree", cmd_commit_tree, RUN_SETUP | NO_PARSEOPT },
+	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
 	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
@@ -553,7 +553,7 @@ static struct cmd_struct commands[] = {
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
 	{ "maintenance", cmd_maintenance, RUN_SETUP | NO_PARSEOPT },
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
@@ -566,7 +566,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
-	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
+	{ "mktag", cmd_mktag, RUN_SETUP },
 	{ "mktree", cmd_mktree, RUN_SETUP },
 	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
@@ -627,7 +627,7 @@ static struct cmd_struct commands[] = {
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
 	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
-	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
+	{ "worktree", cmd_worktree, RUN_SETUP },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
 };
 
-- 
2.37.1.633.g6a0fa73e39

