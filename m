Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE5AC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiI1Ikk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiI1Ijy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED66D5AA3E
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id cc5so18624301wrb.6
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LRUboWp/sTVpM1mPN+0AXguP3udVIAkNQigXX8RSFr4=;
        b=fqiU/2zdy5oVGIWcngHU3L3jwWm9pLZZAKxTuCSYwOH/VGf6YQ1T7JUcRhNClBDmKn
         xnUjk/7aQdmnGAFZozK6Jx98PX0uEEJQr152qP4VtZEn1/IJbynvQZDYf0mXAtWdtLtz
         6OaXO+jQSXrKYGlgbDqmi5Fn0hPt5ZWNsE1dS4TOmlvW5fQ4cC6y71vuzGfBIYqcYe2d
         Bh5YeTU56zrBmtKTKuOGfyc/QFxl6apb8PdVKhPmnxYXZPKUt3vel/qC9ZwfPxiO/nCd
         ezuKiDyiCM7z0gZQgiGYEM/ckd+r05chL7YcwoqoUewR4fMZVVSfE3A51sBRwdFt9zju
         /YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LRUboWp/sTVpM1mPN+0AXguP3udVIAkNQigXX8RSFr4=;
        b=ngyF83W29L4nV70K909mC4vDT2f84YfxgM2VyOdb3I5EE4BY4+exLdJoQkP57w+Lol
         E0Fz+usQ8mqT069qNRBf0pnFLj+cEl6MJkLOxSjSHdQRG/sq5HOuEP/fVlsntSwYFto9
         c5C8dPRzrgztmYTflH+Nhtt8YltUV1yX96F2jWp34oWEOjMX18F6r2qToKaFOFlaLTUf
         UN7rh08FWtWNPxbgtVrdC7QiMssc3ZH0FIfts8X/HCGA10I1fOvjjHj6vwjIbRcWhK0V
         8liAB/nS4TzV9IJegGXTLLbsrYs1Tk8WvApBcgBE3gx9BQuLhtFN4+kpeAfvLUpKz4jk
         I7gg==
X-Gm-Message-State: ACrzQf3AfISgCysxCfYzPD6FFGsY6Tu5DUx+6Qo4pHkcmrCiwpMCzprK
        0Xqob+MaR9pfQCSnef9i1/HTbu5tBFnd7Q==
X-Google-Smtp-Source: AMsMyM7FTXlbqcxpdMNUvDQEFTT43jebMEM1Fkq3BMSudz1EVvnKI2L2yDojDSE2LIGPNh43lJ7pPw==
X-Received: by 2002:a05:6000:715:b0:22c:cb20:ec54 with SMTP id bs21-20020a056000071500b0022ccb20ec54mr166183wrb.324.1664354390604;
        Wed, 28 Sep 2022 01:39:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/35] stash doc SYNOPSIS & -h: correct padding around "[]()"
Date:   Wed, 28 Sep 2022 10:39:09 +0200
Message-Id: <patch-v2-14.35-6354bfea1b2-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The whitespace padding of alternatives should be of the form "[-f |
--force]" not "[-f|--force]". Likewise we should not have padding
before the first option, so "(--all | <pack-filename>...)" is correct,
not "( --all | <pack-filename>... )".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-stash.txt | 12 ++++++------
 builtin/stash.c             | 28 ++++++++++++++--------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 4856f452511..ea16d2eae7c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,17 +9,17 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<log-options>]
-'git stash' show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
-'git stash' drop [-q|--quiet] [<stash>]
-'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
+'git stash' show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
+'git stash' drop [-q | --quiet] [<stash>]
+'git stash' (pop | apply) [--index] [-q | --quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]
+'git stash' [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
+	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
 'git stash' clear
 'git stash' create [<message>]
-'git stash' store [(-m|--message) <message>] [-q|--quiet] <commit>
+'git stash' store [(-m | --message) <message>] [-q | --quiet] <commit>
 
 DESCRIPTION
 -----------
diff --git a/builtin/stash.c b/builtin/stash.c
index 51d40efaac7..d91cf5fd3e1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -24,16 +24,16 @@
 static const char * const git_stash_usage[] = {
 	N_("git stash list [<options>]"),
 	N_("git stash show [<options>] [<stash>]"),
-	N_("git stash drop [-q|--quiet] [<stash>]"),
-	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash drop [-q | --quiet] [<stash>]"),
+	N_("git stash (pop | apply) [--index] [-q | --quiet] [<stash>]"),
 	N_("git stash branch <branchname> [<stash>]"),
 	"git stash clear",
-	N_("git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]\n"
+	N_("git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n"
+	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n"
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "          [--] [<pathspec>...]]"),
-	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
+	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n"
+	   "          [-u | --include-untracked] [-a | --all] [<message>]"),
 	NULL
 };
 
@@ -48,17 +48,17 @@ static const char * const git_stash_show_usage[] = {
 };
 
 static const char * const git_stash_drop_usage[] = {
-	N_("git stash drop [-q|--quiet] [<stash>]"),
+	N_("git stash drop [-q | --quiet] [<stash>]"),
 	NULL
 };
 
 static const char * const git_stash_pop_usage[] = {
-	N_("git stash pop [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash pop [--index] [-q | --quiet] [<stash>]"),
 	NULL
 };
 
 static const char * const git_stash_apply_usage[] = {
-	N_("git stash apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash apply [--index] [-q | --quiet] [<stash>]"),
 	NULL
 };
 
@@ -73,20 +73,20 @@ static const char * const git_stash_clear_usage[] = {
 };
 
 static const char * const git_stash_store_usage[] = {
-	N_("git stash store [(-m|--message) <message>] [-q|--quiet] <commit>"),
+	N_("git stash store [(-m | --message) <message>] [-q | --quiet] <commit>"),
 	NULL
 };
 
 static const char * const git_stash_push_usage[] = {
-	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]\n"
+	N_("git stash [push [-p | --patch] [-k | --[no-]keep-index] [-q | --quiet]\n"
+	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n"
 	   "          [--] [<pathspec>...]]"),
 	NULL
 };
 
 static const char * const git_stash_save_usage[] = {
-	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "               [-u|--include-untracked] [-a|--all] [<message>]"),
+	N_("git stash save [-p | --patch] [-k | --[no-]keep-index] [-q | --quiet]\n"
+	   "               [-u | --include-untracked] [-a | --all] [<message>]"),
 	NULL
 };
 
-- 
2.38.0.rc1.925.gb61c5ccd7da

