Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F7C433F5
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C6F6187D
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhJCK40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 06:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJCK4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 06:56:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C157C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 03:54:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so5813744pjb.1
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6A8C7Nmod9pO4UaeZfna3tQ6dntf2JkGuHXOjs79KfU=;
        b=PX+PJQ4+ttBfEkJLFf02S2AOH86iizMx68zmZBE1DoLbOGf9Qb5KVtlra18mBR0KzL
         /hiMW8d/wggRnJino2nxgEaJeH7JM5pELEM/o8jpVSZhBBlHjHWHjzaAGlxM97wtcsfg
         kEaQmbTtzzu7F7razqrS0Nn5xVaNwCv7vPy96nwoAgIUA64qChwU6F6qCxeN3bM7951D
         EGrwtMreJzy+rdpTEk1xTmmeccBB/LGZZ8tJ6DYX47lIDuDqIdQZ3BlG4vhyMI6VtV/s
         IK07jtHkt9HHk8iFESVZZnDDsrJD/iz7Uvl4zeo6UFbC5JuNqTsEVW+Gzuu5Md3jW00R
         w3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6A8C7Nmod9pO4UaeZfna3tQ6dntf2JkGuHXOjs79KfU=;
        b=oMoVmio3f1sH+ryvZUsQ4z41vvAuhMGyCh9zAf8QxoxnIlNfYLy2CVX9o/Y2Rev6rw
         bise+2hOHG0JoK0J77YwZLyG53ruGyd3YWG7iJ0lLqiqzbpC56fXWBHxXoSPPL1bTGiw
         sR2KWFXPRlXsxLEIkQrsx9ytSgN794Q0JoyTdnA8SgJIDlMImQE9HEN/cWngh7Ivy+eh
         5h1nR7E+2fcjC9lMys1BLDBW+J+kzt6K0cS6NvJVZ0do5696O85PGX1WXrxfkPXKGt9j
         Gtj5ZpAsVZprR7XJ5RcwOEPCgvJ0IkUGJG1CPWAKwJtvbE4G+qgECES4ixyIV715jn++
         Y7lg==
X-Gm-Message-State: AOAM533MeNu3CniVua1gMWg9/68nxx7QJeqT4URUsr/6WI5rg6KA7aBO
        lgQWz5CXWEi0jJ5mKVdoazLzx3W0fO3wYQ==
X-Google-Smtp-Source: ABdhPJwtUHJbfpgAb/ovCPeOLxMHg7zCjeleQIH46XYjuzW1wOfUhswmBy3Jdw47fsdjRPXFbTNvug==
X-Received: by 2002:a17:902:7e4b:b0:13d:b90d:cdc1 with SMTP id a11-20020a1709027e4b00b0013db90dcdc1mr18456437pln.72.1633258477879;
        Sun, 03 Oct 2021 03:54:37 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-29.three.co.id. [180.214.233.29])
        by smtp.gmail.com with ESMTPSA id u1sm11263163pju.2.2021.10.03.03.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 03:54:37 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v4 2/2] blame: document --color-* options
Date:   Sun,  3 Oct 2021 17:53:28 +0700
Message-Id: <20211003105327.215996-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003105327.215996-1-bagasdotme@gmail.com>
References: <20211003105327.215996-1-bagasdotme@gmail.com>
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
 Documentation/blame-options.txt | 13 +++++++++++++
 Documentation/config/color.txt  | 33 ++++++++++++++++++---------------
 Documentation/git-blame.txt     |  4 ++--
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 117f4cf806..3972cc8cef 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -136,5 +136,18 @@ take effect.
 	option.  An empty file name, `""`, will clear the list of revs from
 	previously processed files.
 
+--color-lines::
+	Color line annotations (see "The Default Format" section) differently if they
+	come from the same commit as the preceding line, and if neither `--porcelain`
+	nor `--incremental` format option is specified. This makes it easier to distinguish
+	code blocks introduced by different commits. The color defaults to cyan and
+	can be adjusted using the `color.blame.repeatedLines` config option.
+
+--color-by-age::
+	Color line annotations (see "The Default Format" section) depending on the age of
+	the line, if neither `--porcelain` nor `--incremental` format option is specified.
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

