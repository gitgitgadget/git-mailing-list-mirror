Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D800C1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbcJNNUS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:57814 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754601AbcJNNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MBFBB-1c5Fcy2Bnh-00AIDU; Fri, 14 Oct 2016 15:17:21
 +0200
Date:   Fri, 14 Oct 2016 15:17:20 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 04/25] sequencer: future-proof remove_sequencer_state()
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <0ed2f56dac32bfc5fe1ef8eebdeb1ec4f13b2f47.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GACwyjPo0DWU5qVS5QtJ16Gnf/8mkvYnjhLNESPexwOMZ4yQ4xN
 dnjENxJg+iX6ClAi6ToMunTeSWBcilyjxiV5SY2/zmLv3ZpQpMhNapS/ZSrInxXg/MB/73C
 xFB2dRqXufDmTGrtYUiRHASIMSe55NUuz6uMBljB+iNOwDnnueuMUVGJdLi8v0cN28QCfd5
 N7QJS/kOb7qPfMIFkFJUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hLQYB9+7UOo=:T+fqneh7P/eZVhWn2U7Zas
 Dkj4PfVS2fkW1NzlxnaXZTOa7FS4J/DEiA6i/QLGSM44YUZPabjNbKBm/ujsiNKmUoJaXDKBk
 Bh8Gd82l2vbaFSGR3g/TYaBiULMuboKNOIU6/FZ9LcrxUCovoc9op0KSntjdZDMlnNrNtOGPy
 5pbf2MB+cjZklMARpTigTJFN+m87NWJjjOwFhgXiEuPZuWxSt0oNxWWbne5oHMFZzjrMDDAY3
 KbDaBWKRWnjSqetU7OScq2mksSnCX2RBcY/h41/1D9o0IXNdEEVG7db1Id+x2WKjXcW+2rVyL
 YJiPscqKWg1R3MNFB1V6cvK8ae1EOkv5JTJWfBcKjsh7EbgUZXkxunFUJ0wzr6pMIp5TuOjBf
 4gS6+WV6lxLHar6+YRN5Os3ZcbB55GA6jGKzF/ZsUxknSwHr52eKxpgn4Mb3KQlXzq9SVagMr
 Gn6yBFiLdcWqkR9vrxWEsgx211O//yeX5PUOsKlmta7ekt8s1GPUzn021Gx5LNLjDbeZKXmVK
 M7Bc3Ttyt87szzAPIUAp/lIpR/rgCXvywzk66UPpALJugt3c5tCdLgkKl1+Z3erH540nMhn9N
 kxJxb5V/pzEtkV1uLGB1UiT37SsLYF6gAqyOF80gtMoSkzJ3p6XCc5T/Fk9LMEy+eOd/QfVEq
 QsZrEgpLL1MJTaEVX7gNZuWwsq69vJ2cffy4KXslkIQdQRP5NCeTXgzQahi2+Ax1Mb33Lu84J
 L8ZqPgUHA5gDoAeO7B7rLVy/7CTXwfg+if2VLtOON+C7fH/k2FK+1+QWBBLm0W7ua4lhsPRMg
 OG7mKTi
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
2.10.1.513.g00ef6dd


