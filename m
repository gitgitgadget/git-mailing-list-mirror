Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB68C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiI1ImP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiI1IkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AECA0279
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r6so1328536wru.8
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=m83TnlXXyBxXPDI7Fy1dJgFrG5HidnAupDBIEY8S79Y=;
        b=pT7MPwP6bPjjnIJC7kYZOsSgPSu8uUl2sGRh+RokrAdzn/fDq3N4dUbCbHyVYkubv7
         loc0XgkLJe2mqT/v8WpdvMP+Dar6v0SG6swyAh8krBaBSSzSNnuOZSuUPLAoT4t/UDaC
         3ezDiwpa5GeFvVyM+vW6p/BeG9mY1gw5sm0pasWq+he8IBAfjKoCYcH5hjIsXqt9lEK9
         GZqIXxP+Dhoyd2IAp9c1G+gHJI85Aza+YpTdFa68j6PO8tZIC7HQur5WTlrgNULCDzVO
         /o5aH+1oGm/4QA+8pUpftt4iXeHrL7pHqAioam868vOlxv6z9Ru2YanHd6xQ54hbrylx
         pm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=m83TnlXXyBxXPDI7Fy1dJgFrG5HidnAupDBIEY8S79Y=;
        b=CXxSvsYtqdkQt8U46+FTtFPZAi+2dVDahDuiV2mbSJkZEDburx7YgIHGXpKeElZF+g
         065PJ9b1cmZraODlXPKAZkhcORU0MWIxGogmocyJQm8fG9KE/u+inAGwYRPVPyFs5L29
         bEfrpkXAoS0tz2WNqwMtWR2FH7/4h2htdYNlAcgYpxD+L/aK/YP+CaQN8S7LhSZgAZ7/
         UQFfAb/rIsbDmZoOB1pUq7yxVpelfO84PxdUnDnCU89SrgQaDyOxrsdNrdIdMt/7982O
         /TL9SEp/D42jfq/doCEyiwJpGcLHqjEq8Vs32GG/6niESExglfHqbAw6O+DL2mV0SY/E
         vYlA==
X-Gm-Message-State: ACrzQf2RBO5xmqmqletFL2u2IhqUooN5wiZnVe/G07w8c65OteU34osX
        lBTWA66neq7m0OTroeITFNM/4VLEYhkXtg==
X-Google-Smtp-Source: AMsMyM5aDhupmfJBzL7YrbCx8NZeRpn8A74+0GRulSLAhtxrr/5sAv1vdqT1xVSWJTa8kZ1peZk26w==
X-Received: by 2002:a5d:64c7:0:b0:22a:6a3f:e168 with SMTP id f7-20020a5d64c7000000b0022a6a3fe168mr19419583wri.161.1664354403856;
        Wed, 28 Sep 2022 01:40:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:02 -0700 (PDT)
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
Subject: [PATCH v2 26/35] doc txt & -h consistency: make "stash" consistent
Date:   Wed, 28 Sep 2022 10:39:21 +0200
Message-Id: <patch-v2-26.35-ac62cda1ab2-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend both the the -h output and *.txt to match one another. In this
case the *.txt didn't list the "save" subcommand, and the "-h" was
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
index 83c9591ea6d..446a0089e84 100644
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
+	BUILTIN_STASH_BRANCH_USAGE,
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
2.38.0.rc1.925.gb61c5ccd7da

