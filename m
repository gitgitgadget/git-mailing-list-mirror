Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B591F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeBIN26 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:28:58 -0500
Received: from mail-dm3nam03on0136.outbound.protection.outlook.com ([104.47.41.136]:13477
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750924AbeBIN2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ylgkrdDBhcZ+AI1Gfg53NACfM2Ikwnj5R2F8MvhNaRw=;
 b=HHTCLpZa3cosXtQFgdnc2NsyYH8R6jMg8a8QS/mWcxQX8uSDCZq6ZmMJmhMfJhSUOTSUxHcgMMupLyXMVDB2s5wRYKpXeufG2asDnPl3x9mH9k7ZdsFHAKyjE7mekXTufwE8qNVwmx2vrq0/SQQD4s3uKD2frgV26xSUfrS3n64=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Fri, 9 Feb 2018 13:28:49 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 2/7] strbuf: add xstrdup_toupper()
Date:   Fri,  9 Feb 2018 14:28:25 +0100
Message-Id: <20180209132830.55385-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209132830.55385-1-lars.schneider@autodesk.com>
References: <20180209132830.55385-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DB6PR1001CA0018.EURPRD10.PROD.OUTLOOK.COM (10.171.79.28) To
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8002cdf-6d7d-43ce-7e05-08d56fc10fac
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;3:alrdlgiqvb7J8vNZD6aTVRlcjPvuBvRxgaxb11TjHsRA3AqqnqD4u8qXk1NozLrBZ1p8vKRmxDiRv+HvuFhY6p8/3aoFHSgXeCWy4mx9b8uNW3CQpw66EVX0cxNVA15MXvLwL2KsPIbCZF9fQe+XvynHGS8roK27QJ/yjeRdAa+vjw3aonk5kX10piwJFh9YjGCvE8uLVIpDg265TC/KNHo4SyW6h3IbUhOo2qj+OQ13ZSiJLcHLEm5J4XHKMJSU;25:1dh/03C5O2axTYC6UfwnFtkSVEs/Sxu6eR5m0F5+4+QeRddHE88sT54N5RxLlzQ49ZWb/sqvEFd9np5IX368QwPjyj7jH305uyKCGkj9/2+juDky/kKZlO7LKaAH6hPS3m9LLTwXre+OuFJEdy3aTsjZrGPPeV0x378KFeazrKx2cX2pAL5XAfxVEA7LCAXlgoi9VJdYP4iZr6v5YTYlMPqoJcYM9C1YNEw+7N6vQoccFsF8SBtnkL+NiI4KN7f05BcWkKGZa4CK81fTO4dTF0SOPbYpmIocZo1Pswst4SerugvmsHvpcLjyBK7bmCu1bHR882H9z9yYYOnO5/f1/g==;31:UFmy4ntkSBHUH0R4TMwzSnQ43si5eoLagWHccCc4c6a7t2+wpLHXX6M3QcOvzByA5QN9Vlhi/EaQ7nAvEuOaqitAgZXpqlS+gddXlZy7VT8hGh0/KRdJ5VlnTchzyu+dDxr5PkvlSfTGqhYq7q55fxtHY2ReMIoNxhzcasJ7mmbIhW0JmXziOUFuBAYFcFKr/HprUKqjwk+Br62B2D7HjLZigDooJvJ8DhDw8JAWpJo=
X-MS-TrafficTypeDiagnostic: DM5P136MB0028:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;20:UgTSGzHyvzOysaKBrXtVGlzGbV30A14OdVc1B1fMJJw4jBDMHfXfpN2tC+6rGPLQCDcuoc6TYQLxHc1x3FhO3h5GZvlqTNCypPRkSyBlJy9QZeGbJbKUP2lfnSsE1FNcyEUAF7YGpBLKWwq0w5JaoAUhHalj7bVkO+5totVIHpTDLXb/SsyjyGqB+vzZnHwAbKV9IUEnYfUTDzxqJ66/s1sqjNmlfXXIXwoWkLCu8L2QXMh6biUYMVmZhPj/hApGYCpP3Mry8wzRMXMovhUBgC6uGYNDMeW8KPikjny99b3hWh7sJ6+cKlcG42eHkKigUZe6gGWgRAA9h4YHFPu97tD+99g+G1aEbca3W5Xje6UzwNrKv4Bw13BieFO+cDHve5C62fCbJ5y8CbBo7yQfEwbn3W030UdNptXuX1JlGd80Og1WcE4WQU0VMlGyLOJvEyK0y2IO9KxGEgtQIsTIy+3zw6tiI/rwL24cJFnbvA/ugJNzbPkwDqx/N6OVkYfWkVyiVU9I/EBjvjrIyOOspZWM3QU2XJc9dYKogoNNvanzKQ0jfsX89aWnTwzrJTQv2h4Ih6nbz2RFsPGAZRfGHdZ3+L2F0KJQuWmkKnZPngE=;4:DPe/pRmTXga6TdJ2CT1NO4NGf0M66cTKRset0js4MwUERlCfHIdRJWGqfROgtnqzz4v827Cj39rAuvpsxRlG72+gXTeP7if5rc1j/tjS/C89aySvFB1TBMy7YjJxY2Kl1xE9f/fsmS03vhu+achBi2hsrs7bCml/ze4Q7U1Y6HVdZLV8PCNE/J2w+BBPwHTR5YdRuexJV1TeNiFZFZBD7P89MgZuHcgJyQtzCmBm/zvNW4cMjZO8np2Vz+BfzDWWBIhrVREj4lboc6/IhrYMokg2P9nUJ1O02CJ6TAKJqw1u8q9F/wUQakw/XiwzsG2M
X-Microsoft-Antispam-PRVS: <DM5P136MB0028B9F674FC6E6D0045F0C5E8F20@DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5P136MB0028;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0028;
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(97736004)(68736007)(26005)(2361001)(6116002)(3846002)(106356001)(2351001)(478600001)(53936002)(86362001)(9686003)(1076002)(2906002)(85782001)(36756003)(8656006)(50226002)(316002)(105586002)(25786009)(52116002)(7696005)(51416003)(7736002)(575784001)(386003)(16586007)(50466002)(2950100002)(4326008)(48376002)(6916009)(6666003)(8936002)(81166006)(47776003)(6486002)(66066001)(39060400002)(8676002)(81156014)(76176011)(5660300001)(16526019)(186003)(8666007)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0028;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0028;23:oDRj4Wx0RhlsXUbOHD9l25q5OOywheeo/wNdhWvd8?=
 =?us-ascii?Q?3tzX093ipm40t5I7FQvP6can2GNspzzbrL+adcqDtiNRTnybnZ6A/ppFAS5b?=
 =?us-ascii?Q?0qbZCiX+5JiLXIbGKb/ubciT7MNDKX8iXJRM5gJoUs3EnIGF567wfV+0WhAM?=
 =?us-ascii?Q?94hO4+I64B4WwLt4mHPYluV6fGK+ao8JUDTsTy6ylTTkF4PGSul22uFEFG8y?=
 =?us-ascii?Q?vwP832r+53MusNn5xnlv/gdTJiHpD2nynhV52s7I7qsoga3lBhed+IjoITX1?=
 =?us-ascii?Q?cr0Gl/zIeKafw0t5Y2+W/9hJ9ozgoBc2b6Czq06ATCuvNtLuaEOYSMRbHIYA?=
 =?us-ascii?Q?fYJ9CkdDcAuhbtIMpQYRBaK+DXonYtq3igKDWWy6XJl1nv7YfDelxKApKJ//?=
 =?us-ascii?Q?Geh1RhwF66i+47iHTREfgDZeVbBZgoB9kRzKyDk8QjapGU9Dtd4bioAPvbqT?=
 =?us-ascii?Q?hbpZJffVFww0PYU7qip4WvxHRQVxvhoKafGCIV8XFEM8zsicRyAmdHYdT2Dl?=
 =?us-ascii?Q?Iu6usOSgrGTt9Ta16eMymOH7R0U9PlqjJ0CthOlIrIEKDcDrdU9T8Nfub8rE?=
 =?us-ascii?Q?tDuM6sENhpaiYTbNcHSn3BpuNjg8JFlBeF63cINf5kX8Z2Pok7ggAH0rf20S?=
 =?us-ascii?Q?L2Eo89yQd/soJA3aHdCcVTZyA2+RfXrO+dmwuMs8KSeV3E2HD4AiaIdr7F4B?=
 =?us-ascii?Q?1Cs9HpXEOozglo+O6A9nywu3IBi27cTTijtKlzsC/2RdW7M/0J/+L3aC8Crg?=
 =?us-ascii?Q?yJGKLY68dMXeHsVQ4uvfPTh77V4lH6PCe77C22xcbqL/IUukD1dSaWxTVYlJ?=
 =?us-ascii?Q?C8VmB+hVdbZCC+DniKn2VIkNJj45HM5P7AGURuXwWdtwu2p5wvQ4WsIOB9Fr?=
 =?us-ascii?Q?EYgFQhzsV3T3kxSJn6S8soCluQ4z/o5ProdXdzrkoauGuzF6RCOOv85vTGrb?=
 =?us-ascii?Q?Eo09HEFPa7WY0rfAoBMvcWb7XVSqCcBmsRLoD+FPzm9Zv1Ndj/BqRyX/uZ3a?=
 =?us-ascii?Q?asQKA8hDydos3HNOCEJ7jzU1G9E7LbpltMwqRb/BoWMPV5jO+GyC8qZ9trGQ?=
 =?us-ascii?Q?ahqXMOd+RM6JUOilDOkha97J6Zx62WcNKGzsK12pon5ADm9jeSNLLu9zERlE?=
 =?us-ascii?Q?Nab6V7LPIzGi9QcMUGEE6zG1wKRpXYwICLjxv+sHRKevzj/NrXWpA88dBvN6?=
 =?us-ascii?Q?8KDWSV7kW8ula/d+4IvXhFfOETFH3ae8s6ty1DJ/44JzSl+Lchix/m5ewdIg?=
 =?us-ascii?Q?XhAW2S9aYWVsFyIzJ2B7+yWny5pvkEQ8PR8Kv0jLcT2CfIWdwfa3VtRsAnzk?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;6:fRtloEwWalomXiNrBQ8X6JV1xL6BVJnRhgVFG0i3ub4rwtJdNQfCjKLWCbJDWZFpJXGDVzHfcEtGxhFYl8hpo68fuovTT+B+0OiGOubTAzqrTE/Qx+y3Oqdy087ko3CwHiV5LOCBjs0V5DG/asQ9NUJlQpyHGxYiZu294tQLXDBCqwjStJacFEAS+vMYB+Au6p3eB/Z0vKsymqpxbCq/9vr5AoK88dpGTOL0JX0d5GGlDr/hGUZzXhtthANccEZhUoQyNvCMOgL8+dMo1698SiJzG62MeslXthqdStqfcMkjRzVIs7R5nw+eItwKwWZziQxSVid7yVolJ9KnlMNfbyg06VoRhEUrXRx6ZSwYiTs=;5:atxUL5h8AMIO1B2D9CQMw8kL9c56VUgL0QTQdo+vs/r7fNJMST4YW9BpUJJbEV//XEJ2oyjjukV8GnkYRQm/4hRmLRNQ8fqj8KYZOlfDBvmZmvAl1mdcbdbADudwxJ2QUnF8Gd+aqd4sr+klvF+BHkv4ccU9tIdFMcQ0TYW5J6M=;24:w9LzRdyQJkkAdtUPAj66EuQAjiIoitYzADUE4GGcgSRiKEAqD/5uviUoit18iU4cMnNrfPcY7tFkY13FFj1nTFelRK0YU4O0lXa1EpTr94k=;7:GYOoFY8+Av6e01RPryPhR/mY/3rQK6YRpUXlPEI/ogf71PNh9nDwnsmJhXtB32ORkEOh9xLLF71H6D2rsmn9vR3rwvYSAF2IR6uoGqrY4tpmZnCoBk3f4qCQWts7D/Qv41d68dsi0oqU7OyvhpSrB298wp9wb2vwQIz6XjqS7a3+EeISE5TbLBZ3DRYP+kdm7VP6jHQMQ7Y3/g5REA1hBwLmpVg4tBsZW19PlAPC5KBQH+b1bZdD+/ie2WDrUp3/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 13:28:49.7939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8002cdf-6d7d-43ce-7e05-08d56fc10fac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0028
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Create a copy of an existing string and make all characters upper case.
Similar xstrdup_tolower().

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 12 ++++++++++++
 strbuf.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 55b7daeb35..b635f0bdc4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -784,6 +784,18 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }
 
+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..df7ced53ed 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -607,6 +607,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.16.1

