Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFDAC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJMPlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJMPk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CFF237DD
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a3so3543152wrt.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an4xqb64q9wsVnMv+gkqxUSxAR1Ky4egAkJfoGNwei0=;
        b=i5BiGzxVDUsavD+CP5zNITmihB9Qcncu31GAAppIiBPLoKFdOr3gd1B/fkL3bvHeoH
         KP3MpP8ImAKg4KaNm3wDOxTZLk41zIXzCWLV8FL89zsK61IsEJWaHC+BLg8Xu0ZMJlEF
         UajenKZ/YQIR5VpY02ky4WlqoZxbCm/Nr+8SpssPQKCsI2xzcS3hdzybszP2lNHdY6cT
         t/SjQyYpJkb/LD0rWlUDZZIkEMoaf7cmsF9QH3aZoyUs/I21kglxtWRApYtUfez3Yxym
         1GRPkt082CD535Vi1/K55hcvrvJ8VV3mR55J3Sna9roLpj9S4ahimPLi8OwxAF71jvqI
         Aibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an4xqb64q9wsVnMv+gkqxUSxAR1Ky4egAkJfoGNwei0=;
        b=NTCQFC5LufAXw4aFDYUwN1zKyz6sW7OdFIdMLG4NK4pwMDxhBhW3+XMNm7h7RFNzyy
         C/K+YwUnltuUuC9Q7Kttx6s5GUVgc7g984A3P8dElIGwHyEnj/UvHM4jJOcDG/KwjI73
         vx0rMsnIDii0b4VLRfHb610A30jhY+drraiRpKKvttkDNClxVT9ICtKtRb5jrI9aGF7g
         g5JwUaA7mbas4sEhFJ8R0AI2Cdzn4HxXAXkavNdeM0JQZRgBTkKXYQRhFiYweaIyB6Ay
         ZSe5G877NuWm1X4HW9vpFb1NZ70I/Oa3vJx5iXUZ8dLtDDG6+v51txekWOyjhErn7Kj4
         xR/A==
X-Gm-Message-State: ACrzQf0pIdmTdYaWk0v3X9sAtyA1ciE9O6BTep1MjqTws8jMx78DSxsH
        Sa/d+lUHxihO7QGLPtBXs5TBI7hHNVvDQw==
X-Google-Smtp-Source: AMsMyM7pkLlO1sFD7yNVRFVYKc+SCFEp6nvK5gDld0zFwVfi/1cA4IQpJWl2Y8LwXoAm/LlwMuwaiQ==
X-Received: by 2002:a05:6000:1843:b0:22e:77b0:2e5 with SMTP id c3-20020a056000184300b0022e77b002e5mr382110wri.215.1665675601168;
        Thu, 13 Oct 2022 08:40:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:40:00 -0700 (PDT)
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
Subject: [PATCH v5 25/34] doc txt & -h consistency: make "stash" consistent
Date:   Thu, 13 Oct 2022 17:39:19 +0200
Message-Id: <patch-v5-25.34-89ad801409d-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

