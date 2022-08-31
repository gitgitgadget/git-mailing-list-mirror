Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA84ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiHaImP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiHaImF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:42:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF137C1210
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:42:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s23so6967953wmj.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VBV3cdDRJWOF3fBy2gBku4gJdRc7TgKOqa+yI6S8SPg=;
        b=Y4/vJ72pbF4kmk7e5Sgy6bYQOlKSZAN7e/2yDze/nzNvMDfIujtl26fgDlqTXWLQvE
         y/8mnD2yjA4b/epnmPGcX7DOPW1NRqGC9LzPPPN6I4BN91YVOeqpamOVKf8YAeLGFlXS
         k/1Mviz9TkpgtvDFGNTexVui/+HW5wpeG5ny4sLf9K3k+nFL4CPZmXQazCxGy4ogmPku
         OBFk8I0WnJfCxsXe9fwchPRso9CCF+vbbRrU55o4SPkZTBFlGTH7LKMqiI1RbPwiwqX1
         d0RJrMfrU251x9H1E3XRxEXW00vwN98aNEVoN36xjuoNEErCpvT4uJmkeLzPWD1ATMea
         vY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VBV3cdDRJWOF3fBy2gBku4gJdRc7TgKOqa+yI6S8SPg=;
        b=s6IiAt695cXOYcsURa3A8wsjQ5sPjl2BaRSLQTLUCM/x/DHInNM3meTb9fBuIefmbI
         Uz9+9WK86LHBsyKAq39mewUdi8ti81zFuuS4Dt3Xt92QdL9Ce6MtSA/yLjSIQXrYrmbN
         Ww9Q09us9xBHudElC6Y2hcgYMJPuazxL4TlrrDjEpxKsTL7MCa8SKDEWs0XPjHuLvgqA
         xDNNbiz2mCX4wqy6pNTRfmCYlVXslPps9Oxy+z7AaRM669HrA7jP6PaRloy3rFEj/n/J
         3+MYKEC6CKFCfeo4d10LPhQNi3KzCQpVJXE9ogn153B2jou7oMssJeW5uLRYKjK7M2mH
         +qzA==
X-Gm-Message-State: ACgBeo0+naSN3rsh8rV/4Vc6cv+7O2i0RY4jvW6M1m2rouMNYEYfnzkL
        D0jZWwOIaWg0GCnxJzQFZkMmvwLflh3Pcg==
X-Google-Smtp-Source: AA6agR5klT3/9gBI63CnQav9RYO/nNClPRosa6NajaGSsP1LxBjS+S03S0/7iJ/fVw4/b3iq40TVxQ==
X-Received: by 2002:a05:600c:a05:b0:3a6:71e6:47b8 with SMTP id z5-20020a05600c0a0500b003a671e647b8mr1240515wmp.29.1661935319466;
        Wed, 31 Aug 2022 01:41:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/9] docs: add CONFIGURATION sections that map to a built-in
Date:   Wed, 31 Aug 2022 10:41:39 +0200
Message-Id: <patch-v3-8.9-af912e9ca65-20220831T083759Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a CONFIGURATION section to the documentation of various built-ins,
for those cases where the relevant config/NAME.txt describes
configuration that is only used by the relevant built-in documented in
git-NAME.txt. Subsequent commits will handle more complex cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-add.txt          | 7 +++++++
 Documentation/git-am.txt           | 7 +++++++
 Documentation/git-clean.txt        | 7 +++++++
 Documentation/git-clone.txt        | 7 +++++++
 Documentation/git-commit-graph.txt | 7 +++++++
 Documentation/git-commit.txt       | 4 ++++
 Documentation/git-fast-import.txt  | 7 +++++++
 Documentation/git-init.txt         | 7 +++++++
 Documentation/git-mailinfo.txt     | 7 +++++++
 Documentation/git-maintenance.txt  | 7 +++++++
 Documentation/git-push.txt         | 7 +++++++
 Documentation/git-revert.txt       | 7 +++++++
 Documentation/git-show-branch.txt  | 7 +++++++
 Documentation/git-stash.txt        | 7 +++++++
 14 files changed, 95 insertions(+)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9b37f356542..a030d33c6e7 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -433,6 +433,13 @@ they will make the patch impossible to apply:
 * deleting context or removal lines
 * modifying the contents of context or removal lines
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/add.txt[]
+
 SEE ALSO
 --------
 linkgit:git-status[1]
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 320da6c4f76..326276e51ce 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -258,6 +258,13 @@ This command can run `applypatch-msg`, `pre-applypatch`,
 and `post-applypatch` hooks.  See linkgit:githooks[5] for more
 information.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/am.txt[]
+
 SEE ALSO
 --------
 linkgit:git-apply[1].
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index a7f309dff5a..91742633fa8 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -133,6 +133,13 @@ help::
 
   Show brief usage of interactive git-clean.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/clean.txt[]
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 632bd1348ea..b9ee8a87238 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -363,6 +363,13 @@ $ cd my-linux
 $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
 ------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/clone.txt[]
+
 
 GIT
 ---
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 047decdb65b..36fe56c2c71 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -142,6 +142,13 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
 ------------------------------------------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/commitgraph.txt[]
+
 
 FILE FORMAT
 -----------
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6c60bf98f9f..225c6c9f2e5 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -557,6 +557,10 @@ The editor used to edit the commit log message will be chosen from the
 `VISUAL` environment variable, or the `EDITOR` environment variable (in that
 order).  See linkgit:git-var[1] for details.
 
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/commit.txt[]
+
 HOOKS
 -----
 This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 39cfa05b28b..8b5dd6add00 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1564,6 +1564,13 @@ operator can use this facility to peek at the objects and refs from an
 import in progress, at the cost of some added running time and worse
 compression.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/fastimport.txt[]
+
 SEE ALSO
 --------
 linkgit:git-fast-export[1]
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index ad921fe782e..160dea1372c 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -169,6 +169,13 @@ $ git commit    <3>
 <2> Add all existing files to the index.
 <3> Record the pristine state as the first commit in the history.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/init.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 3fcfd965fde..28060283c70 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -115,6 +115,13 @@ If no such configuration option has been set, `warn` will be used.
 <patch>::
 	The patch extracted from e-mail.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/mailinfo.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index e56bad28c65..9c630efe19c 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -397,6 +397,13 @@ If you want to customize the background tasks, please rename the tasks
 so future calls to `git maintenance (start|stop)` do not overwrite your
 custom tasks.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/maintenance.txt[]
+
 
 GIT
 ---
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2f25aa3a291..def7657ef9c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -692,6 +692,13 @@ a `git gc` command on the origin repository.
 
 include::transfer-data-leaks.txt[]
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/push.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 0105a54c1a5..5016755efb6 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -142,6 +142,13 @@ EXAMPLES
 	changes. The revert only modifies the working tree and the
 	index.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/revert.txt[]
+
 SEE ALSO
 --------
 linkgit:git-cherry-pick[1]
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 5cc2fcefbab..e5ec6b467f9 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -199,6 +199,13 @@ shows 10 reflog entries going back from the tip as of 1 hour ago.
 Without `--list`, the output also shows how these tips are
 topologically related with each other.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/showbranch.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 6e15f475257..c5d70918283 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -382,6 +382,13 @@ grep commit | cut -d\  -f3 |
 xargs git log --merges --no-walk --grep=WIP
 ----------------------------------------------------------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/stash.txt[]
+
 
 SEE ALSO
 --------
-- 
2.37.3.1406.g184357183a6

