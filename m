Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE461F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 14:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbdKKOK0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 09:10:26 -0500
Received: from mout.web.de ([212.227.15.3]:52849 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbdKKOKY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 09:10:24 -0500
Received: from [192.168.178.36] ([91.20.58.47]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKrC4-1eDWUF26jI-00018L; Sat, 11
 Nov 2017 15:10:19 +0100
Subject: [PATCH] apply: avoid out-of-bounds access in fuzzy_matchlines()
To:     mqudsi@neosmart.net, git@vger.kernel.org
References: <0101015f9c91871f-2f750aec-6877-4e29-9c15-c8399670dd48-000000@us-west-2.amazonses.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6ff27de7-ac22-3f2f-1f3b-2e0e6f10605a@web.de>
Date:   Sat, 11 Nov 2017 15:10:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0101015f9c91871f-2f750aec-6877-4e29-9c15-c8399670dd48-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kP8ImRTuHTYQoxnaHygFtorJJouRnvUyiLmhsodsFODVwU4uEwq
 u/P++AHE8la6rUqxfVxNvHSwpS4aq/Utx90J7Ezw6ebhIGYtKGQOKfhevVfyy3bu/vXalRI
 S0warOzBesWaIqdQ8gE/yg3QDVvL11xWpmJl+fL57un6sn8Rc4fY+d+IT89K+e33hz8c3V2
 onVd0wkeRSnXQa66jJonA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zQdVk/o0+O0=:mXW0Y1JJmQAlJS9q+mXv7m
 Mg+gtD1gTKePLUdSytcx/CXGkUQlCDnIshR25K69P4hCM/u3eDakG51XjZ55cx5FjkdhZftOg
 IJ+lwnLhL2k0RjYNS9Knej/GURTjHQPLKS0Mw5XVDyStg6Ar6rL4mmEjCF2Eb26DYKf7hvIHn
 FC/Oyl6UMKEaozmDmGqE+C8A29p3EM7ixhk1lM/5qG6KEnQtrUzhyIDm+nA3M1h7yBZ9Ulpjf
 R1Fh3foadMjEVWWBKvIyW91D6TcQPcdy8v7nYDg9rf2+ux/qC3XcH7iVELTi3HAyfcCPRBmQM
 GBcoXMVM3htjx4eG5D6YVbphaG68dwl5TmSPMzMF+9vuX6kKGPXPccezYJaxvJT9Z1R7SbcpZ
 hFNUzqieThHffBVlpTxHW3AYQU/r7dy+/uwMB/VI1D7i5FMvTzhfvAU6u20d86F9mT4cNOLx7
 PofmbEC8xeyxSZKyUpwoEJ4hr+aWH0zhKgNxTdXiUNlEo6B137PEy1JXbDf1g8L0ohU1hloL4
 f7oD7ehbJfMQQSzdimunLW1G4xKscGUS9ehI2gZi/UoTWtVsvSEZ/sSUSRsgaWqFLN6G4BQeC
 yGfBNjiRRntr5TjdrbenamiE3a+a88NifSafp2v31upCVP3gPN6u4or+JS12SM9ju5hnV+UdT
 yi3pSzuNY/Kjvs9fFYmgcGlWjTC0n7t23habyuKGi+bKWEPndnZzGhx8FrJMhTpFUmfaOxRsj
 iFk3l9Dpw49EUWPcu9KqT8MOgKjrsVE4OtDZ47ZlrfZ6xQTOzUxnWa+6x+cr53tqGZON+YtVu
 Ny87x5jFNK1Lx/KHSfn7xtEwjU79BCNebiAPBkQvSZSr2aSAnQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fuzzy_matchlines() uses a pointers to the first and last characters of
two lines to keep track while matching them.  This makes it impossible
to deal with empty strings.  It accesses characters before the start of
empty lines.  It can also access characters after the end when checking
for trailing whitespace in the main loop.

Avoid that by using pointers to the first character and the one *after*
the last one.  This is well-defined as long as the latter is not
dereferenced.  Basically rewrite the function based on that premise; it
becomes much simpler as a result.  There is no need to check for
leading whitespace outside of the main loop anymore.

Reported-by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c | 59 ++++++++++++++++++++---------------------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/apply.c b/apply.c
index d676debd59..b8087bd29c 100644
--- a/apply.c
+++ b/apply.c
@@ -300,52 +300,33 @@ static uint32_t hash_line(const char *cp, size_t len)
 static int fuzzy_matchlines(const char *s1, size_t n1,
 			    const char *s2, size_t n2)
 {
-	const char *last1 = s1 + n1 - 1;
-	const char *last2 = s2 + n2 - 1;
-	int result = 0;
+	const char *end1 = s1 + n1;
+	const char *end2 = s2 + n2;
 
 	/* ignore line endings */
-	while ((*last1 == '\r') || (*last1 == '\n'))
-		last1--;
-	while ((*last2 == '\r') || (*last2 == '\n'))
-		last2--;
-
-	/* skip leading whitespaces, if both begin with whitespace */
-	if (s1 <= last1 && s2 <= last2 && isspace(*s1) && isspace(*s2)) {
-		while (isspace(*s1) && (s1 <= last1))
-			s1++;
-		while (isspace(*s2) && (s2 <= last2))
-			s2++;
-	}
-	/* early return if both lines are empty */
-	if ((s1 > last1) && (s2 > last2))
-		return 1;
-	while (!result) {
-		result = *s1++ - *s2++;
-		/*
-		 * Skip whitespace inside. We check for whitespace on
-		 * both buffers because we don't want "a b" to match
-		 * "ab"
-		 */
-		if (isspace(*s1) && isspace(*s2)) {
-			while (isspace(*s1) && s1 <= last1)
+	while (s1 < end1 && (end1[-1] == '\r' || end1[-1] == '\n'))
+		end1--;
+	while (s2 < end2 && (end2[-1] == '\r' || end2[-1] == '\n'))
+		end2--;
+
+	while (s1 < end1 && s2 < end2) {
+		if (isspace(*s1)) {
+			/*
+			 * Skip whitespace. We check on both buffers
+			 * because we don't want "a b" to match "ab".
+			 */
+			if (!isspace(*s2))
+				return 0;
+			while (s1 < end1 && isspace(*s1))
 				s1++;
-			while (isspace(*s2) && s2 <= last2)
+			while (s2 < end2 && isspace(*s2))
 				s2++;
-		}
-		/*
-		 * If we reached the end on one side only,
-		 * lines don't match
-		 */
-		if (
-		    ((s2 > last2) && (s1 <= last1)) ||
-		    ((s1 > last1) && (s2 <= last2)))
+		} else if (*s1++ != *s2++)
 			return 0;
-		if ((s1 > last1) && (s2 > last2))
-			break;
 	}
 
-	return !result;
+	/* If we reached the end on one side only, lines don't match. */
+	return s1 == end1 && s2 == end2;
 }
 
 static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
-- 
2.15.0
