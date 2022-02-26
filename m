Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CF8C433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 06:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiBZGQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 01:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiBZGQC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 01:16:02 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC718A780
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:15:28 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 132so6591507pga.5
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCabWHHYv+TbaQwfVFraHCE1Qj0xdgrEUKV03d4yjtA=;
        b=cMrGQC/UQBdHo4iHbuVupwhnv4eypSCdY4FTlJOTSyUuG1as8r9iICIZLXoGqI+aGY
         0M6QDHyfFY3mfKJ6l3u6GWdowWWvR3up8wtV1EKDAtyhn8fcPb6jYLMaOB6frkv1V9oW
         La6G/VGeoJfWgKEXzEJE+vZB0zXSRouehfhip7A08iSQJFXFixFVnoh+bi/nLSvQARbi
         bOgytqSKzkfD8JMt6sG8pt43GWnaK7sh2kFg6IkN9uowfC6lcIyEF7bj1KG+q2ysX/69
         y8Gsc3X4EJRn76ZGeEuc2pSHXZJkT+7KTVRZJL9xrrp8A4Qn/8Ybj7oC93cO4VPRnxPq
         wYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCabWHHYv+TbaQwfVFraHCE1Qj0xdgrEUKV03d4yjtA=;
        b=K1uhsj3KhMSuka5ma5/fhn0SoEy72iR5GMflptDl70SaSohQUYWM5uZpZxStWxjreh
         AxiabN7H94CcC+4nJR5B5AvnayF2RvK2Ch+ZbBCxTNBgfJF+zelY9HIvLSfF5UtgpFNd
         6Whp23LzUCDLSeZ5eCIWODaSLuZb6lTXLQ79R+HxJ4LPrWUpjWgIxxnpTMABRQaJqyu5
         3rfQwmVFL9pA4n4rz0//r5Hv6q9Slv374apsyRqZN2+FsW9vBBESzEod9Afk5kvq3l2A
         xR9XkneUtzBMOvLxK6L5wDTUu40nev58X4JzIsQUP4CESazOZu6R3odXEx/1OPilts9O
         wexw==
X-Gm-Message-State: AOAM532/X5LrzBxfQEYlutIR6ZnK34bn154xA2xwsnaaeaFoxdA1MxN+
        iDag4sidmiFsHNaM/zkvRkGbFtLhryfCAg==
X-Google-Smtp-Source: ABdhPJynnUmdOOSO+NFkEry529yqEBzpe7VujIe++xWhDkLprTXAENsevhvaA0yvFTnGZCH8DnLBXA==
X-Received: by 2002:a63:64c5:0:b0:34d:3d6c:31d2 with SMTP id y188-20020a6364c5000000b0034d3d6c31d2mr8960768pgb.499.1645856127943;
        Fri, 25 Feb 2022 22:15:27 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00170200b004e0f0c0e13esm5214447pfc.66.2022.02.25.22.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 22:15:27 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        pclouds@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3] switch: mention the --detach option when dying due to lack of a branch
Date:   Fri, 25 Feb 2022 23:12:13 -0700
Message-Id: <20220226061213.1590341-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users who are accustomed to doing `git checkout <tag>` assume that
`git switch <tag>` will do the same thing. Inform them of the --detach
option so they aren't left wondering why `git switch` doesn't work but
`git checkout` does.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v3: Use plain grep instead of test_i18ngrep
---
 Documentation/config/advice.txt |  3 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/checkout.c              | 30 +++++++++++++++++++-----------
 t/t2060-switch.sh               | 11 +++++++++++
 5 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index adee26fbbb..c40eb09cb7 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -85,6 +85,9 @@ advice.*::
 		linkgit:git-switch[1] or linkgit:git-checkout[1]
 		to move to the detach HEAD state, to instruct how to
 		create a local branch after the fact.
+	suggestDetachingHead::
+		Advice shown when linkgit:git-switch[1] refuses to detach HEAD
+		without the explicit `--detach` option.
 	checkoutAmbiguousRemoteBranchName::
 		Advice shown when the argument to
 		linkgit:git-checkout[1] and linkgit:git-switch[1]
diff --git a/advice.c b/advice.c
index e00d30254c..2e1fd48304 100644
--- a/advice.c
+++ b/advice.c
@@ -42,6 +42,7 @@ static struct {
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
+	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead", 1 },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
diff --git a/advice.h b/advice.h
index a7521d6087..a3957123a1 100644
--- a/advice.h
+++ b/advice.h
@@ -20,6 +20,7 @@ struct string_list;
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
+	ADVICE_SUGGEST_DETACHING_HEAD,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_GRAFT_FILE_DEPRECATED,
 	ADVICE_IGNORED_HOOK,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d9b31bbb6d..9244827ca0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1397,23 +1397,31 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 {
 	struct object_id oid;
 	char *to_free;
+	int code;
 
 	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
 		const char *ref = to_free;
 
 		if (skip_prefix(ref, "refs/tags/", &ref))
-			die(_("a branch is expected, got tag '%s'"), ref);
-		if (skip_prefix(ref, "refs/remotes/", &ref))
-			die(_("a branch is expected, got remote branch '%s'"), ref);
-		die(_("a branch is expected, got '%s'"), ref);
+			code = die_message(_("a branch is expected, got tag '%s'"), ref);
+		else if (skip_prefix(ref, "refs/remotes/", &ref))
+			code = die_message(_("a branch is expected, got remote branch '%s'"), ref);
+		else
+			code = die_message(_("a branch is expected, got '%s'"), ref);
 	}
-	if (branch_info->commit)
-		die(_("a branch is expected, got commit '%s'"), branch_info->name);
-	/*
-	 * This case should never happen because we already die() on
-	 * non-commit, but just in case.
-	 */
-	die(_("a branch is expected, got '%s'"), branch_info->name);
+	else if (branch_info->commit)
+		code = die_message(_("a branch is expected, got commit '%s'"), branch_info->name);
+	else
+		/*
+		 * This case should never happen because we already die() on
+		 * non-commit, but just in case.
+		 */
+		code = die_message(_("a branch is expected, got '%s'"), branch_info->name);
+
+	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
+		advise(_("If you want to detach HEAD at the commit, try again with the --detach option."));
+
+	exit(code);
 }
 
 static void die_if_some_operation_in_progress(void)
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index ebb961be29..5a7caf958c 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -32,6 +32,17 @@ test_expect_success 'switch and detach' '
 	test_must_fail git symbolic-ref HEAD
 '
 
+test_expect_success 'suggestion to detach' '
+	test_must_fail git switch main^{commit} 2>stderr &&
+	grep "try again with the --detach option" stderr
+'
+
+test_expect_success 'suggestion to detach is suppressed with advice.suggestDetachingHead=false' '
+	test_config advice.suggestDetachingHead false &&
+	test_must_fail git switch main^{commit} 2>stderr &&
+	! grep "try again with the --detach option" stderr
+'
+
 test_expect_success 'switch and detach current branch' '
 	test_when_finished git switch main &&
 	git switch main &&
-- 
2.35.1

