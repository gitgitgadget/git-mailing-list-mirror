Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8374C1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759539AbcHaI4z (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:57960 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933451AbcHaI4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LnxVE-1bCG5F0cbA-00fyg6; Wed, 31 Aug 2016 10:56:45
 +0200
Date:   Wed, 31 Aug 2016 10:56:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 33/34] sequencer (rebase -i): write the progress into files
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <479efdc7e7c4f7bf92cce7a7033c5d27df9606ca.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NVll7/UjuKw8FqZmuvW0KYCoLSw+wpr1YMiMB6l+RMjgemKN70Q
 +O1dJwRvMhfEt0kJ0upYzqM8tMln46fJp3b+nV8HYuveK0SsBkPe0o8+3Rmn04TICOldJTP
 AldForwJoi7M3AKAsrNoSog5fctUyUR6TbSc+/ewn01UmoBfRfg7bMO80X39E2HjiHdPMiJ
 bxMFAKoILY4S6WF8rTJtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6/PgexTrZ3o=:O52D21HaLLIPT6a6WCCrfg
 UrRvUNoRfWxZDg8vtPnSg1l662uATvqM54LpGbiiqpBXSgI7Frob2pcnOk0hzU3DQk1Q2uv1j
 UGVXTeRsplm4OFo9OrQQOEsx8a/u77ei3TtK32e4qOVnvSMAcuVyRM/2hvihmk4l0EsIo4TXe
 uwrqcNLx4GvPFLTGbaysg0To/skpUCPLZ91YS/N8vjFmeqo6I5ITmA4nNH6LFN1faZs4t1CaY
 j4QvcNvkIzJxOLmU3NmSxvltf6DhAhpoj4K/nWq+yGLorD9a9Z4R1NBDh5g60i716vKxygDoQ
 z3PAiDzVlyc+HnERmMzM14WJhikq3uG9ECL/M45N8Fv1LVctRfury9uxZ2gaTPdFiYsB8mylD
 +u5eVSlBobYnJ80OE0985BmJAu/PRizRC8tv5YRibmxmrxxfudK0gPq4lVGisZMl2cURYDJI4
 AJZR6QCOBWI6FmO3NXcMDnhjtlgZbCm5GHGMm5K2XdU0BtCqOMZvLGAaBOaNjSGnQA3kbRwtG
 rokhdS5/fw791KEFsQbGoea7qO5a8vWSJ/Nh32pyv0KFLkX8Rqn8rTCiYryBuMr1FN2B2bDJe
 ItERtMgYbbE3rwc+0pI6Ne18GElh+Z5bYrtz/9wUH+DqEvG8O7qXf9V+HrTnDYYJ1+cMFw1Ug
 Cz0NY1PITO9mpZItlDZIFF1lg5kOvEjTxLRuYDNDTBmO/Lh+Jsogja0TLQpqnFZQO+8KS+yv4
 cyFhASiTnCt+1nzWjJeFHfCKqMBU1CTb8SEeGWCbl9gPog+rG9Us6en2iezqFJ1LqQbHiQtry
 otHlba2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the benefit of e.g. the shell prompt, the interactive rebase not
only displays the progress for the user to see, but also writes it into
the msgnum/end files in the state directory.

Teach the sequencer this new trick.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e8c6daf..9a8069e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -45,6 +45,16 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
  */
 static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
 /*
+ * The file to keep track of how many commands were already processed (e.g.
+ * for the prompt).
+ */
+static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum");
+/*
+ * The file to keep track of how many commands are to be processed in total
+ * (e.g. for the prompt).
+ */
+static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end");
+/*
  * The commit message that is planned to be used for any changes that
  * need to be committed following a user interaction.
  */
@@ -1370,17 +1380,22 @@ static int read_populate_todo(struct todo_list *todo_list,
 
 	if (is_rebase_i(opts)) {
 		struct todo_list done = TODO_LIST_INIT;
+		FILE *f = fopen(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
 				!parse_insn_buffer(done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
+		todo_list_release(&done);
 
 		todo_list->total_nr = todo_list->done_nr
 			+ count_commands(todo_list);
 
-		todo_list_release(&done);
+		if (f) {
+			fprintf(f, "%d\n", todo_list->total_nr);
+			fclose(f);
+		}
 	}
 
 	return 0;
@@ -1928,11 +1943,20 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		if (save_todo(todo_list, opts))
 			return -1;
 		if (is_rebase_i(opts)) {
-			if (item->command != TODO_COMMENT)
+			if (item->command != TODO_COMMENT) {
+				FILE *f = fopen(rebase_path_msgnum(), "w");
+
+				todo_list->done_nr++;
+
+				if (f) {
+					fprintf(f, "%d\n", todo_list->done_nr);
+					fclose(f);
+				}
 				fprintf(stderr, "Rebasing (%d/%d)%s",
-					++(todo_list->done_nr),
+					todo_list->done_nr,
 					todo_list->total_nr,
 					opts->verbose ? "\n" : "\r");
+			}
 			unlink(rebase_path_message());
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
-- 
2.10.0.rc2.102.g5c102ec


