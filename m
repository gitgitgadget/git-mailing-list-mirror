Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418981F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbcHaIyw (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:54:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:64306 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758979AbcHaIyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:39 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MgtWa-1bRs7u451U-00M4Np; Wed, 31 Aug 2016 10:54:35
 +0200
Date:   Wed, 31 Aug 2016 10:54:20 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/34] sequencer (rebase -i): learn about the 'verbose'
 mode
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <68118621a481d786dd57d5c7fd4c3ea0a8e61b07.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9WkFY9dynUfGbvrVZTZtCrYcuPOsWL6k8/KMN+fw5IDMtT3PH7h
 kqBf9B1RJY4XcOn3e7aOIna5a/DOSSWXpECzpli6K4u0a3OdYGXx8HYWB23rHhPstqNqlzu
 +Sv2C0ClzF1H/z6ukavY3rH5ng6bCsOX6A83Ych/pyvufwpdTwt2V7OpFqpFL2UlwmEsrjg
 kQAtiQ0YciZy/W7tIZ+/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GAF/P0WQS98=:1md+KazScmYNThqbK1rle6
 YvStQYaQUYlVSVJNhB92zBWMch7WTtsbeM1fKKyNRgA/jhIs36nUFKu4wZFEyQcQ20cAstmMW
 U6nizU5aGNKULoHgK/4rtbqGuiokwEsmpIU/e+oHFmsHhm1g/JV9ANkb20lBzRWBBQ2w3qwYD
 U+5kU6Cd/2E9bmCb1w6e54+tKjQ0Zy2u1Hn3NKXqhd0BvTAF6hueEzv83aGRKA7xUDHcbA/SG
 r5nHh9B5UGjFQm9Ad4AmxvX8TWz9/Asy+Fkd/CzC+LYsLL8qQz44XcaCsxLqNwxfyXqDx7G7G
 D8nkkXEYjwFVimMzSKAkFIzFSLCe4x7Ydl7p2HdFo/FTVK6HLigi9FKeS/cYeladsWA0+HyAc
 Fzv5QjRDakVO3zEHkAKNutlKkTObidkdgXUZRBgajFcQAV7hc+HW7n7Ay7hWuUyF83H3BITwi
 KpquJDetbm8uB0SlDvGVX2jRjkAaRlbRJvhGvE53V9GXmtbr0nvb4Hk0bxHxTZsadpepvVW7I
 d5mHP4TON66/KwLlIwbKQsW9qGjwNFXgUOOlqZYUOMn41e+Xw0EBM7NKtJkG6MPG/EwYMo8Ir
 aU0r6WGaVwMLvTk+FrPJIdOmMLE8GGq0YxTL2S27zJuifMyEaG7EdHamy9QCsinAdEBwJedVv
 YRd479XBsEQMrSdjhN3fy+qHAvWafx0arDeJk6vneHKs9BCQ7KK7ofUeCynnzgwxtdeFvnZ7d
 UDvxbbew7w4dQeHvjUctxuiolQRRNVg0Cy6/sS2270t2zqBtQAnUPykPLJPybVdX6PanPSd3K
 OuEu1ct
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
 sequencer.c | 22 ++++++++++++++++++++++
 sequencer.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index a58bb91..95c31bb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -63,6 +63,8 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
  * command-line (and are only consumed, not modified, by the sequencer).
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
+static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
+static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 
 /* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
@@ -1096,6 +1098,9 @@ static int read_populate_opts(struct replay_opts *opts)
 			}
 		}
 
+		if (file_exists(rebase_path_verbose()))
+			opts->verbose = 1;
+
 		return 0;
 	}
 
@@ -1468,9 +1473,26 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 	}
 
 	if (is_rebase_i(opts)) {
+		struct strbuf buf = STRBUF_INIT;
+
 		/* Stopped in the middle, as planned? */
 		if (todo_list->current < todo_list->nr)
 			return 0;
+
+		if (opts->verbose) {
+			const char *argv[] = {
+				"diff-tree", "--stat", NULL, NULL
+			};
+
+			if (!read_oneliner(&buf, rebase_path_orig_head(), 0))
+				return error("Could not read %s",
+					rebase_path_orig_head());
+			strbuf_addstr(&buf, "..HEAD");
+			argv[2] = buf.buf;
+			run_command_v_opt(argv, RUN_GIT_CMD);
+			strbuf_reset(&buf);
+		}
+		strbuf_release(&buf);
 	}
 
 	/*
diff --git a/sequencer.h b/sequencer.h
index edd7d4a..fd2a719 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -24,6 +24,7 @@ struct replay_opts {
 	int allow_empty;
 	int allow_empty_message;
 	int keep_redundant_commits;
+	int verbose;
 
 	int mainline;
 
-- 
2.10.0.rc2.102.g5c102ec


