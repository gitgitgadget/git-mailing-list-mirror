Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D921F404
	for <e@80x24.org>; Sun,  4 Mar 2018 20:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeCDUQK (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 15:16:10 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:61501
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932182AbeCDUPt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 15:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RFRuuYggwyow4TDGCZqhZAH2adm+V2jjUTUTE3MKF4E=;
 b=YrgGT94TwHCA8dJa1ZhWQ3k8v41CFq4KfYuSBIUSdc+2rpfEyP7pFeUH4Cwavh8DNrul2ROOafneMrQ4RtXB+OWLnrBX3lJSbe1w9qqpGqEpqB8db6yI2D93P1wQyf/UnrZeY+jcd+rBZwWGOrOd1iLYKHlSVmO7dq7y/8vW7aY=
Received: from far8gsqyz1.ads.autodesk.com (132.188.32.100) by
 DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM (2603:10b6:23:8::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Sun, 4
 Mar 2018 20:14:59 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 7/8] convert: add tracing for 'working-tree-encoding' attribute
Date:   Sun,  4 Mar 2018 21:14:17 +0100
Message-Id: <20180304201418.60958-8-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304201418.60958-1-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:23:8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edd6af20-5a13-483e-a54d-08d5820c9ce1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;3:wnQlgP8xnmdPCBp3T89uGARAeje3QVBwfD+kRaTh/CdnzqquVCqPfce2FFokvAyBfUVhKgYn2VH263Z/odIxw01KWsWiEvYDHWxY7gGj6RBDSml2SsGGp3srfawnjNHEBVSSPEy4KjWkzWB/WhZLqqJbSVFHy/T6Zaq4LSxWTxoYbACl53i/U4T9imOeTrYwJkSoFto8ScPPowgTsmMPbISoQZYIPQX6zO216gzxrVNj38WenvSfypRgZVmnDWLy;25:FWERHnl8DCpfhpRlwhpqb+KRKh2kXEg8VmRJbVe9u2GIZdXmdkgfC7OQggEWCj/rSIbfhz0wkbZRt+7/+8Q9IKBGQpsyXRYYk8AqCsGCANavMHpsX0AEEBIIshS/V6mLzwwldEOAXhHIF4UXY+v4Ual5CrH3MvN++b7xkTA2vhUDuklU3asHiTLcg+TjbOcUdNdjb3xdOpOOUxFVNL4jCARq08neLchvKLRsAqXCtrvgq/E+EoEBtk9IOuXNDrHx3M36hEgUgZZwxkrAlsLjWnGh9YIFYYPIXGfc3a+lMl+JCkO86SWhyYnvW/oqNHYNPB+MhFsemUwVdkCt4hhLfw==;31:YMbuRjbKMWPXad0mFYmdFC1dIGxBipZjM5PBzMLadpAfP794RrxN+bG4BsBkunS7DLXrUHt1qlrYJfkln9dn9/vof4LAjqai/GTBiuUW3TbShUwxHXCVxYPRgRW5JfJxzFnACatpwyDC3MpkW2JingfufYIMfrCkIvmCAicU1hpzNgPJ4/SbOWRDmx3xZXrF6k2e61l8I7EkOHRHoED5sNTIznjTfuj1YMzl/iz/BCQ=
X-MS-TrafficTypeDiagnostic: DM5P136MB0009:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;20:LF8aPQVIMXxdJU4wvJfULEsUTPRHNUnY8umDlHWgY/F8LYoJjuw5IILwgsv1GAZQv6QfM0/e4c8oDvWKFhwzosqFlHgP1HOH+N8Y4Q2rFWlh3fqnFgbVyurF2wSXS00Yad6G2Az7YiZOdeziODHFbnVX0Z50NlU3ab/c4Oqyv94o11ikOZdlplqJTEDe9IA4bY3mDt4DK4b1AetbHXZc1KNKatEtBTIUieMJEJfT+uqzGcMivGzRLgfmxf91KCxKxEO0bD3+meaURXVUdNuiyTH82Q+fvsjVG4csL4Wp7pFcXdr7pgYvMm5WixFaReHQA0DdG7MJYJMoHHtZKBNho/b1FJzVTvRs1VwE+z1kHRthGP7Khx/1BHQME0HPbTwLZiH1yGWpdS+CeZiXVFMQzw1mwfsF3VoxGGfGdXBSiMis99loOSG/Mqw36EmYEyLlRSN96wifWl5efsiV3aVg2xStBXG3A5lLikOXJ4ATJhD283wDzE9rbYfhvRSG7Jg1QQDAsjgdYISmLocYPz9firu3eahdtgzfp/E/O4cYRxX/9C4y7WBVvfSZ12JO5BniKmwhHChjmphRdfsJKo1sqhJaJ7y+fyIOJYwGn4hXg08=;4:NLB8Yl65qRE2+4qpv2b4Cnb7GsdWjoovjqocA0x6W5Qm+Pg7PcvHUS1GrOK9N4pAb6KE35mpAyz3LNH9SWIGxbpiyboCw4/3LwSB8KkgxhkvOjhRKcG2oBDGrUeQZOfZan3LPE4M2pRUAXPufCTIUmW7WCNaKovpk7ahn1rPml3TCoXYcZ2UJiqy9qDLf0/ADnLqbndW5ORj7B6zj8Pc2Hj4ADaL4NoMiOuIFwLrEY49lQVk4ePlprbf/txa9774ForTEuRoNIubwTL7UlxAWn79FJKZ99EIm6T1m+XiACeHsahabgXs8a6P3Z63OA7p
X-Microsoft-Antispam-PRVS: <DM5P136MB00094D1A2D109586288DCBFBE8DB0@DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5P136MB0009;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0009;
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(316002)(1076002)(8656006)(2361001)(16586007)(66066001)(2906002)(68736007)(7696005)(85782001)(52116002)(97736004)(105586002)(51416003)(76176011)(106356001)(86362001)(2351001)(47776003)(6116002)(3846002)(48376002)(8666007)(25786009)(6346003)(39060400002)(26005)(4326008)(50226002)(9686003)(305945005)(386003)(5890100001)(6486002)(59450400001)(53936002)(36756003)(6666003)(2950100002)(6916009)(81156014)(478600001)(8936002)(50466002)(7736002)(186003)(16526019)(5660300001)(81166006)(8676002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0009;H:far8gsqyz1.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0009;23:F2QAyij5SppNJGIOqXy/xNzmiWCIHhPgCCkY5kgt7?=
 =?us-ascii?Q?S+FzBR5e/YkaoI1686bGfHsgJ2rpmhr6GotSJS70eAB7Zx5sz3oTrjHSpQsY?=
 =?us-ascii?Q?XG6N8S5h2buGQrMVSpgQg83PAbpcJfVNEDMl0yG0COUCIN/F8Q9aDXvv43T5?=
 =?us-ascii?Q?1tisDk22l0yJNV0dI0sXapzWMZh+nM1a/NVBuzV2nTkaDDJR/yc7sxEAIFl6?=
 =?us-ascii?Q?ECy+wL0xZ0mqu/8t5+oX8eEr8zSSsPjSbXP89UgW4032UgqtRDvfM4ZQrE5T?=
 =?us-ascii?Q?yMgvlOW+6wnRDnD08YIEv+/RQVjQ34o6DA4y/LM5BD9ykrj6efKxl6yPmwYv?=
 =?us-ascii?Q?ALqLSAI62jkHQVF12TpODbl2sf2SUXhyR2ZyqAV1HmDIUd9aDlSVWuRPOlBK?=
 =?us-ascii?Q?0+KkvEBga+P9JxFYm1FIBn/Bau7wggWdY9BjI72W+qryLFLoJyAZvPUAwUTK?=
 =?us-ascii?Q?mVVTaCWdrlJJcQitbhE8rJW2LEf0GV3ib2WYn7AdFydp4G8QejT15fBjLxiq?=
 =?us-ascii?Q?d7pSNXlyFt0pXKV+I8CahNfTTdD4pKu0QD4PfkYlf/Uern0XXqkYvBzCUoa9?=
 =?us-ascii?Q?bvtAcLuEWyZgkLo/NrveIysVH3UVoFDnxsPeosHb2y+HJnevD3xy7ZdXaHcN?=
 =?us-ascii?Q?iSxnINYKWhDlYTtvpV5crcCBDtxKPajeKqcnYp5tIOnqrXAnNcGdue9n90jk?=
 =?us-ascii?Q?t8vqpWOr5w5796CKSv7jG43cjOmawvDCprmu7z4hhir5kEvw6KRZO0CQjUTK?=
 =?us-ascii?Q?bttyWXuXDXIMr8TQ3XQqPj93ml4LMpfO0RSehSShACrXnC6wwpxNCsuCwAiL?=
 =?us-ascii?Q?AIxYk+vD/P7ec6WOdGeOv4rCEdRG1shJV4faLmfCkyRkHbcG3bBi8uBHO7QJ?=
 =?us-ascii?Q?zC+huYsajsxNmS4vC3VHChYuUcWaGub7gcI49KXKFYvwkwEySszhvkSF2Ubl?=
 =?us-ascii?Q?NaWOrn/tl2VLk/zRJ7C71CZX801qP9KO2OR6kWsDU9m4AqfG6OvfWrjIzxOR?=
 =?us-ascii?Q?tFNhQqUWjP/UjML+GKkadcqzJTnO/rANrngmfnBrcov8Jjf8oUqFPc5ea/E3?=
 =?us-ascii?Q?sT/JcWlypmzQyjrADdlH0Yx8vZaZp94Uu38eydwBpII0RjhQzNxd3iN9jySk?=
 =?us-ascii?Q?iiF8GMW9no1JiXpaYXn07D8458ujRC/cLM0AJGIr235iUx7BZbhyjgLw64kl?=
 =?us-ascii?Q?gQaMG3Sr75bDQDQjYk9mhTZ8mpF7ufCtmFFi38KNBrQhyv7UxelCZO65hgC4?=
 =?us-ascii?Q?Gh+l2P7bFO+ndc0yS3Zb1yrvcMGSNb/bAMa7a+bXS43gpbKIyk6ny7mpM9dW?=
 =?us-ascii?Q?JK+femR4+UBlQLDUUvtKuPtAnJI4PJ/EBBjwbWteQGp?=
X-Microsoft-Antispam-Message-Info: K37X+B7CAVST381n7f4MI0XbFsYeNbBT1rkCl+XdORiqErrKfRVzC8adV6fdG//EOyQpd+HB3U6SDDiy5poX9PQgJBMJNRFKQiP/7i7DxVR6MPJ5L4S5HRjs2mgDyhVy2IXdDRTeNVPrtCLBZ/Y/G3G+J2b3nakBIqRiP9JDDl1AXjhwsQK4eyOlw4ppaVF6
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;6:haeJdFrh2wwYh4WqRZBS+1YLrcgyFONM+n0jG7IFqiskNj56+rxXlj2CkzMy6yagPyDAXu4z0QG5D2KCzNUVWAGnQVi57maRQMkHwVbOchG5DlUD9odcf2GhjBjDl2R5kNcO/aXu/Eo59J8wDNvRkDCWtPRvvNo6hQ2eFlnxgOScghmfw/Lc1Yii7pzj+Ugor/nG+xd2VicxY4pRRsbs+7jfvNtVb4hZdl/3GbiyfLPhmpx4jqoygbSRcDN/IcCKo22EhuA5gF5Rv7MlRV4UmNbhEOCT78RCbw7608OYyAD0o9w3M+LE7J6BXk3WnKLFzUon67/rK2700XDd6ioB31lOY55e+nuriIOlfxlOTzA=;5:VXSLq+Kx5763nYzZj+VoZ7ibD8sZZLKW9ICQQltmJsXV38BhSZtFmNpHEqLLpjZJSlB8BXILFxXptfQ//PwHhujrKo1GKWiwgJgzHLvYV4YgS4O/ylCM8BZG0mv9thBLI9SOClNKu/STxMDIbxJpeQAfmT6NQa1RTyPt5F4CVDo=;24:KLtNP4EIV7HFLmTXNajD2VyoeUoHZ1FRimZzrXCUBp98fbeQcNm/aC6U5zyvA+8cHQFCKfQn20XRBLpYEpQkbtQgsI3BkN5fgXLqdiPLNeE=;7:tcAUEveKzRf5jCT81+8mSnWw9OomhO4m905Yb1FTFVk7Zev9OqyUHuI8EVqCM2+ObqOacNNeUb254xx4PpofStO8v4v4AVnWzyCv6qqOK98UmPc+A2gfSNsG+nQyri9x73xjSzAgOrERgKpBAdpLrW0N7Y78PAu442qpHAlbHpW0/nir9rhavdFJJIar0pMsnZGVhJ9Ofom+s5qTvqcGTDtkS4AeYKVG1ovhMo8NlzW2dUgg9K4XPSGKzV2OITjJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 20:14:59.6982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd6af20-5a13-483e-a54d-08d5820c9ce1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the GIT_TRACE_WORKING_TREE_ENCODING environment variable to enable
tracing for content that is reencoded with the 'working-tree-encoding'
attribute. This is useful to debug encoding issues.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 25 +++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/convert.c b/convert.c
index 9647b06679..eec34a94b9 100644
--- a/convert.c
+++ b/convert.c
@@ -313,6 +313,29 @@ static int validate_encoding(const char *path, const char *enc,
 	return 0;
 }
 
+static void trace_encoding(const char *context, const char *path,
+			   const char *encoding, const char *buf, size_t len)
+{
+	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
+	struct strbuf trace = STRBUF_INIT;
+	int i;
+
+	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
+	for (i = 0; i < len && buf; ++i) {
+		strbuf_addf(
+			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			i,
+			(unsigned char) buf[i],
+			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
+		);
+	}
+	strbuf_addchars(&trace, '\n', 1);
+
+	trace_strbuf(&coe, &trace);
+	strbuf_release(&trace);
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -341,6 +364,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (validate_encoding(path, enc, src, src_len, die_on_error))
 		return 0;
 
+	trace_encoding("source", path, enc, src, src_len);
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
@@ -358,6 +382,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			return 0;
 		}
 	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 5c7e36a164..bdc487b44f 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -4,6 +4,8 @@ test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
+
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
 
-- 
2.16.2

