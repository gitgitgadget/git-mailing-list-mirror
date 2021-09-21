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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07879C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34056109E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhIUNcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhIUNb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:31:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA44C061757
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t7so5960626wrw.13
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXFFp/4BRhJsSl2lPH0LGRPfODuF4czq9vf4Mlu0+B8=;
        b=I9kmO7LtfjzQkOvvn6DzGWqh3ol78YhXTYzLTfHN6QB1INDrrRYd61JQkT9+qyOmkD
         uFexp1fqrpCJTbmbw07XphpNFN5C9YITRcyxaVC08IiQxuCMzuplYfsq6EUtueb8LH4Q
         5rDFq1ouejb62ptkngexETExryK2t+SBDhkUNFBq6QjyURF9/4g+XO2xkw5C6mbzz1P2
         5jWce7tO5mRge1GFpQlmNjX9ij1xu0Ymn+4qZf7n1/VgF1B1g765Ng37yM7PzuI9tS+H
         D3zkHhkk41dmDJBj3vSyUDFlnMLxWlkblbVebMphyEbRR/pMoSmZxuR5CiBc0AnvVANG
         QBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXFFp/4BRhJsSl2lPH0LGRPfODuF4czq9vf4Mlu0+B8=;
        b=uJ4+Xyh9/aC7A3SX5FoXBkRMMErpToLuYCTW2+02EfHqWWjTVeLTFq122OGxXeniEJ
         eeVG6ZQA82xJH/fdoEIkhYU3uXm5jb4p1s8qyIIU2jTFQdr6QPLT5WugTsO/y4PNlSXX
         ToEqddh1XM7p8du3WjjzI9ZMNAI3e4GGZe/UKXBd4lBnofSUGAMN0H83+d4jxQFAaI4V
         LyeSwwpM9YPkR+x7P8jQPC0m5ff4+JAv1WMSmfLQxzwNqBW7w6IDBhb1ujPLvzQta0Yu
         bwRONSHNi8OZqNpiQL1vnd9VYu+JXXGxlPy0U+r+wybmvouGSd/HzHQdXuYzUYqL0ww+
         dRlg==
X-Gm-Message-State: AOAM532jutKSZ6X8JwudaMxkcCXClgDmGBbSgdZE1pMyBx+5UrZKb4N9
        ptVQpyOMt1zydxZ/5rtB3YRJve0lDUU8Jg==
X-Google-Smtp-Source: ABdhPJyvYHFxVq6IRDu5Ha4yBjPqlmoZfbIKcRrgIelNXUsuMtCvmDVMGggwros/B6umH/TvvaazGA==
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr34752215wrx.413.1632231017607;
        Tue, 21 Sep 2021 06:30:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 135sm2926891wma.32.2021.09.21.06.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:30:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/4] parse-options API users: align usage output in C-strings
Date:   Tue, 21 Sep 2021 15:30:08 +0200
Message-Id: <patch-v5-1.4-352662be92d-20210921T132350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com>
References: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com> <cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for having continued usage lines properly aligned in
"git <cmd> -h" output, let's have the "[" on the second such lines
align with the "[" on the first line.

In some cases this makes the output worse, because e.g. the "git
ls-remote -h" output had been aligned to account for the extra
whitespace that the usage_with_options_internal() function in
parse-options.c would add.

In other cases such as builtin/stash.c (not changed here), we were
aligned in the C strings, but since that didn't account for the extra
padding in usage_with_options_internal() it would come out looking
misaligned, e.g. code like this:

	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"

Would emit:

   or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
          [-u|--include-untracked] [-a|--all] [-m|--message <message>]

Let's change all the usage arrays which use such continued usage
output via "\n"-embedding to be like builtin/stash.c.

This makes the output worse temporarily, but in a subsequent change
I'll improve the usage_with_options_internal() to take this into
account, at which point all of the strings being changed here will
emit prettier output.

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
2.33.0.1098.gf02a64c1a2d

