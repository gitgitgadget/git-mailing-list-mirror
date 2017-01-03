Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44831FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 16:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935227AbdACQD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 11:03:29 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:41049 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759516AbdACQBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 11:01:52 -0500
Received: from [217.91.110.92] (helo=localhost.localdomain)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:AES128-SHA256:128)
        (Exim 4.84)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1cORQp-0002Go-Nd; Tue, 03 Jan 2017 16:55:23 +0100
From:   Marc Strapetz <marc.strapetz@syntevo.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>
Subject: [PATCH 2/2] stash: --[no-]include-untracked option for create
Date:   Tue,  3 Jan 2017 07:53:56 -0800
Message-Id: <20170103155356.11213-2-marc.strapetz@syntevo.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170103155356.11213-1-marc.strapetz@syntevo.com>
References: <20170103155356.11213-1-marc.strapetz@syntevo.com>
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expose internal option to include untracked files
for the stash 'create' subcommand.

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 Documentation/git-stash.txt |  2 +-
 git-stash.sh                | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2e9cef06e..cc7944e59 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
-'git stash' create [<message>]
+'git stash' create [-u|--[no-]include-untracked] [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
diff --git a/git-stash.sh b/git-stash.sh
index c6b9db694..16f5fe93e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -10,7 +10,7 @@ USAGE="list [<options>]
    or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
    or: $dashless clear
-   or: $dashless create [<message>]
+   or: $dashless create [-u|--[no-]include-untracked] [<message>]
    or: $dashless store [-m|--message <message>] [-q|--quiet] <commit>"
 
 SUBDIRECTORY_OK=Yes
@@ -629,7 +629,17 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$*" && echo "$w_commit"
+	case "$1" in
+	-u|--include-untracked)
+		untracked=untracked
+		shift
+		;;
+	--no-include-untracked)
+		untracked=
+		shift
+		;;
+	esac
+	create_stash "$*" "$untracked" && echo "$w_commit"
 	;;
 store)
 	shift
-- 
2.11.0

