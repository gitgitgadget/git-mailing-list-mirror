Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5491F404
	for <e@80x24.org>; Sun,  4 Mar 2018 20:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeCDUPz (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 15:15:55 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:20096
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932151AbeCDUPq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 15:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GKCrkOqn/Wj6lF04QgHJrXtz+bnyQcN9b5j//iYWLxw=;
 b=egep1mu/dlm1XZQ5IFlV4JD6T9IhCALuayocTTV+qQyaTi6ziY0WR6iDi8L8dvtWdN0o3tU8fElB8zXtMxC5/SocjhAZWf+/kNhYBtRjHsseAmPjBLavNDvjPElqazBsOiIVZvHrse34kIsPryRqrSZxMNfXDMnBRo+ir6cH6RM=
Received: from far8gsqyz1.ads.autodesk.com (132.188.32.100) by
 DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM (2603:10b6:23:8::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Sun, 4
 Mar 2018 20:14:49 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 4/8] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Sun,  4 Mar 2018 21:14:14 +0100
Message-Id: <20180304201418.60958-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304201418.60958-1-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:23:8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ee8b57f-8fb9-48e2-6310-08d5820c968c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;3:7LxCV2oJURqBTrlP/ea/liYlGL/F1Bi1vU8KoadO57SRGsI+9FCoL2wk7qfXM24NMrXg/5/G7EC3LnN21ZXyRepqCRMosLngCmy9DJ9GQcrxJVKnGwDgVv3NCPYhaUFe5IjOle4+LHRYZ0sMkwE8eLriTui3KwNOFNuvnHhX7+0Njq1iei8be3PnBc1Wm4q6BNp7EXm5YeMKfb5eWGOSiTMmTh6ojYz9u9JlaL6smRBto9Vy3Vdtn9UvGvJAHuEH;25:R9C9n/7TpCKp595eKhzzlhFdj1hVJUH9FfxQBo26OVkuzdE+BtJ5Mr7lno03Yd2xWH6k1vfgkGkQ8ZcCKedoQCE0Zqufos4TcmdaoMzGAJGCPpRa8iSnNeL3olhKcf4eLo0XT4wl8ueJZWQ9YHuUvXOMpU3EgDkkB9RCnYATM3WciUHY67joiUSV3h48w4ECZSVSRrFF1quCman3k6YkKFholjoPZ7BO7V+0xHWYQyMLfe8p/g3FnqYOV6zv5R2sRuIncvPM1+P4ufyXME/0uUL2XVZahen3v1SafUJNE0P3zHkUxXi9+SH9pOhCbbDcsMjs73nmdzfbA4VSww/+zQ==;31:LgiWcsjAZiI5G6Dbv0fvxdj1mUvQC2uIuEVQHEAoA4iRvdwudFCZ/uB1lWUECz2riP84eRp7X6WF3N7+GN8vy6aq21r2FfH3N1YGhNNYwYQWk7byXHX+IVF6GR3gPZk8yzkxrXOIt7UR/VAL/eaZVSrBedM+7rPncDx6F76i6GkJzJ0bVe0aJZ29wB3m1iXWR03gIjXuCgmKt5eLRVGb8bgimXn9840JEAos4Wmfsbw=
X-MS-TrafficTypeDiagnostic: DM5P136MB0009:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;20:a6GwfzglWZcTCMHA04serlQ9pNFQ4OKZl1W5wn8qWj+Arf/dcv0+wz7IB15SULSvBrgkO6MofCbP1YdSfvDJ7b70zLD+IIbCabGq2dE+NMtormQN/ffYsj7nB4HP8z+gzsG8VeVAcFvSDRQd4fIkmqVQJVOYDLZmL9yDenpL46ijiSTiOKFGjPZ1XiwGSb928RF7JmetBsOguQpBQiuZ8KPv3yp+XP8sbadgqhkymcILkKplEyNkqEEvl3rx4qYeIKQ1Rzg7y8p7g5rztuPZPdKbYNZEX+nLu8VoKwxzLRqZjMWYAc3KQ/N6EElmDQ04gCkTWxLDuUHuW4XLyqlosB5r+7w/wGN7e3fdc7iwW9t6zYaEXyPMRpESb6VYYNSaRi2qiuKC8r1qQJ5G3wJfEBILyR49tt4yruHxvEYqmgM6ZEFgQQunjBQ8+ojI2p1qqjWxNfYab+TpAL+FntJlAPXB/0JwCfTeESC0s/Zs/0Cu6BD1v4rG1gPLOWaAX3mShuR18AQTLMN1oi0ckFAN+SCCGiAsFoP8N8aWzqirAEQvefi9jYpCeOH8P3KGphgZ5zgDARCAwtJ/1Y4gExn3HyvJ+4uoxB6Fd8U1GqFuXkw=;4:uHWr2ffNkC7w4BLKW59H4NW1BXQRPk+NZsieen7mmxD+KWyEHs+0tkt9rkfeuj7hNbfjBmhnWPs22KaOOsH9UzZxXNo6y7xZCUh/ws6ij+KOgfq1v3Dw3PE2dMwcOuwTF8N9iTCa0ruIUYJLYv3syXPp97Pcq5RvratqoGJaYP6Cn6Uf1rTpdDnXOsBl3ep5JGN/7ZBkiy6kep9KKFY3BT18/8U5ye5KaHu71NNi3Tui/voC7Goz7Grd2Prhl/P4JJUFEAE/VGZb62vcmGBqmgewL4MtWbzN4/rZlq96W+fyPCEfxzLbys+eK/6FTE1X
X-Microsoft-Antispam-PRVS: <DM5P136MB0009E6078E409A8B26F209ADE8DB0@DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5P136MB0009;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0009;
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(316002)(1076002)(8656006)(2361001)(16586007)(66066001)(2906002)(68736007)(7696005)(85782001)(52116002)(97736004)(105586002)(51416003)(966005)(76176011)(106356001)(86362001)(2351001)(47776003)(6116002)(3846002)(48376002)(8666007)(25786009)(6346003)(39060400002)(26005)(4326008)(50226002)(9686003)(305945005)(386003)(53376002)(6486002)(53936002)(36756003)(6666003)(2950100002)(6916009)(6306002)(81156014)(478600001)(8936002)(50466002)(7736002)(186003)(16526019)(5660300001)(81166006)(8676002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0009;H:far8gsqyz1.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0009;23:xI6p1Tf3f9sRAqfaCustsei8jzMtOQ6oGz3OeADbU?=
 =?us-ascii?Q?2ydC3OC9U0OIDvJ8uOJmLU6C3rFxhqAneDiB6nE2AFJet7TqQuQjk39JNZoV?=
 =?us-ascii?Q?Bg+WxovWbXO95oXDDQ8KMKk72f7YUkFgfFhCssUaUogcRzkpgFyHiojXmOCU?=
 =?us-ascii?Q?dKQwyvSYXm9Ht7vMEZa/FT6OCuiFBtWWhieTtR7/QUZ+WXE5iatNmlGci5nb?=
 =?us-ascii?Q?VvV4KPrb7rswMKTs3nh2ZOcCTQLVgJUeWj78qFSTEFM0YgpQf8Oj7rPoqaja?=
 =?us-ascii?Q?gGrVfjPlkuHArGQtk6Un4DCIXq00Of9ab4SuJ/WE4I2Cb+E8131C0fk7QOQC?=
 =?us-ascii?Q?xxxfqOLATCNHeUadUOgaBDW0kcRLKvupYejnAOTCE08ohqjdOI7QFI7J4kDU?=
 =?us-ascii?Q?Id/vlB6dX/oWmWtk+GUb49RShVv1NOvvqyns+hbRFAnkbeM6TyL36v0q1yTy?=
 =?us-ascii?Q?iCMmTwbPfiOFpCJ0O9T0mFXXyWFtckv+e/YTmGd5HZGW5VhADoVgm201iuhl?=
 =?us-ascii?Q?4NhDT+cBwJKhYnQfwjyfnQ8uL0iGnLWxFjND9nXaJzPXCaD3557pej8WCyFT?=
 =?us-ascii?Q?ecEo2gV5Rx+tBDjx95DZVegL7dqNR8JX6ZCl7idIDKtQhSP2TorkdPpuVUtQ?=
 =?us-ascii?Q?/XflIsM0tuhIk3v+doxnVzI6fzmSpd2cX0BRwqXwK2vLFr7k7UR29zodZCkk?=
 =?us-ascii?Q?5nf9xncZ4tGKvsh7exKSqdXKj2DUynNvMbrnIHM7xuxczPME8TDbYxjo7lpO?=
 =?us-ascii?Q?azX8KFdLue1ZoBzw5wUrKOanOWUy3ggPt1TjJjfDfPmnYD2mmyQnZYqJtwSB?=
 =?us-ascii?Q?0nIAGvoW+L9BAbA7QaK0pbzswTezuQA6wC5h+zXUd+4mQfN0fzVvG95BqMMa?=
 =?us-ascii?Q?QQhAlyepYuOO42e25YhEL054iXwIaHGIQ0pfhNiWjcsUZFQxl76SukoHsUiC?=
 =?us-ascii?Q?bSaF6Us1l8n4KGZ7g7NQ4bu6MdM4cy4r/UP8BAx6ZIL9NpMY2dF8IMJGFa99?=
 =?us-ascii?Q?bdfcvrJ/CF4tjO/WjzQCn0BPyp2VlnWg6EO08M1aXrp+/ezUjj9BkMA+xZ+v?=
 =?us-ascii?Q?+FuCKWIZznYH1uEnim6nrEbzMBjxNeaN9oSjA3SeZkSWe1xCGYPl1h+yK7pS?=
 =?us-ascii?Q?HpXS8I20g5FRxCCV/R2YGXCBr8Af6j58Hr4aRALT6eKM7jxYDsUp9KWhveHS?=
 =?us-ascii?Q?P1bqOErJ8DecGWKhMvo0K84d/rz8fZ9LvRKn+5ES0zxB2Owb7h+owSYbHaAm?=
 =?us-ascii?Q?KuUZJHqMXHoFYMLS5oOy+7+ZM+oOsxPllntF8JeTPoDO0an4rSjoWTY2iksX?=
 =?us-ascii?Q?TSsgyMjWIXLY1a0dq2E+KXHALugG2ti/3GEHclZmvOX?=
X-Microsoft-Antispam-Message-Info: DUHVW6vKm/yjjvL0Gozyp2VMBnt/FMpPYtm7xoUtUhRCJoFRKrbUQVqOdv1e9kcvqEaHRxb7rQvW7mIIPme9U869iDIsLL6xKT0w9ViRaVfvcCPO5mFDAlRm1zMosXjjbfLEONrWtzoyP3UPkwrenxvXAeCbrwRV3xFvxUpcYSIwPFA1B+2AZVPtrNHCM/Fw
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;6:N8WFz5gEpdpleMoGxxz5Jhz02AchlR/iAFG4aQEtIALsrapTUM5UK5PouoYvNafUXerBNFZ8V6fC2QMzuaskn0vh3v4Sw8QK0KAiyrHnqefJc8qnqN82G/BRfRYgfUd6Wu+pGxrRyJy/sBFxIBS0mbHsriTjeZRmuwgRaxR1eNsp9EQ6BjpfDhyQQy/3ALbFS/CAZwIavikvSs4Tw8QbsqKkzaRLTyQKQbDDqdQvV9S9P5qRdwmNQrwWk7oBlu4c1bk+rw6wybEx0hJVX68qLxHFNx5JjA7E/wkGCuFvp7AeW6Qq0ORdLBz5Fs0PKZ3QSTU9Ir5Wi21eLg2e41wx0z4O2YMb5MOhONPkU3kA4Kc=;5:lZprGyaKpC5vvA9S1+SPplq7PWUUwZFKNy4f+buuBSUnVzEcU8x/0FmtCWRF5IhvAPg5ktx/qKQuLUlG6i3YuIdvU8ozooJ9sHK+7r7tYLQ0tHQGNxL8ErXVvwMk2hbNzL2oueYMHb12uHTNcYLRHxzY3YATE5zjjJuJqplmAjY=;24:LvefBwQO243ripxvWwuuJAR50sVWf31+dFO5RaaKrLIQJ4dEh+Q1P2wXEYHe0BKZ+mfY1f2pcWldAutifZxVC4XTzXT7BN7kvEjNUje5LaY=;7:cigq5XB/zuGssVt/RDVdMGs+DSneRDT0idPaG9xV21nXSMOA3KzLdc2B50+53kr1abSg6dwgtuFTSdBYUuNAlF49fCMy67M40azNSXoAeWcFVIFUwEgujzY2yivcH5XVQ/576uTsONRglA1vUrnP6xIyHNHbPZcYazE1XSGithdLP3sSTxI67949oO3jkGHR//HM3HiTz//nD+PDmEaVAz4biEhaOmArvba5ppqmwrrgXA4oacv63ycVr9ILvoX1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 20:14:49.2294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee8b57f-8fb9-48e2-6310-08d5820c968c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0009
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
index 914881cd1f..5113d26e56 100644
--- a/utf8.c
+++ b/utf8.c
@@ -562,6 +562,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
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

