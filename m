Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C856C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiI1IkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiI1Ijr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CBD3C8F8
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so6626471wrw.9
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=q/3U2PD5WKtKpuBIywAli+A65RuyT1WCNkczvOjAbYk=;
        b=dpCUG52dvjJSCzfDn1teZ0nFkqgBnRt70kXgd9PuG1qmkrD5INBvRzSlBcC+YqEbSV
         jU7B8j0rE7oDQvhMX/GKA3RKl/TyTOzgUcFujbFGtw0QmFMTfvOJCUPj6z1SxNJWGv3R
         qiRN3PtzH6+1VRCWyZ+0SWztJB+a/wST0/ie0s1yZy6LeUvd81enMcTdp5elXFoEBjyu
         zdt0ibeTlPuOgvDCnvytThwfqIMNmt8rCwaRN5p6UB8tpOsm0vxjeRZ54zkbiQ4DkTOa
         hKJdcrzaUFlwo7FV5+YYJSUZcd4vV9e+TjwY6CRqWYKtljjJLtOQi0HWKRp8E4yNmAjY
         YxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q/3U2PD5WKtKpuBIywAli+A65RuyT1WCNkczvOjAbYk=;
        b=NTWtrrbwyQzzEJCAzKISbfjOxUvuu9wW4V4sufO/843QR+ceWRcwtKAmcOqauUGq0S
         nsIeTilpg4RST1g16yVf80gQPfRHjdGIne0BTbXjC6TEdRuwwEkOvuwqoHWpxWy5FX0o
         q+0lvrJyRNUUZFRXweAlohFbyEpBAS3vLGStrIFJOlmUTNvOtXzomqul0BfVKzPtFo3Y
         /gqW2O5YV+qUwvNJ9dZfvMwKWIy2E2G4tEeAjEu7vcRw6h3GkQvifwB3YEQb+AimmJLc
         SMrQNLJuUEJ2qu6ifVaZE51ZPqdE7ekWbFyFcuMeHVtY5i3oUA516n248E6l/tZGR/Y5
         8K9w==
X-Gm-Message-State: ACrzQf3kfo1FlosljHUVUoEYhqzHY/FZcUbrrmfiZqw00b5xKBNCBFsp
        yJPtAzIw5MIIPj6peSZTfXI94c7ktN6wRA==
X-Google-Smtp-Source: AMsMyM61o4p/XMoJr3lLDW5k/Rn6U4ebi4s+cZMp1Q9Ktrl3BxBdzzq5Cc6+m5fPzq/Lx5our2IbjQ==
X-Received: by 2002:a05:6000:15c7:b0:22a:f70b:490 with SMTP id y7-20020a05600015c700b0022af70b0490mr18996603wry.489.1664354383207;
        Wed, 28 Sep 2022 01:39:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:42 -0700 (PDT)
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
Subject: [PATCH v2 07/35] doc SYNOPSIS & -h: fix incorrect alternates syntax
Date:   Wed, 28 Sep 2022 10:39:02 +0200
Message-Id: <patch-v2-07.35-3531d531a3f-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the incorrect "[-o | --option <argument>]" syntax, which should be
"[(-o | --option) <argument>]", we were previously claiming that only
the long option accepted the "<argument>", which isn't what we meant.

This issue has been with us in both the "-h" and *.txt versions since
bd514cada4b (stash: introduce 'git stash store', 2013-06-15).

There are also issues with the alternates syntax for "bugreport" and
"diagnose", but in those cases only for one of *.c or *.txt, not
both. Those issues will be fixed in a subsequent "consistency" commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-stash.txt | 6 +++---
 builtin/stash.c             | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index c5d70918283..4856f452511 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,12 +14,12 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
+	     [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
 'git stash' clear
 'git stash' create [<message>]
-'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
+'git stash' store [(-m|--message) <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
 -----------
@@ -47,7 +47,7 @@ stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 COMMANDS
 --------
 
-push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
+push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [(-m|--message) <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
 	back to HEAD (in the working tree and in the index).
diff --git a/builtin/stash.c b/builtin/stash.c
index 2274aae2556..51d40efaac7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -29,7 +29,7 @@ static const char * const git_stash_usage[] = {
 	N_("git stash branch <branchname> [<stash>]"),
 	"git stash clear",
 	N_("git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]\n"
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "          [--] [<pathspec>...]]"),
 	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
@@ -73,13 +73,13 @@ static const char * const git_stash_clear_usage[] = {
 };
 
 static const char * const git_stash_store_usage[] = {
-	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),
+	N_("git stash store [(-m|--message) <message>] [-q|--quiet] <commit>"),
 	NULL
 };
 
 static const char * const git_stash_push_usage[] = {
 	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]\n"
 	   "          [--] [<pathspec>...]]"),
 	NULL
 };
-- 
2.38.0.rc1.925.gb61c5ccd7da

