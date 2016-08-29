Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12662018E
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756684AbcH2IGT (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:64941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932679AbcH2IGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MTwYX-1bV6cG261R-00Qgpj; Mon, 29 Aug 2016 10:06:13
 +0200
Date:   Mon, 29 Aug 2016 10:06:13 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 17/22] sequencer: allow editing the commit message on a
 case-by-case basis
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <96adba0eee05a7b2b46b726f7e231b6732e80882.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0LOar3ok0jrIqGdarD4S2R6ZySSDHyXM11vBN13pGBxCW88xwQx
 T+I1ADWnGO56eAeimdi6g+RcyC7DBuF4+afIIpXtZYaTY17wpRtUSw/e7zUdwUYEhwLtBVT
 QSMSDyGSLvro3t+q6lC8VNW99lHQg/7Q0gISSBQk8GmswYKk61dBqa3d/m4iIulNUJwemkm
 MGUKD4Os5LgOLOJIb8MLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ME3+JDdspdg=:CUon1y2NIEwOsQJy6pxpb5
 bqFUHqAeyJAw/Ss66rZt705k4kDu116NH4QaupIVBfLpLSgmFjsZQzrF5W0C+n+2SR9/tKP0k
 x8oZhkvZ4S44/T32tlCLn0YIeSY0BOe/tRKp/ai8+BKbM9uNauUke+FEQ2XPg573QjtJE2zz4
 PQHX5FZPtFpxRnXqxxCgAscyr5QdMUeUwX3wN4iC6Gyk6s9Z1a4FxF1uckRIeUp1ZNXa/RtCt
 EltxZS1jbhUMJ9B+ay02FbFa3Hrx9+rMEIxJbhIln/jIRenbwfq4a4qi6Dxi119UySqMqbPiB
 ibvVb/KtkzK+SS36rcX3inGy34EEHmgqY9qts3QjWlfOL/Vo9qpfa0EklaFGhXl1sj54SEB0y
 sHu5nUKqUTDqN7lzVt4fUqA4TwCmT7e/sb5+kLVRb3knerPT5X6THA+abSoPJ7lQvVQ1Kd4L9
 rVhlDLu7X7U5shpCVNUO2EdLqFvbpz636hvzBIsALPrQNxNjL5oYN96Paq9vieNTA1HFiwUHi
 ULtE09wwcwrKX1uVL8uaMW9GzHZwGT3kg8qs71hdPH13R7/1icahJn1IOhMRwwz9qQjjlycDF
 4DpVwI/Zil90Udflprj9kNa+AsGJdsUIIptDOoqbDgQ8nOp4ApUFF3Kkpd5WVuMWqPRFON5h7
 5DExtJcy9+ftCDKOkcSj3GzmouR1R6GansEvYGIYQk6FCjaBHhPCayL4MFuSvt7qiXcQ209vh
 HqXTGch7UeYYdF4dZchz/GEFYBezKyggY6RSjLmutM3dH6kK5OtwA3NbnuE5XIKA3I467aGxa
 SgQ3BR0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming commits, we will implement more and more of rebase
-i's functionality. One particular feature of the commands to come is
that some of them allow editing the commit message while others don't,
i.e. we cannot define in the replay_opts whether the commit message
should be edited or not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 +++---
 sequencer.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e094ac2..7e17d14 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -478,7 +478,7 @@ static char **read_author_script(void)
  * (except, of course, while running an interactive rebase).
  */
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty)
+			  int allow_empty, int edit)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -513,7 +513,7 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&array, "-s");
 	if (defmsg)
 		argv_array_pushl(&array, "-F", defmsg, NULL);
-	if (opts->edit)
+	if (edit)
 		argv_array_push(&array, "-e");
 	else if (!opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
@@ -779,7 +779,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
-			opts, allow);
+			opts, allow, opts->edit);
 
 leave:
 	free_message(commit, &msg);
diff --git a/sequencer.h b/sequencer.h
index 9f63c31..fd02baf 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -50,7 +50,7 @@ int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty);
+			  int allow_empty, int edit);
 
 extern const char sign_off_header[];
 
-- 
2.10.0.rc1.114.g2bd6b38


