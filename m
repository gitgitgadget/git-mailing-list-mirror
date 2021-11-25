Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D4CC433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353583AbhKYIog (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353361AbhKYImd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:42:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C409C061761
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u18so9898628wrg.5
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pGZm9gqf6Zg1QWoZPxdqgWYYWEoJTRxsD2IfU0/75HQ=;
        b=gum124UDEpNlfiJL75IXehel0e1kEf7DHoN8ESAmYnhVYhjC813dWfIUDV+9OsyT5S
         LpY/nmQE0lxMCzP3e1FZ1TVta/lMhf+WJEOjbKN7SVlpLJuxS40fK9zuas3MSZOP/JwU
         QORfSytySurL3XF73u1hFxL0FVRwLMQABildu865awVDLyBQgF9+LqlZzidzkBxzIo5G
         FTJCCFCiexASX+MTrXw4TXKKA3SKtrSCNDDIr00jzeBWXcbnUl1DVDV5fd8+uygRQG8e
         B5IwbNnc5vlNwzxWMLvGltPOMaJO17hdj9O6Wjy7y6z6CY59YHaKxsAIkJhXcBjjjKtg
         YF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pGZm9gqf6Zg1QWoZPxdqgWYYWEoJTRxsD2IfU0/75HQ=;
        b=hfDS0UqokzVAQvB1KOycYDZhWljvobtXQUmYpoNx4UFvTw683vBGy9w1wyKK1Cy5vo
         7oRYy3JDuPgqWb5w8fPCfmJ5D1tGAk1Voh94MPXuwbtR0v9Si3rk/d9AFCMTzQFS3XGZ
         1TfiT/UW2aDWwo0q6I5bc74Z5f2N19p6qxtSEqPbIY97mbK1QaWZbsjUddJ+DiWGnceT
         BwYS3vNRWwJGUNPenVUaeichm35XQ71ddpNU0X9B5fvMKuZVuJ/z87x/ibrR9yKO4gW0
         +4/JBLWV4WNsTAxSIuOMOZkSIQDcHkOYcfpzuCKXhUt8+aW8zK8581uT/LdyIs3DIXx2
         WZoQ==
X-Gm-Message-State: AOAM532a5mu4jXKuMHZ7szBTgHvYqps17VwcDvbCoBx2NHXmYbMhl0Mb
        60OKZACAD7EeP1LaWy9Bdl4PsJT+jPo=
X-Google-Smtp-Source: ABdhPJwLvrZQ4nZMbozk2h/vxBYyJ75YT3nzKBHx7yJKMEvpxyscVUB9rRL1t3RFVPjBzxt9ic91uA==
X-Received: by 2002:adf:9bc4:: with SMTP id e4mr4609147wrc.476.1637829560521;
        Thu, 25 Nov 2021 00:39:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm2139077wrn.63.2021.11.25.00.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:20 -0800 (PST)
Message-Id: <e74975e83cc7a11b8f0378d59a8c2c4a97d3aa50.1637829556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:10 +0000
Subject: [PATCH v2 3/9] unpack-trees: refuse to remove
 startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the past, when a directory needs to be removed to make room for a
file, we have always errored out when that directory contains any
untracked (but not ignored) files.  Add an extra condition on that: also
error out if the directory is the current working directory we inherited
from our parent process.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 10 +++++-----
 unpack-trees.c       | 17 +++++++++++++----
 unpack-trees.h       |  1 +
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 5dfb456a691..212676d71c3 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -38,7 +38,7 @@ test_expect_failure 'checkout does not clean cwd incidentally' '
 	test_path_is_dir foo
 '
 
-test_expect_failure 'checkout fails if cwd needs to be removed' '
+test_expect_success 'checkout fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -95,7 +95,7 @@ test_expect_failure 'merge does not remove cwd incidentally' '
 	test_path_is_dir subdir
 '
 
-test_expect_failure 'merge fails if cwd needs to be removed' '
+test_expect_success 'merge fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -122,7 +122,7 @@ test_expect_failure 'cherry-pick does not remove cwd incidentally' '
 	test_path_is_dir subdir
 '
 
-test_expect_failure 'cherry-pick fails if cwd needs to be removed' '
+test_expect_success 'cherry-pick fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -149,7 +149,7 @@ test_expect_failure 'rebase does not remove cwd incidentally' '
 	test_path_is_dir subdir
 '
 
-test_expect_failure 'rebase fails if cwd needs to be removed' '
+test_expect_success 'rebase fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -176,7 +176,7 @@ test_expect_failure 'revert does not remove cwd incidentally' '
 	test_path_is_dir subdir
 '
 
-test_expect_failure 'revert fails if cwd needs to be removed' '
+test_expect_success 'revert fails if cwd needs to be removed' '
 	git checkout fd_conflict &&
 	git revert HEAD &&
 	test_when_finished "git clean -fdx" &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 89ca95ce90b..6bc16f3a714 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -36,6 +36,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",
 
+	/* ERROR_CWD_IN_THE_WAY */
+	"Refusing to remove '%s' since it is the current working directory.",
+
 	/* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
 	"Untracked working tree file '%s' would be overwritten by merge.",
 
@@ -131,6 +134,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in them:\n%s");
 
+	msgs[ERROR_CWD_IN_THE_WAY] =
+		_("Refusing to remove the current working directory:\n%s");
+
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
@@ -2146,10 +2152,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 		cnt++;
 	}
 
-	/*
-	 * Then we need to make sure that we do not lose a locally
-	 * present file that is not ignored.
-	 */
+	/* Do not lose a locally present file that is not ignored. */
 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
@@ -2160,6 +2163,12 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	free(pathbuf);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
+
+	/* Do not lose startup_info->original_cwd */
+	if (startup_info->original_cwd &&
+	    !strcmp(startup_info->original_cwd, ce->name))
+		return add_rejected_path(o, ERROR_CWD_IN_THE_WAY, ce->name);
+
 	return cnt;
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index 71ffb7eeb0c..efb9edfbb27 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -19,6 +19,7 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
 	ERROR_NOT_UPTODATE_DIR,
+	ERROR_CWD_IN_THE_WAY,
 	ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
-- 
gitgitgadget

