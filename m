Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4950EC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256EB61074
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhIJPkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhIJPkB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:40:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E101CC061756
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so1676599wms.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JExnSC7vwOuoaPaeNKovCm7NpBPsFCbPTGpTf/8Z7tQ=;
        b=qVOUakxojBTTrWETGRCDeCgVAs4Q4uRirBywxH6kSLG6pAY5Sp4Z3HphUgxC2w0YeX
         qeQOnqWa6WfiuSKq9TGVFs1IIbq20HC5mo/uqJumDinwOM1GaGwyxExnB/vShzVvcSu7
         97f/WAQ0qG9n801c9xZNuONn3e1m+UdYUcyE2SVv8AZgykbBgIsH4xxm8ABfvSJg/TlP
         VwkTNRBtPRZGN52i4E+RHprSeRhx9o8BUsKjqcBV0beGETDUq+YFcG6gx0nhzaS7AT42
         At3ntNj5gRuSJTtmdenDYS8btXXoyt2TpE6p5CnN4PJaEGWnAJsNW2auwkLvDljJtl7p
         6wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JExnSC7vwOuoaPaeNKovCm7NpBPsFCbPTGpTf/8Z7tQ=;
        b=rIv82CFIeRx8CqenpnYCDk6I7qlY1Q09hWt/Q8lSzR5H7z48KhYsVvKBw7+mbdwBpv
         EU2GR0C2TMpxUCWeeGGvPivnoR83OW/FrMzpgQmgIwL7EsUBGi4LygZ957+6XGtd+svA
         LnIpnrIjcPCS0T7KEJ3TCF/ZcfTzNmNmrA7odc4djmmlw8Kx1862GiU3B6hmQcZhXvp/
         m4Ao+q/bEEur+BeDZGWKR1iMa5qcejqa0FPfSd3WT8JRlfiEc6iQQix3SSzLlYBsOlGD
         c28kyfnx9awr7Mt/E2u1i0YMoEYAGW3F4EeJDuzGwvyfcoCvOAH7pwuDpO7q67fTLOqV
         TmBQ==
X-Gm-Message-State: AOAM533Cg+STTVak4GwDwuj8HUQQCZSApg5MnnnqaQiJ4QAXShr+83Bp
        ZmX65HO0Efw9C2WQPkKV/jrFJENWFoQuhw==
X-Google-Smtp-Source: ABdhPJxgv4745qgJNYTYl3r8XhNAqteyegxLWrt3/vqfeB3aNfNDYkp193HIQdzlH9S+RwEjuHPozg==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr9161388wmg.111.1631288328262;
        Fri, 10 Sep 2021 08:38:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i5sm4181972wmq.17.2021.09.10.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:38:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] built-ins: "properly" align continued usage output
Date:   Fri, 10 Sep 2021 17:38:34 +0200
Message-Id: <patch-v2-4.6-4547cc968b1-20210910T153147Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.876.g423ac861752
In-Reply-To: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
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
index d77ce7aeb38..a82cd1534fc 100644
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
2.33.0.876.g423ac861752

