Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C56209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbcJNNTE (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:50020 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932226AbcJNNSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:34 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MDyil-1cCN3d0tMF-00HMPH; Fri, 14 Oct 2016 15:18:26
 +0200
Date:   Fri, 14 Oct 2016 15:18:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 16/25] sequencer: support amending commits
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <48167f26c68728e7df42244b07a4f4e17f6105f5.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jD3HB8wFhxf+hleBFB31s57IcYc/1XD1INpBjLS4+o+4aatuBP5
 H2JOFyFAglAgfun9Hg1TvyEJOEX447khn7Aw2fkkd08CblURyZ8ZcdfNX1otEN0pdgnkHgy
 XGwyfjRT/kdD1TB7Zub/chZ2fcPl1c6MLLBotZ31mO369Z48/e2n+/877ZyUy7C8hhBlUPZ
 OF0KVV/4WeSq+wlvbSuPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1CbZF4fjMQE=:QqAH9MbrKAg/ZEy/qkmnju
 J9P4/79QNxjGUX/yV6AgLQbf4+r7Xwt68HzhAJ0EI/OtWcZaTPSntn6AQMfpCdveoBm4EMYrJ
 LAsjKahQM8fr8YbHM62nj/ruOSz2PRMTEPYJfpRH96hZF2fKCosFXPJojeLr/yXqplW8ZaW58
 6sx3TLddCtU9cijgFNZ66jJqN8nIYLKQIfhjyLjoUrRAVFF+r2BI4gBkLd1/MU24uXXX4qHpe
 /c1y70PbgAvkoC1tDjAUU4nJnEytqfvp4xU3kAu8vMZeXs8GEv65ZQguFI2goEvm84RiFNArE
 vnHEOVA/m4HuhiyUZPQtJKy+Halfi/wK57J1KoIQ8K5icYA6uReTgHYCyiXdbgFL+Ra09m4ja
 twkw+U7Y1VBfmiXH+ETTY9TU1vzZUE53QREdzfbBvZULuE2mChHy+Of84iUOb6NzPvl0yskcV
 3lA0B2mJ9yTGR+8E6xrQQCL2ZJa8hYqnnSuFcYkTAGM9ZLhXjfvB+DB+B9t9eT6k1pgOGbabB
 J96+FAd9KU8jHbe7Dgc5NmyHV0an3bY6wz6gylCgwBZ1v92GLNiu5Luc6E+U16lQppd8iBSnA
 WDiSfAedE2HnLMoc5prldWH4Scm3dMFgoo1zMEiQU1IgvMamNUyg6OIWG3P3CeYa4KLu2Az/t
 i3fJwl9jKj70RoCH2xOidTNnXr5WgSJtpDJffUZEk+d93y0xWjtye79hpU5KNqmRnzF4i7c6V
 +wUhf/odOe4f2sUPnW77LeWqRiXvH+QXS04YN07tEWSnUxAJ/TBbr03k8fhbs1D2oAmCY3Hjp
 rBMctS3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the run_git_commit() function to take an argument that will
allow us to implement "todo" commands that need to amend the commit
messages ("fixup", "squash" and "reword").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2ef80e7..fa77c82 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -481,7 +481,7 @@ static char **read_author_script(void)
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit)
+			  int allow_empty, int edit, int amend)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -510,6 +510,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
 
+	if (amend)
+		argv_array_push(&array, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
@@ -783,7 +785,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow, opts->edit);
+				     opts, allow, opts->edit, 0);
 
 leave:
 	free_message(commit, &msg);
-- 
2.10.1.513.g00ef6dd


