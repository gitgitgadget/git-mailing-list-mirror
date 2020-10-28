Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8CAC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A836220878
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7u8uOJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgJ2CEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgJ1VjG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE78C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:39:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 13so655366wmf.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bkG1AbO7CDoqXplFXj4nxwr1mT3OVxp12LeC4oSNcYU=;
        b=R7u8uOJEU94/dOjT6cLQw1wdx+EQJ8LaUGgubI+aTXnP+4S/8B7y2Jt7WZtCVBWt3m
         mCaww/C7M7VZcHqgcIHbBMd5Wou96hYGw2CPavqnSZGwuHOjGWNIOcRcfX6wdgPeM8Vf
         KDEoiCZleNW66ONMU5BEAo0e5EWxsu5BEUY1hrtySfNYEwkq+lEMNI4YT3XtdnccFPxf
         zEyVw/taBmi7JIIYTGyh1PxL2Nxy767OV8si5Wk+sApVFwHRDTUhSHb+qTKAs6QxsPuK
         pNQj/SSib6Lrzpd2sfrP3bRE25US/c/1gE6cBKBz9qt8De5nE4sqwMXa1IUcx9h7jt6e
         jv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bkG1AbO7CDoqXplFXj4nxwr1mT3OVxp12LeC4oSNcYU=;
        b=gx2JAApKxTU+c2Bfhst71ePPAeXqaBfNiiyZY3C0LGsHTDRuICUcCzw5eVQqdV4y1+
         7rCQ2TzlX7aoK5f26n/4VHji13lr7LLhmSfD4bWNu3JGa43z838rk1uTxn02ZkLAqVNN
         74RrCnGOSHvL/xxhU7OtWYGTvYgE6UmWRYhwMHNj9YsXf2Sjt42RFQ7+vprClpTEBXvv
         9c6+w5HgrxEsZtwhQtLj22C0hAvgTrTcqp5rN8bO9DsM76o5X80IarBgmf0p9bPwj/0g
         cDjb47uB9LBMbL8FLVIGynlCWdL+2LAjYFGJaJctEiXKFC2AQrcLgf4qRr5yiXy617Iz
         Qplg==
X-Gm-Message-State: AOAM5312sXTg+D83le0a3Bl3Eky4RPLb6hmZKZ4dVKuxnfR7r3KkL+Vx
        S3yuApw2SKdUZ8tDEYOq3+Vn6yiFA/M=
X-Google-Smtp-Source: ABdhPJweblCKIqqecDcHVRWVB7WLW5UOik0IHToTayX9hgIqVA9+5CLhC8h4w/GsGOrPQvjeTodEFg==
X-Received: by 2002:a1c:7708:: with SMTP id t8mr7968636wmi.6.1603889273990;
        Wed, 28 Oct 2020 05:47:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm6796536wrn.48.2020.10.28.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:47:53 -0700 (PDT)
Message-Id: <7d3fc0a503b160ea15363a4465af4647bce6a30b.1603889270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.git.1603889270.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Oct 2020 12:47:46 +0000
Subject: [PATCH 2/6] doc: line-range: improve formatting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Improve the formatting of the description of the line-range option '-L'
for `git log`, `gitk` and `git blame`:

- Use bold for <start>, <end> and <funcname>
- Use backticks for literals

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/blame-options.txt      |  4 ++--
 Documentation/line-range-format.txt  | 24 ++++++++++++------------
 Documentation/line-range-options.txt |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 88750af7ae..48bf0eeec5 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -14,8 +14,8 @@
 	Annotate only the given line range. May be specified multiple times.
 	Overlapping ranges are allowed.
 +
-<start> and <end> are optional. ``-L <start>'' or ``-L <start>,'' spans from
-<start> to end of file. ``-L ,<end>'' spans from start of file to <end>.
+'<start>' and '<end>' are optional. `-L <start>` or `-L <start>,` spans from
+'<start>' to end of file. `-L ,<end>` spans from start of file to '<end>'.
 +
 include::line-range-format.txt[]
 
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index 829676ff98..6ee159b683 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -1,30 +1,30 @@
-<start> and <end> can take one of these forms:
+'<start>' and '<end>' can take one of these forms:
 
 - number
 +
-If <start> or <end> is a number, it specifies an
+If '<start>' or '<end>' is a number, it specifies an
 absolute line number (lines count from 1).
 +
 
-- /regex/
+- `/regex/`
 +
 This form will use the first line matching the given
-POSIX regex. If <start> is a regex, it will search from the end of
+POSIX regex. If '<start>' is a regex, it will search from the end of
 the previous `-L` range, if any, otherwise from the start of file.
-If <start> is ``^/regex/'', it will search from the start of file.
-If <end> is a regex, it will search
-starting at the line given by <start>.
+If '<start>' is `^/regex/`, it will search from the start of file.
+If '<end>' is a regex, it will search
+starting at the line given by '<start>'.
 +
 
 - +offset or -offset
 +
-This is only valid for <end> and will specify a number
-of lines before or after the line given by <start>.
+This is only valid for '<end>' and will specify a number
+of lines before or after the line given by '<start>'.
 
 +
-If ``:<funcname>'' is given in place of <start> and <end>, it is a
+If "`:<funcname>`" is given in place of '<start>' and '<end>', it is a
 regular expression that denotes the range from the first funcname line
-that matches <funcname>, up to the next funcname line. ``:<funcname>''
+that matches '<funcname>', up to the next funcname line. `:<funcname>`
 searches from the end of the previous `-L` range, if any, otherwise
-from the start of file. ``^:<funcname>'' searches from the start of
+from the start of file. `^:<funcname>` searches from the start of
 file.
diff --git a/Documentation/line-range-options.txt b/Documentation/line-range-options.txt
index 9e3d98d44f..d2ef1a6d67 100644
--- a/Documentation/line-range-options.txt
+++ b/Documentation/line-range-options.txt
@@ -7,12 +7,12 @@ ifdef::gitk[]
 -L:<funcname>:<file>::
 endif::gitk[]
 
-	Trace the evolution of the line range given by "<start>,<end>"
-	(or the function name regex <funcname>) within the <file>.  You may
+	Trace the evolution of the line range given by "'<start>,<end>'"
+	(or the function name regex '<funcname>') within the '<file>'. You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments, and
-	<start> and <end> (or <funcname>) must exist in the starting revision.
+	'<start>' and '<end>' (or '<funcname>') must exist in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
 	Patch output can be suppressed using `--no-patch`, but other diff formats
 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-- 
gitgitgadget

