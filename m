Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59122042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934213AbcLMPcq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:58553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933929AbcLMPbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:47 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZynd-1d2ZXT4Bdl-00lm7Q; Tue, 13
 Dec 2016 16:31:23 +0100
Date:   Tue, 13 Dec 2016 16:31:22 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 18/34] sequencer (rebase -i): refactor setting the reflog
 message
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <6f7ec89ac91ba1aa860a28c27ab93f60099f1ddb.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iR6WxxOfKW36QWCvVZ1s1ChOEF3eWbb+RJgfjKC1VdSpILqHRJt
 ZecCF/PbpU3kdUFPL9GhOakQe0GIU0g2ZQbaIw1LNk/g5J/0h6big4Rovh+jDkER3Ntrf11
 VSm2r0TEk4U/q5+Uj84QcUYTnXjlWPyxRSnvFid6era2LZvGH3Zcu05iXHM27xWNQvi+Ato
 3i6/k3SKKXgd3Vf3OSPCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6dDbhhf2fKY=:A5RnJ6HvGkZoB3n5N1O8Vk
 fps5CjS1KwIeT0mkylO5C+oIaUoole0DzMvYgy5wtxTqmHRH8nfUMkrYcRsz+V2cjXUh5zB9C
 6/l74LCwJZ7odFbpBOJvHb6PpYFTJau3W5D0cjUX/3uYPHJROOwKTKE47TQqbLVOxerTdD19G
 iZpwehBc4+pL1uYshSZoUnZ7uHl/Kxk8NgccJk7tnw77we0siQZLZu1Le2VxtT/aCCqOp4A/L
 8NH0SvCMbl70rW4ZUcoAZTG0UlVKUjYHgjDdV8QQRoAQJlcriTtgiBwdMJ8ioeFS+O1oRByqU
 jAdPQzkyTuMtUHjRshu1+/XTmzhCIF6r/zV6EdC4e7y9jBOqTXB29apbXefjxSxD+fRMSbvqk
 uPyvFSnpxAdMTSZ9J4aIZDwtQW6rVHN1zqgl+h2IFglKNLbwSCkK3bCgXa9/ZNriXTrC6ePd/
 7I+KmNK6BRoRWaZncYh4mLLD9sw/aBajjc+Mvrr6mxpTspaWJqzZM2THZcpLl3Pcl2egNjnr0
 3EUlpBmLp2j++iRRJP3V6Rh43OYqIb83cT6jFI/bOYGB6L+Ohgv/ymDdPtUkUNmS0Xl/8VFo8
 le9ojwTRa+AvO4i/9tuB3bsM/fq6SEPzY44dpTkpsfQx1dEDGyE6DLtZ34/npHJFR6f9TXnQd
 C7rGx7zkNutWxL5scO60UfmazWMzeYgtAgoGoBEBvB7JGPvJo5MtBP7Gw/QQLnJMZ8/P2QyLo
 loAm90lkd/TmbVeRcpwZfxQfF6Q45fU5pA0IWH5MehoqcShPrjjWDXX3N+YaOVFkNkgtiGYM5
 G5/gswJ
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
index 33fb36dcbe..d20efad562 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1750,6 +1750,26 @@ static int is_final_fixup(struct todo_list *todo_list)
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
@@ -1820,6 +1840,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 
 		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
 				starts_with(head_ref.buf, "refs/")) {
+			const char *msg;
 			unsigned char head[20], orig[20];
 
 			if (get_sha1("HEAD", head))
@@ -1827,19 +1848,17 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
 					get_sha1_hex(buf.buf, orig))
 				return error(_("could not read orig-head"));
-			strbuf_addf(&buf, "rebase -i (finish): %s onto ",
-				head_ref.buf);
 			if (!read_oneliner(&buf, rebase_path_onto(), 0))
 				return error(_("could not read 'onto'"));
-			if (update_ref(buf.buf, head_ref.buf, head, orig,
+			msg = reflog_message(opts, "finish", "%s onto %s",
+				head_ref.buf, buf.buf);
+			if (update_ref(msg, head_ref.buf, head, orig,
 					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 				return error(_("could not update %s"),
 					head_ref.buf);
-			strbuf_reset(&buf);
-			strbuf_addf(&buf,
-				"rebase -i (finish): returning to %s",
+			msg = reflog_message(opts, "finish", "returning to %s",
 				head_ref.buf);
-			if (create_symref("HEAD", head_ref.buf, buf.buf))
+			if (create_symref("HEAD", head_ref.buf, msg))
 				return error(_("could not update HEAD to %s"),
 					head_ref.buf);
 			strbuf_reset(&buf);
-- 
2.11.0.rc3.windows.1


