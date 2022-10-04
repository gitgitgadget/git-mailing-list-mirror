Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598BAC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiJDNY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJDNYR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FE53016
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i83-20020a1c3b56000000b003bd44dc526fso783126wma.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x6oMKNUMXPpC55IkLj8XUWs4TDz+cdEsvh3hBr3Lss=;
        b=KhbYgqshILK6YbZiu8iKEKzfViswuAilqPl6uhuPhGP0cXM0SldF+nY8W+TSWlR+52
         wXo/iFqQSOSWLSV+4aFEhvApKROSE1khOd37mFTSG+u+ruSqO3WcPmbSZZ26s0blCeQJ
         qXy9zG2MxYaoe5BuyOtSKxIeeEeGdy2bV31UTJwqALKkvQ1pgxeWEYdOj8+fnmPEUebw
         UM5ztdXZWrUCEgz+XXdEFNDRyYIWY7jdBKR/s2UiKkvFb/L8do3MGS5LFjvaF8DVK7Ci
         /zpiErca19vJ8JHXKR54zIknRYKpTLyLCITEI8Nha4dxyXC8xU9caQxsunVgCJkqKJbI
         QZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x6oMKNUMXPpC55IkLj8XUWs4TDz+cdEsvh3hBr3Lss=;
        b=oChvO+fvqbwQikAV4YaqejLIkJOgtq5WyCYFiSXMj25mNCi8Noz07RP7CEd5Mt1Ewz
         Et4h5TEuS5P+sVqXUfdUUcUMGDGscmNoORh1N/Q1OWweKrZeNCvT0QV1gGoxpRui6Afk
         eAIPEil5jzdRQUcwnJQLb7yLfBqRGi0rFffGviil8taqY7qOm7wuJedIzP/KcyP094g1
         gfcWr83OvghoXZZr7xFRG4fnKeg9bjExDbmAivbMTKTIuIHut5OJEyMNfKL2QRIiH7A1
         pOTt98UrGO3itKrtLtUAmbBsvRH9VSgMtNqEgrtDCQZ8tb7sk4af9njMYMGusdN7E2rz
         rvCA==
X-Gm-Message-State: ACrzQf2EIpI7NSNzCxXi10eGP66tFCdCcr8Dymgf7tzLyr5RYApBTLag
        CpmdKM6TTfBzsvpxUK218mVHnkI7s0V7dQ==
X-Google-Smtp-Source: AMsMyM5yLmGEPj7RxfCbCa7DX8Mh24g6kP30FvxH2DEgpGQ/kTKlbzZQjWxcfixCs0JowVZwRE8C/Q==
X-Received: by 2002:a05:600c:3586:b0:3b4:c057:a366 with SMTP id p6-20020a05600c358600b003b4c057a366mr10126524wmq.170.1664889842742;
        Tue, 04 Oct 2022 06:24:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:01 -0700 (PDT)
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
Subject: [PATCH v4 09/34] doc txt & -h consistency: fix incorrect alternates syntax
Date:   Tue,  4 Oct 2022 15:23:23 +0200
Message-Id: <patch-v4-09.34-f4598ca1899-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the incorrect "[-o | --option <argument>]" syntax, which should be
"[(-o | --option) <argument>]", we were previously claiming that only
the long option accepted the "<argument>", which isn't what we meant.

This syntax issue for "bugreport" originated in
238b439d698 (bugreport: add tool to generate debugging info,
2020-04-16), and for "diagnose" in 6783fd3cef0 (builtin/diagnose.c:
create 'git diagnose' builtin, 2022-08-12), which copied and adjusted
"bugreport" documentation and code.

In the case of "Documentation/git-stash.txt" and "builtin/stash.c"
this is not a "doc txt & -h consistency" change, as we're changing
both versions, doing so here makes a subsequent change smaller.

In that case fix the incorrect "[-o | --option <argument>]" syntax,
which should be "[(-o | --option) <argument>]", we were previously
claiming that only the long option accepted the "<argument>", which
isn't what we meant.

The "stash" issue has been with us in both the "-h" and *.txt versions
since bd514cada4b (stash: introduce 'git stash store', 2013-06-15).

We could claim that this isn't a syntax issue if a "vertical bar binds
tighter than option and its argument", but such a rule would change
e.g. this "cat-file" SYNOPSIS example to mean something we don't:

	... [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]

We have various other examples where the post-image here is already
used, e.g. for "format-patch" ("-o"), "grep" ("-m"),
"submodule" ("set-branch -b") etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-stash.txt | 6 +++---
 builtin/bugreport.c         | 2 +-
 builtin/diagnose.c          | 2 +-
 builtin/stash.c             | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

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
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index faa268f3cfb..23170113cc8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]\n"
+	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
 	   "              [--diagnose[=<mode>]"),
 	NULL
 };
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 28c394a62a5..474de9ec647 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,7 +3,7 @@
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]\n"
+	N_("git diagnose [(-o|--output-directory) <path>] [(-s|--suffix) <format>]\n"
 	   "             [--mode=<mode>]"),
 	NULL
 };
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

