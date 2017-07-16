Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EEA520357
	for <e@80x24.org>; Sun, 16 Jul 2017 11:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdGPLQT (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 07:16:19 -0400
Received: from mout.web.de ([212.227.15.4]:61384 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbdGPLQS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 07:16:18 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWRoI-1d7vMu4Bxa-00XYG9; Sun, 16
 Jul 2017 13:16:03 +0200
Subject: [PATCH (resend)] ls-files: don't try to prune an empty index
References: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4522dcd2-a896-4c41-89fd-c3f33a23a3d6@web.de>
Date:   Sun, 16 Jul 2017 13:16:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:0mt57FII86dcoIMh7XPsmggEI+VQ5xXjUXQHZmS1KUIm7GDdo55
 tspc3q8kV9rdr+yXQCbTczCDh3SrDE4UwOoZynKgwyJhJatxffmMzUqfXNbJHF4qwhn//EZ
 Vy3VRVV+sgfNr2noFMh4GHZKluQOXT2vGptphsTzZehm62mTp9P8PzNVZYgkux1ivS/sJ9y
 /MD35/t5iTsiEgX8FmTwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/ZYH4bsCCRs=:o6XvjayCAckuoxjrtRDbAP
 +xb1akXSrawql5894SmfeuoArHGZxwQCI/YZk6je6BekbKTk3ueG6Lj4fCQnLKZSmCc84eor4
 R6B6Pi6K+/QMR+WvVisFRsvG2P4QD3yGN5KjWTL6h1MptFl6LzIJqwSXo+SIMa68LOm0TWqs2
 7TxxHPWq3zGZazHGTA3/BETc+hlgBlw63YKeYOP39F4AFbz5Lm4edK3AKG+C6EwLSqGnOL8BK
 ZwVDJzywwKiClGlOFUV43MEWtRyhhs5JK2lj3g7wuBODKjMslynKTidxnJVjf1lJLSlaqPTc9
 GfgD5OCAf9osAjemPq+l+QISGzIrYgAS0IPjR5pm6dz66aAoftZhEprXGs2kA6CSTT5R+vz1K
 GsXmx6fVEMzGcPrg0PNIXEBhHGUiNCWKzBfkyLL4PvqYK9wYOEEN2Mp7Pung/hQyT9YB+V692
 jDvlcNTQG5zBKCTEp/+aJybZqYitz69KjeVKVPI2h2o8Ucyf/o6IAPenz7meF3la29J/atbE3
 vHM4OqlTAhwkZ/tqerGLwvsl34DDz2q2jdpDlr7rOzaYmma66e+E++awHwTl0t89Dj8iPuzG+
 kLb/z8ePbap2o0TBLjaSgVhRJHA07jlEY1RgoETTlRiRF//k0EgsC3/0EeVU0lJAGhM4GR+Kw
 hnBjh0aZIQnsO+HKUJmpwE4kyjp/WPwkN/uJ5K4ceiwpjwVhXCXWbUNUHOi8+w8OqPO7AvlQ8
 ne5YCSHRRHHNYwCiDWB/gonpw9oCrro6Hre6kodqo+5icV+H2TFOiWqjrIYnqLP7H4pRgseGj
 9rm85GhIcNQt2evcRB4SwivC37YeXQIgtkKDAcpF/2FUlYD6xI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exit early when asked to prune an index that contains no entries to
begin with.  This avoids pointer arithmetic on istate->cache, which is
possibly NULL in that case.

Found with Clang's UBSan.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Messed up whitespace when sending this the first time.

 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b8514a0029..adf572da68 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -362,7 +362,7 @@ static void prune_index(struct index_state *istate,
 	int pos;
 	unsigned int first, last;
 
-	if (!prefix)
+	if (!prefix || !istate->cache_nr)
 		return;
 	pos = index_name_pos(istate, prefix, prefixlen);
 	if (pos < 0)
-- 
2.13.3
