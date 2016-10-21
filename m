Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7220120229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbcJUMYR (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:64833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754387AbcJUMYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:15 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M1nbu-1clo6V2Lxy-00tit9; Fri, 21 Oct 2016 14:24:09
 +0200
Date:   Fri, 21 Oct 2016 14:24:07 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 04/27] sequencer: future-proof remove_sequencer_state()
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <45451bc8b0bd49a1de83ab5c32e2b4f5b63a2df5.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g9ZXHX5GjO1INiMAfzVmul8kjejfI1ZkZvVgPt2w3A8+7XaWrYl
 NzRHy/0K0HYAQz2BAei8VFC8bro9aJPpgTt0oR1fJWC73svcJ9XIceAHFDLFjFtojvad9JB
 mnQf6M8aL+dRMfds1XIr5HIJPICrAH8JAkQPHETBQD72vXQNUBuKa8Q3MMPqwdpv3Askz/a
 dsSgA0XnnIPxsED25b3wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dbAAjb1S9ek=:2UtbRoPHU9TXpNqjEpO1RB
 F99RXSUvlwRqzUKGubPLT1jHc3jPU3N6JbguY0PtkN7BZgU8QdDNdk9y2fAXoksyYihqpJuIo
 svkiDr9lKnIp7niRCmqb3hnepZFZxz/ElWtBaCNQdI5igKIzrxiAmhQ9EuHXKZLOmSVFK2wcI
 dkmyIkXobcGY8UQH6618kjalYLc5c0cVBNB6dRCmVKENW4tGiBME9+qTquvGpW8YoQ8WCr+N1
 Fr3mKniKoN+UaAew4eXmp+nT4W+BA5UZV6gL1vC8hHq9+AUpAVPZ4bE61FNHsukn91kugyJ0v
 iVOBMQwPlg9rZwcyCoLOVAj+Ir+IPCfG4yfppO2zGoTVMEWpbkE+upjNqOOXp5snVsHueGW5a
 H2wEqely096GycpNo9NL/4v24DwWrfDx2u5CH/DwVKr9XFLq06lyUA1gEOojvtCqCV8em1uY2
 qIosWm+XddT6/2qPf79mlHqftVdL8qLdao2p/UCvKcXGGwDg1W5sHj84cW+dr5DQjA62V5iay
 vWOYYLwMyhBzNrUWxnqvGP0u2w/pJNNLTQcvp5Xj5VgFgMc+F6kLxOIW/bW8l8Dba8eoLk2QR
 6YJMIBUy8UbWavQYgL5PODBKXXfDaOgjERZ7td/XItYYKyPi0tYnS6DuLP4a9h6tcIHW4uHkA
 X/Bsb6mHhdK0cr3+7eUICU7xFR6ZEC5c3QnZ3nlDRcusTaXQ8q7P+EWwIwBjxUFqt9ys6n+9l
 BHARJnyEaxHz5drI/2Q3NzngOOKb0kUr4UhYMI8NRQ5dmmgcA4YxUH0huVgzeLmJl1XqYXO+S
 Pe0Z5g1
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
2.10.1.583.g721a9e0


