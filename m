Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B33C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B64661178
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhGUBDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhGUBCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 21:02:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05791C0613DD
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f9so368560wrq.11
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rcHy2kpyRrd2ur35EtZQmqWsp1/MLlYIB4KAKIEEBjM=;
        b=eU1EWz33nouYslDTpYCHVv0P6NQboYwyg+Zwyvt8sBwhjsT7KcfiLAj3baonoVTbl0
         JVOz/XxPXkusQf6XslmkdoU0SeZxdpNZvj4Y+QggrR16E/of45wrKs4aRUkwkPeGDy8m
         4WzbnNsa9GJanq8weo0UEwkP/8WoLlQYotB+eMjD28wGmSn1XqwPa2Rb1nE2MQlZ6Cv/
         ofe6107oXlZLnjSPH21bX+zFhMADZpr0yAeM4Bl0gSzLQjUJCPTnr58/ueKD2FTgldNR
         XGgRDeb4/3dExXNSCRWBAZ9mprwwod51eP9qvVALFV2qPwFQXS/VasOyLmCS3HK/YU5V
         mCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rcHy2kpyRrd2ur35EtZQmqWsp1/MLlYIB4KAKIEEBjM=;
        b=POiPZOR0H7r06S02xrELtYMtge/PDQrUItI9yC01csIkoIps5qQVP2Q9oXjEhBHlwS
         esh1K1ZiZ7595Whle3LgHnu+s5/d92ixooAV1JmIBTZC8wvv5cfGRiqMfNdItgNyxN9y
         SfWI42uFMImADwKUTf+iXpY+bi2bY3I6cckicm8kCCFhswTYYmciWb6fEpkxSMNheQnY
         DNqEelY1upLV2wNtiLntZWozeltvqPVcXaWcF+iBDhsGz6CxOW9vEsq2KwABuWMEB5Dw
         vK0Bhi9sRAlcgkZZ59DqzX73kfqQ1ezXKX5XCRN30ty/Er6KWPz5bJeBvWAk+6Mheqy2
         nq6Q==
X-Gm-Message-State: AOAM5304ivxcCs7/j5pOZGS0UEqtSSVOQto9tB2j8Dntb9h+PG1R9Qag
        hSRvzrrZADSIrVBxN4pkxNhlZ7IHs9A=
X-Google-Smtp-Source: ABdhPJxNyfTbippKaxHZXuT6pDPJlhIpiLvSFimHANYYR2A4s6oEloN4HaI1ivujLOBQcszQl7pNZg==
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr41159927wrw.105.1626831750558;
        Tue, 20 Jul 2021 18:42:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm24382199wrt.89.2021.07.20.18.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:42:30 -0700 (PDT)
Message-Id: <90d49e0fb7897512d7386a72787bb15c3f23a4f6.1626831744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 01:42:23 +0000
Subject: [PATCH v2 7/8] pull: update docs & code for option compatibility with
 rebasing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

git-pull.txt includes merge-options.txt, which is written assuming
merges will happen.  git-pull has allowed rebases for many years; update
the documentation to reflect that.

While at it, pass any `--signoff` flag through to the rebase backend too
so that we don't have to document it as merge-specific.  Rebase has
supported the --signoff flag for years now as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge.txt     |  2 ++
 Documentation/git-pull.txt      |  9 ++++----
 Documentation/merge-options.txt | 40 +++++++++++++++++++++++++++++++++
 builtin/pull.c                  |  2 ++
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3819fadac1f..e4f3352eb58 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -61,6 +61,8 @@ merge has resulted in conflicts.
 
 OPTIONS
 -------
+:git-merge: 1
+
 include::merge-options.txt[]
 
 -m <msg>::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index cad3f6bfcee..077961dfa1f 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -19,13 +19,12 @@ Incorporates changes from a remote repository into the current branch.
 If the current branch is behind the remote, then by default it will
 fast-forward the current branch to match the remote.  If the current
 branch and the remote have diverged, the user needs to specify how to
-reconcile the divergent branches with `--no-ff`, `--ff`, or `--rebase`
-(or the corresponding configuration options in `pull.ff` or
-`pull.rebase`).
+reconcile the divergent branches with `--rebase` or `--no-rebase` (or
+the corresponding configuration option in `pull.rebase`).
 
 More precisely, `git pull` runs `git fetch` with the given parameters
 and then depending on configuration options or command line flags,
-will call either `git merge` or `git rebase` to reconcile diverging
+will call either `git rebase` or `git merge` to reconcile diverging
 branches.
 
 <repository> should be the name of a remote repository as
@@ -136,7 +135,7 @@ published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
 --no-rebase::
-	Override earlier --rebase.
+	This is shorthand for --rebase=false.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396f..907327bf759 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -2,6 +2,9 @@
 --no-commit::
 	Perform the merge and commit the result. This option can
 	be used to override --no-commit.
+ifdef::git-pull[]
+	Only useful when merging.
+endif::git-pull[]
 +
 With --no-commit perform the merge and stop just before creating
 a merge commit, to give the user a chance to inspect and further
@@ -39,6 +42,7 @@ set to `no` at the beginning of them.
 	to `MERGE_MSG` before being passed on to the commit machinery in the
 	case of a merge conflict.
 
+ifdef::git-merge[]
 --ff::
 --no-ff::
 --ff-only::
@@ -47,6 +51,22 @@ set to `no` at the beginning of them.
 	default unless merging an annotated (and possibly signed) tag
 	that is not stored in its natural place in the `refs/tags/`
 	hierarchy, in which case `--no-ff` is assumed.
+endif::git-merge[]
+ifdef::git-pull[]
+--ff-only::
+	Only update to the new history if there is no divergent local
+	history.  This is the default when no method for reconciling
+	divergent histories is provided (via the --rebase=* flags).
+
+--ff::
+--no-ff::
+	When merging rather than rebasing, specifies how a merge is
+	handled when the merged-in history is already a descendant of
+	the current history.  If merging is requested, `--ff` is the
+	default unless merging an annotated (and possibly signed) tag
+	that is not stored in its natural place in the `refs/tags/`
+	hierarchy, in which case `--no-ff` is assumed.
+endif::git-pull[]
 +
 With `--ff`, when possible resolve the merge as a fast-forward (only
 update the branch pointer to match the merged branch; do not create a
@@ -55,9 +75,11 @@ descendant of the current history), create a merge commit.
 +
 With `--no-ff`, create a merge commit in all cases, even when the merge
 could instead be resolved as a fast-forward.
+ifdef::git-merge[]
 +
 With `--ff-only`, resolve the merge as a fast-forward when possible.
 When not possible, refuse to merge and exit with a non-zero status.
+endif::git-merge[]
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
@@ -73,6 +95,9 @@ When not possible, refuse to merge and exit with a non-zero status.
 	In addition to branch names, populate the log message with
 	one-line descriptions from at most <n> actual commits that are being
 	merged. See also linkgit:git-fmt-merge-msg[1].
+ifdef::git-pull[]
+	Only useful when merging.
+endif::git-pull[]
 +
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
@@ -102,10 +127,17 @@ With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
 +
 With --squash, --commit is not allowed, and will fail.
+ifdef::git-pull[]
++
+Only useful when merging.
+endif::git-pull[]
 
 --no-verify::
 	This option bypasses the pre-merge and commit-msg hooks.
 	See also linkgit:githooks[5].
+ifdef::git-pull[]
+	Only useful when merging.
+endif::git-pull[]
 
 -s <strategy>::
 --strategy=<strategy>::
@@ -127,6 +159,10 @@ With --squash, --commit is not allowed, and will fail.
 	default trust model, this means the signing key has been signed by
 	a trusted key.  If the tip commit of the side branch is not signed
 	with a valid key, the merge is aborted.
+ifdef::git-pull[]
++
+Only useful when merging.
+endif::git-pull[]
 
 --summary::
 --no-summary::
@@ -166,3 +202,7 @@ endif::git-pull[]
 	projects that started their lives independently. As that is
 	a very rare occasion, no configuration variable to enable
 	this by default exists and will not be added.
+ifdef::git-pull[]
++
+Only useful when merging.
+endif::git-pull[]
diff --git a/builtin/pull.c b/builtin/pull.c
index 94464ca196f..a15d4154093 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -893,6 +893,8 @@ static int run_rebase(const struct object_id *newbase,
 	strvec_pushv(&args, opt_strategy_opts.v);
 	if (opt_gpg_sign)
 		strvec_push(&args, opt_gpg_sign);
+	if (opt_signoff)
+		strvec_push(&args, opt_signoff);
 	if (opt_autostash == 0)
 		strvec_push(&args, "--no-autostash");
 	else if (opt_autostash == 1)
-- 
gitgitgadget

