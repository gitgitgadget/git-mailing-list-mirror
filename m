Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F5EC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346988AbhLAGoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346969AbhLAGoV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC36C061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s13so49842107wrb.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fK8d+RJ7hnzvZ1yBfOpd29GZkh1b5t4F2UI3aglOhFk=;
        b=FQkdxC5R02XUCrlKWzNDZk8/jnFAXtQrzCYJv55/86gJt0HGX+/Fjjum2cCCHA1Ugq
         p8fL8LY40cTvZ36Q1RookbrOOmcBOYvk4KrGglz+qgmq3pE8/SG6RRRLvb5kE6TmVlVB
         YNmF/Gud90nfzj/y6rfZcKp93feNcOX8HggAbtKJHPqnNO+6nbkRl6DyRVnGpHW7ZlaY
         QaVtTQU1JQcmr3hvT1Rq2TqkcjC7X7vv7EYMfkKAJx0sLpgOI9drVCUoK6O4eI+jLlKa
         tVpC3BLmbXN9AYCfri3z1UqZ207rEPr9Es5OnSkze8SeUyCN9K1HvC4JCY69jFfcfyzz
         d+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fK8d+RJ7hnzvZ1yBfOpd29GZkh1b5t4F2UI3aglOhFk=;
        b=X/om7fbgVLWuM4ehdV2jn1d2Rh9xyOiEmG6M7uwdtntzoEwZ2Lppt3LOoBk6hQxMJl
         a0CMrJ2ERSErNAx31AGM+M7E52arC42eRFXnqmbh03si51ahNyTAMHbSNpIws2m5A63y
         EgoDo6GUje7eOrffzw1eTC6Lt0AmmoBsfK0UFa/lG17QQldoqvHgP7WAd1qY8vvv7BQP
         TsqntTr0fb9CwwpkfAnFAdWMSzhNpJIsfL8jo4iissAgzum7DKitpf4+JxkuKd8EOWh/
         6XbxG6gCT10TR6Eu0eIFRS14StnDcBuWN6s6O+LHq+43hsZJw7DoSZOnmZF7gAavOx1z
         X2Mw==
X-Gm-Message-State: AOAM533B/0vx14tBpGM/2MqWNM9TTLUVmdZRjOu018EGVoou1u03lmw8
        oZ+WgL3dTVGzCZz+KaeL8oe7BElxjAY=
X-Google-Smtp-Source: ABdhPJz8JTMGnrqTTXH5HHI8V9LvTeRkoBxyqkCDxa7MU/zJqPhjWvjTWyBOVhsh9oJTp+e0EJKSRw==
X-Received: by 2002:a5d:6212:: with SMTP id y18mr4358773wru.608.1638340858876;
        Tue, 30 Nov 2021 22:40:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm19559931wru.21.2021.11.30.22.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:40:58 -0800 (PST)
Message-Id: <b611c73bd158b31d200d324cfc3b141161ac0b96.1638340854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:46 +0000
Subject: [PATCH v5 03/11] unpack-trees: refuse to remove
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
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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
index a05abd18187..398908dfc93 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -113,7 +113,7 @@ test_expect_success 'checkout does not clean cwd incidentally' '
 '
 
 test_expect_success 'checkout fails if cwd needs to be removed' '
-	test_required_dir_removal failure git checkout fd_conflict
+	test_required_dir_removal success git checkout fd_conflict
 '
 
 test_expect_success 'reset --hard does not clean cwd incidentally' '
@@ -144,23 +144,17 @@ test_expect_success 'merge fails if cwd needs to be removed; recursive friendly'
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
@@ -168,7 +162,7 @@ test_expect_success 'cherry-pick does not clean cwd incidentally' '
 '
 
 test_expect_success 'cherry-pick fails if cwd needs to be removed' '
-	test_required_dir_removal failure git cherry-pick fd_conflict
+	test_required_dir_removal success git cherry-pick fd_conflict
 '
 
 test_expect_success 'rebase does not clean cwd incidentally' '
@@ -184,7 +178,7 @@ test_expect_success 'revert does not clean cwd incidentally' '
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

