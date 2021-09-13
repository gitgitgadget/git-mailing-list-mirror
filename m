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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6B8C43217
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1248F60EE7
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbhIMAOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 20:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbhIMAOw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 20:14:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4806C06175F
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:13:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso5366036wmc.1
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skwc322iqDIkfDWQITxKXoa67aztJl0DbiABHabtZIc=;
        b=SSL9TlyOO//xHr5gwIPCvC245qIW6Estiv5CcnTAefS4WCCMwOhO5HR5mPsTVg3qZT
         QfYZUZhnD09jYzbr6+HEDb7CMLH/Y0AIRi5FGpZE3sxnGM+p+6YRn2Xr+wbcBAsvskrg
         l5g3ctXCN49ypaiaQhC+3bI6LlU271Z8ZiC0hxcj1SzLMMBsEu3CikmlfdzAlYXa/Uda
         hRVd8EyxicgMFhtonYt6gUMp7HQtVmMpXjArlF/qWj5szmYLUWuJZx6AW5XkHTVzUQek
         Uf2UIEqklLBErud0o7C8aMpGKDYO4JaOEC0vDnLOWyBpNSBvnYrwTO7bAlW5Po6yAUjw
         nhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skwc322iqDIkfDWQITxKXoa67aztJl0DbiABHabtZIc=;
        b=OAtiKeFjvLTHnS5HSeI4KXwlfwjc7hexwoLzeAt2NDeszpV3D4lPX81anFSy88wJhe
         MFC5WvYOJgna1zIUz1oRxzAMNJO7OVsMKAFV2wVT57CEIiqQ3zAxf4mFqpLpDYR1u3bC
         v0l5Rzt/NYfiJxQUAmoF6HxzSeCDx0Do0YsHnrkxuSGR9xK6PJkQvy1DsyJYXg1z9JvJ
         GZAcNOM2/J7kzmLqUnUNWpndcn0ccUDWsy9R75KbcZP90g/LsAa6GaPdQyaJSxHJuXzy
         wo6l4qQAatk0ZhT3WD5+Q5ays87GWxkK4pXdhjXRVuPvR/vZ3Ol9ipDohZIByErTeK/a
         b9uQ==
X-Gm-Message-State: AOAM533+n2xwQk1oOkcU7nuQ9+D+2ROakJXq0SDuveraNCvRdt/I+AV6
        3kUzW/prXRGRMzomPgKqYQsKgO6BxvOyhg==
X-Google-Smtp-Source: ABdhPJwBrWOLhnXKNnjv2g1ZRxOoHW/yAN6cDIQNy0+zi2ddlXa2g63btGQUEHafchjaTj+VVM4T5w==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr8614985wmk.135.1631492015897;
        Sun, 12 Sep 2021 17:13:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j14sm5827974wrp.21.2021.09.12.17.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 17:13:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/4] parse-options API users: align usage output in C-strings
Date:   Mon, 13 Sep 2021 02:13:19 +0200
Message-Id: <patch-v4-1.4-64d8647340d-20210912T235347Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1001.g3ab2ac1eaae
In-Reply-To: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
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
2.33.0.1001.g3ab2ac1eaae

