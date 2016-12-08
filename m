Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083BA1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 15:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbcLHPgW (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:36:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:56867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750851AbcLHPgU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:36:20 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4WRI-1cZwo70wOa-00yiXQ; Thu, 08
 Dec 2016 16:36:15 +0100
Date:   Thu, 8 Dec 2016 16:36:14 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH/RFC 3/7] Mark builtins that create .git/ directories
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
Message-ID: <43a2d85a3bf92c9efacad722fafdbea77b409acd.1481211338.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pD8CbWOs9RoWjvLovHcFLXxTrLy0eT/+FRoL36Fex6SE8OuE2ZZ
 Gj0HK7owYs/xDHlummuqUT2qC5AiUdpkQDBWYVyDic7JWLiTSaZUtj80CLr0HbH1T2qWP0L
 q7izkcnqWa1Ai+HiVeSIcxmWLzVQKAGTY5GRfVbQjMA/IB9RXYYRL1gttFPQSoSjo3Xwy2t
 IHaj+O3IegS5di/OBFUSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SI4NJbBUWIg=:eXvm6QjZBs6xReWVE4wkX9
 1oV7Fxx43yysmN1/9XukvXYB5EMes6tmlvMZRZLBE7JsPg/KQ7xXor7dWmlXpqsTIJYa7he/E
 OzNGoW06iHlNoDsibJrWnnkhxfcVIMlTTqiBfLsosR0YZEyV7H63i8YKO/qCuRObr0mcOTpFN
 muYIkAiGyhsy33miKHi6YBVaaang8Nx6TpPY/iuItbSMWkUIpuZeDJWW5T3JuhY20nWi6NDlP
 agV9hHsXWiYNZN83qaTctjJfxx+yjOZKQRAUAjLduDW/409hfdyZfHtDHCN7DRje2rxw+VHax
 u+C3oDYlo1WFCaKCS6PMtoN4mHVRHPC2fKE4Qe6wmehot2gEKCdBXoZBHqUJ0FtOBUwtDt1UB
 0DtlVy4reqTka7HwFPGtoFITztDhkd1VlKbmPcFz8SvV1rJuVHjnxVbec1lztipVamix0Z2of
 2gUsunyBuM1jNw4njgHq4xQHegBRyImgZmlyyCgAHEXkCKiLSeYQcRdaC5UEnuVg9LsKZIEVZ
 6VG8jsLSPROM8VxTY8MZyQihKeuPwI1J/tOpaYvKAK329DCTS5hfSUN0z/7ZEHCkgKqI8uetX
 nW+ojEx70vya46OUMLJSWTtLVuAZi5V58t6SCWxHXcYiwFb8DrtfpKVWHoz0Xcg1X5wADPe/Z
 Jp+3kEifCZja89PfjFfyV97QZ0a1U1/ZBqs/agL/GTU0CTNtMIQ8JaW9h7tGbIP/5nmzGQz0Y
 peTAmmPdHQ+dr0NiPLZCiOqC7AfpGwIHpXm5Wftrns3UdO1gxqwljjP/K9/f6TQI7PQ0/EjL2
 ZPzl0C8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To refactor read_early_config() so that it discovers .git/config
properly, we have to make certain that commands such as `git init` (i.e.
commands that create their own .git/ and therefore do *not* want to
be affected by any other .git/ directory) skip this discovery.

Let's introduce a flag that states for every builtin whether it creates
its own .git/ directory or not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index dce529fcbf..61df78afc8 100644
--- a/git.c
+++ b/git.c
@@ -318,12 +318,13 @@ static int handle_alias(int *argcp, const char ***argv)
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
 #define USE_PAGER		(1<<2)
+#define CREATES_GIT_DIR         (1<<3)
 /*
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NEED_WORK_TREE		(1<<3)
-#define SUPPORT_SUPER_PREFIX	(1<<4)
+#define NEED_WORK_TREE		(1<<4)
+#define SUPPORT_SUPER_PREFIX	(1<<5)
 
 struct cmd_struct {
 	const char *cmd;
@@ -412,7 +413,7 @@ static struct cmd_struct commands[] = {
 	{ "cherry", cmd_cherry, RUN_SETUP },
 	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
-	{ "clone", cmd_clone },
+	{ "clone", cmd_clone, CREATES_GIT_DIR },
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
@@ -438,7 +439,7 @@ static struct cmd_struct commands[] = {
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
-	{ "init", cmd_init_db },
+	{ "init", cmd_init_db, CREATES_GIT_DIR },
 	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "log", cmd_log, RUN_SETUP },
-- 
2.11.0.rc3.windows.1


