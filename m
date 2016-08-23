Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829612018E
	for <e@80x24.org>; Tue, 23 Aug 2016 16:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbcHWQOM (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:14:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:50393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753466AbcHWQOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:14:09 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Md3ZK-1buJJk0WW2-00I9ge; Tue, 23 Aug 2016 18:07:34
 +0200
Date:   Tue, 23 Aug 2016 18:07:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/15] sequencer: lib'ify save_opts()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <7768b55e65c771a5615a6f1209b40395dc705425.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qpJ4QQvFV3BMpVdgv0XltQQETy88g2HD4on9bFKd+NPSYDbYj2p
 McWeTZmVq7+lZE1MyACroDC7txfPK8W2NQwWh0gUKcOAFmVye5o+XK683VD/+lgNTx2/W0a
 eAkXDCoDDzP53Sfzi7DBewvBOQ45frbabhps+Kmtku9JpTD15i0849pOIHVmIc0eEZxD5mh
 aci633drGXUkARGhJ2EKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C8+5i1ZS7G4=:BzwfStcYTmR+ZGPiF/7nUh
 7hUBGnRyD0XSMif6P7GyYXyvVdwJEPh0TwWXgIQBIyiZZ/J7OxyD/oIGOwfCITsmh1/cJE4hJ
 aNAIoB9sOrmhkyUlNB4ezrD+eM+Vi6pdg/gpp1YcrnJ+qoZKb7YiNZrL0F1suxZ6JRtrOB+xV
 orUyWzD4VoouSCYxCG1fifDaSK7oW0vcYjMuccA97oa5EXf1m1foIBYKcUDS+9Zb8KxR9OWJP
 YPEgmFm16A69h3u+fIHZLNq5WV7hgF0GX0BL+8VVqys7VKuLXAcBANqIiChjuofsvo6UYfFJH
 O7Q+s6uJjNiivKX41BCtqvQyFqJSzWGzRcHPKaet9JtIVcfLd8THuX4FsP4kT1la/vzCUcWfv
 iT+WnMxSOdaGwynhczpKRx8W95tLK62iolpAnWAdRTQz1ePEr8gyDt/CTqyoKY8ASlz2doxka
 HV9K2pRDFBcvOfBwmON8JNQ6t0rqehYrKjevZqg98LMbZ9BQUbP2KYdbT5jJ4vaEKTsO9BXMC
 Csm/XtaeIA3InZkxn6NVd8HOeRwL8/2i5aWFE1uK4N8zt67mn+bboSSa38mF25mzu60e8yjFe
 P5XdO7FXkBL7+lPDKiDJ+ZumUwXJz8xGXJfMKh7Q8Uik1J8NE30x6lTrAR6wFPGQfEjKvLX6u
 Tb7VCvlGZINfFS7uiHTT9EJ/8p/q6uOUGoairt+Mt0G9zYASu+iGa3Q4GeLp2pwIFlhE/unvj
 /Lf4DB1qjSgMXmegzVbjEO0/oAE2ESl7BodUhNXUVlPtBlQKXvuxUItCtYmcJV4wm3p5zOxoq
 JI4LkeC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 17f2c8b..bac32ea 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -954,37 +954,39 @@ static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	return 0;
 }
 
-static void save_opts(struct replay_opts *opts)
+static int save_opts(struct replay_opts *opts)
 {
 	const char *opts_file = git_path_opts_file();
+	int res = 0;
 
 	if (opts->no_commit)
-		git_config_set_in_file(opts_file, "options.no-commit", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.no-commit", "true");
 	if (opts->edit)
-		git_config_set_in_file(opts_file, "options.edit", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.edit", "true");
 	if (opts->signoff)
-		git_config_set_in_file(opts_file, "options.signoff", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.signoff", "true");
 	if (opts->record_origin)
-		git_config_set_in_file(opts_file, "options.record-origin", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.record-origin", "true");
 	if (opts->allow_ff)
-		git_config_set_in_file(opts_file, "options.allow-ff", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.allow-ff", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
-		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
+		res |= git_config_set_in_file_gently(opts_file, "options.mainline", buf.buf);
 		strbuf_release(&buf);
 	}
 	if (opts->strategy)
-		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
+		res |= git_config_set_in_file_gently(opts_file, "options.strategy", opts->strategy);
 	if (opts->gpg_sign)
-		git_config_set_in_file(opts_file, "options.gpg-sign", opts->gpg_sign);
+		res |= git_config_set_in_file_gently(opts_file, "options.gpg-sign", opts->gpg_sign);
 	if (opts->xopts) {
 		int i;
 		for (i = 0; i < opts->xopts_nr; i++)
-			git_config_set_multivar_in_file(opts_file,
+			res |= git_config_set_multivar_in_file_gently(opts_file,
 							"options.strategy-option",
 							opts->xopts[i], "^$", 0);
 	}
+	return res;
 }
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
@@ -1128,9 +1130,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return -1;
 	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
 		return error(_("Can't revert as initial commit"));
-	if (save_head(sha1_to_hex(sha1)))
+	if (save_head(sha1_to_hex(sha1)) ||
+			save_opts(opts))
 		return -1;
-	save_opts(opts);
 	return pick_commits(todo_list, opts);
 }
 
-- 
2.10.0.rc1.99.gcd66998


