Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510191F4F8
	for <e@80x24.org>; Sat,  8 Oct 2016 14:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934972AbcJHOPt (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 10:15:49 -0400
Received: from mout.web.de ([212.227.15.3]:51021 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756611AbcJHOPN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 10:15:13 -0400
Received: from [192.168.178.36] ([79.213.121.94]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MS1tK-1bQiKR2wyA-00TERb; Sat, 08 Oct 2016 16:15:05
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Paul Tan <pyokagan@gmail.com>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] remove unnecessary NULL check before free(3)
Message-ID: <0528736a-d47a-df2f-fa91-8161075be487@web.de>
Date:   Sat, 8 Oct 2016 16:14:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kg8bBIuEJ4cO0fqdUSgaGoQudyLmHcT1k4M3W+Xvdr+r2H6mtn9
 nbNaWpuyQcmlbcv7ZNwdLpIG7J210+khGQd+LHn0nGQkb/mCcP8i/adkzWrk/5jJA37NVAZ
 TtfPhDfHSS/f2cayGhvT7YTTiK6tDJaAH/5VfSZnmVGrMynNGm8iBv9LSPoJ1a0gn565T8L
 SfiG07zcsFsRblqJbI64Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gpKcZjm3Xqs=:d4dmLu8D/aqlCPkwywESEp
 eAlJA+MhoemmLR+GRfzT8Fkkw/s9YEHZuJ3zJVWAq7N9ntDxeMwB0BA8zDJ0iWxrQJNSHTP0Q
 +LF9w5fkB9GPflW6ph4uluqMflF/bwdTdJsonfMIKEJVYQQR6I0Wr7BCN+0rBvYBgS73mooic
 7Zz5dFk2X3oagLmSZk5oWS+df46H0qAgHbRS1G/9i/i6sNxYFrc0OuT+X2lyDjlja2Dr/DHm8
 d6Ikee3SlTCjHQ+dCXlxZU2mgIF6BH9Fug9+/XAzRJLe6wXhIzJrx92kwT64vs8IIFNLPIysM
 zj2fqs3mQWNuajTOLbRdITUKDlPDQpoT9eqnbcGPzus3ozpQgRF4jCDOsKmd40WtH/DWQlEEH
 dq/c20aIplhTXwBVIPe+HKIT2ALMdl3TFC7GMD0ynwZDKiIWNzIrX6XGTdAy9ycSRV0DIaxAT
 nGwXWGVUxuIgV4g/X/SfPolbQ3gC9dsskxkR+0zrt9jqjmttUCeMRgFrOwip6FE35KqCZaY7d
 upF8Zfo3tjX95+vV8dnLtNKH8RwauWpwQpP/mnwZfoU7Hr2peCVuG1TBESysqFpXgzg43W6JI
 4zuh30ZXIsiPyX9q+O7JvK/AGGvKH9MztqoIRcLGCrnmUmd0qHnFqCt9dspwfDbKQUP3gX3+O
 3cfplWhD5MZ5gibcKPAHGDQGprsGRAktW1RQ2IK+yQRtGEUi8QC2ByPcSie1TfwakOdkfKenl
 lH0A42SuJUqaj0yozftnOPpgwrQ88P7fmUwTNOtEWlmv/nPiAp7nxs1um5sq3xyxQED9j2hTM
 +s7CnS+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

free(3) handles NULL pointers just fine.  Add a semantic patch for
removing unnecessary NULL checks before calling this function, and
apply it on the code base.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/free.cocci | 5 +++++
 parse-options-cb.c            | 3 +--
 2 files changed, 6 insertions(+), 2 deletions(-)
 create mode 100644 contrib/coccinelle/free.cocci

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
new file mode 100644
index 0000000..e282131
--- /dev/null
+++ b/contrib/coccinelle/free.cocci
@@ -0,0 +1,5 @@
+@@
+expression E;
+@@
+- if (E)
+  free(E);
diff --git a/parse-options-cb.c b/parse-options-cb.c
index b5d9209..b7d8f7d 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -211,8 +211,7 @@ int parse_opt_passthru(const struct option *opt, const char *arg, int unset)
 	if (recreate_opt(&sb, opt, arg, unset) < 0)
 		return -1;
 
-	if (*opt_value)
-		free(*opt_value);
+	free(*opt_value);
 
 	*opt_value = strbuf_detach(&sb, NULL);
 
-- 
2.10.0

