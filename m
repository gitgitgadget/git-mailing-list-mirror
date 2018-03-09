Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965211F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbeCIRhW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:37:22 -0500
Received: from mail-bn3nam01on0113.outbound.protection.outlook.com ([104.47.33.113]:10015
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932435AbeCIRg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7k/TSboRwMTE8aanuWkPHOMq1EOHGFClAMYsOttdLHU=;
 b=q0gQoVxLQ4z/ZfKPZ+bhU2EsoRUo7Ienui78iI/fRWcyhnAQaEc5CX7N8ZuIzT42109k4DObh1EzQWa04e59mDmYzsqGu5JZ7ivWYLFLghvoKH0BAHdsQJxuOwIbTiQzfRhgn3DlMncHR2ukF38h7jikYk6IIlNhIPG5pjNqDrM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:36:06 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 05/10] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Fri,  9 Mar 2018 18:35:31 +0100
Message-Id: <20180309173536.62012-6-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 12be93c6-6be8-40ff-6cb2-08d585e43f3a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:4n6E4YvJcKsTdcMm+xa8djgvtD+AfhDQKFwnFv5vvdcRIuON6tlLhyWHyHhAnJZQd3psS7+Xm+NtKqvlm8irN7wXacyg8vrfSQkz4hEjujK36Xx8k3Gve0kjFtTO4uUxBHluC55h5L3KEm7BxVFB9qJNRs6i7ui1B2AcOzZbJ4lylRtlSVV7haCYZzWrPVaaBE7wJX8IsmjIchL8PifhTnr+DgclHauWOAxeJ4gwQK8UTiFR2g4n6CqeS6ZfZbon;25:VS5RVhNQAyGGwzeKwFUOVrwMpG2eViWdIWkDDnqyZUDnxa4sb9skfgPUb2zVWOQLTy3tNLe1mGDM/mNp8wvqh57stIpoqD4gh6GsBmEzEhKNIJzT2fkcgLhq3vRyyT52WSRmFGdCE1ZcT/N8L4GxDdeA3+P+X9sGHrLAbYFovQzAo2eMstvJb/B1SYPkwWywst0s6QbrJrwNfkGXblXDA1IY9fqG5rXmE1absD5RqIWZw9U0LkcMVJE7xeMzMGh0JZJGZO8nkuTAokgsCJM8DDUzhu3iU4thCAC4Bi/ow3BCrocBVdv6dXrPWOJ58S/G4I618bsn9j6E4GPsZRh0Bw==;31:vVVgo2w2eq0sy2nvMb9mLcMEtEEJ8Nyl+HvPV8vMl2gJfJE5aB4GxcggfEHAm/5JlI8buBGI1YGVy9D83F41hj0K87GQa6rG6/e4dr9mzAiPaDA0WG38zdevrue5HFvjVheaf3uEuLtW8AwRMXdnL2hSzyCVnKFbZxF1vnKjKFs+BqYrLYypSMwXL710VxYPLullV2YOKfeEIkwBy9UclsYGY9Cd6VW2GFGFx4eVa9Q=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:8vlHk6zD9qtYYVRvNEG7e9jbQzqzBneM/Eb5lDIxztLNuJAZNnysGzxX5WPylKARQbQ8Zk6wXA2cRAqBfC2fjA3vDNeXe7Xd3akVOCc0q+2Izudd2JRlGL/T8rnSjc99W4OwNdTJd6dChU8dqDUHimt+KoW0R47+gZANfXnr1PP3AIxhYZjtQB32VvB7Zgg6qGSsdOubcgUH5f7NdtseCdFKf3y+NGsGPaftbqIKBFqjcBWlMr4K5MCnzeT7xKzsZhzHERltP1+OCaqH+gfAl0er3wUW/L2k+NWbeSSKL3aadNHbt1W9ZSRcB8oCDG8EmrEqDuziXHZriKe5yuA3V7N7KPSBbgMfx4A6nMTvJwNL3ry+iOO/SFgp/w/QUdgYakhpC9seU2dYL+NqS0fhAS2zH/ClZmV/9n642IGSPY5nFsEm6eqRrnoFNiqPGUN9lYm8TAvv6YCRqIB6/qzdgBeiNH3S/lmB34blkqLQviiC4Jb2BiKIbqaDKBTxN8sWJ+EJk4vkNsKVQPRocI7KMWrjAKUMp3q0kLrbHXxzhHoaPismvJHvkY5FZmaaNTCmcaQIR/UxJYm6zG77tWC2PpTAx9g+5fbKi2ngelsU04A=;4:51Ft+YtWcb0aH6fPggpSYJ2E4ZgNDQg/wZea+D9rsstGTaQI7vRo/q02nEjOtdG6V+2gLCyGh5v5uTHZgXj1OWtGiq5T+VwLbRVFPKIhWGdZ0YaFQmjD5RfsheuV1OJQr1cCj20dUkTnQbW3/kB8l/FnCNYONy9AgBciq4zwR1QM/9XxGL+0xDj0aLEcNTyyU5KKBpttCFctfVzd9rbkpSYlB2w7go0wEvCqxDsBEB2CodI0jq05TCBipfvrEd0Q1jK+AvMLD3RiSTcwojfstx4lVMcQ2scrBEm/K9HObFn6qVV2QghMKeCr7CJimHPH
X-Microsoft-Antispam-PRVS: <MWHP136MB001580F79675D9CF950541F0E8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(50226002)(76176011)(8656006)(7416002)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(53376002)(6116002)(86362001)(26005)(3846002)(85782001)(316002)(9686003)(6306002)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(966005)(66066001)(85772001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:WwZU+JRo1TalrADOPW+z4LNjnL6OXywZ6Xij2DJK3?=
 =?us-ascii?Q?JMLy7jzTybnLUoXcVerCClnOliGZ6bAkLGOsSt2HAdzJEIC9fRIEIUh9sVIG?=
 =?us-ascii?Q?kWOKG80hRv8y464tKV6CWalwspbPbdlHhaTnLVaEmYNGXRgGCxMd9fIw17SE?=
 =?us-ascii?Q?ZlylwNRw1UwcOGsKp3WJwEYxi8bHhHjMzkBbfp4OTtZedbtBVW+tXsl+8Ptg?=
 =?us-ascii?Q?hhg2+oFvye4EOTVV4A5kzrWaoHKVK8oXTUeNK0sILT+6iE3r+AyNro65Gq4D?=
 =?us-ascii?Q?bLjVNGwVMjVJ3eCg43jkSOQgT39vvUv5Jc8qUULBq47NJdljpLCap2YEmu2H?=
 =?us-ascii?Q?rlB9SL8c3iyJRC+SbC6t0fTG0eEnrKr97KOfPq0o2HPQVhzcKXbtESWeLAFl?=
 =?us-ascii?Q?+ghfdhj3FJbVdhJsnLEPOeQHiGVgaf23mekqYSIUk2a4GRs1zIIOY0FgtZmC?=
 =?us-ascii?Q?QH2Qn6Cj69LdTOtw/S3eHlhqk+oAF95Wl1umJokFayMADwyjh5Xv9tU8iB5V?=
 =?us-ascii?Q?qAdbvx4DBzo+VII5dgkdfWz5osfnSuE+msbHUSFTbUcizGlqYJURvMa2Bc58?=
 =?us-ascii?Q?ZkjE1W7nCDhwzDkOAGlzZ1WUzt1Bn3TvbX/bykzg96bvLIHDQe3hcqFzupqr?=
 =?us-ascii?Q?lR9KLanAvU34Dp9hNCky12HG+7F3XYkDL1xbh9DE/xsSQaFNTqhEaxNOL+B8?=
 =?us-ascii?Q?Amme0NYQxhG1KzPkudGnWDvjOVvhycCgjX/sGsTEHQTFNiRX2UgJDoS+Qp8w?=
 =?us-ascii?Q?H71Qqx1sIMocXlb+24jXBbFfJrIdYb1EEoKnG9RnXM5DR9vE+1TDC9CYShdy?=
 =?us-ascii?Q?VEflWBKjUNW1xjzUNBnZVgHPIhkjrMm23xMh8XzoZ/16KkQUcp9LoVtKXGXI?=
 =?us-ascii?Q?5kCfeUftJnPeWepiL2b79nVpPzqjaVMe88KGhYG2YpkzYJfbsb0HiN0u+/Nb?=
 =?us-ascii?Q?7/qZlSyO/YWsf8iHu7im3FRCj9f9tqaCn29Zba3RCVbzXyF+MQ0jVqIv5pp9?=
 =?us-ascii?Q?ALiCIgkQT2bjndPDj0YEACBNKFa41OGnvbtGCUUZIfD8ru8oBT1dV2tP6Yhz?=
 =?us-ascii?Q?R/R88VQvlG/55/sGrhKEUUiSa5nbPSdFSk3cM0A5CmXJqGgvZrEwChA6ZkBy?=
 =?us-ascii?Q?bQ0KJ2yYJIYOfL/lvwyt+qnUN3Y18qZsR9fIXUR1RerB3NhiXIFte4YbPvSH?=
 =?us-ascii?Q?L975pZyhzW35nL78aaSJUqizFKAWTqNadOEd/lFat1Z4dwmvddEsoJevTCeV?=
 =?us-ascii?Q?rUp84Le96HgMiWd3eFAxymnN4ZVfP/JQf8UdiHY4b6TbRiCV7LYpWNwBa8cj?=
 =?us-ascii?Q?PZL7JbT9AIa0MFyjjMuAbaS9AIkjFm19EoZyse2+G9QuS1Efc58QHZ55J8uT?=
 =?us-ascii?Q?SgauVDruxYJBG5MTvbFUrOUo5UyVPFKAxmFpUMWX1V0coBnyHqDut04xzt93?=
 =?us-ascii?Q?9syAFtRnHos7OBVnoSxcfIkUjsxM6s=3D?=
X-Microsoft-Antispam-Message-Info: s1TH1YeSKKf0YROBnrU5/sPKJSRXb+jduiDtG6xQvzuaV3JW9IAMbxwKt3ftIFqflO+Mauw+bDJ8EYDEwRUC3rsvyJQmtIRmYpHnANQeyKuIWXcu84THRxraH6HQ1EyeLj+p5WccEV60AUi0SwlKMzJJSNEMrYc1vmC6ndwURmB/Wb+pkUXJPlTynSoR0Dcm
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:P0I2bEihcwmqqil9Y2YEp6ujFeEO6Ogbq0RX/CR+YBQCBD84IzqUEPNQmngF/9K/t0nZsVzjbOWqh2CQUIVydgAujf5vuhX+fdLHXex0Ayft84Gw5dD+FZDeDK3BlDL/lYNKLUiaKpGfM6AfUxJvTVeFEhEt2cQBHlrQturstY76XurbqsrOsPUGmXH9zy5unllcDR3fHmZakPqoL3TtLZ3PDhF0xd5mPwsNjhG1PrfXNU5S/M4BexthAyTb/A1m8sx+c1swwfDK/XS6zI5g37b4ryPjVuVdOxjX9fwHIP3zxXzuMcVkhxkNYWJIoQkXHRDCdNsbd1DTh2P0fgWmVEUZj/9EdREhIMz9B55n/hQ=;5:BknQeZ72QSf2nQ/Gg3NJ9GTgSZ6Up0Kr4uddYUDnFFxKRANEQ1A1NzJQwFG7uE9D8EINR7rmi9I3joIW6nOIyCYoYxoB8QrdOP7sI+YsuM+zID2rACKq1LE7nAzTgIVBakFpPNvxxeHYUJNVfmRRnEzhXuedFS385uPNIq99t8o=;24:bfvHsen7rg6jYA9M4qtZjcJpXuaKDgxjuOlA3vdS94P622jXO5D9hPUBo9yEg0Pxvrc8JcM5sSCr2fAt41LPhfYb45T6/QI6sLfZonSgAaA=;7:4bsHOkjyCpTgUL1i22GrU9SEs3pE2hQy2/eQ7FfNLRqPUB4RBJNqAI2YOpE+Y9VYLKBRhgTg39K3+tESJXAd3LHmuGD57u/xgrJT4nF5OFCgQ9d+YcOoqv+7I4/jDLchGFDx9xO+08bIamA/guI8IkuWu+n2Gt+o+PK3RpnhjReCZDI/+7hcWbRF7CDscXA5Z6L/xnVxVGXaVcXhROI4XuMJmTf+cCkJjqFsUAtB6OmVRncA1QT94MXCulLBN5KE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:36:06.6999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12be93c6-6be8-40ff-6cb2-08d585e43f3a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If the endianness is not defined in the encoding name, then let's
be strict and require a BOM to avoid any encoding confusion. The
is_missing_required_utf_bom() function returns true if a required BOM
is missing.

The Unicode standard instructs to assume big-endian if there in no BOM
for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard used
in HTML5 recommends to assume little-endian to "deal with deployed
content" [3]. Strictly requiring a BOM seems to be the safest option
for content in Git.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#gen6
[2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
     Section 3.10, D98, page 132
[3] https://encoding.spec.whatwg.org/#utf-16le

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 utf8.c | 13 +++++++++++++
 utf8.h | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/utf8.c b/utf8.c
index e4b99580f0..81c6678df1 100644
--- a/utf8.c
+++ b/utf8.c
@@ -564,6 +564,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   (!strcasecmp(enc, "UTF-16") || !strcasecmp(enc, "UTF16")) &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   (!strcasecmp(enc, "UTF-32") || !strcasecmp(enc, "UTF32")) &&
+	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 0db1db4519..cce654a64a 100644
--- a/utf8.h
+++ b/utf8.h
@@ -79,4 +79,23 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
  */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
 
+/*
+ * If the endianness is not defined in the encoding name, then we
+ * require a BOM. The function returns true if a required BOM is missing.
+ *
+ * The Unicode standard instructs to assume big-endian if there in no
+ * BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard
+ * used in HTML5 recommends to assume little-endian to "deal with
+ * deployed content" [3].
+ *
+ * Therefore, strictly requiring a BOM seems to be the safest option for
+ * content in Git.
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#gen6
+ * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
+ *     Section 3.10, D98, page 132
+ * [3] https://encoding.spec.whatwg.org/#utf-16le
+ */
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.2

