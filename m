Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFB8C5517A
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2DC22265
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spfJ7YdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKAR2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKAR2w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:28:52 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DBDC0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 09:28:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s9so11907913wro.8
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 09:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XdA++MRqJSgWVqrx76LuRSmxfv96ZIAz/oLur7BIroQ=;
        b=spfJ7YdENuL+hJo4nhK7gn8Y0kZ+2rhjQMaDSHM0wUnUUjxI0uSKtTuh77FHdIJkYD
         oTOsFvKo1F/03pBgJa5asQB7gPx9ME7OE3jwcazoq5TqmlIKYEv4iqiinAP0yRkPmc8Q
         tu+CcaSVYqaDXMmu+4dt1bouHjGNHydBJPreu5/LHVWBc6DYfrkVbxrDykWfQgZMhIcm
         IopHGFhg5HBIf00dMR7cZs5KknIFmx/+ZE7fV8dxwI3yDzQ8lG7k0niYEwCRCcPCHhjD
         zh9WAc0VNs+MoYRaX283WPMrmcPEqp/IXnwc3nK7Cu9VwOSAPmEJjUjNfiXf8vA6aKVT
         HTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XdA++MRqJSgWVqrx76LuRSmxfv96ZIAz/oLur7BIroQ=;
        b=T4o1T+8MKamRC6DxgUpwBxFPmNWS9QV0wbaZqp8eAxy2RYnn7qYz/j9AcB8Q4tXpXE
         pI78pfGrx50CyvcRrv1Eiyu+NOs6EoPTbKBpQAhBJ4aPSTz8+Dfl6A0QRpPq901/8K0t
         AVAoh4vutV/9ThOo6h6eayZVh+zyNjeoVy/KkfzgR7ccLuTPS8/KrV/pOPtaVI+YbGHI
         3dHDCK20/bf4dSKnaEQ5BKaiu8MPeVA/ucnJUUT0HpTuzSSj2YZbSA0H4Q57cr4rgMl8
         8Qrqo87cJmR8Haqc+p0qhBczDbhur6UOC2X7Wmb7uJiBBb77XsjdmnEP6O1N06seS18g
         28Cw==
X-Gm-Message-State: AOAM531iexgBZi3SviJJxYC10uK3JHSJz7rVVFKMywKi2O8diK1wxz1q
        h6AazY+PXWrf3OLy1jdd+OtAYo1a264=
X-Google-Smtp-Source: ABdhPJyG49zsJ4IjasNaHA1EEaDDWCP2tNtrJeBCD9bJwke6hUMjQFUbAxJUrXiXH8M4jNRmcyAsag==
X-Received: by 2002:adf:914c:: with SMTP id j70mr16249614wrj.170.1604251730697;
        Sun, 01 Nov 2020 09:28:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm19217449wrm.77.2020.11.01.09.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:28:50 -0800 (PST)
Message-Id: <6c44b1c576150212cfb23c6f3d0ca3563ddf4556.1604251728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 17:28:41 +0000
Subject: [PATCH v2 2/8] doc: line-range: improve formatting
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
index 829676ff98..43759eef89 100644
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
+If `:<funcname>` is given in place of '<start>' and '<end>', it is a
 regular expression that denotes the range from the first funcname line
-that matches <funcname>, up to the next funcname line. ``:<funcname>''
+that matches '<funcname>', up to the next funcname line. `:<funcname>`
 searches from the end of the previous `-L` range, if any, otherwise
-from the start of file. ``^:<funcname>'' searches from the start of
+from the start of file. `^:<funcname>` searches from the start of
 file.
diff --git a/Documentation/line-range-options.txt b/Documentation/line-range-options.txt
index 266263f6b4..1c90127300 100644
--- a/Documentation/line-range-options.txt
+++ b/Documentation/line-range-options.txt
@@ -1,12 +1,12 @@
 -L<start>,<end>:<file>::
 -L:<funcname>:<file>::
 
-	Trace the evolution of the line range given by "<start>,<end>"
-	(or the function name regex <funcname>) within the <file>.  You may
+	Trace the evolution of the line range given by '<start>,<end>'
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

