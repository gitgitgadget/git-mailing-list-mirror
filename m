Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B141F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163642AbeBOP1k (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 10:27:40 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:49632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163612AbeBOP1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 10:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XB7ZHdouGNm/DFuBSB4OfXxSWV1XfOpSnchksRSdiA0=;
 b=d+GEm0pl+UI9hKOhl0ieeJk8ImRdjCTcchhxnFVo/qy8Ct7y+oTjHiegNsj21B7iVzN+/N5+16Co29Az3t5HeOauMAi4PjNuMgIjexSDW2zbUaPeKao+jyqgYHs8Viim94us7Aa33XgKMp/zkhG6yAczy83PxLPjKgHvuVnpYNk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Thu, 15 Feb 2018 15:27:30 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 3/7] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Thu, 15 Feb 2018 16:27:07 +0100
Message-Id: <20180215152711.158-4-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 009399a7-2723-4061-5146-08d57488a1f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;3:0CT7B5NcX1h30jni3nBQn0XeokcMPaXE6Ktt+xo0LLsaxyFg1bBbnFAx3YXsvubquUDnA1EnJErvXpIMfcmrOsIM+lWkFLUnhX1oafWVclif2zMjDSQVaR77pYoXyS2Hv5ObigaIaM5GaRUTUtcrYwyxgm+tCcEE+iZh3oPxl7zc7V/YRd5ucMVH60qzJ3eE+JQLZM3mSfrK6B2lrj74bcoFd8T/JNyonoyJZ1JKrcg7G1xYEZm2b+IFBkaWkf1I;25:JN/FPYBI6PyYFjdVFh8EQLNIG4rcsHKiI7kwolyX8Qj73T2kk5O224nnnxz+AD1+0plzJMu7Fgv9MPcYpUROfmwFA96VDyYUhdDJjHLiYte4tYulm/1NzKMTVpG+xL1csEg4llrgQIhHqFQdHSE0aqiwwK0RgBksaXo0ZtuYabuR4NshQpsyCjnbTj6in7e2ZOSzu1wY95dZO1XlZd8kXa5SB4dyVxi9yH1mv+S1ShvAaOviP2fqQudFsmEAHENqgATwcQuxDxryA4BeHO/3NKImOwhMTQB8AgknOd40y6FvDbG5G2RVn+YG6uWM1R+QPxPLZlzjIu5BFZnilRVxrA==;31:GnV8iH5MHKV8sSyjUjmA8+Vy6uLFel04D1dRjsbzun2vGFE8vKZcxsKOi3GjerI+hIxqCJcQ9WMtzuPvTNYUejYPgv/Rzc8uxMBtJiZ795YiT4XWpntLiOwqvmJaCQYrqgsvL33gfHoVcTy+E4BSRjUn0qOGQKoSefs2NSHY0tQp2KEqAAHu2oUSrxRWwDM3iJI8XIF4G4yZnjFHOVaT34UfbFim4IIvKzYvx+zrkl0=
X-MS-TrafficTypeDiagnostic: BN6P136MB0020:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;20:54NBm8jV1Ks4+/jP9lLXCucvHS6LDIhj8FGjV/fWcvMWWpvxb7Tk4AhQULbX3rNsXiVELqSeGXDLZisGf2dKFkvhdQgaA16pngkQwdYx9be4+Rj3QizZYmFSFHoPG12Ni+MC/BjqJsoBzqE2HH1PdlFtw7OSuiKXdWEeiKYMBmMAwMPWuHJl4ee/7hT2HIkMKF1aKiI/vBM3+La1av2JCntUOl9KhA6jrM7ydSubKpX833b8X/buornMbM+Xbst2azOAFdqLviYqUtuUJqonbJ2gHHxeJI4t9UPEQfBhOJviCilb3qdQMKFkHV5bmTakKWPYhRSxW5yTOdgDsTTpZmvOVNlqP3kQDid58DC+PB9KR+UkVo+Ar/X/nNBhqat5xvJZmQrjSvhM7WC5Zcz49cdm1vIAv0xk0psJfEcXkyV4NP1JicA/Luo7Eg2yMfpszN5VQ4cHP2BV9r6/3rrYf2eeI4KKo3vALRQWU2oeAsZGPHgUSouHWCH6+n2q2q9GoAsMFKofTEra0U2MbPlu+64Pn+6rXm8Q++E6l+aLQiwsDHiaH/VU71SB8ArGX8HU2w+KtZ3+3lbt9JP7teCJpM4wOeLw/2JFZQenFJ7TFVI=;4:uwmj92bZGBNom+bck3FTSCbeuEVr1X7JJn+5U0c+48q0trxJuWClF4++7NQnlSIbzacri4Unzq3qkUzXCj8+vhwk+XIfDE/l18JrhqmFJ5QBmwbMHKSzkpaGuSmM6UqLlNsBx+SrbOTBvweWWiMFxSqjD5IGrHTPCab5rwF2ZqLUEX8ubgJZIHAVX6W/g0I+X9LY8rWy/kKN3ivTlJkadz5KaN1CNSsDJWet6aT4H5teZBsDQ07B8l5lhlRI54vhNcWx1jXasMJpJLdtmXfB8tEn11EzX7tzF1tc5re1PhJRckiRV2cYlMmbbeTNP0MG
X-Microsoft-Antispam-PRVS: <BN6P136MB0020BB311CF8C40FB8A4E941E8F40@BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6P136MB0020;BCL:0;PCL:0;RULEID:;SRVR:BN6P136MB0020;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(81166006)(8666007)(85782001)(186003)(5660300001)(1076002)(6116002)(50226002)(6306002)(3846002)(86362001)(305945005)(97736004)(106356001)(16526019)(2906002)(478600001)(6916009)(26005)(25786009)(81156014)(105586002)(8936002)(48376002)(53376002)(47776003)(51416003)(76176011)(2361001)(36756003)(6486002)(66066001)(8656006)(8676002)(68736007)(50466002)(316002)(7736002)(2351001)(7696005)(53936002)(386003)(52116002)(9686003)(966005)(6666003)(4326008)(39060400002)(16586007)(2950100002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0020;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0020;23:SXE/gzxEdDPO75zS/ASpaRLgrp7iQMT8wh1wawizm?=
 =?us-ascii?Q?oz8AX8jCfT9WrnwRLOiQUaAEaF8JeX5dls6Y/LDKi0oHv80P0Y4r52iZmwtc?=
 =?us-ascii?Q?XpOodrsw97NH25M1DhyCOC2g/7304yV+WKXx2ANNmnAYjajOTF/SLkqHIyEk?=
 =?us-ascii?Q?2KHH+KYLMC7TIaNP7CBDiqfrWs4cHCkCTCtLPK3qopFD63yvlR2m7n1qJNcy?=
 =?us-ascii?Q?7jUNczjb5YqQkkRrh1nEv+NarCK6ZAOTdv1JxuWvr6NTUsnhkRQQ2h07Mej+?=
 =?us-ascii?Q?jqOfpi/03sza3GF3BzCqIi+kWqVyZDU574aL09gbnTZop/0ou9E0PqhD8jE2?=
 =?us-ascii?Q?NGbS0HUGdco7IlzLogy2r8iFBIuJsv6wcveEV0X4YwI41N3AT+8WI/a4wpol?=
 =?us-ascii?Q?so9vJbFw63va9MVMtHaXgZgAZdTtF3n1LzuAPMYQi8htzBmz8RIz1Bo90/lm?=
 =?us-ascii?Q?IVvqTmzsWENal5jf/CAueSH9roRWDpSHc8kU6dffu50Ftz+t7JUnqcFtX6Bx?=
 =?us-ascii?Q?EsUdDTBnum4ThqzGPWSViklR2IqtnfPM4qbSE/xBbL27j9SiJ6w5CRF8Ryuu?=
 =?us-ascii?Q?XPYdc82Fav6pA3mOjnSznZ3qPMY9GXCwdVfNsCHapF1ISVx9c8LLUTnNs2Ii?=
 =?us-ascii?Q?rNSQGEcicQO9CbgNERpmQv08VrhlsQBmwcMDzxxaE+lhRyS5cTse4zcaVb4/?=
 =?us-ascii?Q?7NPn3K0TZXyYIo9JtrekRdK8XgIafa6WcwM4wqtyBmJKEooUtZ6nixpGJtA0?=
 =?us-ascii?Q?KIq6o/IoSTgWNoycqQzF5lQHmiEKkT+3Lnu1utM4sRSmpb+mwLcKmMRu8Gop?=
 =?us-ascii?Q?1TTITMmIhsm0wNuBGdxywqOyimtaibWICCeet8Hn6zGdP/Pscbi7K/hEM12A?=
 =?us-ascii?Q?ldhVe+a0x8OIZOdM8qzhsXY2HiQHeA3W7dfboBm5BcMDZYiCeXqlGzvVR+Ey?=
 =?us-ascii?Q?goO0QliYhuy3LsXEWr6mf0Wl0W+27N/f7bx7GoWb/lhYfHRPT+9EXpaodnaU?=
 =?us-ascii?Q?sDA0lgCMzGi04gFlQgrt5onsS5g5HZfxK/sPzMYFrBlOsruDC8XtUVgIkdac?=
 =?us-ascii?Q?IZw4jzAuvdxn+BNmg+Rfo9lFvXNyCXCrDZ3jvNsxK03zsUJI5a0cSI5p5RGh?=
 =?us-ascii?Q?YxLsOIQtLPbAgHw2UUzh4It2xtdZKE2VqR9TXLTbc50h+DYcknP0fFGN7yvU?=
 =?us-ascii?Q?RrwUuH/cZL/r12UIaw88o418Qx0vAqF/jDorjRwk4X+0n4cyKXZoE/INlct5?=
 =?us-ascii?Q?GMXOe+S9N3GyWRRlV0g/y6aS41CZv9Cu1AX5UFTtldKSvfuCnQLlOfc88maU?=
 =?us-ascii?Q?Je1wMzkTLmn+GYpyIHyaZY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;6:35nMerFbVyg+8q/YHeDZIUb3dz9ZVrdSNtjMOT8/9/ERNPAZtXifCa/ktk6opRTqZgeYHmG/7yqUvQYRQ1g4dtMw9E2QgyW30kZgoXVEArXgNRWfGYlWqA2Vy8UMFYZdWhjHan8XjIfkIXAd3/8oJvZ6UnOcmHClYeFat8xJN+/gwxnfsN9JlwNyzzhGnd/RqDzEtWKoEriV4VB4rvD/f/GExBr8M3J77eA8Iu7f++4NCnVr5i37zgy0A1Y/ieUNDvufWIUvD8UkrgovFa8DLpkExUwwgskDXIZtarWU62vTuJBoD9gtLfTDy7er6Yw1KzxuFubrj2fZBvvfnnHbLFfriTg4VLn8V1jfzd62QiE=;5:vGN9Br5O2zlsQwvsfNDeQGZbRvg5dfuN8eXtAN82nCLZOxiF8HdyNl3bJyXxOUM9ou7TxyZKD97jlYAaA3GJc8nVq9rsi/H4OMaIS/PyX2PnxCF1F82n74pSaDo7LPofkSIsqKtkOqbEDPxK6P09V+oVgnrHaAsjo58O7HzR3FA=;24:mvzDaFfmO4HRUQ44pwgYq2rxU8y4dT3NG+Yj6JEdNd0pFbPaXn5noYL365m/x7tR3DRXSC4S0Hkn6oxzk0eEmm7oc9OtSyaT1bJzyW1dVy4=;7:h8yG51WuyFT4RE39Rnig0Hns15u08YOaEAYGaJRHJCnsj//+J1K/MB80bx5fMBw6AvRmtJt3w3j8ZjTFi5fEGGPuqM+LR9i7Dt3ajLL5jaMIS6u7Sq0v2AH8oyC9nc9+Us1vCpmMc8CSSf9FMIP++MpAlkngC5xk22IEXaN0tx0vcfKrIAGFY4RgQBYU1szfTT6iLISntegZVY53XsOV6NdNeoefgxVpIbqRxgT65YZZKI7jDDHGMHPtPcFoaSJG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 15:27:30.6200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009399a7-2723-4061-5146-08d57488a1f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0020
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

