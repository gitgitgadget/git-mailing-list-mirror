Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EDE22042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934210AbcLMPcm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:56585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933247AbcLMPbw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:52 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZkic-1c39Fy1PCA-00LXq9; Tue, 13
 Dec 2016 16:31:48 +0100
Date:   Tue, 13 Dec 2016 16:31:47 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 24/34] sequencer (rebase -i): respect strategy/strategy_opts
 settings
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <a21233f368f066408051e6bdc9a2b6ec513e9e11.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ONxQv/Ji8EXcV3gLeXArTErY6LauXvB4cppjrnCRp8l36MI1nVq
 rFzoPH9qWVgB6hfQgt7lJ8HlcooIjdp2auoC1dOYoxEnPtAV5Zqye9dL0fpYrVwtOTV+0CJ
 QC65nb9cmWf3gc5CIyIr5uMR9HhGtsttLXIJQXq2och2rKQGwPrt2kK5x3D0b2GSqMqD9qI
 TeH4tZKDkCuVhauwagi0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Yb6yJ8qBZY=:CbupCmU9KCTRErwRBzg5Bp
 davThkuZwnX480ukKjmW1A8fFgG//YUL2+/cnGgNYE4cVO49q24pVZnCALxBzGP/ZFo/Yfd3j
 OvlRJrj8G6KEjyFvGLu09YHVs17VgBeZbIDVK6Ecp0U/myyOtfM2d5zgrBU+n79lpjT4b612Y
 cPuRXuoa4Zf6oGyIpTKaQz04e3SkWUUfr2uCNBh2XW7/bAH+rjbjDI4cv+uVP/iVbX++07AE8
 avN2/xU9NJvQEAJGbTreoiWr9YYLeCe6H1XWQT1pFlFwBdI9NIbEAPXf430o0EHwDnkap8a76
 NEYziJ/pdBUyV3m2lwj0OLBCBumMyK2k2xY4vh33Zm599WtTgsOT4v4J4D5lQnTt8G9ugifbT
 HTnKhOEfdt18JNipRCfbOAKCs6mbTGFXXss3UFCZPo7GzhiXEnVEjlcOm1TcI31jA0O0d7ZCq
 MSD+L0Tb4jre78zk5jyxT5qYiWGVtmUoD1/0ay5/+4V05uezdroY+emRGW+u2FxaHmnVNv8+L
 rg+vfsMmpf8ok2XUGceOAi+UmxLDkfynqNmq/hivfP0fRyUeKW+88BLyHXdAMle7thC77GKWH
 To6Xioi3c7ZGhx6uh16QqouK6ul0uoxFLwx+rZFzQRRGFMQ08oIjt2UcANzGzRRKrSKHJDtrT
 PzvfuJwZCQmam+gf2rAGVaKPgUcs9OsBfrfXVK744AIYoAW2Kenz1WqyHYgDkFXIjZWa5ASlm
 kuZGaUSYtQGDrkYAT0JaYvQsRYmG6RbXs4vnoRz1ghBY5OrM0EzeGqyZBlNcU7y58QlLcmYS9
 gJoM0cF
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
index c11eceb70b..a67ecec961 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -112,6 +112,8 @@ static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
+static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
+static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
@@ -1408,6 +1410,26 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
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
@@ -1421,11 +1443,13 @@ static int read_populate_opts(struct replay_opts *opts)
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


