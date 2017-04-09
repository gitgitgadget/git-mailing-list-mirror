Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A3E20970
	for <e@80x24.org>; Sun,  9 Apr 2017 02:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbdDICcX (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 22:32:23 -0400
Received: from vps.dannysauer.com ([72.4.146.113]:43009 "EHLO
        smtp2.dannysauer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbdDICcW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 22:32:22 -0400
X-Greylist: delayed 650 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Apr 2017 22:32:22 EDT
Received: from humpy.home.dannysauer.com (home.dannysauer.com [50.44.186.177])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "mail.home.dannysauer.com", Issuer "Danny Sauer" (verified OK))
        by smtp2.dannysauer.com (Postfix) with ESMTPS id 8804C789C011;
        Sat,  8 Apr 2017 21:21:31 -0500 (CDT)
Received: from krieger.home.dannysauer.com (unknown [192.168.0.150])
        by humpy.home.dannysauer.com (Postfix) with ESMTP id 8C1AD20807;
        Sat,  8 Apr 2017 21:21:30 -0500 (CDT)
From:   Danny Sauer <danny@dannysauer.com>
To:     git@vger.kernel.org, danny@dannysauer.com
Subject: [PATCH] Make git log work for git CWD outside of work tree
Date:   Sat,  8 Apr 2017 21:21:28 -0500
Message-Id: <20170409022128.21337-1-danny@dannysauer.com>
X-Mailer: git-send-email 2.12.2.576.g4455b18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make git log's `--use-mailmap` argument works if the GIT_DIR & GIT_WORK_TREE
env vars are set and git is run from outside of work tree.  Without the
NEED_WORK_TREE set on the log subcommand, .mailmap is silently not found.

Signed-off-by: Danny Sauer <danny@dannysauer.com>
---

Notes:
    I'm not entirely sure if this is the best way to fix it, as my git
    internals knowledge is pretty weak. But this /seems/ reasonable to me, and
    passes all of the current test cases.  If there's a more appropriate way to
    make `--use-mailmap` work properly when `git log` is run outside of the
    tree, I'd be excited about the opportunity to learn. :)

 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 8ff44f0..e147f01 100644
--- a/git.c
+++ b/git.c
@@ -440,7 +440,7 @@ static struct cmd_struct commands[] = {
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
-	{ "log", cmd_log, RUN_SETUP },
+	{ "log", cmd_log, RUN_SETUP | NEED_WORK_TREE },
 	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-- 
2.7.4

