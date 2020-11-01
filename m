Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC0AC2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199802225C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSfSAkB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgKAR2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKAR2v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:28:51 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143BC061A04
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 09:28:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so11892495wrg.12
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 09:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bJwfGHssSO7FwyQCHCC+rZiTBwG6EPhpyDUb1/9NjEY=;
        b=NSfSAkB/GFjDyRpTj0vRZ07vteUmJnFJUh9FDwjGqCJ5q3qKnGRz1Ske9wio/+4T8O
         epBNqa0GN+61HidsKMfw5IAz/LKJi1bYKw5yqh9v21ufzlp2BL/qRUojRr0YO0jGGylf
         4dYphjr1tvvXEAFefBECR2X4XR0eIbDgrX5pKR8aP8Ak2QC8LFK/Qc7Z3YfxpcmSLQPl
         Seh7xS7ONr3ZyD8FAoqZ86Lf5g1sN3vRZ9E15QQ0M8+jsRRirTYslBoda2xPJT2jCOX9
         cr/ehhrLTH1VJ4zj/SpQAejkx4V5p0IPuqx831ACtpBhOzl3g1JMkUbp8k90G8lRvejz
         NGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bJwfGHssSO7FwyQCHCC+rZiTBwG6EPhpyDUb1/9NjEY=;
        b=EkaW9c16VwYqhyenbUDkvms5bmXbmGba8e/S2foy78iPoJxYohBVXnSxL0XCHaTImH
         FgQM6NNM48gVdqQjAPaIlDRAwfMeAuGmMK0Z5Zr/edgSkXhMkBRCMKMNPvdwuplNrH8k
         AmXsVupndfr0GKu8DMx5wLXyejzh57jOfRFEIlLvFlvvNl7dpiGilUekzpYeypbQ0MTs
         jUWcQYjvFayR+ViM7nMAxdGtmjxR2mjSj1OvSnyQRBIK5ySA8UBZLNpuiw2kFv1hDENL
         0ii+eKo845N4ry5xY9OtFbsrH0y0sjxPN9YO7DVhD7xbUqfz1tUDYG+vWPxJvz1TnUiB
         tQzQ==
X-Gm-Message-State: AOAM533uQxL+WPU7HTnwd5+nrin8GpCnSMYOXd1pTGcYzlqbdNW2umFH
        OUg3GIRZn6Sic7+QGwHYeyU1bxAsdkU=
X-Google-Smtp-Source: ABdhPJyTJrXmdLydSgUJ3Mzuwfjrr6JzkbKBTe8rN5u4Ly1YaMROMcGVQN9TthnIyaqhNQX9zv1yew==
X-Received: by 2002:adf:c3c6:: with SMTP id d6mr15819849wrg.206.1604251729889;
        Sun, 01 Nov 2020 09:28:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm19311663wra.29.2020.11.01.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:28:49 -0800 (PST)
Message-Id: <b4fa5fb5ae5cb1d23bde1481a73b088826aa3f44.1604251728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 17:28:40 +0000
Subject: [PATCH v2 1/8] doc: log, gitk: move '-L' description to
 'line-range-options.txt'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The description of the '-L' option for `git log` and `gitk` is almost
the same, but is repeated in both 'git-log.txt' and 'gitk.txt' (the
difference being that 'git-log.txt' lists the option with a space
after '-L', while 'gitk.txt' lists it as stuck and notes that `gitk`
only understands the stuck form).

Reduce duplication by creating a new file, 'line-range-options.txt',
and include it in both files.

To simplify the presentation, only list the stuck form for both
commands, and remove the note about `gitk` only understanding the stuck
form.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-log.txt            | 15 +--------------
 Documentation/gitk.txt               | 20 +-------------------
 Documentation/line-range-options.txt | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/line-range-options.txt

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2b8ac5ff88..dd189a353a 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -77,20 +77,7 @@ produced by `--stat`, etc.
 	Intended to speed up tools that read log messages from `git log`
 	output by allowing them to allocate space in advance.
 
--L <start>,<end>:<file>::
--L :<funcname>:<file>::
-	Trace the evolution of the line range given by "<start>,<end>"
-	(or the function name regex <funcname>) within the <file>.  You may
-	not give any pathspec limiters.  This is currently limited to
-	a walk starting from a single revision, i.e., you may only
-	give zero or one positive revision arguments, and
-	<start> and <end> (or <funcname>) must exist in the starting revision.
-	You can specify this option more than once. Implies `--patch`.
-	Patch output can be suppressed using `--no-patch`, but other diff formats
-	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-	`--name-only`, `--name-status`, `--check`) are not currently implemented.
-+
-include::line-range-format.txt[]
+include::line-range-options.txt[]
 
 <revision range>::
 	Show only commits in the specified revision range.  When no
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index c653ebb6a8..d50e9ed10e 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -98,25 +98,7 @@ linkgit:git-rev-list[1] for a complete list.
 	(See "History simplification" in linkgit:git-log[1] for a more
 	detailed explanation.)
 
--L<start>,<end>:<file>::
--L:<funcname>:<file>::
-
-	Trace the evolution of the line range given by "<start>,<end>"
-	(or the function name regex <funcname>) within the <file>.  You may
-	not give any pathspec limiters.  This is currently limited to
-	a walk starting from a single revision, i.e., you may only
-	give zero or one positive revision arguments, and
-	<start> and <end> (or <funcname>) must exist in the starting revision.
-	You can specify this option more than once. Implies `--patch`.
-	Patch output can be suppressed using `--no-patch`, but other diff formats
-	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-	`--name-only`, `--name-status`, `--check`) are not currently implemented.
-+
-*Note:* gitk (unlike linkgit:git-log[1]) currently only understands
-this option if you specify it "glued together" with its argument.  Do
-*not* put a space after `-L`.
-+
-include::line-range-format.txt[]
+include::line-range-options.txt[]
 
 <revision range>::
 
diff --git a/Documentation/line-range-options.txt b/Documentation/line-range-options.txt
new file mode 100644
index 0000000000..266263f6b4
--- /dev/null
+++ b/Documentation/line-range-options.txt
@@ -0,0 +1,15 @@
+-L<start>,<end>:<file>::
+-L:<funcname>:<file>::
+
+	Trace the evolution of the line range given by "<start>,<end>"
+	(or the function name regex <funcname>) within the <file>.  You may
+	not give any pathspec limiters.  This is currently limited to
+	a walk starting from a single revision, i.e., you may only
+	give zero or one positive revision arguments, and
+	<start> and <end> (or <funcname>) must exist in the starting revision.
+	You can specify this option more than once. Implies `--patch`.
+	Patch output can be suppressed using `--no-patch`, but other diff formats
+	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
+	`--name-only`, `--name-status`, `--check`) are not currently implemented.
++
+include::line-range-format.txt[]
-- 
gitgitgadget

