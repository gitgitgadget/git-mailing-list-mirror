Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08E31FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 16:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758225AbcLAQ2Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 11:28:24 -0500
Received: from mout.web.de ([212.227.17.12]:50652 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753741AbcLAQ2W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 11:28:22 -0500
Received: from [192.168.178.36] ([79.213.126.9]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dg1-1cVWVL19m9-00sPmR; Thu, 01
 Dec 2016 17:28:10 +0100
Subject: [PATCH 2/3] add QSORT_S
To:     Git List <git@vger.kernel.org>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d7e9bf45-98ca-4245-7740-ef71f71610aa@web.de>
Date:   Thu, 1 Dec 2016 17:28:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:L25GT5joGU6jf33jrbL6ctop5IA9Q969R8qXBVX+m5sLVy+I62T
 /eqeJx+wk2XAR+sFERXNvoi5pTlkMdWGQXfjF3BJY4xBssMbr0TPYPmBK6XoNZk9F/EaftN
 lvasoYhB6J0oNFQVHmaLrRXbK5wCyszQ6hlA1I5hke4T9I5ThEQaDNaHHEU1l+H3DiWLDJI
 N2wIZYO2fJo988+CtKUtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OkB9ZuF5Gok=:7/hlI9sef9Nizv/WxNNxwB
 /D9s+jxmVj01DNBq7LEKXRxDC/bzIuUu9TDUYpUE1Dp3fbF/ylgqkoVa/nbSoZ73aLx6NnmOm
 WxNkC0dygpOqI0Li6I94lSfaiiZLU5RsVo8sKpssLlT3kqb7o3H8HsyHFfh9lDZbdyVZ51rr3
 qds0EQ/CUsBnnVnjF6dDtZyzQihaMLvuAZFUZAiWWUsQv/O+CxKGvic7HK2C5YyHfh0dbgumP
 33wg8kIlJLJOFo0d9ptigcOgLbCwW6dE5z+wMdC/klnNeIGDIrE8rQjl0ixbZVYHLCeHE2M2S
 H9jT45AacmZrnJcEVYwF2BPQPwpAkbY1lJqPpcTE3AiAotTsZIb5YkDTupEeY7/hwYYvL25QS
 ssWU6Ssc702yT1rEkyTaNhOPbJ8oDFBTpMx8oP4gbl80Zf0MgxGHby41Pnj3w8uJ0SbeB4JI/
 2o5jTjEbLbdWNCUnWaCTfCy0n4p2BRLdpZxtbcUdIbbFv8L6e0UV2brang+W6w9RdUsKl87iT
 x/KtDOHszRK/RkyAWUoREGrbxLdEALqSDScF6YRQFdQgBdXA+bMzc+CGmXjF7Qh2sAd1OjEuR
 mdr616zrOY03w0Jxuuser3ZbvDHQNAXnWVdfz7xxU2bKwIA04vFKK0Ej4hFweLKNEch7FL7yF
 TVJmiExVJvIxLMdS3YMW3OGmNF5RurBy4JqZNP/W1hcaINZIQeMNtN//coJ90ILhWirj+oF0R
 6xV7qQSwl+e7ZHfdD5xEEAv2WA8pM/JQXyHd/M5PS7IdhCSwY9Hie50YBQXo8y5kZDZou64xM
 lHG0VmM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the macro QSORT_S, a convenient wrapper for qsort_s() that infers
the size of the array elements and dies on error.

Basically all possible errors are programming mistakes (passing NULL as
base of a non-empty array, passing NULL as comparison function,
out-of-bounds accesses), so terminating the program should be acceptable
for most callers.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index d25f0bd4c..b707dd880 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -994,6 +994,11 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 #define qsort_s git_qsort_s
 #endif
 
+#define QSORT_S(base, n, compar, ctx) do {			\
+	if (qsort_s((base), (n), sizeof(*(base)), compar, ctx))	\
+		die("BUG: qsort_s() failed");			\
+} while (0)
+
 #ifndef REG_STARTEND
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
-- 
2.11.0

