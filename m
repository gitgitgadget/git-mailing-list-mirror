Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FDDC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiI1IkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiI1Ijr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A763CBF6
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so18621877wrm.7
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AJaw6Nf/jvPdNslktRM97QzR4QetZnrEICLZRfbxh2I=;
        b=pb3uVdX3BVXA21cGXEV9Fpcr/ZRI+AL7Dg7+r44GqBTG8Z2aSvxPqE8350mKXD3+Sl
         oxOeAJoCocZzs5tYI2yV6GeEB8BPIEemV4euHbaIssACPv1hPSHjj1jCkwLzyBX6KKcq
         upI4nS6f7T18XrX9OQe3R6N+R80T3HEXzbnXNF3c7Hz/3PCz3Xa57a92eSwbJmPxTM4g
         dXQaPjUF+qQ+VSHi7au2/Rgk/+5FFQVe0HjvEyi0ZgTnoNKrGpbhaFVdOI+d3p1L59VX
         6Um8qmPa9/UIrB0oWU9NzNLdh082dMQk9XnexVwCXye0WsVBB7lhnqL5ESgCiKnPkSh8
         Y+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AJaw6Nf/jvPdNslktRM97QzR4QetZnrEICLZRfbxh2I=;
        b=xDHdCg/4MlM37byNXxr3K/qF9yRDLUETIAf/5ShKPS8PGdkX3F0mktLruNms/p9Im1
         iF87N7wPTH4RnT+buHzJWWDLJccBDsoRUk6QigqfiJ8xqhPu1wxK+gxklZnZhsI1fby0
         Ux5PacTOfAlpegpDRStvZUxhlzTefoq+bkOCff3oMzcyhRO+bkP8yf4ZISAbcfngUsan
         18C5TwiLUz9tgaFmGOIho5S1WMZPnhfVUVZtl62WKVlDBVhidxiabf9S5oE09XkQveoe
         g5Df/fpwYRAvvqmy+70EpF4LJ2tPe4tTR6UsPFRzhlNLIp0bMYIzVpGXc7EoLcWgnsLY
         g1tg==
X-Gm-Message-State: ACrzQf2SwOAo3/Q8WK+3JqApf4KXixeLf1D0FSSTCilRa0b4L9fsMce0
        3sXzbQvZkAVaDH+QwMZx40E2zwpWZp+Yjw==
X-Google-Smtp-Source: AMsMyM56hpFCSi69QzrMOK2GMeZGlJHbJBHbDSsjI4c3S9pH01D+LOECMj2g41f/NNUmh09P1NUXmw==
X-Received: by 2002:a05:6000:178e:b0:22b:c23:109d with SMTP id e14-20020a056000178e00b0022b0c23109dmr19490142wrg.408.1664354384311;
        Wed, 28 Sep 2022 01:39:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:43 -0700 (PDT)
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
Subject: [PATCH v2 08/35] built-ins: consistently add "\n" between "usage" and options
Date:   Wed, 28 Sep 2022 10:39:03 +0200
Message-Id: <patch-v2-08.35-4c68003904f-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
the usage usage information is separated from the options by an empty
line.

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
2.38.0.rc1.925.gb61c5ccd7da

