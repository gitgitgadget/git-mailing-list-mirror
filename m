Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B3EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 16:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjGUQje (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjGUQjP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 12:39:15 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn20802.outbound.protection.outlook.com [IPv6:2a01:111:f403:7004::802])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDDF49FE
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 09:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr7BY+jiCXeeR+7Hzhv2GD4YnPdXBzm8uA2mRbbzzW9ZMsQ4iGRdL3bp7WJqHnR0m9/pseqtIK3Ong25vE42GnZWDz1CcgqGjsZqx/xGIM18AX4o55DtVLArX+g8/if3EgqUjHLqKtCVq96NohOzmqWSOg54vGCsV/xzz6gmrmD2q4MwpDrgKtP+3Fm+V0VX8Q8ezucp7DbvSSQKT49gmuosfzaPkQU5ogMKJvtgecA6ceC+2twtjxC8wqgnPScsyMYJQJnwkVdWA+oevbYHVXqI929bjvykuqyDm3xKqngmU4kLdCpvANFmuDdg4UTF8Aq335thjuYPgSINAXBrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmJjzejmrqE7G2xWy4ygZs0b5AmVRgzN7e/AJ7dYBME=;
 b=IzORaQTTy6F5KRoRrf29hlHph3YQbw6QPjVl+DvXAsC5PdaLze9nqKLZgmBKFSS6QJgnbM4lUR0peKcl8HrrehJPav5KftW7h8xnKgIgtoUU+mJb871tOd61E/7XYZalxIgrK4GlG/+Y4Du53E7KBjxLdhTe8xdDnTQCqWvSAqyj2HztdbkUjfBhE+3GG0cPoUdr7TlCXjCzW3cnFQ/Wdaup6m36H3U5OTHgFerZbCt3sOHvtnA93h81/gTqGN/c5fxDKpbQ0ygE0gNPtwRDaTx17U8KZgfqSieUAUrVvXDJWkBu3aUgjp/o5LtPb4elnObwiB4zu5Lfu1yAA78Acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmJjzejmrqE7G2xWy4ygZs0b5AmVRgzN7e/AJ7dYBME=;
 b=iEzm1BF6Lj+/x4CBjMlgwB+0VaJRS0gJvkZYsDw7ljLccQ9sM0/VirAJZ9rpE4C+o7OPtaLYIcjsI1Xf6G/UnYTSWAYF/SVzTFZ1Hr8FOMzZoTzwrikZ6oI+Z1uNKssZpCFGkfr6xP6LFchDBDeC+uWTzGzDY48MU/d5yw4odpu40gU8iQ2rxvGwYb3SGlxO/fxvn/93JtMgzRzHh6tF+4+nLDdcFLDJ5obQBTfqTI2L4hCMmdLwmV94diDSxTBUhe7A622igDt5pHANQymytlCarm2kkpPfOxVAiBNtciM2csvhzCuyzrt0XYsI97/3jJO+/2OQLPXlY8ejNDqS9A==
Received: from ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:eb::14)
 by MEYP282MB1704.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 16:36:44 +0000
Received: from ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
 ([fe80::569a:9ef7:3338:79c1]) by ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
 ([fe80::569a:9ef7:3338:79c1%2]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 16:36:44 +0000
From:   Qixing ksyx Xue <qixingxue@outlook.com>
To:     qixingxue@outlook.com, git-git@nodmarc.danielabrecht.ch,
        git@vger.kernel.org
Subject: [PATCH] gitweb: wrong capture group used for grep search
Date:   Fri, 21 Jul 2023 12:36:05 -0400
Message-ID: <ME2P282MB2242C7D0E3D92E2CE5A13B68B43FA@ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <ME2P282MB224200468AFBBBD4534ED1F7B453A@ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM>
References: <ME2P282MB224200468AFBBBD4534ED1F7B453A@ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [7rif9Jxh/1pl0hn4sjJNAA1kpeTSAqGVNqwXnesOSvo1tXw5R4qWgprMTOKaWPbq]
X-ClientProxiedBy: BN9PR03CA0399.namprd03.prod.outlook.com
 (2603:10b6:408:111::14) To ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:eb::14)
X-Microsoft-Original-Message-ID: <20230721163604.992-2-qixingxue@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME2P282MB2242:EE_|MEYP282MB1704:EE_
X-MS-Office365-Filtering-Correlation-Id: 0681b04d-d41a-403e-de59-08db8a08ab88
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3kio6YMFhyXu7GkCIaMVIdq8E/2fn2dJIO3nUuq/fh8b/Sw7pEl48+D/16x8pjW3gg4eKO2SkgyqSbOFpFDyvGhiJTTqsyh+aI+KrKZi4S+7RiC/9ygZcG8kN8mbQrlxDc52JVwwYPrpjtn0BT8nDP/nBCLGM4twX4qbiyRp7v8s3k2YnNZALhPx9PynSqnKz4zrrGzqYzshXzPrTA/1rt9PDpV2x/WzYPoMtn00QMVtQ9QhN3gJQ0kDmVrKEGgkr/7JhFxiHOd8ZM9mzZtYx2Jkh6y2fGk7Mq6/oGqc4WGXKPxkmy/14rpmhsgA0IL+jNq6lEaEViNE1G/kb3ZAh5uyBQpKTp3eGme4Ex4q4nydOBNLQHXgXPnVuEaC+lmjF1ifrOrO8OqB5TG8ln5b5JcBtfxkN1Cz5+xD/XJixwTefkpMnmuGoIEQyhnq3AI73Iru13fIDJJX0j1NjmIl5ktajqGhRJJvvTUJQAusepwVzkbaYZdwQw7BcCiIGP/ABKXtPGCEVTK/lOhyENaSRhzWE4y6xd6nIFYb3lTE64kYbepSk4K3ZY7ksvlguYqljw9YZKOqfkPM3I59vf/aeH/MWc3m8CGefS9J9X119M86BDTHvDKjowQndMcHTndRxlwkctVntxoqpY6wktNdKq3FdJmzkL1XcxnLiuKwj1m9jKokrJEwS5bRQ0Xbaq193LldevkXDNiilYh9auFFjrwfNpt47b7ZceX+mm9TaFT5dEz9hGBFabHSAidWO9133uPpk2gw7XncK3ZLXeFs1+M
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMq8syhZyhaL0OPZr6njE4FP+iEvx116l7P/rIsn6AjEbRFRnxIiMssoihHwf14IieAkOV6qucMdRY/6DWE3jN80v2EAnSiarh8r0AvOh35ZESGiFTyI2LZCj+5WtUELxF1vBkTFIwB+c3OA8tbKgEJGP51HiP8Z16x4dhv5ZGKZuiJzIvx/aUKCRDqjrPwjYzzKCTLT+jgxw9+47EQPPb4/m2OgIKBlb5oqefPH2j+drijkp9avM3u9gR+OZuw8vMnbjZQ2tTVA31rZjrgO6CTA57k3ViMBC20HJlibJyaBQGqHwVckRptQYyaZ8ve4hN4FHdfE0lYo7x845foP7KjsAm8DUyJOV5P/32TTIyESivDSPOViW9vPUTqBXKJ2VvT1c92wNYDf19VrjlAlX6SQKgxqTSnvckoaQz909kVYnIJ1aRkRoX+ek8KXLSKlb2Js0b6HgZvLfeluWdS/ZBcoRzK2jle/EYgRHQaQgIesZbKjZURWBRhSXztJEcSoEbzeFnHrEqe/gnzDU375IFDXe5L1z+xi2RRJGWDdzX51HAUQbKp8AKiq5NlhEpTnFerttihqO2nxAcQgaQ+AYTNFxnoIUbDj/wW16KN5oQseRj/+yT2eh347RYl/j79N
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RHL63rMyw3SAXsKmKh4Sn3VCbvLcRO156nPv9PkCbwBMfB7kenRWwc/mBY5k?=
 =?us-ascii?Q?tmfekGI+uW5Cx+7SO8ZH3bJCd6ByV+hM+lerO+BZ29duQSH+oy31z5UXjwtC?=
 =?us-ascii?Q?klKbxcrfr3nBnFsVKXDmJ9mZttBg/7m7YhRpCNcuUTY2IAEsho9mjYKTcQR6?=
 =?us-ascii?Q?sDE3XTPTjjsVrAkNq2tKRgdiowdqJuX7nZu+8UOzurDPXh43OvI9iVkkIsKm?=
 =?us-ascii?Q?o8RvCSBwv5SMPvto2Jk3ybINKUV9m4Pr296fyrBSYOr5fLiu2ewDCSjLABHW?=
 =?us-ascii?Q?sjlTOh0UGmvszIwmdHcocNpFu3fyIlAlxoBZNvIOEATpuFoXBIoGWCOi9lyB?=
 =?us-ascii?Q?hqLashMt6PXKQqbn73GSsOqOZYgmFKFG2KokqWKpZt5om+CTXHQxVqwZ6TAe?=
 =?us-ascii?Q?gAgfAMMxJof7Ldv0X13xz7NPm0rL/5gPA9eWqAbWBfDCNpAnVi73mUsONdIl?=
 =?us-ascii?Q?Wk2XTrDqk9noi1htqBBrntqPlUnO/a0zwqHGKHM3T9CI8972Xh+uNmoD2NUV?=
 =?us-ascii?Q?fkVWM5ls2aIXrtLRZxx7Hr5N7FBVpzs72jeajKyl0qlFNwoEozVy2E+/YIAI?=
 =?us-ascii?Q?AMc68Y8eYPZ+OnieEgT1nQhuB4Fyzinh4CXrSCLU5ZbOf5O0z6/U1yklPjND?=
 =?us-ascii?Q?BJwfLtXOlnt8iKxuvvzFHN2SxYKh+p+GklAEo+gPRe/NGQ20HZIW1yEMvOmd?=
 =?us-ascii?Q?AIDsAnaXEWsnwme4jFufDiyzowDKsY62OsvoBwg94qAaJx+/+wJTyem7kYsC?=
 =?us-ascii?Q?LB8qBzhh8iX9AFE+YTRLHS4UJTuLSp8rR25t6dSj/UaOSopckBqBRh4PR4xI?=
 =?us-ascii?Q?K3nQySOmexjskjAUjWsLovI2eTYNr5n98wf6QbUGhOE5pdAn19kyaAsk/4Bw?=
 =?us-ascii?Q?pBFyvNYryqxOZD0FcqKHyAFtNIMM1/ZyLeVhmGoYcJfRczCvG3MSm/R+XOfq?=
 =?us-ascii?Q?ZUZzkZVIrpmfNlNBC07utlwAFAB7DhCk3cACU+8s95TNgT1Ge4mISWLNtWuc?=
 =?us-ascii?Q?oxcttCM+nosfVTTAInRH7tKmK2JdkGAVTXZICuBGwRfAmXbBO+efO8ta6b89?=
 =?us-ascii?Q?madnF87h97nOtXiSKOQ47EE80S/uvdzx094h46JJUnL9qEUHLmaCMbgbR40j?=
 =?us-ascii?Q?KdLYuINFyXQAYlYxFUZxiPvhqQghs4QRSuf9TExNNYv9rp6cSoPjKPE2Fvly?=
 =?us-ascii?Q?Yybn6QwMsV1Eal9pLdta2VjYPZsenxGUWsJtneqMluHQ0776wdT1Xnl+HWzu?=
 =?us-ascii?Q?+cR6E2ySadsPk9qJzw0upsAYbe/oUaFIyls3SR6Ol1qV8aS3qtHkqPWHy5ZK?=
 =?us-ascii?Q?NSc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0681b04d-d41a-403e-de59-08db8a08ab88
X-MS-Exchange-CrossTenant-AuthSource: ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 16:36:44.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1704
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The capture group numberings $1, $2, and $3 used in the original script
does not work well when the search term itself has capture group, and
could be replicated with the simplest case of p(a|b), whose search
result with regard to original text `XpaY' would yield `Xpaa' since
capture group 3 now becomes the one in the search term, instead of
some suffix. This patch fixes the problem with named capture group with
capture names that hopefully would not conflict.

Signed-off-by: Qixing ksyx Xue <qixingxue@outlook.com>
---
 gitweb/gitweb.perl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9ba..e868122853 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6418,12 +6418,12 @@ sub git_search_files {
 			print "<div class=\"binary\">Binary file</div>\n";
 		} else {
 			$ltext = untabify($ltext);
-			if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
-				$ltext = esc_html($1, -nbsp=>1);
+			if ($ltext =~ m/^(?<__gitweb__prefix>.*)(?<__gitweb__matching_text>$search_regexp)(?<__gitweb__suffix>.*)$/i) {
+				$ltext = esc_html($+{__gitweb__prefix}, -nbsp=>1);
 				$ltext .= '<span class="match">';
-				$ltext .= esc_html($2, -nbsp=>1);
+				$ltext .= esc_html($+{__gitweb__matching_text}, -nbsp=>1);
 				$ltext .= '</span>';
-				$ltext .= esc_html($3, -nbsp=>1);
+				$ltext .= esc_html($+{__gitweb__suffix}, -nbsp=>1);
 			} else {
 				$ltext = esc_html($ltext, -nbsp=>1);
 			}
-- 
2.30.0

