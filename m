Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A345E206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933148AbcLMPco (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:63135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933846AbcLMPbt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:49 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCcvy-1cQCyQ1ASw-009POF; Tue, 13
 Dec 2016 16:31:44 +0100
Date:   Tue, 13 Dec 2016 16:31:43 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 23/34] sequencer (rebase -i): respect the rebase.autostash
 setting
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <e8ca098f5da19b540367b1d070169fc74d2e7863.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:C3PQtOx1FuJADiXIZmlqCzRDSCt1Bdp59qvtf+1ExPg1vldxHcX
 e8B2Q6CKVCzTvbVs56tX0cxOIt4aXrMknsSBW978sxYE2FGaaWL412z83FEhlcPB3AXzWSg
 eWUKuMohpeQT2EJOefSNB7EUAn/tIbIlytB1hBbmgzHOrmC50jW/5WHRxokxXcVY6rEJ8Kb
 0ljIKg40rs1LeEQaDtoow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VGiwqYDXu1c=:VEvB9pR5Dpo/R0qfoqjMvZ
 DLpx30d9ZBqwTRm6AOjyG9S/ScJEdDc/RegVX9wWmQOso0rg8LcU8LDwkfdU6hJrODP4JJIme
 4T3d81DLZ7E2Y1PXgjrUDR/SYAKPppklhbbGM8YjIQsFdq5Fx+22jQSiTEkEiA0AXa5UA/udY
 KQDhHVqtTGJeiZe7fJ48i8o5ZZ0ygl9aKtYtuKMewss4w0tvlUT7YCmMNL+BN4c0sCPxoE5nS
 eFIM4570wKqdOuTanJUrH9OkNCMyCdZ6lGy6WeNZRuZe3Dcdw15dP4POBRjYPTKytYCD/90GH
 RYn2V/auNQTLP+Rumg8NVF2UXQdTZ3iI8ubZeXKrG2aCXVochfedt4aR/EcRNURS8/WeZjUqL
 T8Cls1ltT5h1+iMtIW7uNMZjmJwauojdzmFAl8YYowgsOhTqv/vaXMnWkIXyIs9js+SyTQVR0
 m6yleIS4OpKezBXXBeErYvPguE9cc3UgNDEFy17MRJZsR/KYV9wiorbvkqJFksVAyadaAVZZG
 HUBslBfWAEyOKp5l3MRjXml5JFQ0T0s8hWpM85bgeCQdnOQaz29RUHlEmf1RZQoFsBbHTH/tB
 t1G6HOcqNORlEsX5h6CIPKhIPRWFpt0sYzsHCywDoiVHIU0Pj6AO1KEDe4sQGMhn+siquHAM4
 3YSchvXZMaTGNYykGhK0xr2mlbS8H+PeEFK1RqbSChXpjLfgRttZj4/HvqMpx2gkodCexDa82
 sPAkng+F3o22bjNaG3D4joE91+4T+lQxQR/o3SLWxreIYc0vo4wNZjr/o1Dfs3y94vijOpbue
 f3DtR6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's `rebase` command inspects the `rebase.autostash` config setting
to determine whether it should stash any uncommitted changes before
rebasing and re-apply them afterwards.

As we introduce more bits and pieces to let the sequencer act as
interactive rebase's backend, here is the part that adds support for
the autostash feature.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index cafd945e83..c11eceb70b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -111,6 +111,7 @@ static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
+static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
 
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
@@ -1808,6 +1809,47 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
+static int apply_autostash(struct replay_opts *opts)
+{
+	struct strbuf stash_sha1 = STRBUF_INIT;
+	struct child_process child = CHILD_PROCESS_INIT;
+	int ret = 0;
+
+	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1)) {
+		strbuf_release(&stash_sha1);
+		return 0;
+	}
+	strbuf_trim(&stash_sha1);
+
+	child.git_cmd = 1;
+	argv_array_push(&child.args, "stash");
+	argv_array_push(&child.args, "apply");
+	argv_array_push(&child.args, stash_sha1.buf);
+	if (!run_command(&child))
+		printf(_("Applied autostash."));
+	else {
+		struct child_process store = CHILD_PROCESS_INIT;
+
+		store.git_cmd = 1;
+		argv_array_push(&store.args, "stash");
+		argv_array_push(&store.args, "store");
+		argv_array_push(&store.args, "-m");
+		argv_array_push(&store.args, "autostash");
+		argv_array_push(&store.args, "-q");
+		argv_array_push(&store.args, stash_sha1.buf);
+		if (run_command(&store))
+			ret = error(_("cannot store %s"), stash_sha1.buf);
+		else
+			printf(_("Applying autostash resulted in conflicts.\n"
+				"Your changes are safe in the stash.\n"
+				"You can run \"git stash pop\" or"
+				" \"git stash drop\" at any time.\n"));
+	}
+
+	strbuf_release(&stash_sha1);
+	return ret;
+}
+
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
@@ -1970,6 +2012,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				run_command(&hook);
 			}
 		}
+		apply_autostash(opts);
 
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
-- 
2.11.0.rc3.windows.1


