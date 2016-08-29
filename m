Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1D71F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756678AbcH2IEk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:04:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:52836 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756487AbcH2IEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:04:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MCtLD-1bmE3C1UiB-009dn9; Mon, 29 Aug 2016 10:04:29
 +0200
Date:   Mon, 29 Aug 2016 10:04:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/22] sequencer: future-proof remove_sequencer_state()
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <2245e7db4d4c028f63b2f4c41097559f91756f2c.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RtGgO8bwERL404CaVZxRPfWN98goBNq/WQCfy/A/kI5D8Z2w5VQ
 cpkBLtm2531P2CUmNRIEAEYG0cuewesvj3JPY1gGghQieVf0NPZqrk7iwu8xkgeAXOz70Ls
 KXvK+5RpqVjuZBzK7PJ/M9GMAHURRcob4YdtQ4pCGNwhM9mh/+LR7Y7osTl0VX9aDmJYD5K
 gssjKpSZspj5CNum8zo/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FvXM4s38oUE=:lE0xUlGt0aOjSdvKlNWube
 mx4vPtAl5FoCbp8LDoxOwajySvr0Ly7NRFbHMmD5ZoaZZhRXzxfH7a600+nwuMYJ3pYp2utZX
 gSce9eVeKaDzfSrlF0ibIgAJ34PAnYjpBA+zaWPECOKI5MOfUW4k0KQpoTWhgFThbug/Dw2gb
 nB7+cxNpR/6ynQXeZq+ApoCKda4v3NS0Pz10WPMZMSDdUWxV7BSkHVndz5NNOLzmdxiahIFTP
 JYeQzTVYvF4T2UrmOyzia7ySy7wD4wRxjLL/RrwUuoeFvy14bxJVzzZS/zzxsvCwU7wa9UFA3
 TzyLRKIFk9KFdegjUwfFysejLPi26hDtwZnsfEJC2QcsXKIApMfgbV0dKudQdY3PDkY59iXi7
 aBRcMvPGuzCHkSR+YloaVntMHcecG9R4p4mXyywZqNoU+5r09VBdckK7cUY2xZcuEqofuc4KW
 KUxPKUqQPYWfmPGCR3x9ldYh4+T8jX7wFLUnuU1+dxSTUKPO4MqAS6EdbO36AbKFFvv1vWoDf
 ZRBMTN+SGFVLy7O4F+ZuJxxUtcm0gJEoFc4h1aC3m94CRMS9Xdoh/MYKgeW8wl1B0VQhWM2f/
 NClMWhQnOVmvK+kbd1OwlihJ7DVRXNQ7T2XeXJa0XTMl1y5Q8ECBsYi33OlxqZyZEiIck7PW7
 LbdyY95IzheqVJLys9E3/4U7O6EvHt7UvMkqbq+B06OwhZZuTDDjz0DBJJUMOO8Mef6GRZXf/
 ayQa2hHxhSLE6GoTIMwcORuSLrn/3kKG7ZfyJili9S5hp0vZEg87okMeeo3y+FdKyLNxp9K3n
 Sry6uQ4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a couple of commits, we will teach the sequencer to handle the
nitty gritty of the interactive rebase, which keeps its state in a
different directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 14ef79b..c4b223b 100644
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
@@ -895,6 +900,9 @@ static int sequencer_rollback(struct replay_opts *opts)
 	unsigned char sha1[20];
 	struct strbuf buf = STRBUF_INIT;
 
+	if (read_and_refresh_cache(opts))
+		return -1;
+
 	f = fopen(git_path_head_file(), "r");
 	if (!f && errno == ENOENT) {
 		/*
@@ -924,7 +932,7 @@ static int sequencer_rollback(struct replay_opts *opts)
 	}
 	if (reset_for_rollback(sha1))
 		goto fail;
-	remove_sequencer_state();
+	remove_sequencer_state(opts);
 	strbuf_release(&buf);
 	return 0;
 fail:
@@ -1018,7 +1026,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	remove_sequencer_state();
+	remove_sequencer_state(opts);
 	return 0;
 }
 
@@ -1079,7 +1087,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	 * one that is being continued
 	 */
 	if (opts->subcommand == REPLAY_REMOVE_STATE) {
-		remove_sequencer_state();
+		remove_sequencer_state(opts);
 		return 0;
 	}
 	if (opts->subcommand == REPLAY_ROLLBACK)
-- 
2.10.0.rc1.114.g2bd6b38


