Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFF2C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A349215A4
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDL9k5jC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgAaUQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39514 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgAaUQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so10143869wme.4
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qvJlsm6+87hUo/cW2GFKfhL+PDcSk/JMELMkiDzkh7k=;
        b=nDL9k5jCgzfFjA3+fFA6/JwSyzpqeMe5JZ3ng33k4lKYCnKX2VziaxKMpi0mPQ0+l9
         KbV9u1t54pgN59Km+9C9xLKk0yJjId2NeJ3BVgNrcCvyuWXJZgc2IfcvgWXhORNnFk9D
         bI3ABrEe04gYuSQgVAr4DfQ27JM2nsOi2XP1hab7gkIccdjUg3J/uz7MTsHuFi1arkXb
         MLLFZqzVwxXcCr0Gnf6KUm2RGa5ZhEVCIkSUyMs3qBUUMLK3X8fgALBxkIHLBlpIYMSX
         6ZmVVSPodK/lbrCABlmvo89MBgG9aWGXhYxRChrMj3TY6TQk3qgiEXOWvzIkzzHmDfhG
         kcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qvJlsm6+87hUo/cW2GFKfhL+PDcSk/JMELMkiDzkh7k=;
        b=MCSFNJ4/d0SG9j3PNjQJPqi8MAgdd7fUynNx4/3UPwEaJKMiim3tZ6m7dgKlJLFMVw
         Wu9hwrXMtrR8C/OtAukr84FQRlNw37d+7SveILlKLdzs780j00+HiVYqDOoyWzk0FanO
         r8ZIQMODxEIU/lMapNuZU+aRUL9k1p5PBDh3SG/axidF8M5LYgnBfGu8wyMEu9Xiy/nD
         sp4NQ0Cf07bTXhMUfKgXVQsjO+Xx9I6Xnnn9XJz/CXjb9sdowGciRrXRlWfTrPBvnfmJ
         lGcqOBQUznR8OYps4cA1D4PEPCG67tdnbv6cj9pPN0SB5kp3AvVeN4QCFBG1dewBjERM
         6LyA==
X-Gm-Message-State: APjAAAXnNb1bxT1SIRcTN9Gzg3Zm/afgXacF5oZpuOG4niZcDJ24thfm
        6wEriHQm1TF0PXQZrrMLf0cufBSn
X-Google-Smtp-Source: APXvYqxt80rNz8lJwHoMaGAhsgf7d+bbwK/9zlKACme4Av+Nbq3EkudukO3CQoqPTKG7E6dBJg6Uyw==
X-Received: by 2002:a05:600c:2147:: with SMTP id v7mr13218053wml.61.1580501784406;
        Fri, 31 Jan 2020 12:16:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm12416873wmi.27.2020.01.31.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:24 -0800 (PST)
Message-Id: <9f682e6076fd23491d51561ff2e9cf506cddbce6.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:11 +0000
Subject: [PATCH v4 11/15] sparse-checkout: unquote C-style strings over
 --stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a user somehow creates a directory with an asterisk (*) or backslash
(\), then the "git sparse-checkout set" command will struggle to provide
the correct pattern in the sparse-checkout file. When not in cone mode,
the provided pattern is written directly into the sparse-checkout file.
However, in cone mode we expect a list of paths to directories and then
we convert those into patterns.

Even more specifically, the goal is to always allow the following from
the root of a repo:

  git ls-tree --name-only -d HEAD | git sparse-checkout set --stdin

The ls-tree command provides directory names with an unescaped asterisk.
It also quotes the directories that contain an escaped backslash. We
must remove these quotes, then keep the escaped backslashes.

Use unquote_c_style() when parsing lines from stdin. Command-line
arguments will be parsed as-is, assuming the user can do the correct
level of escaping from their environment to match the exact directory
names.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 15 ++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index cc86b8a014..6083aa10f2 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -442,8 +442,21 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 		pl.use_cone_patterns = 1;
 
 		if (set_opts.use_stdin) {
-			while (!strbuf_getline(&line, stdin))
+			struct strbuf unquoted = STRBUF_INIT;
+			while (!strbuf_getline(&line, stdin)) {
+				if (line.buf[0] == '"') {
+					strbuf_reset(&unquoted);
+					if (unquote_c_style(&unquoted, line.buf, NULL))
+						die(_("unable to unquote C-style string '%s'"),
+						line.buf);
+
+					strbuf_swap(&unquoted, &line);
+				}
+
 				strbuf_to_cone_pattern(&line, &pl);
+			}
+
+			strbuf_release(&unquoted);
 		} else {
 			for (i = 0; i < argc; i++) {
 				strbuf_setlen(&line, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index fb8718e64a..a46a310740 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -405,7 +405,19 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	/zdoes\*not\*exist/
 	EOF
 	test_cmp expect escaped/.git/info/sparse-checkout &&
-	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
+	check_read_tree_errors escaped "a zbad\\dir zdoes*exist" &&
+	git -C escaped ls-tree -d --name-only HEAD | git -C escaped sparse-checkout set --stdin &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
+	/folder1/
+	/folder2/
+	/zbad\\dir/
+	/zdoes\*exist/
+	EOF
+	test_cmp expect escaped/.git/info/sparse-checkout &&
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist"
 '
 
 test_done
-- 
gitgitgadget

