Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2477920989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbcJJR0C (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:58640 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753225AbcJJR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:00 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LoEPJ-1bDRov2McT-00gKCA; Mon, 10 Oct 2016 19:25:36
 +0200
Date:   Mon, 10 Oct 2016 19:25:35 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 11/25] sequencer: refactor the code to obtain a short
 commit name
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <0244a3f187fed257c96d33c0d6fec705215769f6.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:31VNuB6YzK5pXU4lybfKTkx9wdinaY/fDnR6baFpL4ZXZq1iBcz
 nnlGtm5vR1l0Bu+d5x3etcVPbROS2fBygSPL/bgD8IkdvyMZFgD3k+8Ssq5AKELkxk5APzS
 yilS5oKgR3pEnaAOEL9+ZGoIdHa9530iOzDnbnM+6kDrwtCzVEww7DdeRTCz0UtUgrAynrM
 FSzy0uBPFVuUcjWHSq+Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dWsWwYfv8Do=:a1WJdLFnsNWGAFTX88ELtv
 Vg11JbaLLdEgan9fQcisyT+ZFnurM8eVdlkaW3OhJMizeqEf64pMOlt9a9a6ilwt4pfto1cA+
 jEfH/S0LKGyx6/jCud+O+gqhS/fw0Ch8dXzD7HYZ8o7uLCzQYnm6gx7h9N8kyn1mn3MdTGr/C
 81KWxvYp/6FSEx2RwcCU0N+mRZVbwEpHSTObOYZI8JeZKYhE2zmQlGChDpFucu0pnQBZm2Sxt
 dN0crnBq0dbRoft/nj+c17+rOCcpA3w1vfb8u6wbUhQOS5ruDeiqxVu4rVmjH+KrkEoRp76A1
 z9de2Y7VBdkOjAOdZIqVZTTWlEd0HZdp5UPB4tf3u9Er+mfw6l032LAbP/TBq+o9+vZnG9ZLD
 R0MmY5eYlxGhuZEdMvXoF/OdT7KCxKXl1T6I7l0+g0W1/dH7ltMfk6t/P/po0aeQ4XNsG6Fm9
 hrt17LKClJfR/PYhoK0Tfhj8cAgV3s32tfkqFsP5ogoZI4/n1HfVfCOP4AE3/+fnKZo0Lzqjt
 23ZBuDmp0fWCTNvziG8nq2U2xmwldxbYra2KUGLCVP1FsyZoHTj8rwFkHHUtyYqQ3E3y6n4pl
 U0M0TdvwZriuJiNjrZJ/ih1OW+ONUJESp23YYMV11P4XEeZKBYgORzU1K7rqHzJKE+zys+o4+
 my1o2VsNroV8M65s3SLIvQtVLO96PdUXIoTByP+sOmhf6/U/XqLwhc69VyHelcrK2dA3/KpN9
 q+vM2XMHY//T9cs7m0lodH7xWKPziJkPasuE3aZwxuGZTWZH0dET2BdwvPu7O0kqSR4CkzM3T
 3Ebgplj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not only does this DRY up the code (providing a better documentation what
the code is about, as well as allowing to change the behavior in a single
place), it also makes it substantially shorter to use the same
functionality in functions to be introduced when we teach the sequencer to
process interactive-rebase's git-rebase-todo file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 14b1746..afc494e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -149,13 +149,18 @@ struct commit_message {
 	const char *message;
 };
 
+static const char *short_commit_name(struct commit *commit)
+{
+	return find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV);
+}
+
 static int get_message(struct commit *commit, struct commit_message *out)
 {
 	const char *abbrev, *subject;
 	int subject_len;
 
 	out->message = logmsg_reencode(commit, NULL, get_commit_output_encoding());
-	abbrev = find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV);
+	abbrev = short_commit_name(commit);
 
 	subject_len = find_commit_subject(out->message, &subject);
 
@@ -642,8 +647,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		error(command == TODO_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
-		      find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV),
-		      msg.subject);
+		      short_commit_name(commit), msg.subject);
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
 		goto leave;
@@ -910,9 +914,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
-			find_unique_abbrev(commit->object.oid.hash,
-				DEFAULT_ABBREV),
-			subject_len, subject);
+			short_commit_name(commit), subject_len, subject);
 		unuse_commit_buffer(commit, commit_buffer);
 	}
 	return 0;
-- 
2.10.0.windows.1.325.ge6089c1


