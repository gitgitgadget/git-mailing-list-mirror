Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3F3C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiI3SJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiI3SIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7021E5579
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so2634792wrr.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8AFcCBHhUJYsfjEDK50sIGNjw9UoStgal+Zl/DaOTtM=;
        b=gtGL6NzNOnHNlmKCTXbOOZx/4WzPu0nKo5zoFt73adSQ/4dWcEQnkTI/bvBSN/gKEq
         Q0tBNCYdwbgx0aww8I9dXEXAWg7AK5sc4ci+mJa/TuJdwbUMkOThj9wOsfrVchKWzWKq
         zrQZyrOQ1McPtsYGSE440SVqtbLcTABVxk8bX7OsNLNJdZ9yaB+dcSBNolu1Mub7VP5j
         r2IMy+fzLmgpT4PweGOazpeZAR9/WUURGaiuJqyiefzs0OSVsbeXB9vU6wrTjbaMiH+A
         xI4BcDA/YETascyJerrlbhVyGbBqbJOz4H0egpDYIi9BE5K9+2Za1GqNgYVkoLtoQ5+P
         XAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8AFcCBHhUJYsfjEDK50sIGNjw9UoStgal+Zl/DaOTtM=;
        b=nvwiPqx/dUdhYsKhCjTVarig+uO/V8efF15T2RcmQWTPF213ozAKgjZA29CS/hZnBk
         V+Nr1JJpNJQkvhkX1HoYVHqvV42eVRdjsJr2j4AZJEY3m33sHWIQqIyuwpEtiTFIPzrN
         Np0sMrvxYIco7PX+GTb/ZgxkKQUnV3AyCufv9rajBUzzY6sggC/ZFRi72IHvimvoDxPP
         fAdrh7XmCQxIlhbyR/6KcLWZEjd7B7DrTWf/2AoaOKwXz3BGapcJ9oUquNgr0KqhRZQk
         7avRfw8ZgvRREtAI3uDufDuqgA+74SgtKrwLaqGPm3WYd1FOedZXoVyTkGHcC3IwLhpY
         wIbA==
X-Gm-Message-State: ACrzQf220ISeEIGascxZtArRf/bKu0uT5T4XzJGS8pUChSpUMV89lzcY
        bKkCVuvUO3TMShjA6NtDYE4OqLqmseptXA==
X-Google-Smtp-Source: AMsMyM4JAjoFoojMdEjeBrlZ9e9vucqaqXi6cBGHiB5NAWPDt6xyEiyQGCCKzVGYbGJKfpzIQAqTyw==
X-Received: by 2002:a5d:6da1:0:b0:22b:773:a99b with SMTP id u1-20020a5d6da1000000b0022b0773a99bmr6406603wrs.600.1664561312964;
        Fri, 30 Sep 2022 11:08:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:30 -0700 (PDT)
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
Subject: [PATCH v3 07/36] doc SYNOPSIS & -h: fix incorrect alternates syntax
Date:   Fri, 30 Sep 2022 20:07:30 +0200
Message-Id: <patch-v3-07.36-829bdf58499-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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
2.38.0.rc2.935.g6b421ae1592

