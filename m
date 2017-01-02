Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C08E205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756262AbdABP1K (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:27:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:63947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755665AbdABP1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:27:08 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MarNa-1c3fHb2Fju-00KR6M; Mon, 02
 Jan 2017 16:27:01 +0100
Date:   Mon, 2 Jan 2017 16:27:00 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 09/38] sequencer (rebase -i): write the 'done' file
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <4f5b2b38d352c0abdc70fda55e6b47a8780a155a.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zUWILZEfSraMp8rduhjg8InyC7YixMVeUzbRhk+BbAjih0D5Qi6
 YaYTsTl4M/8hAgH1/VyP9kz0NgdbrnKlJzbP942iG+6HmCIx1Q32qO2bOTE7CjbyFrAgdZf
 poODLKUNBmIhFn8aG8iK7hHfs6HLiLP2tbGly8HZ+3r0jyYdF5EO8RCGI1tlL0crVzd+uRo
 6pSvzOKkgxz5dlFpnTSKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D6OBaZgcMco=:KMWPd/Pm89EY+V2SW2lXX0
 L+TfSc8APRhoj1ATzxNzinv6+cpeGx/FNriHFrDAlNfhkKNVgyL4P1yrCUB+ANF82OAhE93zt
 20OU+okBH5/O1o9yz7Yb7HoUmRlKbSqo/qDLhxeS5WYI7xwS6wFs6OiynWxaivw9fofT7Xony
 ikeWsuCwsUNywzDqiWrPgbFgCTp+J6OYjHipb8cTOhlsJa2wFz7QaDKbOAbMuL/mGljz7Sx4m
 fAoaLVIqx7DLUuFTPxEtQNMOioqA6/cgFEn+G1MfZWN/kAlkRwBpwW1BsRPhUrwx+NKGA4o+u
 RnGM72QC/Z6eOMgO1K/A+c3RWiCziSiynL3xIr6hrqVmUJT3Q7vz6nPysPlR0nyOGIflyIMao
 G1Ap62XjJXxPuC3jwOZyEKVyPXfle4SeQMWK121PVCXi2NS3ysCO7rS/fvI6QFwgcJRrHVEo2
 RL4B56JhAGTEQL0rT/hG7O6rT3hac1jGiI7Udx7T935u6xL0C2AoRq/So62VYFpFhHVHeKCyJ
 5jhlv3amb5JR008M7G8oud39x5KxP4P5eb0YyC66e6vt2yvrHStq4mGpCzr96e+5csatYffdD
 mkm2c9jRABoKu1KaRxHowQe+e8vrKbCayWG1mIgG4w/PWbmIX7RdZJzjTvo1+9xFmp2Ly3O6G
 ePBid8qN7vJ1LrzqOEsA0m+AbvHy/SMJ0W7kD9ZEaBGcOuMjttLJc1UQkktbJsMCOkpzOi21w
 NJvF26ggtqDsUF4g3QnoiKF1OlOKUrU5KN6K3mD+9ExUIJ5oAU6JAHjeoHKgA2RWt35QJDBcT
 6tJfbWp
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
 sequencer.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index ddc4d144d7..8ea3d6aa94 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -41,6 +41,12 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
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
@@ -1296,6 +1302,23 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 		return error_errno(_("could not write to '%s'"), todo_path);
 	if (commit_lock_file(&todo_lock) < 0)
 		return error(_("failed to finalize '%s'."), todo_path);
+
+	if (is_rebase_i(opts)) {
+		const char *done_path = rebase_path_done();
+		int fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
+		int prev_offset = !next ? 0 :
+			todo_list->items[next - 1].offset_in_buf;
+
+		if (fd >= 0 && offset > prev_offset &&
+		    write_in_full(fd, todo_list->buf.buf + prev_offset,
+				  offset - prev_offset) < 0) {
+			close(fd);
+			return error_errno(_("could not write to '%s'"),
+					   done_path);
+		}
+		if (fd >= 0)
+			close(fd);
+	}
 	return 0;
 }
 
-- 
2.11.0.rc3.windows.1


