Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951AF1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933761AbcHaIz3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:52242 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759169AbcHaIyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:49 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lg5kl-1bKoZY1YLb-00pfgw; Wed, 31 Aug 2016 10:54:39
 +0200
Date:   Wed, 31 Aug 2016 10:54:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/34] sequencer (rebase -i): write the 'done' file
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <516d2aaf8837c8675141cf9c330c18c44765b69d.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:trOXUwM10FSU6guyo0wLqV0wb9M7875U9mgsxGH0TBQHH1frPVq
 H+pYWi/htktwNeyzDN2qpu3Oz5CvkvVjGeQh4toktXLItmNQ7n5BMiRARcW0QteCK77CujC
 J7iI1wim5KdfhUCk7WugCRsMnpgGm0I5tBKf0Sme40yTtzJL7TCcFQ1l+tZnIMTSiLfy2pI
 RCp2t+QQQ6DVjawNtZnpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wAGVrEnnsiE=:5owruXBIR0Zi/72/DKA8d4
 RdD7RZDnQxi9m7toLP3YySDTEuoxxEKzyQ65+/4oUhlDrwInyM0RrrU0LYpdN9bPI+B5GENys
 auzaN6+gVrN7jLmixSoa4PIOKqhRedeJiaoPygVIRBS1UJ5IZZie3qGr/hWZALK4UbweMaBAK
 QHSRPP1dV/6jpcdNXGp+d1JqYy9ws61YzFPz8i6yIY3O61+1TItx+qY7H1hYTtwe3p3Pkrpzq
 X9rdHOa/k1MdABtQt8RWtkhBOHwg5O4fOVkWgLIJFP78y6jkbyNb5Sqz1jTku2jTYIaBM6clu
 Q30m/sRMIWL+yTDr12cbwhfYcMSL/noxNPqmNVBBdXKjEVFe5AlywFPzYjgV9fMdFAA7R3Crs
 wSzgN2ygfu2ug+a4UC+sLt10YFH1erF7/vlI9l/QblipQOAMBnUN8bNAHXLEX+g/9VbHL5iCk
 ohlNuLUIYJFpcY8635OQfqKAYi3HzuR5oLuoOIj4I4d/HpxUJ/dvxq+sSVn0Vq+u55zXrl39+
 5relET1+1qQXGEfcNFbRefW1l+isDJN9YCoNuvmp/GGWGPoxGh6LnCZ1055O5dgqRW9iSDz5D
 rsJ7gu0uKiCRgAp9z93vt3kbeWyMDyVMcAg/WKhGPcurCRSs8jCjbKqvH8fOs6SSsq4JjX60Q
 JUSts/VV8Ir8gLVezJrAdW3mPxNI872h5qZmiBg0RA3eDkCmcsFd5NmQCeFIoNT58yjtUix3N
 Ra3DvGODoB51lzAagUcKERwHhZEOL56D4i7ANpMkJOKoHzuMEpNCWhFn4hcQVQqZgdpEkQUMv
 N1IOkP4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the interactive rebase, commands that were successfully processed are
not simply discarded, but appended to the 'done' file instead. This is
used e.g. to display the current state to the user in the output of
`git status` or the progress.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 95c31bb..3bff3d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -39,6 +39,12 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  */
 static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
+ * The rebase command lines that have already been processed. A line
+ * is moved here when it is first handled, before any associated user
+ * actions.
+ */
+static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
+/*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
  * GIT_AUTHOR_DATE that will be used for the commit that is currently
  * being rebased.
@@ -1272,6 +1278,20 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 			todo_path, strerror(errno));
 	if (commit_lock_file(&todo_lock) < 0)
 		return error(_("Error wrapping up %s."), todo_path);
+
+	if (is_rebase_i(opts)) {
+		const char *done_path = rebase_path_done();
+		int fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
+		int prev_offset = !next ? 0 :
+			todo_list->items[next - 1].offset_in_buf;
+
+		if (offset > prev_offset && write_in_full(fd,
+				todo_list->buf.buf + prev_offset,
+				offset - prev_offset) < 0)
+			return error(_("Could not write to %s (%s)"),
+				done_path, strerror(errno));
+		close(fd);
+	}
 	return 0;
 }
 
-- 
2.10.0.rc2.102.g5c102ec


