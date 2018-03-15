Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDE61F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbeCOW6P (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:15 -0400
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:24137
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932670AbeCOW6L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mezNRGoVInttSJ5Wco1C2Fc7nNahcOoLQjAUPXTlvXI=;
 b=mKLHpHubmE/BxjlOwFdYCGXO1DRbx7LHUImETkKsHc6szabX/r2ScKJaBn9NLun2rMbVp9gOQZIn6VLc2ayUXuYwGJsk/5gSbjTa4DYkHNab1TFXAQMoyg4rE+DP5K/zfF85+xfj2/zgahS6J3WVWUZ2UGLIr98y7rFM8KPdXNE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:58:06 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 04/10] utf8: teach same_encoding() alternative UTF encoding names
Date:   Thu, 15 Mar 2018 23:57:40 +0100
Message-Id: <20180315225746.18119-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315225746.18119-1-lars.schneider@autodesk.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:104:6::21) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b12c657-9d41-4394-1035-08d58ac838ae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:Z10kjhxCAG2X+0f2ATude2frlswe2C57nFxitjANHiE5kR2ckGiVK/80voFmeB41gks0D8iUEQJfTTkJd72IbgEe639PxexZxlY6iuCNfUIjh4mBABL80QCYe/PbLQAIHB9QtU9xNvk8SUNPt34Jd8PiFEsJWgAwgehd7O23ic1C5+WZJr+VPg4ZvAFTZ2XRpSWoyEW4MVzRePHeCRpGE9MeBMmzAbk8j4LVgk2iCtI09UJhRxFsN2jDH7xOZMBL;25:03Mb27LsEYXzDo8ywpFxRySmqxAtKsgKPZjdP/xPYf514Q6RlAMjpNvTK9C/cuoB2rxZmIXjydUCKRZ9e5bZEnNc0Yjrzq0di1/5lPhVE6uQS3WsmdQG6ztyHejXVQ/qIZSDI5brRL3WZvD7s7Cx0+iO7uctJ6IPcCxASNrKlMd8NsHHGMK3WAk/GOaZuNVmKE5v2XtL/RhBbNnB550tvD4nK3VPh6019RyyeFS8J1dY2P45TDBnVg7urOMGZCWVXEHsy4RmwDo0Pxvbni3sAEXzTYBV2KXYNhsuvhui7CdlmQlRJgEkXNx4iOkrr9miK9xgLccjgXv80ce91qAqsA==;31:bf12G9d3IydE+K99lvOgZkcnpcTUwMCoEgyC/yyK7JH1jUZDyXn5tpwleDhv2DQllzMQopzUZXn2Ze2FKuQ/Dl9AUT9c6uU9PvLzga70UgXHzt+oPyv6EiWBG+EBLIozpJqKGNXZGt1utiBzzr8QGwaLmEsyhAQ0/dSz8flKyqK5ug12pNu97AIe8jsXvwtHjwsR1diNmO1sbu1ZLKyCRw==
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:lAb62vfbBKn0/CCVDCl0uxBDms6/nR9do16rlwBzO8BEdLO+NBljUHNiKSmJXVUpc7Pv6/7GiFXFwprp8d4wRKA/lYzt/SbQOiCmyjY2IWAnjqdmuc9YyHlgrWyvfNUCtSopAtI8tESm0EJrjPgDvz7Hd8lgu6quuySdaJgkPJaP0iQm8WzamECiMPap6SFtrCZXu7I8YKWM+1s/QEOv6ERLCA8aQqQwm/2cByFre7Ob3WpkesI+AqI52ycEjw0hpfLXbZlC2OjgcHWiDpybYFDbB4QA2YLNq3FSNs6HbejaE3ie1dzUzMn3Eawo3qBn4VjF7h3pXO4MN8pA+UB6t12W0cypD0KPbpLS1rdEexGWJWktmZB8XfMli1aZKiauN+WwwfxggJRhQyD7ZB9uAXHW3qObR5mE/pfdiHgGRaESU57JFmhUa/M3RJKOOQxfx9YdgVGvXCXs3fQVopA+JvQXtzrMHGH4+E4H9t3c34faIW0mqRcJC59CAgNDkD6vH12MXcEr4muSFk6D12b6/46A4e7/26lndySbz1PUhZ4VPW4PY2NFSLh/zZdLjYWNNMKVo6SSPlMybHDi8Q91F7KvX59MQMavNWzmPJhrU7U=;4:A+zG/60l5hcB5Se/in80F4jtcV4TSoNSERhYYa2rnG4B+d6Lo/6OlNnROHjHSJ1v0FEkNu0N1d6/4r6ryWYAlXvLb9n3UNUXWnpWvGZXtZTBe96jgAJDQ8qtiHfyTPg1rLTr8JxyaBtQ/ZNRbwh/QRfCQsawiF4EulkJG52bOgdjPZ4/7y2OGrGbWZ0+A2Ghr+hkc4DDOI51SykuSZ2FQMBbBM/3oHg76GmAl7DzGR2CGLbQ199wKizh1lJHV8+kaw7kyMAWWpGdDOEWqIzoS3eZWuVbTWgl1Ek3k2RK2SXr9EOGXmc3mrIRX8xiQZrh
X-Microsoft-Antispam-PRVS: <MWHP136MB001473655FE2C2AAA9128CDCE8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(48376002)(386003)(86362001)(8666007)(25786009)(59450400001)(36756003)(6916009)(7696005)(6666003)(3846002)(68736007)(6116002)(2950100002)(186003)(66066001)(9686003)(50466002)(8656006)(97736004)(5660300001)(316002)(16526019)(7736002)(7416002)(305945005)(39060400002)(1076002)(16586007)(53936002)(76176011)(51416003)(2361001)(81166006)(85782001)(52116002)(4326008)(8936002)(47776003)(6486002)(2906002)(8676002)(105586002)(2351001)(26005)(50226002)(478600001)(106356001)(81156014)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:hv4Fm+dN6P0epvwMt/BxxDKJDWL+o0keO59i/6gDv?=
 =?us-ascii?Q?SyyI9j2sVymt/8hr5+06G48CrZnHC3FCHXsOHrk/jOkdveVwF8Nqa/7SvTDX?=
 =?us-ascii?Q?Qiizu2Lay4gXdx+GfjGfXhp4EwA5L//PYZ+1jZofx5Sl8qDoy/UqQ45TwAYT?=
 =?us-ascii?Q?so7rnprWCeKIVsjaYo65lan02pGR+d2nSzOZS3nCWvj7cZEcdhcI8sQY48Jl?=
 =?us-ascii?Q?lKg4IiR7yP/+qbBt6/AwSFZs8P/T/vFb7T+BLU0wKkUPHzgISMwaa3Md5gej?=
 =?us-ascii?Q?CiftvVMX4nYokXd0sXrpY7YbZQcmgov3k7IVb90/tLeaohp26rZ2JneH4AFP?=
 =?us-ascii?Q?LlTqzGLKb9w1HkvD8vtmFe1fWrwgAbFeLDIKBqGOFRauPLul7nmJAd4VGr99?=
 =?us-ascii?Q?fy8d4Kqge8rBIZBVjJYvUq7IF1sUPShPp3wKRTc34m1oijIEIxGnyHhXj2Gu?=
 =?us-ascii?Q?ai1Hi7QQTfDQC/oYn374Hb37e+Ed4m0+11RQsvk1qksetNuWrzlxMjv2be6z?=
 =?us-ascii?Q?CrX5cWPTnYI3P7uI01TuVBBxgNXt5y0k3EvRBl8D7G/Ry5vuouVe4MT785hQ?=
 =?us-ascii?Q?J2whmgpy/nSasyuVEdeJCGsE6k5K95RDgCeIwlJtGgRifDlHuZvdlooyWNeT?=
 =?us-ascii?Q?F40Ldef99J8C1SSNp+hmlVHkWMkNmUKFlSqlLyVoOoTFsSgw348fXQ5cWAAZ?=
 =?us-ascii?Q?wL63m1O78iBwMLayrYBAp5efTNtyWhfXMeRtDoexcTjn/mg63UTKmmdPeY7E?=
 =?us-ascii?Q?73NvKmxJc8FTTDoOVy6HoY1I8gKEmxNOf+agqznOz2/j4zsbpLgcOoRs00Ah?=
 =?us-ascii?Q?TJtrO2pw2C8e5Pz4+rRE+icwM4m/AytUtUEZ3Pw/vVTxCAhep8UTtnCFr21j?=
 =?us-ascii?Q?OalgiE59PVTrQG2MBh+kab0Ir72PMO/SK3YmLsG6Su6f4b7r+7spCg2X9Cip?=
 =?us-ascii?Q?LK7A8wj8WGsGNoLDMYBzaL6l10DOm1XWYopYJGUVGnmhJprDyWdAn3KFBFiN?=
 =?us-ascii?Q?HRza5/LsO3+oRhO4SPKh6D9vyVthdd9HzLZl6utXC4tl2OXcdIv75CR7b6Vl?=
 =?us-ascii?Q?Zz5r6UnVrLMNzmxfuxkoPT2Cifm8we8Uz19YTAiEt3TrCDpbDYgwLbN/2rPu?=
 =?us-ascii?Q?SUmSKFMZboUkuMIzxO5X1+yX87hN9VRo3RRmTG6++f9uxhhT71XtKKYxCy+a?=
 =?us-ascii?Q?smKXEeT5L3lTbo4YYCm1s+SxVusOQWpKrTHVniJ1WOxvNqycAJT5MFAk25Oe?=
 =?us-ascii?Q?7vy89AMZ79X+S1XTEzlsAV7PKzmsWINeTRu6dL1aKhPRkohc7Un+LQ9dekex?=
 =?us-ascii?Q?rfJv/n+7Q1AK9kIYEgnR6E=3D?=
X-Microsoft-Antispam-Message-Info: BpiTHBDy1o0d8CxQBmMz2PxjBHuu3yiSCIt5oBwYjp+DOZvDrYrMFJlpSuQgcXpx+MJsJb1fEBdJTRrThT0/jtbRKbPqnTnOR/N10FudFYIorK9Fwl5f2JsgUEp2B5YvLaMF30HV4aCni9UnCnDdVL4S+1Uuq7A7R4rRqUPdcumhe8WVgR16OPgvGLEHuZ6Y
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:zsNM7hlcGCTt4fHxHzGixwEiVGdBhuzMu9E5/MANqQAvCfw3jvAWpDtrFf8RtczuKT80zfnXcguENBnU/0geJfOTIrT0vIraI13fr4B0H25E98MdXYckps9VkrKgyQEmJkEJ7PUv3YbqgWZoGyYen/wWpWxzvcYBQLPfWkStxHe+gCzzQCiAIoPN0DTcPisdxBUtyNw6nx9VdoXoEYKkjcbUJzljXnleur/TIHCWrrZiDYWIBBC4nVs9wTdmcDhgW+cS/0ismB6nYVtv2XfTD6+EKbYi2s7WVk5BhqtFOOKabmHBBVJ33aYx5RftmQEU1t0cCrV697//xV07t/OA7Q==;5:UgL31gidXG3ha1SB64bBTHoS5lRG3Dty46zPqIIF+0Ohgf+vOLvC0IpWvNTB44aJswwCXoXN/zVsRZ/7P8Dspfp7hCY+2ysoU/6Bgo4YI3uEOjV6+mWWBs3afRtdBet1Q9Sfwkq/BVOEzvdMkivlVV/U+xG/hTBgvb8prkTS+Ko=;24:EJTfF3wtjSxhELPfaBCqY8V2RIbxK3yj3YdxhEus+Wlb5p5hH1G3egV8XHmQmiIgfmXZ0p+anUmkZVa1P24xwoju4Ja/S/xHALyxYGD15GY=;7:47dFi7YZu1j7+lMDufLVbB19txUdEJoBgb07rXAeGypjI9TzteONj0I+80AvQb9j9giyGy64pXBvmy3ZF8KxWbcwqDYdPT2BA/UZkpP6NJbqS9aAePb5fYRrSj6lakUyrW0IdCrJbOSK2kdPmv2wou9z0SUUXgMzLG6bwYU/S2gGd6wnG0mMPgBh9dr5n2VOLky7s6/mgkZg4dyP6pp1UOQKE8Sd4wUrOmmmR3qi4U3rt0u/GcDm+9wfneBSDY5+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:58:06.6191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b12c657-9d41-4394-1035-08d58ac838ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The function same_encoding() checked only for alternative UTF-8 encoding
names. Teach it to check for all kinds of alternative UTF encoding
names.

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 utf8.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/utf8.c b/utf8.c
index 2c27ce0137..c30daf4d34 100644
--- a/utf8.c
+++ b/utf8.c
@@ -401,11 +401,27 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 	strbuf_release(&sb_dst);
 }
 
+/*
+ * Returns true (1) if the src encoding name matches the dst encoding
+ * name directly or one of its alternative names. E.g. UTF-16BE is the
+ * same as UTF16BE.
+ */
+static int same_utf_encoding(const char *src, const char *dst)
+{
+	if (istarts_with(src, "utf") && istarts_with(dst, "utf")) {
+		/* src[3] or dst[3] might be '\0' */
+		int i = (src[3] == '-' ? 4 : 3);
+		int j = (dst[3] == '-' ? 4 : 3);
+		return !strcasecmp(src+i, dst+j);
+	}
+	return 0;
+}
+
 int is_encoding_utf8(const char *name)
 {
 	if (!name)
 		return 1;
-	if (!strcasecmp(name, "utf-8") || !strcasecmp(name, "utf8"))
+	if (same_utf_encoding("utf-8", name))
 		return 1;
 	return 0;
 }
@@ -414,6 +430,8 @@ int same_encoding(const char *src, const char *dst)
 {
 	if (is_encoding_utf8(src) && is_encoding_utf8(dst))
 		return 1;
+	if (same_utf_encoding(src, dst))
+		return 1;
 	return !strcasecmp(src, dst);
 }
 
-- 
2.16.2

