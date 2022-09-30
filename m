Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD7C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiI3SJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiI3SJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:09:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0D1E5559
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f11so5350972wrm.6
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5CHvxH0qZuEdSUBG4ySRLzQc8EiPn10JbIU/YFpUGd8=;
        b=OR4HMoYHH3cjCSYkIUZd7+jun9s4x1O8KC5575e/qT74zZp5a6ZaSTENihvyRL009k
         4MaO95wnVfxBFU3S1+jakZf19Ufy7LhMQhpec7zhNF/fTYGdJQ0oQ5Rd5wAregNJMgEf
         gQIXi/yr7EdsKCVX3FnIV3+V6ICERtEyZx/H57v63WSNFmH43mIuseQHhjRtEHNHMaix
         xhi2N6Z1h7szrx/Ju04Z4ai9fvZdr/44ARHpiOn8YVbLO1o2hpshmrxcUPiJHvx+eu+c
         BiFY/KL+tUQdsmDZMhlUfDBG6hLvZP4nHm4NVNCGEtw0HYDa3ozjyiX3rvsztJpD/HDs
         8xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5CHvxH0qZuEdSUBG4ySRLzQc8EiPn10JbIU/YFpUGd8=;
        b=qxoyP1xq1Qp2IlvIDr2G7nqIATMGubESJV4vEXAQdeqFcUOAGHkFEkTeQJ1n2kDiZF
         H8b5/GoxDwx7SVeWwr+uRbc9Xfj5FjjMoPU68yEc8u5QRb+itltFUDWZw9Id3Ih65sRM
         pGdK27onussemACSgmmRtNf1/Rq3wQjsbgPJ6RggtuEMeJIDFVm8KsrRCq7OLwnCQ0Ti
         yVM6vLcsz3eLmzwx1L5MwuqLqTEEs+1o14zvjQgL4jj8iIRK+4FVF35bo465AzRngyXC
         oQbqdM3NIT6QjD69br5kRUF7hrivm2Em3Wd4YTQZMbQCzu4rK6tIl5El1KImYjLm+PZD
         5b2w==
X-Gm-Message-State: ACrzQf36gD/k8XxvK76qY2TtOt8mnhPqzgnKbFzqrKJTg8MC9xJH8n0y
        LaYOjU4IDL1VK5C0KqgZLmRM6jhsPX9LWA==
X-Google-Smtp-Source: AMsMyM6TEGUl5FZP00SuZ/dNH/OEqABHKP8dlngTIIdfRO16jKCriG9vxtSfJcPlSwwHsvbu8s5V4Q==
X-Received: by 2002:a5d:5089:0:b0:229:3151:2865 with SMTP id a9-20020a5d5089000000b0022931512865mr6314782wrt.81.1664561335058;
        Fri, 30 Sep 2022 11:08:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:54 -0700 (PDT)
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
Subject: [PATCH v3 15/36] stash doc SYNOPSIS & -h: correct padding around "[]()"
Date:   Fri, 30 Sep 2022 20:07:38 +0200
Message-Id: <patch-v3-15.36-589705cf6fa-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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

