Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBBA2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934176AbcLMPcE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:59166 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933614AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOwY7-1cEKaE33sF-006KLU; Tue, 13
 Dec 2016 16:29:53 +0100
Date:   Tue, 13 Dec 2016 16:29:53 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 05/34] sequencer (rebase -i): learn about the 'verbose'
 mode
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <1d1f8d8b0696769bb85dd8a2269dc281aa91eede.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UkeWLSzgw6TrZX0EufzWiFdn5A0b1A90QH7tT/fBbJY3jfWiPhb
 SE4ppYqiFquPqJZADXAd5tHZqX2tczOvFLcOMTkB1ldYMCwWA5SBx9PdZRveIUwfMsq6goe
 WA4tIA7zdFalauNghDDz9Fj5tA4ppxHyAdOs5KCeQf7a9JMie+yelqtSNS3scR6GY82HPfA
 IPUi7cXn+zWcPDIsQPKQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MiWvqqOA9p0=:xRbDkTadtW1jlH2+VMyZoY
 /fd6hp5atHhLGReyhJ03FVx/rb7yUwklJ230GE0dFkwTtkKQxzAX/eWTYo9u5pVuthYe6ReGh
 VdsOmboAScx03aO99f4p3FVONrzSCmrizd2SqZywCCBC/SMHI+5gn/6o82xCKbw/KVcLqKOkA
 rCSirorYH1OhpfhQWRy6aYTUpF3RyGE3y5YouZEJeSII1TXxjj1vA6DkUBKXXrlLBlHO0NT4V
 lWHF+X9mkLasXxivlutn52QFK9nriHf4mSW9knoGv/Uf88FyIkpLw17yEOLqylqXjobXypp2O
 PkFvFcqX9irIUkrjE8tLn3cDUDANhJx1EPIiJzASfrIiNJdJ6kEkONexKGUeQ862X/9CVg825
 /+sBiw+o1FDHJyaofi7ykIJ4wR8YSZ4a8ah+uhuQyq7v6rOP9iPObRbu6jxTP6aAt37gtNZvS
 +6C3D9CJNBdISloo4lKlbm3tqSTvVnx5T9CBKoLHc0/L9ysTKsh8NIEvpJ8sclUPRJ4QYPJOl
 QhWS+DWGUEmtwD0PYaUjoEwcaORgRtUEdp7dMsLk3mZW0T/TywYJX9zjRqeuWcHT0ehXUqEyA
 Njkp/P7Or7PIZqmw58ONeF/EOSEHOD3kwcbUIBHFSyPGtVkD6GUmHZsOl3CBC0Q+lSSGj2S7a
 EMFjSUmmrfi75alHkKZmuhU6oqfYkHlLy9dHfM/XBVCShfehJ6o9r2GbCCvWP/ZuiqvmmDCun
 CWCfTuM5y5wQ5b1EFW+G5NAefIDop3pfXN1qUEWIfIFUvrgg4TYOau8oaN4mP3ee/VEw+K13u
 6SsRr/b
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
index 700b7575ed..1ab50884bd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -63,6 +63,8 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
  * command-line (and are only consumed, not modified, by the sequencer).
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
+static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
+static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
@@ -1121,6 +1123,9 @@ static int read_populate_opts(struct replay_opts *opts)
 		}
 		strbuf_release(&buf);
 
+		if (file_exists(rebase_path_verbose()))
+			opts->verbose = 1;
+
 		return 0;
 	}
 
@@ -1493,9 +1498,26 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
+				return error(_("could not read '%s'"),
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


