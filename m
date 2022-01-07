Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C68C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 09:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346369AbiAGJHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 04:07:45 -0500
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:54319
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236732AbiAGJHo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 04:07:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQX3pwtxTeVIYrdpyHVpgXqkqyrWcnDKNWMzo/mtRs2AHGUQJeqFuwuIK3+xhdChw6eyZatKLiiqeX1EQX4z6wgEMBaT13CY8jyu9E51N0jyCJ08FszYgUaJ+F+U2coYKrtj3A9ifgpEU4p3Ga0YpIpEuFJgySs1NdnEY82H5EGfXp8IGDfgBIkSzrKhxed0OBUiae0YVH2qQHJ8sQ0H0cXfk2ysGPb1tPhPrmPCd1LEKPjO3A6tyhQkYZBqGW1/qTLgrXbFgMuGG/gaIBq1XIyrTZhnK5z8625I3BJo9b0G9wjZAA9EaaQ0WV/w815H0ac/i2XDJl9n96G7L22Zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Can9Yr27xImoBuXhZIAltuBK4HG4pFLK8MkZ2XmranQ=;
 b=H2cGUHda7L+WUvwVxuej/NzPY8fE8TsKHAZDvtrogygQNPMWt5ymr/qNOTcr7iIR8l+xcyp1Enb+XHxK03w2d3GCaoh1EzqXKZrL6SNsqT8esFM4lZlu8w1F4Rlro/n6Efrc7ZPKMh8gZi74l6vNYf6325yCsy161yuqNg596wB+Rul50pscjnmLLDn0UrVDSXj+CZMXZeMighU4EY7WruEXQ4vHhS2PEXwcLqcfQZxcuPJL99yEwi1F5ncaoJFLa7pDhDmurjSihpk1V0VEsE8jrxXlpOptNjM1C63zs82pOWMq4twJ28ADoWionrNFSD7Gb9QkJ3FIzVR5wo+knw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Can9Yr27xImoBuXhZIAltuBK4HG4pFLK8MkZ2XmranQ=;
 b=W6n2sOeWAqUGjnuX2SgX9yNZ2mmgBMyOvurxp6kCAwGCBp3ggk7ldZ63097r8uMxcAJVEpTGE3jce0TbL7TWjak/v3F+N5TE3MPLATVfN+i/dm0nAkCVPJvzcnzUrypBRfpQuKT+kVHZdByauznBe9Vl6oeJAZXJvgTtt1yGFAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 09:07:40 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 09:07:39 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Pedro Martelletto <pedro@yubico.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3] gpg-interface: trim CR from ssh-keygen
Date:   Fri,  7 Jan 2022 10:07:35 +0100
Message-Id: <20220107090735.580225-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220103095337.600536-1-fs@gigacodes.de>
References: <20220103095337.600536-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0060.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aa8a5f0-1724-4a6a-fcce-08d9d1bd27a0
X-MS-TrafficTypeDiagnostic: PAXPR10MB4671:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB4671AA27699250A270FF1712B64D9@PAXPR10MB4671.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELv+2uRyP9/1mYIFHRMXgc7fJtnxi++eG7QK2+7FrwnABLGkdn0+dBbpZvU+YiYvcTcowwhd6YmjNsZLDO1hyQJeus1fpsUQr6dLjlbLfbi650S0w2UYH9ut6ILIMGjWWqx0sKkdNeAGr7/nAqAN1of+AVXHQF2YrPdYJ7Sm1GDpyFBAfL2hXUkhMH+G8GorfWoe7nwbq11vBAGhr1ocWtXxIdeWEJbrBNlRje30SYuZBYoxlJWtsZKewvLBLwyDqxobFGDACob1EjPSXeyDwz4TeNVBx9FqhvJrUsBmzhK9pwP8QTuYczI4P6B9ufYqhSyvB1LXxh3XvoDOz4Wl4eda+IJm59QmHBPllNWNayfAXUau5D+nTmNNIG94Gfp7OZRKVY5oWkTMz87AAek1S5pxwlm88pRmG66VE/O3UFuSUEP5KzJnQ1gnsVGBMKeNQ7pKcOwZIMhlonlFXAbiHwGWkDphtu/HwEX04TDdseY/ETxQpy/biGGy58W4/6heF9PVLaKtSc5Dc9u9CJ9WKwOjYLkY6mFAC9bjCSBQXM/6RzzXDiMf5A63cCcC6E+QudQXoRO3uuwoZEtcEE5AJCn7B7nhlMquicIgEVPSIrfo2r8W7XeqhO0quzDxNjUEPvT3uIUYiFmmKhe7SpR2og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39840400004)(36756003)(83380400001)(86362001)(66556008)(66946007)(66476007)(2616005)(38100700002)(6666004)(6486002)(5660300002)(1076003)(4326008)(6916009)(6506007)(186003)(508600001)(6512007)(8936002)(2906002)(54906003)(26005)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ByTy7617EN0+zsaudmBHDxiMz/Cclj56pMKoxStsBpK4gEi2x770TuXEew9F?=
 =?us-ascii?Q?YSgsS+7iL8i3nHJKoKrZ9XEoLBKQFnGcbCs2+jAt5c7bXtGwakBQUbiVZx+P?=
 =?us-ascii?Q?BHw16qH3WbwQIPkXW2VjAED6VLahR5adZ8Al+Hd0Y0/feZRCxhB6I21Iozpu?=
 =?us-ascii?Q?WyecXfkpdobVnxdF664gJ2wp9A3VNJLq051vtd/NYqHXL+ZLTJUaechO1tJr?=
 =?us-ascii?Q?38/6s1WaAuQAGWKbghLh20QKYmc8ZTH7jgpRHXqEd9NQp37ujN+k/e6VsmZv?=
 =?us-ascii?Q?FPyln1u8rfuPFSktCwxuvY3PFV9CqOZvCkdmfnVlh2neRiL3aj0ly8Uie9v/?=
 =?us-ascii?Q?nFJD3gJqbv/skcmzIu86wev06O49KPgz6GlDteFbFKnodA4pv/8q9zvXK8vm?=
 =?us-ascii?Q?h4I70PbBbp0bT790+A+4qwLL7x7XpJo25a2R5mr9nwRN5rSuj/t+WnPzzrCB?=
 =?us-ascii?Q?t5GrcaBIC2ZU8iDohlTrW8aLzAIUUYYLa4sJ/2LQBU/VMX3ax7ElbbExe4BU?=
 =?us-ascii?Q?5zjoc0OMd8o2ewTVShF4dI2zMDj+6Jli+IT7hxna2KaMcZSGjlZEhehpk1+t?=
 =?us-ascii?Q?TRkGiUWoO+PJtkKA/kqEumk0wc85XY/v2AR1DnLjYhOmtvoTiDqju2HCZh/4?=
 =?us-ascii?Q?Tayn9VlE57+PC53HkD0P1uvdrzg9uXu1IyaaaX15B4SA8eiMddYHkBtnTaTD?=
 =?us-ascii?Q?/SCIUQUo0C+4x4Yrx1sFvuaUY8KZoPqmvr7mc3epdy7uWKU9HetcUwXQ31bw?=
 =?us-ascii?Q?g86LL2Tqlq63PCKWyjEFRwomWJ5RWputq8twGCi/4y4UTkHVDJj6d1F9PYXk?=
 =?us-ascii?Q?wHwVOviZQPaYIi3ii94KFx37ereBBr+302Nj7b25G/MLHkLcV2MmaR5ihct9?=
 =?us-ascii?Q?ltDn9PppFWoeZbBeaEusQF/+9+PdCONyLmZbGQJvKcFWJD4XDRB/XH3JyhW3?=
 =?us-ascii?Q?X+uvbL/gjO4Kij4zdhKeRJnHlEJ7rhNyzG2KIW3/T6KcYj3hSHXnw0z7sVwd?=
 =?us-ascii?Q?GKrHTBnrXiwG8BtNL81oU2F9I9Qnf15qgtRTXHkFFUVwgyDVq/TkNgdZqsBk?=
 =?us-ascii?Q?lf96f1/6hcyw9OOCozauKQlwgsdfyOhD+sAvtqCTbaOAR4lajAMmKSAzuqXB?=
 =?us-ascii?Q?RdA1KK4en1kMjI7d8nu/IOPxePvzeascjEQ+cLZtpCkFD8JaC19NlZHLYLKB?=
 =?us-ascii?Q?Q+tGtjmYdsWVYqhenvtBxfrb5jLu/UZypSLIsNH78eIMPnSAmidNBN3Wawwk?=
 =?us-ascii?Q?NI+oPW74DawBOmrsvgURyGMTBXCBr+b4VAuiEEKEpquNcuPcDv/McV+M5CVE?=
 =?us-ascii?Q?867bLT4CoW9uMzdSusV14eJV3wf3B7EUoYs2aGil5HfXiss0HvGK512p3//3?=
 =?us-ascii?Q?LUIzp1gzUHr2VITZ3KeDefNgikVZSXFgFpZ5w+V507tDb5JDOsvF8AVRKRzt?=
 =?us-ascii?Q?1nNEUrwpFtQtZpne6ioRrKSfqh1z2SJjvwbE3/IPobO2p5Hh1ExsMrFuiLJP?=
 =?us-ascii?Q?SJpcnyQWkGXnroD7CEN3Ce0taJtZAB5LqKG5d4u+JZlzCXq3ZXuJLMAcE2J2?=
 =?us-ascii?Q?FD3WMy/ltrXF/51uHhFnSzP8aJaNlr/XdsKoCl8pKsFmxhndXo1pVDYp5VD6?=
 =?us-ascii?Q?fD884tHxs9oD4N6ryQ0/OV4hW5WL8d5l8I0Q4SaIbHR5bVJcysFhoAB29CEP?=
 =?us-ascii?Q?WTIhK4iWWt3bg1sOCSBEo+WOxuA=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa8a5f0-1724-4a6a-fcce-08d9d1bd27a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 09:07:39.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5+930rj7k9g8zwZfs5k1q+LAsxh5EMej7ZSxi9/tNk8twlBHn0KqA1Fyeoj91bZg4IOSzQLZbaVrNGXyonlp/0phOhYCfUbYIFT4xtbhAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4671
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms
this hypothesis. Signature verification passes with the fix.

Helped-by: Pedro Martelletto <pedro@yubico.com>
Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index b52eb0e2e0..17b1e44baa 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -433,7 +433,6 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	struct tempfile *buffer_file;
 	int ret = -1;
 	const char *line;
-	size_t trust_size;
 	char *principal;
 	struct strbuf ssh_principals_out = STRBUF_INIT;
 	struct strbuf ssh_principals_err = STRBUF_INIT;
@@ -502,15 +501,30 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		ret = -1;
 	} else {
 		/* Check every principal we found (one per line) */
-		for (line = ssh_principals_out.buf; *line;
-		     line = strchrnul(line + 1, '\n')) {
-			while (*line == '\n')
-				line++;
-			if (!*line)
-				break;
-
-			trust_size = strcspn(line, "\n");
-			principal = xmemdupz(line, trust_size);
+		const char *next;
+		for (line = ssh_principals_out.buf;
+		     *line;
+		     line = next) {
+			const char *end_of_text;
+
+			next = end_of_text = strchrnul(line, '\n');
+
+			 /* Did we find a LF, and did we have CR before it? */
+			if (*end_of_text &&
+			    line < end_of_text &&
+			    end_of_text[-1] == '\r')
+				end_of_text--;
+
+			/* Unless we hit NUL, skip over the LF we found */
+			if (*next)
+				next++;
+
+			/* Not all lines are data.  Skip empty ones */
+			if (line == end_of_text)
+				continue;
+
+			/* We now know we have an non-empty line. Process it */
+			principal = xmemdupz(line, end_of_text - line);
 
 			child_process_init(&ssh_keygen);
 			strbuf_release(&ssh_keygen_out);
-- 
2.33.1

