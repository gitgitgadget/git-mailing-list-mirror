Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA515C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJDNY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJDNYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05C50538
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y23-20020a1c4b17000000b003bd336914f9so794494wma.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHPK0nqLEU7QiZSOVoIVqKRuwLezeTdOF9CLA7Z1lQE=;
        b=iGA4DI47CgqoPh/6GwF1f9gnEV+fItMfcWUpyAzCXJuB5HRvjyK2k7ee7VmrDUC3cl
         WW2LX/noE/ETJ5b23TxwiZ7bOOi0qY95zZO8KtFA5VqnKm4SQep/iyNyy0AxrleX0mUr
         z9GTtTQyKTyj5TkAX+NvK6rZHPEabhVXttsODwM7q/GH1+CG53nyw+HymMEJGLCWlepE
         Xz6k7Ox8cNF311rEm3jYA/s0W4znp2+wGyDcKv04IzPVyDaXnwQoXIDFqKVzDQXQETMF
         F4GU28FwUTyiBfJA+z5hBNkfwl4t+aGwMvzfzzQZ3lQUhDihkJZOwVoc5vSyHFbINUlR
         ZiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHPK0nqLEU7QiZSOVoIVqKRuwLezeTdOF9CLA7Z1lQE=;
        b=3bUKu1gd6DSVnTXs0ckWIegpittnlQ0pUetR6rnQVIdPl+BOSOJluok2ttdTwXmSPN
         W9gWjM28DBI4DCHKgSdc5Pofb6q9/8jQX3+lrkhK7fbf5Mfiyg+SzbaeG1jk2Hs39toA
         Vp+lgvWtDc6c8sy2jLGXPk8oRVaJ2BSyPa0ttOwbOpxCLP7ouQ3KktOYbxwExSIK2Uc+
         wec2dACm8bSSMz8TxaSYvWo2cqcVNhCTPLV56gl92pOquDLTaNBm6dBXHr/spaHmMX8G
         BEO0Ha6iSibB7bFP4QiFVmNBYGqO8qGzYd5LCe+aUuLxv/DtW42VWDn2rWbeYghrMi/P
         dkbg==
X-Gm-Message-State: ACrzQf1Ibdg4BAd1YoKgFrJs4rjxTLAfregCXmIrrWKLW1PEpeVmWCsU
        NoJq33NP6ooNJXD5KEbuausIg7rp6gdSsQ==
X-Google-Smtp-Source: AMsMyM4Jjpzv9s0ksOg1qTOXSyec9jxNdf2pFWJND+1B/hNrjINuGQUK85xogWjPzxiwJEGO/htSlA==
X-Received: by 2002:a05:600c:2188:b0:3b4:9725:7941 with SMTP id e8-20020a05600c218800b003b497257941mr9999324wme.175.1664889840332;
        Tue, 04 Oct 2022 06:24:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:23:59 -0700 (PDT)
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
Subject: [PATCH v4 07/34] built-ins: consistently add "\n" between "usage" and options
Date:   Tue,  4 Oct 2022 15:23:21 +0200
Message-Id: <patch-v4-07.34-ecdc14f6dfe-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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

