Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4421F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeAGSPX (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:23 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46356 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754418AbeAGSPV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:21 -0500
Received: by mail-qt0-f194.google.com with SMTP id r39so11255717qtr.13
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uHef39jsVbmhKUzJKTu3TlIOKD7yiGLdXKVQMmYvudo=;
        b=Dc+24HgoaSnc/TaQGqtR+lREPkTp1PVHjZsIgWCmgDjZablxNR1qiZ8U/Hr4namdLM
         UEFiinrndIX9wTZ94At48Lp4PW2J2J0PnsBN86vIpbslksjWHk5s5c95SPADyH6NFj3J
         U0bjpe8Aj+QIug/QWCN/+9mCYLbB/pLbYDbx1Pt7wRcZKO1FrjelT/8xuyJsXMkw6GFy
         UsyYZ+Y5uGShgvwR/I9Dl+lDRDo3zTNl4BQy2RcIiOgwQtAHohPtP+WkIk7pcB5vcxBr
         Lyq5/dbm1Q6Xr+OCNh/hmA5z/oylte7HYDHKlAw/FnSX0fuZKOlSQFvt0ROhkcM7xdW8
         +DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uHef39jsVbmhKUzJKTu3TlIOKD7yiGLdXKVQMmYvudo=;
        b=KPgoyI9ONTfVE+MYCnmyQmErALqmLx+DYCvSzxGkNvqM0uK1f4nJnOgY4ahYGtVwps
         QlYJDLiYCCnBZwi7mwRCnTUKgjLNTJkr0rIsZkbbT0ffy3fSa3gr9fQV0qnRjO5Z9/Ds
         D7zcXH7tMyoWfhECjDsGoeR/bnczfgmBKapJengQiJ0sDOCab35c75e5GvOSBQRuh9I9
         5DAsxyLdxjUmJwfe2rH09aoOSOjMZJlQWqfLgTKeRAFj0vZG58x7u34UoOJ+RQgRWH1C
         wvLSC2aK7flF6oNVukHVIA4i/irXuqQT5DeAjRvG+BY589hSpwwvjpuE6REbTPq398WH
         ISog==
X-Gm-Message-State: AKwxytfZuIVM66tp/lfRwW3iZU/xBZf448QSqf+xPATg1eVfU/uFL6vF
        QUY5CJIEPvaHFDBSV7lcA6OfBwhKES8=
X-Google-Smtp-Source: ACJfBou5HVTGtbURkZds4ETTJCeP8hM0DcIsGUQ2aZ0IVFifuHqfQDY0uUQDLHIP9BnTljy81nDOrQ==
X-Received: by 10.237.63.58 with SMTP id p55mr12853632qtf.225.1515348919946;
        Sun, 07 Jan 2018 10:15:19 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:19 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 11/18] midx: teach git-midx to clear midx files
Date:   Sun,  7 Jan 2018 13:14:52 -0500
Message-Id: <20180107181459.222909-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a way to troubleshoot unforeseen problems with MIDX files, provide
a way to delete "midx-head" and the MIDX it references.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-midx.txt | 12 +++++++++++-
 builtin/midx.c             | 31 ++++++++++++++++++++++++++++++-
 t/t5318-midx.sh            |  9 +++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
index 3eeed1d969..c184d3a593 100644
--- a/Documentation/git-midx.txt
+++ b/Documentation/git-midx.txt
@@ -9,7 +9,7 @@ git-midx - Write and verify multi-pack-indexes (MIDX files).
 SYNOPSIS
 --------
 [verse]
-'git midx' [--write|--read] <options> [--pack-dir <pack_dir>]
+'git midx' [--write|--read|--clear] <options> [--pack-dir <pack_dir>]
 
 DESCRIPTION
 -----------
@@ -22,6 +22,10 @@ OPTIONS
 	Use given directory for the location of packfiles, pack-indexes,
 	and MIDX files.
 
+--clear::
+	If specified, delete the midx file specified by midx-head, and
+	midx-head. (Cannot be combined with --write or --read.)
+
 --read::
 	If specified, read a midx file specified by the midx-head file
 	and output basic details about the midx file. (Cannot be combined
@@ -79,6 +83,12 @@ $ git midx --read
 $ git midx --read --midx-id 3e50d982a2257168c7fd0ff12ffe5cf6af38c74e
 --------------------------------------------------------------------
 
+* Delete the current midx-head and the file it references.
++
+-----------------------------------------------
+$ git midx --clear
+-----------------------------------------------
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/midx.c b/builtin/midx.c
index aff2085771..b30ef36ff8 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -11,11 +11,13 @@
 static char const * const builtin_midx_usage[] = {
 	N_("git midx [--pack-dir <packdir>]"),
 	N_("git midx --write [--update-head] [--pack-dir <packdir>]"),
+	N_("git midx --clear [--pack-dir <packdir>]"),
 	NULL
 };
 
 static struct opts_midx {
 	const char *pack_dir;
+	int clear;
 	int read;
 	const char *midx_id;
 	int write;
@@ -24,6 +26,29 @@ static struct opts_midx {
 	struct object_id old_midx_oid;
 } opts;
 
+static int midx_clear(void)
+{
+	struct strbuf head_path = STRBUF_INIT;
+	char *old_path;
+
+	if (!opts.has_existing)
+		return 0;
+
+	strbuf_addstr(&head_path, opts.pack_dir);
+	strbuf_addstr(&head_path, "/");
+	strbuf_addstr(&head_path, "midx-head");
+	if (remove_path(head_path.buf))
+		die("failed to remove path %s", head_path.buf);
+	strbuf_release(&head_path);
+
+	old_path = get_midx_filename_oid(opts.pack_dir, &opts.old_midx_oid);
+	if (remove_path(old_path))
+		die("failed to remove path %s", old_path);
+	free(old_path);
+
+	return 0;
+}
+
 static int midx_read(void)
 {
 	struct object_id midx_oid;
@@ -263,6 +288,8 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
 			N_("dir"),
 			N_("The pack directory containing set of packfile and pack-index pairs.") },
+		OPT_BOOL('c', "clear", &opts.clear,
+			N_("clear midx file and midx-head")),
 		OPT_BOOL('r', "read", &opts.read,
 			N_("read midx file")),
 		{ OPTION_STRING, 'M', "midx-id", &opts.midx_id,
@@ -287,7 +314,7 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 			     builtin_midx_options,
 			     builtin_midx_usage, 0);
 
-	if (opts.write + opts.read > 1)
+	if (opts.write + opts.read + opts.clear > 1)
 		usage_with_options(builtin_midx_usage, builtin_midx_options);
 
 	if (!opts.pack_dir) {
@@ -299,6 +326,8 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 
 	opts.has_existing = !!get_midx_head_oid(opts.pack_dir, &opts.old_midx_oid);
 
+	if (opts.clear)
+		return midx_clear();
 	if (opts.read)
 		return midx_read();
 	if (opts.write)
diff --git a/t/t5318-midx.sh b/t/t5318-midx.sh
index 2e52389442..9337355ab3 100755
--- a/t/t5318-midx.sh
+++ b/t/t5318-midx.sh
@@ -143,4 +143,13 @@ test_expect_success 'write-midx in bare repo' \
      git midx --read >output &&
      cmp output expect'
 
+test_expect_success 'midx --clear' \
+    'git midx --clear &&
+     test_path_is_missing "${baredir}/midx-${midx4}.midx" &&
+     test_path_is_missing "${baredir}/midx-head" &&
+     cd ../full &&
+     git midx --clear &&
+     test_path_is_missing "${packdir}/midx-${midx4}.midx" &&
+     test_path_is_missing "${packdir}/midx-head"'
+
 test_done
-- 
2.15.0

