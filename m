Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210AB1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbcLHOse (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:48:34 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:32840 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbcLHOsd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:48:33 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so54850518wjc.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cw1xunSM8hiz/dOvclLOms+zHwnxJLe+QDa2qfwRNLE=;
        b=JKqU3+xwigcZ/Jf3kSXaztf5YqsvhAeUL1ujKiHm/ThdmkxNNtytsP4W0MxyMuMk3k
         CFP7Ao3lyLvriU0swtLYdpwGKlNOnVHVvor8L+rwC5BpRrxcPB54O+dEudsV+MT7i6Hn
         Ua+oiaXGPt+9zR7AQrLzUum3/4HOsNfKGCfr8qAlhHm/TOwuA18vEVjXP+GmJimSuJ6j
         a1Kyez+dVw4vjmRfDKEmluxFrc+KUoOrc2KgqQMec/EBpXhHwX0ohJzmW2V0GHZc1Yf1
         bnD8BnrF+bAC2fNJu6fpPOPF/SRuGBlJycgUs9dEg4OBI7uStpXdqI6OCFYZtjxMLR2u
         2axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cw1xunSM8hiz/dOvclLOms+zHwnxJLe+QDa2qfwRNLE=;
        b=QG7QCJ550dRiMo8Kk8dymlnLBW2JLhZYL2xtcDncBIIbhLCYtvT4dyyKx51Gh3LyvM
         cC8D8MBWYLZMGbd+OpCh59mGG6+zoN3VDJNUE4hVpAQ+oSK2KUiWXJ9qG/m/Wbdd1xPN
         baudrYO5TzZN0Orssmzhm3gazOsYLAYGPt4QGTfGKp4N6uCkFW5Oxi0PdK2WwuuHSAk2
         8GoYWyZxjlY17u1S4QsGAdGBcldg0ftmSEFvWH3JuZk99dCPzEn61eXrbOVg670X5pIZ
         lpZljQC2AvP41vov5OQIkDVHw++CCZ/wtw4HcDOb2Jz4lLGFB56+3ausqP3ICnqhFrxx
         vkYw==
X-Gm-Message-State: AKaTC02nz0eLhtU+9kXia44ThrY8/Ulqf4yYEdNfmCHq+SCTu1vnZOSQiCqP0DtU77CMyQ==
X-Received: by 10.194.119.196 with SMTP id kw4mr61517436wjb.181.1481208506368;
        Thu, 08 Dec 2016 06:48:26 -0800 (PST)
Received: from localhost.localdomain (x590d68ae.dyn.telefonica.de. [89.13.104.174])
        by smtp.gmail.com with ESMTPSA id q7sm37368719wjh.9.2016.12.08.06.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:48:25 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 6.5/7] squash! versioncmp: use earliest-longest contained suffix to determine sorting order
Date:   Thu,  8 Dec 2016 15:48:11 +0100
Message-Id: <20161208144811.4372-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
In-Reply-To: <20161208142401.1329-7-szeder.dev@gmail.com>
References: <20161208142401.1329-7-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the number of identical steps to be done for both tagnames grows,
extract them into a helper function, with the additional benefit that
the conditionals near the end of swap_prereleases() will use more
meaningful variable names.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

I was not particularly happy with the amount of code duplication this
series added to swap_prereleases() in patches 5 and 6, hence this bit
of refactoring.  Which I'm not particularly happy with either,
because, well, look at that diffstat.

I don't have strong feelings either way, but here it is, take it or
leave it.

 versioncmp.c | 62 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/versioncmp.c b/versioncmp.c
index 62c8d69dc..601ceddef 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -24,6 +24,29 @@
 static const struct string_list *prereleases;
 static int initialized;
 
+struct suffix_match {
+	int conf_pos;
+	int start;
+	int len;
+};
+
+static void find_better_matching_suffix(const char *tagname, const char *suffix,
+					int suffix_len, int start, int conf_pos,
+					struct suffix_match *match)
+{
+	/* A better match either starts earlier or starts at the same offset
+	 * but is longer. */
+	int end = match->len < suffix_len ? match->start : match->start-1;
+	int i;
+	for (i = start; i <= end; i++)
+		if (starts_with(tagname + i, suffix)) {
+			match->conf_pos = conf_pos;
+			match->start = i;
+			match->len = suffix_len;
+			break;
+		}
+}
+
 /*
  * off is the offset of the first different character in the two strings
  * s1 and s2. If either s1 or s2 contains a prerelease suffix containing
@@ -47,46 +70,35 @@ static int swap_prereleases(const char *s1,
 			    int off,
 			    int *diff)
 {
-	int i, i1 = -1, i2 = -1;
-	int start_at1 = off, start_at2 = off, match_len1 = -1, match_len2 = -1;
+	int i;
+	struct suffix_match match1 = { -1, off, -1 };
+	struct suffix_match match2 = { -1, off, -1 };
 
 	for (i = 0; i < prereleases->nr; i++) {
 		const char *suffix = prereleases->items[i].string;
-		int j, start, end, suffix_len = strlen(suffix);
+		int start, suffix_len = strlen(suffix);
 		if (suffix_len < off)
 			start = off - suffix_len;
 		else
 			start = 0;
-		end = match_len1 < suffix_len ? start_at1 : start_at1-1;
-		for (j = start; j <= end; j++)
-			if (starts_with(s1 + j, suffix)) {
-				i1 = i;
-				start_at1 = j;
-				match_len1 = suffix_len;
-				break;
-			}
-		end = match_len2 < suffix_len ? start_at2 : start_at2-1;
-		for (j = start; j <= end; j++)
-			if (starts_with(s2 + j, suffix)) {
-				i2 = i;
-				start_at2 = j;
-				match_len2 = suffix_len;
-				break;
-			}
+		find_better_matching_suffix(s1, suffix, suffix_len, start,
+					    i, &match1);
+		find_better_matching_suffix(s2, suffix, suffix_len, start,
+					    i, &match2);
 	}
-	if (i1 == -1 && i2 == -1)
+	if (match1.conf_pos == -1 && match2.conf_pos == -1)
 		return 0;
-	if (i1 == i2)
+	if (match1.conf_pos == match2.conf_pos)
 		/* Found the same suffix in both, e.g. "-rc" in "v1.0-rcX"
 		 * and "v1.0-rcY": the caller should decide based on "X"
 		 * and "Y". */
 		return 0;
 
-	if (i1 >= 0 && i2 >= 0)
-		*diff = i1 - i2;
-	else if (i1 >= 0)
+	if (match1.conf_pos >= 0 && match2.conf_pos >= 0)
+		*diff = match1.conf_pos - match2.conf_pos;
+	else if (match1.conf_pos >= 0)
 		*diff = -1;
-	else /* if (i2 >= 0) */
+	else /* if (match2.conf_pos >= 0) */
 		*diff = 1;
 	return 1;
 }
-- 
2.11.0.78.g5a2d011

