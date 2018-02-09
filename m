Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532381F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeBIN3B (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:29:01 -0500
Received: from mail-dm3nam03on0115.outbound.protection.outlook.com ([104.47.41.115]:57376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751034AbeBIN26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XB7ZHdouGNm/DFuBSB4OfXxSWV1XfOpSnchksRSdiA0=;
 b=BPGkRV6i+nxP546Y/NXWHLJtEFRpZwyyX5/KqcYoK39Sjo48JSNm2dwykHByvZ7BFo+DcWU227oVe/lpyj1EsQIGOTyv6wMAed3gKQCtJPQYA39jWWZ8HfNRTBlcH8gSMXsbzNosZSAfxbhISfSo/RvhHaVxOJ7PGHbJaY3y6mY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Fri, 9 Feb 2018 13:28:53 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 3/7] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Fri,  9 Feb 2018 14:28:26 +0100
Message-Id: <20180209132830.55385-4-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4c10275-ff61-430a-66e2-08d56fc111bb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;3:wVbvj3HT8flcBJW2wZVuBSjIqHsJDtB/2cmpJjJ9BCJ+96W+IJ86eSlJi5La48+RFzcd7BvvgO193w6vxTB/AGOowAYx+3axMtHFbSMeDssHx+U+P+oYnbrSN4z6/QwdxGyuQrzQzt7hPFHywN1Uogik2YGguQEFeQkaZaAMmmwHZ03SeFrDHUam4FiRrsAOJ5D9lEArfsasgqATerAd9od3/1FS84Scn/bLnPe5ySebVjAa+go7GgC3oRuqN9UP;25:7K8lAwzwzyczYKXs/e1d+SoYTzWEyBy9VpmgQOTcr6BgCA72JMCNj/DcjejGSYEfRYlozB/gCew61td5aWVVVwqOCX+/4W5tlzucbQnxtr6LU97PLKEjcgMfDPCgJBUvR6/7oteD+fnxQbL09zSl+nnHPNyfIagIgygCBRjUhJoIk9OsmMyzAlPz95sOKkw/ch9st97gCe+dsOQM6rqVgyA2hXF4XD6xXBYw2odbf/zrOvWACFUaPwunYQNoxU9ovqjD6p3IyrS1Fke0HXmgCv8VXCNJZGF5+I2GuULW1pvRK1Ik5DtLvsEiuLDVkSYnnqlkiouQpg/yycFY6BfKXw==;31:0DqAoef0VuhQkw1i3w0ozbVtvSVKrV+up+kGotgbHHGlZxpT2CV4K7e7kchudN8XHi8Q+s0olJ0oW0SCNXKRrIZy/EymDYndkf3c4k8gVR/Gkygdx7FJ+K9tZP0P+lomOd++SZrARVdXRndoMcqMAHKrH6wzsIeO256h0Al/DD+aFLAyfzQgLOsllT6fXJHFX0sDWc4aAiG/VpTEUTmdg9QQhi5O8dt5Y6GEp2iy6Ms=
X-MS-TrafficTypeDiagnostic: DM5P136MB0028:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;20:w4xwu9sNWgt8qMBWmjHLI9fh78CHORQhKftDMfB40JHZ1VFlbEqjqwBa0WfbDia7zkexdEa5rDMnGWrIzvs9D/jkZpaht9f02WsKyUjV3Pg9uyrz+v+MD1MuoS7S5/oLd5gxx6mM7JyNCjNnXDSHjV11nqe03ntIEntU8NtTt13pwCboILZr/mzs8Sj7ca9yJMEXIAuz/IHS5vL2oRk9ZEQ8bELzhlF80jQLfor0NLIJAd+ADQhBTItJ2eivLA2OW8puUnclOvsgDfLh1bSEwRtcD6V3YjTssOCMnxE816snrUAzw7zxv8C4oB40oItnI9g4gPI+WfkgQPG0Cf8i21+1uw8sKEbw9VA9AZ/6sXYp+wwXU4p+ms+2WDnh2lVix5py8Zbc3ABuboiQKgIPeIO747EF0MLF0cIHZHZ6+4it8LYVLQq7mdgqjaFbneIfKfl93VgDJYt45yUeDXZ5Q6DuWjqn+0xWtG8dOEWTdsmMfGW7w5XUPWQEN+O2aufPDRx1H7tU0kZ4/0bjsX1qaEwfQ2SO210beMB8SHPsnmz2NWpYo3MUYJSDEU1x28fT6kxl7V612oLaTPlrrjFKs5vSGgKPjqvVCqO3sxMFwmY=;4:IabLt2+M3RyCUOYo8GHUGyAevB18oPITWTgu+h+/R7VhvXsmJHQMaIUeFT0LbW+nFoNE6wCIsQh+G5xr84Lvyq7ClRSH5GDSDP2CbNziz3Yx2lQd+qD500FvO9Z8/ZN2eke01RKdCMHexEoQeznV2V1/+1C7Z2ZqzyFPaLMiHtV7vPXp9E8GCrtOGKXwvBpNanpKyY7csvBUuc9VUstH6nR2T0sv5uRQ9gzyazePe1AY4NE6oeBujJeWSqn5ZJjxVpP4lgNQ52w98xUhcaIi0O+EBDWrK3s3EIXFLgUa3NZgMLy/B/yd05T8a1TRPQHd
X-Microsoft-Antispam-PRVS: <DM5P136MB0028E86E5FA969B4205FFA8BE8F20@DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5P136MB0028;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0028;
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(97736004)(68736007)(26005)(2361001)(6116002)(3846002)(106356001)(2351001)(478600001)(53936002)(966005)(86362001)(9686003)(1076002)(2906002)(85782001)(6306002)(36756003)(8656006)(50226002)(316002)(105586002)(25786009)(52116002)(7696005)(51416003)(7736002)(386003)(16586007)(50466002)(2950100002)(4326008)(48376002)(6916009)(6666003)(8936002)(81166006)(47776003)(6486002)(66066001)(39060400002)(53376002)(8676002)(81156014)(76176011)(5660300001)(16526019)(186003)(8666007)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0028;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0028;23:IGFXqrkw1Fx79J8uzEQ0fQYDDY3kO0iEP6Ef9jeyP?=
 =?us-ascii?Q?3rNkDai483VInJBkn0zAJHEeNBr3qPsNaapZTOWjXcGNgDB9j0IzqeCBZj2I?=
 =?us-ascii?Q?XMPTOPoESdvw1KkG6g4S88esL19Ckl/RvaLBziAwgCTszmHn9SLXl4nycGnc?=
 =?us-ascii?Q?Mxl0cCjiMFeWOCdauQAay+gETbx+IyBREELs1HLFkpWhrxdDLhXHwF0oHaX9?=
 =?us-ascii?Q?5jedUJ8RCcYAQ+yEj+4K8KpDVIn2rj94RSyQ2JUBBL8B0ZQrRjY2aOZacebs?=
 =?us-ascii?Q?fZ5rV4prODnoGgg0AAf5TwGd23V8LrvbQxMxjEUx5o/k+2jQbc/K5bfelZxU?=
 =?us-ascii?Q?iDH+lSo52GAxkYC4/LSanYY1D1mmZgwd3DiDvNRrjfBxn9D1QaJXAC/QOPGW?=
 =?us-ascii?Q?uU2SZVRwtW2cQ2kxXhn7AHO2dOR5RmzTX4aqM+X4WO69ORcMHlsA49uioiHW?=
 =?us-ascii?Q?CYjSsOzV7JcjaiPr2iLClYvxzdYaABt/FrxrqXpxJFUTAVW2o8h3RrnEMX7C?=
 =?us-ascii?Q?uXWhhKdVRvVX3gMQB+OgHkB/KL5suDRY+4khDv0HibOyrqXI1vOTWtX0hKdz?=
 =?us-ascii?Q?751TcDoKJWVcFqVOlg+5EzkLk3SWO9vYEMWggCi5oIuvNZMHlFpFJbPweody?=
 =?us-ascii?Q?JPukFKRWa1wAe/Z8UIHcN3wIwgaoIT3kb37mSvcwLyKftv5K4NSbWNuHvmI8?=
 =?us-ascii?Q?MzuUBb4ATQ0Zppi3dj+ckurorc6LZS4QesGDjmFOUTrR7OtDWyvXdgO9X/QF?=
 =?us-ascii?Q?B7J5S/6HXeICfxvrZTZl4jxohA/57Oc/dXru1jVqrHfUlo6V17CXMOm6ISAe?=
 =?us-ascii?Q?2GjcHFkwsFK7/E2NQRfvQfZ8sCXTMao6PPnFDBd0400ws2r0go5vCPG/bOX4?=
 =?us-ascii?Q?FT/1iCI+HSpkD7ERPy9xwFL/3w+bv5QChiYD+zA99Cv3nEzzlv8xUWGbaDrK?=
 =?us-ascii?Q?jS7kbamw5aoaQLyJWY+rVRRdwHhWphKd2ZfJZPpeuaChpoxSI3PIeP4A3mbW?=
 =?us-ascii?Q?RK1/OUQ9JgU3G8ae/vi2rSQBlHbGEGQLmKuDeEDtozptP3q9bYJVCoWy3FCN?=
 =?us-ascii?Q?4dUb8eKfjE3TT6ffWWiAqQi7uah+FL3u71pakzp9+BGLT+6QHEad21opNTJ0?=
 =?us-ascii?Q?YMFYoYagZczAG9y6cjI6SeZHL2MgKiQf546fWZBco8zKTGG+4uQTNPluYwXU?=
 =?us-ascii?Q?DB8FNCbRMm1O+L6VlOZ//WUq941aS9oLhysB5QryPbHg8z7DZO9Bm4sPl+Dn?=
 =?us-ascii?Q?4bn3699qgboElkdaA5r88HGY9ASBo1zQ/Z4PCcSlQbEVKFiYtpNzmul927J7?=
 =?us-ascii?Q?S+qEgqPXSMhZ9dg4AWirZo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;6:eirEXrHf16b1osBaifpDF04tMHDB/mPUyIIDtnnNWYNP4veW4zeE4ssWc386tOksr8aCZIMhf/ABOprB+dkFXJmdUFkftxDD5XBfTRqT9bj3aKkK8bPndAYhjyv6N5maS+JeCQxx9bWyv4dAhFk1Mlv8IcWIIW2UcIDw26cVVu+BJv1LgB2O1L++/eWqlusko4L53p7FRda18ii0xRWiSAi9K6BQM0x899kzoFFICpwokc+UFj3zVQ5Do5318+9inkigaxHBDKQKGFZUK3BepjaDJ78aDnEcedx4udsqHeqTROrzgKtEU/JjbouwhRBRTunYtN5n7yqpRpwvKqsUtxXlishrcRz3Bd3SQYgyZqo=;5:GR9Wm/YxJTGuA94Z3DAjS0sS06WM5TmTpETEDwCJNLKnZA9AGdaxCKmgKlcH6YBKmfU1qt5QmhtN9tRAeHVXvqPK1u9S4K+D8dNC3KT9r+DhyeZJNYrgMq1zuSHip3Wk1/ei7NEGxXaTxI84EJjojwHQxk0tYcr7OIkBACHkQNI=;24:XhVpbJSJ+QENhQcqLvHxyGd/EBYfcHXPvfK8cZuLMc4kvwvtoAb33+JYCk5avz9MwcaU/gfIK84Mx0mq4OT8LDUuIji3I4vq99o+nAsC5OY=;7:eDTefAU0QGbQPl3UdqGmf54YGnm7eaXlvjN7PCCY+aLBLblTSNUNKdY1OzwQrBVN4BdS3QCJkephLnnAdvJCF4hRXybYYqRWxittyKUcpcyQdk1WmREbWMrA0IuqV6c5T/ot8azCkSdlPUi0BloctLMjmLPqYj6fK5PRcmt0S/kEOP9LC6kxDF3oJxyEy/lBXxbar6GCo3JuyfzSjXxeOvqKd7if58yHjgIaXFsWbBfKn8/6tkIeF+vlYD9XJFUF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 13:28:53.2470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c10275-ff61-430a-66e2-08d56fc111bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0028
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
or UTF-32LE a BOM must not be used [1]. The function returns true if
this is the case.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#bom10

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 utf8.c | 24 ++++++++++++++++++++++++
 utf8.h |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/utf8.c b/utf8.c
index 2c27ce0137..914881cd1f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -538,6 +538,30 @@ char *reencode_string_len(const char *in, int insz,
 }
 #endif
 
+static int has_bom_prefix(const char *data, size_t len,
+			  const char *bom, size_t bom_len)
+{
+	return (len >= bom_len) && !memcmp(data, bom, bom_len);
+}
+
+static const char utf16_be_bom[] = {0xFE, 0xFF};
+static const char utf16_le_bom[] = {0xFF, 0xFE};
+static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	  (!strcmp(enc, "UTF-16BE") || !strcmp(enc, "UTF-16LE")) &&
+	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	  (!strcmp(enc, "UTF-32BE") || !strcmp(enc, "UTF-32LE")) &&
+	  (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	   has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 6bbcf31a83..4711429af9 100644
--- a/utf8.h
+++ b/utf8.h
@@ -70,4 +70,13 @@ typedef enum {
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s);
 
+/*
+ * Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
+ * or UTF-32LE a BOM must not be used [1]. The function returns true if
+ * this is the case.
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#bom10
+ */
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.1

