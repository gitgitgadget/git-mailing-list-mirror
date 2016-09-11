Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41AAC207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755820AbcIKKxZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:53:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:50244 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755778AbcIKKxY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:53:24 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MXqV1-1bV1Vk0kmV-00Wn4F; Sun, 11 Sep 2016 12:53:15
 +0200
Date:   Sun, 11 Sep 2016 12:53:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 07/25] sequencer: future-proof read_populate_todo()
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <19f49ce9df124871c77474386164e51defe4416b.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T6X5LJJR+OH3eeCI2iBk3jw7fHJNqP4hMO2ndLPVRDW3cUnr6Me
 ja4WL8UJkOPtnu138vhOF5GmgpoQKGCVz/pZWtHR/gSLcSso8TIYPtnwqSK5DElz+hYhH90
 McoV+V2aB1YHfOtmlV755BcrnRqnz6+XOhDwj6zqmF2jBX6SYgzWFhrkQf5+VPpjO02hXP/
 q7dlGzY37aDK9oW6tAiHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IA3BqS9FlzY=:WT6n8mhORF/skopw/I/lRf
 De5UIUeC/NQPVTBBs0emkwWDtQlihxTqd7AUDfFHWYng61xxfjRoXsRUpdGQqTeUYl8mKJqLU
 NRX9jDnmmbR0TCDdAu6wadXf8izJ4n74XqHz+I6wIkakB9n+gnNDDRZaggitOAyRKK976/CC+
 feQpPUbKv5f1bKB8ItiSS2uC+hJJ9BjgEAe2GpY7xttuahzQHbjISCIdgYrMAlVWcPJ1hcFzb
 lVYhKoTd5D2Eg1AAOYslTo7lvbvmnsH1rnAMNg9ZecxbUHzNboBJwfRjEINzJagU39GRd+5UQ
 YMOnEz9/bDFuTwQ9vJ91lhcksdUwlRypetqxfmyWxJ0e/hxxOemN8EInLf/3u25z8zC7/j+9n
 G4iJdmFhduxlQ6zcJxJVQEngFkweXYIgtD4BxY/A8GKm94k2tl0/bBd7kjiJesTSzUpy0CyYD
 HB90CToUiYfHlEx9paHgj7GOX53X/oB7uWH3nRLVmO+aSXs2HLxDtB3f5BA5S9W2M/hYCyE2P
 YBlNMeeb1wcqpbo6j2tNrPtWZUWql0nCMwviooe1fmpYwEzgN1pLgqLOEWHawrf7uav5Fcbpu
 vcP+LSjStLGeXO4zZmoU831E3Ch033fczk/NCwQZhRena8wVOUGs2LHN3FwHtMzH+EfJNrVWe
 l3+iIOxlrimnjFc9d1xfl8gIPxcBwL89quL0TA56nJxHxwZKOl1F2VDXaozdvl5jhTCDwzcho
 cfZlAWMhSEaGCmyRzj0k4AmAR5TNcCvM1IWI/I8wLS1WY/uZrQQS0FfJEfH+QDWjCn4Qgc+Wk
 afWj05d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the next commits, we will work on improving the sequencer to the
point where it can process the edit script of an interactive rebase. To
that end, we will need to teach the sequencer to read interactive
rebase's todo file. In preparation, we consolidate all places where
that todo file is needed to call a function that we will later extend.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3ca231f..da6de22 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -32,6 +32,11 @@ static const char *get_dir(const struct replay_opts *opts)
 	return git_path_seq_dir();
 }
 
+static const char *get_todo_path(const struct replay_opts *opts)
+{
+	return git_path_todo_file();
+}
+
 static int is_rfc2822_line(const char *buf, int len)
 {
 	int i;
@@ -776,25 +781,24 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 static int read_populate_todo(struct commit_list **todo_list,
 			struct replay_opts *opts)
 {
+	const char *todo_file = get_todo_path(opts);
 	struct strbuf buf = STRBUF_INIT;
 	int fd, res;
 
-	fd = open(git_path_todo_file(), O_RDONLY);
+	fd = open(todo_file, O_RDONLY);
 	if (fd < 0)
-		return error_errno(_("Could not open %s"),
-				   git_path_todo_file());
+		return error_errno(_("Could not open %s"), todo_file);
 	if (strbuf_read(&buf, fd, 0) < 0) {
 		close(fd);
 		strbuf_release(&buf);
-		return error(_("Could not read %s."), git_path_todo_file());
+		return error(_("Could not read %s."), todo_file);
 	}
 	close(fd);
 
 	res = parse_insn_buffer(buf.buf, todo_list, opts);
 	strbuf_release(&buf);
 	if (res)
-		return error(_("Unusable instruction sheet: %s"),
-			git_path_todo_file());
+		return error(_("Unusable instruction sheet: %s"), todo_file);
 	return 0;
 }
 
@@ -1077,7 +1081,7 @@ static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 
-	if (!file_exists(git_path_todo_file()))
+	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
-- 
2.10.0.windows.1.10.g803177d


