Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61CE1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163767AbeBOSQT (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:16:19 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:49632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163622AbeBOP1c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 10:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ylgkrdDBhcZ+AI1Gfg53NACfM2Ikwnj5R2F8MvhNaRw=;
 b=qDME/8myToogmKXJUPV6cfQRBygnekm1jwXVO3IBcZu5Bj09lQAelYgeeq2rnsmH4iPCahm59/FB9xBQmbmPTmeg1t/FB1bCboE1IPR45Ne7q0MmlR/aEfL9YD1PpftjnH8PzXL46KzV0hrMePUKaiErgEsVGF0cRzeKZy6RwT8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Thu, 15 Feb 2018 15:27:27 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 2/7] strbuf: add xstrdup_toupper()
Date:   Thu, 15 Feb 2018 16:27:06 +0100
Message-Id: <20180215152711.158-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215152711.158-1-lars.schneider@autodesk.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DM3PR12CA0049.namprd12.prod.outlook.com (10.161.151.17) To
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f07f52de-5ca2-4804-0095-08d57488a064
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;3:dqPWNqUHnyur0sYK04JFuNdDOKVG23ENz3cKJBNlZdyP2oekNo6R1T2EJ5SfPeqtuwKrgj5Y1/zr/nmsHk0/pysmG6T7ZAWb7ZdupTmwS6kWZbKticDaw55SOGPEafQW31hdTMAHIuY1QE41oX7PF1G5jc1UPOt89RmKMy+kuk0Wfu+sNtBdAGqhI4+6j2fNLAfL0rCQ8s+IH3rWc6MMUBZ1EuMM5NcUE2SK6v4MGLgId0iLQFBjOM9y/OZL0zv9;25:n71CwvbYBdMqVn8eNELiyJfsm+ESlgbUjVbfzy8dkthoUkM1m8rY+BP67WFUdKYN6kRO1pO2Sk4Wuk+Od5YP8pF36xiLeq98Dq+NChuriM5MRbVq8dCGB6C/zMOQTyVoO/oCPdvAQJVIkcmb2nIJnsXFnv34M+Q1N2GFriiBVEq+dtNQwvkb7XIGFJSwhJwKumPKcUdO0G9qwpsn4zNZyqNZZa5L7KlHySFpGfzB/uqTg3EhhbsAsuVV6e1qirZTeOIaCJzBzric4cgrCrTeYNs5oFKEC4m55YLxKPuYfL1bkceecEFNF1BV/bDXYh5GuJ3kuWfK+UtIak0X89vSyg==;31:yLY7N5dwleF80KEWyyQIQOsduqEwgvkZRYv+s4VGd+rXuYe8rzdRtVASled55bhKIWYV9NWM1RT/Z0C5PvFKcKOpcKNvhLHqLrOsgJ7URHWsyeHkyWIjyMyYJ3iZMOeyk6PMuyvdBGYoS2RsrkP63sw59vPSFfMIOiHIdaU5vOWsSOjXlWBxr79pR/i4I6g3ufkyTqCO96uOcMi2xxTKdOeUBhNvJmt5QVGPskLV2DU=
X-MS-TrafficTypeDiagnostic: BN6P136MB0020:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;20:iqq1rUTpfpuggFNQxu4XdeD0TXvKCBwR2xaibsxSbI1u+U2tZzV4xYWN0o/RqjBmuK15gROr4H1ymfsvdH1SyCM4zCcYOaK5WzHN9A2GWQrk0nBBSlAbK13H02yQEQ1h1NO7WIHICNCGOHlzyIdksb988kD49dJmr8nUDJiychphUFZOhjeawzbvuwSjmfLmFjAmCxLN7aWc0YFVozN3YU1T55y5G1D2u4Tv38CG38m6svIguBggfRHxoAk8xBa3a846jzF3/LHmnSt094JRALwFMSY5aBUqEMkf2ikmb4Z94AYp6KEW+cTTGRhpJo+virXimgtaMNbwe21VA4KP01qtyUYvZu5LzKrh1hBgGHY9iY2Bnq8cybDyFf0slhTz/gwIRT4zb5f/BnPIreT8NuWvFnf5WoeX+JWbE1R9CzWTKDsPxtPe6wLxUW+Gzp2jQ1LSOvpA6gXwaq7Ryevp9t9fb2uiRJgWAQHZxqoWqfbd5z6yGBq1Fy4Y1PmkPzXBmAABnlYnbr/sWPCpvTrcBwhesuTiVTrRLt7saTL7ng0u9/LqYPWOH9QsLO3wJULLdOp0JfqW6SEM4OLkHfVi21J/j5yEdIxd5AeDhdjlV3Y=;4:dnlf1HR/4vE1p4d3uklYr6hUFuxac09wB/p+AwdFv7oGpMWhk51NaqEimwnCVDXvSpCN6iQ+vi86Sg4cE3SsAQWpBYrPN9fSQ/+XHj7HcPK3yoYIdh0udwqNxqItjtJ82Si9WOKoYujhm+yPR/OCvVN7i0haWvwqg38B5vwGVDkEhddlq5nkTPdDz29RVZutpFngG27Ny8jjTodhx6xFI9D8tJbvSFbZH0OFF0M+xMo2Vm9LO+19GfhL0/x0nBSHbccY8vE2qwTTiCaA2Kc8vyP4pY+iCedErRlE8dtEC53tXQnC956ygmfwqg8vd21D
X-Microsoft-Antispam-PRVS: <BN6P136MB0020DA0EA8E43B0A3CD3451FE8F40@BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6P136MB0020;BCL:0;PCL:0;RULEID:;SRVR:BN6P136MB0020;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(81166006)(8666007)(85782001)(186003)(5660300001)(1076002)(6116002)(50226002)(3846002)(86362001)(305945005)(97736004)(106356001)(16526019)(2906002)(478600001)(6916009)(26005)(25786009)(575784001)(81156014)(105586002)(8936002)(48376002)(47776003)(51416003)(76176011)(2361001)(36756003)(6486002)(66066001)(8656006)(8676002)(68736007)(50466002)(316002)(7736002)(2351001)(7696005)(53936002)(386003)(52116002)(9686003)(6666003)(4326008)(39060400002)(16586007)(2950100002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0020;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0020;23:o7IkAFuzR+Ocb38r2dM0Z6ZnVEF2W6VbZd9oO3Ikj?=
 =?us-ascii?Q?SsnFBkFqbfFzie2F3aHE8V9aeaTQ2MnyaCpUFJf8QfgPH41nsi7huL+vJ9NY?=
 =?us-ascii?Q?MZqRnGhr2EkeqsHG+YtsvIB3Bog5KcjdIs37hSD46lLQbh2LUekLoKHsSg5g?=
 =?us-ascii?Q?xUnwq/clA03eoZ23UDA+n9nxEOlpJd1SzssEJz9+gP224UJIDfhYGm31oTFn?=
 =?us-ascii?Q?nhaFLl1GhR2QXNYQ2Z9ZJDQ+U2g2q3LCL1W4tNucNb0kMirinN4nFMvAGPKZ?=
 =?us-ascii?Q?ETGYz3SmKHapYd0Upvz0n80+mI8/jToLVCx5LHe4X+DqpGp8R/EXUKNPN8K6?=
 =?us-ascii?Q?QgeBPgzI2rSsdXseRUUnNsq82adCXbsxFb9Fb8AR1E0H6IcSJeRLPI5JrK20?=
 =?us-ascii?Q?PZpMsNMCgk92sM1Sb+orha8p1bpFSwdw5UwEkeTtwyUS0s4FB70b7PRB4JJp?=
 =?us-ascii?Q?5KmoWCAe6vLwJuzGtYGknrf0FALSWXEpXhk5I7oVVz5CYoXDsA0SEyEI5TUA?=
 =?us-ascii?Q?BQUuvCKfjuA5aVqKIQYb4RW5zZIRehGTDvv3rdXn/VrJYGB8t9urILYA+bK3?=
 =?us-ascii?Q?m5eHdiOpaC2QB+9dnh1Ow9ui0sRhEGiYiCuxgtmNn0/+GLR3+hneDJDFREcW?=
 =?us-ascii?Q?YrxmBkIwA/9CAAee8Fc5bRoWmEF4D73DBe8eJvjgANhVqzCW0yYbdVJoz9Ci?=
 =?us-ascii?Q?+ivp+bIjYQEGVnDdZVPuADG2o6z4FlMv0HPDStdb7DY/70MoEaC64UGyocMY?=
 =?us-ascii?Q?9cSLtZiMmFBa5oahEHYxWaYVfnvIFOoilrvgHQEEmrtQiX6ntKW4aSi2n3E8?=
 =?us-ascii?Q?sXQWIvW39X+QFXBX8cocvHlXIbRnDW06c8mW9LXCRByksZ5l3lXFJBl10KWE?=
 =?us-ascii?Q?2wQOt/woT/MN+xL6TGWN8J7wJzBkwPXzZ4U70oEL+fhuLJhymHE55q30hd4V?=
 =?us-ascii?Q?2SRs5GBUBDaGQo81ir+bRUaB6RXEh3AqgLHbEb0Qeuwc+21HKofpcqf57aZE?=
 =?us-ascii?Q?Fgf/mFOIV7+zhBzhXS429oWyyLBsXyUQPnuXs854RdBbmzl6hvasIILgmXli?=
 =?us-ascii?Q?11Hhq6H1GrxREDQJvUkx5QHUKnh9bHgYZhrVNhqFluCxsoYLKRLKefR3e4vM?=
 =?us-ascii?Q?xPV05622CDdyf3o+V1GRlsz1UyHj26l1y+OMztJ4OwPkLbtyGbZO4zP3JKYR?=
 =?us-ascii?Q?liYD5KT0+Lz9nVqCssIsddo6Bvm+mvZg6LvLZ5tTanPUdeOrKNlfc45RsArL?=
 =?us-ascii?Q?bM7slwXwQP37DfDnsN9BNfsVJ/TGqO338KzfaYrEvG9ojCpzF42B92RqwpcO?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;6:JhHk9xL5Y4BA8mCQBIu/RTr0oRGTni7uHBzaR2RTreRryEzXW1attaXR7SAI0hbVmAwfrbvnteIcnFWm8w0q1x4U8obs+N/14PfWgxE5Q8Jf+F+AAvID9yeSDdPg+r0gj3J94lWJJHCm4KqcHHINeojIOFj+AtHsfHPi/xRcrqyafmWHn4w9mHgej3gutNiKF7iPJ3KWmQN1nNO6FwuIBBiL6hG+6BVM7L2b6VYZlf2oSMHwfqJOyYoa8TlEHp8D+7o6vhTS+b39DFo1L0e8HwQWD+mjAT0f9ZTI63eT6kORqwDtnGqJCWwgTtBHEpOyQhFLJFzm/BgHcL2YMFyVK/Hgy8UsbIRkJpNg7XWhHUY=;5:xQuE1esfakRA2+iHUovrlL9qzMmU8CciKVLzP1m59b+hk+UogMFyZoXkXon0hIzPJjUY4kWIvx/onYwzLvH+HJ16DP+xWn9ndmVJ0V6ba/GcmxoZVr14/FA7XVEqXumHLgTiEuGbS7Z1Lt0vj+I3MWqsDO9aSP+kIJwTlWyNFzY=;24:yZ3vmqJUQ46rjLfsJ1Md4+l8Ccl//MsF/4apML/VS/XLeOpAVoiCJo5g8fBvaw+iqUrfnOv8hygRHeQYM4WE74C8jtT4nHRPBs2SsWH2Gmk=;7:9gKalnJsa00dFHmgGvUUZsOcVg8kd7q8nWtRLglwEMN/TsV1GjkF9vMSL+Koe/3KM3GXf8pqYADWZzPMVqQzmPYRFXGxXihGT60GWQuF/Cv2GFE6/BKzhyrMIEZuaf/vpc0ngFI8byS8wImWqM0g7XsA56YFbXsw+puayOykXmDx1ArzJ4QGm3ILgOrQ/dWReoIz6+5FwjY54px/hizTTFPl4kNJsfsQOtTbaIZBFSrb5YNuEpMAN7nQiCV3sFXX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 15:27:27.8075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07f52de-5ca2-4804-0095-08d57488a064
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0020
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

