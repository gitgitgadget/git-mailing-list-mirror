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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17039C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD14613AC
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhGNBP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbhGNBP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:15:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EEAC0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:12:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so2836938wms.1
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MNOnbBeOkUpJMxxnamPv5ymuLy10eJ9TRLpHhuRAaiY=;
        b=Xcj07/LARBzAhmoTRCwhXoLkpQJKq+KGkdaz9A527DB83b6Pzuxy54BGsJNQA3GrA1
         EnW80mlniEj/RamNVQXVaXaBWadBq0JeHwA/GkVAFa/igeARc09mCJ0O0Aq7gft8uAek
         LraSebHR3m26Pya8G2Bgtj+SOsCIEcHJXhGTSgijBlCX3SslRjOGrNILmGh9AVMVm7zU
         zw3KwXBkGM6LdBpv0m2gAI+dBkbmbLL+aoCtGYWs4zKbFzPnc0VZQxF+Su2Gh1IZv8rU
         f+jVdaDgclhFB5e+1XDlvtOb1VtL0mzflpIgzZj56/6oGcNSWdMeW7z+7r1xbxfL6CFV
         78Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MNOnbBeOkUpJMxxnamPv5ymuLy10eJ9TRLpHhuRAaiY=;
        b=DdwMhdTsju1uCxkHecj91BqEqkD7YnK8O6YBEElRJ7AcZS26gmzcx0uTZcC7EvcEFe
         EyHgBwU1aExGr3ATNIlW+8swfTmGbYUZ24WXoG8OmEnZ4k32xt7GESNc6OvX8EQfRZ85
         k96G1S/Qk1hXIrBUrVb6PQ8Dh0s8EVKR5YstvNt9d3cdmLa1vyRaYeA41kI2E218gVqu
         KOio/kyXmSlQXLLXkp4iSFbYEBlgv0nQsQZIyMs7jvzAihfsD5HYhMsnYL4wXjGYu0Uo
         Xw0oeJBEFf5egUzGdwOIaXeBxTMTYcmOCc3/kfUa8jnpamjDN0LH2UVe+FtpPHdhZVlC
         UxyQ==
X-Gm-Message-State: AOAM533uaFsxyb00RuiUkiEzj4nunnLtPa48bMJ+ZlIg7CzdzVTkAQP4
        QBtx0OQOP5Sz+W0hwAvgZeSCIuxxmx0=
X-Google-Smtp-Source: ABdhPJwCLBulC2UX4Mpz3Vb/cUxszNn3TX+EUHDBCs0vtiRlIJY5FC6FQRi0RN1xVvjHngOaD8CziA==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr1009671wmc.138.1626225156180;
        Tue, 13 Jul 2021 18:12:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm500748wrx.59.2021.07.13.18.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 18:12:35 -0700 (PDT)
Message-Id: <4046993a9a2af79029c1ce94d20616831e94d786.1626225154.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
        <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 01:12:31 +0000
Subject: [PATCH v2 2/4] doc: clarify documentation for rename/copy limits
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
 Documentation/diff-options.txt |  9 +++++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 2d3331f55c2..e26a63d0d42 100644
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
+	`-l`.  If not set, the default value is 400.  This setting has
+	no effect if rename detection is turned off.
 
 diff.renames::
 	Whether and how Git detects renames.  If set to "false",
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 6b66c83eabe..aca0c92dbe6 100644
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
+	merge.renameLimit nor diff.renameLimit are specified, defaults
+	to 1000.  This setting has no effect if rename detection is
+	turned off.
 
 merge.renames::
 	Whether Git detects renames.  If set to "false", rename detection
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 32e6dee5ac3..11e08c3fd36 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -588,11 +588,12 @@ When used together with `-B`, omit also the preimage in the deletion part
 of a delete/create pair.
 
 -l<num>::
-	The `-M` and `-C` options require O(n^2) processing time where n
-	is the number of potential rename/copy targets.  This
-	option prevents rename/copy detection from running if
+	The `-M` and `-C` options have an exhaustive portion that
+	requires O(n^2) processing time where n is the number of
+	potential rename/copy targets.  This option prevents the
+	exhaustive portion of rename/copy detection from running if
 	the number of rename/copy targets exceeds the specified
-	number.
+	number.  Defaults to diff.renameLimit.
 
 ifndef::git-format-patch[]
 --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
-- 
gitgitgadget

