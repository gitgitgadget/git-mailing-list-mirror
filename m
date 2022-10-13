Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D1C43217
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJMPkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJMPkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C171A835
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so3468026wrr.3
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umGUSPze9qqPzDvD9L4oLzTUvVHVp9yRW78A1JJ1ew4=;
        b=LAAiBSWxJyx+9owQoIiFfgWEf/Gu2v/U83OXU4jSXFV9TitEbfnqGJPRS/FsOzawP3
         HSCu7JNndej7t0nCyM7Rmo4WaHM3W4WWN2F8HHlJjg4IK80sRAn8K+01RuT5lnR8CRDC
         +ZY5qA+N22WlxUTZSOkfk7X6ar+2spq1xBUco12zNdefjbEdpmHWott8BA6wl+phdjuB
         mNAljYclA9MreKoeBWoErFWBqM+hysNr4mbnsjowyRDqY6vMiHQTT6bw81bgTRdy2XSB
         ZnSLFMc4R8Qdl0N2lyZzV9mMxpuWMGCvggPvnGcx3RXFgIpSt0M91xTOcwE11nHmMXu/
         U0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umGUSPze9qqPzDvD9L4oLzTUvVHVp9yRW78A1JJ1ew4=;
        b=eA1OL1wSgb6ZBpNNX9BRYcep4+HSQlQc4jENhYas6nA5CZjNCMgSCn5y8Zj9SeoQPz
         D++j2zumelJJ1oJtg0aPS8AHjjbCdEgevNGTxMka9mvHqYklZ11JF6hBnUrTxI2lLYK7
         UYffRlyYMCFnkI2aBwy1m70K8orAwD7IzPsbOWgW26SLBP3xIWpot1b8UI/1l5q9A8o1
         PWGN9BIrqGRdISnFRzLMC1ApKYC2GHuGjMuSdA6FuMNoVoT/x8aiMeIOOfWGvm8Ofbz7
         541eUi6aM0UBTPlzjzXlmwUli2WKvGI4VEXjJjHuW2nwXQxdNgrifpLQKjl0bGTHIkqW
         wRCA==
X-Gm-Message-State: ACrzQf358L71WUGtSO/ZNqeWcf21WKMSTlbQpkokwabyZMlEua+FGMoB
        h37A/70ZpEQ5rGjpLI19UvI84ZR7cT2EDQ==
X-Google-Smtp-Source: AMsMyM4KOxpu80M5LokiQ5yT0ixz5FM/sWsmY5S5xMuJQxtUR6M5jeSwSEDCZdN+PXnRwAWh+3YL+g==
X-Received: by 2002:a05:6000:1843:b0:22e:77b0:2e5 with SMTP id c3-20020a056000184300b0022e77b002e5mr381495wri.215.1665675587353;
        Thu, 13 Oct 2022 08:39:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/34] stash doc SYNOPSIS & -h: correct padding around "[]()"
Date:   Thu, 13 Oct 2022 17:39:07 +0200
Message-Id: <patch-v5-13.34-83d53381165-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

