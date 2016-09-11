Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62579207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755787AbcIKKxO (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:53:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:55399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755762AbcIKKxN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:53:13 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LabZr-1bK7MW3Dln-00mOOZ; Sun, 11 Sep 2016 12:53:03
 +0200
Date:   Sun, 11 Sep 2016 12:53:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 04/25] sequencer: future-proof remove_sequencer_state()
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <d6b92cd7aa56ceb515c50467a0e6030401e2e1bc.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/16nCFVGKug7MUnMuMtks6rTe+31p5x/q5mAisujFNfhWBv8wHx
 2OvMHbX0V2FH1kGF/MoU76bUvHzVJ9C1buEVACoyTQSlzMUyWSfR4pNLB0VmFoZtXmOUjWy
 PsXteSoxxFSl1rEUAH3tv/poW9eU9WU3QyNpFPA/Ni5Vibma1kyU9MR994pjYPkIks89zcW
 d/cnRU2NQbVrb7W8b/yLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QZzE477mHko=:rIg4eaxBP0m3m7Tom3/Cw/
 1flbFbbbD1DH71mj2MUfR1zPatCRSd7sU0zW15JUkkxRQJmaqXjXO5t3+DIjouxtK3kfvJLKE
 FoaQMgyxKKH6voJ9gnZDS+Abv2+r2z/Zs74gCrs9EKKIZJzrlI2+l2lCgYDcpPUhGklCfqtQ2
 anQcORCczB6xl7regMRyb1EPsYnB09iGsOYYxcmJPy3AAS8qV2dJmwEbcwZCNWQQ2FuafyFz8
 5s1z5vw4BBGk3RkykOy4lYVfFqIhGOkZG9rPOlxAlMxXORQv1hTIXspL6pjCLmtxrH7D24Oq9
 4YW8jr7+FXAHJ7ozRXq9Lf66B+Ew0RRJQMZZryIaVMYpyHKClsUmE9eGI7on3qWP9rj+9DvV8
 GJ/+61xgcq6VDh73RZQCQ0aY0aKfhXPAf73WOQ4HkzgpySYnH4lTO5afI0+9Xdm0LFPv/44AU
 J5JZDOgUmXd7HFk2lnBOWf4Ocq15rBDtL8NVCWg9vL/keCLd0C+OzYsBQ4cnYD1+zlbqjTzRf
 aQbm3nBBDNC/yXyI6O/BIv2BkEurEb3ENF6WT4jjOuiQmP4Gasjn9UNzkK9jm/6JPgxblYB3W
 oNm56qhmOsTZJx+cvuRL/6ky2cJGyzBWV2RC+13In5x95WXkghz5ovNi4ZX0GzJKll4WNAJY+
 vBA2WFKZQOMQN8nTHSBgqVAmR+YPbnU7vNB4BRHXG86BoQ+h8XD/ehxHL6QE4vSwsQ4cygStD
 gJ2iDbj6HvVvevridQMdzGN7TpJb6sze5Z0mZN8GL+uhlkQkW7Yt6bKW2yUqkzufSdAnQiwNf
 +vt+RrS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a couple of commits, we will teach the sequencer to handle the
nitty gritty of the interactive rebase, which keeps its state in a
different directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c2fbf6f..8d272fb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -27,6 +27,11 @@ static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 
+static const char *get_dir(const struct replay_opts *opts)
+{
+	return git_path_seq_dir();
+}
+
 static int is_rfc2822_line(const char *buf, int len)
 {
 	int i;
@@ -109,13 +114,13 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	return 1;
 }
 
-static void remove_sequencer_state(void)
+static void remove_sequencer_state(const struct replay_opts *opts)
 {
-	struct strbuf seq_dir = STRBUF_INIT;
+	struct strbuf dir = STRBUF_INIT;
 
-	strbuf_addstr(&seq_dir, git_path_seq_dir());
-	remove_dir_recursively(&seq_dir, 0);
-	strbuf_release(&seq_dir);
+	strbuf_addf(&dir, "%s", get_dir(opts));
+	remove_dir_recursively(&dir, 0);
+	strbuf_release(&dir);
 }
 
 static const char *action_name(const struct replay_opts *opts)
@@ -940,7 +945,7 @@ static int sequencer_rollback(struct replay_opts *opts)
 	}
 	if (reset_for_rollback(sha1))
 		goto fail;
-	remove_sequencer_state();
+	remove_sequencer_state(opts);
 	strbuf_release(&buf);
 	return 0;
 fail:
@@ -1034,7 +1039,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	remove_sequencer_state();
+	remove_sequencer_state(opts);
 	return 0;
 }
 
@@ -1095,7 +1100,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	 * one that is being continued
 	 */
 	if (opts->subcommand == REPLAY_REMOVE_STATE) {
-		remove_sequencer_state();
+		remove_sequencer_state(opts);
 		return 0;
 	}
 	if (opts->subcommand == REPLAY_ROLLBACK)
-- 
2.10.0.windows.1.10.g803177d


