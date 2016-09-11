Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7270020985
	for <e@80x24.org>; Sun, 11 Sep 2016 10:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755811AbcIKKxR (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:53:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:53237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755778AbcIKKxP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:53:15 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MFu0Y-1bmpTV1AGs-00Eytz; Sun, 11 Sep 2016 12:53:11
 +0200
Date:   Sun, 11 Sep 2016 12:53:10 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 06/25] sequencer: release memory that was allocated when
 reading options
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <7654513b93b7126077243b9e16538facbd35ab08.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4P7srOg7bWd9TcpIzbQrqQAju3q/TPfFiJUxD/2ZcoumhS2WjkV
 ugMO8qluw1p3q3fhvmTz6yhLGS29XgzGfF7jcEKW5VpTxKAWv4GOeuMceZA0VnkiJgmqldh
 rUQ7btb5fXyZlyZRWlS9QYea0Aku/0/jRPV5+57h9860vgn3GhEip72ZkCif7iHf3NTi86F
 o3sKyT2dJnXDvCNAGRvJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fufIk2DjwEA=:mUcYBDy0P/xV7pK/H+//Dc
 SFuHn5p7eq35Wr4Tbfyknof5N/9tj/OmHeCdiTG5Cfa4QIjBGpbIaoF8wE3DsBv0qBwSknaVV
 3gIh/EkostOR6pEEmQohOR4szet+VYNzmRuRtcR5kjwB/3/RUrn0B0qlyQbIUtJvKthNps14F
 X1E2hlNSenuz6Ynk92ywBH8Y8yEk2H1rVL0aXHTVZHhGxP9T04YtqDjn644E1/q1XGDJ+745C
 RWcxP54dUGoUoe0bFBEXsRCbLwgrpv7ujfq7+b33OdC79cJUaOFcnslpxNPVUf0CTlpRTTStJ
 2hj5aoShali7HQeiVefO1pYQMNErvFtnAC8anZD7SRTxTt8tnJnuSZJ37bOLh38jNqWb30JBi
 5wvhghLFBPFDyrJQ31VJ89AZQ6sTb1dbhUY5KVJhol5OKNhc5I7ldNWGPy+RSfkvvmp6lHUn9
 Eu0MBH8mTBAN13QRfJlBqprOGY3A8dZ2PglMZ6wRKA3QtsXc2AKFtpC8IAa56gC4ZxeFJuAR8
 vJAreKDI/EVsPloyZcsAFtXeYtVtkeDwzhODnFlr7Y1feEGj6UA9/mqo+Z2KhNfpHEBr7HYoE
 mqOjClchklOSrwSaSnEsRcfdfYP6w3YRlCyW50n+LpQeDiP+s2DUL+nyAxgH6b52ckXRcFmwV
 9inYLHbfHee2MNI9Nu5VIGm6myyVgsWXYsJd4vdWxugSSYYzDjAIk8rcLaIe8i5GazbEjrKkK
 6bfhsxHkqQEax8PctP8Ub89dZbRrNLAbZ7musCwuT3TE2qglgtfzpOBV4fzMDV3/Jax2wQw+V
 1ekqLy3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer reads options from disk and stores them in its struct
for use during sequencer's operations.

With this patch, the memory is released afterwards, plugging a
memory leak.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8d56a05..3ca231f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -131,6 +131,8 @@ static void remove_sequencer_state(const struct replay_opts *opts)
 		free(opts->owned[i]);
 	free(opts->owned);
 
+	free(opts->xopts);
+
 	strbuf_addf(&dir, "%s", get_dir(opts));
 	remove_dir_recursively(&dir, 0);
 	strbuf_release(&dir);
@@ -815,13 +817,18 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value);
-	else if (!strcmp(key, "options.strategy"))
+	else if (!strcmp(key, "options.strategy")) {
 		git_config_string(&opts->strategy, key, value);
-	else if (!strcmp(key, "options.gpg-sign"))
+		sequencer_entrust(opts, (char *) opts->strategy);
+	}
+	else if (!strcmp(key, "options.gpg-sign")) {
 		git_config_string(&opts->gpg_sign, key, value);
+		sequencer_entrust(opts, (char *) opts->gpg_sign);
+	}
 	else if (!strcmp(key, "options.strategy-option")) {
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
-		opts->xopts[opts->xopts_nr++] = xstrdup(value);
+		opts->xopts[opts->xopts_nr++] =
+			sequencer_entrust(opts, xstrdup(value));
 	} else
 		return error(_("Invalid key: %s"), key);
 
-- 
2.10.0.windows.1.10.g803177d


