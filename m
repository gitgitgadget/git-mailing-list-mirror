Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB15E20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbcJJR0Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:57710 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753230AbcJJR0S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:18 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lrviw-1asDXy1FqY-013aBH; Mon, 10 Oct 2016 19:26:08
 +0200
Date:   Mon, 10 Oct 2016 19:25:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 16/25] sequencer: support amending commits
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <ec146dc2f3a3698bd433bbec4d7ecbab762c1bfb.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cpmICBQ/h/tQbjx476TS+6NmSoQ9CaNbnePCBV42dLUSJtfACAn
 7+9j5jFgxfEYsI8nOOGHU4tOk3b4/65mpMktpDHos5Ln0+PPBIqoMdkZ7pGJtl7Z+nNahYJ
 Nc4MyJb04ovrhszO/3YTC38EN47O0qMcPGFQskM1CkQfdLiz0MT+jl5nwKSnL6iHOXLF5jz
 MPDfmDUczvylA3kPesduQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RL3VjuU40NI=:dOCGbykwZPmxv+J60PRanv
 +MBQxtN9J3d2Gy5J75PqKwzbFOdFiXrUBUj1Sz2lsj4J0XXXeU5kDn1YdRUhDNtD1bglYcVR6
 3/JOKukqlKr5UQsCE8QN7utsmKZmc0uHFCAYpWN/0FjnuevKi7EOCLwAEsM9zQLA9keYsOfjB
 OA09szkfe6TUmAr6MkzWqQVdwFzurRiN9l4jF2ezOe0xtQR98O54eH0j1hVmI6B2YK0CaXY26
 ucoUliP7L4Hrsc7THwruybebMGQAvO1FZqxglGYlyhqXVaHOb1waFWprdehUVAzI+UIUrA8o8
 HyEQ8qLz1npRhzhW+RT+jSIwU7QvaykuhlLwYXhO566dDF5I3UZj5U/fY7QVMfB87lRZucgml
 Ti1PSMrYbaSQtMzQWbHxcTwlr1pPsh7jNYVHl7J50iOs5K1O5K/EzvfvG1bm+ac6zfOK9GSxQ
 uVn3Hzk8QYykTrJGXyNdDB+G/OlFDRWdchzD2KrolRcv0a9g9SHR7VwrVu4Rwekpmk8jwOMYX
 rBqroL/1jlGnvspYdIL2DkZLU3tk/o1YkmuTnyt/CI10wcKmmjpXP7CDNBijbuJ+LF7SgkCmm
 UfMhgdJ5FPTH5dYdArqbIsE+uzaU1egaXPM2b8bKsuCqRd0uRk9yG041DazU9YLnP58uzEfIp
 BBbtRH/B1yIrLKekaekdXw1oAGU4+ESJ0fhTUEhvgIaTBJqs+jYl2WkSJgUm/gD/eRfwo9KO6
 k8o5pLL+GnzZzxN6oK67H9UZWpZYkYkEXRtDvvonCrKbYESbHeAKBYwf7CdxFMXsAPlMOsr8T
 A4ctjAk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the run_git_commit() function to take an argument that will
allow us to implement "todo" commands that need to amend the commit
messages ("fixup", "squash" and "reword").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b621f4b..403a4f0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -481,7 +481,7 @@ static char **read_author_script(void)
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit)
+			  int allow_empty, int edit, int amend)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -510,6 +510,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
 
+	if (amend)
+		argv_array_push(&array, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
@@ -785,7 +787,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow, opts->edit);
+				     opts, allow, opts->edit, 0);
 
 leave:
 	free_message(commit, &msg);
-- 
2.10.0.windows.1.325.ge6089c1


