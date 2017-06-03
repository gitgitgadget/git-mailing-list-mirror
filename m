Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C10A20D09
	for <e@80x24.org>; Sat,  3 Jun 2017 10:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdFCKSF (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 06:18:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35538 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdFCKSF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 06:18:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id g76so3195650wrd.2
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cHnvqOTPO+ngJdkpXlG2nFKbcivwzpNq4BjoQDPBKDw=;
        b=SyYbfzQN0u06acV7fniio+XqSTcCJR0FCEXHQ5BHH4JmBAM42dhjniSuHr18ZRn3Yu
         PHTbfHAEJAwmaxh7B7AQOnFO5gIhlErEEqOcvMbrt+gG4TREMSAg0yz46KBfxiulAx4f
         VDcMl4KHA5E1wngHq6KEK+Amg/zt+YZ9WkK/t8P/q4KTj5ofSf9koVats5WWK0g6ReO/
         Swmpuyd0odU8WbrQIMnGNe6n1LUGCoNr64LCIV/BEo2wLe7Vx/3r7zPS5ashJirQfdHK
         B0SpMiU2qukKRyCFwDm02im99vTJ421ydCziSLzzuWvLdw4ujQP5S82LpWnbnqMauNau
         3d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cHnvqOTPO+ngJdkpXlG2nFKbcivwzpNq4BjoQDPBKDw=;
        b=bP5Mh4qh9yz6JGz7whhPedv9tPT0bP9HlgJiKfNkaCbncOGrFF5fGkS9HQLdz+MQAH
         PuUaa6xwM4mi35P144e+vE0TdhmBKzMCbqtjZs2yCKDjFenszaDQQiYhcAA0RnFvSzWL
         sDBxlelrFQJ+d1LrRG/mPHfkRBT5Tnl25ug0jf1L3hihWvfPOCxX6pcyelEH1fb54PZI
         lgzwwjKX/j6rqJt6d9dJncMNXrcTj3SnXxg0bUi4tewPawP4wXkgQiVKt/wyiDNqMYkS
         GUDudeZ7G64jaS6BLlSZjZrycVOfywQAziNaZER3rp5aRNMD+VJw3D01BDr1Me0mjhCT
         ri5A==
X-Gm-Message-State: AODbwcBqnG8p0uc8tDt9jfkQRj1ZSMjKUnfQo+OcMDqCEIFvxG0hk7Oh
        JT7kcePhAgfv+g==
X-Received: by 10.223.172.118 with SMTP id v109mr9643114wrc.84.1496485083702;
        Sat, 03 Jun 2017 03:18:03 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3405:6400:b08b:b890:381e:abd8])
        by smtp.gmail.com with ESMTPSA id z23sm14696819wrz.0.2017.06.03.03.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Jun 2017 03:18:02 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 1/2] add setup step to filter-branch
Date:   Sat,  3 Jun 2017 12:17:54 +0200
Message-Id: <20170603101755.13619-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A specific `--setup` step in `git filter-branch` makes it much easier
to define the initial values of variables used in the real filters.
Also sourcing/defining utility functions here instead of
`--env-filter` improves performance and minimizes clogging the output
in case of errors.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-filter-branch.txt | 16 +++++++++++-----
 git-filter-branch.sh                | 18 +++++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 6e4bb0220..45c849d8c 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -8,11 +8,11 @@ git-filter-branch - Rewrite branches
 SYNOPSIS
 --------
 [verse]
-'git filter-branch' [--env-filter <command>] [--tree-filter <command>]
-	[--index-filter <command>] [--parent-filter <command>]
-	[--msg-filter <command>] [--commit-filter <command>]
-	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
-	[--prune-empty]
+'git filter-branch' [--setup <command>] [--env-filter <command>]
+	[--tree-filter <command>] [--index-filter <command>]
+	[--parent-filter <command>] [--msg-filter <command>]
+	[--commit-filter <command>] [--tag-name-filter <command>]
+	[--subdirectory-filter <directory>] [--prune-empty]
 	[--original <namespace>] [-d <directory>] [-f | --force]
 	[--] [<rev-list options>...]
 
@@ -82,6 +82,12 @@ multiple commits.
 OPTIONS
 -------
 
+--setup <command>::
+	This is not a real filter executed for each commit but a one
+	time setup just before the loop. Therefore no commit-specific
+	variables are defined yet.  Functions or variables defined here
+	can be used or modified in the following filter steps.
+
 --env-filter <command>::
 	This filter may be used if you only need to modify the environment
 	in which the commit will be performed.  Specifically, you might
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index aafaf708d..2758ae5eb 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -81,11 +81,12 @@ set_ident () {
 	finish_ident COMMITTER
 }
 
-USAGE="[--env-filter <command>] [--tree-filter <command>]
-	[--index-filter <command>] [--parent-filter <command>]
-	[--msg-filter <command>] [--commit-filter <command>]
-	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
-	[--original <namespace>] [-d <directory>] [-f | --force]
+USAGE="[--setup <command>] [--env-filter <command>]
+	[--tree-filter <command>] [--index-filter <command>]
+	[--parent-filter <command>] [--msg-filter <command>]
+	[--commit-filter <command>] [--tag-name-filter <command>]
+	[--subdirectory-filter <directory>] [--original <namespace>]
+	[-d <directory>] [-f | --force]
 	[<rev-list options>...]"
 
 OPTIONS_SPEC=
@@ -96,6 +97,7 @@ if [ "$(is_bare_repository)" = false ]; then
 fi
 
 tempdir=.git-rewrite
+filter_setup=
 filter_env=
 filter_tree=
 filter_index=
@@ -148,6 +150,9 @@ do
 	-d)
 		tempdir="$OPTARG"
 		;;
+	--setup)
+		filter_setup="$OPTARG"
+		;;
 	--env-filter)
 		filter_env="$OPTARG"
 		;;
@@ -317,6 +322,9 @@ else
 	need_index=
 fi
 
+eval "$filter_setup" < /dev/null ||
+	die "filter setup failed: $filter_setup"
+
 while read commit parents; do
 	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
 
-- 
2.13.0

