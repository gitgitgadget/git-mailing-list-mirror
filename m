Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478EFC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbhLMWz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:55:28 -0500
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:28160
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244049AbhLMWzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:55:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0/qMKNl62kyFYXvG3FrS5UzjEPzgwAzU1KmqxrcNyfxlGyh6OdexTM9bbZdNSbDP3F/JVKjQx+t2REA8Aad+KfiO/aJc8MLIYi7SKQ6K3DTmX9aPXS/Gziii8qCNPnTKH9cbdaFv96bET3NuK1yCr/bWpyWW/h0QuXc1vfVilHIy9XqemtHiLrhw1d2UCNVZzkx4ZpRiC+WWJ2e2t0HyL3japPtFSychvPwHEDB2idSYvS/ObJTzBP0P/7Hix1NVPIwTfUrFFB8qp9LnnToRqpsqdSq2KXze0AWMvhWzIM/h1PNC77nuBqgJfjWmm6HJtDy82W0K7a1cpIIOHaT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqZoIJbSMvjCqfj86vBEPU+rETWkpGUjUTrnc9+NIig=;
 b=SrAt2LoFDCf9Osg6jkBR+1Vr+8+j5zpsyc+tqQx1j7NTLIkkVzvjRUJd38JCtLGcOfSRsjT/fMykFg7G0Mw8N9nymLn9T6EWFZEhefd8MGxFsdTVffbZ0S3nDXGoIRlfRx+oG+FJ8tTePqKRyPx95mSA6gkLzuS1Yn5VCbEc/Et1MI3ZNcxRPkGIXLRGAzVg7Ic4TCGQNCGB0AIBmdHoOC6LvSucke7Iiu7HAkJIFj3KNxStytk9ENQpHE70WmaxMcc7XjS004JNLXw1ZkXa0dsuK26nDdljz3kgwkZM1VsCH+2FnY/aox5N45JdiIhXLQDPvT4Qh3rJ9HJP40SpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqZoIJbSMvjCqfj86vBEPU+rETWkpGUjUTrnc9+NIig=;
 b=KOgt1tJXQEfkfUOEO91qBEWdxafuXcC3bizgDwyMk0fCSMkf8OMfPm7/27MK8CoHUF4I2Jk5sUGBuDhl5mmT/WTDqFCKwXAxdBPWPlZA2Bc3IFWmdMrpJDfVIXHRELKXl7t+Eszzxq/rMMMEO71g5XQ5PkmYi9oSWRlK0w3BoqbBTJYWTp2V2eYGITEdVOpoOqKDjRJJ5uG39Gx+Zy95YoGjD3cxRwhDKpCVoLELcd6hskiIpaefa6Caiy7xmbRBHI1eXCVOwFhnGNppu8/2HNk2tDo9iz2mmaVCfYZMTqJjixNpwZOLKCbtao9+cHACD3PoVPav4PICpsY46LSdrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 22:55:08 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:55:08 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 3/4] git-p4: add raw option to read_pipelines
Date:   Mon, 13 Dec 2021 22:54:40 +0000
Message-Id: <20211213225441.1865782-4-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213225441.1865782-1-jholdsworth@nvidia.com>
References: <20211213225441.1865782-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0263.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::36) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb6a1aee-9272-4037-0d00-08d9be8b9c4a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1377:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1377FDEBB1A01F86CDF6369CC8749@BN6PR12MB1377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAfZHu9IlWoysP2TgHWfWukUsDUO2f8cl4sfqioGngOYxD5huygq6DDtuZJ1vX5+0VXlGkilzkKK1UW9GATmX0UjlonX0bGJooVLZIrN5gpwzCeCbYNVHKB0Mqdegt0uuOfElSa1OIrgCnVVsH9scNrahXJVCmkfJT5bN79nK2PN6Js4rH2JZHPZtFj9eeVSB6YhafMJWxd+LxNDBh2ZCbiDX6v8NgjaHWbOqEd5h/Ps2202pfpE43FP4ZpyFCh4t0lhj2+hoddwcLCJ/YTAEMbo6nA9PxYjAYdX8Rc0fgqVyncjQ6kIzbCKCsuv007iIyr82edVRQ8IJ6FsS08vjuG7C5oLDEbK2CRGZ7pE8nlWa0CwOJk/+q5WzaCHi1L9qCy6FqqAoj+jbrzPYhj6f5ftIAwBwkm3Oz2XnUqsnEiqANwxhI3IAlHVmU+qzJbmL2iv2qBBJWmjwBvC5JSfx5vV1TyygL7fwvXNKxoCTuDiRPcSPtI5CwwpKXz6YseKOBCfIvW5+MT5W2IrwuwgfXtqPHBgESGSBzxiYyHCWY8pckN5oxJNcrdAaewwyw8+IsiBrZbmstk5+UUao5IYxBgflqHD9nIwyuHFyfSM1Wep+QU0wOymY3ldJOxG0eBl3Ug33yeGRQvrfyPU7DjDNJLywnO9JTrD0bz28r60/R5YTbKuXB0Y4LqX+bRiegGgp0dcll3v4jTxRRSjAVrJhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(508600001)(6486002)(2906002)(54906003)(8676002)(8936002)(6666004)(66476007)(1076003)(6512007)(316002)(66556008)(38350700002)(66946007)(107886003)(36756003)(4326008)(38100700002)(86362001)(6916009)(52116002)(83380400001)(55236004)(6506007)(186003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8T8/o1GfLz+IEkUDxjVuFYZO5PW9Or7xxtOfv1AZfm560XRXf1Plcv2Lg5iU?=
 =?us-ascii?Q?AHCERhftDFG/qUzu3FyiuYPunEQ/jAHBwB3I02dlsmIhKAtMj0KKzLB2jHo6?=
 =?us-ascii?Q?vbHvDGBCn1xfdv75GDBYsfzcMP7CBu19Ux8XxvsT2cEgR6iMuOmMk5XbVvqN?=
 =?us-ascii?Q?ruf7u8hsa1a74H5WQOTtZmqsLwpeD5KJTHCTX8gMGMsWhShJ7tdnbj2S/+mq?=
 =?us-ascii?Q?TmnDiPCDg3rm+tYyGOOj2NfWz6LVccTSHlG8A5ZIYb8zR5ExGxA6F/XSGQg8?=
 =?us-ascii?Q?AMiIQzv+IAwmV1BCqE3QyLYMeVEAv1MrYsjS0IP0bKgjTUq8X/SZYIT2503p?=
 =?us-ascii?Q?+jgA5k5SGnu0LyViXag6ob/PRnvmxtzwKcRn7pazSw1yfqhCiJ/ebFmNwU46?=
 =?us-ascii?Q?ubSzkQ868gJj3oNZC4/tyOdsEYZVrrgsHYimhO18v7XGPtGi/junOtdtpuo3?=
 =?us-ascii?Q?9rczkHMKkotkhWV+jnzykfLyhMSiehZTazaUy8NQx7sCBCdjaQwaqI4bF+5t?=
 =?us-ascii?Q?jDttcg2sbgmhDq1zCNZs5fqXaK/pDsHhHBnAI35tU0EDEZZK6PEZ3ktXAIiz?=
 =?us-ascii?Q?i4Jkw6/H9Xm74/suaTGLeNi/jOMPy3lVsc88l+OK/YUHMGDXamlKqCfFb/4A?=
 =?us-ascii?Q?EeEZ9tr9y9mgp8hJ0egjff9oHhQLTTvlBejPSIbC5JE874Eyz2W2VME55AMo?=
 =?us-ascii?Q?bNWPr0/tDVBOFzYfm7sbu2e1QvwN2LrdjRZd9hhpaXLbN20YBmrXhnzylX9G?=
 =?us-ascii?Q?01apphtrEpUv49EJrDRfU9YgUlilydsPwQBbPjnQ3pvTeGpd8n4xBkR1YFAq?=
 =?us-ascii?Q?72B3O769g73yw0k/vEosaJS4x7E3DfrLwfHT3CrHnVnu7M4fvIzfpTuN82U4?=
 =?us-ascii?Q?NqFBMqZKiEFn5+4ehYIlTdzuV5YOHUejy3zNNI07pBDD0J4C+vPwmUeE9esh?=
 =?us-ascii?Q?Q+qbRn8LpT4lNLH/hlnEH2A2irIazVURtUU8yHl57MTQjAQRXe81pMNJypcK?=
 =?us-ascii?Q?BSR+DzsNJLopqIKTXhzch+cX84lXwEo8e41Yg5O/6N3bXeAmpMdfUQLkqBqA?=
 =?us-ascii?Q?P5yHMNbpMetHNLOtAai0MbS8zrIdEASoq8q940HHIIO6xvEPVpG5ijSLQ65h?=
 =?us-ascii?Q?Tt4z7dAizZ/yiYG7Q+JP1nn4HoRAsF3sIoFXhuSMbIq1EMLFDStE/7k/GKgS?=
 =?us-ascii?Q?8zDK/5DHobYOsS1D8E7eqNKgi392ztEcKusUXllvJITuG+3L7L5lpzmts+Bc?=
 =?us-ascii?Q?pn5HkNs59RpdE/7W6ayR48Ga+SgBhNQSjda+AJJzbNlUbInw1ttz8rHor1Dc?=
 =?us-ascii?Q?eifMZxsaLJ8K/4ZezLrPIA9WIrCsTLmhdka3KaBYSyyrISA00oiibfq+/4xY?=
 =?us-ascii?Q?1j9AvCczFN8oas5CYcSBPKd42uIeTgJBD3BqGt1HTrfbixucByD4jFLIUAsN?=
 =?us-ascii?Q?dF+73HYrMvL+yk7SUnnHd6N3wgcpDMmUSO9gEtMkrt686wEmzz3rbqP0LSbf?=
 =?us-ascii?Q?6NKM/VHv6bkf76+RR5NSTrBAkFtR0canU+FZVnOjvUst4hh1YoXB/iEoZ3ww?=
 =?us-ascii?Q?dytHqKRgam8QZ5fEdSx6wPF16kTk/3UJeBQSSLkormn2u2f43BduxCEwrwSN?=
 =?us-ascii?Q?iyaR1f++afZTYwxUqNHoucg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6a1aee-9272-4037-0d00-08d9be8b9c4a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:55:08.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4cD6Kqib80XVhSzmS8+sZ2rThi1TPmpUP4Le+2/oWuYeyqrWXkrsodl8oLV2LDshidcXRTqt6YLWAdWTXi1gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously the read_lines function always decoded the result lines. In
order to improve support for non-decoded binary processing of data in
git-p4.py, this patch adds a raw option to the function that allows
decoding to be disabled.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0af83b9c72..509feac2d8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -340,17 +340,19 @@ def p4_read_pipe(c, ignore_error=False, raw=False):
     real_cmd = p4_build_cmd(c)
     return read_pipe(real_cmd, ignore_error, raw=raw)
 
-def read_pipe_lines(c):
+def read_pipe_lines(c, raw=False):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
     expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
-    val = [decode_text_stream(line) for line in pipe.readlines()]
+    lines = pipe.readlines()
+    if not raw:
+        lines = [decode_text_stream(line) for line in lines]
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
-    return val
+    return lines
 
 def p4_read_pipe_lines(c):
     """Specifically invoke p4 on the command supplied. """
-- 
2.33.0

