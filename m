Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FBB21FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 17:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758163AbcK3RCv (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 12:02:51 -0500
Received: from mout.web.de ([212.227.15.14]:64485 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbcK3RCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 12:02:49 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhQWG-1cYJwK3JEO-00mZXg; Wed, 30
 Nov 2016 18:02:36 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, eevee.reply@veekun.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] convert: git cherry-pick -Xrenormalize did not work
Date:   Wed, 30 Nov 2016 18:02:32 +0100
Message-Id: <20161130170232.19685-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
References: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Vg1q+2RFkskUNU+p2HE8Dw4TEMyScXoMM0eBQcOzJj5vUWj/FM/
 E7k2/HEZuU5Cduyrd4MYAxnEBkk66spplEl8BnGf+lKQw/df5jSxdr0FnZYirCt1nC+9EW4
 e4uMkDo4CBC8G0c6ZmWsGvYb0xdc++flHRwfMCFnc7nbjdyo5evdpiizLm95dS9JS52LLQC
 nL1x0f+2hktm6CO2oSrxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ol3e5XYQ7sY=:zNDJexIBm9+LYJUhf4lSms
 W6b1EFgv5qtFyiu+qt6X2zNXDLM7jo/24isG0ZYJro2SlP7HpCtPUNtdU79txvwVBQTPdYv4K
 jl9/ZEyyumKI1XeCWrGA3Hdz6mo5BM8XAXkwly8Air7TDDBa71zzJ/p3UxxpQ0LgKZNwcs8Jn
 uyMUkScpDw53HbPvouv51Q3F4lTpILyU+B2Mpob4ULdzzm4ljC2yp3vTTWiQi841WgUOCzHCw
 Tqze9/OP4jcxPuTxhAgdVDdXtbY7Jy/d2lqFPH9t0Bo82RfGExWmXDtw7nyqTEiMyF7BNm9Y9
 J3XDnFWdyHfaxjfGl5++HJl6/hWg7hPKEedlK+3ez91WsMoA/crEDClO48Xv1Nz0zToLdRj8s
 ySJO77L3RBqJQ36wuWAHQd/Q0uaimZhc7EmI/jNyIlNVgsbcHGi50JT1hZyEXmvZ72h/2GDLx
 nBcAi4W34noB75upr4an+kgwPkfeDfdqVxCbvc691FBbw24NVUjULgj3sqOc3wUYpGIEWd3y7
 WxvAUB5wMBoGQj+t1DYx4bTmAofrCZBGN9wLsWmOHnSdNkSfnNJyyExvb4JdSAxT1d0hixHKA
 S0X0OlfXM+sIvlVudFIS/v6q/6TscR92nESm3PAEAUsinvNMkKRH9VrlomLejxsWJkgJ0j2ya
 2tOIraRGM1SQ1qGohmCrW6UYMrbudFi0Bp/5Hrtm32JUxBLsEE1heAdmooHEDLflWWryjYMtf
 cC0LYGbxzZGG/lDN11fwmaiHfdDUKQzpbK3xjnLYS8HA02PZnaexNOlFuzDXsaGVwyO3UUivX
 O8PZ8ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Working with a repo that used to be all CRLF. At some point it
was changed to all LF, with `text=auto` in .gitattributes.
Trying to cherry-pick a commit from before the switchover fails:

$ git cherry-pick -Xrenormalize <commit>
    fatal: CRLF would be replaced by LF in [path]

Commit 65237284 "unify the "auto" handling of CRLF" introduced
a regression:

Whenever crlf_action is CRLF_TEXT_XXX and not CRLF_AUTO_XXX,
SAFE_CRLF_RENORMALIZE was feed into check_safe_crlf().
This is wrong because here everything else than SAFE_CRLF_WARN is
treated as SAFE_CRLF_FAIL.

Call check_safe_crlf() only if checksafe is SAFE_CRLF_WARN or SAFE_CRLF_FAIL.

Reported-by: Eevee (Lexy Munroe) <eevee@veekun.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 convert.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index be91358..f8e4dfe 100644
--- a/convert.c
+++ b/convert.c
@@ -281,13 +281,13 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		/*
 		 * If the file in the index has any CR in it, do not convert.
 		 * This is the new safer autocrlf handling.
+		   - unless we want to renormalize in a merge or cherry-pick
 		 */
-		if (checksafe == SAFE_CRLF_RENORMALIZE)
-			checksafe = SAFE_CRLF_FALSE;
-		else if (has_cr_in_index(path))
+		if ((checksafe != SAFE_CRLF_RENORMALIZE) && has_cr_in_index(path))
 			convert_crlf_into_lf = 0;
 	}
-	if (checksafe && len) {
+	if ((checksafe == SAFE_CRLF_WARN ||
+	    (checksafe == SAFE_CRLF_FAIL)) && len) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
 		/* simulate "git add" */
-- 
2.10.0

