Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65350C07E95
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482CA61186
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGKAt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhGKAt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:49:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E7EC0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:46:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k31-20020a05600c1c9fb029021727d66d33so7292657wms.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U4Sq35LhX5XIhPRbsyO8VH0d0uvwzL/zHhLjsn9IFus=;
        b=tUMlo2KM3F3XRm51EYfFBIFu5gL+jmr1blfohgCfzY6yIm+o5B7crXVKNKyTJWIvcA
         2ZrqsgIz7ZZEC5ujYeh1vmCMFXAFwulLRindnhgPt0AqWBsekdXxU2lc7Z85ZtVkA0L6
         bBvBIVjBHy1Ly/3dIQmBaDVWHxq0gedVshHeoLTUUjJEumob0YOXh1QbXroi/eIuWs0T
         /bQWHyGHrLc/MPxhwD2a4qkEk/aB35GjOQzcSG9oCsbVfFwRMxppHyaW2M5LwY28RFZN
         RqyPWnfTwR285RMTpuE8DWazbqF64BPzAZd7BUEQ+N0vVGzUBaqp59I3JvFgbSd9CyWx
         osyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U4Sq35LhX5XIhPRbsyO8VH0d0uvwzL/zHhLjsn9IFus=;
        b=U2sA4OmuQCcpN5N1uyp5knj3USDbaL22Mxz5yhELT5uYZga31YfOsphVKb7kFL/Yqs
         7WmVxiBtXXSb6ZwBSLFQAjft+eOHcio7u20RfM3vYrOV3Kbq/cPK7W141P6Omh5/6iIY
         jXgArKGqohHb91cNDH+/N1VPNGXwdBx7yh2EuAIgWoTp9ifJ0P3Em3WwHe/ua3LAKzmM
         ZjPH1bF1akrrEjb8U5IqT68BO4UXhHGwW0xur0FT6FmLjZbSHDo/jyPN1GmcCm4ZZEdt
         4wp1j1VAcFCLQlHuc8QwchpHNotC8Fsb6vvcYZXK64Ev2flHJ0At33/TQ8RVLzXCYtHh
         M7Rg==
X-Gm-Message-State: AOAM5309Vdy7k/CQGrm9YpKIwZxvT5S0p0HfzMisXt/C7Utf7Wc+SkjY
        dc+JBmJSqGm9fvnorbb5SOHJyt4d9vw=
X-Google-Smtp-Source: ABdhPJzZAPjTA1k3QpD88cSXykdVyoXBV5EN88/GFCNnn4/nLd5Bk2Rf0O2usYQsA6ur3nAVltUrRw==
X-Received: by 2002:a05:600c:154d:: with SMTP id f13mr30599455wmg.139.1625964400668;
        Sat, 10 Jul 2021 17:46:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm8568923wmb.40.2021.07.10.17.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 17:46:40 -0700 (PDT)
Message-Id: <7dc448df6ec6edb41464a4115017064cf41b2d83.1625964399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Jul 2021 00:46:36 +0000
Subject: [PATCH 1/3] doc: clarify documentation for rename/copy limits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A few places in the docs implied that rename/copy detection is always
quadratic or that all (unpaired) files were involved in the quadratic
portion of rename/copy detection.  The following two commits each
introduced an exception to this:

    9027f53cb505 (Do linear-time/space rename logic for exact renames,
                  2007-10-25)
    bd24aa2f97a0 (diffcore-rename: guide inexact rename detection based
                  on basenames, 2021-02-14)

(As a side note, for copy detection, the basename guided inexact rename
detection is turned off and the exact renames will only result in
sources (without the dests) being removed from the set of files used in
quadratic detection.  So, for copy detection, the documentation was
closer to correct.)

Avoid implying that all files involved in rename/copy detection are
subject to the full quadratic algorithm.  While at it, also note the
default values for all these settings.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/diff.txt  |  7 ++++---
 Documentation/config/merge.txt | 10 ++++++----
 Documentation/diff-options.txt | 11 ++++++-----
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 2d3331f55c2..31b96e8294f 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -118,9 +118,10 @@ diff.orderFile::
 	relative to the top of the working tree.
 
 diff.renameLimit::
-	The number of files to consider when performing the copy/rename
-	detection; equivalent to the 'git diff' option `-l`. This setting
-	has no effect if rename detection is turned off.
+	The number of files to consider in the quadratic portion of
+	copy/rename detection; equivalent to the 'git diff' option
+	`-l`.  If not set, the default value is 400.  This setting has
+	no effect if rename detection is turned off.
 
 diff.renames::
 	Whether and how Git detects renames.  If set to "false",
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index cb2ed589075..d030b936d1f 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -33,10 +33,12 @@ merge.verifySignatures::
 include::fmt-merge-msg.txt[]
 
 merge.renameLimit::
-	The number of files to consider when performing rename detection
-	during a merge; if not specified, defaults to the value of
-	diff.renameLimit. This setting has no effect if rename detection
-	is turned off.
+	The number of files to consider in the quadratic portion of
+	rename detection during a merge.  If not specified, defaults
+	to the value of diff.renameLimit.  If neither
+	merge.renameLimit nor diff.renameLimit are specified, defaults
+	to 1000.  This setting has no effect if rename detection is
+	turned off.
 
 merge.renames::
 	Whether Git detects renames.  If set to "false", rename detection
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 32e6dee5ac3..b5682b83956 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -588,11 +588,12 @@ When used together with `-B`, omit also the preimage in the deletion part
 of a delete/create pair.
 
 -l<num>::
-	The `-M` and `-C` options require O(n^2) processing time where n
-	is the number of potential rename/copy targets.  This
-	option prevents rename/copy detection from running if
-	the number of rename/copy targets exceeds the specified
-	number.
+	The `-M` and `-C` options can require O(n^2) processing time
+	where n is the number of potential rename/copy targets.  This
+	option prevents the quadratic portion of rename/copy detection
+	from running if the number of rename/copy targets exceeds the
+	specified number.  Defaults to diff.renameLimit, or if that is
+	also unspecified, to 400.
 
 ifndef::git-format-patch[]
 --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
-- 
gitgitgadget

