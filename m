Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29019C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiG2I0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiG2I0I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C962E6A6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v5so2186785wmj.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5S72UZti9Wzpdk3f5bdC4w9ltfycZlQOtVo05XS1s5E=;
        b=eLBg9FKpmWcjNSyGyn5WYpXJ5AUxsmGdxjU/kpX6pFgyAM3RpoQhWtgk5gPla64SCZ
         DHUVkL6OOqte5CedqVpaQaDm5oKCZ0ewc0a3pXWdCoyDG8gAs2Vqca6XlZZZ7f5G28h2
         H5IZY0EV62v1UdyUT2WpeDgJpmQp15N8iwvCPVP4oiCGWpGreJ9VIX62GdI6cppJr5Tx
         32/ykIO2XdoTelOorxmujn9aKvT8IbnZB9vab9L0CDP3dWjUGGpPTj1j08p4vpNLw++7
         YfgZIzMSERqGjz7KnxcwjDv6dzb6kbEAlXvjmPC4r7pePHsqkplPNKuNXTt6WHV9q6Ka
         ijPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5S72UZti9Wzpdk3f5bdC4w9ltfycZlQOtVo05XS1s5E=;
        b=NZKL2TzictnRUfSIKnluxuv1NaGxahw2iSlwMy+mHxTtorrBOffR5SV97ky5EY+4L1
         ok0DqrRY6JD6t2X7Wqvl8Zh+Ai7ZEsNPiRPS++iNhXcps5EhalFy7CzF5epJbJYGEM3l
         3Q9RQIvksQgP2/qTCuFOrQJNArPNnnMpJO+WDs7x3nUzvzy1GgSLzYeUKsbqAf/kTZq7
         +Q/SzqC0GwA9iHtebA96glU7I85Dt3saQ6i/4s4mLkN6LnDfGee9yyAXTyJQDrAEa22C
         iUW1KdSKNK29AdipwPj8lcSu62cKtenvIOpX5fegZaq/Y63miqlknrlkXfMUayBE9Ovm
         PK7w==
X-Gm-Message-State: AJIora8Al+Bki4fhqEGJYMVc+yj0bigb21MEDUzeL6vGbhv3KDOnKDI2
        NmFgRZAISbJKedg+lx4Zox29cQNONZlBCw==
X-Google-Smtp-Source: AGRyM1vsBLMIu+L3sSpFi8/dBiuWpe02Ak8GG/RpC8YcDaihoJB2/lQ6pf5/0C5/sYJOefSs5xFj1A==
X-Received: by 2002:a05:600c:3ac6:b0:3a3:4178:a9a8 with SMTP id d6-20020a05600c3ac600b003a34178a9a8mr2042953wms.22.1659083165010;
        Fri, 29 Jul 2022 01:26:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:26:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 9/9] docs: add CONFIGURATION sections that fuzzy map to built-ins
Date:   Fri, 29 Jul 2022 10:25:55 +0200
Message-Id: <patch-v2-9.9-91689154926-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
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
   "CONFIGURATION" section to git-annotate(1), only to git-blame(1)>

 * config/branch.txt: maps to both git-checkout.txt and
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

 * config/remote.txt: let's not include this in
   git-{fetch,remote,push}.txt etc. for now, various options there
   change their behavior.

 * config/remotes.txt: As we're not including config/remote.txt for
   now, let's not include this one either.

 * config/credential.txt: let's not include this in
   git-credential.txt, it talks more generally about how the
   credential facility is used by various other commands, not that
   command in particular.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-blame.txt    | 6 ++++++
 Documentation/git-branch.txt   | 4 ++++
 Documentation/git-checkout.txt | 7 +++++++
 Documentation/git-clone.txt    | 2 ++
 Documentation/git-column.txt   | 7 +++++++
 Documentation/git-diff.txt     | 7 +++++++
 Documentation/git-fetch.txt    | 7 +++++++
 Documentation/git-switch.txt   | 7 +++++++
 8 files changed, 47 insertions(+)

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
index b9ee8a87238..43955a3b504 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -368,6 +368,8 @@ CONFIGURATION
 
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
2.37.1.1196.g8af3636bc64

