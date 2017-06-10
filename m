Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF9A1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 08:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdFJI4D (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 04:56:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35949 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbdFJIz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 04:55:59 -0400
Received: by mail-wr0-f193.google.com with SMTP id e23so11229266wre.3
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 01:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MIjAL3HDmEVRHWLBxmZi0AZl2zf8ClHnoOTNiQGq9sU=;
        b=WOXG1ZuXQMT+hFFMcQoFEry18r7B4n7qawS0EBEv5nicfLgpcVTGZiSfdPMxfkStXz
         tov/iNW+2AhhMMiTEe6KfsWN2gREWB+xZVtjm9xKHhOioahADpV/PzHO3l4x4wSrjCf9
         PRHVl1paLqyPY+fwh9ydaJh6K+A/+NY2/Vl1Xc0zPAkZRqal3kAu7r4nRDTlEWjdmEX7
         G/BRmakJzAm7E2XYtLwpn3PVUBf2YS1QoTRi5K/ueJGFXD+gEwJXIV55+Kp08RXKQK+z
         MnfYQ6ud6Iu3zdBLvy8GLxyfiZEakMu8C6l7W+mhDz1wNVo/CoSrtCRjcZxpnze0Vy20
         I+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MIjAL3HDmEVRHWLBxmZi0AZl2zf8ClHnoOTNiQGq9sU=;
        b=hP3zv3GpueSsnVWIlwBt97PmkXvc/wa7jrNY201zQG4GGx1LMecbbfft6K3BfGlWLw
         VuERq7Rhdx/oTCmD4dBxLJP5IJDaWJ8u107dl5//DgtvbQjejduYdPNourd+F27E2Mnq
         sbNWuaiXsMbhhvx0o8OXdarQK/9xP+UIPV7u+Bc0QNbln8yBRJ10TDP22M7hhgobzxlN
         pCtRl7AI04uA1bhsCPf5GJ8XmlmyMoIOeQ4GslO7gj9htGRAA7ceXZlYUCnlM3dMyHnZ
         fSFi/LmOZ+LvNLmnkJNEq2l3XYTcspBCiUUwLKD0SM3zf5F2CwNsuaBEi2yQ4sBllym4
         m57A==
X-Gm-Message-State: AKS2vOwOz5+FGr0Uny4Lqww23yIZ/WNIbVEqh1TMoypEmb7foeaCPQEF
        EyBCfKW4tIWU5Q==
X-Received: by 10.28.141.131 with SMTP id p125mr696886wmd.66.1497084958056;
        Sat, 10 Jun 2017 01:55:58 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3439:7300:99fb:6818:11d2:739])
        by smtp.gmail.com with ESMTPSA id 47sm3716544wrb.55.2017.06.10.01.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 01:55:56 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v2 1/2] add setup step to filter-branch
Date:   Sat, 10 Jun 2017 10:54:44 +0200
Message-Id: <20170610085445.6470-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170603101755.13619-1-asheiduk@gmail.com>
References: <20170603101755.13619-1-asheiduk@gmail.com>
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
 Documentation/git-filter-branch.txt | 17 ++++++++++++-----
 git-filter-branch.sh                | 18 +++++++++++++-----
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 7b695dbb7..9e5169aa6 100644
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
 
@@ -82,6 +82,13 @@ multiple commits.
 OPTIONS
 -------
 
+--setup <command>::
+	This is not a real filter executed for each commit but a one
+	time setup just before the loop. Therefore no commit-specific
+	variables are defined yet.  Functions or variables defined here
+	can be used or modified in the following filter steps except
+	the commit filter, for technical reasons.
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

