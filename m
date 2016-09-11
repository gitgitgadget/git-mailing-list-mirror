Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24399207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755935AbcIKKzs (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:55:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:59617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755778AbcIKKzr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:55:47 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MYwQh-1bW8Oz2uAt-00VgXb; Sun, 11 Sep 2016 12:55:42
 +0200
Date:   Sun, 11 Sep 2016 12:55:41 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 19/25] sequencer: remember do_recursive_merge()'s return
 value
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <44c455710fd9c420a3f759d021c4864f3a83c97a.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MeSGB34ms4pXOMDMd9c/XD6etCUwknKhU9ZrWUNMv1tDkVQGc+N
 KRo5MQy98okBeb8N2CFcJY72uSkkKfupdKUkqEhI/6kh01lvmvG6RYTo4kXGUFdJv84WXXS
 fkOPGS5vsQ1xG82JEmzcjq03q8W9umJjSBUIFZLV5OPh1Eglaj7tOp7tWEFaGDTTRP0S39y
 t0ywOhjYSHugRorZdGbhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OrlFE3iJlig=:NoCDnaGXnAH4N/l4V7nBrY
 yQdjyCYqWBp8sPr+hkswqx+RiDNIreZ+7GcYtoYQpI1I6GF8BZCpBKnjPVj51PzxXTTtC38PE
 t/+zK34C3Vg71vVLWqaNfdqLDuNLMGjCE887g8+bXSk3qTWNpVnqCQHi2QC+lYzptCCREqpPf
 yB2Ccj2DjCtf910+6DOkHiuKFuFNlnqBM+4fr+yUFaqyi9ds8m4B2kSNZCW+r39wBwS4O/R9e
 hs0O0I90RQPhONr4dIhZRBuVwHMDBFa/ji7sDwupig8wqBUFZqOvhHF0ebJEDxkjJRvG2KVvR
 KuAW91N5DoKXM9u2iYyx0YkXqgc2wihdGiRJdFYNF5J7z5W9/NBGtGXCygB719QVdnLv+19QB
 8WN7l3sxe5BKJglp67VOfCInE4wiQyZ4bEapJPnJyyAXZrjSHLSEjQtAY7XROPmJtzWuJOb8T
 x1A6eRtLlLzlMEpUOlqcNZBGPpH3xRsjXr0KFMElKUorVLnk9PGf5VeKCLyvVd2Ab5Amm+w65
 8JLuTheV+ul8nFtDiit+blgTPT3tqZChTX/PhxyKzT18nvRdFPWStZPh9oXnzqVkTjCocE1z5
 kjZpHFfuUcsQQxVhSe2xep1sFxkwtQiOxNQ+9ZYqpaOhCQNxxrNjUdT4Qklmn09JWgDD61Utg
 F3cZOZXlBGlZ6t8mhxAENIy3A0y/CPFwaeP+dN/8h93NMwaBKXzE56FqHFEYU2PJ1tUn87d7B
 LHtoO/7tploG2kxguh0lmSl3jLJuyGda9YX6NIDjx8VxkxI/Wn1tAyBWgXP7P8P1wKYnTDmBA
 P58Xy4v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value of do_recursive_merge() may be positive (indicating merge
conflicts), so let's OR later error conditions so as not to overwrite them
with 0.

This is not yet a problem, but preparing for the patches to come: we will
teach the sequencer to do rebase -i's job.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 75772b8..7953a05 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -630,7 +630,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, allow;
+	int res = 0, unborn = 0, allow;
 
 	if (opts->no_commit) {
 		/*
@@ -741,7 +741,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
-		res = do_recursive_merge(base, next, base_label, next_label,
+		res |= do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		if (res < 0)
 			return res;
@@ -750,7 +750,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		res = write_message(&msgbuf, git_path_merge_msg());
+		res |= write_message(&msgbuf, git_path_merge_msg());
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
@@ -787,11 +787,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 	allow = allow_empty(opts, commit);
 	if (allow < 0) {
-		res = allow;
+		res |= allow;
 		goto leave;
 	}
 	if (!opts->no_commit)
-		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
+		res |= sequencer_commit(opts->edit ?
+				NULL : git_path_merge_msg(),
 			opts, allow, opts->edit, 0, 0);
 
 leave:
-- 
2.10.0.windows.1.10.g803177d


