Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D5C20A26
	for <e@80x24.org>; Mon, 25 Sep 2017 09:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934513AbdIYJzs (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 05:55:48 -0400
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:37136
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934475AbdIYJzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 05:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vgRMK8iw/B1PylHym6i97bDa3SELBo/3O0UMb11kAhM=;
 b=UB0p3Lqi0Z5AltLW9FPBFyJeM2D3ukanS/QImyS39TMuT8XSPym8EtcZaxFyzwGYJw/XWSZqwav4fR8LdbMp6cFBFwAAsQ/bM1sMzFhoCGahPIO7yS7OFY2hcCZgb+LyavOmkzep1q2GtWrH2Aes6KGZXMy5vM+naMzouu5awMU=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 DM2PR21MB0092.namprd21.prod.outlook.com (2a01:111:e400:50c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.98.3; Mon, 25 Sep
 2017 09:55:20 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 4/5] sha1_name: Parse less while finding common prefix
Date:   Mon, 25 Sep 2017 05:54:51 -0400
Message-Id: <20170925095452.66833-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:404:b9::17) To DM2PR21MB0092.namprd21.prod.outlook.com
 (2a01:111:e400:50c7::12)
X-MS-Office365-Filtering-Correlation-Id: b7de528d-bf4a-442e-e6ee-08d503fb88ad
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:DM2PR21MB0092;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;3:wRTVbP7WSmoacsGdMPyPs7W8ag9hIAWJfLxPQhOS3JFw+niugC20KFEQ0X7njb7Uhd7nISKSdbTii7IFpxa+r5P+mnLVzl9zEkIVXKCihxhDaK11PPlFiBBmDOYblsOCB9i22m24Abhxo9FMRhSqNP5aPdRJQDTSokn/0GnKCKNqzqiuCFmL9ff0rZ3V7qrb42Re9hjNS8rrRzK48sYTAyKZ60TULHASjl0zYf1rVfM966JTfjU8wog8HKW+OcGx;25:AO+EgqslX/2OrTby961G3b25GR+0ceXb//V7Id2XKI52Sd7lSrBMTb6UNKel9ItjiJEbPgjsT6NMZ3Z+uGUFpsxKCaRQR6DIEJJmPeWO73p4o1Bi0NT0F4voe2Cg0VIV2aor2/AZsWgicWv7qcorxl8EIGgAvsh1xQsM/omuNJvOriVdo7VtPow0hluMPUAaFdSgWhU1nUVdxmT068dKLp2MBsWEdn8zCoMTuTWjgW97Q2/n2nnv98e3LZ1qVFr+TN7mgIpDRXiYVGnc14PTOJMiU+M9KCECnTwa6yiXuAJmnOIWNOSVZGSVDOxiS6IETTW1NELcHxjDwQVeUtitkQ==;31:84d5SkEmk73kUwW664JcSdcz98Ug4F5K1RWacBKUzxxLoTi78ohR7bPEK2c8mR5T8D0pNP2Pg79qa/Y6eBhZbhUvlPeV2qtU3Sv+Rpifu3tta6OCCJneei8PDwWJv0wnYmHqv1YBZcXKwgnOH4dCaKwyphmu/BPcNNKYAheV2qIvywwOVOpq+aGTh3f5LbjBtMOeAiq8GKCluuyQDLdEl33C0lWVGseFX4aMivyNqFo=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0092:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;20:k3GUzklJyIpcwI/WkKP7aKoKFK5IoncUAgs+0mC4KEO3fSkauUuUcDp9jTjBijojnl04RlK9aeHB88vcaJ5mzo7+pTaJYZZSluXteaIyqEw5oz0qIelgEB6HVOV5zcOiDR3BSDOWW/LlF/s6Vo72HRCNoS5HHt2pYkpoOmfUgjkXFOmujHaqC1WEFRiVw3t/Ikt0Lc/V5lIlqLknOnRWxwW/OJbn6H+yNu8SUDl61FLeSVevWI8qi/XEkx32WCco8M4r8DM3EVR6diWL2K/nlAxxiCdar7MB2+LWEDsq36KqNEed3nqd/Z/P5MHu06Z+uZBOGA1G+KlLkISLSiNbFfY1s1YmwqEmg7dI2v1ufDfprTU/NUBr4VtRt66dARfpZNP3at3Oftp/iL1y1C+VUYTTiH2Os2/PXtHbWBBkKwWuLY1XGUjCLl6CoD8I3jSPOFohIgU6NWEeqdkmxqx3huRgv3z16YeUqdKtONfZ7cBxXZ1R03eKUemaFA7TWxss;4:zGxV17SBS3yOLaaaDq3d176MAIUTzyiMmB55Gh6j+olYI8IDeFWaqBEjdM+NHDs9SbWuodshFVWCIyYGViZRMNZ0gaAevSFzTanWZmCbuAWMiTAM35UmpVFCtwcXUddPeglNdxKtaEPdiI3v+rK3LpkG3WVufqeai+/Uwi2pcy8EgJTjoFukLuLLIQBV/P44mEXacAhmofGO/3UFP0D4wb7J5Vo7xrQnSEewYGx6i6oeMWO0uT38HpZgW9Z+LVUHPLXEvq4WsooaTsFtqseqEh/VWbY2xK1Z1cgwLA5S07s=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <DM2PR21MB0092C4723B6B24AB66047563A17A0@DM2PR21MB0092.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123555025)(20161123562025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0092;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0092;
X-Forefront-PRVS: 04410E544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(189002)(199003)(316002)(305945005)(68736007)(86362001)(10290500003)(101416001)(6666003)(7736002)(478600001)(2950100002)(105586002)(53936002)(6916009)(2351001)(86612001)(4326008)(2361001)(1076002)(48376002)(10090500001)(6116002)(189998001)(81166006)(5660300001)(25786009)(8676002)(97736004)(106356001)(39060400002)(107886003)(81156014)(36756003)(50986999)(22452003)(6486002)(8936002)(2906002)(47776003)(5003940100001)(50466002)(16586007)(33646002)(76176999)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0092;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0092;23:W2piGvXeG2gc97HpACQtjnMPqFAq/6IYIh8dYOXqD?=
 =?us-ascii?Q?vYm85gi7giM4908f+lokRdQHD0ejpYkatrGQGxwQRK4+Pgz2OQMZfXyapqDa?=
 =?us-ascii?Q?G4g+Iq95y8/0JTIl3N9Vfrkj2Ey/kGUcRhohwZNss770F7yBby3KvnutaBw6?=
 =?us-ascii?Q?p+bCxobVVyc2tnWNcPPgHQo0r6ne2hjB/6Fw+kUtbCfIR+zRIM7MV5aV+9Rr?=
 =?us-ascii?Q?fDQYqhcHQx+iLoGdcZh3pWlne4+Qt1dXXYA5+MLM+VOzWdOWy38iQVzTLurB?=
 =?us-ascii?Q?nx7UA+gMBzEZvalOU1SMMXZSFX0oBvpP9SJ0JMYnXUmtGn0Jrsc5evTby+an?=
 =?us-ascii?Q?EflEia8jp85AhVJFTIEiydMHzOdo1JZyBeuzNU+Eey+4blhuaxWGTUToEw6U?=
 =?us-ascii?Q?jeIRfXOjUp3VSvCQHaNxs/znrrOL4DgdexBHjvGmzbmezf5XxZtVe/pRgJhW?=
 =?us-ascii?Q?4ZMjpYQFcauUaLKMc4g6eGkRSqk8+GSjEF1hd+7OLy7mFtPbD1Hq1cr3NRHu?=
 =?us-ascii?Q?9gPOhpofFzg7v82pM+PRLUesEoxM6TuSMkOBNe9VaAt++9QoDeS/hxkNrF5B?=
 =?us-ascii?Q?16NPDXnqZX1eWywH2oHX1kcO/4hJzTLPBSpPtTKEEteMnSy0Cfkf3ln8Kyqj?=
 =?us-ascii?Q?Yz1BBkkXeEB1sHEElSifi4uivJt7lXKQQWfxmcP/wh1R1jWrqH0+TShhRcBe?=
 =?us-ascii?Q?dize3enR4u56letfGxHqsPIyjHsjffzj+EHTh/rdV57fvkZGvFDjE+c8QRdB?=
 =?us-ascii?Q?Te/thrLsUdECfwyZubK8MyNsGJIxV1zAJyX87V2ymQQsPxOrdRA5qdZCtxsx?=
 =?us-ascii?Q?4nWD0loEvW5Gb7yzaekJtr89kWHi3lBp96HeAb8k++mEX3KHJXnB8NmB0jDz?=
 =?us-ascii?Q?f9P37AWhp5+H5XYncwLe6+L19aNow7Mq2aRi0V3eAFXlTNmHAtG8exBYN9Ed?=
 =?us-ascii?Q?zOIlAlFoDtsOM1k5bQvQ2diYpmTZLje4yYGOpspz5K4XUDO5ZnR+46CNR5wM?=
 =?us-ascii?Q?UoDAuVo7mIe6survUt5KjqjLThCBWY1Wx7EGtqu8j56qJZfxGlB66ZgbRT4G?=
 =?us-ascii?Q?eFztzGXi77BIK4uz9l9HUkisO6PmXEA3S3kxpbaG5PAqB/E9nmnd4Kvyec+f?=
 =?us-ascii?Q?IskqWba1CS07UZ7OUmNjY2pUNIoXwG2WqItBlZqXtmh1jf6a/zvpt2yokjGk?=
 =?us-ascii?Q?BhW3bc47rWnobRKdfzuNety3l18mwk3RmGi5QIPAQS5rCfs9n4/fW1ggg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;6:fGsNvcMHuvAYc9iGzRvoSKovxDIydrt5SJL+oYfL3RHoV3qkFK9mRE0Rv5fTERCY1j5D9zOc+zunu56hzZR+wbzfyeZYEecbDQ80zMS31GHwF22qEHdt4sQjI39r2/Bf+DR9qlnCNf9/V1AnAY/tqUMihh34lGncGJp0MPp2Q/jgATH5oafCEqPLfEC3nfhX1XnHgA+HqHJCZFiJM3g2xIPOOhsrw3a/lyaxZ7ih5LQZG+HP6W5BAU4aQMABzdxhj6Z9GQVb7NKooNlxU8v9+fSwuZ4mUpExMZjrXa8ewvovv1DsN/8Vldmp5fi5oNdQ+C0bkTvzKoF4nLZisPPQ5Q==;5:tPRIL9qexKvEuJ/qvhrYOxzR6K+Ll915AixvqXp9sHqEbsJnfMDH2MnWuahsotFfucDzU2NhwhGhgXxljeeGb/jTTrmF7fw7LB2Oifc/ItlPIP4e5j80na56DJRCNf4L0J/NJzmivdnJQ09n38Kanw==;24:C2hbB9G92JrE9xz9aXJ3M/inRhIHiKx/EwCpEq4LWB/sJ2ioixl92KDGWvayNI+0+I/FYDCI3W3gUCUIFY0Z5y7KwnZVrEVLzFBnFj0sCbM=;7:4X9bnQdvA75KBR7mx6ucIuN/2mXIe+25scV1dk0nCF8Bt/TKlsuwe6KMNOZIwqi2g4tsLJaaWufyoe7xpSgIoFNEQxwZkWfEI5khSQ7chzFoQXtJJbB7c/T4/0q5MFdo78nCzMYh/q6O0AKWhhaawWZxmwH726jAUcf68NbvdpTuKUcHcEOd6QxBo6WPaB1qcCoEWYvfPQTEnsD3hDH6C1xND/5YswCwvqnca+nmE7Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2017 09:55:20.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0092
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create get_hex_char_from_oid() to parse oids one hex character at a
time. This prevents unnecessary copying of hex characters in
extend_abbrev_len() when finding the length of a common prefix.

p0008.1: find_unique_abbrev() for existing objects
--------------------------------------------------

For 10 repeated tests, each checking 100,000 known objects, we find the
following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.08 s | 0.08 s |   0.0% |
| Git   |     5 |  230162 |      0 | 0.17 s | 0.16 s | - 5.9% |
| Git   |     4 |  154310 |  75852 | 0.14 s | 0.12 s | -14.3% |
| Linux |     1 | 5606645 |      0 | 0.50 s | 0.25 s | -50.0% |
| Linux |    24 | 5606645 |      0 | 2.41 s | 2.08 s | -13.7% |
| Linux |    23 | 5283204 | 323441 | 1.99 s | 1.69 s | -15.1% |
| VSTS  |     1 | 4355923 |      0 | 0.40 s | 0.22 s | -45.0% |
| VSTS  |    32 | 4355923 |      0 | 2.09 s | 1.99 s | - 4.8% |
| VSTS  |    31 | 4276829 |  79094 | 3.60 s | 3.20 s | -11.1% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 4.61 s
      New Time: 4.61 s
         Rel %: 0.0%

p0008.2: find_unique_abbrev() for missing objects
-------------------------------------------------

For 10 repeated tests, each checking 100,000 missing objects, we find
the following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.06 s | 0.05 s | -16.7% |
| Git   |     5 |  230162 |      0 | 0.14 s | 0.15 s | + 7.1% |
| Git   |     4 |  154310 |  75852 | 0.12 s | 0.12 s |   0.0% |
| Linux |     1 | 5606645 |      0 | 0.40 s | 0.17 s | -57.5% |
| Linux |    24 | 5606645 |      0 | 1.59 s | 1.30 s | -18.2% |
| Linux |    23 | 5283204 | 323441 | 1.23 s | 1.10 s | -10.6% |
| VSTS  |     1 | 4355923 |      0 | 0.25 s | 0.12 s | -52.0% |
| VSTS  |    32 | 4355923 |      0 | 1.45 s | 1.34 s | - 7.6% |
| VSTS  |    31 | 4276829 |  79094 | 1.59 s | 1.34 s | -15.7% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 3.91 s
      New Time: 3.08 s
         Rel %: -21.1%

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index f2a1ebe49..bb47b6702 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -480,13 +480,22 @@ struct min_abbrev_data {
 	char *hex;
 };
 
+static inline char get_hex_char_from_oid(const struct object_id *oid, int i)
+{
+	static const char hex[] = "0123456789abcdef";
+
+	if ((i & 1) == 0)
+		return hex[oid->hash[i >> 1] >> 4];
+	else
+		return hex[oid->hash[i >> 1] & 0xf];
+}
+
 static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 {
 	struct min_abbrev_data *mad = cb_data;
 
-	char *hex = oid_to_hex(oid);
 	unsigned int i = mad->init_len;
-	while (mad->hex[i] && mad->hex[i] == hex[i])
+	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
 		i++;
 
 	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
-- 
2.14.1.538.g56ec8fc98.dirty

