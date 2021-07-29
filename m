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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8FEC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A5A6103A
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhG2CBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 22:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhG2CBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 22:01:39 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0FC061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:01:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id d17so2618469qvn.13
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HpOzNGm6NtxtxvPkNkJ7u5w1nrTthnnB9832wtBb/mU=;
        b=i8ZpFjFrGpDg8Ld+tEtSmRlctH46FVUy7iHwY8CBPOiAnvEWdmJXxJIp/Qc/Gjn0Dj
         uwvOBlWfizGX0Vt3z8/Qg2FM03BvqNML9XiCsl7dMh0i98DeDiJ02us55w325dIQxQBY
         QhrIHBWh843iDZ8byPHLPVULhaMyUMacUWCmPaZ2z7+otXauxQFxrhoy/tB8pG14bWCd
         zxyzM9lMCJ4Jr/mdBlXiXW9wsKY16x/lHRFNq9zfkLh/Nnhz0TJvcbNGfZPYDNmBF00L
         klVwQW+u/NGTwlQ2B8I4MsBeW8bs+yuI5knBR704HE5fmhKVKfA4kUJv9hI/WOlPnWla
         XX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpOzNGm6NtxtxvPkNkJ7u5w1nrTthnnB9832wtBb/mU=;
        b=lx9tC0rI1EqmK5S0irqsiNT3+vS3Jwy7cqDlPqRScnEGMHN6XGKpX93s+4+9R5Q8hl
         hf1ud8pAz9mBmjoBj5G2+sRvtGGTgcygRcSugk9MRiCl3dpHl3BbGbF4kgHE/At9cDql
         P1TIFAVgqLJJi9tfrjUZMmoyinBfCC8UGAmBdaNigFWrSLzZrBObUAB7/T+1RrxmRQMP
         M3BxKd1Hd3Hye3k4/113JUyb/FAed0ARehNSI8yFrQzp0nwwYnjOxRUvlZZvgsYX5PuF
         pp2nZS+PiALLvkWB64rFhAC+qgY979jwTMwNwoJ7W0e24/wjOwVIAq1RZiujpJDRsumh
         sNnw==
X-Gm-Message-State: AOAM531xJeXj9Mr2eg6w9mkaR4aKIQb69vIrwaF9FOUnt2l/ExYmHMQm
        kVfKyPRUV4a4Lvp+jm7tpD7ywbWkPqUF/Q==
X-Google-Smtp-Source: ABdhPJxic3spZz3pOJTMSJAi1LhJYFOrp52OsSZhee7RzuBdJR2Bl1Yj4IJ4MS0786R1c4VSajjitQ==
X-Received: by 2002:a05:6214:767:: with SMTP id f7mr3067243qvz.16.1627524095203;
        Wed, 28 Jul 2021 19:01:35 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id z9sm763256qtn.54.2021.07.28.19.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 19:01:34 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/1] config: support a default remote tracking setup upon branch creation
Date:   Wed, 28 Jul 2021 22:01:25 -0400
Message-Id: <20210729020125.746206-2-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210729020125.746206-1-mathstuf@gmail.com>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `branch.autoSetupMerge` works well today for setting up tracking a
local branch, but there is no easy mechanism to automatically set up a
remote tracking situation for workflows which use a single set of
branches for integration without specifying `--track` to every branch
creation command or branching directly from the remote ref. This patch
adds the following configuration values:

  - `branch.defaultRemote`: initializes `branch.<name>.remote` if not
    otherwise given;
  - `branch.defaultMerge`: initializes `branch.<name>.merge` if not
    otherwise given.

These effectively make branch creation commands such as `git branch`,
`git switch`, and `git checkout -b` have an implicit `-t
${branch.defaultRemote}/${branch.defaultMerge}` argument and is
equivalent to doing:

    $ git branch new-topic      # or another branch creation command
    $ git branch --set-upstream-to=${branch.defaultRemote}/${branch.defaultMerge} new-topic

In a fork-based workflow where contributions to the main project flow in
through forks of the main repository rather than pushing directly to it
(not uncommon of forge-hosted projects), the following setup may be
used:

    $ git config remote.pushDefault myfork    # push to `myfork` by default
    $ git config push.default simple          # the default
    $ git config branch.autoSetupMerge always # always setup tracking
    $ git config branch.defaultRemote origin  # track from `origin`
    $ git config branch.defaultMerge main     # track the `main` branch

With this setup, branches will automatically be set up to track
`origin/main` while being pushed to `myfork` by default. Some tools
(at least Vim's fugitive plugin) will show the commit differences
between both the tracking branch and the default push target. This
allows such tools to easily show "what needs to be merged?", "what has
happened on the target branch since this topic has been created?", and
"what is my status against my fork's current status?" at a glance.

Additionally, with the `extensions.worktreeConfig` setting, when a
separate work tree which is used for changes against a different branch
(e.g., a branch tracking a prior release), the `branch.defaultMerge`
setting may be changed independently, e.g., to `maint`.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/config/branch.txt | 14 ++++++++++++
 branch.c                        | 22 ++++++++++---------
 branch.h                        |  2 ++
 config.c                        | 10 +++++++++
 environment.c                   |  2 ++
 t/t3200-branch.sh               | 39 +++++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc..ab5cd2c1ed 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -1,3 +1,17 @@
+branch.defaultRemote::
+	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
+	so that it will track a branch on the specified remote. This can be
+	used, in conjunction with `branch.defaultMerge`, in projects where
+	branches tend to target a single branch. This will be used to
+	initialize the "branch.<name>.remote" setting.
+
+branch.defaultMerge::
+	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
+	so that it will track a branch with this name. This can be used, in
+	conjunction with `branch.defaultRemote` in projects where branches tend
+	to target a single branch. This will be used to initialize the
+	"branch.<name>.merge" setting.
+
 branch.autoSetupMerge::
 	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
diff --git a/branch.c b/branch.c
index 7a88a4861e..097d5af647 100644
--- a/branch.c
+++ b/branch.c
@@ -60,6 +60,8 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
+	const char *actual_origin = origin ? origin : git_branch_remote;
+	const char *actual_remote = remote ? remote : git_branch_merge;
 
 	if (skip_prefix(remote, "refs/heads/", &shortname)
 	    && !strcmp(local, shortname)
@@ -70,12 +72,12 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
+	if (git_config_set_gently(key.buf, actual_origin ? actual_origin : ".") < 0)
 		goto out_err;
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	if (git_config_set_gently(key.buf, remote) < 0)
+	if (git_config_set_gently(key.buf, actual_remote) < 0)
 		goto out_err;
 
 	if (rebasing) {
@@ -88,27 +90,27 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 
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
 
@@ -119,9 +121,9 @@ int install_branch_config(int flag, const char *local, const char *origin, const
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
index df0be61506..7d7990dda7 100644
--- a/branch.h
+++ b/branch.h
@@ -14,6 +14,8 @@ enum branch_track {
 };
 
 extern enum branch_track git_branch_track;
+extern const char* git_branch_remote;
+extern const char* git_branch_merge;
 
 /* Functions for acting on the information about branches. */
 
diff --git a/config.c b/config.c
index f33abeab85..a46c5a43a1 100644
--- a/config.c
+++ b/config.c
@@ -1599,6 +1599,16 @@ static int git_default_branch_config(const char *var, const char *value)
 			return error(_("malformed value for %s"), var);
 		return 0;
 	}
+	if (!strcmp(var, "branch.defaultremote")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&git_branch_remote, var, value);
+	}
+	if (!strcmp(var, "branch.defaultmerge")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&git_branch_merge, var, value);
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index 2f27008424..d550deabbd 100644
--- a/environment.c
+++ b/environment.c
@@ -60,6 +60,8 @@ int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding = "SHIFT-JIS";
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
+const char* git_branch_remote = NULL;
+const char* git_branch_merge = NULL;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..82137e8451 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -797,6 +797,45 @@ test_expect_success 'test tracking setup via --track but deeper' '
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
+	test "$(git config branch.my2.merge)" = refs/heads/main
+'
+
 test_expect_success 'test deleting branch deletes branch config' '
 	git branch -d my7 &&
 	test -z "$(git config branch.my7.remote)" &&
-- 
2.31.1

