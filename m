Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B411F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758650AbcHaI4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:64135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933889AbcHaI4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MaIsi-1bPgIL2huS-00JtdS; Wed, 31 Aug 2016 10:56:41
 +0200
Date:   Wed, 31 Aug 2016 10:56:40 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 32/34] sequencer (rebase -i): show the progress
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <3207457a57d056c3054faf718128fb5c806cb032.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jLSpeRarDtrc6I6md4shpSTu8kZg1b4g+kFNSxRKgDWa3f3cwxJ
 DogMsf85t2L78CJ0gy3F4d50B79r6oUEf4sYJmND8WdcFIBEbJq6j8Cm0jxNSGN3ZTAIkTo
 DfFhBFesx3H6mnTCu+3dhjKfyIq0mobzarjatRYj+IS3U6XIVfLud5K4D5yG6wJfCLghecV
 KTKjmSSfPeDkUpuR1fphg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Nyc3F5SVOPw=:wWVckQMiXJw7NPbiD/Ap3I
 1/lV99fdJePGcme1530eFmAsZ601dtUKD6JEGXKDEPk9wAeLcgl6KB72N1LoNqFgljCFJgRNE
 ffRn7upIdpTNeWF9Zy+RRNnacmhY9phsROj1FYk7YP/MyvswBdyX2jQNpMt0+tFI2ucJBlrxm
 tjIf132P/GMc/Vp5rP+rMpVXOn22IJafSYsnI+EfRWeT7VtyHew2U2OkSG0wjUCgRevqi/AXk
 RZLQKf+19cLa+GKYKfIn5c9UxfRpKeQE5EMvtt1qymfkYDcJn/avtAYOMDo0oBGp3bh69rQaf
 xCwCyjgwlyS+QZlHTCUeEAruvuu/6OaDjPOAokfFIU5ISkNlcEB8710Z0t1y5X8k03/v5omje
 odo8fy+p6pe3zvBXs5kmMNgx3ybBx6sjW5k+HnXVYbYpXLyBJR7BARnVEtl74GfPB2ZRJlzGL
 ZqSFdTyHnjX5xyLVNqHC6UPh7Em19/MlHHInSupO24/6cpmJEeUL5LRASO74L69B0257+PLUt
 LbfiN6itOIucq7pGj9P4Ez58Uc8d1eZg3lv4ZynGoddAk1NW9lyWjNDQEE9j2NAIYjJxB9MS4
 qij//UAG9CAEehdaM8/WPu2LmlpOKMGAZ6R8vIu+hiCT3/+9ineVVTFcwAuUPu7rQatG4cwpJ
 cSLdMsvWSQPehJMSxxM3CvaDFOjqhiFW3voU//0wD+BPCjSQRTJtIS9YOiqvbIEXGdk8PA9F8
 5wCXcquEvL4lfrD55mtatTQKBK/OQCpPxAdrpsayYac2HUveUMRMhIL8vHxlcNf/ynQaZ4VY8
 K9UanwD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive rebase keeps the user informed about its progress.
If the sequencer wants to do the grunt work of the interactive
rebase, it also needs to show that progress.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 89fd625..e8c6daf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1218,6 +1218,7 @@ struct todo_list {
 	struct strbuf buf;
 	struct todo_item *items;
 	int nr, alloc, current;
+	int done_nr, total_nr;
 };
 
 #define TODO_LIST_INIT { STRBUF_INIT }
@@ -1329,6 +1330,17 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 	return res;
 }
 
+static int count_commands(struct todo_list *todo_list)
+{
+	int count = 0, i;
+
+	for (i = 0; i < todo_list->nr; i++)
+		if (todo_list->items[i].command != TODO_COMMENT)
+			count++;
+
+	return count;
+}
+
 static int read_populate_todo(struct todo_list *todo_list,
 			struct replay_opts *opts)
 {
@@ -1355,6 +1367,22 @@ static int read_populate_todo(struct todo_list *todo_list,
 	if (!todo_list->nr &&
 	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
 		return error(_("No commits parsed."));
+
+	if (is_rebase_i(opts)) {
+		struct todo_list done = TODO_LIST_INIT;
+
+		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
+				!parse_insn_buffer(done.buf.buf, &done))
+			todo_list->done_nr = count_commands(&done);
+		else
+			todo_list->done_nr = 0;
+
+		todo_list->total_nr = todo_list->done_nr
+			+ count_commands(todo_list);
+
+		todo_list_release(&done);
+	}
+
 	return 0;
 }
 
@@ -1900,6 +1928,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		if (save_todo(todo_list, opts))
 			return -1;
 		if (is_rebase_i(opts)) {
+			if (item->command != TODO_COMMENT)
+				fprintf(stderr, "Rebasing (%d/%d)%s",
+					++(todo_list->done_nr),
+					todo_list->total_nr,
+					opts->verbose ? "\n" : "\r");
 			unlink(rebase_path_message());
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
-- 
2.10.0.rc2.102.g5c102ec


