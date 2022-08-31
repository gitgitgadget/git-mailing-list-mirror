Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D94ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiHaImg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiHaImH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:42:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC68C3F7E
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:42:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so1519705wmk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=177HbPKpA+vDU9cGb7YMZnWGhSzW2rA667D6Ha8JIA8=;
        b=lr9DNhAJefpp5AXTsiMo1GX0MYaboP63c+vV5E4jAV/75NOz6Db8TCEiQLyYP8iv4X
         ioOSnpP4bLkXOf/i2xXo6ph3DL2942r7M1YGgKfm7Q1ayCJdfqZZwTSbW84V/Gdr7xpZ
         4+gcQIXlvKz/Fzlz24BRYj74RjNC8cFAlx71bhGCx0fK3N71+Wg0t/dUiHzmmDglmFDj
         Ei37526IZlhvryuoHkwe1+JZt00adcXod/Sh/CqU8PgZBYBa26EjzjW3xImGiWg5LKXb
         4CbxQAKkfvOZhEg/J4PYXhlcLy7Cp7kUow0d2+GicWEaasEiQcvwXcx5qfyLAQRWAPDE
         Tc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=177HbPKpA+vDU9cGb7YMZnWGhSzW2rA667D6Ha8JIA8=;
        b=JVvAaJXj2w1vMO1w1+ofd9VI96RLvmTMErTuiQG2jrMAtC3yQzJQj9MOj62P3ESS/A
         ikMlEECh0grKX0bzuC4SE1EXBQK0DjQuokDxv8LT4UD1NCzCcZqNYI6UchtvSw/zctWG
         hdaFcjWCZ0Wlz0J9Vp0jJ68opEUw+MQ1JXsF9OlcmSQDz093kioERjE2QTtmUCr/+oER
         p7zvT4XgHZEgBpwt8YxJfmlTJhIN/TqDuloCFP3au7cCUcdsuIsDfBltUIOvbcpB+fwt
         3Z0U1f2Dyccfm1iYMafkNG1DqwLuIVAT7V4ZjlouMuhc/Su3it8HBWExUssMnFB5HFAy
         sc9w==
X-Gm-Message-State: ACgBeo1O1W+/+X1KIQs4xtdrOXHeN/3mJ8+Fjy1dmcf086UgEFawLMUR
        rg8Dq8Vj9EZiGNJtTsji+W09WUTVuz0V7A==
X-Google-Smtp-Source: AA6agR7bxMLp010BFrdBmKkiSQjM03lE27YHWe8CCv+bcjTBqzfUo8BxB+sKNHXbwRC60sF+5v3/fA==
X-Received: by 2002:a1c:3842:0:b0:3a6:632b:6165 with SMTP id f63-20020a1c3842000000b003a6632b6165mr1207364wma.100.1661935320602;
        Wed, 31 Aug 2022 01:42:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 9/9] docs: add CONFIGURATION sections that fuzzy map to built-ins
Date:   Wed, 31 Aug 2022 10:41:40 +0200
Message-Id: <patch-v3-9.9-5ef36654bba-20220831T083759Z-avarab@gmail.com>
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
2.37.3.1406.g184357183a6

