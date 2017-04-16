Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29FEC20D09
	for <e@80x24.org>; Sun, 16 Apr 2017 16:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756400AbdDPQzl (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 12:55:41 -0400
Received: from mout.web.de ([212.227.17.12]:55766 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756302AbdDPQzj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 12:55:39 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLj0-1cXoMd1IgI-00YhcS; Sun, 16
 Apr 2017 18:55:33 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] am: close stream on error, but not stdin
Message-ID: <309ca90b-9f44-c2d8-c377-98080369bc05@web.de>
Date:   Sun, 16 Apr 2017 18:55:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+3ISM/QvxGJnA46GPm/s/TFixP5Lee+uO1dm7bGN3wkmkMyObe0
 hNZyXzS8KBgWatjCnsgz5P47CbPUXoNlpZQWoFgQvo3fKoR3Yqkgk5khTkZpDU63NHOxxlB
 Np5AP5wrR/U8wLPtVWPoS2K++tYD7K12rybqOL/KPMS7E6qU/X2iKPj7ehep5OaB/6xi7BO
 D62yu9OvI1qP0ZAIzkfzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:giAcrDWa9e8=:xagyxcw5dyBlVLjEHvBOIp
 pn9QXKVlfvXEjKlIU12BvJ/45sz7Oix9k/JJmcbbQR7ej3K+VBkFG3FsreabL/BQUrFxsViCd
 kNkouTUsNOFCfwxMdbU9m4nVyTP9pOP0y5MjK1oMvJnG1qfxYmthqRdsAr9E5jkFgy74rDg39
 I/U+AfeiRGhPuFqfKddut/vKtqPMYmD+qTonmAkn0F1YdfAW+q1Y0U/zw7BgD3bIGjvZI6CB3
 LTSwoOyfxAwhAoEoX3cgyn4SOMCAP6xNRGl+q1mTPOG8hECIoejYGJ9yjtpwkA4YCk4DNei1d
 dj2d/3cLuqOo7gQeClvUSqGXMRDYvUruTFeeSgJx8AgIa99f0bfgOz+mlsya3cNdFXwNhLEa0
 JxLfi8+pehv8eK4qoiLbhkzyb/jZYAUAlJWj9L8+C1R8urDtvUu5xbKjo+nZk1Xm32dDw+Frm
 0z+4Fekl8buNGxa+uGFgW7/PClZwBHUcqeVS2oEwDSJugHUxdjl1I/gEsyozqB6a1O74njXlG
 wvd0s6ahAgVnSQFVOpjKf+jCmm4zVsyD2YVHlAA5bJ2/AkpHbt4nLYwmwUMzvd0WyR11jNi1p
 bN2xQQ2bGb8EnTbYQQW9cGbwgwyFq1+b+HK80yKAoJ1w+fKt2wBY7jIJ9GkVS/8WzRYYwKhgR
 xtfHOp6B9ULkfxMozjAk8SbSvar3YmeCjrPx7Up4bfmD14RFuP9+91oxQJiKDyGPc/HOdu4c0
 XYG//tvmZBElT0AlLdY/Q1m98TNt1aJ8DcxQiKItw+CKYC0AwibBwkB9BznxO5dNSPYabeJTW
 GhI79Ch
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid closing stdin, but do close an actual input file on error exit.

Found with Cppcheck.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/am.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f7a7a971fb..805f56cec2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -762,14 +762,18 @@ static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
 		mail = mkpath("%s/%0*d", state->dir, state->prec, i + 1);
 
 		out = fopen(mail, "w");
-		if (!out)
+		if (!out) {
+			if (in != stdin)
+				fclose(in);
 			return error_errno(_("could not open '%s' for writing"),
 					   mail);
+		}
 
 		ret = fn(out, in, keep_cr);
 
 		fclose(out);
-		fclose(in);
+		if (in != stdin)
+			fclose(in);
 
 		if (ret)
 			return error(_("could not parse patch '%s'"), *paths);
-- 
2.12.2

