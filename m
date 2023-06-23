Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B52EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 19:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjFWTtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 15:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWTtH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 15:49:07 -0400
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0C92718
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1687549746;
        bh=cp7eEuVIFeuLtpxzY52U09wJw7q9zna8NUSuKg0/qhU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=ijC+/c9LAP75k3QLSfNSZ01bFCdOlgEZwGuMpoXeffGKBy1+TxQOAfA627m6+JsA7
         ks1dAWMMlFhzT7NOelPWBH3ohRLJh6Cw+vT+8fRTxlaN7adENot3j0rFjNzN9mXxHj
         a3EkwxE9WcRW94dQm4t3+KCP64/85VC04GM1O5QVo7cdTC6ctVr52/D2h4ZDa2901w
         c/imnsYy9odKxplaLxjANiP+9M8FbEtm85uFMC9tfKHf1KO/l9PFkfXemW9REdkxHT
         2yN6YBa7reIohtRD0EvYTKtCtAHeudgEukFV4hk8usdO6g0Lxpujceo5tsiUnNuyJ5
         PTZ4VQ65D0a0g==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id B43393A0236;
        Fri, 23 Jun 2023 19:49:04 +0000 (UTC)
From:   Emir SARI <emir_sari@icloud.com>
To:     git@vger.kernel.org
Cc:     Emir SARI <emir_sari@icloud.com>
Subject: [PATCH v2] i18n: Enable percentage l10n for more strings
Date:   Fri, 23 Jun 2023 22:48:49 +0300
Message-ID: <20230623194856.3696-1-emir_sari@icloud.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vPJmlqCZvV0QX4LtOU-o8hYlSlgqY4tG
X-Proofpoint-GUID: vPJmlqCZvV0QX4LtOU-o8hYlSlgqY4tG
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=997 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306230178
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This enables percentage localization in more progress views, and
provides a more cohesive l10n environment among the translated messages.
---
 progress.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index f695798aca..1f8d372284 100644
--- a/progress.c
+++ b/progress.c
@@ -124,10 +124,24 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 			progress->last_percent = percent;
 
 			strbuf_reset(counters_sb);
-			strbuf_addf(counters_sb,
-				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
+
+			struct strbuf progress_sb = STRBUF_INIT;
+			strbuf_addf(&progress_sb,
+				_("%u%% (%"PRIuMAX"/%"PRIuMAX")%s"), percent,
 				    (uintmax_t)n, (uintmax_t)progress->total,
 				    tp);
+			struct strbuf progress_str = STRBUF_INIT;
+			strbuf_addstr(&progress_str, progress_sb.buf);
+			strbuf_release(&progress_sb);
+
+			if (percent < 10)
+			    strbuf_insert(&progress_str, 0, "  ", 2);
+			else if (percent < 100)
+			    strbuf_insert(&progress_str, 0, " ", 1);
+
+			strbuf_addf(counters_sb, "%s", progress_str.buf);
+			strbuf_release(&progress_str);
+
 			show_update = 1;
 		}
 	} else if (progress_update) {
-- 
2.41.0

