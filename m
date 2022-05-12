Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F67C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 13:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354173AbiELNUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 09:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354278AbiELNUP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 09:20:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1095C252DCB
        for <git@vger.kernel.org>; Thu, 12 May 2022 06:20:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k2so7251813wrd.5
        for <git@vger.kernel.org>; Thu, 12 May 2022 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=2lemy9aLCfawqRtDu+T4/SWskq/WDZDkM2iQQRcvgEc=;
        b=PVQqQvk6FG1ORFmtVvSJhPOAiXz/ZyfcF517T97EiOi8KwUxDEnWa4Ci1w8yqtcyCU
         wzQL4QDpdlab7zJ/gL1TDikQB9ULbIjVIzQLQn+5ggUEc98W1dTto+ThYTvMjCJulD7T
         ALRqmu4bpvJ8Mjm9ZbnePnQKzTqpczqv8pN6szdBXlLVRM55x4r4gExUNKC6/6RwP74u
         TEePNPl1bqyTskTXla5IiSWVFrqSUQMm192pquJOA3uRdG+KYyb3LT7QcoGMgrmEU/Zc
         HcFZzfCrzyXr9+XBYJXG1YSkSt/zHMAllG01Vi6itA1bpkaB9RECOeWCOeY/ko8TiaCw
         Hbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2lemy9aLCfawqRtDu+T4/SWskq/WDZDkM2iQQRcvgEc=;
        b=L0kOiuXyfBm/A+RxgEsv0D+sPmupvN5qmD4AHKZV+hNqxagdoR3Pt3H7r1wTV9J5iA
         SwwTO+jyUogiYlvovwg0sI0Z7RrYojYYPqzWgoUKR+AJdaV3fDgBIU4rjCBGPTa7aijC
         OIbk7JrqjjFE7c59eQ+VbDdKRzXkP5V+hG0DzRbDcxJ14/jxn4JPjXqXhsVi21657caB
         XNc6uFhd8syZOlM72pZdFD0bVSfFhJmkVUSOiP0L2Uzkd1dbLP9M0NzSJ5i8okTamIen
         38z8wJQH5IoCM092zWVF7QOMZcbQ5dbGw4U5gliEEHFGlCQVqCuNRSBkWpJ7X7K0zmAM
         TkeA==
X-Gm-Message-State: AOAM530S9cTBX+On49ZRoJbqclIZkrFf8NjrF3K33MErnzDFDBUTx8Cb
        5y3X7u71S/zNzeSDLaXvU5GT7b1K//k=
X-Google-Smtp-Source: ABdhPJye+pMeyYc963Hi9kz5sSjr8u3sP9OAwemflIwwwdOk01uz1yyV6J6S39NrQ2SIHG1V0AdTxQ==
X-Received: by 2002:a05:6000:1a87:b0:20c:687f:6d10 with SMTP id f7-20020a0560001a8700b0020c687f6d10mr26596207wry.574.1652361611184;
        Thu, 12 May 2022 06:20:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q22-20020a7bce96000000b003942a244ebfsm2625445wmj.4.2022.05.12.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 06:20:10 -0700 (PDT)
Message-Id: <pull.1264.git.git.1652361610103.gitgitgadget@gmail.com>
From:   "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 May 2022 13:20:09 +0000
Subject: [PATCH] grep: add --max-count command line option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Carlos L." <00xc@protonmail.com>,
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

Signed-off-by: Carlos López <00xc@protonmail.com>
---
    grep: add --max-count command line option
    
    This patch adds a command line option analogous to that of GNU grep(1)'s
    -m / --max-count, which users might already be used to. This makes it
    possible to limit the amount of matches shown in the output while
    keeping the functionality of other options such as -C (show code
    context) or -p (show containing function), which would be difficult to
    do with a shell pipeline (e.g. head(1)).
    
    Signed-off-by: Carlos López 00xc@protonmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1264%2F00xc%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1264/00xc/master-v1
Pull-Request: https://github.com/git/git/pull/1264

 Documentation/git-grep.txt | 7 +++++++
 builtin/grep.c             | 2 ++
 grep.c                     | 2 ++
 grep.h                     | 1 +
 4 files changed, 12 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3d393fbac1b..02b36046475 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
+	   [-m | --max-count <num>]
 	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
@@ -238,6 +239,12 @@ providing this option will cause it to die.
 	`git diff` works out patch hunk headers (see 'Defining a
 	custom hunk-header' in linkgit:gitattributes[5]).
 
+-m <num>::
+--max-count <num>::
+	Limit the amount of matches per file. When using the -v or
+	--invert-match option, the search stops after the specified
+	number of non-matches. Setting this option to 0 has no effect.
+
 --threads <num>::
 	Number of grep worker threads to use.
 	See `grep.threads` in 'CONFIGURATION' for more information.
diff --git a/builtin/grep.c b/builtin/grep.c
index bcb07ea7f75..ba1894d5675 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -961,6 +961,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
 			   N_("allow calling of grep(1) (ignored by this build)"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_INTEGER('m', "max-count", &opt.max_count,
+			N_("maximum number of results per file (default: 0, no limit)")),
 		OPT_END()
 	};
 	grep_prefix = prefix;
diff --git a/grep.c b/grep.c
index 82eb7da1022..173b6c27b6e 100644
--- a/grep.c
+++ b/grep.c
@@ -1686,6 +1686,8 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		bol = eol + 1;
 		if (!left)
 			break;
+		if (opt->max_count && count == opt->max_count)
+			break;
 		left--;
 		lno++;
 	}
diff --git a/grep.h b/grep.h
index c722d25ed9d..25836f34314 100644
--- a/grep.h
+++ b/grep.h
@@ -171,6 +171,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	unsigned max_count;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);

base-commit: 277cf0bc36094f6dc4297d8c9cef79df045b735d
-- 
gitgitgadget
