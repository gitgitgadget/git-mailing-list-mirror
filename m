Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2381F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeCIRg6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:36:58 -0500
Received: from mail-bn3nam01on0113.outbound.protection.outlook.com ([104.47.33.113]:10015
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932165AbeCIRgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rupQgFN9SA1yHLnTEn7SiP2BqdvnAo+RgrUpsyJm6yo=;
 b=jkP2pLkhmpXPof+6xCGVnmRFHzG4KHXEiu1YBj5AIqMtNEDgBwBnK04Udrgb55lKi/PzCHR5uRraZaJT4rJZSBGxCNeJW+WDvmIVLQ2zSd0V/MuTfSct8MPTL3Ecb2a0Rj39VOMkpYNwRFked2QsaRFC5+mQrV1WPDzocQHCE5o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:35:56 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 03/10] strbuf: add a case insensitive starts_with()
Date:   Fri,  9 Mar 2018 18:35:29 +0100
Message-Id: <20180309173536.62012-4-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309173536.62012-1-lars.schneider@autodesk.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:104:7::21) To MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8283018a-3d2e-481a-2d0b-08d585e438a7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:QxaQeNkb/uhyoQxhmXSNQa93W6SHr81RM9B4OT8pQy1Jy5TQEV687xQoDvX0E1WdtYubYo0StmRQY2YG39wnXC3Ds1t04o7jXBS4hDAiBmI5u50mVz4sVPwAJjYTRicls+JLBng889TAmPopRZqePAfh2OEplnGUOXxkZAfTj7XmRQHsmb8T2coLTHxB1z3Ea6x+CYP4CIPDM+Pb/KEyuxYEmcD7TTW0tCnOfa53NwhT3tTUYGR/Xvj/UfNj4Sy2;25:67XgPb7zLVvkZbwtiClwhMy2PcgYxCP40QDuFETy8Y2y8nXRQxcFEjktW72PO91vsH7sAyjiPAM/8yfT9z8aVZVy2zUP1rIpdq7nDlmSjPkpydTORMt6nW4sbGtq6m719vEXXt+tRmeSYkywcBHeaf1RQ0aw0l98iT6/90RSpLV0YZtfvK8MYBwqbrQUlA2nzbI84zaTECCyRgIn1mRHEXKWWQ0C6uodSDOsYVhkLZvs5b1Zc/oLogu3Qb/SIAelcbaafRR/JC9RU0Tr8NYjEVDc8jmCEsnX0qaamZdRa6g6fox/yTVD/BycuDTYN7YtyFb30rVuCjaAPHTJ7H3GCw==;31:RdlHKVVjpwdKkuJnUBmG7LBdJx0d9iY5CvcjgUcbGRExCQ290Mu6Kp+pOcZSFrRe2XCuHrMIwyuj9EvbRg2jlgRFFkSVm0yR16M6C6kwXJfaSOacjoSxS2g/eDPo0/7wW1nhd7VK8Gg/iIITC4YYqsYUYwMQMmm4CEIRPf9Z8XUaGvEyejCieLMPDps9RhHtKAcMS1nZaXeLvXIHVOQOj02BsxtlH0htN1nOqmVeDY0=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:wt3UnOPaj8fjvXnrXcvOgYqoSxWpo8jFHb88z+dOgHssfnyY/r6/DL0pavzwEnWcmC/OIquew/OGjfyt9zOm6rBybp6YkYXIHeFqMzylJtJZTq6WD7EojGctuqJqMQ7U1LNnk5xLAGDGlCERFqkfVZvmQGeNDEhhPc8Yq2cjI+huO4LKCuY+c0WO2YcipLt9uS0Ki5NPgcsVFDI6uY3peX32Rwj+gVtKV2JQI9YakZBEOoo1Z9Tl+70UbGUo8xeifNMPMtgU9vJawmDDzXWhKOYknpk9/KehzyvvIzUQcFCUz0OnY36JK6UY9PY2DykT8cp0Wq6+2MpZXIKNAWM3OxJ5Ff6tkOVm+uc8acGKcJK7/MCL74ThnVSYv5hziZtFaqol/YjTEqEeJVzFfq0XDim+TwfTHvKEXGYnGK07o798dSLhhzVkMcumsl6bnEm4nssbEK5Tydnv61c5A0PPkqNe3e0t+H3z4OCZzvnVLln5dKB87u0r6HO0STLktLYGF3noJU692ss4qu0ryVORuqSN5QdLxwgRp3h3+oiJ962CKFMrCf+Q4aaQILs7wiFD7dAQc4d0K3ANMWlVl5aZof240+yx9eZZPQs1qvU1Ba8=;4:GDteDVO6za36iBWrOs/FimJADQacsj39KUcR2PhxVeG+Jzp7zdV/TjCoc5HD1zOwjTuJhIb1s++ezN61EuO1Gz3YJyL9gCW9fZS3JNqCnChzpwbVdArnHdsgQJBusxe0SlhlabYX5NuFwjsPaNYW+P6xkozHKbyGDK2EAawjwRik0fBPU0ZngiQTYGmwZBtft6dTxLy2X4EBRzMU4G67YbSef7ntk3TqIM29hcAh860gl4P6rOwiZwWrcZdXCvyyyHIuHLLsl9Ppmit3NkLajVw+Zdk/fclgTLfNrdNMBv/j+KvuJgiKkeZyZmP9NONF
X-Microsoft-Antispam-PRVS: <MWHP136MB00157150C1C1212694C90B11E8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(50226002)(76176011)(8656006)(7416002)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(6116002)(86362001)(575784001)(26005)(3846002)(85782001)(316002)(9686003)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:/rfOO9kYxORyEJjTBAhRDwC6OHLCOP3qsJHkemz+2?=
 =?us-ascii?Q?VUyFkH5JvZgwKqcbHzHzQHP4BxAg+ajAVuVN9kGlUG/ciKilvIU/ujNfNKz6?=
 =?us-ascii?Q?/s6cEPpEc61xZ/E+0pfTnLIa8XLHc8txoPxgIRUjrW2Ez0o72z4HgUrtNali?=
 =?us-ascii?Q?HlGE6FA7xIEZ60NPFlDQJM4YbDdI+mK/Slr3jZzs34NV4CbCWNyPyLEuWnvE?=
 =?us-ascii?Q?fofi5NSYviUzMTVe9gBRKF0E3dOrCZsGbU1FQTRJglRLaNDhRjUwZgiiZaBj?=
 =?us-ascii?Q?zapM31WKgKaBoBMpDdSZpW8EB7PM3gyQBQ4hOR6S4MrcK3VscN0Rp0gfCVWQ?=
 =?us-ascii?Q?4jDBYYEZ4wITlambNpBVjDaB2x81/K8k+oG2B/T0aoHvNSNiFCEy7UpWAYn3?=
 =?us-ascii?Q?VoaygkTnRm2jsc8RHpVR0RzPNZdpprTpxfzG5VJdlBXGaW/Okjt6R49zxlY6?=
 =?us-ascii?Q?z+tG0f8OtnByEPN/krwW55xMgkBe5ZyYaPnTHV6aioYA4U5+19K8AfNeMQyT?=
 =?us-ascii?Q?BPoHwiYgjh12Y7IdrgroLvrCKW7zJgFDFnkRhLu+tR23RsYCu6tnmuJKaWMz?=
 =?us-ascii?Q?dTlu51/FJ/am1GgC36drU7SiEzxzdlRzZ+5igToMt0KbHhaf8JvnvTl2nq52?=
 =?us-ascii?Q?I0bnnkrCpK78qmcikqkSV4BN4diRO3FDj1LGbgxvvAa6Vydla92H0OLLoKiU?=
 =?us-ascii?Q?IkO6juTS4fY/OtVk4/vcSBGyxZTXsBBLUh3dgDXb6yKwuUDuMQW970siWcFv?=
 =?us-ascii?Q?fllh/e2VmtGmS7l4zTyyvEV7XDmQeAJQAHyZUDAN96NcyQtfaB19M8jBpbAl?=
 =?us-ascii?Q?scamkm1Rndij1Sua8k96na33tB1UJTQnmwedlrBxy5u8K3rkCIvPrBcgnOcF?=
 =?us-ascii?Q?ZHIXDxfG6dxtBYcIlfcFBILCNFh09c1rA+lg6VUpF6yTTeIGCofPPmkQjSUj?=
 =?us-ascii?Q?+PXKKg42NLiBtW2PtR19YhzckX+tIaBhjICQrqelpRgDChqaL8wOL13g+sWO?=
 =?us-ascii?Q?wgcQHLBTUHtoYNtb6QhwoqZuAzmlEdY1gTbGORn3b8+05oHZ1VgKR9xmrTy4?=
 =?us-ascii?Q?ES/sGPUnnozwEraXF75xO3mc3GYaERfwCA7RuvX7h6FdXFp+To8vtbEDOj/Y?=
 =?us-ascii?Q?04I9YEhBfJBa+cOsjC4l6YBy25RDIv7AkMOasWJNSl+Iq27V6qoEtIw/DlQ8?=
 =?us-ascii?Q?hna8aMmprWD2peu/AVRhJhv969hAXhRcIitLWU7JZtfNrn5+6eGiJ8Icz2P1?=
 =?us-ascii?Q?gGdF3P/nF/HnGSn8ylmsehrwhIyj7LyYeTgzeg4Ca5f6B8Olcmw+VAjNjLmP?=
 =?us-ascii?Q?dbeVw5CiCpafrx92oqpgn0=3D?=
X-Microsoft-Antispam-Message-Info: ebX1ZAcPk28qtUYzxGCoiRUrgpCG9byi/S1QAYjisnT8BkqOOJHq+WqZmCZfJkyjypCVcO9CbREdIP73QhtqZc+KON5djfxnKxQB38UYzH5qht7qwgJcZT6TC6yaZ8xlrao7CAwNc3eIS3IAsqWPV2TmyZgxtk34GfMBq0u7GyxkRkBypXXzaLaccI22f2Mn
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:UDFCr5ueLQ6ScK8qB7vgBUICdHjhgDBzq+ttx2K8TnPm2tFh+I+ufQ4qgV/8o/+ZqzgYuKBD5RXg8I+d0gr/eewReJcFLMdHZVQRzApsy/jzjAyw8Fuii1OBCJ3DVv2ctF8HGIqJ7c24bw7QgDSdyTcuF+dQb5F2DrvhF6XzO71LF/+4Zj9Nd8KBaws8IkCST/qznsPo+p92AJEf+Dpd59SzKJZaXQNtneRvilsFrmbFsoEd4MJHt9jySObSnQeXDNNHUNuTbN2n+IXtGq2nxB8t26+/O7izisZmCWCz6gcSpixr76+f3g01uUUverzLIjO9FcK4V1cjwsgILQTpuGVneYzeIj023hEIv93hAwA=;5:Qjv0YCt7sGvM2WKlfxk7XCn1P33S4F1C49zSXmULHov463PolEK4bYvEOqkqeL1nWGBjQdO/TprVS3GkOTUs/rhx0KC6F8kbCq04kOeVqWXDnVz/tOltTbm7gD7yis8ZWaQrRtmv4FXLXduwRN1Yht4ABVfV5V6iiK6bHLsfCbE=;24:EN3XafahlV7JrxMFR6VGy5RwEhTQH3hAzrSAbYscldWgMWBgYddSVreFt66CdtTJGLtWgrjwqJrPzecsJRoNJm8ouMkYI4iZY7dG9ZX0OgA=;7:FdzPPY1HsXw279b4TsFtgRE232kl6XUY2kvoqutqsdKnvE227FF/LEGQkrDH70Ll+3fICZuIKSWE0fVVFhhcNs5WP4mAYTkOxy69tQa8nxS2WEL0if+QNVTh486v4MTrdZgJpnBBe+XEQG5tMu0CqYqmbPcVNFXjKFVy543b8yCYDFpmV4beXjLTqSNvdVunj7TVXnrAf/0lPCUNVcPSnqp4zKDlAF5lfPlJxSV59YTgSRT9z7LiZ7wWVX0WG6Sk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:35:56.3092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8283018a-3d2e-481a-2d0b-08d585e438a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
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
index 68b2ad531e..95c9b34832 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -455,6 +455,7 @@ extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int starts_with(const char *str, const char *prefix);
+extern int istarts_with(const char *str, const char *prefix);
 
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
diff --git a/strbuf.c b/strbuf.c
index b635f0bdc4..99812b8488 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,6 +11,15 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
+int istarts_with(const char *str, const char *prefix)
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

