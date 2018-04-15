Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A431F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeDOSRH (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:17:07 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:43680
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752938AbeDOSRD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hv3cycPoMH7MIZFZsYSMYx/Iv72FXLaRf2fNUXUxqds=;
 b=Hz5ZxjD0QP/Txiw1wP/de9YKOEqHS9bNVeIkqWeS81cM6iFoZMrDqelTdGqA8XF/8FfWRotV8bmkbgd51bWRVyZ323eK1C361oG3SlpguSDqZ0hvcuftTQOjaHMFKrpfQrU88taNQNjNdkek0ijxzG+bxwNskgrQweK2d7h9rDc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:16:58 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 08/10] convert: check for detectable errors in UTF encodings
Date:   Sun, 15 Apr 2018 20:16:08 +0200
Message-Id: <20180415181610.1612-9-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180415181610.1612-1-lars.schneider@autodesk.com>
References: <20180415181610.1612-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: AM6P193CA0010.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::23) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:SpZYMzcqgjtmrQxcyg9kwp1ux5oMGuMcT4ZP1LI3xpJvjhfITgbGz7n7YBri5u3Xz/ECCd7e6CCmqJ1cUxQJfmBIJ3VG+cpMtq5NhZmhYsUwAwM7SJzFRGK5maQAU5UgNp0fqVmXJCHgu/lv+J4j1kkq7hYSiJ6L6KWVGty2b1B8VzzvjAUZCeldIn95Hp3PbTTrv86+jne3b2yee9C9CkiZsmtid5ICl86iYtPfQDOwa4eOE1vK8q6PO+te89Ac;25:i/diLTZYAUkv1WNNJHukZ28w6f0182XH3lT7fRJ4RmPb1RLVI4sS2cd6nuyupQVQhVXaNO62kmsZdiYZOnAJjAIh9Ixycp/q04k1i0/7KdCX1z+UMT+jSbGoEIjDSs235ekxIssWaSIsGlKadB1gKSkudo1TBv1tMTf5srHdxxRlzQUolGYqfcKBrF+9Cg46Q/0qX+9Gl4Nz8zhiMbeBuHrKDHFiDNB3RD3ArnwfRD+DrChPuW3Fzg1LlTLJa8qVhhJVB3MHbaTIz38DJaYOHcx9Gsf+ZGCQ63n3yzvaymCzuEuWjP8ATJ3Vzu15YOE1aBosxtY/WFTtUlyX90jtEg==;31:I2s1KvQi3x8mNJTbl9BM2VYVSi5YUGH3lavdJtW/4TrMQ7tQzlA0v5em/NKbBNyaAhEKmdONInKjruZi/Vwgf1uk6EgRsS8d4SkowL9rWvceGFNnqAOYiZlwlrae0TqkRn5j731rZPLHtOlvD7RlqU76eP7X7ACuo694iFrsrQf8flEaz5Ewql6zEh6j5IuBzPJqazzqG1rmpWCaMdZ15RyFjtHArDdMSIM/aKI3qxQ=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:T0Hnp/TRzKyR23bMxHnYAbgHl9wNfjou8lBbY5QYWn1VtQu02eKimd+3Udy/bdd49y0Pz090C/LblZ7+58pqN82EAcLZG6lTQ+7GWFkbIm/1pkm/0xYe7frZBGZ4JmcgV1VGNZy/pSAIxURlBeK0nlXFZ2zU5ipi+dRWY0TFdYccl/BgoLiq8xYyUGlkWZx+IwhUeDQF51G8NfMlLUrq2p61jwyqiapwEsVgE3APTj/yWhSNNnRxtKsUF15c+DO5jNBzEm7MhdPlY/+Dp47GcNaxZqvkV41IK0Vk2dEZjfgFqBOnU3tSzzRkmzjjzFtYvSKz9USXb8qtHRtlTE/rOzXMFELhcCeMW8wXo5TUiUCnPbL+Bv4TfOSunmOsnkXGtAVzgzun2JlTdd133tpMz2MoWYUuoU7lYFTwDrt58wz8h2nS47PShP7F4gJ1krYDo02h/KtEgfNDDs5Nb4BNmBbL2/ZTBWRSSd8nQnVYh8aY0bh3WfI8URgA1GqHTQ3ATcqnyah4/0AhIdl4pbopuN8b2OnMbDzCNEG/BGhOHof9x/hMmuYPXyk/1GszsvP7t5FUKRcXVlyHwEsaAP/UMgMCv5zBvqHr6umAtyr5UsY=;4:7COGhcBEqCGyQbtGfFxLr4NoDycyGNo5v5b3WpSEA9VPgSbhFWbXNZLA1N67u7M6pLHyX+aM/fLUM/vGwmUNK1dQPGhoqyPBTBDgIDC9Zpmz0ZYVe41I0XhwIo5Saq0UoxWBCo/Og1u0dSSms57PGewQ3d7IB11CvP/S7JsClo+Gfiwgmg8dHJ7VbdMa9Pq++CeRgCvvvRZ7OCCMBn28tDcqt0EZgNnomptgsXMCtGuSHSwi9p8SVqbPYCw+KgJpaPd6LMskGmRB+dUJAi/Lg2h3XxwbncECFpDyNp5LD83MxIJHQUnJUWjl5zOi3Mcy
X-Microsoft-Antispam-PRVS: <MWHP136MB00146C65E2BF4624F4DBCB02E8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(9686003)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(50466002)(26005)(68736007)(16526019)(186003)(85782001)(59450400001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:+vX4tBSpxLbqQuBcOA1xtwFkm7MPvjob95DvJ4v3h?=
 =?us-ascii?Q?SqUe3F/oNvoTCENiGSslpjpy1yKpJBswJyiwrW6HPby78gtGpp9NGffMteq2?=
 =?us-ascii?Q?8S6uC4eOP0yQ3fGch3iuRl8UjrHYCjjJg/ro3P7VS+RaF+/dOVPpPIQJmi14?=
 =?us-ascii?Q?zRLyZw+Q41mXaSWDEWF/zs2KvUQUqtyPD3LeR8b5o7j3q/GKJ5bBGY6acKP7?=
 =?us-ascii?Q?Cv8TnglXY63A5iFZsQYgRS6FdJTEi/Yj89BHW2A+Tdf4gOn+76hVuMCTyWSD?=
 =?us-ascii?Q?1AVwKZ/+XGSFziXZIc1OroCYw02qH6n1ScVOPQzLW0eVlXKL1UjPBSc6KNHQ?=
 =?us-ascii?Q?okVIqIoCGgMUsVSUCAdyIpKKtMc8RtGVZW179YXjTDspJUZPkY/J/THRFLPe?=
 =?us-ascii?Q?phvrWbOGb2j2c6pPqkA0ZmkSJvpTJPv6KdHPqfHf/V4g6+G1x69Y82yOy7rk?=
 =?us-ascii?Q?N/1cGJe7+cCpEGCkRLLxQmicxxois8vX5WjUuuFvnl7Y+qCguOvWA45eylu4?=
 =?us-ascii?Q?BYVcBMs/zxwt77L6tedK5FL//eNOs8+80texs8/j7B+o6WwyC7wYZegrMypy?=
 =?us-ascii?Q?Lkp0YrC3t6tmC5eWMeLHC7wJWPP3uAp8k6fMmPih1zQJAq4j9Ev9QtB+BaxU?=
 =?us-ascii?Q?hJWdqEpF8ufBX3UGC2H1wku6daAxVMkYZ1Wn5usc/Z05SOefYi0Wis69pneh?=
 =?us-ascii?Q?DDhZjxJwqvEIYyZ4wsl/pRRE1q+kj/18WbzeMVu0YA3yMZsZoo0H5ggRQmNl?=
 =?us-ascii?Q?2uK2fBSZddMKMGg09junC9Mjs3/k6rRFpXgyKDOQe2297cbYnbdNzIk2RXw3?=
 =?us-ascii?Q?SJrueIyLLfyfOCwMywf/plEEYlGsO5FJEIvUJQkbNpPfwooTeg50gDdVUvy/?=
 =?us-ascii?Q?jG6en1rAp38yB1ImNc0ygcbS6wG+JrDOmFlvKn8cOcOLSkpjUD+1JvYOG/x1?=
 =?us-ascii?Q?OGXnaAxibaTyObdOAQV4Lnz0t199wtfcYlhPwU0zzpxPgOvZq3Exp8S72lrI?=
 =?us-ascii?Q?UDoWMUDe1DOgfrTykOr2pHUrJvFxIlz5Rc7/HMYlKqAUrr6ShFxJ7HydythY?=
 =?us-ascii?Q?0ISAn+LSTi0IkJjRG7qiv7zTcoC2RmOncayG4f2g2e4vIxnIQ7DdNVzmjIpI?=
 =?us-ascii?Q?983ZnF1tlijRDTA0oqNo4U0IWIj2BOsMsmP5jIBwQLO0sc4qmC/jYUTjU5vr?=
 =?us-ascii?Q?kINAdP+jKkAeRYv9IJuHqJnVuOWeitQqf+Kl60zNUeFKoWmetFAZY8Ba6SjJ?=
 =?us-ascii?Q?eE7J+bjcCvoEfYyjDSZUfFrOyUMMYf0eThQGeK9F55DeYzUmvJkHiA3xcgs4?=
 =?us-ascii?Q?3QlgorvyMFDZpA8tdU2FsxqabMLVmEWXDwVmBFY2cBE/6RNIV69z4Hd1QsUU?=
 =?us-ascii?Q?0+F3VOvgmLSPmRI3UEGAZsQlU0=3D?=
X-Microsoft-Antispam-Message-Info: dbyl1a7uZncQlVgMK2AaqN6esA3QrZjCgSNWs1+O7uZymCPjZT7n88+MP/4sVQWupT4a6EbjJotZtr3b8bP8Q5Wgjy8cEWcs+zM5HNXN+4v8utV6EGZZzSrojQaXPtzmI1s+kHTJXUj6t/x+F3Z0r7Hdtf/0X83ijddfjX0+dHoKwYvtiKe/FdNUIZfarMTJ
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:tRtaH2QDPKFn+aVHUhN8s/w3roYnRiaJQpsiy0sBsiu9oaq+5iJy2uKQq2ZFE4Lauu0SpHOTgwy+D4thLUBwBn0rHat1Hvsyv+4gPM/kWtqjhqKNMGEgYIj38c1lU0oJgxB/WNzh1ecdD3rQq8rKGYIzG/ltJ2I7PzoMP7ZS+u1s7zE7uSHnkxQfolSmb8abFp9CZHogOqVwfDJhXJBVf6w8MkEV9RqVKWf3Qff3o6Z2ZDrvzobLcVG3UdHHG4vkiFz/PP1SKwW2bHsfNihlOmfsS7VCcZIActv5S24zag5iNTVNcOzyG88W4aG/5xKse7hJP90wqNrMKIGLnRKJYYuNzzTezQ9MAX0+U6slJqlj/Ro9WbRNIDdnl5X4y/cT/zpMcbULpVWyiQ3cO3V/Xd/i2898T0MP6ePLjcYAYPsrZrJRRG0WCAL7PETQ8v7Zz3OpgQaN8oQ8c1waUNdtdg==;5:VvGHFHXQGNxDJo69QPNxWL07FPgQcF3z5he04bVC2XwVkhKLrSJhOWAHcpINUwM+8iFVuo8YM2V4YqfUvxWfgCgT+GG197j9SGPLJlHF/QTUFCLCkaCLgnkTwKH25UWCKRxylosSjlCnHph0EC81F2VtTJAJKJWuYoMhOIWG3Xg=;24:Ra6RQZW+81tUymYjHBCGXih7o/pUvgSJ/cMoZUj8BvQjdx4t5W6Ivz5LNYiJXbQxSj+kf2X18EA6OaG3pHZ1KexHZ18gebd1jLn4nmYMFxM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:hf7/vkIT3sRFrtogjdd0FLlnOCjojcv9hjVRHaE5XB9x4F5QpVpo5kYDx1ND9wmisrzS+ACWWE8/A0/VD+H2uGPyoeb0OdFcVqSpaeyqWh8E5fyXDNvvUkVV+2cAsBvRuG0BSTPmXMiaTKS8ScBFC24+IiJDSj5nmBZCsiEo4gmSLx2HlyFkxcqcPcEHw/ElmupIZuAF7LmbfVHb9KP/dMcPDpO+cwxVYsRIxlyzGI+P5Q2kdm8avk/DA2dJgRp3
X-MS-Office365-Filtering-Correlation-Id: e802d483-4443-4602-e398-08d5a2fd1587
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:16:58.7413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e802d483-4443-4602-e398-08d5a2fd1587
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Check that new content is valid with respect to the user defined
'working-tree-encoding' attribute.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 61 +++++++++++++++++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh | 62 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/convert.c b/convert.c
index 21d5cb60da..0e7930c154 100644
--- a/convert.c
+++ b/convert.c
@@ -266,6 +266,64 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static int validate_encoding(const char *path, const char *enc,
+		      const char *data, size_t len, int die_on_error)
+{
+	/* We only check for UTF here as UTF?? can be an alias for UTF-?? */
+	if (istarts_with(enc, "UTF")) {
+		/*
+		 * Check for detectable errors in UTF encodings
+		 */
+		if (has_prohibited_utf_bom(enc, data, len)) {
+			const char *error_msg = _(
+				"BOM is prohibited in '%s' if encoded as %s");
+			/*
+			 * This advice is shown for UTF-??BE and UTF-??LE encodings.
+			 * We cut off the last two characters of the encoding name
+			 * to generate the encoding name suitable for BOMs.
+			 */
+			const char *advise_msg = _(
+				"The file '%s' contains a byte order "
+				"mark (BOM). Please use UTF-%s as "
+				"working-tree-encoding.");
+			const char *stripped = NULL;
+			char *upper = xstrdup_toupper(enc);
+			upper[strlen(upper)-2] = '\0';
+			if (!skip_prefix(upper, "UTF-", &stripped))
+				skip_prefix(stripped, "UTF", &stripped);
+			advise(advise_msg, path, stripped);
+			free(upper);
+			if (die_on_error)
+				die(error_msg, path, enc);
+			else {
+				return error(error_msg, path, enc);
+			}
+
+		} else if (is_missing_required_utf_bom(enc, data, len)) {
+			const char *error_msg = _(
+				"BOM is required in '%s' if encoded as %s");
+			const char *advise_msg = _(
+				"The file '%s' is missing a byte order "
+				"mark (BOM). Please use UTF-%sBE or UTF-%sLE "
+				"(depending on the byte order) as "
+				"working-tree-encoding.");
+			const char *stripped = NULL;
+			char *upper = xstrdup_toupper(enc);
+			if (!skip_prefix(upper, "UTF-", &stripped))
+				skip_prefix(stripped, "UTF", &stripped);
+			advise(advise_msg, path, stripped, stripped);
+			free(upper);
+			if (die_on_error)
+				die(error_msg, path, enc);
+			else {
+				return error(error_msg, path, enc);
+			}
+		}
+
+	}
+	return 0;
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -291,6 +349,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (!buf && !src)
 		return 1;
 
+	if (validate_encoding(path, enc, src, src_len, die_on_error))
+		return 0;
+
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 8e574ccdd8..a318d03232 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -62,6 +62,52 @@ test_expect_success 'check $GIT_DIR/info/attributes support' '
 
 for i in 16 32
 do
+	test_expect_success "check prohibited UTF-${i} BOM" '
+		test_when_finished "git reset --hard HEAD" &&
+
+		echo "*.utf${i}be text working-tree-encoding=utf-${i}be" >>.gitattributes &&
+		echo "*.utf${i}le text working-tree-encoding=utf-${i}LE" >>.gitattributes &&
+
+		# Here we add a UTF-16 (resp. UTF-32) files with BOM (big/little-endian)
+		# but we tell Git to treat it as UTF-16BE/UTF-16LE (resp. UTF-32).
+		# In these cases the BOM is prohibited.
+		cp bebom.utf${i}be.raw bebom.utf${i}be &&
+		test_must_fail git add bebom.utf${i}be 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
+
+		cp lebom.utf${i}le.raw lebom.utf${i}be &&
+		test_must_fail git add lebom.utf${i}be 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
+
+		cp bebom.utf${i}be.raw bebom.utf${i}le &&
+		test_must_fail git add bebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
+
+		cp lebom.utf${i}le.raw lebom.utf${i}le &&
+		test_must_fail git add lebom.utf${i}le 2>err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out
+	'
+
+	test_expect_success "check required UTF-${i} BOM" '
+		test_when_finished "git reset --hard HEAD" &&
+
+		echo "*.utf${i} text working-tree-encoding=utf-${i}" >>.gitattributes &&
+
+		cp nobom.utf${i}be.raw nobom.utf${i} &&
+		test_must_fail git add nobom.utf${i} 2>err.out &&
+		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&
+		test_i18ngrep "use UTF-${i}BE or UTF-${i}LE" err.out &&
+
+		cp nobom.utf${i}le.raw nobom.utf${i} &&
+		test_must_fail git add nobom.utf${i} 2>err.out &&
+		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&
+		test_i18ngrep "use UTF-${i}BE or UTF-${i}LE" err.out
+	'
+
 	test_expect_success "eol conversion for UTF-${i} encoded files on checkout" '
 		test_when_finished "rm -f crlf.utf${i}.raw lf.utf${i}.raw" &&
 		test_when_finished "git reset --hard HEAD^" &&
@@ -139,4 +185,20 @@ test_expect_success 'error if encoding round trip is not the same during refresh
 	test_i18ngrep "error: .* overwritten by checkout:" err.out
 '
 
+test_expect_success 'error if encoding garbage is already in Git' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+	test_when_finished "git reset --hard $BEFORE_STATE" &&
+
+	# Skip the UTF-16 filter for the added file
+	# This simulates a Git version that has no checkoutEncoding support
+	cp nobom.utf16be.raw nonsense.utf16 &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	git diff 2>err.out &&
+	test_i18ngrep "error: BOM is required" err.out
+'
+
 test_done
-- 
2.16.2

