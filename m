Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F63C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 00:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8244960C3F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 00:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhHEAId (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:08:33 -0400
Received: from mail-oln040092066053.outbound.protection.outlook.com ([40.92.66.53]:6188
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229991AbhHEAIb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 20:08:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+aOwvhdYezjqz0iGYeL8LQePv5Xfbc3/cknne+PpKvUS8a0LirwGdQ0FMFI23R+hBRqLFdAg5yTZjG/R+CS5VDpBm9dfZ7YgRnkHhId8I4gqsgkMLuQNhklh1HjGKgDPKqpwKXM4VJfSH9Y7NMsEIT4cBYnbZY7lfLQgbpVBJUwvuXWecebpMQBB4SRxFSlUIbF48ZlxFpbnOYj/yCner2kWQKEVmepdqb+xSsvdd7vxrm2/qjrZ16cxQCFPDFu8gOxKm94MsoUGlwmR4PVXRIIV7iFPLHK4H3IgGPORgjnAn8qoEqXQIXokmsC4FiozdFPl4hXcaQpOVk6h29JDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwNIUTasxMrERcItSRtErNoEXdXShJRKpDcxSG0pt8c=;
 b=KM/kzFTJUFAurzFwzGBhHigZ+6CXGNxfqQDfZXiOrVCTCKKjJF/lXfaf5pngmmixtyMMR6ZggIL2h6+77RrKO9ylcMTAaHFJ2J8XN+Totoveyvoc8CndcEpOeX+tZ+TodfyZ8XYOISuM75OsfKkvQTS5lIdA/EJgwN/Zf3Y3P+XatUuGGCDjytJdUaSvdyMK5WTtE8ZsIrYQ3b1LFGQhNUacpwub8JNAeRvJA7cqDMEz98RpauOphmdXo3gH7YnFty6XmD6GLSV4lm2TBWLdcDc3MwhSQdShGIP2lXVuoPDbV9fL4Rjx678rbUpquWNaStHoigp0CWxRnkKQfRp8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e19::4a) by
 VE1EUR01HT113.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e19::272)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 5 Aug
 2021 00:08:16 +0000
Received: from HE1PR05MB3371.eurprd05.prod.outlook.com
 (2a01:111:e400:7e19::4b) by VE1EUR01FT050.mail.protection.outlook.com
 (2a01:111:e400:7e19::288) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Thu, 5 Aug 2021 00:08:16 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E77D129831F5D7D4748CEAE02FC50842D4DD1670D79ED67250FE9D8AB956A66F;UpperCasedChecksum:A01302A3BFBEB9F9F7949E2B3FBD9D81EEAE7938B5066B3A0D045898E413F9C6;SizeAsReceived:7251;Count:45
Received: from HE1PR05MB3371.eurprd05.prod.outlook.com
 ([fe80::14a0:8b32:af06:711]) by HE1PR05MB3371.eurprd05.prod.outlook.com
 ([fe80::14a0:8b32:af06:711%6]) with mapi id 15.20.4331.035; Thu, 5 Aug 2021
 00:08:15 +0000
From:   zegolem <zegolem1383@outlook.fr>
To:     git@vger.kernel.org
Cc:     zegolem <zegolem1383@outlook.fr>
Subject: [PATCH] configure.ac: fix misspell in comments
Date:   Thu,  5 Aug 2021 02:03:47 +0200
Message-ID: <HE1PR05MB3371C8B2A590C32E0FDD212DD3F29@HE1PR05MB3371.eurprd05.prod.outlook.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [DlKvICbP6PedcSK4Zg9Doy2lcVaDWr+y]
X-ClientProxiedBy: MR2P264CA0113.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::29) To HE1PR05MB3371.eurprd05.prod.outlook.com
 (2603:10a6:7:34::25)
X-Microsoft-Original-Message-ID: <20210805000347.298313-1-zegolem1383@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pcfixe.localdomain (109.0.235.140) by MR2P264CA0113.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:33::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 00:08:14 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 860bd5ff-1b48-4486-e13b-08d957a51efe
X-MS-TrafficTypeDiagnostic: VE1EUR01HT113:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQihUc4ZqNQehlIEodkSVptdzgvPBojmvscZOwRf0phpUgLeKRoug9gNYYESe9Lt68lYCTYwvx8Ot5aV/Rz0qmqedOSZXE1tZF3bRQwGoAyxVJHGD2LIV2ONIopJgBgTp0Fuxl0Q+3ElxkyMgs4l5boO2sggHYeIrYNcD/7nwsnqBjFuY9Y+731q/YaXYB2u02Sx5KK75Gbgdy1HG8Gky8iQOK0DtVJOHh1WCnCZYFPXjFImrjQskJB093HD6MUAkoK++KCit7kAXDUePOV275ie8kid92YqQ1AcX/AZbDVGCr+aFGYiwacvu52Vc0xkagfVDFIdEYIq9mFBgH0jobyxiYLwCvhS1ldg4mh/aivXG1NARDSQ56Fm/BOjYZSllgkq0WrTsHSVhXK4YdafNo7NR2qirGcNgNUv95lFKOm+ckea4AIrwT3HzvSdewrz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0uhoutOu6GkZ3GY3D2TqFl4nr0NZrjkKiCjHKuPkIu7awfzW5fc86//hyj/cBju/OWTwtcNOUBwjvy5tIOLDa5jxCYJ5vvfXxFdM05DI0PRadYYtTz7yGA0rDL0FXd7gFp2ug+Ov5VE3kwCr8TkxRA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860bd5ff-1b48-4486-e13b-08d957a51efe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 00:08:15.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT113
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two places in the file where 'you are' was written as 'your
are'.

Signed-off-by: ZIEGLER Florian <zegolem1383@outlook.fr>
---

Note: I didn't review the full file for other errors

 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 031e8d3fee..44fd314a2e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -955,7 +955,7 @@ else
 fi
 GIT_CONF_SUBST([NO_REGEX])
 #
-# Define FREAD_READS_DIRECTORIES if your are on a system which succeeds
+# Define FREAD_READS_DIRECTORIES if you are on a system which succeeds
 # when attempting to read from an fopen'ed directory.
 AC_CACHE_CHECK([whether system succeeds to read fopen'ed directory],
  [ac_cv_fread_reads_directories],
@@ -975,7 +975,7 @@ else
 fi
 GIT_CONF_SUBST([FREAD_READS_DIRECTORIES])
 #
-# Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
+# Define SNPRINTF_RETURNS_BOGUS if you are on a system which snprintf()
 # or vsnprintf() return -1 instead of number of characters which would
 # have been written to the final string if enough space had been available.
 AC_CACHE_CHECK([whether snprintf() and/or vsnprintf() return bogus value],
-- 
2.32.0

