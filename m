Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93FEC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJDNY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiJDNYS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654F543F2
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso7523978wmq.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CHvxH0qZuEdSUBG4ySRLzQc8EiPn10JbIU/YFpUGd8=;
        b=bMDl3sG+7uDU18EIAcgo8UYDzO/ZpfdYTFDDr9tWuOLlE1HbUlaQl7anUlgawF8Huh
         ksH3ORihTTN6beRDqWKs8z9oXiYqBHDJV+3DYXN9iJ49kizHA+j6XwwsPxONWmdEzV+K
         dNz/W2KdhW6QuQIF9dwHo6wqVqleOe3kmD4UbxBGA48fhtNZe7kCJy/LIDTC6EzyuVaD
         slrrME7qPPug/wwfDq1yuSOh8gz24agjqlsQMy7AhLig5A85wQFUxxBMZuT+y/KlErnU
         itq1BXgqTtBulret5nOOEt70LHQhX3gmn4OXyu7Sdn/n4Svg9vkfy9wT45d0FRDyHFSG
         9Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CHvxH0qZuEdSUBG4ySRLzQc8EiPn10JbIU/YFpUGd8=;
        b=3tkxgt/muY6Qs6hfbt5FcHHKRClcxJlrQOH5/vw29W/GIW2GCbq7cJ6vEabK3GXYqm
         vVZRYIg3r/M4twH44/GW7HZ9LDN3sj+W5jLC/s209BcsrR2wYWfcFVH1HqTzSTykTmDq
         QpYdeLlC6jyseXlEhtheQyO07BfXhk0yY2EUiZq68PjXp4DhiQOb2NQMIC/5EXjrJAGs
         HwS+EyCvk2OEWwhCJ/Vm9aDQ0kUhHrlA9aX2KPSMWOzTk2bpaWbiByOB9RC9MK43ghCq
         sE5pa4yKVDAdHyGZC1VKwnf019/cyNRO0wJUTjuXjNQAx/RNfVYcyr53EkEyfRAiY6g+
         RXfA==
X-Gm-Message-State: ACrzQf0Bzt6XdPbbIuMle0xoKl02QO8eS91vMfvICPj087qZgaq65bMu
        9c/rhZPYWgOb3v41Xyqi1FAaNE3VwaplIQ==
X-Google-Smtp-Source: AMsMyM5/tXOGCOvyW2JddhWyIR6BVssCxErKO/ed60XBmrRVld0R+++r/QrHMrmSvfrJpq9btMy0YA==
X-Received: by 2002:a05:600c:216:b0:3b4:874c:61e6 with SMTP id 22-20020a05600c021600b003b4874c61e6mr10514478wmi.116.1664889847573;
        Tue, 04 Oct 2022 06:24:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:06 -0700 (PDT)
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
Subject: [PATCH v4 13/34] stash doc SYNOPSIS & -h: correct padding around "[]()"
Date:   Tue,  4 Oct 2022 15:23:27 +0200
Message-Id: <patch-v4-13.34-b568189532f-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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
2.38.0.rc2.935.g6b421ae1592

