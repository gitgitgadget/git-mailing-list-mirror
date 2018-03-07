Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83A11F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbeCGRbL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:11 -0500
Received: from mail-by2nam03on0116.outbound.protection.outlook.com ([104.47.42.116]:51485
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754551AbeCGRbB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DJhjCRjehD0LnL3cVHomSGo8ket+C0AxHmdPWvbRDKk=;
 b=Gg2sC6lA3FM2zLp2YltTwwIl5RmzqyvEdd1f/MrmTFzCK1h8/ToO9oV8TZJI8pBGN/9k3Hbtv982SgbUY6NTmCziYt/USbdzKAGT/M4sPRwwezLfCsUY/n2/gOTqH5e21KYQOHR1au4NndD5pMmhMA0d5m6/rAS1ea2aoahynp0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:30:57 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 3/9] strbuf: add a case insensitive starts_with()
Date:   Wed,  7 Mar 2018 18:30:20 +0100
Message-Id: <20180307173026.30058-4-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307173026.30058-1-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0083.namprd15.prod.outlook.com
 (2603:10b6:101:20::27) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bdddfa3-3499-43f1-7174-08d5845131db
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:UEYEH88HOcJNABV7JPj8Aj2y/BYcyw2vbxm+YV7IsEujgw4jrCUVDRSCL/+RzP6XKuoq3ovodnlzpG2Kk8XOMiLbCKTwATP1kzrzwrqlHKUZbl1gg7VFUTQebTgDyNgJ0pVxv2fdg2o2lCq4qZfN/zlUXI0krOIAPf+DhCY7G8ms6P9cqHyFkFB8/aVI2plU/4fu8Xq5gOWesJqEzaJKcnTXc7JOy04f8oDnv3++VJF4vGmmoNLtPKywuBgp9L5F;25:kSPn4NTzXYpEYn6vFUMgA9Aj9mhR/Bh1hWwLJtZCQqHfnJJuHX9hk6RRNiPotE+mNxpkpULppNyoSawmVcW5F3be2GPc8kd15FxJZHugmxyn20mI31IXySSYYFqF6eSF3bxFQ2Q4H3tL3aR86FOlgPzgxy7QbkwdnWEpKUdnxie6VW25QAs7bfgxFykDSHbupdIfaMsw6D9xg8vgtF43/z1iHmW+ssK/QV/Cb0DmwBvpZJYhQgvHsUHMzDSo2UVPVUElepaNcfLDQ5TYhBXw/JhcQdNCzt5jBYmVipRqmY5DBVNZfPJolBwTTq9U5FTmkfqQk3Mm5OBKHvjiXqgcDg==;31:wP955ijk4LL7dqZrV5NRr57+Z2bYOZ+1jpEXWQDLKgjBaX1F93QggXpithPmnLDaoK7KMCj0P1KT823dgxeKfEorUESf5V2cTzCX+UA7rtk/vOOtAZEm5CfwPECg/h/0oFmZIUwtaneaeSl7mQ9lauvDfsD+59krnAmOTHbQKREjaD+rIhYMQljqQq6iOgzz9AMU/vMzPhYUAvNcBKWXKfqncNfv7JrSN1Hw7VXLh54=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:dhgED4WazpMB+AmQ5lurWdp9YZUZh+jVEQJlT9qELuEF1ioQ1KYHLBoE40IcR0O9MLvAJFriQptRxW9HawY0SiROFl7WkxJFUsptKdAmVmuIi/+HvoftuBegZ+217IwtmOCn0c+faJhDgDGmCeSaGYyu2D+lr7bZ6QaJSa6lGGuxW/gI4Ri9sTVs8b+eJ8t5Tpm8HsdB/mc6860WVK1DucYrcl8DRP2nLHoVJyKhCJFYZ+oxde52NNj0jlWeC+QeaB3Bawb6PwTntJ/KMDSRtef7HQwLrM5b72GsU3RYvQoOROsubh2uKmYlGUUzh9JcA0RgG8nvGYBPPM9mtRYSBSfjScupjvYjRtywl1tQbto7vv8PRC7dYwUxBv4JtlFxZwhD9khvZOey7zRmYT5Nx6bKNIJB7OX9Yb39c4q3SAA42sEpiTXAsdBQJ3nIA7CrAGtwiZXrPvesCWYCTyK9hgOZDnG7U937YCBY2DkboMH+/oZoXTtiGFvc/y74sRgYfFCsDr+dOYes4vLjuXQMbdCcbzlY3WaN7L9rirkwGCL2QwerKNYleuZIX+5Cu2Fl0cFftK9Qz+gV50fOc5bc8k5waw29GPr9uoT1HOApiDU=;4:QvZyyPg3l3rL2XttFJyOLxs6V2Z38EIot1TjFbZhnZy2ST8Cd4D9H6SOggA30dPLWIgGBEAGrkVPFMp8qJagKHwfbmcWChBExynsMVhyuWE49P7aK47ru1XulHjTeBL7zovbjX/HWoB63FDqGvalRYHm6j5t6ZsTBeugpKsstaqTmtvjlfvMH8ONm/seQKHAhLE5WUJrFJ4AR9ur+c7oqjlm1ED1GztgRuF8HMhijyfap1X4sIeL8vWxOKnkpt/VPkkI7T0JFSdFX9GSfR0O4taZumOFqimG+9fDtaxFGiLAjf2FB5onCCmvLa/dXVHh
X-Microsoft-Antispam-PRVS: <MWHP136MB001498BEDC7E29BD7E4B632DE8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(6486002)(4326008)(26005)(316002)(8666007)(386003)(8656006)(39060400002)(76176011)(52116002)(7696005)(51416003)(97736004)(25786009)(50466002)(2361001)(2351001)(105586002)(85782001)(50226002)(575784001)(86362001)(478600001)(6666003)(2950100002)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:k869o+9uwSudLrKmJSI54l4L/EbqmTBDXZzGAMwxq?=
 =?us-ascii?Q?b/FvNa8oq3/oslP53u29DNHAeOEqBonDA70zLkcY1Pt2bB2o8WTT6m4a6g4b?=
 =?us-ascii?Q?mCNfUQYODCByG6yK/lk4UF3CpaGYrh7uvg5ZVDw+V6dQ1x8PtxpMF9BsSqIN?=
 =?us-ascii?Q?JdQb2nGaSOW5nHtnfOanfM3ohxiK1NVTROSXNWZ3HTyLd9lW+B0CPEwdYrmR?=
 =?us-ascii?Q?kxfw+pRSIa+E1ZyVlA5iUsxHnNxpnaItHrEr/YMgCCLm91ACSaJ49nz0H2My?=
 =?us-ascii?Q?oAqAJ4BJJvaHa+HqoM4j83LCK1Gae1zQ9ksqMMikEl2LI3G0YpO9bSMefqJH?=
 =?us-ascii?Q?KHN/9j6GDnYOZ4uotiBjIiL+3jQM1stPe4tWoHA0+hGAzxEy05sRO766eiqc?=
 =?us-ascii?Q?AOmHRL+CDAH4GrOVRYCG+g+gAU8YhOpAIoguUriet3VopReXGVaDgzUzLnsn?=
 =?us-ascii?Q?F/GzbuYR7HHjvx5DAVRBaupW8/AgIokMelTvN+OirIT+0ZHKbR8ZHJBq5dmC?=
 =?us-ascii?Q?pGtaP1Nuuv3TdotsETeHfokYTYECLm7BXeFIJSwBg3TEJ8XJ1mrja+TNALB4?=
 =?us-ascii?Q?cblDqwPAraH10FCZe6QZ8fRVp2INP+X3RhRBAUgLFd08/xENh8+mI0RsfIVS?=
 =?us-ascii?Q?M4k6B7U3IGxpe/1jmkKgDrtZxHWlnSjPHMQ2gYr8XCRmZBdMA3Qvnr+sOqgO?=
 =?us-ascii?Q?tgQC2dLNDGQ2tvPpICtUbAhG/meITFKoIzSRKIoI7utJXpxWSVfjnV3CwCq1?=
 =?us-ascii?Q?mTjvjLaJ05Yg4zkMq3CPG1D4uLDag6ApZJePnYY0F1DYYcJsPqNnPfd8GeVk?=
 =?us-ascii?Q?VXVKUEzsjEDQE9dYffX5MFj58BP22lo2r6sKTTWRzUyZ1y1XCKF2UrKKt8se?=
 =?us-ascii?Q?biawiFYAwImzDR9Vt+3UQDdnZ+YjC+eQzEXVhRk0AcHRtYd4OhWRKBT/ssTr?=
 =?us-ascii?Q?2Qj1HCbx4NPDF1gV/smh5wWmDqP0/mp31EYIZO5s7qJ85FjxEoloS1NMGr7C?=
 =?us-ascii?Q?HzlloTdsrZSeQNMWmJTMXJ0LbuNDhuF9WIXcUiUAjns+NE2snpS/WDQ9PwkO?=
 =?us-ascii?Q?HQIHKEHbeqkoD5TFIb4h3I42FqKM7d4g3nd9BVqtVgOhUn7kBrIr80hmQgAP?=
 =?us-ascii?Q?Q8MD2KdPn3K7IVIGJOOlmyYhfubbpJ7rMVkuo7TcekdT/kiXcUiYYoz8gIog?=
 =?us-ascii?Q?uL0s90+Am4OvCLnVHAQExlsXZ9if5ZPPOsFQNbeZPmB1nezDasxnH1qCyvFK?=
 =?us-ascii?Q?hKa1kL6qB4Kq/aZu98dWVOVOdkYl90QHppb+mYdVQwUul4iszCy/lQ4RJiSY?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 5OebI1BGRx/DVHNuIFcr8GGBaPN2VLWC3CxkLVHQ9DgtdH/1p1mYzYf5f9We3z0Vpy9uWiCqGdm5nasx1iOH7mOe3ofu2irr/dTSqO8ENcBoDOhLPG0cT+NtViAYsiW6COqCg8ODZMzbO2FXT2QmpbmZPgNhEawtTiWJAymUG19xGfzfA4bxuHtj7jhxKtUm
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:yZnrftBjMXOO2ayoLH2R8my05tM6fogTKm2qb52ircvC1dxateuSyvPz296ZvGDGmku/70pTvaA5hU4BadNFuUmd6j1RK6czcNXzvyl91ne4++/S0PYW3MsBj4NsnDVxc4ucLERAqr7FCb7o3A4DQTHnFnoTFs77uYNkL40KErJqdNbNDOEf2XrdY5acAieY97vEqa2k4DQ7sRgekCCenqN+q+TlZ4vizvH8CmGU/45B1R3iwNtYbWgT4lDSq+L6s2sWcZf0dkfGdfKD4AxOd+33FdIUxeXFo94tiql78ME342XF4/W10p7H7HMeqtdDjrlrFN3mkjAZ0N5SoEkkfhAfgYpu/ICx+TvcI6HyYd0=;5:KwQUMUwD42CfkkdoTrLbmZ58Nnu0tgkuz05Q46bEpX6yqSCtBrE6BbkETS2/jU+nOkv4PCx2CwH4dgSyQclB4R0GnwAbfgdRH2Rder4r3W++JD0bG7Voepwc1um5DTA8CJeWUAoLXbY/DTy8y1LfBu6SSBPm1Che86WMVvbGyxw=;24:n4zHgidQ15H5NgRG43fRk+c0d11LkYmYaslqqkYH1pOb/rbjA6UOgW14D4+4Rg+sx2xJ7CfmqVrAlTAfq8xcBqbXEVi3PXgua9DKah48hJg=;7:v9/uF3EiUj1i376tH4sAHIZDbUjdA3S3AUfOBcUuNW/4h2tAzMBGZJ2lNk7sj3ZB6WRyWu9CdtjwE8Z+ePYXPyQ+X5seqUvKi5EUCNHAjABz1m20WyobggKCX4e18SsvOcm/Re3mneoBAaFZg8cTRdF1XIxMzNHACmZJgNm4KVfaPbc2SS5ABrKWM/jmJ1w6SS3cLskbWBT/bEsVrh86KRFYw3l2R4PUGTSiefcuN2kTqGD+8b3M1PlYBVHNs1B+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:30:57.8662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdddfa3-3499-43f1-7174-08d5845131db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Check in a case insensitive manner if one string is a prefix of another
string.

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-compat-util.h | 1 +
 strbuf.c          | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531e..f648da0c11 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -455,6 +455,7 @@ extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int starts_with(const char *str, const char *prefix);
+extern int startscase_with(const char *str, const char *prefix);
 
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
diff --git a/strbuf.c b/strbuf.c
index b635f0bdc4..5779a2d591 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,6 +11,15 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
+int startscase_with(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 1;
+		else if (tolower(*str) != tolower(*prefix))
+			return 0;
+}
+
 int skip_to_optional_arg_default(const char *str, const char *prefix,
 				 const char **arg, const char *def)
 {
-- 
2.16.2

