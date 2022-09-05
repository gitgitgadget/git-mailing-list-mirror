Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03520C6FA86
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiIEI2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbiIEI2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:28:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793763F317
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so5227080wmb.4
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qiVImiwPKnZfi/KpRgN1xI0YhU6/aGP/7L7/151rDOg=;
        b=a2efW2NXuBfTYZnr6tiJR1lJ60DClZ49swsC0meBd72+oKXmQXLAa65lApjNdNR+g7
         I7tnVDLZtYb/q/oz49cYPv9bd4wT1GT+VEebvJYu8Yq+Yj5qgyaYQpgZCpFQxq2fwfEj
         QFNIq4X5NzhvfXExdfdpLwIL8u2TSLDie/3bmNML7KxFdtNeh8FHBz7CkkJF0VO3uewM
         h2mjqifXfHOs39aVo6V318gwA1KN6KTp9CAAmle65M8vkUFYCyz1aDm2pkuc1eZJ80R9
         QGhOtXkSw8sapbuxoX1n9u37exAqrCeHb8KxV0xczmVO87x0ZJAXnK0x9XBWaJ/7q7qw
         OKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qiVImiwPKnZfi/KpRgN1xI0YhU6/aGP/7L7/151rDOg=;
        b=TobHjjw5ic51+2g9f3ubKpZ65eOuBiwpkWs9kemt12FKtHi8llWamAAX/3XkCKMzyK
         erZHH7B0BokTOyKfMhwW2KN1+HwR2HLXZrHqRzSYS5dpD6IMIwcDcwapKrv35Xia33D2
         x4bIUocKE0LmYtCkrkw3UcdBCqyBhCBSjaK7bPhHxhC/OjQSVSpyIiDi5Gfi3lpH69yJ
         FdHQ5Z8fZCMw3h4vnEaiVJ6Ypfb5R1mnCRgn/P6Aqap8M2iQf3c/6iSSdcVEEHGO+zsA
         ju8WrsFsgUDA0Ovq66IpmH8Qzpweyxzqgot3NZXqJUrgKTT46v8rjxVy7SniAtHHinuO
         wszQ==
X-Gm-Message-State: ACgBeo0E55YkEdSCZFgJ7cQTLWhG5xnRlw2uQfsWAOgjXFCJmYze7s09
        rQ3J9p35y3lyZ8smXnsjKX+YFgOkoTuiJg==
X-Google-Smtp-Source: AA6agR49NEjKkxurvzpJ0dZ1fTZ7VLoNDj+D/SwvvPyPcpuxWuXBguo8fEbILOXtm5en/A5ZI6UANg==
X-Received: by 2002:a05:600c:2e48:b0:3a5:b600:1a3b with SMTP id q8-20020a05600c2e4800b003a5b6001a3bmr9637669wmf.180.1662366437128;
        Mon, 05 Sep 2022 01:27:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:16 -0700 (PDT)
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
Subject: [PATCH 26/34] doc txt & -h consistency: make "stash" consistent
Date:   Mon,  5 Sep 2022 10:26:37 +0200
Message-Id: <patch-26.34-3907f349948-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
index 379bea645db..c350a3b8dac 100644
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
index 614bb0dd4a2..5408832efb4 100644
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
2.37.3.1425.g73df845bcb2

