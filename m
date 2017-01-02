Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AE3205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756352AbdABP2V (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:53640 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756340AbdABP2S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:18 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTSKd-1byOwn1kZz-00SSS3; Mon, 02
 Jan 2017 16:28:10 +0100
Date:   Mon, 2 Jan 2017 16:28:09 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 21/38] sequencer (rebase -i): refactor setting the reflog
 message
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <937c6f725ada6514554be13bd00eb036ada2bae2.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4HHuo7rgRWNNz+/Eaov1DHvShMRpb8WLWKfOKOVdO6dj5hUJqJV
 WcaPTU68YPASXUcAFos8WYrO0NhBEXhBzPO9AG/0FgdNe3fK+qfCQUoosj3QFN6FQUgYzP/
 2Mbz+enV9A7cAbclPxOwW50cITMHxwp4ZIVnyh8tZ25MSYLDrDBZQtpxJZIFiCcYfzAI/NZ
 1lR2/Q7+V95BR7bF/3qww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u9Jia3TqDaM=:KKgEpOq4AVG5mYpvXABeTS
 R1z47XS6q2CoKOZmTQ2Oz6eZT57QIOIyqC8fUS7ovlC9tXr31MBFH1cJUDpQioiwM0O8+ZPdW
 eO6M/viE+24qcdlmaVHVq2WE9kevxGDlaQaPLQyzBdYjMtaYfw/9Nt7KvjiLFM/FR08oSEP6R
 prMazv27qu+kDf9fOTprFNxSKzv9NThVeGr/M/NOYAQPwzfFwrBbKiK5FMpFnHyFSv9XgMWJ1
 hrwOnXvm1DjEblXGY5BrLPELV525iQQrmWHmRTv/SRgXNLGn7YCG5hbcBLKHqw7rmspPeQKlD
 njignwM9DnfvfyRM6G1kwS9IAYZkBrYZ6Ccxuu6RjZyRDS6Vm2nMh0MooGdiozYYFmuTioB9k
 Ry1idNwFA1LKznSZD/OfJjYPpwSbCmMufTA+HOszcisQa7IHvi1MrrhrsyqnT+gmz7lmtFcK1
 hBtDhvcoUy+WrOKkb5dZxq1OyZxGmmwAscXzxc/2pobfPGpmRmTsN05tfLIDvkGlv5dOXcX47
 8fDvVb7CQMpvhUkC5sZl9/rshT6GvQNr7T91gT6PW6kaLInjp0sK51fBdir5/ElvkZwpcWm48
 ClqlfSDkWF6CPh0FFawUr4SKlsadLn6IyhZzx11YolfzWIpinapGGbJnHEsjfk1vMhaT1gTpk
 TR9nHrw9YqIzSPzt3OrrV+LrsomeEuL3DLhSD1gRRD0r0KopXuL0jSwxUys3hOiI034capbQw
 E1Jza0BgOTm2iFCI1qpRBIRtpTCgbgJ26RG361967EttIeO35X35omZ0nazKB6AoLk1IH7Pjg
 8ILQEJY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the code DRYer, with the obvious benefit that we can enhance
the code further in a single place.

We can also reuse the functionality elsewhere by calling this new
function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 23161f593e..0d8e11f580 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1743,6 +1743,26 @@ static int is_final_fixup(struct todo_list *todo_list)
 	return 1;
 }
 
+static const char *reflog_message(struct replay_opts *opts,
+	const char *sub_action, const char *fmt, ...)
+{
+	va_list ap;
+	static struct strbuf buf = STRBUF_INIT;
+
+	va_start(ap, fmt);
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, action_name(opts));
+	if (sub_action)
+		strbuf_addf(&buf, " (%s)", sub_action);
+	if (fmt) {
+		strbuf_addstr(&buf, ": ");
+		strbuf_vaddf(&buf, fmt, ap);
+	}
+	va_end(ap);
+
+	return buf.buf;
+}
+
 static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
 	int res = 0;
@@ -1810,6 +1830,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 
 		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
 				starts_with(head_ref.buf, "refs/")) {
+			const char *msg;
 			unsigned char head[20], orig[20];
 			int res;
 
@@ -1825,23 +1846,21 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				res = error(_("could not read orig-head"));
 				goto cleanup_head_ref;
 			}
-			strbuf_addf(&buf, "rebase -i (finish): %s onto ",
-				head_ref.buf);
 			if (!read_oneliner(&buf, rebase_path_onto(), 0)) {
 				res = error(_("could not read 'onto'"));
 				goto cleanup_head_ref;
 			}
-			if (update_ref(buf.buf, head_ref.buf, head, orig,
+			msg = reflog_message(opts, "finish", "%s onto %s",
+				head_ref.buf, buf.buf);
+			if (update_ref(msg, head_ref.buf, head, orig,
 					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
 				res = error(_("could not update %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
 			}
-			strbuf_reset(&buf);
-			strbuf_addf(&buf,
-				"rebase -i (finish): returning to %s",
+			msg = reflog_message(opts, "finish", "returning to %s",
 				head_ref.buf);
-			if (create_symref("HEAD", head_ref.buf, buf.buf)) {
+			if (create_symref("HEAD", head_ref.buf, msg)) {
 				res = error(_("could not update HEAD to %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
-- 
2.11.0.rc3.windows.1


