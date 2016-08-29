Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E982E1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756696AbcH2IEn (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:04:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:62658 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756487AbcH2IEl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:04:41 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LzskF-1azdhd0oTb-0151Rj; Mon, 29 Aug 2016 10:04:38
 +0200
Date:   Mon, 29 Aug 2016 10:04:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/22] sequencer: release memory that was allocated when
 reading options
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+cs0vRNIvl9ZcWME1S/kAo2kC7PHRbMIMGHAdsniQSObpNODVHC
 HlnEZXYZAEVMwtoDjkuCRmpM6MUBa5C0D5uy/2enNjB8LfzOFurO0KRin6662Y36Nn2n52P
 F2/DgzIfB0mozCSOAe7uMQ5SgvdaPWQ08HG1WN7tTGhKL4RbEZWGUuOkLMcjQju+t0HQ7sn
 9bnI0AztQEFOj9FH6V2AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3AfydxXsebE=:F9KYa+Ck3WFoxZ3AkZz+d7
 rHsdvgUgWmKf2+t6+lBI3PY6TJcuVNHe78+3CzggIgkdQKQc8FE+Qtpy7Zmy0JgQYZr3JmIfX
 9pyI3t0ks+DPAte1KsdN0e3QW2FRWNIiFLd9IyNNwUSDrmZk2ATYQjuR/nXs/3juh+2LXgz4d
 E/RPhXvogxkAJKzzfC8JMApBHSAvUYmTOZMI57tfyFEVvSg7doE3jXv7mlk03pGhfDfaEhx7F
 dSXBrmtX5O87yhlrSUW4BXRnYPv2Vn/0PS5yp3xmcz0hZvpIMXnQRHQ3OsJmkiYCMIKqsORu4
 Bg7Hfy/aFgu+vVkdriNyX1gCzGPzESBc4Q8gRWJLQO2WfzYKy+RQtzIUzJKLbqVEsGZjaouE0
 00ZAQd7rMoovgYqLe6a83Y/ogsz05q0tcTH9mWRW86qqMqflBXhYFKZGB8kU62g66Ws9FHPjp
 vtMahPqURDk1fl0gNzfzFoM7D8XOMcEqPqr9+eGoxoVk2u8kHoBBcFkW50q/odZ9xrt1uGHDs
 0+zDHDYv58u70isoP9ILUo+tA60SBtY10EeIRLmu5mdYW8jTsXdK2so6mbxtUzID6Sut9ubrD
 k/UtxrhpK/zXwspwBYRC02RQszeFvXStszv6sHKUHAN3LyNuFwp4qcUngkjWH8fvmFdIPTPBt
 CBqyOFdkKG4fjEQmJLR8DeFX5oaHeDARu46LKkJiFhBVyqqo3+j/RgYDEwSVVIxlW0Uy7hRVz
 nJL9UebHj4dnjSyy9gXFDb+oXVgbT008+ual0P8oGzg169k7dQP49MVErM2IOxyq6XaW2pNCz
 BIv7iBr
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
index b5be0f9..8d79091 100644
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
@@ -811,13 +813,18 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
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
2.10.0.rc1.114.g2bd6b38


