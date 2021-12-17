Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F568C433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhLQNaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhLQNaf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:30:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92064C061757
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o13so4018892wrs.12
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPPY1ht2tGo0kEPbxnO0IoZKfaNjNnKOJv79UKDE510=;
        b=iITlfqr87EPqSEfidaR/PukyIACxIPXIxUpFIOa2hJovBJPm2P2bWMWgryTKgWGlkI
         qJSOlxhrxc4WI2D/RocPKDMJ88HBZ+LbEZUh87ZTtCDrq3ov5PiiSPqDhugpKPFnteTx
         ADu9EMYFHRmwPKsN8zlXKEoFm6nrP4Ac6eXwqB9NjIFR5cuFOkDJLqmwp46BIUMhqslC
         UMfIsS4kqdfBH2lW/P7SV/RwyTEMYYqf8rTflo76UjL5HRPpT9r8paOqdD6lg1AWRquY
         HhqxvFsBHQ1dll2amGyi6N4AT0CtxTBAQ85kMxkrEfkHu2r8lijjw8JpPJmwXa+I0DBf
         L5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPPY1ht2tGo0kEPbxnO0IoZKfaNjNnKOJv79UKDE510=;
        b=1UEQnl5J80AryisfatZuo56gXcuF8DSkUR+yfUNe+qplhWdh7u1LeYAxen/nofsEok
         KhrUw8ulVRYCwf5qPo2bwJAhYEDSAWIhYJ8aZzzF3lyx2GGdby9DynceLjJfTo1sFcZ5
         iSdS9LKyC8lt6xV8N6kiajSt15VRKNPoHlqAHan3Ot/aetCfKGqZm+U+U8qb0IGYbp2i
         1be6S4wNybG0mSXgxYFwF+W5IRa609Mz8WXHnfdj0sZ0ZavcspVuW8yVIPXn3nw2XtXz
         O3Qg+Z8vkSTum224VpTqP3SEonuBY54tnr6J2006MC+dpaMDEe0gi/XaXSSpv9Rfu56n
         5ksQ==
X-Gm-Message-State: AOAM533Tb6nPxDiy3uDMQ6zPOMWSkTLuibCB2hX7g3Jegw090thkPprw
        fjULJlJqca+Kautm8TTmt9XWpaNln2KYIg==
X-Google-Smtp-Source: ABdhPJx9HI6DUxJYMhz0ENMoRkS0kS6mvUOWvhrh2MJtkq0ekxPbkyHSUcoswNHMBDXHLNK10W7+/A==
X-Received: by 2002:adf:fc09:: with SMTP id i9mr2519564wrr.336.1639747832937;
        Fri, 17 Dec 2021 05:30:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm11953993wmb.38.2021.12.17.05.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:30:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 7/7] ls-tree.c: support `--object-only` option for "git-ls-tree"
Date:   Fri, 17 Dec 2021 14:30:23 +0100
Message-Id: <RFC-patch-7.7-5e34df4f8dd-20211217T131635Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com> <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

We usually pipe the output from `git ls-trees` to tools like
`sed` or `cut` when we only want to extract some fields.

When we want only the pathname component, we can pass
`--name-only` option to omit such a pipeline, but there are no
options for extracting other fields.

Teach the "--object-only" option to the command to only show the
object name. This option cannot be used together with
"--name-only" or "--long" (mutually exclusive).

Signed-off-by: Teng Long <dyroneteng@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-ls-tree.txt |  7 ++++-
 builtin/ls-tree.c             |  6 +++++
 t/t3103-ls-tree-misc.sh       |  8 ++++++
 t/t3104-ls-tree-oid.sh        | 51 +++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db02d6d79a9..729370f2357 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
+	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]]
 	    <tree-ish> [<path>...]
 
 DESCRIPTION
@@ -59,6 +59,11 @@ OPTIONS
 --name-only::
 --name-status::
 	List only filenames (instead of the "long" output), one per line.
+	Cannot be combined with `--object-only`.
+
+--object-only::
+	List only names of the objects, one per line. Cannot be combined
+	with `--name-only` or `--name-status`.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index efd85cab088..f19b0138362 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -20,6 +20,7 @@ static int line_termination = '\n';
 #define LS_SHOW_TREES 4
 #define LS_NAME_ONLY 8
 #define LS_SHOW_SIZE 16
+#define LS_OBJECT_ONLY 32
 static int abbrev;
 static int ls_options;
 static struct pathspec pathspec;
@@ -31,6 +32,7 @@ static const char *ls_tree_prefix;
  */
 static const char *ls_tree_format_d = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
 static const char *ls_tree_format_l = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
+static const char *ls_tree_format_o = "%(objectname)";
 static const char *ls_tree_format_n = "%(path)";
 
 static const  char * const ls_tree_usage[] = {
@@ -271,6 +273,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_NAME_ONLY),
 		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
 			LS_NAME_ONLY),
+		OPT_BIT(0, "object-only", &ls_options, N_("list only objects"),
+			LS_OBJECT_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
@@ -302,6 +306,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		implicit_format = ls_tree_format_n;
 	if (ls_options & LS_SHOW_SIZE)
 		implicit_format = ls_tree_format_l;
+	if (ls_options & LS_OBJECT_ONLY)
+		implicit_format = ls_tree_format_o;
 
 	if (format && implicit_format)
 		usage_msg_opt(_("providing --format cannot be combined with other format-altering options"),
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index d18ba1bd84b..a8641706a6e 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -23,4 +23,12 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	test_must_fail git ls-tree -r HEAD
 '
 
+test_expect_success 'usage: incompatible options: --name-status with --long' '
+	test_expect_code 129 git ls-tree --long --name-status
+'
+
+test_expect_success 'usage: incompatible options: --name-only with --long' '
+	test_expect_code 129 git ls-tree --long --name-only
+'
+
 test_done
diff --git a/t/t3104-ls-tree-oid.sh b/t/t3104-ls-tree-oid.sh
new file mode 100755
index 00000000000..81304e7b13a
--- /dev/null
+++ b/t/t3104-ls-tree-oid.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='git ls-tree objects handling.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	mkdir -p C &&
+	test_commit C/D.txt &&
+	find *.txt path* \( -type f -o -type l \) -print |
+	xargs git update-index --add &&
+	tree=$(git write-tree) &&
+	echo $tree
+'
+
+test_expect_success 'usage: --object-only' '
+	git ls-tree --object-only $tree >current &&
+	git ls-tree $tree >result &&
+	cut -f1 result | cut -d " " -f3 >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: --object-only with -r' '
+	git ls-tree --object-only -r $tree >current &&
+	git ls-tree -r $tree >result &&
+	cut -f1 result | cut -d " " -f3 >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: --object-only with --abbrev' '
+	git ls-tree --object-only --abbrev=6 $tree >current &&
+	git ls-tree --abbrev=6 $tree >result &&
+	cut -f1 result | cut -d " " -f3 >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: incompatible options: --name-only with --object-only' '
+	test_expect_code 129 git ls-tree --object-only --name-only
+'
+
+test_expect_success 'usage: incompatible options: --name-status with --object-only' '
+	test_expect_code 129 git ls-tree --object-only --name-status
+'
+
+test_expect_success 'usage: incompatible options: --long with --object-only' '
+	test_expect_code 129 git ls-tree --object-only --long
+'
+
+test_done
-- 
2.34.1.1119.g7a3fc8778ee

