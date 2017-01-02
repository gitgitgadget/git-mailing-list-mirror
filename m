Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241F3205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756258AbdABP1I (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:27:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:49513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752971AbdABP1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:27:07 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeNGL-1cs8x32e8z-00q9S4; Mon, 02
 Jan 2017 16:26:56 +0100
Date:   Mon, 2 Jan 2017 16:26:53 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 08/38] sequencer (rebase -i): learn about the 'verbose'
 mode
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <6111bb6e05b82f4692f894c75edc8985aaf8d437.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:t64vn0unyCIiIaaxmnIHNZupChLytK3WdIedlas5WxT9zIkpnr8
 gGp9cAEkovnlxP0SswJDWsjADoiGpxVF3pxaO2wtvX+LxiFcb2l0RQxSWMnK45JwRg/c7GY
 v674Op9kYsaifxvAVbq4ai/spVbL9D9qjT/8DALYTQLNOUPLzTu1lwh6YHkcLgodsRyjVdW
 kLwq1HdeA73PCz60P75fQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T0XsObLC1uc=:8rIWcX3Z+kPckY6GrMQeTM
 YMrFKhILgOiOEjF8Bx7YRjAbtSkO7EkgPZPjYVCPjGn4QU4Mnb3+5WRBtjLMK0dAPE270ehLK
 7wn9w0ryOt07tG8gvHGFLwCLt1GIFdub/vnWPt7cywWHG09VoSB+/xCkwjCrQ0FtRaT++3o71
 /C53KH9uy1B0nZJ4H2fTmivc08eui38e9eOBiWE6U5LQC0xtq9ReiYc0S64a6xSb6nYF9kG80
 ei3e8C8BijNo8igLNTapsHrxIq3x/siZC8tG878WIZsu1049HBGeYp0UlQPpdZ/dDkNMJ69n0
 Ny1nNNMpUjiIdORI36hm7Ujy7A+cVadi26XObBc+Jzyw97aNAKfc8fhkxYyHKH/yXgtwqGeU1
 Oa+UO+9oY4U7dhdvQqgTczm7/L43929rpGhdhJIbyFuAiDpTxFUU02auf8enpX04j45KsFl0l
 Owy1hIjIJacMBSsbOTZCiY7xzeVrIvS35fEd9BvHxbFw1kEAMKWjecb3SGiBd+8TjavbN+kQx
 kBgia2jtNtFsdQhbV0EbKMwyamLkrBC6xvunS29GK6IM6FsNSjVQZeIwI7DfxpI2pTi23VtNG
 9vlzYLsl2Dx+YoJp7jSf+wbaWO1TAw30oOrRcWVJeyD4hU0zrN+LjtQ0HptLIvvV5RhOveHeH
 2W5SlUHgYvv7GavjmZIAInhzvOvWFvmb6uCM6QY1WM7IEHbl2UruDgXDcvVkt6mNLCaIZ6+kk
 KwWGTtJ5nCE85Vyk07WuZ4+T1O3XrBJOKT2CUmOINtQq1FIeN+Z5cA6I5dHJMBr0I4QMBh+nj
 la6DY3Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When calling `git rebase -i -v`, the user wants to see some statistics
after the commits were rebased. Let's show some.

The strbuf we use to perform that task will be used for other things
in subsequent commits, hence it is declared and initialized in a wider
scope than strictly needed here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 28 ++++++++++++++++++++++++++++
 sequencer.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index e9c10d7fe5..ddc4d144d7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -65,6 +65,8 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
  * command-line (and are only consumed, not modified, by the sequencer).
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
+static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
+static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
@@ -1088,6 +1090,9 @@ static int read_populate_opts(struct replay_opts *opts)
 		}
 		strbuf_release(&buf);
 
+		if (file_exists(rebase_path_verbose()))
+			opts->verbose = 1;
+
 		return 0;
 	}
 
@@ -1491,9 +1496,32 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 	}
 
 	if (is_rebase_i(opts)) {
+		struct strbuf buf = STRBUF_INIT;
+
 		/* Stopped in the middle, as planned? */
 		if (todo_list->current < todo_list->nr)
 			return 0;
+
+		if (opts->verbose) {
+			struct rev_info log_tree_opt;
+			struct object_id orig, head;
+
+			memset(&log_tree_opt, 0, sizeof(log_tree_opt));
+			init_revisions(&log_tree_opt, NULL);
+			log_tree_opt.diff = 1;
+			log_tree_opt.diffopt.output_format =
+				DIFF_FORMAT_DIFFSTAT;
+			log_tree_opt.disable_stdin = 1;
+
+			if (read_oneliner(&buf, rebase_path_orig_head(), 0) &&
+			    !get_sha1(buf.buf, orig.hash) &&
+			    !get_sha1("HEAD", head.hash)) {
+				diff_tree_sha1(orig.hash, head.hash,
+					       "", &log_tree_opt.diffopt);
+				log_tree_diff_flush(&log_tree_opt);
+			}
+		}
+		strbuf_release(&buf);
 	}
 
 	/*
diff --git a/sequencer.h b/sequencer.h
index cb21cfddee..f885b68395 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -24,6 +24,7 @@ struct replay_opts {
 	int allow_empty;
 	int allow_empty_message;
 	int keep_redundant_commits;
+	int verbose;
 
 	int mainline;
 
-- 
2.11.0.rc3.windows.1


