Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE5E8205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933148AbdABPg3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:36:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:50711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933079AbdABPg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:36:28 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXIov-1c3KhU2JkL-00WHZg; Mon, 02
 Jan 2017 16:36:21 +0100
Date:   Mon, 2 Jan 2017 16:36:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 37/38] sequencer (rebase -i): write the progress into
 files
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <355835c0a42580b708683d1dc777d33026afc804.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4tKWaaEF575Z5X+rwSHoEy4KPt5fTgUXn2IovbX6+Be/Xa/gs8N
 0QIMIQtZdXPwyYTZ0766+2foD/TYaH2Hq0765CXTh+GKuGRtHjKjMXTGikgUxaNG0JwkDGl
 5xzSQVQJJpveoM9cfFQCsB7RGcRe0hzH3wHEjEq2jAYxsImFRFBsU3MSo89FpkaBkcGAxLy
 CyLyylrk5IRWHas5mqy8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mIWFj/wQuJ8=:+JyEN1Sd/1p2tRi6sRYhOM
 39nuv45cWhxW6GWmvRcS+mW/isO0q45krUh0dvNYoclnxl0SR0tQsv+qXrvYyLBS152QmPeFL
 Tf5wjNJqeL5viFNGpRWr4XYzD23GRSRYkvRb/qpNacuwA7N1qZiJ3pBgjPEnNa62bL0VXSLn1
 rPyNf0Cd5V2nUyGliafHlgg80PHce+asxE9RsgruTXjlSaKiHnpHnegY7hNAIUzyzMLlKkBoo
 tAKtfnIDi7ESfZmPlNs1XUx/8enhxYPPb/CPS7vXGjxjt15kYlX9gdYHBYv+pUyXrc101yyQw
 pFmk5jNnstHHwLos2GHtH7MOA73XwpohZmfUP7jq0HVSyL+SGhwqdp8Sbj/FjyGrpvJo6UMSm
 x2o7v1kAH0NFDfRysxbG1p1mXEootDx5I1zEvI6gk4JPRod0B5yoRtqQkt1D98XVwZaFEpx++
 e5ilWO4295E8DreXfdkLn3z+nwwRQYviXPJLo3Kyf+h/rWikxcNR3C76DVVb0PTBP/n5z5/LW
 e0zrSm6ZoYZ/sQeO3mspqgkZ9xtEXMRHzbCrkdx3UbdM9zYb5TiH2TVjAiIMiaaEfkeiJ1+xc
 DS6ldF5KiFmB/P79p0L9TBqCIcH3AUfF9IXHWsFEyHpk1mTnokbEB8VurmfXiwLJz8eGWj/Og
 UkClZ1Ar4E4fNkZiF+TOAkWONRalZeJkEfbKtX2fQ7EefY1BtKq/a/B6VVlldedLtWamMVsUk
 8+qEItanSyU/QsXBAYEpZmASpLcqVRMQVaxnWSSnaTO7WMc+xPsfgOnkaO6+nT3X/dKCB2p5i
 VY/Dkoz
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
index 2c9c555ab6..b39cd21e03 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -47,6 +47,16 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
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
@@ -1353,6 +1363,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 
 	if (is_rebase_i(opts)) {
 		struct todo_list done = TODO_LIST_INIT;
+		FILE *f = fopen(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
 				!parse_insn_buffer(done.buf.buf, &done))
@@ -1362,8 +1373,12 @@ static int read_populate_todo(struct todo_list *todo_list,
 
 		todo_list->total_nr = todo_list->done_nr
 			+ count_commands(todo_list);
-
 		todo_list_release(&done);
+
+		if (f) {
+			fprintf(f, "%d\n", todo_list->total_nr);
+			fclose(f);
+		}
 	}
 
 	return 0;
@@ -1947,11 +1962,20 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
2.11.0.rc3.windows.1


