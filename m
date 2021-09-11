Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899DEC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F38B6108B
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhIKTLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhIKTLo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 15:11:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF13AC061756
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so2789801wrq.4
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ChLf81W3t4HKCng/soE8BIA499OOBLGo1cM4oJfuMyI=;
        b=jxFoSSeIr1Ftkt5jYEAIuH9NA/QUl6OeysBqT63MnKifdGwtBEpi2gqDi+1+vhj5mp
         DqQL0vJdW8vDR/NVscVwa1VYp9BbBIkLvnC6hqlJtg9Ae3xoj6N2s1388qUIvltnV0dL
         79Nj8LpZLHEWS2uhU9rIc9GaCl6OuvLiM0d4L3dfDScHPgGVZHUcA+mG6LgTrPymw/BS
         yzizOvpuJBdezFMJwNTee36AT94FocBr2tg07Mtc9ExsCDOXEj2xw2NvAmZ/U373iqgP
         YKdEyuIDVePnb6GXre+d4nXYTgY5youGRWLkZHIXFfpjqL9roZ6CLJfShuQK2r3IFulT
         Qshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ChLf81W3t4HKCng/soE8BIA499OOBLGo1cM4oJfuMyI=;
        b=6UC/n+xyDB+M6Nb6HPJUMGFwZlYx6JaTD5oAU1i1Gk0C4FfbfZaq0uMuLXGBSNnf6t
         4KRIa4ATYyCAXI2wELBy8EtT5NoL3KeeWPRYi75rVuXbMDlCXBwDgIauX+2PgesDV3sQ
         llKPIv2B0wIw3iUPOx01ItTX+iFfm2Zzhae5RJt0oL9piH/bGUzpyvmjLGASqIq9RH0s
         6/mjrGyinK3II+il5u8SpZLrqeHXAwJrcSWuVMGFhF89R9RdsuJy4sErTlmNDXFNe0Qk
         55CPBWXwEJQAnNFQMDUUCU+ACtIhepvmakf7oqu3jQ1EebxdH5dciHVjavz045F14F18
         LfbA==
X-Gm-Message-State: AOAM533P3C4XIYthDdDmD2ICbJQUqvmYdIyeKgsa5gYF/g9G1eKV/grd
        GMMEBZv/9byNZ+AmUH0GN7IzwSKbSPT3jA==
X-Google-Smtp-Source: ABdhPJzO3p3geQmPy7qHoc8HR9gR2WGpUQypxGU++AOeGs0XUUDWIvaKjdY3LcROGK4stQFOB7+n1Q==
X-Received: by 2002:adf:f884:: with SMTP id u4mr4104529wrp.411.1631387429207;
        Sat, 11 Sep 2021 12:10:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm2256822wmk.2.2021.09.11.12.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 12:10:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/6] built-ins: "properly" align continued usage output
Date:   Sat, 11 Sep 2021 21:09:03 +0200
Message-Id: <patch-v3-4.6-5638d2bc832-20210911T190239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's "fix" various "git <cmd> -h" output by "properly" aligning the
output in cases where we continue usage output after a "\n". The "fix"
and "properly" scare quotes are because this actually makes things
worse in some cases, because e.g. in the case of "git tag -h" the
"\t\t" effectively works around how parse-options.c aligns this
output.

But two wrongs don't make a right, let's "fix" this by making it worse
temporarily, in anticipation of improving parse-options.c to handle
this alignment.

The issue is that we should have whitespace corresponding to the
length of the command name here, e.g. in the case of "git ls-remote"
it should be 14 characters, or the length of ""git ls-remote
". Instead we had 21 characters in builtin/ls-remote.c, those extra 7
characters are the length of "usage: " (and also " or:"). So in the C
locale the resulting output aligns nicely:

    $ git ls-remote -h
    usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]
                         [-q | --quiet] [--exit-code] [--get-url]
                         [--symref] [<repository> [<refs>...]]

But that's fragile, we might not be under the C locale. We really
should have parse-options.c itself add this padding. In a subsequent
commit I'll make it do that.

In the case of "tag" and "show-branch" and "stash save" the output was
not properly aligned, although in the "git tag" case it was
near-enough (aligned with the "-" in "git tag -l") to look good,
assuming C locale & a tab-width of 8. In any case, let's align this in
a way that looks obviously correct when looking at the source itself,
and then improve parse-options.c itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-remote.c   | 4 ++--
 builtin/show-branch.c | 6 +++---
 builtin/stash.c       | 2 +-
 builtin/tag.c         | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index f4fd823af83..318949c3d75 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -7,8 +7,8 @@
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
-	   "                     [-q | --quiet] [--exit-code] [--get-url]\n"
-	   "                     [--symref] [<repository> [<refs>...]]"),
+	   "              [-q | --quiet] [--exit-code] [--get-url]\n"
+	   "              [--symref] [<repository> [<refs>...]]"),
 	NULL
 };
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index bea4bbf4680..082449293b5 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -11,9 +11,9 @@
 
 static const char* show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
-       "		[--current] [--color[=<when>] | --no-color] [--sparse]\n"
-       "		[--more=<n> | --list | --independent | --merge-base]\n"
-       "		[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
+       "                [--current] [--color[=<when>] | --no-color] [--sparse]\n"
+       "                [--more=<n> | --list | --independent | --merge-base]\n"
+       "                [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
     N_("git show-branch (-g | --reflog)[=<n>[,<base>]] [--list] [<ref>]"),
     NULL
 };
diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..45b19007d7c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -85,7 +85,7 @@ static const char * const git_stash_push_usage[] = {
 
 static const char * const git_stash_save_usage[] = {
 	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
+	   "               [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 065b6bf093e..6535ed27ee9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,10 +23,10 @@
 
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
-		"\t\t<tagname> [<head>]"),
+	   "        <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
-		"\t\t[--format=<format>] [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
+	   "        [--format=<format>] [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
 	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
 };
-- 
2.33.0.995.ga5ea46173a2

