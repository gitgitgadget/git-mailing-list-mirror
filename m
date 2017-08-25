Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5598208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 19:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758131AbdHYTGf (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 15:06:35 -0400
Received: from mout.web.de ([217.72.192.78]:50979 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755040AbdHYTGe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 15:06:34 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKrPw-1dlJw62ctc-0003dO; Fri, 25
 Aug 2017 21:06:30 +0200
Subject: [PATCH 2/2] apply: remove epoch date from regex
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <205339f5-bad8-62a3-8ccc-d3b0dd1d6736@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5dd40b51-ac5b-6885-b7b0-f2a33045c386@web.de>
Date:   Fri, 25 Aug 2017 21:06:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <205339f5-bad8-62a3-8ccc-d3b0dd1d6736@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:nbbs24KbiRlRYN9xw/vyLyKGQQ89MnskB2LDGJqc6A7hdN5tZoG
 tc89UvMsSZDnbUdmInOiQ8OyH7xlPM2J0xif9l83lsVhqpTbkcmUgZGTx3uetsGOQ6Qd5V/
 iNeg0hdsqrA6/N+3bHnl55+lf1xioO266Rt+IeZknYiAMFn3XixPMD6UCAwpHKEC/p7BQ3z
 Lrg8s/7mBkWaGkg/B/1RA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zfG0DiZv4Fg=:CGqzDxwdCpfVw+dHGK9mVj
 89bKDe2dGdh3AxAQdtv6l+xZTGXRTAn4tLZD/XhO5+O2MC236NQGHQuoJ1JzWJFGTD62yzP9Q
 qM76XeaflFf46KnltFIEPTXtequ+5FeumBJFBS/IvwCjETDwbUc508K/3KgRh63ctAcGufRDo
 wN472gK7chTslsUbbn0KVrAZyp/68voebQxVdiH3x9c4mgCTk08F8TdJI+zcbvf8EKZMh1d8s
 ztU14YAPqfpHJb8TONSyV9iZsPY+svsMoekdIlynTRj7Ew3n9mTuFoqRpu1YlaonSj8/DXH0u
 MgORDn/otVforX8wwTzSVwlPwFvmSgxZXOhdMgHVkD/34FXllHSz+TPzoz+GhwxvwFhLEGjyt
 w6u3IJ95T386ojVqTHmjdfb4mJHog3PSibumZWNU2SiDKzU4iitn9wKq4gqvFu2Dx4UmMu+ii
 Zm3dcNvUsgRylC1rzZCDtOqTiPUd8VctJGvGThIVj68Sz3Eak4qWef4oHuDnRcCtc0fsvFQFE
 yq5jJSgCiz0BipAsQQMehhV9P2MGRuH3dKAGLiv5WbHuKQlLVQilRhJk3VA1VgN2bKYf4n8hF
 OB+QqLC0C1p8oJvZyNrAia5S4oaf2/z8pl2d9LuePKwfvgvE7gOG6A/xdTRjVOZPl/0WkcfTO
 63VpHbUFmQN7fr7yVSivzm3GMyCFFynFEwXbCBWZBT5iQUlN6rntqj32Av6vGOtR0fb95n9zx
 IoG7o7dAUduslYjqqQLiFP9RI33z//uoNSa6TEo18Fb5Gqf0L04vFigzP8H2PCfeMx4kdNULD
 CY57WsTQEy3Uyt0eeoa+0H1bEivS0CQ7OCWT3WAszncFdkQhUU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check the date of epoch timestamp candidates already with
starts_with().  Move beyond that part using skip_prefix() instead of
checking it again using a regular expression.  Also group the minutes
part, so that we can access them using a substring match instead of
using a magic number.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index e14077eaee..9c70b4040a 100644
--- a/apply.c
+++ b/apply.c
@@ -811,9 +811,7 @@ static int has_epoch_timestamp(const char *nameline)
 	 * 1970-01-01, and the seconds part must be "00".
 	 */
 	const char stamp_regexp[] =
-		"^(1969-12-31|1970-01-01)"
-		" "
-		"[0-2][0-9]:[0-5][0-9]:00(\\.0+)?"
+		"^[0-2][0-9]:([0-5][0-9]):00(\\.0+)?"
 		" "
 		"([-+][0-2][0-9]:?[0-5][0-9])\n";
 	const char *timestamp = NULL, *cp, *colon;
@@ -833,9 +831,9 @@ static int has_epoch_timestamp(const char *nameline)
 	 * YYYY-MM-DD hh:mm:ss must be from either 1969-12-31
 	 * (west of GMT) or 1970-01-01 (east of GMT)
 	 */
-	if (starts_with(timestamp, "1969-12-31"))
+	if (skip_prefix(timestamp, "1969-12-31 ", &timestamp))
 		epoch_hour = 24;
-	else if (starts_with(timestamp, "1970-01-01"))
+	else if (skip_prefix(timestamp, "1970-01-01 ", &timestamp))
 		epoch_hour = 0;
 	else
 		return 0;
@@ -857,8 +855,8 @@ static int has_epoch_timestamp(const char *nameline)
 		return 0;
 	}
 
-	hour = strtol(timestamp + 11, NULL, 10);
-	minute = strtol(timestamp + 14, NULL, 10);
+	hour = strtol(timestamp, NULL, 10);
+	minute = strtol(timestamp + m[1].rm_so, NULL, 10);
 
 	zoneoffset = strtol(timestamp + m[3].rm_so + 1, (char **) &colon, 10);
 	if (*colon == ':')
-- 
2.14.1

