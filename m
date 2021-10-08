Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E8BC433FE
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51BD61042
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhJHJSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhJHJSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 05:18:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32405C061755
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 02:16:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cs11-20020a17090af50b00b0019fe3df3dddso6921919pjb.0
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+FYwPSyDbcb0pHA1iUp4Pr1mLIZcQF/N65x0z0Kn1k=;
        b=WbrzIclTpol1lznlo7cktIBP1jMShBNi7LoDcCUjPvv8elzSL6PKNvMUFxd89v1gX4
         nliV1w+8HwdnZtZxP5AVwHawcp95B+pcY7X07lAjnb+2Cm86iXxPpmOxtScrpPG1T3/Q
         xG8AnQwUqSpiQiARHqoPWnZVogkTJBdA7GXY1R7f0xQF3ItU8fQi0mfgRjW6/H/IYxHm
         AJmUZiRjE+KikwzLM7ReoFElvIERsiWEVOJz+G2BtYE9grrHi0o4XLW3yjW4KJ6WKXOT
         q5MCc3ip+iYk5amIbpo79EL0uhd+l75VSm0Oto9hflOCLtZnDaRRTlk11XX/5M5L5QbD
         xT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+FYwPSyDbcb0pHA1iUp4Pr1mLIZcQF/N65x0z0Kn1k=;
        b=R+22lcaH6cqh6Oxx9hpnxmwuirkjMpyhniNc3k+v/CVxE7kvxyPr5mVIOsX39CxdKO
         WVmR9RwBTb7Hnr/ySCxWKnfK5YSdvlTfsdSAKMNAOEnejY7Iq1Z3D98j5Z+/JXW33iP6
         +xARBWZPEwKp2gaUB/oWEpKVM+8TQgZ3gIw71NHfYaWANDFA6vRer/5Ye2zdKn8WT8e7
         ByD4zTib0FBSUQoxThkGdeav1qoXj8zwWYHnqXFi6hg4jEdFf3osailS9Efnetx+SMEn
         +3PJxQo4lEPWGr4BvHulNv4YXWKgMBwXLdjioNa+bijCKgmvDP/Kepaz+cMT3yDOLouM
         4QwQ==
X-Gm-Message-State: AOAM533dY88+ASAI9gMo20AIDryu8rSEVe9ivKuLsf/9RMfa6yfSF8Db
        C0CHvmV7bl4i7Ng1LM8aS8Jm8Ek6X88=
X-Google-Smtp-Source: ABdhPJzbKSmP5azu5uvVLOKv9s7JJ8A8hn0arwkT+vXtRz/gpU9zQ67/50dM9EkHgKMSTQY2nS9+0g==
X-Received: by 2002:a17:90a:a88a:: with SMTP id h10mr10495403pjq.226.1633684594517;
        Fri, 08 Oct 2021 02:16:34 -0700 (PDT)
Received: from ubuntu.mate (subs28-116-206-12-49.three.co.id. [116.206.12.49])
        by smtp.gmail.com with ESMTPSA id q2sm10495908pjo.27.2021.10.08.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:16:34 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v5 2/2] blame: document --color-* options
Date:   Fri,  8 Oct 2021 16:16:14 +0700
Message-Id: <20211008091614.732584-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008091614.732584-1-bagasdotme@gmail.com>
References: <20211008091614.732584-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit cdc2d5f11f1a (builtin/blame: dim uninteresting metadata lines,
2018-04-23) and 25d5f52901f0 (builtin/blame: highlight recently changed
lines, 2018-04-23) introduce --color-lines and --color-by-age options to
git blame, respectively. While both options are mentioned in usage help,
they aren't documented in git-blame(1). Document them.

Co-authored-by: Dr. Matthias St. Pierre <m.st.pierre@ncp-e.com>
Signed-off-by: Dr. Matthias St. Pierre <m.st.pierre@ncp-e.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/blame-options.txt | 11 +++++++++++
 Documentation/config/color.txt  | 33 ++++++++++++++++++---------------
 Documentation/git-blame.txt     |  4 ++--
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 117f4cf806..fa3104d954 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -136,5 +136,16 @@ take effect.
 	option.  An empty file name, `""`, will clear the list of revs from
 	previously processed files.
 
+--color-lines::
+	Color line annotations, in the default format, differently if they come from
+	the same commit as the preceding line. This makes it easier to distinguish
+	code blocks introduced by different commits. The color defaults to cyan and
+	can be adjusted using the `color.blame.repeatedLines` config option.
+
+--color-by-age::
+	Color line annotations depending on the age of the line, in the default format.
+	The `color.blame.highlightRecent` config option controls what color is used for
+	each range of age.
+
 -h::
 	Show help message.
diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index e05d520a86..dd2d2e0d84 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -9,26 +9,29 @@ color.advice.hint::
 	Use customized color for hints.
 
 color.blame.highlightRecent::
-	This can be used to color the metadata of a blame line depending
-	on age of the line.
+	Specify the line annotation color for `git blame --color-by-age`
+	depending upon the age of the line.
 +
-This setting should be set to a comma-separated list of color and date settings,
-starting and ending with a color, the dates should be set from oldest to newest.
-The metadata will be colored given the colors if the line was introduced
-before the given timestamp, overwriting older timestamped colors.
+This setting should be set to a comma-separated list of color and
+date settings, starting and ending with a color, the dates should be
+set from oldest to newest. The metadata will be colored with the
+specified colors if the line was introduced before the given
+timestamp, overwriting older timestamped colors.
+
 +
-Instead of an absolute timestamp relative timestamps work as well, e.g.
-2.weeks.ago is valid to address anything older than 2 weeks.
+Instead of an absolute timestamp relative timestamps work as well,
+e.g. `2.weeks.ago` is valid to address anything older than 2 weeks.
+
 +
-It defaults to 'blue,12 month ago,white,1 month ago,red', which colors
-everything older than one year blue, recent changes between one month and
-one year old are kept white, and lines introduced within the last month are
-colored red.
+It defaults to `blue,12 month ago,white,1 month ago,red`, which
+colors everything older than one year blue, recent changes between
+one month and one year old are kept white, and lines introduced
+within the last month are colored red.
 
 color.blame.repeatedLines::
-	Use the customized color for the part of git-blame output that
-	is repeated meta information per line (such as commit id,
-	author name, date and timezone). Defaults to cyan.
+	Use the specified color to colorize line annotations for
+	`git blame --color-lines`, if they come from the same commit as the
+	preceding line. Defaults to cyan.
 
 color.branch::
 	A boolean to enable/disable color in the output of
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 08008f4a60..e03029fb99 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
 	    [--ignore-rev <rev>] [--ignore-revs-file <file>]
-	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
-	    [--] <file>
+	    [--color-lines] [--color-by-age] [--progress] [--abbrev=<n>]
+	    [<rev> | --contents <file> | --reverse <rev>..<rev>] [--] <file>
 
 DESCRIPTION
 -----------
-- 
An old man doll... just what I always wanted! - Clara

