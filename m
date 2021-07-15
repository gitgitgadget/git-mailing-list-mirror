Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF2C47E4B
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5DA613CC
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhGOAsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhGOAsV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 20:48:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51738C061762
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g16so5420097wrw.5
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JMMMy0Fcyl8mCDG0H/yyawYs8tnD7kR/OH3f55UMsV8=;
        b=avxo3TpIFnyEK7zYIFFxiJpluE272vtuPHUnMXAH4b8SWQVE8y7rOT90qBaknfeTRO
         RjmS+iDnxh+19VYp4JVRZ3Unyv69sZK2TwHkuwMWI4bdJPYohseNgUjG7beLBSlSYFxQ
         y480u1vufGBe3LNIQAwileERDiP3TrTlKO5xhIjqXGUMqpJjC5vVnhcIaZef84ZPayqD
         ZfXlxHcZQPxX4tPNSayR3K9AKAPEivHR5KC+jBvkbVmI/eQs5IBHfvIjzFjz9AOIUhXp
         qm0DbSFlCjBpGlFwpexHyOZ728NpiDCjriG+/4xiBn163Dw8jDq26AxwD4EDepevxQ6f
         EVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JMMMy0Fcyl8mCDG0H/yyawYs8tnD7kR/OH3f55UMsV8=;
        b=njYUMqv7bLPQ6EDmBEo9KSDTPoLvKWQehMicHlTHpWdmmGZ/DSNVW2iyLsxUVf3dNC
         S0CUSM2pWHIQrt0LuJvylcFJU26V8jk8tDIA0/+aQe9Nm/O2iG3XVd+W/y1DW5J67aFF
         yuzqqn532rej2iMEgJpMvVsQTqwpqvmA+e1gdZHKrzbBaF8KHHwenp+SwGToS5BeOA8L
         n2YHvTR4mLTk6VgCnr2Xkt2w64yTrPKXHXgXJegmXCc6w/RK4Ac5RcNFKiFw1M/fF1yo
         FFOy8PJFdFTQQaw+PDNJTHi0nTWfjBctXa7fGqivPtgDsykF5xIX7+jTq0nx7PpdU+Pq
         P2zA==
X-Gm-Message-State: AOAM5334B5K3JoiKa7oxNmnp7rxlhcrqFKXolvydUkitKUf9+l6+FWPp
        J/kPzeUH925bn/CIG3DFjBN0CShBNA4=
X-Google-Smtp-Source: ABdhPJwfPjoOYAt3pWxsRRsLX58zo9WKe9E42c2toFCAKL1LKWE0TlNhl4ZzprgXkv794Q0oS4Ss/Q==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr889417wrv.123.1626309926836;
        Wed, 14 Jul 2021 17:45:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l34sm7623926wms.45.2021.07.14.17.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 17:45:26 -0700 (PDT)
Message-Id: <193385d7ca11f5af74b88164062a9220956a5aaf.1626309924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
References: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
        <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 00:45:22 +0000
Subject: [PATCH v3 2/4] doc: clarify documentation for rename/copy limits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
 Documentation/diff-options.txt | 15 ++++++++++-----
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 2d3331f55c2..d1b5cfa3542 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -118,9 +118,10 @@ diff.orderFile::
 	relative to the top of the working tree.
 
 diff.renameLimit::
-	The number of files to consider when performing the copy/rename
-	detection; equivalent to the 'git diff' option `-l`. This setting
-	has no effect if rename detection is turned off.
+	The number of files to consider in the exhaustive portion of
+	copy/rename detection; equivalent to the 'git diff' option
+	`-l`.  If not set, the default value is currently 400.  This
+	setting has no effect if rename detection is turned off.
 
 diff.renames::
 	Whether and how Git detects renames.  If set to "false",
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 6b66c83eabe..7cd6d7883b6 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -33,10 +33,12 @@ merge.verifySignatures::
 include::fmt-merge-msg.txt[]
 
 merge.renameLimit::
-	The number of files to consider when performing rename detection
-	during a merge; if not specified, defaults to the value of
-	diff.renameLimit. This setting has no effect if rename detection
-	is turned off.
+	The number of files to consider in the exhaustive portion of
+	rename detection during a merge.  If not specified, defaults
+	to the value of diff.renameLimit.  If neither
+	merge.renameLimit nor diff.renameLimit are specified,
+	currently defaults to 1000.  This setting has no effect if
+	rename detection is turned off.
 
 merge.renames::
 	Whether Git detects renames.  If set to "false", rename detection
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 32e6dee5ac3..58acfff9289 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -588,11 +588,16 @@ When used together with `-B`, omit also the preimage in the deletion part
 of a delete/create pair.
 
 -l<num>::
-	The `-M` and `-C` options require O(n^2) processing time where n
-	is the number of potential rename/copy targets.  This
-	option prevents rename/copy detection from running if
-	the number of rename/copy targets exceeds the specified
-	number.
+	The `-M` and `-C` options involve some preliminary steps that
+	can detect subsets of renames/copies cheaply, followed by an
+	exhaustive fallback portion that compares all remaining
+	unpaired destinations to all relevant sources.  (For renames,
+	only remaining unpaired sources are relevant; for copies, all
+	original sources are relevant.)  For N sources and
+	destinations, this exhaustive check is O(N^2).  This option
+	prevents the exhaustive portion of rename/copy detection from
+	running if the number of source/destination files involved
+	exceeds the specified number.  Defaults to diff.renameLimit.
 
 ifndef::git-format-patch[]
 --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
-- 
gitgitgadget

