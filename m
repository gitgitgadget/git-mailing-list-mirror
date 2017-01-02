Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC03205F4
	for <e@80x24.org>; Mon,  2 Jan 2017 15:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756276AbdABP12 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:27:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:59906 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756263AbdABP1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:27:25 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCfcc-1cEgrd1zkI-009PMk; Mon, 02
 Jan 2017 16:27:19 +0100
Date:   Mon, 2 Jan 2017 16:27:18 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 12/38] sequencer (rebase -i): write an author-script
 file
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <c1318a1663643adea672e4af6d0f068b36e7cb02.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dO1MVfBlJiGvn3DczOPJJCbJk+3ewHs/uHgWRm0mJm1d2DZrRQY
 dz412vsVEBKhJF6LLRfKvP/oHhr8Zp9kAQdfHh9/sXYc5nJ9R4SGFyKRessSAwL7tWoIeZd
 IaQjylNIR3WuQEc3NuZp0hfsMdEl1Jr56i9C+nl+tQvjWc75B5k/91KvfiyTazSiwgFxqK7
 x1/JA3Wy6Z1eQdaNZosBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L72Au5rh43g=:Iz/fahjXhmFmX3JhnBwB0R
 up+XXKqcu2fg0dE62zuEbrxehaBcL9MmJDb59d0bUW84KWaVEy7Z04FEpc4ImEodKqem/+QFA
 8G54AA+aMEp5/QRZQ6X+Wwru6M8M3CsK9g+iY19+lMk43d5jsC12qmjN8n4d7UtHqV8TmCX/A
 StXp2El8R7KSqBLIk6mpuqRSQc0lZKEpyxYpOaZ9FHqczk8LPjO7x7qIPOxDEv3pw04Y0hDeF
 8oSk7s9VCAPWamgfWCloGEdxPZkdbI+xov43TzT8xRc0/EyX/owKSyS8/nMbNPmijaB14aJ5H
 HpZrYrcoXEC0OEBVnqN9mt8uOGocMMcnpU3u4huXn5MFMcHLr4DmIKfT+0X8HXGUse0QosWt8
 ETPe7GzdFNGVpMb1xpzyOYoxp2qTjy4V+EteSjpOOW7n5IfGcKnjD2dt4NuX075bsVZ6WHFhr
 lNWPkvsaURhTu665Fq2HsJD8YRMPCqzAp7GMIlDqJ7V6C0IHH6huLmCmKIl5a8nLPtD55cI/2
 TrqKFkhDHsuNOHwPFc+v853rXwop+isJ1bpEk2aY7sH/Lwt/PshgGmSLWhGVi1iNFQavqEyLZ
 noHXyS7bsdO1NhK9bw5h5/ran/DKis+FcOkEVUpbGdwAFYveZFedXFuBMMZXwuZQkSVB8jgY7
 WpPnsRytO5wW6F2ApAt/HE6JMWoNk2OSCyAu/YdhBbVAwaoSntv8dmuIPli9bBYKSQRqbVce8
 eto0xmwvLVt4QhSzmv1ey18M5U1VBpZtnh3AmidR9woewxyoMAgDgn0htxSGbjCFKezz3AGve
 b9uDQbT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the interactive rebase aborts, it writes out an author-script file
to record the author information for the current commit. As we are about
to teach the sequencer how to perform the actions behind an interactive
rebase, it needs to write those author-script files, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 29b944d724..9913882603 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -483,6 +483,52 @@ static int is_index_unchanged(void)
 	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
 }
 
+static int write_author_script(const char *message)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *eol;
+	int res;
+
+	for (;;)
+		if (!*message || starts_with(message, "\n")) {
+missing_author:
+			/* Missing 'author' line? */
+			unlink(rebase_path_author_script());
+			return 0;
+		} else if (skip_prefix(message, "author ", &message))
+			break;
+		else if ((eol = strchr(message, '\n')))
+			message = eol + 1;
+		else
+			goto missing_author;
+
+	strbuf_addstr(&buf, "GIT_AUTHOR_NAME='");
+	while (*message && *message != '\n' && *message != '\r')
+		if (skip_prefix(message, " <", &message))
+			break;
+		else if (*message != '\'')
+			strbuf_addch(&buf, *(message++));
+		else
+			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
+	while (*message && *message != '\n' && *message != '\r')
+		if (skip_prefix(message, "> ", &message))
+			break;
+		else if (*message != '\'')
+			strbuf_addch(&buf, *(message++));
+		else
+			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	strbuf_addstr(&buf, "'\nGIT_AUTHOR_DATE='@");
+	while (*message && *message != '\n' && *message != '\r')
+		if (*message != '\'')
+			strbuf_addch(&buf, *(message++));
+		else
+			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
+	strbuf_release(&buf);
+	return res;
+}
+
 /*
  * Read the author-script file into an environment block, ready for use in
  * run_command(), that can be free()d afterwards.
@@ -935,7 +981,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
+	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
+		res = -1;
+	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		if (res < 0)
-- 
2.11.0.rc3.windows.1


