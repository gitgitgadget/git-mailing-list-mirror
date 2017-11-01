Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32B0202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 17:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933224AbdKARDc (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:03:32 -0400
Received: from mout.web.de ([217.72.192.78]:58385 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933216AbdKARDa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:03:30 -0400
Received: from [192.168.178.36] ([91.20.50.251]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbJ4A-1dQ71S0s3O-00kuyn; Wed, 01
 Nov 2017 18:03:24 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] imap-send: handle NULL return of next_arg()
Message-ID: <2d466b78-77fc-fa2c-c5e1-7b8737a00958@web.de>
Date:   Wed, 1 Nov 2017 18:03:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:YnLx3QipkdU8xj99pK8QfzN1IjqhOVWhrCiRWeaRfc4sgsTrHIL
 tXd89ihlBrzAGfQYnZ9moePbIayzRIPrRvJVyXjtZ1WybsNtGTq7attu7sCsQxt+Z0/iXF3
 6sqCfYkZZV8khXLQLF4eQCZy7AvuyKFLyYo+3ts71KYvGCkChftiTbBKy9JcB/3kYM6ApS9
 3CVH5SGGZYrw20brMEBVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BiIt8y3dnn0=:KgG5lzNPyGudO3iQXNa+Jy
 WfdQzhYCiNGrqZvd9cfo9qg8WNLHcOqT9+SwKAwQ8aiwh1PTGIaC5hXkL7xRIdJ9X6nVqirEc
 zOeSWL0G5ErOmEeyMR//kYxKuc21Zgncu1wKr9jCsuELODzFHSWm8RWnfwCdG+OkMwDTLthy4
 EuIs+sGJTx+b1zkrAjqNnL3KFWUv89q0TXdjajgluNuXFNkS68zOXqgaOQfJGa6vbInWcJZ7c
 xJXDPQIT0he2BrCpnWj/ne1zCsZJTAuPArIlyhWpFBDcnxHd1gqQ/CmWODinb8IpYvzsk0ARr
 u8sW4GqxTii+DGP6F+5crySQAFyan380s4dVikxwEWhUoXrcupcKIlcwClj/bC9/pTlLypWeH
 VHuX3mvDm9WVvoa4uyY+YpGrXLL4RhejRIv5VcVKCAOJgR5+atVJ1WzLR2Swh7axMiu2851zi
 /b0hiffW436iCeHpJExU99ly7ZUOq0SS2p2K/JUeNHuOtgTlWNoffnfe/ceqO2NwmRa3pujs7
 6EG3RAhufq54Q8w6uOFPNK7kV214VxrUTxq2zLOl9Loz/ywwbw7JCMqpVH98+FmngYlFa1+OS
 tAnJg3aZ9tpuEDSGC9uWbSfWB6MXhsoT8Tvwr8HJxIhHaRi/HF7rA50K8UFmQxJF1793ZQp23
 FDzbgnpSw81ljNEehRj+Ub4I2cxeL6J777DHosp2HEvKkSMQoZcI3tl36LB6WDyFanzIjcGq9
 iV4QUOHt8hdCRFalYhd0Jqm+alqn+gtzBR6LiwFyPfC2LGKz/h5FWNs9IwalBYAh18QM1Bgxm
 z0cO9QRL7iCVvaMbutmIU0Ge76ghuZN4+0A29iE2ZxqaQ5K/BA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

next_arg() returns NULL if it runs out of arguments.  Most call sites
already handle that gracefully.  Check in the remaining cases as well.
Replace the NULL pointer with an empty string at the bottom of
get_cmd_result() -- it's nicely reported as an unexpected response a
few lines down.  Error out explicitly at the remaining sites.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 imap-send.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 8c785f3ca2..0031566309 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -693,6 +693,10 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 	}
 	*p++ = 0;
 	arg = next_arg(&s);
+	if (!arg) {
+		fprintf(stderr, "IMAP error: empty response code\n");
+		return RESP_BAD;
+	}
 	if (!strcmp("UIDVALIDITY", arg)) {
 		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
 			fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
@@ -725,7 +729,8 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 {
 	struct imap *imap = ctx->imap;
 	struct imap_cmd *cmdp, **pcmdp;
-	char *cmd, *arg, *arg1;
+	char *cmd;
+	const char *arg, *arg1;
 	int n, resp, resp2, tag;
 
 	for (;;) {
@@ -733,6 +738,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			return RESP_BAD;
 
 		arg = next_arg(&cmd);
+		if (!arg) {
+			fprintf(stderr, "IMAP error: empty response\n");
+			return RESP_BAD;
+		}
 		if (*arg == '*') {
 			arg = next_arg(&cmd);
 			if (!arg) {
@@ -807,6 +816,8 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			if (cmdp->cb.cont || cmdp->cb.data)
 				imap->literal_pending = 0;
 			arg = next_arg(&cmd);
+			if (!arg)
+				arg = "";
 			if (!strcmp("OK", arg))
 				resp = DRV_OK;
 			else {
-- 
2.15.0
