Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798A81F404
	for <e@80x24.org>; Fri, 29 Dec 2017 15:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbdL2PWw (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 10:22:52 -0500
Received: from mail-dm3nam03on0112.outbound.protection.outlook.com ([104.47.41.112]:7200
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751230AbdL2PWq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 10:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FTF0v11sFLBXsUCpmorD/r1emH1KvFp7F5T/3QcyGAU=;
 b=RAfnMNOLGmyB1Wv0N7i+WjKehYpCNO3XqvY3WzKJVz/vgU2u/J5J0E5ivhCd223lzF4OMdK2Z4tvy4/2TpjcynGytmEeN/S8T//Iw5MjJJekrlLPe2gq9jJK0p+vwRSGqulynb6IGoVW9pGXRWAnb/4DTQDuP8rrYcD2Mdi56j0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.84.3) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.345.17; Fri, 29 Dec 2017 15:22:42 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 3/5] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Fri, 29 Dec 2017 16:22:20 +0100
Message-Id: <20171229152222.39680-4-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171229152222.39680-1-lars.schneider@autodesk.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.84.3]
X-ClientProxiedBy: AM5PR0502CA0001.eurprd05.prod.outlook.com (10.175.37.139)
 To BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa76e19e-c8c0-42d1-08e1-08d54ed0020f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:yv1pQnCYS+jWSo3dxSXCFTl9AxJaxzeDqpB1bCLGCnvQinEu7zgE35Usr8DWbm8djTRcLK0EiF5ZHLq9Xc2vzZn7oHcBuV5jkoyea2e8tpmRZ89MG01g/NMckWtZeokBFm7RiNiaQ64drkndohbf1L99XM9zeNTVwldmRA8llt4LxwiPMK5nnDaJr8AaXTqVlJPHJk75S1UCXvQCEWtfUUZZ2i2qcQW64siaG+WZEARdyelWffymD5kX0DXCbyOt;25:1vIQm6WScg8JPdZcTU3PGPc7UiUNmxptvDHS/3Q+bdfcYJrN/V4dQZ5kElWgy+AHorY8RHHYm52sTow6Oqy89srVsWiR+nkOoox1a3EU7e+ee1GJ+hfU0L9zEitvH0WTcfJ3mLlt0EcFKw56wy5Ff8TLgd/IfHoQREipvfYgYqN9JkyhpBeaZ367R/2nYnVb80GDPTFDCATmqwKojhdZH/GQr30vd0DYAi/nIsuB47gcqievh0qTAhAbgtqk5iCcrBrZHDF/gnN1y9O550oPG6WMdVl2NMSKGbWot8A2kqWxmSHkq/t05BxrZiT0jzj7CqTxzQqKNTHSw/Xoiolb/w==;31:nEF/dwSHWP+L97SCVAhJc/lYVUpOI5TToQ8gY8kQIqzBBGHA62uOkTc1/aZAmRw+f/F5/yEMRHswDTdUxbzDS4dm0c4ZxNxPqiwcWzQZOcWFpz+uqLTq6OP4FOIc5jwj0rYjKRUHWBQu3sTxAN2KLpPdvjGBkYIsybgTNFohonQGJDTH7otmgEbg/irhN351HfTjB/6NCdGwR5B9HVUA4L45WdCh1yyzHro5pdOupfc=
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:R5mUdZ95LP4SjYbHF7R6BS4KfAJPRQfbyHmoRsMHbSf3OqjtfulVFfIsSmm99R0rh9HLrgFuCz+8Sr/4fLdd0uX7Vy6/OBXOEjLbwrD2Cpaoc53wgvVGwQ2IgjdDQo1r2FAjSBsTIH0B2xqRXNbH5DTI3zJUKtJD5KyBxyoB4Clj5Ib7EFEbfpbx4+0qaG3kep0aP/dLCEPQHd7qxVbS8XpqyXya9maohE9NGcsZtDlpkJrGyhd29nVc8048fa79rxHEKtPv6ucSux2j8exnjNFo8A6ieC+nC6GjC3sRvRMcdBFp2Cj9HF4rZxiAdzP5sG2y19L+1fmvFDotdhXxGIZAr9G7r1xRznfp1QRDpowQghAZFwN/TG+LVZgmCR26Q0AogdlCssQ5o6RptmLrQIX4gcjDwrel+WAwKx8fV+lTcVJCiOG6KerodR+601LUmoTSD7oQk9PpTRaX+66yzu03O5mtwdCVxaLdKujPd1KWaFopoH/zX7M61R7zQEj5qE0HOnKtVQ7J9/Y4f1Hkx1P9cFPK6abxhU5QnuN8Bb87rOP0uCWKVxaWlzj437UKzPuapQ4t72KW1+XgpKNbf2sRSMcOmN9Pykq0xYsXebg=;4:F/iivfrtyWJ4EkUrEG/hl7mxTbJXk7eAbr4+tapaltHbk/ck+FEzf8nJe1XFM8Gz/imoSLCC4/g8oSKn63uhySMYU57ywrgOG2uDCdmUupC1KbGjDBnJCOExhl67+MjUG3/zZHiixVTCdj5yifEhuVtaiTRjRoH2Fktx3J28ry9Wer8auMutjr3A4ArQCgdW80Q7T5oUJgHXDCbZSKRk7/Qi8DwyxpFky5yuPa4QLzxu2pPkD/PGCllGMwUshvVA8JCw0knIu9s+pOnQsr69PQ==
X-Microsoft-Antispam-PRVS: <BN6P136MB00177CCC9B02E2456319F2DDE8050@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Forefront-PRVS: 0536638EAC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(189003)(199004)(16526018)(4326008)(6666003)(2950100002)(478600001)(6916009)(9686003)(53936002)(16586007)(6306002)(6512007)(316002)(6506007)(68736007)(386003)(86362001)(8676002)(5660300001)(36756003)(81156014)(76176011)(81166006)(39060400002)(8656006)(33896004)(25786009)(51416003)(53416004)(52116002)(53376002)(6486002)(50226002)(3846002)(66066001)(7736002)(48376002)(2906002)(1076002)(105586002)(50466002)(966005)(69596002)(97736004)(85782001)(106356001)(2361001)(8936002)(47776003)(2351001)(6116002)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:xL7ZM9ulKRx+BKxRzf+xSk0Iuf/2z3ZzT3vahmU3z?=
 =?us-ascii?Q?rpKqiVaO4vka2g9IZRPLpnnGcUpnh+98G6Ube40IYIC8t40OkCX2Ls6/1A+M?=
 =?us-ascii?Q?4J4wY99VsKdpmaj1ziYqob9rFdN1sUZXbU2mrD0XsrS4REgDYonhecKbpK0X?=
 =?us-ascii?Q?JBaznTuAFF8f/Za2Hmf/5NZk4E0SPx5jZo5F+XLQy9LwCbYr+6CUbpV+XEHj?=
 =?us-ascii?Q?mPMGT7ZHxB0ddYUhuF/4Qts1h9HDkz3Jw2CsY4jOq/7gIxtV+xAXXHpftSIO?=
 =?us-ascii?Q?V7CNGNfQpMzljezCDx0Wftfo99RZRja52LWmrlOrr8znqY6p0MPda4ckRSe2?=
 =?us-ascii?Q?A8/FK7gpcILI5RoeNugNPrvAleJmk+Z+Dm8+c112HkXAteYj6g+iYR3zhSno?=
 =?us-ascii?Q?PuR88oABsFXypII0wY87g5qhl50Wc+Mzb5HqVZ6hdnScwI0mOe4ZnaGWn6vP?=
 =?us-ascii?Q?zObeR4LHhADd/AdCCSiF+mwfDCeOqlcbSaElOArg5ZI0Diy9V1YPq8AOBbFU?=
 =?us-ascii?Q?KvTvm7vXLI0am5euE8UqNSivoUK5ACiJ04ReoBX6R2yANwmke04aMeQk026L?=
 =?us-ascii?Q?pKP7Py0UcFXPQ6ODhoKAoKMS9ALkvXZNr+1y36mp4anhAgg87+/Dp+So/5JB?=
 =?us-ascii?Q?nodHvAs1Zf0BBSgk1sr72HSuwmLXDlLIejVORFTmxpWqddKvygKxL6PLMx9F?=
 =?us-ascii?Q?CaEfDq2W+ewsLCl0M6LfvYZuJyB2yqwNTkbHOkw1c+BZYEwMDQBUhdCMPMHd?=
 =?us-ascii?Q?+jwSiMVreEbyFnvfXJZfgxq4I2f9VzTeDsIcsX2Ft+IdWtpRPSM21qS918Ue?=
 =?us-ascii?Q?U9G3PRhOWSQJ8xz0hwbnnQaNfGlm3xJ+N2c+qQllNhbk6tEKrHe/az2LduLf?=
 =?us-ascii?Q?Y6T9oWoo39AnS7WcxlxJiR8nA4wTtQxmvyyNOr/4dLhxES3jH7Y6IIHo4O/2?=
 =?us-ascii?Q?lnrEz5mA21YyZUnDYFFimv9/JkhEE9jzLITjYyODd0z9JkVkH6G9TbUuKaRN?=
 =?us-ascii?Q?ZtCArvJO8ywYUzOC1XHo5muFu3qdQvCHd+C0Vzajb42N4er3V/KFoCOiE5SV?=
 =?us-ascii?Q?65CchVl7gm9BQIpesBoGI0C8X1/KoH5pmtCEoYkoGe2P7qabvvqpaQMMUdJO?=
 =?us-ascii?Q?CLT75CtZdgL39HbUB3dn1yEupmRP8lYqihLWkj8uE+ieskW+OUn11ShzUMcp?=
 =?us-ascii?Q?ix5yrOrIZ2huF5UyOrfBU3f1zml2Id20ZWdnbaTYeAakJs2y0aDG+Ztz5haV?=
 =?us-ascii?Q?wkxu78Vs475ceK1lsG9hTQMRmkuaVKWpkbYWdo7i5qGXYKoXYmUdFkwTH4+k?=
 =?us-ascii?Q?FtxO8cCNNfvpjdEoZlkpsm41rONO+TNHzSe+rrmCMcFm0EjlFL6M2+Ec+sR2?=
 =?us-ascii?Q?OjT5w=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:tjqtRm7N1jhltKRcLL6uM4bpIbfkdDaxiQbE5rmAaFwbEctY239CLmXQPEzZ9HLhCipEDrnKWezQs1VQ9kA5aiLTaLrN+YjAXVS6taAT04Y45y5lYK0A8ALSc9AHXB3xrZweesCD9pp8GnNjZ0rHn49QdswpL8auOr8pcReQ2pDbDdQ3d39viTSSyLTeLJ34EZPsndgvAqXzGC5L4HZpbjCbZ1ylOahBHe95wqXXE2k9cYXG5I9Xhw8PLX5//rxAmUHbKBQIsjzP0ipn7EnNcb0vKNODHCwJ+6ZV//M6PgzElH/ibblOW7TX7S/56nUHb1ppL4C+7UFLnKihkizM14qyGaPvybDkOJsFKiSHA8g=;5:A7L22yg8HySi7JFOv3GsZYxTUF6LVuBrFFIZs6zd1wowzDRYeF//LtUoPMGr8J/s13NRDcProMM8AnC6ttZUx9VNRsoP7MJxLr+Jn6mklYNKveC0HHcyzoRv4Zd4Z6o2yGv9+JPoORPLqzoBsRKtO+qPukFuCBb/gByeVa95MJc=;24:Tii7Z/wq7VFVzWzkSoRtgC8pkLD0QtaQ9reHCBQaOUs7sqRlgR01Ci5EcJ0gmMkRUPiHtENzE5cmFlK3666GnwqhEUWoKhdhw52DB+cGu9Q=;7:1uPrE3zSfM3xDM3FFlL1QGcaIemxEsTse3u+oDLkPw9A9mtvIxf3G6rj4yXnVWeQ7hPlMtXfSQBvSV1eyHzOklS4vIpuVwxypD/MC1RDSK4UpU/jydC/t+bVvzrOS6duZjB91hTHF/2d4NpAJjVCurTgsrEmgrR7mUKwPZeMiDyfwPggS9JEOD0lk8hJ0FV1sMegToZAhtHqAQ7zt+t3qx4BVhnvwnequiIzTk8H2clK2YNLP9H5b/9s3TMAY5ts
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2017 15:22:42.2027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa76e19e-c8c0-42d1-08e1-08d54ed0020f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If the endianness is not defined in the encoding name, then let's
be strict and require a BOM to avoid any encoding confusion. The
has_missing_utf_bom() function returns true if a required BOM is
missing.

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
 utf8.h | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/utf8.c b/utf8.c
index 776660ee12..1978d6c42a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -562,6 +562,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int has_missing_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   !strcmp(enc, "UTF-16") &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   !strcmp(enc, "UTF-32") &&
+	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 4711429af9..26b5e91852 100644
--- a/utf8.h
+++ b/utf8.h
@@ -79,4 +79,20 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
  */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
 
+/*
+ * If the endianness is not defined in the encoding name, then we
+ * require a BOM. The function returns true if a required BOM is missing.
+ *
+ * The Unicode standard instructs to assume big-endian if there
+ * in no BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG
+ * encoding standard used in HTML5 recommends to assume
+ * little-endian to "deal with deployed content" [3].
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#gen6
+ * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
+ *     Section 3.10, D98, page 132
+ * [3] https://encoding.spec.whatwg.org/#utf-16le
+ */
+int has_missing_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.15.1

