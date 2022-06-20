Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E28BC433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 15:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbiFTPtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiFTPtj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 11:49:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73091BEB1
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 08:49:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i10so11511200wrc.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=9JH+weqLvmyiQZ9TpADSbIWemhQybJbiRInvdEACmsg=;
        b=HWN98k0diWwLbkiT6EL/od3WV45sjMv0GoLKBw8NKtPuRtUVLDx4qxSn3UObFPzE3h
         DpI4w2G+UKG+TEM6iZuVmyLppwjR9LJCPXi8ytsu70+otlV9TyTR7G2Axir5X5iy+vYL
         UIhdBBNULCvv5lTFzvEseMnX9VmZ97vvoRDk5/fd37Cs47k/KNrg/COGTUk3HIcErWDx
         z74gapV5F/oC5/dmLk5NcpP8REkF9OJADejK5BJK9tf509IJx8Qf76st9D8XAxrX22AX
         BuK4ctzxAMQOi3f72o3JhScTUu80yrHK7L0bWUSTOgDnRpiAjKEjoZpDqrEqGj58c0Yw
         Zo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9JH+weqLvmyiQZ9TpADSbIWemhQybJbiRInvdEACmsg=;
        b=W8nUegKm9MmXeYnuzWIURq7mYwrg4Jy6RWs+RygqS2X+5dODruPMctpI1JJbon7OZJ
         SxU8sFtGwsy9MHfxHBRCyfZwE2pZkPLYc+MGVRtqqCto90rtYjs+G9dx5CJgXXoNuG4G
         ceNYlFlfp6FXOC3Ptbowha4VM8qzTHVmbheQ0v5YPwWlC9shGGqKvQwNTBY2fKUgwLrO
         /t/wYQ19ZRsMxG2XOtjVVtNc7B7QQgpZk/xiYc4lkF0yrzWiFshi3TZu9CqQ2bHbRbtF
         XnDULYLhTlzrT3VceWMAXRidXdXneTiuxg9bnt0rOq3Tfl/NcMahf8vlmXSUz30BD6Bn
         k1VA==
X-Gm-Message-State: AJIora83P7ef3iQeVRyexrOZWhxsn5k87E2liRtanVLlTQccrFtDKrsu
        w/r/8AdI6wR3mq6kMB/p+0BUgS1XdwKF6w==
X-Google-Smtp-Source: AGRyM1sx/StxkoRn2TQn/KrikSxFBCd2g8XmdSdeNL28z3m4zX38O0bYjBxaenB9HLGZ7cPPE73/ng==
X-Received: by 2002:a05:6000:170a:b0:215:6799:782c with SMTP id n10-20020a056000170a00b002156799782cmr23328992wrc.38.1655740175809;
        Mon, 20 Jun 2022 08:49:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10-20020adfe90a000000b0021b9504cc83sm711619wrm.31.2022.06.20.08.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:49:35 -0700 (PDT)
Message-Id: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com>
From:   "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jun 2022 15:49:34 +0000
Subject: [PATCH] grep: add --max-count command line option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Martin =?UTF-8?Q?=C3=85gren?= [ ]" <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>,
        "Carlos L." <00xc@protonmail.com>,
        =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>

This patch adds a command line option analogous to that of GNU
grep(1)'s -m / --max-count, which users might already be used to.
This makes it possible to limit the amount of matches shown in the
output while keeping the functionality of other options such as -C
(show code context) or -p (show containing function), which would be
difficult to do with a shell pipeline (e.g. head(1)).

Signed-off-by: Carlos López 00xc@protonmail.com
---
    grep: add --max-count command line option
    
    This patch adds a command line option analogous to that of GNU grep(1)'s
    -m / --max-count, which users might already be used to. This makes it
    possible to limit the amount of matches shown in the output while
    keeping the functionality of other options such as -C (show code
    context) or -p (show containing function), which would be difficult to
    do with a shell pipeline (e.g. head(1)).
    
    Signed-off-by: Carlos López 00xc@protonmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1278%2F00xc%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1278/00xc/master-v1
Pull-Request: https://github.com/git/git/pull/1278

 Documentation/git-grep.txt | 8 ++++++++
 builtin/grep.c             | 9 +++++++++
 grep.c                     | 2 ++
 grep.h                     | 2 ++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3d393fbac1b..19b817d5e58 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
+	   [(-m | --max-count) <num>]
 	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
@@ -238,6 +239,13 @@ providing this option will cause it to die.
 	`git diff` works out patch hunk headers (see 'Defining a
 	custom hunk-header' in linkgit:gitattributes[5]).
 
+-m <num>::
+--max-count <num>::
+	Limit the amount of matches per file. When using the `-v` or
+	`--invert-match` option, the search stops after the specified
+	number of non-matches. A value of -1 will return unlimited
+	results (the default).
+
 --threads <num>::
 	Number of grep worker threads to use.
 	See `grep.threads` in 'CONFIGURATION' for more information.
diff --git a/builtin/grep.c b/builtin/grep.c
index bcb07ea7f75..4ab28995da0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -961,6 +961,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
 			   N_("allow calling of grep(1) (ignored by this build)"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_INTEGER('m', "max-count", &opt.max_count,
+			N_("maximum number of results per file")),
 		OPT_END()
 	};
 	grep_prefix = prefix;
@@ -1101,6 +1103,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (recurse_submodules && untracked)
 		die(_("--untracked not supported with --recurse-submodules"));
 
+	/*
+	 * Optimize out the case where the amount of matches is limited to zero.
+	 * We do this to keep results consistent with GNU grep(1).
+	 */
+	if (opt.max_count == 0)
+		exit(EXIT_FAILURE);
+
 	if (show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
diff --git a/grep.c b/grep.c
index 82eb7da1022..a010f9f4132 100644
--- a/grep.c
+++ b/grep.c
@@ -1686,6 +1686,8 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		bol = eol + 1;
 		if (!left)
 			break;
+		if (opt->max_count != (unsigned)-1 && count == opt->max_count)
+			break;
 		left--;
 		lno++;
 	}
diff --git a/grep.h b/grep.h
index c722d25ed9d..218585a8679 100644
--- a/grep.h
+++ b/grep.h
@@ -171,6 +171,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	unsigned max_count;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
@@ -181,6 +182,7 @@ struct grep_opt {
 	.relative = 1, \
 	.pathname = 1, \
 	.max_depth = -1, \
+	.max_count = (unsigned)-1, \
 	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
 	.colors = { \
 		[GREP_COLOR_CONTEXT] = "", \

base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
-- 
gitgitgadget
