Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E42ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiIEI1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiIEI1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B45193
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso6645002wma.2
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GyTXPB5OauXc/DW3rjfYm60LdGuRAxAMKkQJ0jj1E/Y=;
        b=q6D3LtD14LmBs1tPboKcDMBPPdZKNwZpjAZYTmhMCpxK5ylhDBkveFDqgwD8KeIZuF
         x4sBUgimI33ng3ABaYdzHeXpyhSXKAIhSQI7A+tgEKIF7Qkm7FqzLnssxDA++BF5k0WO
         T2++QUl9RY+IG99igwRy2gqXZtGvw8oDDiPqNWB6NmaSefpUYZaER0Myn1bjc1AcKF++
         QPeVhemQ314Tp2/0ht/rezdieoXbzqUsRc3MiIH3grpAUSOxvcRxpgMEPqb/62lsupgI
         WbF+dEvFRhWJnWYX5JkWYF2t03hBciUrUsE1EKkpijMUhWUUvtzHYEmQ7+R4Fh+E1Ale
         TVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GyTXPB5OauXc/DW3rjfYm60LdGuRAxAMKkQJ0jj1E/Y=;
        b=raJ0YAwg8sPexAWbLkK/PSHUIbfaUf8lrUaQrDWgIUx+G2HrFHrQSsro42FcDR8YfJ
         m2cLWugzWTPoQUAtcRu5iFsqpOSufsfCYdy4cKYJlB2N89URk6ErZIEh184uE4lk+RS4
         B8SOKcZa5gS9v57eSAdVbZArJrii7sfwyQhW5Yqk4dYiU4yundvvUjrvIqhAbDfxHYXo
         U6C8j2ayk2IiqZGqD9KiDJf2aT7/QuVHpSuhAhV8kNhuaIh/aKo8XQ2gXHPzJuy/plN7
         taXDmzNcQZZCJ45uzbdk/VybBMjwWz39pTbvHm/+P4nBGjn2pB6xcQbNVFtYjWZOKtd2
         U9vw==
X-Gm-Message-State: ACgBeo2SM2EHf2shuwdQkjFeOci8VvOOiJLXow0lN9EnVkZZlHPYBRZB
        Zf5trT7Ogh8Gf8l2j/hqRsBlY6eVVHPvHA==
X-Google-Smtp-Source: AA6agR7LzcOc0L9in/z2ZLSs6pmP3dqh23lCDWFzGICOAbAmS/vwTes8X2WGlaTjEmGYWTTLrp8spg==
X-Received: by 2002:a7b:c016:0:b0:3a5:fff2:62f4 with SMTP id c22-20020a7bc016000000b003a5fff262f4mr10382902wmb.104.1662366418332;
        Mon, 05 Sep 2022 01:26:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:57 -0700 (PDT)
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
Subject: [PATCH 07/34] doc SYNOPSIS & -h: fix incorrect alternates syntax
Date:   Mon,  5 Sep 2022 10:26:18 +0200
Message-Id: <patch-07.34-a070c97f29b-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the incorrect "[-o | --option <argument>]" syntax, which should be
"[(-o | --option) <argument>]", we were previously claiming that only
the long option accepted the "<argument>", which isn't what we meant.

Unlike a preceding commit where this was fixed for commands which had
inconsistent "-h" and *.txt, for "stash" it's been with us in both the
"-h" and *.txt since bd514cada4b (stash: introduce 'git stash store',
2013-06-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-stash.txt | 6 +++---
 builtin/stash.c             | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 6e15f475257..0df21321e50 100644
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
index 1ba24c11737..0fc359e9d39 100644
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
2.37.3.1425.g73df845bcb2

