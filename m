Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416AC20281
	for <e@80x24.org>; Sat, 23 Sep 2017 18:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdIWSE7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 14:04:59 -0400
Received: from mout.web.de ([212.227.17.11]:56167 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750959AbdIWSE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 14:04:57 -0400
Received: from [192.168.178.36] ([91.20.61.209]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbaBL-1dXBGz3jnn-00lB5y; Sat, 23
 Sep 2017 20:04:42 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] mailinfo: don't decode invalid =XY quoted-printable sequences
Message-ID: <d48b3d67-5f03-19f3-5a32-ec7e8397c98d@web.de>
Date:   Sat, 23 Sep 2017 20:04:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zbsxayigZ2i1sEorbXI4HuhEcY5LatbDB3h/BNEy+LE2YF/2vmX
 Oa7tySshAsrNQJakGXoVvEFvm+1A0z1C4YRxUFh3PRmkIIDarcaagP0AQujuxRpNSvabBxc
 os2gn4chXwbAsq+SBYkQz8GrtKfWJeIJm7uHH7ephGSn5F3xBf4i/o1IrVZOo+CO2mWBfzw
 4ZKh7Jn3kvJb3JjBt93MA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lH0BgBBD6ic=:ka7Cu2MmjK3iTLHGRIX4Pb
 /cGzAiWLtgaGTjlwAAsq9TMley9NtyKE3fRnwfg5wOZqd9aZSxQRWht4AWbUU3NdF2zCDiSEd
 ic1wuMiP23WuL0q6BpjzkAtKBxLjQNWBM5LH5vwXFNa1OKEECIBqXmsD2d/H/5YieGRAnF6ed
 kBsIE9Hq/edv/ojCumkzLPvuhAXEpYEKnlJ1WuCiADavyAz2YM92qGDC/wEfvaC+g2mD6LcKc
 /Wlxh+8sfwLVA5BY8tWzzcWZMRMvatOD7GyXDYYIVIZ4ttq7TjkGg0wMp8/ml6yWraGVWFmuF
 MuRMDjjMSWVcnRO2dwLodGKYkK9xr211gwOsAMFVna1Rw/1YdGYXV3KaFwzRYei0YYZMZOo+N
 a9vVsLVDtDsATjsmWliHa0c3UJaJC+YTEh9Ffn0ZB4COl9RreFxy+CZsHPL0gVKC61Hhuaz6u
 mTkPuoDOvEDUWsUcqsITBys/oeNEJ1mdEctODlZS0Kp2IC7Chclg7g/2vMtq/NDFeLu5J4FFW
 QZg3TmnnCGtuTui/2FcaOOeSidBuiD4+hZh/keDw34EDOG4Etcjyw/9Sn1Fj1427KlPwTiZQo
 zfhTALltKzhNYyoQnjFfL59cW3ev9HkSnGG31nc3WKaLn0g93yVE5it8Y+LSF8S6UDUsF1nKu
 bq0Kut5+XTWUxos9kb/UZAxY5v9SDiJhdgV4TPf8ko35hhZl6m2t9/pG+PVCJeylGfhGxHXYE
 ri1aVzBIi55P3R+83TJM1a6sSyr8/2JwPwPid6as6HkvWSvoZH/g4nShZbCLj+lebDN/innoP
 YCHKre0BH4yeqvVJzLXcNCj6CgyuqsLw77so5Qwc+vzXA4RlXc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Decode =XY in quoted-printable segments only if X and Y are hexadecimal
digits, otherwise just copy them.  That's at least better than
interpreting negative results from hexval() as a character.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 mailinfo.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index f2387a3267..3d8ac07399 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -367,11 +367,16 @@ static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
 
 	while ((c = *in++) != 0) {
 		if (c == '=') {
-			int d = *in++;
+			int ch, d = *in;
 			if (d == '\n' || !d)
 				break; /* drop trailing newline */
-			strbuf_addch(out, (hexval(d) << 4) | hexval(*in++));
-			continue;
+			ch = hex2chr(in);
+			if (ch >= 0) {
+				strbuf_addch(out, ch);
+				in += 2;
+				continue;
+			}
+			/* garbage -- fall through */
 		}
 		if (rfc2047 && c == '_') /* rfc2047 4.2 (2) */
 			c = 0x20;
-- 
2.14.1
