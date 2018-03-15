Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EC11F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeCOW6U (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:20 -0400
Received: from mail-bl2nam02on0102.outbound.protection.outlook.com ([104.47.38.102]:45366
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932670AbeCOW6S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D3curwj61qNdnraIW2MMaNPFQmq7dkcwZ2AIBa96JyE=;
 b=m9uefvVIzTsLROLz4TnXiM7FlkZU9+Z42e/SdBVmVcdBqvQoF2gPdrywCQkQv5TU/11Yzy1yMr/hispM/iGt/Q7VJ+fd+V2B9MQsw/HSztVVq4I9OpUEfbmBZR0AhMcw4n3Y+EQzQveTb63Cd2AZhX8aKA4RiwZhFOHJRhI67LA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:58:13 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 06/10] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Thu, 15 Mar 2018 23:57:42 +0100
Message-Id: <20180315225746.18119-7-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7709977e-59a6-4fb0-bbc9-08d58ac83ca5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:SNds9j+cbKQ6TeIctAtv4yk8gdjRU4eqi7fh6wXu1i0tljVWSxMvmvbIzAPd+E50BWk3woQZ00dC5Svs/7O50WjKB1p77Nup0DTwwiBQvlPjdREJAO+Cug4CS0KWjX1iPue1NL13Aju0X7VdOdwwQZb+s4Z6F/tPRLSGjuvOKI++TdIGBTRQUwB/e+WsRorKUMTGeZKEUULF3bXWGGmFTW/0QDyWD+QV/kCjdkwGkOqiSevmH6SH5Q7SsNdNpuIH;25:2cvv0yxKBULpHYTphqA8c3FKxPsh8gGIwwBrEaJe8KfLQOHFEHnzrOjBXM2AsRnR9SMeYJ+f3LUiNCi/Hym/sHPFalLn9JYt+FKCv1Kxpm3WLTfMuJSlAuyOQuDK1uGQDpZ84nmfZ9vm1WXgfRtbmJuehMDiM98qgtAXJe+QpBvB5txROshi/J2l6Ba0zAL3Dq6OvsCr5Ww4LPqkrb7NpqWjdNwB9jbAiNgpqOfEfRaCj1UT0Np1d1ZGTEvUEOLVAsG4sdTMqu/nyQlmV7KKC8VYCQgpnBOr5Hg2uX4pLGgDUQacrdvaFi7mnMBOrr+53/iwhzC2DgZqE3YpkOnZLw==;31:ZpOgNHpD8fsQJlLeGV1YXe8S/dCo6C2mi3t845yy38d2pXuQAnDxVB0ICHxGSUnd8iXI/F4MM/99EytCUdB0NRLUnJsxXTe2jADolMjdezJBUFef9/+zPpnX+ymv8t+d4Nk89EbfWOsXNwQ+E+QaB4hzlSlbxHin8S8Wth1vXBv8/tt/J9jTIJDWqN5uRnMhVZh9oGMaplpCOwspFpK0tRyJ86fUjMZBwczivX1ZNE4=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:1SdHdKY3jIOEKrOhvJSVe32ZHYqIdAOLuxosmPrgeoxYfbr5ijEPqj4Z+k+xT6N27DyO58G2YfYruyCwCWLRrlujfsC8YjwQEYy1etIwGotmtcW78hkM9HDoLRPCF+boGOqsgyOaSvYis5FUQQdse+NtNuXH+C5JvSVs9zRGMC27OSoT+Z41LybmrfN8erLbAlcSet5j/xoxiXsA51fky1E0ukTVbSEh9B3jUjFtGyaHOpfNJMcoocno3TtP+8F7+CWCPRsDoz4tJrtZhsZVg21VW+aU5ubkTG91YuryNWnqvMsmf+DymyXB1oB67dYW5CB68CdmWOXFGWmEhoByfl/foWc1jkzFKCV6veA0m0kjsgBxLfdVTSLtAayfMiKlw1kEktMNAxAp8hYqzrwsOM2USEaMTJdFFhfhesEgBr/yaWvcJzVrvslia16Sa+oASxI8m72MUxFOELmA0nahEjk+TGS+dZ9Kq3eHFjih/gDtEcOP3uLhhZNvw6lIfV8uxTh5hk5B3H86KGO1qxeisn95PoawK6A2nKb9uewKXZzFvhwce+s8/6UD5feVnDU4+xx1I2CCmhM/kN4obApm5YT12KedUsWIfgPjlVescV4=;4:dtqF7EY54ou9x0CFybiDg3Hr944uVxk7zbtQsewGMzJMdRL15oYmq3298a9hBsKZagJunWLD3CUX+ZFaaiJDLPutecGK+7/gH+aSip1gHORbrjhVPHE+i+9PlxsTqH6b7O1t8qFoh+A1ap6cp4qwcco1ssKtaT0V5idY5NljTE0EaYXelrrB+JF15v6P+5QuLLIDMqSNr5GmOXDQtskrbfHmR8aPn1YOoMbaaXOBOdcBuhC9m8/vGH81J87uAjtm8aaxuQs0w336/n4xCckFS9kQ6l6VJq/kPsJLigZKahRf/mv9R9ITJrWL9VCdY8VP
X-Microsoft-Antispam-PRVS: <MWHP136MB001447AFE27B574466DEA927E8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(85782001)(81166006)(52116002)(53936002)(51416003)(76176011)(1076002)(39060400002)(16586007)(2361001)(8676002)(105586002)(47776003)(6486002)(2906002)(478600001)(106356001)(50226002)(81156014)(2351001)(26005)(4326008)(8936002)(2950100002)(6116002)(68736007)(3846002)(186003)(66066001)(8666007)(25786009)(48376002)(6306002)(86362001)(386003)(966005)(6666003)(36756003)(6916009)(7696005)(5660300001)(97736004)(7736002)(305945005)(7416002)(316002)(16526019)(53376002)(9686003)(50466002)(8656006)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:jRh1FsmENNZMuup6u5nZn/hc9HWzd9Uc5dJh3qBFx?=
 =?us-ascii?Q?y+8zeebOclStfqbbuwNQjTWPUj57Czq2bIECaOwzxV6CoAoJE43Leil8VmbD?=
 =?us-ascii?Q?RaTnrI1D8N6Lvujk02JCHiR9cWf+ll2cNrgS9wD2wKs6zN2va0sPaFXaLnVu?=
 =?us-ascii?Q?/RzCPFSXn6NjhZEBLGG4atdonJA8OsNpqDCC4rzqb3p6S6IXjRuO9Ypmqlkm?=
 =?us-ascii?Q?SuMWBBQNw795pF7Liw8oKicr72ry9KlR8UTmgINvCMzlydoCXuoWCPAHKMzo?=
 =?us-ascii?Q?EpZck9yXMjOZEpMl3izcSY1NkorHM6RMdKFfFhsTefiD3Q5AhDZL6MXhW5u8?=
 =?us-ascii?Q?W8RDQxBLJhbiYm6oCDBLIMlcA4+rzLkX39utCMeeGvbGYh42Z6p4p+64g+J6?=
 =?us-ascii?Q?UAqjnOUxjrQbMD45xtlJzMHShBGd3j2EvuFn7TJT0+ZU0tJ8wvuYHoZX8+X6?=
 =?us-ascii?Q?1oXF2UUlf2uET9ZkyKwCarFShkuVuyzPszsolLmBxjNLBoKvjDq3fXcmSKvJ?=
 =?us-ascii?Q?7fNj5LYILWc6z95UKEI48QqX1qh5HtWUo8fwCEgGL48kEre644UTws7NpsYJ?=
 =?us-ascii?Q?Zj+7UFp9qD0GPuG9T7b1BQXSB1IPfAV2lQmdjL2IaN9zH0F7MsC8zwrfMYqv?=
 =?us-ascii?Q?EXR6njJ9QSo388uy9ldtNh2KgQtruVAoT0eYA9VI6w/FChzB1taDmT0eVbx3?=
 =?us-ascii?Q?/GE3mnjmrLkjlu0liAEzDhfqCubz5rrz2GV3OaV0BBaQs5jCng0j9E7R6nr3?=
 =?us-ascii?Q?5qXLyJJs0saqFok3KGKFfPwaYVD0/JtQ9kFdODb8gdDT1nHOXvjgJape8ENW?=
 =?us-ascii?Q?pfSyJ7zhr3iiAAtMuME5eAcdFzCxgioOL1fHTSBHC1NRMzj/JCTkVIpZHNOx?=
 =?us-ascii?Q?a9mXUKFjwMYNAJiGO4+ZPdGZh81rJcOKqce9blUrZMK2f3ShFEAWVyP0yNW6?=
 =?us-ascii?Q?VlEUKxh/OL/HDP6YlnlEbtTpVdDrt3HCu0ftpdnCaCIyfuu4LN65/4dsjhTx?=
 =?us-ascii?Q?qTu2TaOaKBRUDV6kbqWgE+P/Axsyy1GocpO+swyNJhDaRsd9Gf8Ae1LKqTrq?=
 =?us-ascii?Q?4PiMvCSbmP7NelQ6XeRT/solV3XrdCRH+F6gboMcFD1ShmUrTL7AuEhpmGGV?=
 =?us-ascii?Q?VfxI8PY24p5qrNomnr1880I790wZMvWdLRIOT4JhU3yIwyCAg7KryMz1CVbx?=
 =?us-ascii?Q?M0kkQZLnRi0f60fHwx3OXR4rKfynHhTJJfjzoUKYZ2g0of4r/CCTah1UF23F?=
 =?us-ascii?Q?Ma+EzxY4dClDkXm9b6y9wceN/ld6UrXNiYw8ChfUYFm4DO1+0oL0AvLTbLl4?=
 =?us-ascii?Q?dcERYt5pn1t/1Lgr6KDaSKz2/EIYKUP6GtGdfQmrFWn?=
X-Microsoft-Antispam-Message-Info: WzGTuDKHeQwgyWrY9spiCO2oH7COXc2081rVjEL4n88FBFjlpIxZtwJU1pGdvfMer5+C0pNTpsOP4HwyxUtDjmTJ7iSUfbVuPhixzTLl6RVg3NWrZqRalFz1WsYmRmb+k2koDIF873o91KjyLk0BF+b7BabhlrM107uV2/2UrVAGOTQAjozOGC6Z/Siqq/HA
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:Bp/EQgWAOKfPmVKYskNL/3vy0CxR4e7cEOHxn3WUNeeA+SiPB2qwcbIZtO9WVmkoWPL9rLAxp+R46npVqP/uJ8gyF9A/dgmyDUlB8a5IB0CjF9tGL+9mNlIuMJ48Jt6yyMmQ6bTvJReQDkIKaJbSkiagqlKYvPcCoCNX8LvCTBFRAH/UKId2lQBXeS0ooYc3QKbs19wyXCwsY0/CzbvS6i9YSw+Dwof79PDnm6ZLq6w8tkD4HXVUE9oMubPXMYruR+P/xiLtorb3goj8U3dSMGMhQ5fUM9wTxZG5bbUsC6XcH9A0/b3Prru0b/ziICvLFZzzmk0ZfdNVt83fTcA1ArAOmwECWVw1IBMl3XqH+0M=;5:8axPRIn2iXJzhdDhS6eSKjw3maSKKDaSg9+qEvUYhatoG2CUSAe/fH4k0PsAwgs1k9MWNQ8nYSMp1sWSX0FurXZF13LYbZDXPEE7yc2MaSmyTvesX3nbIHr+KTkv9JsUSa22PIVzjGeO9zcUQnBzLbfUFbxWK4MCRrYkO97SC/E=;24:qrYYD3T9s09h/PjixZw2MRkL/weChyNKaSKupL6awthykYtdNH8MeRK94fVsKLiiU1tQjGmEGskjlUYtS/lUh0lUz10v2TlKBXEReOSBqkU=;7:fjK/Zfs1Rkz9NEsGEIBEQmNfxq50CcOVXgLN3rxnr1IFN5S9ctlZrry5ldHRqTOWkaZg6IOPAfJjTKLxJoxBEfOFw3A81eDoE1ns9LiygMWbxRVYtMi8Txq9bOFBzdyvRtCJ2So8y3eSyEnYMLEADpgQUmy5y5UaJZys1tn/e1T2CXVgwIZhtnao/Lm+6Dcr0qDg/9Wj4cNWnEA2hMQDRjQs4f4oxboaRZa7vrGDkOl90yCT4tK1Ee8qC5rjAOrn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:58:13.0723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7709977e-59a6-4fb0-bbc9-08d58ac83ca5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
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
index d16dc1f244..2d8821d36e 100644
--- a/utf8.c
+++ b/utf8.c
@@ -582,6 +582,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   (same_utf_encoding(enc, "UTF-16")) &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   (same_utf_encoding(enc, "UTF-32")) &&
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

