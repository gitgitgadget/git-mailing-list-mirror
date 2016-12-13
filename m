Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F362042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934161AbcLMPcB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:63253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933825AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7UUd-1cW8R10Yop-00xKZ0; Tue, 13
 Dec 2016 16:31:08 +0100
Date:   Tue, 13 Dec 2016 16:30:53 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 14/34] sequencer (rebase -i): update refs after a successful
 rebase
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <596e3cf410a339c3212eea76394fe49be1c05ef8.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:07hN1YWWOKknUnvh24aW4amCzTvtt5uNMWEuk1hqWih/c6qP+qm
 lBvoH+hWQRMCfWm0Xvd9n+QNduFxlJ+tufrAnoWV7DN3jP3FtpC5FusiyOvZDgqNharrMQp
 B9ZP27n1OOPNBOwdIkn3Tr0YnUN6NM/VERYTCc0Lqm1dc3RXQaK1tO0HB0AqUxZ0VzUxIWq
 MIWcpRV+kTw0DmcUaU6Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dzInPtJyKPM=:rzvm4L0734ylsA2DMPo/rc
 Yvjnc4NSqHSMKtkMl6b+KhGqnwzsJ3M5YurGqBMOut5pZjW3xXOGmOHvG3qHDq0JGn4p/wH7h
 LFBzC/LbbKI7cIlI39lZzqZnBChBSina5zSfKani8ITuRKvaUUEUfhLmgvvImnklzYHQSfS5a
 7S/2hz/mk7+4qZtYmJB/dT01ITIF1+HZj2Ac/MGIFFoMbAVnuv6PQGtik0UkD36gYcg0PDwe8
 yGUQH0aW5R72jJMK4vBqbbq2fEC98NJz79VtE0mt0MSEjd+QX9TALiH9fpVgs1vJvJFXlO0NV
 n6fF9ZfuSjkquQNTwD6Szsr9KIwpB3J2nHMu9oHXHPZ0Gn2pypMExCzpT3a7X4wGPkodEx1P0
 7Kr6hl8BbHipYKlkOFPvOuX9rXswG+uTnubEeilHbpBvgXw6ebs5H1Dm+D2TJmcYYYBu+243P
 bhkwgo0rLxC/Vj/cN3BOcFNUYyiBHyvApSYPwXZxK+JaIJVhewHvpkI3nxB532CurDze2MD3l
 yhGnBBIBRmSieHvI4SL8PrOqopF4le8TFDWUMr+q/Or4JhFNMCMqEuhODHhUZqBBFFVgpsLzb
 rmdTV/FJ+PSG22ZqOuJaZUhOAMN/QRV3KJ3kLA3TCvGRnaZSzyqD0HXk7bNTJGGZnAoxwBQVk
 6BID45iPfb80vxV0EZeXLx99Lv09oJvS8CZhAQDmUmJnTnWVC6PllwzvXR5QidaUdaMR0Kxte
 A+0jO2RE/QjxT3+KAJYZQ5MEevfdTCXmpwo7N23AqPMbdaxZIB/4xjGZnEfFDULWB1N+leB+M
 0jdVmrh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An interactive rebase operates on a detached HEAD (to keep the reflog
of the original branch relatively clean), and updates the branch only
at the end.

Now that the sequencer learns to perform interactive rebases, it also
needs to learn the trick to update the branch before removing the
directory containing the state of the interactive rebase.

We introduce a new head_ref variable in a wider scope than necessary at
the moment, to allow for a later patch that prints out "Successfully
rebased and updated <ref>".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index a6625e765d..a4e9b326ba 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -100,6 +100,8 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
+static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
+static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
@@ -1793,12 +1795,39 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 	}
 
 	if (is_rebase_i(opts)) {
-		struct strbuf buf = STRBUF_INIT;
+		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
 
 		/* Stopped in the middle, as planned? */
 		if (todo_list->current < todo_list->nr)
 			return 0;
 
+		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
+				starts_with(head_ref.buf, "refs/")) {
+			unsigned char head[20], orig[20];
+
+			if (get_sha1("HEAD", head))
+				return error(_("cannot read HEAD"));
+			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
+					get_sha1_hex(buf.buf, orig))
+				return error(_("could not read orig-head"));
+			strbuf_addf(&buf, "rebase -i (finish): %s onto ",
+				head_ref.buf);
+			if (!read_oneliner(&buf, rebase_path_onto(), 0))
+				return error(_("could not read 'onto'"));
+			if (update_ref(buf.buf, head_ref.buf, head, orig,
+					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+				return error(_("could not update %s"),
+					head_ref.buf);
+			strbuf_reset(&buf);
+			strbuf_addf(&buf,
+				"rebase -i (finish): returning to %s",
+				head_ref.buf);
+			if (create_symref("HEAD", head_ref.buf, buf.buf))
+				return error(_("could not update HEAD to %s"),
+					head_ref.buf);
+			strbuf_reset(&buf);
+		}
+
 		if (opts->verbose) {
 			const char *argv[] = {
 				"diff-tree", "--stat", NULL, NULL
@@ -1813,6 +1842,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			strbuf_reset(&buf);
 		}
 		strbuf_release(&buf);
+		strbuf_release(&head_ref);
 	}
 
 	/*
-- 
2.11.0.rc3.windows.1


