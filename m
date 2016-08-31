Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42D81F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933884AbcHaI4F (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:61112 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933876AbcHaIz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:59 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M3d9B-1aoQck3Eq9-00rIrW; Wed, 31 Aug 2016 10:55:55
 +0200
Date:   Wed, 31 Aug 2016 10:55:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 23/34] sequencer (rebase -i): respect the rebase.autostash
 setting
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <7329458d8dafa92e7d7a6275ff03b90b1035a72f.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r/EKnW/+F8MaQM+/wiEFqOCNzdb7pJFnBVJ+MDLnsrJjYWZwZ2+
 CFanhmQTftWiiHrUEzXlE3R3akFNNY2aotOTkvR3M1fpZpRkODr26p2oa3jf8nCAe5VDNV0
 gX3C3FNAmqZGQYWcS3Z9xRL29Q3J1lPEaI8WSw9tbDF+G/d0aEmS4EXQoScKt8xR+Uu7bBw
 wYQaBSAmSlXnMdZ3oEGHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wUFmmuAbCPg=:Guw1pwRrbOSAv6HX1QYOS5
 FmSg5ItkbmCV0/6wgqTbhrnfyYWDlCZTykyN1IwOasSz1IeyN/R9O57uIhFPXgVI17mdDq1tE
 8JYEXM0DFqb3uPoC3DJIrdo+ztibT7ksC8x1NgbzrJzbLGa0UN1xmKkyBRIo9LWBzDoWVsfy1
 DTlDJ/VrHhgWj9DyXGN6QXchXw87YLQ04lY9xJxaI1sAfh3b+HJJP0iOMIoWuQsTzfDj5ppnp
 dw9WqCnQHNc44hUYXNtddp8Qa5zfpO3x/CdDmSPcWWLPG+P1NNEcwDdLZzrPsZyBiX2VXccwx
 g2H2KUhDdV1j1fzIEatHO/5PRRhhhvxX2OHSozqZQIJ5edLCteFQzxQfQqieDjPl2qAx7lcfR
 +m8MhBe9/RMFxxW0W9SPQQX0gF1HMWyrGLusEyVFVKLbFkxKjEOmr5dAsDc89WbqVhWlIe/U+
 9NPq2JSuOQTm16JQmvUWYig9tDtxQ9/40pDVAWpgTdYCcklgGcuwjC+pSF1uziHbtO9r5YeR4
 ZoLb+dMiQImvpwsVuq/eWQ20797gANujQNm7OHT12RGcX+JT1PK/sWMUBfjFStXn/rRRjDnnc
 Fpn9LEUZtsO1zR/BaHJMQnLvdhtKLB+lbaRpQt4SyKIfrq9K1BnRNtlkwkr19XwVj+83U2VZa
 a7Kp89ysvx0RPB+OmznKm/LJfenea0O/LnGFxC1ORjLH6KDjaG7pqZDs5xWuQgPcGQGovhvgr
 jWCxwp9dBWSjYFuRk/iscNPWmRDsRNkiNbh6ClrGoZ8ia62+WmKREQssK1UR5Di8yyRwPn8br
 NlAiIhU
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
index 153116e..2922837 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -111,6 +111,7 @@ static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
+static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
 
 /* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
@@ -1783,6 +1784,47 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
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
+			ret = error(_("Cannot store %s"), stash_sha1.buf);
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
@@ -1944,6 +1986,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				run_command(&hook);
 			}
 		}
+		apply_autostash(opts);
 
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
-- 
2.10.0.rc2.102.g5c102ec


