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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4062EC432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 13:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276A260F9D
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 13:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhG1Nxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbhG1Nuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 09:50:52 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E338C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 06:50:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id d17so1507599qvn.13
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhTrzwVXo9z4iac6E6Vln5BduEZzo2pO/4fOndB0FFA=;
        b=gPjjkXgzzjhQdw5c2tzfyoReCVusKDaKDtMIWiCIjKZl41dftfytM3JKFzp/OiHamh
         IaKfbGiJ9GsmQk0xWtmHHJW5VdLeHofsLEbPRaxze1+YfE9rO/8lRJjh4W07omCzjFrb
         8C5F2l2bME5likqUzGU463r3pKzU1s6R0HKOVhJo5PhvHvtNlhztWq6GZJZECGiOyNQC
         XLGLBYHLvFkswT7UuwHTAmGnewynCvaJTZYYaE1ZxwhttJetir8SwozsM4TvPcw3TKOi
         bxTJhyDDMNrO3bspial/hUX4TQPbBv+e5c2rZaEvrO9RnTlE7adHz2egq5TuT9Cq3n7U
         N8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhTrzwVXo9z4iac6E6Vln5BduEZzo2pO/4fOndB0FFA=;
        b=a9IZtEJLg891ZDoXR/cSfS8DRcL9xnxnjl69tmFiEs1xlDmqV0CWi+tcjoFz26tvaB
         5u8ma4KCPHo3gC4leRnPLAs29+Uxzc0C3dJEPbVeBWBZnOk0gD1t1QEEmlISsbV5YOTT
         3DG6NSiTp3QHSEFgRfHimTZwV6mX0xlwHiKWMxFTZ58+LKInxIts3vFjeW2EmgI2zNYw
         /OmZ5TUkdfLV0S3ynqHjtWd0iGUpURFvKh0i+cjbcLvQw3fkYuqVyA1Xtz2NXFQb/V2M
         5xZN3CuEx20rhpZgu+CK3aK7G67xJc41NsErm9+09av0Jl9HRSd0EQEjlRlSMImpkGM0
         mFEw==
X-Gm-Message-State: AOAM530O0aGzbeMHomjXBDMQYXUX1JLo+2O5nxEIa+C6N8P+3vLfdO4t
        G3TrGpwW6Dpc1IV193uGzWDrgUhxw0EQwA==
X-Google-Smtp-Source: ABdhPJzjt4UBeWAlag1tqDqZMlfms2O4NhQHwYEhB+7jqeW52uJ9UJIZp5J08wc7ImGuNa2QttHBQg==
X-Received: by 2002:a05:6214:ac1:: with SMTP id g1mr28936810qvi.51.1627480249280;
        Wed, 28 Jul 2021 06:50:49 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id x7sm2728861qtw.24.2021.07.28.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 06:50:48 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/1] config: support setting up a remote tracking branch upon creation
Date:   Wed, 28 Jul 2021 09:50:41 -0400
Message-Id: <20210728135041.501850-2-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728135041.501850-1-mathstuf@gmail.com>
References: <20210728135041.501850-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `branch.autoSetupMerge` works well for setting up tracking a local
branch, but there is no mechanism to automatically set up a remote
tracking situation. This patch adds the following configuration values:

  - `branch.defaultRemote`: initializes `branch.<name>.remote` if not
    otherwise given;
  - `branch.defaultPushRemote`: initializes `branch.<name>.pushRemote`
    (currently falls back on `remote.pushDefault` when pushing); and
  - `branch.defaultMerge`: initializes `branch.<name>.merge` if not
    otherwise given.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/config/branch.txt | 15 +++++++++
 branch.c                        | 28 ++++++++++------
 branch.h                        |  3 ++
 config.c                        | 15 +++++++++
 environment.c                   |  3 ++
 t/t3200-branch.sh               | 57 +++++++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc..6e9d446066 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -1,3 +1,18 @@
+branch.defaultRemote::
+	When a new branch is created with 'git branch', 'git switch' or 'git
+	checkout', this value will be used to initialize the
+	"branch.<name>.remote" setting.
+
+branch.defaultPushRemote::
+	When a new branch is created with 'git branch', 'git switch' or 'git
+	checkout', this value will be used to initialize the
+	"branch.<name>.pushRemote" setting.
+
+branch.defaultMerge::
+	When a new branch is created with 'git branch', 'git switch' or 'git
+	checkout', this value will be used to initialize the
+	"branch.<name>.merge" setting.
+
 branch.autoSetupMerge::
 	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
diff --git a/branch.c b/branch.c
index 7a88a4861e..0e8ece8259 100644
--- a/branch.c
+++ b/branch.c
@@ -60,6 +60,9 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
+	const char *actual_origin = origin ? origin : git_branch_remote;
+	const char *actual_push_origin = git_branch_push_remote;
+	const char *actual_remote = remote ? remote : git_branch_merge;
 
 	if (skip_prefix(remote, "refs/heads/", &shortname)
 	    && !strcmp(local, shortname)
@@ -70,12 +73,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
+	if (git_config_set_gently(key.buf, actual_origin ? actual_origin : ".") < 0)
+		goto out_err;
+
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.pushremote", local);
+	if (git_config_set_gently(key.buf, actual_push_origin) < 0)
 		goto out_err;
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	if (git_config_set_gently(key.buf, remote) < 0)
+	if (git_config_set_gently(key.buf, actual_remote) < 0)
 		goto out_err;
 
 	if (rebasing) {
@@ -88,27 +96,27 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (shortname) {
-			if (origin)
+			if (actual_origin)
 				printf_ln(rebasing ?
 					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
 					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
-					  local, shortname, origin);
+					  local, shortname, actual_origin);
 			else
 				printf_ln(rebasing ?
 					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
 					  _("Branch '%s' set up to track local branch '%s'."),
 					  local, shortname);
 		} else {
-			if (origin)
+			if (actual_origin)
 				printf_ln(rebasing ?
 					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
 					  _("Branch '%s' set up to track remote ref '%s'."),
-					  local, remote);
+					  local, actual_remote);
 			else
 				printf_ln(rebasing ?
 					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
 					  _("Branch '%s' set up to track local ref '%s'."),
-					  local, remote);
+					  local, actual_remote);
 		}
 	}
 
@@ -119,9 +127,9 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	error(_("Unable to write upstream branch configuration"));
 
 	advise(_(tracking_advice),
-	       origin ? origin : "",
-	       origin ? "/" : "",
-	       shortname ? shortname : remote);
+	       actual_origin ? actual_origin : "",
+	       actual_origin ? "/" : "",
+	       shortname ? shortname : actual_remote);
 
 	return -1;
 }
diff --git a/branch.h b/branch.h
index df0be61506..6ce978731d 100644
--- a/branch.h
+++ b/branch.h
@@ -14,6 +14,9 @@ enum branch_track {
 };
 
 extern enum branch_track git_branch_track;
+extern const char* git_branch_remote;
+extern const char* git_branch_push_remote;
+extern const char* git_branch_merge;
 
 /* Functions for acting on the information about branches. */
 
diff --git a/config.c b/config.c
index f33abeab85..42fc510a9f 100644
--- a/config.c
+++ b/config.c
@@ -1599,6 +1599,21 @@ static int git_default_branch_config(const char *var, const char *value)
 			return error(_("malformed value for %s"), var);
 		return 0;
 	}
+	if (!strcmp(var, "branch.defaultremote")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&git_branch_remote, var, value);
+	}
+	if (!strcmp(var, "branch.defaultpushremote")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&git_branch_push_remote, var, value);
+	}
+	if (!strcmp(var, "branch.defaultmerge")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&git_branch_merge, var, value);
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index 2f27008424..3b4d54e7dc 100644
--- a/environment.c
+++ b/environment.c
@@ -60,6 +60,9 @@ int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding = "SHIFT-JIS";
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
+const char* git_branch_remote = NULL;
+const char* git_branch_push_remote = NULL;
+const char* git_branch_merge = NULL;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..2edfb50872 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -797,6 +797,63 @@ test_expect_success 'test tracking setup via --track but deeper' '
 	test "$(git config branch.my7.merge)" = refs/heads/o/o
 '
 
+test_expect_success 'test tracking setup via branch.default* and --track' '
+	git config branch.autosetupmerge always &&
+	git config branch.defaultremote local &&
+	git config branch.defaultmerge main &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track other/foo my2 &&
+	git config branch.autosetupmerge false &&
+	test "$(git config branch.my2.remote)" = other &&
+	! test "$(git config branch.my2.pushremote)" = other &&
+	test "$(git config branch.my2.merge)" = refs/heads/foo
+'
+
+test_expect_success 'test tracking setup via branch.default* and --no-track' '
+	git config branch.autosetupmerge always &&
+	git config branch.defaultremote local &&
+	git config branch.defaultmerge main &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track my2 &&
+	git config branch.autosetupmerge false &&
+	! test "$(git config branch.my2.remote)" = local &&
+	! test "$(git config branch.my2.pushremote)" = other &&
+	! test "$(git config branch.my2.merge)" = refs/heads/main
+'
+
+test_expect_success 'test tracking setup via branch.default*' '
+	git config branch.autosetupmerge always &&
+	git config branch.defaultremote local &&
+	git config branch.defaultmerge main &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch my2 &&
+	git config branch.autosetupmerge false &&
+	test "$(git config branch.my2.remote)" = local &&
+	! test "$(git config branch.my2.pushremote)" = other &&
+	test "$(git config branch.my2.merge)" = refs/heads/main
+'
+
+test_expect_success 'test tracking setup via branch.default* with pushremote' '
+	git config branch.autosetupmerge always &&
+	git config branch.defaultremote local &&
+	git config branch.defaultpushremote other &&
+	git config branch.defaultmerge main &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch my2 &&
+	git config branch.autosetupmerge false &&
+	test "$(git config branch.my2.remote)" = local &&
+	test "$(git config branch.my2.pushremote)" = other &&
+	test "$(git config branch.my2.merge)" = refs/heads/main
+'
+
 test_expect_success 'test deleting branch deletes branch config' '
 	git branch -d my7 &&
 	test -z "$(git config branch.my7.remote)" &&
-- 
2.31.1

