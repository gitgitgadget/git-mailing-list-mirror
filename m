Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E881C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4444560FE8
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhJHEf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJHEfz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:35:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2DCC061760
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 21:34:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls18so6600562pjb.3
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+FYwPSyDbcb0pHA1iUp4Pr1mLIZcQF/N65x0z0Kn1k=;
        b=V8Zev6dijAsSr/GX2oz9ZwdC4MBDPQ2tUj71DfPKZqBjYsh9kJilJW1VoWHIVijH5O
         6VE8XFD+qn58oTJ6k4bb1OvMRWi7BSvlI+x3F1vDlHAZ7VnTqDOJovb4m5ofRt0adBNI
         3V2UTeRJUgF2/ySRD1H1aLNH/gmvLVUpvViR/JlvkZHlxBc3C1XN45rP0YTtYPpjMDVd
         IzyyF+f0iuq5uoLan0c9+Kq4E7gXiOf9C/vqB81IM0IZ43sMCI7plnFbvi5aSPv/GYF0
         DcN8jyLmGcTQF+9cxEOJlNUd9OrszZyMbvyu5uP38kxSBrOz3+Yx2P6uXRY0r2gzioVd
         qkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+FYwPSyDbcb0pHA1iUp4Pr1mLIZcQF/N65x0z0Kn1k=;
        b=PxbSyDULz+jItq3O6BgZpWqCtrbCEgjeQjB1KEwI9621KoBvE3d7CdNd7tktYc5mMg
         I1qLrIkP+foZkpWw9VdOwKYof/l/LUHS7m3em6fdW2jlcOpgLjcgsj8VgQQHvOjoyGB3
         Sabh1xS1P+g/1j4nW6heVT713klj7A/+Q/vpiartsEITO6iQyn55TbpXQSHja+MapzP+
         qIx6r/ZWRGVQyomd/3GhMbjioQNY9UwDp0IJLkkNnziNBGYIUuhIfjw5RRwuz5UGTiaY
         X/nKV4gQxuhWxpc0EcQStsAGIS53BNpUuDIb+icAN7q0AqwZz7WtIwNVh3acycIDvanZ
         CCsQ==
X-Gm-Message-State: AOAM532SVa5o9UO3xaQpiyMXfI8vTlQGOFsR7eidO+joSsqWNViZEbTF
        UNkNE1PYotjQOs+b4beNh18Ho8AOL37XE184
X-Google-Smtp-Source: ABdhPJyU0dj7GPkdDabcXDZR7cuQTt/gnqYk6OCn9HJ5E3CFuhgxCIlTJJ8+pEG2hmBtac/e/zCiJg==
X-Received: by 2002:a17:902:d70b:b0:13d:f465:9ef1 with SMTP id w11-20020a170902d70b00b0013df4659ef1mr7361100ply.44.1633667640642;
        Thu, 07 Oct 2021 21:34:00 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-82.three.co.id. [180.214.233.82])
        by smtp.gmail.com with ESMTPSA id k14sm870845pga.65.2021.10.07.21.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 21:34:00 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] blame: document --color-* options
Date:   Fri,  8 Oct 2021 11:33:43 +0700
Message-Id: <20211008043343.189651-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008043343.189651-1-bagasdotme@gmail.com>
References: <20211008043343.189651-1-bagasdotme@gmail.com>
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

