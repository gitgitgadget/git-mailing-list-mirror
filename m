Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBD02082F
	for <e@80x24.org>; Sat, 15 Jul 2017 20:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdGOUVS (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 16:21:18 -0400
Received: from mout.web.de ([212.227.17.11]:55318 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbdGOUVR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 16:21:17 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8fq-1d6WyP2kFS-00SAqO; Sat, 15
 Jul 2017 22:20:55 +0200
Subject: [PATCH 3/2] apply: use COPY_ARRAY and MOVE_ARRAY in update_image()
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <ec78a849-36e4-4b1d-1ad6-46dcc39a1396@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2b2c8a6b-b493-84b1-1e47-5ea4585610da@web.de>
Date:   Sat, 15 Jul 2017 22:20:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <ec78a849-36e4-4b1d-1ad6-46dcc39a1396@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:abefyfvRe4R6c5dvUDsNpLsu8eHD6Kg7LoRNks6rbQomKVaE51K
 DYKe3377N533OM7JAemU3vpQZf0JLlJCdpFEbzY/O2KFICs/DX6YHCgYNJxwznpQHT+Cmt4
 /gVgWr78C9lQZMovnOSOtQwEeBywSF7mtjddF6GWbhmvQTXe+uLioTrAWI1xGEY5yw2bM6D
 IwLuUzUACzZO0Ddw3uWHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XPxDhs776BM=:lwO9Sx4XG4EgHyxWVTd4xO
 HqAuP9Ie6vzyPLFzUoWDNNX0dybFITj2T/VZZ+ksYxNJvryLSs0DuY7zNglJ440Wlw5wT4l0b
 LfQS6tEOgTmcMi3ljApQbE3s41hyxbbuVztxDEsdOA9scD0jTwh+MTg6h1oNhREmPTM+TolBH
 qSzy7pd0HUpKLA4mNCvW50PcA1OpIAxel3EY+UgpOd+cRzICBS6X/U2/jlpyiJeUFdwCp4Wgc
 tveN26bb572189J7mbgsCSEkSmLafIIPwBL0clHDxYMA0Fl8PiuonXHpU7TkG5X8uHInwL+k2
 eZTlnJTE9RGQU9iQ91FMJCVIKU7cjMQZQLWVqdIi5SdqSA6b2BIMxVJ33MiRzp0FcQOUWxxBs
 CVasT1MsjkC5s9cmsecjluPkSDlAgxsrAfi9cSnC7w8drCZFd770+0cLsVLvwKlcDk+DjLxeB
 /f3+II22eAKBpb3cSxwb6tJB5MAXOXN+dqxaw2FlfEHsbcznOEjnVMrg/+UpLV/7WhypeDuqd
 qcc/sCnowPxfJWlhCXDA5Ry+PNTHJjoyACe9y+s8QXtb+A7A8i4Rx3xp7F3jh8xQAOZKNFuCK
 /euacsL3Vfv7egOQC94b9nwPh2hVVHBQRMymSz0E1P3VdjcLOYREkX62RdcCmvVz6HXJHFJKj
 rYj9jxjjcIwNpaDcs2QVUlIHpFxxGP3M2/f/MSZnBLx8EqccGXw5iEZhGS+0Ru2x1YhWKvQoZ
 cpKYkZAOD6On02l54ol29J4jrHSVpXei+JcEiPbzFqmHFCNTXzIUWjNKA63ep+7sQG4UwPwdE
 RkVXYK+CZRHJZ5aLMCPjIosKT7nY6wtjD7nCr5vu6tpuxNnKOw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the code by using the helper macros COPY_ARRAY and MOVE_ARRAY,
which also makes them more robust in the case we copy or move no lines,
as they allow using NULL points in that case, while memcpy(3) and
memmove(3) don't.

Found with Clang's UBSan.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
I don't know why the rules in contrib/coccinelle/array.cocci didn't
match. :-?

 apply.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index f2d599141d..40707ca50c 100644
--- a/apply.c
+++ b/apply.c
@@ -2809,13 +2809,10 @@ static void update_image(struct apply_state *state,
 		img->line_allocated = img->line;
 	}
 	if (preimage_limit != postimage->nr)
-		memmove(img->line + applied_pos + postimage->nr,
-			img->line + applied_pos + preimage_limit,
-			(img->nr - (applied_pos + preimage_limit)) *
-			sizeof(*img->line));
-	memcpy(img->line + applied_pos,
-	       postimage->line,
-	       postimage->nr * sizeof(*img->line));
+		MOVE_ARRAY(img->line + applied_pos + postimage->nr,
+			   img->line + applied_pos + preimage_limit,
+			   img->nr - (applied_pos + preimage_limit));
+	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->nr);
 	if (!state->allow_overlap)
 		for (i = 0; i < postimage->nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
-- 
2.13.3
