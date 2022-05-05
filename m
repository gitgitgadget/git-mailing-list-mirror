Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185E5C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 00:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiEEAyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 20:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiEEAyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 20:54:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53121241
        for <git@vger.kernel.org>; Wed,  4 May 2022 17:50:31 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t16so2157713qtr.9
        for <git@vger.kernel.org>; Wed, 04 May 2022 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KydD/MTJtm9qU0fy2NCws4ij8HR85/LV8uremO1pZdg=;
        b=QPOiQ2VvHrSZAvYyAeJfiP5cyQNQn/6DWUxX/bPE2EGUcMmbm2A5vsNHbv0Yhhdaov
         4XUxocMyp/U+aCwMancH7WejY4rR6wLm6YT0R4+iKYILWFpv7Fz9sA+a/MrkZW0RIoY8
         bz3Fa31Tz/qog7hGu0cb7j/7JaLa7y7WMy8ExFCxyBRmj8zdPUNnKUNk1vSyJNMx352M
         jaERHws7AcuDlGt0JVyRaf0SwNA0zCnpyyQPEWdzH5kSsuoHJFJvgA5wl+lqzwcnasbg
         Sf8pQzeVjLZCANe0NeMQ9BNt6CTgAq/ZeRRdyB0FCBkAJuAxiUxSKEJ9pNfK1STE5yhM
         v+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KydD/MTJtm9qU0fy2NCws4ij8HR85/LV8uremO1pZdg=;
        b=K5yW7UfWxk1mNUliv2SOvD/+oWppo2LWXg0KvIv2iLOWO8//ZKF9gZV5xCvFoIFRj2
         cGiNwEF5dRk964t10paKCRVLlFkHB7XoFPNY4MTbEXVJfUzWz/q9YiII2YCIFi+Q9/t/
         lu2Atc8j6Yq8vX5cwbeCI7TtS52xNm3EQ9nbwQexELn4dxt3ASaP1XfwYtHEhbdH3ArY
         ynFHDYBh/itZStVty6c481xCO/Gv4Z/1dKiNIoJUZk9qJSOxMKTv0+6HOzsUkG75NO5J
         SwEYAHWru6fetUok6SQ6OYmaesIvehTcYAylGbg+eo06xqyxCNX2eriTiVFmHykExoXz
         nprw==
X-Gm-Message-State: AOAM533kz625952S327jVyK5qzuUnt3D0klN2WQ33p68cFUMHjotMyqC
        njJ/Ch2DwxB9wuSy1vhD0t7o/HnsvGE=
X-Google-Smtp-Source: ABdhPJyt3gd1xQKf6V39N86Zv2f10sB5HVDwerNWQvPt8Q4rP9FGnzq/DqCLVYew+6MyWRNJq6v1Ew==
X-Received: by 2002:a05:622a:1651:b0:2f3:440c:5ffb with SMTP id y17-20020a05622a165100b002f3440c5ffbmr21822920qtj.232.1651711830823;
        Wed, 04 May 2022 17:50:30 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 19-20020a370313000000b0069fc13ce1f2sm58433qkd.35.2022.05.04.17.50.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2022 17:50:30 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, junio@pobox.com
Subject: [PATCH v2] setup: tighten ownership checks post CVE-2022-24765
Date:   Wed,  4 May 2022 17:50:09 -0700
Message-Id: <20220505005009.27789-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220504184401.17438-1-carenas@gmail.com>
References: <20220504184401.17438-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

8959555cee7 (setup_git_directory(): add an owner check for the top-level
directory, 2022-03-02), adds a function to check for ownership of
repositories using a directory that is representative of it (its workdir)
and ways to add it to an exception list if needed, but that check breaks
when the ownership of the workdir is not the same than the ownership of
directory where the configuration and other relevant files reside.

An attacker could create a git repository in a directory that he has write
access to but is owned by the victim, and therefore workaround the fix that
was introduced with CVE-2022-24765 to attack them, like in the following
scenario which could result in privilege escalation if root then runs a git
command in that directory or any of its sub directories:

  $ git -C /tmp init

To avoid that, extend the ensure_valid_ownership function to be able to
check for ownership of both the worktree and the gitdir, and use that for
non bare repositories.

Reported-by: Hanno Böck <hanno@hboeck.de>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes since RFC
* remove debug code from ensure_valid_ownership since is no longer needed
* replace convoluted logic in setup_git_directory_gently_1 with Junio's
* improve tests (AGAIN, not considered production and only for convenience)
* hopefully improved commit message and spelling.

The changes in setup.c should be sufficient to cover for all known issues, but
has been only lightly tested and mostly in *NIX, so more changes might be
needed to cover Windows. Specially the use of "/" to reconstruct the gitdir
based on the previously cut workdir might be problematic if not covered by
its compat code.

The code for setup_git_directory_gently_1 is inefficient (as pointed by
dscho) and could be improved by instead reusing the buffer before it is cut
by the setlen, but if doing so, then a copy of the full gitdir will be
needed, so a solution for that is not provided.

In the same line, we already know before getting into the condition, if we
are coming from a gitfile or not, so the is_absolute_path(gitdirenv) could
be optimized away, like it was done in the RFC with an incorrectly named
is_bare boolean, but that change hasn't been implemented as the cost of the
current implementation is unknown and feels like premature optimization.

Slightly off-topic and maybe more of an ADMINISTRATIVE, but had added the
Reported-by for the guy that came with the last report, not sure what the
right procedure is, and might be better if kept as a note, but be careful
of git send-email to avoid leaks, at least until we have a final version.

 setup.c                        | 28 +++++++++++++++++++++++-----
 t/t0034-root-safe-directory.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/setup.c b/setup.c
index aad9ace0af9..0fae2d71a3c 100644
--- a/setup.c
+++ b/setup.c
@@ -1054,14 +1054,21 @@ static int safe_directory_cb(const char *key, const char *value, void *d)
 	return 0;
 }
 
-static int ensure_valid_ownership(const char *path)
+static int ensure_valid_ownership(const char *worktree, const char *gitdir)
 {
-	struct safe_directory_data data = { .path = path };
+	struct safe_directory_data data = { .path = worktree };
+	const char *check_path;
+
+	if (gitdir)
+		check_path = gitdir;
+	else
+		check_path = worktree;
 
 	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
-	    is_path_owned_by_current_user(path))
+	    is_path_owned_by_current_user(check_path))
 		return 1;
 
+	data.is_safe = 0; /* ensure we are initialized and secure by default */
 	read_very_early_config(safe_directory_cb, &data);
 
 	return data.is_safe;
@@ -1166,14 +1173,25 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 		strbuf_setlen(dir, offset);
 		if (gitdirenv) {
-			if (!ensure_valid_ownership(dir->buf))
+			const char *gitdir_to_check = gitdirenv;
+			struct strbuf gdbuf = STRBUF_INIT;
+			int ret;
+
+			if (!is_absolute_path(gitdirenv)) {
+				strbuf_addf(&gdbuf, "%s/%s", dir->buf,
+						gitdirenv);
+				gitdir_to_check = gdbuf.buf;
+			}
+			ret = ensure_valid_ownership(dir->buf, gitdir_to_check);
+			strbuf_release(&gdbuf);
+			if (!ret)
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, gitdirenv);
 			return GIT_DIR_DISCOVERED;
 		}
 
 		if (is_git_directory(dir->buf)) {
-			if (!ensure_valid_ownership(dir->buf))
+			if (!ensure_valid_ownership(NULL, dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
 			return GIT_DIR_BARE;
diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
index a68e1d7602b..a3ddebb009a 100755
--- a/t/t0034-root-safe-directory.sh
+++ b/t/t0034-root-safe-directory.sh
@@ -47,6 +47,35 @@ test_expect_success SUDO 'sudo git status as original owner' '
 	)
 '
 
+test_expect_success SUDO 'unsecure worktree with non bare repository' '
+	sudo rm -rf root &&
+	sudo mkdir -p root/t &&
+	sudo chmod 1777 root/t &&
+	(
+		cd root/t &&
+		git init &&
+		git status &&
+		sudo git status &&
+		run_with_sudo <<-END
+			unset SUDO_UID &&
+			! git status
+		END
+	)
+'
+
+test_expect_success SUDO 'non bare repository using a gitfile' '
+	sudo rm -rf root &&
+	mkdir -p root/w &&
+	mkdir -p root/e &&
+	(
+		cd root/w &&
+		git init --separate-git-dir ../e &&
+		git status &&
+		sudo chown -R root ../e &&
+		test_must_fail git status
+	)
+'
+
 # this destroys the test environment used above
 test_expect_success SUDO 'cleanup regression' '
 	sudo rm -rf root
-- 
2.36.0.352.g0cd7feaf86f

