Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C75C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 12:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F6061390
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 12:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbhI2Mvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 08:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbhI2Mvd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 08:51:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2FC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 05:49:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso3893131pjb.0
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTqlFcsn6yudaNCMzML+hixJ+yQW3IJiHWjoI57J78Y=;
        b=be9VG7+ENDC4jVxoVgl+NRygRounHKOrCiHdqevQOkDZP7a/T99FYx5b5gewDHIK4d
         0FCDlbpkAAl0jNLv0g0s9675UeiDrTWIrgYm1N0UcDw8HNNMzEf1/n2klrfR0iZB9npH
         568ZtRxYkqiT+x6Xh3qz68Vidb/gc+i0kHpiL3Nv6EzDYVofBUnLQQZEXDRtDLOooYRO
         Hkv9apY4Dq4EviMpL0S8X5nAPNGyzHMiACaiKFSeZtFuIRAV2ZVp+COjzo0nRi4jXCtF
         IT/FU5pTOnZX6cFbtvGmN2MrKzpkLfXUjNw6d7sLrNp4IDcCyzt2CkSulPOeI07BT7kX
         NoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTqlFcsn6yudaNCMzML+hixJ+yQW3IJiHWjoI57J78Y=;
        b=fMSH5yCI8xopqrA8WdeKW6AJga27rkvC9+0+XDnG6rsk9qeCYwu9LSo32ucsf3kDf+
         Dj5wDz55bLHabvmC5F+Ejv74B9kN+g1xK8Lm6meoBZZ6RHF6s0OFWn5cjoGTYseHemQC
         WD416SLeDw0yOV+fKPnE/rPqJH5+8Ui7TEAheKtjkfZUGTEyau6+fs9Qo1qfgpX0nPeo
         +kt/BoRF4ZjTjsv7KAAAemP5F2u8aV6Azn+r7CUvtcHOJ6T7jlJlQLLKDTEAKDFysKnc
         jzO5Aw1oUz5e/T69W+2kbk73PJApHiuyUj28FWvIexV2gat+uBOjVZGn+7CGFdmnWNHB
         uQYQ==
X-Gm-Message-State: AOAM530nW75OHfGqZZNY3DxjcmmKWi6vlwOibOLzAalRQhshrJs7bR5d
        T5WJSePu9zzF/bVQRb3ntgC9ObsRqLP72g==
X-Google-Smtp-Source: ABdhPJz6eTZCcjm+z4NLcE6ffRInkNOwwAPDY/AJhOa2AF+k1ZRBA+zVVfAKeU/+Mfy7pWU6CutaMA==
X-Received: by 2002:a17:903:1d2:b0:13d:c967:c14 with SMTP id e18-20020a17090301d200b0013dc9670c14mr2747412plh.52.1632919791013;
        Wed, 29 Sep 2021 05:49:51 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-72.three.co.id. [180.214.232.72])
        by smtp.gmail.com with ESMTPSA id z9sm1974844pji.42.2021.09.29.05.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 05:49:50 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     "Dr . Matthias St . Pierre" <Matthias.St.Pierre@ncp-e.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>
Subject: [PATCH v2 2/2] blame: document --color-* options
Date:   Wed, 29 Sep 2021 19:49:35 +0700
Message-Id: <20210929124935.41917-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929124935.41917-1-bagasdotme@gmail.com>
References: <20210929124935.41917-1-bagasdotme@gmail.com>
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
 Documentation/blame-options.txt | 12 ++++++++++++
 Documentation/config/color.txt  | 12 ++++++------
 Documentation/git-blame.txt     |  4 ++--
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 117f4cf806..791214a3b1 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -136,5 +136,17 @@ take effect.
 	option.  An empty file name, `""`, will clear the list of revs from
 	previously processed files.
 
+--color-lines::
+	Color lines differently, if they belong to the same commit as the preceding line.
+	This facilitates distinguishing code blocks introduced by different commits.
+	The color defaults to cyan and be adjusted using the `color.blame.repeatedLines`
+	config option. Only the line annotation (see "The Default Format" section)
+	is colored.
+
+--color-by-age::
+	Color lines depending on the age of the line. The `color.blame.highlightRecent`
+	config option controls what color is used for which range of age. Only the
+	line annotation (see "The Default Format" section) is colored.
+
 -h::
 	Show help message.
diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index e05d520a86..b4c120d737 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -9,8 +9,8 @@ color.advice.hint::
 	Use customized color for hints.
 
 color.blame.highlightRecent::
-	This can be used to color the metadata of a blame line depending
-	on age of the line.
+	Used to color line annotations differently depending on the age of the commit
+	(`git blame --color-by-age`).
 +
 This setting should be set to a comma-separated list of color and date settings,
 starting and ending with a color, the dates should be set from oldest to newest.
@@ -20,15 +20,15 @@ before the given timestamp, overwriting older timestamped colors.
 Instead of an absolute timestamp relative timestamps work as well, e.g.
 2.weeks.ago is valid to address anything older than 2 weeks.
 +
-It defaults to 'blue,12 month ago,white,1 month ago,red', which colors
+It defaults to `blue,12 month ago,white,1 month ago,red`, which colors
 everything older than one year blue, recent changes between one month and
 one year old are kept white, and lines introduced within the last month are
 colored red.
 
 color.blame.repeatedLines::
-	Use the customized color for the part of git-blame output that
-	is repeated meta information per line (such as commit id,
-	author name, date and timezone). Defaults to cyan.
+	Use the specified color to colorize line annotations, if they belong to the
+	same commit as the preceding line (`git blame --color-lines`). Defaults to
+	cyan.
 
 color.branch::
 	A boolean to enable/disable color in the output of
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 284aa99942..2dafeb7710 100644
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

