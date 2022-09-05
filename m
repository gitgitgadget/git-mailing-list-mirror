Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B9ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiIEI1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbiIEI1C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0508CDFF
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso7337589wmh.5
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kOkihAzbAgzYJ1FHpFF2E1YoGSEhHH0wjHagigMkUyQ=;
        b=Hn+ftNiA6P8J/xrC01ORLdVxdu0BqCvBO1RSnIlqHEKh/NDdkmkQX+8mgtrynOQvyX
         eXaELmFFDWL3IzkvLUT8zI11JzlA01mTgHYtzIZbwAxe0lSDkfiHulsfW0uHBpTc1IVZ
         axVifOv5gBHzsozmY2EpXIWVXkRdyrHIfq0/SW62KM1tB3ohrtKc58abpVHSMR6U/Z4+
         1FYnHCqUW8wJ97PvliaoTsnHXpzmzOiEVaGIn1RuTyRKPt/GscABKxuX+J3ja92y2Fog
         mX2ANQtOmBBUNyPzDkecFpzZ+pguINVh1neoY0DnVEPxtOtd44M9fg67101z6APfmanY
         9OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kOkihAzbAgzYJ1FHpFF2E1YoGSEhHH0wjHagigMkUyQ=;
        b=zPZ8zCL056TxF+R1H0LNLs3U4vdHrPR3UlRZYEKN3sHOCjhBdsAba2kYQEDvtPgeZ6
         wMIdRDFi12ix/4q8/cwiwTL/+6Ghc1Vr7FANSUXykCuckFwAXbjuVHbeaxgM0yZrXBBv
         Y8NxMOeWEnfEc4G57YOWkk10BCpGDngHjqmggGPyHphrqKb/J2esxMaWXhxq8e9D/8z3
         9nQKd4dw8Km7sB4ytXzVvf9WakIiB+JGJiVf4R3J+E8+rnqn7dxokR71X8OhVBbjq/SX
         i0oRRysfaCVZ8/6r2n5nUlQfCEOtRl2fQhbcM3TuCsc0tPaXc+HuyJNv29mMfj3/nQzz
         1aPw==
X-Gm-Message-State: ACgBeo06q+ramAOXu1Ssofd0hFzwEhMaJdK8iud1ttf84yIfSQPKi4uk
        10FM6GZ1pS8ybpEBcycN3rBoupIq3gasww==
X-Google-Smtp-Source: AA6agR6/4spEsDC2hYZlVMxh6PbynKO+E++S6CwFfEHPaTpZ4lxdTvzTTols97ymzxMyYpjCnr4tdw==
X-Received: by 2002:a05:600c:3512:b0:3a5:e9d3:d418 with SMTP id h18-20020a05600c351200b003a5e9d3d418mr10160878wmq.0.1662366419166;
        Mon, 05 Sep 2022 01:26:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:58 -0700 (PDT)
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
Subject: [PATCH 08/34] built-ins: consistently add "\n" between "usage" and options
Date:   Mon,  5 Sep 2022 10:26:19 +0200
Message-Id: <patch-08.34-75c39a2ff83-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
2.37.3.1425.g73df845bcb2

