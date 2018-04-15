Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1925E1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeDOSQx (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:16:53 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:20891
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752776AbeDOSQu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=x1nwvMh+Iu/xy/BFho28LRRIuKvPsHMm/6GOZ/Bb9Cc=;
 b=O74PV7furHQXXPcfPC3Sh7uDNWKMSBi9b4lf0StPeS/6CEzCQwsHgbUU5RZmMnSRRZUZF7N74ybqgaRk0jpS4o+rS8C0s3UK3iJNvy6c51L2FgKQp3H6a6uEO/quIdlzChOtNvT6pvYzYb1e0J3+uS/1ZonPAKzOoHXQv2m+OoI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:16:45 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 04/10] utf8: teach same_encoding() alternative UTF encoding names
Date:   Sun, 15 Apr 2018 20:16:04 +0200
Message-Id: <20180415181610.1612-5-lars.schneider@autodesk.com>
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
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:ERlHBcoqpqaN/9eVyhBp5dc8H2wwIxVw79dqtqXwZEPmxzXDzS5C8NcSIej1iktg74+NKa9OpCoB4AzpXYQdXlRR+h5vKIgjbxhVPNtsss9WUd4J5YlBKP9ouVNS3VNCTCrh+uz1Fm0CgnXmxwKxgW6Fe1TrPBSbu79VkUWGTHwgPZr9oqFK859Rz8Zs9F562xcankUBs5mmZz1ZVcXegVKMKaZiNbSrtJ9E7AwmnScut2bSX2GdTC0OAjNyD0bH;25:6qA69wRktKymxYJblyz1diVv+Rbk1T/QvNfoxfpURIfpybi0+1P5VS6GxjHT/nuDjgsc4s16EW7f1uUzZFuBbMZ/IiV0X/thMk305fQAU+giKmKTGCJ+yXWGiYgDFXfyrBB96HQxuZv95zjerpwq93A/qYtOGdOoUHX04/6WXdn/Pan29cp2bpq/+5LwQkNwskYRsCPm37qlpXiAh1/lSEprbdVeDm0IgybHF61OrENfTl0QXvU6hCIeBzaGE3KIfJyWpWTSHQSWB7f+ElMHKv8LJE3y4HE8qOZM7qTvLbDeSZuLGyQuJDh5qvUyEbId4OrLdE3av+svO/3l0fIrrA==;31:0v4fSrygLoUCxIfDUC8DqFlD+nN8D+oEgdv4bffw//dNjhYUh3EoFOjxqP0SecqqxZTGIxeQtMmn3h2ZcyFGyE/ry8uUamyWV0Glzh4qn8Yggs20gugSjE32iVEgQoZa5PCu8+nlsuXwJkEy1N1N6RJyuFYNQGjW2A8Odjsu2/prRCbdCKgn6NkZgggCEUF1o1w3jfHwxrFaSWqpDm5Hc70cf7j23bmUVOWkK/lqGeA=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:BNxVI4min1ugnxN+Cedfze2FFLSbtL1i7ElCTvkBUJjB3Z+J/GF+ENtj6XOjURDs39uzVd3EFW4JDjQctrb1HDKq7M7KyWxqxjgJyw2MRMovAHxv/Vs4NmVY9Y4V2q3oxxotpi+9+7Lw21e67LrXJYWb6F9H9EdclDfSLhSOIJmfxd9/x0PzeRA1oS2j19IdS1BsaU6goZajXq8ZBXyS+Y3UZYQQoDOaY/4lgoL0Hb3M34NHyomEtBS/BX3U1UWV/3qQylutqx7T/7DBfqFLVX3TREun/4QM3WWRacQDNdGJ4jYAl/HepcQ93Df+w5IH1vo6iH85NpwVX59TLEuf89d4ID5wZEcro/6rGA2mTV4Kyh0wLi73jmfbD3afY6QRAGmz4N9qFxdo6F7q4q4OeqWzmwk7V9Qo3upsWgkdglyTARJ8Gee5kUAQc0miUTTL1y5Jn8PQGDN28RWNDFvG9jGHzqbBLdstMt2WCS2eQtU4hxyIx16xmnYTgNTCTZkP6GmcuQ9O1+wSboTJMtTRH3iHM+GU+jXAPLTyqkAX6qcXysis5tXvINpV9GYmTHah06EJpvsGhSC4FOIWhfPsuVArg3l5BQMpNJra7aww6Ps=;4:eN/q353lKBJQZ9dl/y4gSDxcx/gKyPRAjMOdiLGBtqHeT3X+sFR3/guTSaDno7H5qNRqQJhfzko1kZbLT43C+JP5pPhZ4h3dSxK3PsW7VRgdxglcZzUJaYLBBkGmyexg70Mp4wmV2rUJiO3trw1/FBxLGBbv1/09OJWuOT2r2Qw9oGJDwG3Azat0Kkt9YI8DieYOgtpJR47+ZXManlvBoglYwStlflYnpXhzJf0ePqRPff8QdLQ52Xg9YITm9oPsPM0mnfoQrtC1qnPMSahkVkuYlrhnhNQoZe9d2DhP/bH0UaZ572Uldc/BTtvbnRi6
X-Microsoft-Antispam-PRVS: <MWHP136MB00141AC82B9D9FA755761099E8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(9686003)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(50466002)(26005)(68736007)(16526019)(186003)(85782001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:IF0ZQ4JP/Kj8/4vYGOwqxY7UUOkTfcN2GVKRwLik/?=
 =?us-ascii?Q?JND+ZZ1ZNC773VAel0OeX+naxhRNjD1y/JsjxTnGW7fqc44tMByx9M3Xywyk?=
 =?us-ascii?Q?F0gKCfyO/An+D0BJ03NNENQUMliI5H2Z+hfwUAyaCGnEjapw3n2E78N8t2yq?=
 =?us-ascii?Q?MndGpagQ5uSQSXHptAwPUKNCJO0+uGX3XCKLqk1wU9w5Mbs8fihApK/ulc8u?=
 =?us-ascii?Q?dg2FVxG0dVAwK5iEOi7FKGWWIT/Wm1qA5Ui4BMZxPizwhffyZOTJ+rGxLmak?=
 =?us-ascii?Q?H6Vg/pmQeak8W1tFRBXQ9IXSrAFYp5iPIrtFTnG4+HYZwYHiAjyxVqSVaoco?=
 =?us-ascii?Q?ELlSF+RezUvQ7p5ALygEuP3NcU1aDcnCO+a9RP9Hz2+iizARaByD2ja7UXHh?=
 =?us-ascii?Q?+Cuf+1/w12toM6a+DlzkZeIB06331fkGaCUxkQ3G2wvA4bSCWxO2bxm19teT?=
 =?us-ascii?Q?g1SsMz9iu5ZijHhUXVby0H6hZzXRmCUelPQAizgv6IJQdOUchfbgknrqTfiP?=
 =?us-ascii?Q?stT6s8aCRJXTZwn7iv09NwbpfDs+k/8qF4b3StdFUntB/FflI42hP2jN2Wng?=
 =?us-ascii?Q?qHGEB2AnhvXZmWaVj8evgDt5M1lSocsZVGDoqv6n9LERdCTqthMq61KnMyYJ?=
 =?us-ascii?Q?w3Y6nGgfeybZ2GzGQ2BuXiokRKCxsGoLvag9eCw6ck8/d/XvmbQPOaCytIWb?=
 =?us-ascii?Q?sn6f1fw+p8EGeLspDm2EQjnSAi+0my/jYZr4T2fLoVwR+OcNtwZmy9MYeqFG?=
 =?us-ascii?Q?flJXUzZX3sfVxD6efdIteRHFZbM2kC3T5+I86aRCiEj4earWqpmg7VujzdiA?=
 =?us-ascii?Q?cAPqIPXGBU1qPgkGFMsYrEfrLGPnho5ZU8+QP/nBBaxIl5PRy3ODoKEJt0Eg?=
 =?us-ascii?Q?t+aTjOXOR5E0CZTj0ftlpXyzhfZ79c9o6pWlCZTawwZY18pj9Eyoj7HY4jzV?=
 =?us-ascii?Q?n8/78YM/wu2fzw3ThV/hegV/2FgdjCD6VrOyyWc9LOuJjGHONu4aeW4nWxcs?=
 =?us-ascii?Q?GKyJeTBbM8KNh14RGZWnZO/4LheJwlcaNniuTJZm8DLVJcW6lIKOYJuEuso1?=
 =?us-ascii?Q?cI1BB59f9NbOElyNU6hiwJRhvmyO9rfIUaTPDg0ojdO4llLOf3mU/QtM1J6o?=
 =?us-ascii?Q?2O9C22GbpFaDImGzXkWHD1MaJHvRCBkLRmNesGvB4Nm1PGf0m8IpD5VY7zNs?=
 =?us-ascii?Q?UdSZD2RIm9eumfefN4fPz/1vwXIeUIQIChNvkzMMWbals+atHXWu8PKvAaZu?=
 =?us-ascii?Q?PaEBjSIeAoOUULwGYnn+eNk29flsrIwUbky95pss0ycRQ3I1sQiCFnEzod0g?=
 =?us-ascii?Q?bRCGoNAhQ6NhFKiRoA6O5durCIvda/CBotSdzcOqpYI88F8hiVnqZ4GkgORc?=
 =?us-ascii?Q?a2drw=3D=3D?=
X-Microsoft-Antispam-Message-Info: ORmYl9BcM4ysHs9pIDHnFFrrPfqdTC2HZHhmIqHgrPKHxDfADtzsn5acwCMhm8CZ9tS9y62yCYacTyGxRTqgGle97n2NzObPw9wSX4etSqEhhwylNqjODnppF7eIkEqwAokXWTI+Gt1MwdlEy4ONBAKTkZDsdE0EfN/HhA0rW1U6A+tYu7ErKnfWSs6t1pgL
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:nypw0gLAU7m4e9LhcQ2nIOuWnqiosOCLNo1YbdHifrOl4kdS84utOtYGEpDtqAe70fjWFz2QXWeYS6J3Kdej7Qv4ToC+6xgOAjqbEVTloc46VdjjsLElOFxCEzKE6E7I+U2SmbIZ0Nqqw25DFhZYUuf6sJmSt3BN1kmJQhCH4FzFpPIYm7xdA7ltPNPZHdztDsAcBpO/DfhK+QkGmJPXPcUWeQEH3oIOg/y5LBr+SQuwvCDAPfgL3kRuU3JY5X3oixDrxIAC3YsyPWm7kvf0P6BjttE5PI2vBoHIgcoLmhaQN4bH/hqokYGYHMikuVckV77Am027+d/UmKaAX1l/ckqRGVSmi9rj07lBartU8Cqh82ad1zJz7Fy5+PDJ/TVJoKS/kTR1NQ0MnSgTt80QwGbj5nUJi5j5WJleMXR3jXYue2/euOwb19+hxt3TUQ9WjYN6u5Rbxgm1rykYtfCf9Q==;5:R4JdzGnpck1eQHun04ZJpkDXC1dKeVGLJWz678w5q6rKuiBmH+L/h0foLbalOvVtCvGw1UHRVDOo13jRk2IWxOuktN3f47FPyYAO6gT8afuObRPzc7zm0EpnQ1IafjZrdybZZfoz9HDT8MR8qXZ+AhmU2VU9V623cI6d2mrPEYo=;24:yDvhqD02c0b2mlX8hBW4YHv2d9XRVpf4UU49KiIpwa5/xOs753W7VcQRoGRKWx5E7nAHO1F/92+q1KFDHSc1kjVhzr1A8Y/uRd4XA/fV/iE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:gpDc9QyVFAYRSjwdy2EUrcua5nOGpnxYi5KS3AHESghG81ZUmwUnKrW3b0mwyCo50xWGweYW3bEA0ehPM0Z4Ab0xV+lAGh074b8FAYnamAxyUF+wpTBWvRpjbp0WbI2Iyuo9Zb06rgeQ/LEx2s+brAEj4auauhTymVaShiozXxkGU+4fSM1xR6XGeymFDQYAihKgfVxJI3f4WBwCvWGWYukmUkBpRrYrFXhWxjRznwcA/4zG9lBcvRva6c5lop1v
X-MS-Office365-Filtering-Correlation-Id: ca6ea756-87a9-4772-409d-08d5a2fd0d9d
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:16:45.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6ea756-87a9-4772-409d-08d5a2fd0d9d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The function same_encoding() could only recognize alternative names for
UTF-8 encodings. Teach it to recognize all kinds of alternative UTF
encoding names (e.g. utf16).

While we are at it, fix a crash that would occur if same_encoding() was
called with a NULL argument and a non-NULL argument.

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 utf8.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index 2c27ce0137..40f4b142d6 100644
--- a/utf8.c
+++ b/utf8.c
@@ -401,18 +401,40 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
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
 
 int same_encoding(const char *src, const char *dst)
 {
-	if (is_encoding_utf8(src) && is_encoding_utf8(dst))
+	static const char utf8[] = "UTF-8";
+
+	if (!src)
+		src = utf8;
+	if (!dst)
+		dst = utf8;
+	if (same_utf_encoding(src, dst))
 		return 1;
 	return !strcasecmp(src, dst);
 }
-- 
2.16.2

