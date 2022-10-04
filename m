Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1935C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiJDN0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJDNYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E1558E0
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u10so21190605wrq.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI0GL1I8bjM0L0NqUSqLYYoGd8fyMu9aucIW12tryos=;
        b=ILqhukJpBIbmhaF9CQ7m3VxaNFe+iI2pAFrbXAoYCdPp0koPzyZsxIzHTEove2dW0w
         epMZNwjzyyQNC/K9Z9ZWGlCbKypHpZJ+8a/qb8YvgNOywjb7FtVg1KF5b7/8nVS6mE6h
         mHq6w2ENz+ReQoBaC65/pspNm2P2tY29irdk2HD0klpWTCxbTZ7cWXl49k1eM2si/JyT
         1yxIWRaNH22eja6JCmDMgLovsp8bKBtd9WiIg7wMTFyg1GIGidR6hgt943eYymrmFo8r
         9wLMYI9QmPee+2C643iGiz+MueHn6dTDLiS/VQ5r9qCNvbmdmcNy/O8zEh+sWGhVeeZ9
         zVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI0GL1I8bjM0L0NqUSqLYYoGd8fyMu9aucIW12tryos=;
        b=Vbu0qaaTbUE4aSqEJFU6BLjtDiqWlyjEWe8DoeifB4k/vAiGuyV5akB2IH0D3I15Hp
         FSxqHdu3yK2kRbmfsGveDvR4kgZQ1c6CptM8Lmo5+l5gUybpKoS97tIPIVWib5ggGSPS
         gbdY2DBLP9lWTBWlX4MOqwGA2tngxI9bAiy6IomNn1ILQBL5Ey62d3tYrmd/Eg4EuIwl
         fKJgtqnSW6bnX9nDkPZnCPa9731/gZNw8PNxe7kq481LgVTw9+WYwTBO21I5suScHB3n
         vLb/I4kDp+s3aEMCeik2G4nMUGX3AgLhJXeeE/LUyc2yo0W82GGDzg3gDaWrteilyDsL
         OOtA==
X-Gm-Message-State: ACrzQf1+aru0gY1OS6aYY3v3LGY0SBlK/gfrwwcNGy/WEW/Y2oZxW06a
        Rm/6xgHflUCcwVPbHsXceoqhBBD/DDBedg==
X-Google-Smtp-Source: AMsMyM6lAQQlNCPO80qLHvjob4bEOPzxNW7b20MoVTDKTf4SuPfRGDQh72+M/avIWWZjqMePJJw9kw==
X-Received: by 2002:adf:ef4f:0:b0:22d:d3ae:18df with SMTP id c15-20020adfef4f000000b0022dd3ae18dfmr11802394wrp.141.1664889863070;
        Tue, 04 Oct 2022 06:24:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:22 -0700 (PDT)
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
Subject: [PATCH v4 25/34] doc txt & -h consistency: make "stash" consistent
Date:   Tue,  4 Oct 2022 15:23:39 +0200
Message-Id: <patch-v4-25.34-acd6e1f2632-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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

