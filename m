Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2C1202AE
	for <e@80x24.org>; Sat,  8 Jul 2017 08:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbdGHI7D (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 04:59:03 -0400
Received: from mout.web.de ([212.227.15.4]:54321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbdGHI7C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 04:59:02 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeSLv-1dKjHN0Kjf-00QAf7; Sat, 08
 Jul 2017 10:58:46 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] apply: use strcmp(3) for comparing strings in
 gitdiff_verify_name()
Message-ID: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
Date:   Sat, 8 Jul 2017 10:58:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:hzPHXVCoU5FT9Rfeau3/zyEvmLLh4v9ZFnUhtbaHkkgmgdAbAsu
 EhiD/sJIcZ4AhgTp+MQP4LakHtl/lHPBYv4zzRrION9V0v2dfBQg6JbO2bK2t50FIRAzPaS
 lpRg+MMehUiBGBkPKQW92CnNWDpxIV3TBjA3mboHBcZovAngAM4dCBBm5x6FNXBxzPpXPnN
 40rokoqX2thUdGKz6fwaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xCOaPjXhGQY=:y9ufkAhsEQjWI8IluCXPSD
 GNNTIUXZC0lYwtsHCLlyRYkMYKelVH0+u5ZQFkfo5TL4Dxbd/7HpdkB3my0D27rIX6d/54cXZ
 5YXZtboymaZBEPxpeKOKgdenyUAe8Vt1D7p0z2U2SCFUAbi0qCWdGXVznecNYNfpu1VWUBTDB
 jAgm1XHiis5CZV3JV6E4lqylmnzqeCTy5xqz2D4t025LiK0SS/XyDnCDZKGyLQIm77iQiegEM
 7XDOj1eopVllys16zMuayLuUFLWvRx47xf4zTBMe7c6cmtAViMDbL+7Q+zZ/N+mqLSELUFhpb
 M8sch099hlX0h8oiap88ZbfV+iba4f5JhmBh6xr25UttSmpx2hazjLj8zdzrey3TGiHBz1ykP
 7K6tUPqZxEJ9buIpfu6lsXlp+0JIcW0o/5m+105thhgNHXboQXHBe2zUBpYOdC00xxK32z2Sd
 4D3uYk0Ha0e4AhhFuQcLv+1rvpiCTE9kNz6anVQUcARtSt872PwfnESvx9k4lpK2nHdojptw8
 EuQ5d6hUC6LD7QEBPfF5jROEhKR+LuuHGjxjhhoTHKG1OJu3Lvsn8l76ICZxY2SabV64/S8a1
 hnc5u+Z+/otR2SZ8txXC745CjfjxJCDqOUMQxbqSri6KPfV41iJ8pXT2KbRCf+uEJYtiTYu6Q
 /PMH2b4YQgwxDq2cLA6ahwc/QpazjXNo8jFD/+qh1r3wtIBNtXWN7Ipnn8IdQaWYszvR4tk0a
 iZPcJkHsqO0c46rYk+kN/m9JudgGKEJx7DQt5mw/YiEdD8EW3H1PvylYBGhHBU5STFBiDComD
 ggzQ26o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid running over the end of another -- a C string whose length we
don't know -- by using strcmp(3) instead of memcmp(3) for comparing it
with another C string.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 946be4d2f5..9b3df8a3aa 100644
--- a/apply.c
+++ b/apply.c
@@ -962,13 +962,12 @@ static int gitdiff_verify_name(struct apply_state *state,
 	}
 
 	if (*name) {
-		int len = strlen(*name);
 		char *another;
 		if (isnull)
 			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 				     *name, state->linenr);
 		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
-		if (!another || memcmp(another, *name, len + 1)) {
+		if (!another || strcmp(another, *name)) {
 			free(another);
 			return error((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
-- 
2.13.2
