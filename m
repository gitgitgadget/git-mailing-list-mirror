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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53977C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B7D613BD
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhEUKkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbhEUKje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 06:39:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CBC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 03:38:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ot16so8817712pjb.3
        for <git@vger.kernel.org>; Fri, 21 May 2021 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4OBzehvPEWl8d8CaMHj77i738IIW6Sprsoxj/eatDM=;
        b=MarbVSEd6RENyRsGqHAi3vBw5RXQSRRN93JvCep5IsrLbxype+ZwyjihLy71f08X+x
         t/uB5vWHX5/R5Dl41fWUQtKpIbfWIH4mBTCqwyUOIg8J9sX2RkelcVW9VoBlmeoOjJUw
         7AZ93F5oP6fykP+jMRVisr/voMbXI6ZFJdPE/SWOQzVgewfPRmoC5MWb7MQNvvwRKvlK
         FgznCa+5EOndnOYlfpxy/wMe3Td2P0JHNUoH8T5mehX3ZaLNTPZ42jY4tXkLtYBITVT0
         DTNzNxKrZUDtRgEnC8W2D7YLOFltBaMWdrpO8zo6GcVnZ28oEIuaGk2ZxVSAqdRLsD2t
         1dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4OBzehvPEWl8d8CaMHj77i738IIW6Sprsoxj/eatDM=;
        b=Hpgq7HZw0qP4FNxVMiYtvVSu1HQ3K7csdzDTx3DQovJK6ORQSJAz9obfvf9eX01gKy
         HOS2PwNo4YmlheFkGrmaKibMp2ahqdlvxwN1s3urVv2uHvAWCKDyIdD028fbCoJVhOhs
         VvgQ8g+8lqxS1RGBS/9bR678u5lLwagsQI5q+03oNHHfi1lIskQEURewdqYssG1RmtOo
         ntKgrJgB5a3aDADVrs5luF44z1Zmh7e2EEMiMALnbQ0gnH6alnDYZgRV5lEk0Oso1Onl
         01PN6Yfxz0/DrXNsCtd2AGZJNHVcHRaDn1tOkee2n/uvAPE+zZgeqlCXNsBbVTOs5849
         v5tQ==
X-Gm-Message-State: AOAM5307v12fESHMKQZIqWQwovTmcLJ1l70ztNot5wKsKkQ1GAr2jiJe
        klJ8NQMfi45h9rYMzaDx0pShQjuT6ac=
X-Google-Smtp-Source: ABdhPJwwmfzS+aZLyCeDL/0T0D4tC9B+UO3dfb4/mvFLIc3wbdgObKaAL1fO0vnJR5cvergRKBtPAA==
X-Received: by 2002:a17:902:8608:b029:f0:ba5b:5c42 with SMTP id f8-20020a1709028608b02900f0ba5b5c42mr11398066plo.67.1621593487516;
        Fri, 21 May 2021 03:38:07 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id p14sm4584397pgb.2.2021.05.21.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 03:38:06 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] stash show: use stash.showIncludeUntracked even when diff options given
Date:   Fri, 21 May 2021 03:37:47 -0700
Message-Id: <e2e3574b25099a627d03447f5ace64b0e56c2ad1.1621593333.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.171.g09c0ee21fe
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If options pertaining to how the diff is displayed is provided to
`git stash show`, the command will ignore the stash.showIncludeUntracked
configuration variable, defaulting to not showing any untracked files.
This is unintuitive behaviour since the format of the diff output and
whether or not to display untracked files are orthogonal.

Use stash.showIncludeUntracked even when diff options are given. Of
course, this is still overridable via the command-line options.

Update the documentation to explicitly say which configuration variables
will be overridden when a diff options are given.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
This patch is a follow-up to [0]. This patch is based on top of
'dl/stash-show-untracked-fixup'.

[0]: https://lore.kernel.org/git/76dfa90a32ae926f7477d5966109f81441eb2783.1621325684.git.liu.denton@gmail.com/

 Documentation/config/stash.txt     | 6 +++---
 Documentation/git-stash.txt        | 6 ++++--
 builtin/stash.c                    | 5 +----
 t/t3905-stash-include-untracked.sh | 2 ++
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
index 413f907cba..9ed775281f 100644
--- a/Documentation/config/stash.txt
+++ b/Documentation/config/stash.txt
@@ -6,9 +6,9 @@ stash.useBuiltin::
 	remaining users that setting this now does nothing.
 
 stash.showIncludeUntracked::
-	If this is set to true, the `git stash show` command without an
-	option will show the untracked files of a stash entry.  Defaults to
-	false. See description of 'show' command in linkgit:git-stash[1].
+	If this is set to true, the `git stash show` command will show
+	the untracked files of a stash entry.  Defaults to false. See
+	description of 'show' command in linkgit:git-stash[1].
 
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index a8c8c32f1e..be6084ccef 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -91,8 +91,10 @@ show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
 	By default, the command shows the diffstat, but it will accept any
 	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
 	to view the second most recent entry in patch form).
-	You can use stash.showIncludeUntracked, stash.showStat, and
-	stash.showPatch config variables to change the default behavior.
+	If no `<diff-option>` is provided, the default behavior will be given
+	by the `stash.showStat`, and `stash.showPatch` config variables. You
+	can also use `stash.showIncludeUntracked` to set whether
+	`--include-untracked` is enabled by default.
 
 pop [--index] [-q|--quiet] [<stash>]::
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 82e4829d44..864b6c1416 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -831,7 +831,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		UNTRACKED_NONE,
 		UNTRACKED_INCLUDE,
 		UNTRACKED_ONLY
-	} show_untracked = UNTRACKED_NONE;
+	} show_untracked = show_include_untracked ? UNTRACKED_INCLUDE : UNTRACKED_NONE;
 	struct option options[] = {
 		OPT_SET_INT('u', "include-untracked", &show_untracked,
 			    N_("include untracked files in the stash"),
@@ -874,9 +874,6 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		if (show_patch)
 			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
-		if (show_include_untracked)
-			show_untracked = UNTRACKED_INCLUDE;
-
 		if (!show_stat && !show_patch) {
 			free_stash_info(&info);
 			return 0;
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 1c9765928d..f7fafcd447 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -333,6 +333,8 @@ test_expect_success 'stash show --include-untracked shows untracked files' '
 	git stash show -p --include-untracked >actual &&
 	test_cmp expect actual &&
 	git stash show --include-untracked -p >actual &&
+	test_cmp expect actual &&
+	git -c stash.showIncludeUntracked=true stash show -p >actual &&
 	test_cmp expect actual
 '
 
-- 
2.32.0.rc0.171.g09c0ee21fe

