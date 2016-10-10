Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E57320989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbcJJRY7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:24:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:59865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbcJJRY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:24:58 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LqzEB-1bF6Zh1xJL-00eZlo; Mon, 10 Oct 2016 19:24:54
 +0200
Date:   Mon, 10 Oct 2016 19:24:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 04/25] sequencer: future-proof remove_sequencer_state()
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <ccfa46aba51d553ce3841f9e9a2466c2174b12f5.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:k3MZz50FC29JUUJkoH85HUZLtUnBv6qyz1PlESdgBeEoD7ena9a
 i7FX6S9kz6ncuR1nHsKjtT0xLswWEKW3OXfzUP2FW6uhg9SyS4/fgQEkx6WOuuA0O0hlX3y
 xJxMZJay9X1NtvwaH6/cxZneMv2y8iesl59ncwpl5KGDoXdvrDSDvqC9AsWCoZEZ6wbI08v
 8v6TXNX26YCqHWuiIDV1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DtmEwitwW+8=:sBdcqXCClb4ierIbWvL13M
 gLrSnUVayJdugDm7xYFfPAeFHjTbHgag8plN3E/yQaV2Z1tv/K7f4TxqTYTj5zg+uI4vCTPn8
 kHjh8iB8JL6gjCs20MIw47N3nGrvPtBWnC0pOy5zSWpx6eMBcKr5OyOs8D+aAFv/FHJmWgCKL
 UNsP6VU/cVGYaqIu6e2UgEib5KYz8Nq243AK4YI19NcyW0yR48oawwPhQXZZmfHKg1eRnRqDE
 u3UwKdt1Ick/xq65P+GFhIiY5x7depmvDUIv+2DWGCNxPGs3+ZUkK3L6zPLWPVv/TisnevmGX
 kMsUD5S2J7rsxV52s10JAEieorPeipQQWINOz9DXs+4mXEZVQ3zNRVt3dJ31XJN4oru5sHosK
 /1cHoHDsYGIkPLH9hXt3V+vBxsYTNWeF9Zuo4caK6Z2FFJwJO0NxGkSEf/PzKWcMA5PvRe8lP
 uw1l6frQYJFPevSEjpG7cIIENE2EeuJsBZKF+DcTtvVte+BzJ29rfVqse15NYhE235Q4qAzzc
 IR0IljgNexnzZlI3aAB6+n256AE7lsq2la0/nutQqQFP9Ucc57BcZmLCdq2WaqRU0ajMTwYFE
 XwvvdvLWiYC8n3DUAWCHAMG5Tr3IljHgFwe4jyRbY6H3JOL1iHT5C0AGlpRWHoFqMAT2658R+
 Oywm6wdKMGXObhb4L9PuMIPKwBsU9Soq6vrVvNX46iAaipPEhZ8oj+efMfoFICe+JzKCJyjNe
 5MAFLQx+5LpL9ousSTbua76SoYVu8gqrHx31p7VAXks1eTh0Nm3OAdbemCHAEUlbd1zkXULIu
 4+X1+lk
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
2.10.0.windows.1.325.ge6089c1


