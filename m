Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEF1C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiI3SLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiI3SK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:10:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F91F2D7
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso4970188wmc.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bI0GL1I8bjM0L0NqUSqLYYoGd8fyMu9aucIW12tryos=;
        b=o2bqRHUi1GHAgDQ/FlIh3+WFwA87z6p8IoLNZYR1wViPy4TqdSUbMIzUgSXLOzjvp+
         Yj6FPyczBLAtTyZCK3wscuEBH1Q/jSZPLme3qTceKCpUoEBVRWmjYJ+Ogi826Cg2M5pv
         dQWyrRQkW3t3oFtvwhnusdy37Gc3iM5FUAhMmTFzMx+1Htg4RGyO8OVcZylZNfUJMzig
         Jvfri1nXQuVqGcAbp5MPixfs2XxXnNH6+beKEu39ftXgKiC00sIuIwVeWLMzR3rlBqEK
         HvVtofx/AD86athh+25FhdhKJnYaFWTtAtPS5WJj5pp8MhjWiFHogQc1dzOyKYiJrLgu
         DF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bI0GL1I8bjM0L0NqUSqLYYoGd8fyMu9aucIW12tryos=;
        b=JsDXk0O7ye+D2iomjybrWKCk6qqO3Pds0RatpWumut5EFlpZxoaOwfWigHpM28+iHj
         KVUswvGx9ipRxYErIk2MY1r1dFUqNMqs96pfBuMshcjZYQxJCcJ++QmGjSrEWT9cMVyX
         WiSD7PCSbHP6qoaT7e2LQeH3Emd9fmEBU1M8D5GSBbqs8kR2OE4xODZUr/QX0swGSYHV
         QvUKoRWX0nioRb/7i/LA90RxGrtTkMZM90+X3kjj+whNtteuBfcCHnMvkgN0LHxsfxLg
         B9Z954iVioQHe2BFgmGKXgztjIiXmvtm88CWLZMvbjIQh8vuaPnVuZSelfgfxfw9QHTx
         7QdA==
X-Gm-Message-State: ACrzQf1uJXTsjBL7lmJZp4JEto7kW0aUcWs5rTGMZfrs426SlxyR6lcV
        FCyyUsWFVtnO/ffpFgtoT6k1HUUUj9j0tA==
X-Google-Smtp-Source: AMsMyM51plkQrWZxecHvFWqF+cleeBxqpJFW4YTmZvEPSxmxbz0PUtehasvmFa5RaNIwO0sUWffD0A==
X-Received: by 2002:a05:600c:3ba0:b0:3b4:8ad0:6c with SMTP id n32-20020a05600c3ba000b003b48ad0006cmr14836397wms.186.1664561381315;
        Fri, 30 Sep 2022 11:09:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:39 -0700 (PDT)
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
Subject: [PATCH v3 27/36] doc txt & -h consistency: make "stash" consistent
Date:   Fri, 30 Sep 2022 20:07:50 +0200
Message-Id: <patch-v3-27.36-ac959d0cfc1-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend both the -h output and *.txt to match one another. In this case
the *.txt didn't list the "save" subcommand, and the "-h" was
similarly missing some commands.

Let's also convert the *.c code to use a macro definition, similar to
that used in preceding commits. This avoids duplication.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-stash.txt |  5 ++-
 builtin/stash.c             | 73 ++++++++++++++++++++++++-------------
 2 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index ea16d2eae7c..f4bb6114d91 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -11,12 +11,15 @@ SYNOPSIS
 'git stash' list [<log-options>]
 'git stash' show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
 'git stash' drop [-q | --quiet] [<stash>]
-'git stash' (pop | apply) [--index] [-q | --quiet] [<stash>]
+'git stash' pop [--index] [-q | --quiet] [<stash>]
+'git stash' apply [--index] [-q | --quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
+'git stash' save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
+	     [-u | --include-untracked] [-a | --all] [<message>]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [(-m | --message) <message>] [-q | --quiet] <commit>
diff --git a/builtin/stash.c b/builtin/stash.c
index 83c9591ea6d..bb5485b4095 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -21,72 +21,95 @@
 
 #define INCLUDE_ALL_FILES 2
 
+#define BUILTIN_STASH_LIST_USAGE \
+	N_("git stash list [<log-options>]")
+#define BUILTIN_STASH_SHOW_USAGE \
+	N_("git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]")
+#define BUILTIN_STASH_DROP_USAGE \
+	N_("git stash drop [-q | --quiet] [<stash>]")
+#define BUILTIN_STASH_POP_USAGE \
+	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
+#define BUILTIN_STASH_APPLY_USAGE \
+	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
+#define BUILTIN_STASH_BRANCH_USAGE \
+	N_("git stash branch <branchname> [<stash>]")
+#define BUILTIN_STASH_STORE_USAGE \
+	N_("git stash store [(-m | --message) <message>] [-q | --quiet] <commit>")
+#define BUILTIN_STASH_PUSH_USAGE \
+	N_("git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
+	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n" \
+	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n" \
+	   "          [--] [<pathspec>...]]")
+#define BUILTIN_STASH_SAVE_USAGE \
+	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
+	   "          [-u | --include-untracked] [-a | --all] [<message>]")
+#define BUILTIN_STASH_CREATE_USAGE \
+	N_("git stash create [<message>]")
+#define BUILTIN_STASH_CLEAR_USAGE \
+	"git stash clear"
+
 static const char * const git_stash_usage[] = {
-	N_("git stash list [<log-options>]"),
-	N_("git stash show [<options>] [<stash>]"),
-	N_("git stash drop [-q | --quiet] [<stash>]"),
-	N_("git stash (pop | apply) [--index] [-q | --quiet] [<stash>]"),
-	N_("git stash branch <branchname> [<stash>]"),
-	"git stash clear",
-	N_("git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n"
-	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n"
-	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
-	   "          [--] [<pathspec>...]]"),
-	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n"
-	   "          [-u | --include-untracked] [-a | --all] [<message>]"),
+	BUILTIN_STASH_LIST_USAGE,
+	BUILTIN_STASH_SHOW_USAGE,
+	BUILTIN_STASH_DROP_USAGE,
+	BUILTIN_STASH_POP_USAGE,
+	BUILTIN_STASH_APPLY_USAGE,
+	BUILTIN_STASH_BRANCH_USAGE,
+	BUILTIN_STASH_PUSH_USAGE,
+	BUILTIN_STASH_SAVE_USAGE,
+	BUILTIN_STASH_CLEAR_USAGE,
+	BUILTIN_STASH_CREATE_USAGE,
+	BUILTIN_STASH_STORE_USAGE,
 	NULL
 };
 
 static const char * const git_stash_list_usage[] = {
-	N_("git stash list [<options>]"),
+	BUILTIN_STASH_LIST_USAGE,
 	NULL
 };
 
 static const char * const git_stash_show_usage[] = {
-	N_("git stash show [<options>] [<stash>]"),
+	BUILTIN_STASH_SHOW_USAGE,
 	NULL
 };
 
 static const char * const git_stash_drop_usage[] = {
-	N_("git stash drop [-q | --quiet] [<stash>]"),
+	BUILTIN_STASH_DROP_USAGE,
 	NULL
 };
 
 static const char * const git_stash_pop_usage[] = {
-	N_("git stash pop [--index] [-q | --quiet] [<stash>]"),
+	BUILTIN_STASH_POP_USAGE,
 	NULL
 };
 
 static const char * const git_stash_apply_usage[] = {
-	N_("git stash apply [--index] [-q | --quiet] [<stash>]"),
+	BUILTIN_STASH_APPLY_USAGE,
 	NULL
 };
 
 static const char * const git_stash_branch_usage[] = {
-	N_("git stash branch <branchname> [<stash>]"),
+	BUILTIN_STASH_BRANCH_USAGE,
 	NULL
 };
 
 static const char * const git_stash_clear_usage[] = {
-	"git stash clear",
+	BUILTIN_STASH_CLEAR_USAGE,
 	NULL
 };
 
 static const char * const git_stash_store_usage[] = {
-	N_("git stash store [(-m | --message) <message>] [-q | --quiet] <commit>"),
+	BUILTIN_STASH_STORE_USAGE,
 	NULL
 };
 
 static const char * const git_stash_push_usage[] = {
-	N_("git stash [push [-p | --patch] [-k | --[no-]keep-index] [-q | --quiet]\n"
-	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n"
-	   "          [--] [<pathspec>...]]"),
+	BUILTIN_STASH_PUSH_USAGE,
 	NULL
 };
 
 static const char * const git_stash_save_usage[] = {
-	N_("git stash save [-p | --patch] [-k | --[no-]keep-index] [-q | --quiet]\n"
-	   "               [-u | --include-untracked] [-a | --all] [<message>]"),
+	BUILTIN_STASH_SAVE_USAGE,
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

