Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B7C1F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeAFAtE (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:49:04 -0500
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:14272
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753459AbeAFAs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rQ44kwSNrsr8YquZy4C9fLNFBs2xMtJHSPcCJLN6AmA=;
 b=jh+lH4EBFQAgOQngJqIozMK8HA3L1XfqQKpxknVCDtIrZeFOR192lJ3byr5oFUawMD342/SDpwmCcbAdWeupho9RGmptgtd35rLmwY5NwS7xQgpw9o/XoO5epcpoHTf3OiZVkfwEAZtjY/+7qFr35gBU9OxLksvlTgXotWYeJGQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.88.245) by
 CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.386.7; Sat, 6 Jan 2018 00:48:56 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 7/7] convert: add tracing for checkout-encoding
Date:   Sat,  6 Jan 2018 01:48:08 +0100
Message-Id: <20180106004808.77513-8-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180106004808.77513-1-lars.schneider@autodesk.com>
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.88.245]
X-ClientProxiedBy: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (10.167.35.16) To CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fd06e6e-bd6f-426f-0bba-08d5549f458c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY4P136MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;3:YB8ZuN+xhdLrPvHWe3VJnkq8YNEanZXp6NyRhFWcsTAmYHkSKnXqn2NvLZcx3jcTCcTRGMJ6yjEK3OmkOlPAafI2EHS5u5KhVc8fxOieXVI09T+sojVNVmSVkbhmacY8YP7bU08GjysbZxE+5vwTtWrJ8DeUIn1M+jVVazL0dqgfyXvq0EUHgiSoygOifdKYMPQLCglZ6Tp2ISEZ+D/ILV+Zlw7CnoOO12N15TKJGntfDajr/Kd28/yJODo/egJ8;25:scI/QAOqBCTZVNuzLRn/1NQoW0USKmN/oAocqe8Z2709E9Cq6VYYbYhshu4juuXD/DRmC9APZyzuu0NamazWEUpMKT76GKonwc3Fs7hcyckqN9Ahu7K6eCYjHbl3P5BhPZTV8vxIyYo/jWTEXG3pY+k1dpqFu7bMs4f7zuM0VLHN5XyekJzw3fyVkgB6d0qYNCtTSmTRWXEDHzVGAI4YViR3uvl9WshCICeO/nAGMjjWQvtKu29JR25q/NgoamntaDS2Z37mJiZ48gDwdZwJtWOM8ifgoAZ1Cgr1dh/UMMhoXvh8Q5INCr7zjrJUkeJSnOSWjmepYhQMfQ9vXdtUdA==;31:PwAFY42hyROCbcTkAm2+01HT0jZtBWEUAZlf6dlb5zlQwlOK8fFxy8FbH/lzeNuqBpgYuoA10ds/UOAPg/VDVI27g0P98+1iCIn8DXZUEDMxF/nzJWnrI00L+tFQ4AMVamhcc3bAFLUYP2dvAkedCaQLx65FzgMcVlQTDnrwXoTxBqEYLsBxatbQmNo8Jn7zVFbKI/TY2xuGivOxgCbWi2fO6vG9WX6pU12wGsCdUFA=
X-MS-TrafficTypeDiagnostic: CY4P136MB0021:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;20:0XMNU0JXY6cYalEaQ0qgWlOxkQB84QgdqAtrkfVaCi1HJu6EDLJh3OsFgFePQ6TP83+aTj+h94HUDY273AsIMGH6834PTz/tNQN/miIAg6WfYdt98DG2YmASKQlzQSFg7EXlNJv0W8t39zmSW8y1O7TkSoSYTU3b8yLEZTfda24jJp6pcdj0gPqYlH1weQuqMgtnR5wncM+xnAEVsnSS+GwkJFCBCqBtBKr0cO8K76qSVi4TbZLki7CGw5BLJfvnkDdr415EV2zEb0XkuV8Z5Fht/YAXY7sSPvCfsNm4RZzDo80CZNV0ldG/15YdY388w1P8905Mt204sl/eHKSdokWf0hu1x3XNydVuj1C3sVPsLeVqUzjZGfwcu2Rjpk5fLI5rOnF5pSIK0aAziBzSaV7QDv0xb1X345Q7dZCn6tlkq1XZRBUm2/xwa681mY76204Iuf039cT8pbZ82vfrkTPC6tgevqX8Ngw389IiPiSFU5UgrP3s8c3LZ75TSVjxNjuFfKmJv5SCUuBgxlA0PTkxLpCMXWUDXKz8mSnzWppxSLPBRZWeXFhngyW+LxWTchLxR3gR5V7Axcp7kkPwCqzqhtelWgq69agBeiGyAwo=;4:y4xMuhP+6fObEdRd+Z2beTZuW59lBKs0lkptduXVx3oEF7fFaarTLe1AwUAMiGYHeqWmHaDRmxgRymInMJno+1zvB/LqHgxNp4JbjKT7KYYk6zk4hUlzXI6O7dk4vpgyaVUx0l5qRbtJ7+gxt5qJbbW2eicKRCSv2n9+NOhO4iUE/qKf6ByDJumWVXRSyvGE3/ljpPRuqc6SS85LN3OJ+TRr3qycPUSJO0d9xKrKUTZY9EkV6l9rSTGvlBqBziU2PSbwU3pP/LzY3obb+TMsAA==
X-Microsoft-Antispam-PRVS: <CY4P136MB002133336D32B68FD4C7C492E81D0@CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4P136MB0021;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0021;
X-Forefront-PRVS: 0544D934E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(189003)(199004)(5660300001)(2950100002)(6916009)(86362001)(478600001)(6666003)(50466002)(97736004)(106356001)(52116002)(2351001)(6512007)(53936002)(7736002)(50226002)(2361001)(6116002)(3846002)(305945005)(105586002)(1076002)(85782001)(9686003)(4326008)(8656006)(66066001)(33896004)(16586007)(316002)(6506007)(68736007)(2906002)(51416003)(69596002)(39060400002)(76176011)(8666007)(386003)(6486002)(53416004)(8936002)(48376002)(25786009)(16526018)(81166006)(81156014)(36756003)(8676002)(47776003)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0021;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0021;23:Or/x4hac1FOsox8A7+O1sIdHEJUG58KIgWT8gtMNO?=
 =?us-ascii?Q?alYRzVG1E1nEnL/UpSycZ53q280PhHUnaHJb+l5A1d+irtSajGMRfJNaCNna?=
 =?us-ascii?Q?IGRxVotibWgGCWg0GrbbI/Fuxtw87FhhBShcNUv/VGgU5wNWwEprKKH7sTHn?=
 =?us-ascii?Q?SFQmV34ghH1KmILMBlPOcxJvKo4rfxWBJj10l28dk2OZddHl18fFZrqio1eG?=
 =?us-ascii?Q?z1FYVBL9fxnYgtZ1iw+YKT8syqu/jiWsKv50phhRlExsOe3PABIR8ULfEpx1?=
 =?us-ascii?Q?mZYnjxlQm+JHAKf/sMCsryOlyMJ+AeUoQSGtEjnWA3/55nFSnVCTtxwopouS?=
 =?us-ascii?Q?E3+u4TrdKRirUJzVAsQP8vIqvqUkwd9kRVcIvc4DL4HRniSzuGmFQ8+aNC6j?=
 =?us-ascii?Q?fo+cG2kThb9dA4WcgnSY5sFaRaXSfOwEJherr5sp7mlnPvACOyuO53RfCnl4?=
 =?us-ascii?Q?bHeOAGFtDJJXoI7oexgTmmFrU1kyzFvwhnFhgJCWN0oqT9ysyyBCMxQORfPk?=
 =?us-ascii?Q?wt8gibBzmZwpUgOZJZyaxSf3v69amiEDpSvhRmDCX4Y4jQ/hWxXfj3lhRp8X?=
 =?us-ascii?Q?b+oo1Yd78X5EJ9cW93+aJK76H4I5Ee5X6yP72GzWZtFN7f466xhbpGQPDodr?=
 =?us-ascii?Q?jH9FUUxfZk84q+5p1PIkYZWXS6soDpeZ6C81TNTMEocq9XMBQisPK5dLz/ZO?=
 =?us-ascii?Q?H0HyxMA0xStWe32T3I/Npr+hUmmQJv6cNpwJPHQKAeTIqM9Q1nE0ORq2ew9m?=
 =?us-ascii?Q?bTnkg4whmkV+/pGxxiQiV0+k2suT7BhSHuiRhrYsKGYxCxjwLfL699oJc3N3?=
 =?us-ascii?Q?5ypJrpXctfj3GazGEi4nWc0JSn9qjO2mn4jGFDouBxlpWxGFkxq5OAWWSzIB?=
 =?us-ascii?Q?ZpyFEK8fM1MS8+XC37FOYSHEUdzqd3DV2A/tB1jM2rKZdyOkl/uJC/LZqi4n?=
 =?us-ascii?Q?PN6yiLqFctyx8taSYJ82iOI3gqyZHgNhr4qvZ/ZaQ0HNIvvRS2lwFaii17Yg?=
 =?us-ascii?Q?ucBgOOtsB+Rp7oGaAoHU15obOHAVL9GAQ8VoZS4aGB7b/nSSXx4OjXxZ2lif?=
 =?us-ascii?Q?M23WcY2v+kqwZSR1WYy/OpQk1ZdSz52Z4kh+lAEOh/XeKe1uL9mJqGAok8KG?=
 =?us-ascii?Q?RndzFa4MZqbhXHia8nfVg5csAEWfEBV5INm0Zph0xRDdiuq69/9LZBoVVMnU?=
 =?us-ascii?Q?OHfo53VZvtQpxZNO5l6c0FOdDLcaCoQ5Qtxe7w86ELsl4rIdpUjfHJdith5O?=
 =?us-ascii?Q?EcepQjF14nimwMrxqENEILX52OWbILPvmyKtGLiBjZ/ZYoeo5aen6oVdrQZ1?=
 =?us-ascii?Q?NqPqXFR9qu0Uvh2ywtiC+8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;6:oHfcQOfg4kSwCDBFV1228suRhb8uE+lnv5WH3TXYfp7ljrNyWdTQegkayEw9b4sQUvlDq13lTNRaPSAo95DjBqSFNxS6aKtl/aUpecR24ud4pudYD9lSNKhbB/dLtID2or08BJI8HIroI1fmc6t24qJbbanfkzmq0Srdy859Ja+6UXwFCCAPGuqsxMMnP15GRUdiHy6jaHsIZGaf7Gqc3LXTJ791p1JLMQosEgJ+GiQbUy4rrSy+ey5KBtXXT/hKkkCMCvFg3V2DdTwM/J0Vfdqki8tRR+sq/bWRGSizLI6npncxKnu/k05t6a1MfJ5vMVmKicG8vsGV3TgY4G14Iyz2UTerjYZfJIXOCsf4i3s=;5:JQh/oiAH2jkmlm/cG3YxsvjGlkjWebbPQPxqhgB1mGSNm25tS93nIQ7KBxcrXdsHpX7+BDp8FbYiIzdxQPwCI/QKaByzk2VtXb0aopdOufmEUazhGqLl+0L2BG+A/kmNXsQzPO9xe6VtuTqrmDjLa1h0Q13tvGHLd0jrpshmAk8=;24:0NyCXdXBbqKoy+tLGm4gbQ6bzgeD7gGuhpuMz/38aW8jhy7466g7yxzgRPSN8vP+XSNNy6VwNaIUQnn+rgPdwn5jtjn81mg3XMR5f9rvchk=;7:mYg/hkib6AfNNaJYNk5j5H/nw4AM378qt5P3eXyRfMjRF1c6HzGF8ixyjc8iEWxJbWupXX7U7fqVau3xW0Uxu06jag5ZvKLBlxAPnIzo4mHrr+9H6+BWoP7v5TX/nUJe+sMmvPxzywb2pR2x2YRhyTeLsUf4P6V6bAO7c7CnhSHOwsuNxf7r4vVNYuRLc11/pmohHK7fTTkktXJVEFayXMmDwmEnru34yNT+GwGCpuxr+VYWbYj6YNfxTaqdPLsG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2018 00:48:56.1444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd06e6e-bd6f-426f-0bba-08d5549f458c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the GIT_TRACE_CHECKOUT_ENCODING environment variable to enable
tracing for content that is reencoded with the checkout-encoding
attribute.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                    | 28 ++++++++++++++++++++++++++++
 t/t0028-checkout-encoding.sh |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/convert.c b/convert.c
index 13f766d2a2..525958bb56 100644
--- a/convert.c
+++ b/convert.c
@@ -257,6 +257,29 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static void trace_encoding(const char *context, const char *path,
+			   const char *encoding, const char *buf, size_t len)
+{
+	static struct trace_key coe = TRACE_KEY_INIT(CHECKOUT_ENCODING);
+	struct strbuf trace = STRBUF_INIT;
+	int i;
+
+	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
+	for (i = 0; i < len && buf; ++i) {
+		strbuf_addf(
+			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			i,
+			(unsigned char) buf[i],
+			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
+		);
+	}
+	strbuf_addchars(&trace, '\n', 1);
+
+	trace_strbuf(&coe, &trace);
+	strbuf_release(&trace);
+}
+
 static struct encoding {
 	const char *name;
 	struct encoding *next;
@@ -316,6 +339,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			error(error_msg, path, enc->name);
 	}
 
+	trace_encoding("source", path, enc->name, src, src_len);
 	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
 				  &dst_len);
 	if (!dst) {
@@ -331,6 +355,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		else
 			error(msg, path, enc->name, default_encoding);
 	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
 	/*
 	 * UTF supports lossless round tripping [1]. UTF to other encoding are
@@ -356,6 +381,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 					     enc->name, default_encoding,
 					     &re_src_len);
 
+		trace_encoding("reencoded source", path, enc->name,
+			       re_src, re_src_len);
+
 		if (!re_src || src_len != re_src_len ||
 		    memcmp(src, re_src, src_len)) {
 			const char* msg = _("encoding '%s' from %s to %s and "
diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-checkout-encoding.sh
index 3a9951fdf3..5f1c911c07 100755
--- a/t/t0028-checkout-encoding.sh
+++ b/t/t0028-checkout-encoding.sh
@@ -4,6 +4,8 @@ test_description='checkout-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_CHECKOUT_ENCODING=1 && export GIT_TRACE_CHECKOUT_ENCODING
+
 test_expect_success 'setup test repo' '
 	git config core.eol lf &&
 
-- 
2.15.1

