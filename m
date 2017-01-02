Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F05205F4
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756391AbdABP2m (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:65168 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756387AbdABP2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:41 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGWR2-1cJcYp0qci-00DEoJ; Mon, 02
 Jan 2017 16:28:31 +0100
Date:   Mon, 2 Jan 2017 16:28:30 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 27/38] sequencer (rebase -i): respect strategy/strategy_opts
 settings
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <71b0cfa8b619cebce4ff85f4fcd243a5725cb694.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DNw9PtZ3ZgA0rhVtTfWE2lCVN+NN6Di5AZECC/t3WzEEuaw7jQV
 okiaKBahj12STrIz+zuyg6OTM7PS5Riz8yKMjqSNupqo4drAls5PgoRlIqqFX9DiDRHUFL7
 +xsAVBq5Q7RMo5ld8IzIcTDcukCXG1vaG91dFrabK6qDodQ2+/xXan0gOVvvvf1n3HN46k4
 3bUwkbj2JcVwiHk3xSuLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I89XUeT9rN4=:CvvykESqfK9megzukXBRwl
 aPrVLUtO++PXwbtj2H+FcEBsrq2xaTqU8wwBTOngSFK778/M70K79gtGFWx44BdomHUuvw4Hs
 2yc2yN+mvOFDp7rU5mBwDEc97PUXC94uWI09dsqss4mH8Y3F1+FunpIJAcMWUBfYqn4Hbbz7l
 zOlKPH+nhGtoEjPQvIdbeDakafrK1lrui0e/+1VEVjRg88RYmuSKhdL/c86WIc1Mpm3kaxxPz
 S2jU3yqBN4bY7VWIRVkeL1a030XVNUbANViUGmUTDPl9N/AwBOxXhwy//hSUKNKQ6x5VuVP6I
 WldGd0mst1blzYYZwk6kZPrqtUXOEh1C6WHCtZYLT4xFILY4MAQ2aFkc01t2NX5PtZ1sfACcu
 Nk7TGoKQRCWOzaYUIsTHQ6Qwx05fPhcZNxvdD59Vn2vNSaIT6Ba6mKHtNcvB/Fsfj4VP2agLe
 9XL7evLUpJVgtYpnBQB2SjCYuTceYs3ma3UUrXG/6IVGkcAmh/iOZYJIPzZscV1ZcTvZWZO6g
 K7ftMM1GWWRhQ7mMwZcbzQf7xRTbmi6Wq1JQRIxUV2fMHhysV4prmy74R0lJEjzXVpduNaicf
 WOhm35oQCqZcq0JKUZJToCFX3H1Dx1/+rA3hEU8UwtyB/D5s6Tupobw2ZGm4WWrnXceOGPH26
 OkIk5hlhjOkEANB8MmN//HXV6chnd+7bdTz5JmgEx2OpsRF5nBqhTCcTP/nuHu9+pbeB7lWz+
 lfUCR5CaIvwKX8sUCezqYWTdpcbTxCSaiJnkduXuqh8wlCl7tqB9WtDTKefUoh/o6KIQ1jiJU
 R+crPbS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer already has an idea about using different merge
strategies. We just piggy-back on top of that, using rebase -i's
own settings, when running the sequencer in interactive rebase mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 06f7cebe48..04a64cf0dc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -114,6 +114,8 @@ static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
+static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
+static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
@@ -1368,6 +1370,26 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
+static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
+{
+	int i;
+
+	strbuf_reset(buf);
+	if (!read_oneliner(buf, rebase_path_strategy(), 0))
+		return;
+	opts->strategy = strbuf_detach(buf, NULL);
+	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
+		return;
+
+	opts->xopts_nr = split_cmdline(buf->buf, (const char ***)&opts->xopts);
+	for (i = 0; i < opts->xopts_nr; i++) {
+		const char *arg = opts->xopts[i];
+
+		skip_prefix(arg, "--", &arg);
+		opts->xopts[i] = xstrdup(arg);
+	}
+}
+
 static int read_populate_opts(struct replay_opts *opts)
 {
 	if (is_rebase_i(opts)) {
@@ -1381,11 +1403,13 @@ static int read_populate_opts(struct replay_opts *opts)
 				opts->gpg_sign = xstrdup(buf.buf + 2);
 			}
 		}
-		strbuf_release(&buf);
 
 		if (file_exists(rebase_path_verbose()))
 			opts->verbose = 1;
 
+		read_strategy_opts(opts, &buf);
+		strbuf_release(&buf);
+
 		return 0;
 	}
 
-- 
2.11.0.rc3.windows.1


