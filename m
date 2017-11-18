Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011D9201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424428AbdKRSKm (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:10:42 -0500
Received: from mout.web.de ([212.227.17.11]:65283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424422AbdKRSKk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:10:40 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyZi-1fIVUn01SU-012WEC; Sat, 18
 Nov 2017 19:04:43 +0100
Subject: [PATCH 2/6] xdiff: factor out is_func_rec()
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4efcd033-ab8d-7b0c-0c2f-8e5b5cdd5e0c@web.de>
Date:   Sat, 18 Nov 2017 19:04:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JNZj+C/22I1E6XuU4rgbJQPgeHay8KYKlq5D0B280dIHemcA6uB
 FoaesMdZpgmi/Icg2x/9YQsJJofccj3JJSev11XhmTFoZwTrYmyOHSZTR10jGUeUoj4Eb20
 tWeWy92oJgX+GQScpKeuhP9mHB0O7HZs9pFBJLjkiSNcbq25wjKV1wP9UtDNp9Ig/Xx5EVr
 YxS2ayT6HDKm39s2PcSJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:epRBlW3Bkc0=:Lb6iadZCn2TpgxjrFITCa1
 8YKTVTDOjUYZ4Wg9v29LwzMirsqOoB8wsuateeCLjr3sCWyNjNdrTbGEam0Fo7yA9MVULEZKA
 hzr9ulIs2jfk9rZX9yE2QV+8YPCZMo7Q5F9u4kN5c5orJAzkwS3xSrWiI3Z/XzKRufSWPi8wn
 K8VrCHniUkT6AWeG97ND4fH9LQiSOo37sJNDb/piUGx+0JbmIZr28F76lXRn9zgSu5DCBSXs/
 7DsYTBQTtC4heh/+LWmICXoFcNFrjx3j5hisvFLQkrbBeGjDWoVBAuNfCLBRb3H1HlYs9sS37
 pfxFkuZhgvl6V1gw3LzSGiXtZ/8O5kI0auR8MhcEpNRa5ILG4YRYlHvnj45zbE+wV+Q7iseMz
 Hi1sVWrHTHGVHuWhYmTUlNuyuRpWcNdcrZeh/pTx+7tsYZk6mqx1xsCCZP+IUbuW8mOH3LnSs
 Q5gN/sJB1IpsH4qPpBgR9ntaHdl4CIJSx4TFWQN6AWpFKdx5cBm+EviKrlYNmP64X4CJjDPM6
 Iy/qc/KEkByvLgH5jfmLcni4ngUnPeLFZdR0cfPtgmZOxIgaE31Q+9/EnRXqL2+ehtsUapTLc
 i61qWcW5m4OOmHuip99F6E79WUl4G2qUKXfaBnYZ4yWVTouYSn1GKewHVkPfxvpCmC8/oZCww
 /avWisIPHUlRFrg3I2l/oHbwazXrJWC9/x+1WSvergetFogJ+Rc29uhA6EuDqi7Bf3azVRj9r
 gFmjNzIHLBtCnINCS7ojx/Mo2uCBB4o+SnSBQCe4qNWORQD3UqhofWcGIRCDUE2ul5OfX5bsC
 29Kfv/FvRxEdP6wboNxab4HYPc7AE4q8aSD4xzsvRNHWmx+Jpk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper for checking if a given record is a function line.  It
frees callers from having to deal with the buffer arguments of
match_func_rec().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 xdiff/xemit.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 6881445e4a..c2d5bd004c 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -121,6 +121,12 @@ static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
 }
 
+static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
+{
+	char dummy[1];
+	return match_func_rec(xdf, xecfg, ri, dummy, sizeof(dummy)) >= 0;
+}
+
 struct func_line {
 	long len;
 	char buf[80];
@@ -178,7 +184,6 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 
 			/* Appended chunk? */
 			if (i1 >= xe->xdf1.nrec) {
-				char dummy[1];
 				long i2 = xch->i2;
 
 				/*
@@ -186,8 +191,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 				 * a whole function was added.
 				 */
 				while (i2 < xe->xdf2.nrec) {
-					if (match_func_rec(&xe->xdf2, xecfg, i2,
-						dummy, sizeof(dummy)) >= 0)
+					if (is_func_rec(&xe->xdf2, xecfg, i2))
 						goto post_context_calculation;
 					i2++;
 				}
-- 
2.15.0
