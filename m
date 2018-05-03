Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5695E200B9
	for <e@80x24.org>; Thu,  3 May 2018 17:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeECRPM (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:15:12 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:15932 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeECRPL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:15:11 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40cMGP1Nsvz5tlL;
        Thu,  3 May 2018 19:15:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 990443AB;
        Thu,  3 May 2018 19:15:08 +0200 (CEST)
Subject: [PATCH v2] git: add -P as a short option for --no-pager
To:     Git Mailing List <git@vger.kernel.org>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <23493ba1-1704-1e8c-f448-95540a36f886@kdbg.org>
Date:   Thu, 3 May 2018 19:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to configure 'less', the pager, to use an alternate
screen to show the content, for example, by setting LESS=RS in the
environment. When it is closed in this configuration, it switches
back to the original screen, and all content is gone.

It is not uncommon to request that the output remains visible in
the terminal. For this, the option --no-pager can be used. But
it is a bit cumbersome to type, even when command completion is
available. Provide a short option, -P, to make the option easier
accessible.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Given the positive feedback, I resurrect the patch.

 Changes since v1:
 - Use -P instead of -N
 - Commit message changed as proposed by Kaartic

 Documentation/git.txt | 3 ++-
 git.c                 | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4767860e72..c662f41c1d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
-    [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
+    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
     [--super-prefix=<path>]
     <command> [<args>]
@@ -103,6 +103,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	configuration options (see the "Configuration Mechanism" section
 	below).
 
+-P::
 --no-pager::
 	Do not pipe Git output into a pager.
 
diff --git a/git.c b/git.c
index ceaa58ef40..71d013424e 100644
--- a/git.c
+++ b/git.c
@@ -7,7 +7,7 @@
 const char git_usage_string[] =
 	N_("git [--version] [--help] [-C <path>] [-c <name>=<value>]\n"
 	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
-	   "           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
+	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
 	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
 	   "           <command> [<args>]");
 
@@ -81,7 +81,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
-		} else if (!strcmp(cmd, "--no-pager")) {
+		} else if (!strcmp(cmd, "-P") || !strcmp(cmd, "--no-pager")) {
 			use_pager = 0;
 			if (envchanged)
 				*envchanged = 1;
-- 
2.17.0.69.g0c1d01d9b6
