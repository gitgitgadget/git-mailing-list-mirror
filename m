Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956E9C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhKZWsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhKZWqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42336C0613D7
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a9so21543327wrr.8
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tF7bJ29N5qibrd7hwQG69xW6Up0RccDTXl3PhwBxtT0=;
        b=qX3RCoyxMrLRJ69BN1U3EsWxDdRKfxUavB/mavq1V8BQ+WwZEK5FAnKRW8x5xAUxwT
         01LWGbRM8NvbXyfaMqfvgZCMx4INXisRr7u+HpGoSQ9ePbKDzxErLrFRB7AstL13/nv1
         GUC0XshaOKQEhw//11CiKbGgOrHr45mz39/LSnsgTv+VOGWA6vgvTVAqBNgq7mbGd1Oj
         7l8Ki5742wHtACPf9G3uKU/rZol2j5b7i8ifvt9oJG6dFiNtf+DUaDFW4bt7Cp+0q/ZK
         lnjACG5dyHuPazwOb2ck/gPoLBvgjp89HbuMGPs5zOPVtHPrDgHAKnP7TuIbfugcClSB
         2G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tF7bJ29N5qibrd7hwQG69xW6Up0RccDTXl3PhwBxtT0=;
        b=HD8lRrZ1fvHigAA97uLkWrjedJQF8MigkKIsQOMbwvIh8rIcczr5GNkpxV1+n4sfvD
         VJ9Pd9MNBqinM8huj8uuzvDpzaiy3mzVSZqEKW179y1dDoeAZejJgtZ/cB4qhtlc77/S
         hRXQz1tbFza7/CbbI0d+Puky86/BE8p1igrEWfQ1M0pRpZ28zhqtuZ7qmYf5/U22geHL
         UKPnBS4gPveJDNGFK20rsWfcSAEpQb2VQDJGQbzneCB3l6KezNS0DmjOABsVbN9eOg1G
         JurnfyBmR3MrTTDOx3UTYLRjOADK1H0kGH1kOqoMXqj2DrXwmwbvyjLStVSh5IBwyut2
         ECoQ==
X-Gm-Message-State: AOAM531rgxqk8ze3ZY2mq0t3pSpFmWmxXNFiy9PjAclMa27MlyVXnqC7
        aWDwNUk8FOR2T4bXMwvU8nvK/evKuXw=
X-Google-Smtp-Source: ABdhPJypHnOopXBN38Sh+WqD7DcTi2q5CsyWUckRD1xwQrFE/pJRFj0NRvlm7JWPdBQJOcOugHpfFg==
X-Received: by 2002:adf:fbd0:: with SMTP id d16mr17731923wrs.107.1637966466647;
        Fri, 26 Nov 2021 14:41:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm7146889wmc.7.2021.11.26.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:06 -0800 (PST)
Message-Id: <68ae90546fed39fbe58edec8a1b81e3054b0c224.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:40:54 +0000
Subject: [PATCH v3 03/11] unpack-trees: refuse to remove
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
 t/t2501-cwd-empty.sh | 20 +++++++-------------
 unpack-trees.c       | 17 +++++++++++++----
 unpack-trees.h       |  1 +
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 67feb6fd200..52399d1906f 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -106,7 +106,7 @@ test_expect_success 'checkout does not clean cwd incidentally' '
 '
 
 test_expect_success 'checkout fails if cwd needs to be removed' '
-	test_required_dir_removal failure git checkout fd_conflict
+	test_required_dir_removal success git checkout fd_conflict
 '
 
 test_expect_success 'reset --hard does not clean cwd incidentally' '
@@ -137,23 +137,17 @@ test_expect_success 'merge fails if cwd needs to be removed; recursive friendly'
 	(
 		cd dirORfile &&
 
-		# We would rather this failed, but we test for existing
-		# rather than desired behavior
-		git merge fd_conflict 2>../error
+		test_must_fail git merge fd_conflict 2>../error
 	) &&
 
-	## Here is the behavior we would rather have:
-	#test_path_is_dir dirORfile &&
-	#grep "Refusing to remove the current working directory" error
-	## But instead we test for existing behavior
-	test_path_is_file dirORfile &&
-	test_must_be_empty error
+	test_path_is_dir dirORfile &&
+	grep "Refusing to remove the current working directory" error
 '
 
 GIT_TEST_MERGE_ALGORITHM=ort
 
 test_expect_success 'merge fails if cwd needs to be removed' '
-	test_required_dir_removal failure git merge fd_conflict
+	test_required_dir_removal success git merge fd_conflict
 '
 
 test_expect_success 'cherry-pick does not clean cwd incidentally' '
@@ -161,7 +155,7 @@ test_expect_success 'cherry-pick does not clean cwd incidentally' '
 '
 
 test_expect_success 'cherry-pick fails if cwd needs to be removed' '
-	test_required_dir_removal failure git cherry-pick fd_conflict
+	test_required_dir_removal success git cherry-pick fd_conflict
 '
 
 test_expect_success 'rebase does not clean cwd incidentally' '
@@ -177,7 +171,7 @@ test_expect_success 'revert does not clean cwd incidentally' '
 '
 
 test_expect_success 'revert fails if cwd needs to be removed' '
-	test_required_dir_removal failure git revert undo_fd_conflict
+	test_required_dir_removal success git revert undo_fd_conflict
 '
 
 test_expect_success 'rm does not clean cwd incidentally' '
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

