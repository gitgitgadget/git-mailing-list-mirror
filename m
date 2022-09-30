Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE537C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiI3SJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiI3SIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BE31E76A0
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so2616867wmb.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yHPK0nqLEU7QiZSOVoIVqKRuwLezeTdOF9CLA7Z1lQE=;
        b=d9zSicFoi73Y8FWGpjo5EYcZd/3P4ils1QR/2qZ635YnPtxkaaRf3gX0O+bWfWaPKH
         6MqTgPh2WR0V5UMuHS8X73oBETECBzkrh3Mt3EopiDHcCWfnzyrbdqfDjqz+ngbyzDnd
         9jccxK1xYBeLIMoSqCG23bu8dPxRZwUnnpmyiHWFLs7/RPD9rRrXDOTRC1daauMuJD+t
         VStZWRi7XzcE9bz7xoQiei9aqpU08c0k1NdR1QgtQukQ5E2gqy183sX7E9d0xvGVEiZp
         1x2+mMCYRA4RqtxjeaEmJr5fKyQhYzQ4nxqsAoKj0G6NhLb8pHxr65Nqy7BZrEUSksId
         GJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yHPK0nqLEU7QiZSOVoIVqKRuwLezeTdOF9CLA7Z1lQE=;
        b=XAyNItYHRW4EgHPP5AyW7Z/YDh0j6iLy+sXIhLxifGX1zQoYCPjpZtVjng9GGsb+gQ
         +fdja5yNZoWKYkeiFW3femhGVBBUWWSBo8g8WNBrJtmnxehaVR4pUQBILf6qo207jP90
         u77W/jrG0Dlx7GPooBtnda9MiA2hifvNFbJ3lHVNii9uWUpKmPNWfM/3+kiH7HSZZ/Yb
         EIuTzdSE/yQauQgV33iIfW7/EwjU17c2N2w5kQ/rtpg78iDLvrdxkCBQr4ZBC8FnSJd+
         83jCGp/9I3HGzdN+uuYOJtZ+FPO1N5JXpG81Yw7rvw2c7Tj8Ss6r3X7weOzpsPmIqxvo
         4rwA==
X-Gm-Message-State: ACrzQf1cfLv6+JPh/lONc9JfPe8qQZXlQoIylgZW+ZWbycsy06lv18im
        ETtalSSUlS4zhh3mJS3RAjHf/yehAbWd6g==
X-Google-Smtp-Source: AMsMyM7nQGa+ShVQDbp1VeTf8kDPZweStsGsDD/d81Y/ONFbrUHKjwA5iD/ZilbLC1hN80iYRdvcWQ==
X-Received: by 2002:a05:600c:3d93:b0:3b4:c28f:6a2b with SMTP id bi19-20020a05600c3d9300b003b4c28f6a2bmr6682870wmb.121.1664561315260;
        Fri, 30 Sep 2022 11:08:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:33 -0700 (PDT)
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
Subject: [PATCH v3 08/36] built-ins: consistently add "\n" between "usage" and options
Date:   Fri, 30 Sep 2022 20:07:31 +0200
Message-Id: <patch-v3-08.36-e9924890620-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change commands in the "diff" family and "rev-list" to separate the
usage information and option listing with an empty line.

In the case of "git diff -h" we did this already (but let's use a
consistent "\n" pattern there), for the rest these are now consistent
with how the parse_options() API would emit usage.

As we'll see in a subsequent commit this also helps to make the "git
<cmd> -h" output more easily machine-readable, as we can assume that
the usage information is separated from the options by an empty line.

Note that "COMMON_DIFF_OPTIONS_HELP" starts with a "\n", so the
seeming omission of a "\n" here is correct, the second one is provided
by the macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-files.c | 1 +
 builtin/diff-index.c | 1 +
 builtin/diff-tree.c  | 1 +
 builtin/diff.c       | 3 ++-
 builtin/rev-list.c   | 1 +
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 92cf6e1e922..096ea2fedbc 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -15,6 +15,7 @@
 
 static const char diff_files_usage[] =
 "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
+"\n"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 7d158af6b6d..e667cf52e7d 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -11,6 +11,7 @@
 static const char diff_cache_usage[] =
 "git diff-index [-m] [--cached] "
 "[<common-diff-options>] <tree-ish> [<path>...]"
+"\n"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 116097a404a..23f58702fa0 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -85,6 +85,7 @@ static int diff_tree_stdin(char *line)
 static const char diff_tree_usage[] =
 "git diff-tree [--stdin] [-m] [-c | --cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
 "[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"\n"
 "  -r            diff recursively\n"
 "  -c            show combined diff for merge commits\n"
 "  --cc          show combined diff for merge commits removing uninteresting hunks\n"
diff --git a/builtin/diff.c b/builtin/diff.c
index 54bb3de964c..67760b67552 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -30,7 +30,8 @@ static const char builtin_diff_usage[] =
 "   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <blob> <blob>\n"
-"   or: git diff [<options>] --no-index [--] <path> <path>\n"
+"   or: git diff [<options>] --no-index [--] <path> <path>"
+"\n"
 COMMON_DIFF_OPTIONS_HELP;
 
 static const char *blob_path(struct object_array_entry *entry)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index fba6f5d51f3..f67e2b33555 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -21,6 +21,7 @@
 
 static const char rev_list_usage[] =
 "git rev-list [<options>] <commit-id>... [-- <path>...]\n"
+"\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
 "    --max-age=<epoch>\n"
-- 
2.38.0.rc2.935.g6b421ae1592

