Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37CAECAAD3
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 08:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiIGI1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiIGI13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 04:27:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81B6AB4FB
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 01:27:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so331516wmk.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZvxZ/JISq8Fda5vvgs9fKX3Du4MVaRav5PtRnzxKqN8=;
        b=HEb2zrXd0P1+rVmi2WJxrPtX1I7RKfgSWZxe2QxEGZk78bJ484YaokJwCNPCdbGBa7
         SitPSBoj9Z+L5TM0bk2OPYIBiHakofs375jdyxHttsE9bQa4QprHIu9fVKyQSifx2Xgb
         b+hJ85czV7ordtEpN7bY8I1WIvZmc+uPxOCFiC3hnDZFfnOGIS/NRTWXbnHOFATvqhXb
         nMJcbcY0MO9mjSavVBM6CoeAAg6tFQqbD0qgCbIf1zDLg2XrlJXiX8/EDbwubx41/aNF
         tEydxMSe5KxKFgGwTn2bTz6z/yVEVNW1N4GsS1wAqX9Ua9TExjR5PSIY3EUTecOB8Zhf
         v7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZvxZ/JISq8Fda5vvgs9fKX3Du4MVaRav5PtRnzxKqN8=;
        b=gebybw8mkOc0cQ9f9lvWXG3aICvcela5f+4CAnUe4X8F4VaqMwN3oMNGTk1yKYUN6u
         50ZCNnPEmUGiVaaTO9cDPo1M2iD9JIwzfrWWTyQ1J6aILCxrtBX0yrA50Td6sw4beF2d
         vI3m0Fx5NGLSoK9n5XxGyopOmuLdvfLvo21F28vOTltz81bJTmRakzePHLaIKE19FWxb
         5NXk4cpso17JJGCP18BOidL0Tr2MWeGWE0ffOB2hvmpqPrVZiIXZ//1DGztN66tozChN
         utVTMFbxIsjEEhX2hjXlpvgVkWEtjGlOWmuo5KoGALqHUztmJATOPGrEzkAGUJcl3xfn
         epAw==
X-Gm-Message-State: ACgBeo2Mndy4SZMjH7XkPSj7m68Pdn4QutN5txG1NXVew+kmD5FgcvEu
        qms+iFARMI6dYqeyYVQeoY4BXAEIal85SQ==
X-Google-Smtp-Source: AA6agR5zrQiGOa0xoG6Y7pLHb36OboEVIZkjp1K6kDdNkdLkz/nMepDuSTD3CEXM28r1TVimDtJQug==
X-Received: by 2002:a05:600c:22c8:b0:3a5:c134:1f50 with SMTP id 8-20020a05600c22c800b003a5c1341f50mr16474749wmg.55.1662539240618;
        Wed, 07 Sep 2022 01:27:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm19532096wmq.4.2022.09.07.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:27:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 9/9] docs: add CONFIGURATION sections that fuzzy map to built-ins
Date:   Wed,  7 Sep 2022 10:27:05 +0200
Message-Id: <patch-v4-9.9-738ee46512d-20220907T082419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1490.g9adf4224da0
In-Reply-To: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a CONFIGURATION section to the documentation of various built-ins,
for those cases where the relevant config/NAME.txt doesn't map only to
one git-NAME.txt. In particular:

 * config/blame.txt: used by git-{blame,annotate}.txt. Since the
   git-annotate(1) documentation refers to git-blame(1) don't add a
   "CONFIGURATION" section to git-annotate(1), only to git-blame(1).

 * config/checkout.txt: maps to both git-checkout.txt and
   git-switch.txt (but nothing else).

 * config/init.txt: should be included in git-init(1) and
   git-clone(1).

 * config/column.txt: We should ideally mention the relevant subset of
   this in git-{branch,clean,status,tag}.txt, but let's punt on it for
   now. We will when we eventually split these sort of files into
   e.g. config/column.txt and
   config/column/{branch,clean,status,tag}.txt, with the former
   including the latter set.

Things that are being left out, and why:

 * config/{remote,remotes,credential}.txt: Configuration that affects
   how we talk to remote repositories is harder to untangle. We'll need
   to include some of this in git-{fetch,remote,push,ls-remote}.txt
   etc., but some of those only use a small subset of these
   options. Let's leave this for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-blame.txt    | 6 ++++++
 Documentation/git-branch.txt   | 4 ++++
 Documentation/git-checkout.txt | 7 +++++++
 Documentation/git-clone.txt    | 2 ++
 Documentation/git-column.txt   | 7 +++++++
 Documentation/git-diff.txt     | 7 +++++++
 Documentation/git-fetch.txt    | 7 +++++++
 Documentation/git-init.txt     | 7 +++++++
 Documentation/git-switch.txt   | 7 +++++++
 9 files changed, 54 insertions(+)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index d7a46cc6744..4400a17330b 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -241,6 +241,12 @@ MAPPING AUTHORS
 
 See linkgit:gitmailmap[5].
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/blame.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index ae82378349d..12c5f84e3be 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -336,6 +336,10 @@ CONFIGURATION
 `--list` is used or implied. The default is to use a pager.
 See linkgit:git-config[1].
 
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/branch.txt[]
+
 EXAMPLES
 --------
 
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9f37e22e130..4cb9d555b4b 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -600,6 +600,13 @@ $ edit frotz
 $ git add frotz
 ------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/checkout.txt[]
+
 SEE ALSO
 --------
 linkgit:git-switch[1],
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 1c3d7017646..d6434d262d6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -375,6 +375,8 @@ CONFIGURATION
 
 include::includes/cmd-config-section-all.txt[]
 
+include::config/init.txt[]
+
 include::config/clone.txt[]
 
 
diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 6cea9ab4638..18431647a2d 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -74,6 +74,13 @@ v2.4.3  v2.4.4      v2.4.5      v2.4.6      v2.4.7
 v2.4.8  v2.4.9
 ------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/column.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 6236c75c9b8..85ae6d6d08a 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -213,6 +213,13 @@ $ git diff -R                          <2>
     rewrites (very expensive).
 <2> Output diff in reverse.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/diff.txt[]
+
 SEE ALSO
 --------
 diff(1),
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e9d364669af..63d9569e164 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -285,6 +285,13 @@ linkgit:git-gc[1]).
 
 include::transfer-data-leaks.txt[]
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/fetch.txt[]
+
 BUGS
 ----
 Using --recurse-submodules can only fetch new commits in submodules that are
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
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index bbcbdceb459..c60fc9c138b 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -265,6 +265,13 @@ always create a new name for it (without switching away):
 $ git switch -c good-surprises
 ------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/checkout.txt[]
+
 SEE ALSO
 --------
 linkgit:git-checkout[1],
-- 
2.37.3.1490.g9adf4224da0

