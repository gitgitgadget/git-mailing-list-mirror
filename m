Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375A11F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBIN3K (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:29:10 -0500
Received: from mail-dm3nam03on0118.outbound.protection.outlook.com ([104.47.41.118]:18893
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751280AbeBIN3I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VrtP9oeKCBwuusVM0Z4SIpY3APOG2c0Pvvza42tWEuA=;
 b=MXBsY5ySAzMv8+ryQJhp9QRL1Shilp8njuzBXvXtblrXqlun7AnO+Hk0UKLuwgbXj4mvOlY8Fr1UB8Yc+0m+qlBexHdbY472nRGzdmQXYGN7wQ3HuA3WKH3EuG4M816bUb1EkTcHDikG8VfY5jtBMXjkKQM6lwmeR7kMVgnFb34=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Fri, 9 Feb 2018 13:29:03 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 6/7] convert: add tracing for 'working-tree-encoding' attribute
Date:   Fri,  9 Feb 2018 14:28:29 +0100
Message-Id: <20180209132830.55385-7-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 037458c9-6941-4bb8-0e8a-08d56fc117d5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;3:p0mf1pgyxBY7meaY5bHUioqfPiXc7vA/uYpPVrqX3PLp/MMr0Uot+5YSHuMsZGq0T/rnYpiJGdSNKbdOZCcvASZtbo7m+pxjK3n1LzCMonpqFNBm32ng9cm8O1VWuumYdLy/Y8i2WnIHkWvBlUiFARUgYZZdhrGMlTkMmIj6AN2PXC6CHrglEW+RKu9lx1pZm4S4RfPAOd7h9WxEIP3sFKq7T1xYXvhXJ9jX2Y8y3tzuaF4Tu4V750AWrC9il4D+;25:fWn3WDJY9C9TPfqkGFdLsWPZRJGpSZqB5WoguZYzfDV4mpKJ/S8dcrlr1Vsu1O+DtPqoiDyXEE6npVMf+xQQPj5i8a0KY/Hp2OjNxFsRHomzivRyFLHvpXGDBNgqHHFX3hIZMxkGDRIsi3aLLn6+XY6b+zhUGBZqJX9dDUM/Z2zOTD4RD9eWBRM8w4v3vcI2MiVvfNA3tSXxn+SP5+vDJnkW/5o6oUs6qqPmn12MDaThdScSiUUR9P5Ty1F9tKwqaVwMBhAaIfuzL/Og/PLWeBJpSLUTXspzs/n/TeuVrnlMhm+6wv+b+KM/fSzoWZT1ZbZ5xYXSNdDUWHRnaFtCAw==;31:sKj/P2YRPbfkpQQP8Poco3JQ6KTRczXJXlenEfquVHRehnl+JPDPeT8qiNK0z740RCHi0etLc6RTRJHwRWTH/Un6IuphvBwr+prFnwQUTCjGhXNX/sDIP1CzmOliTLqa4Oy0am0EipF5O5kPjtTK9QD7maNHkW/iQlQMYtzYuUqLz/mPD/KYcRHzVqcSc/URjav63tSIZQjhGVWoRmJUX9Mo7IVj2se9ARAdRBF/kh4=
X-MS-TrafficTypeDiagnostic: DM5P136MB0028:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;20:61jfo0AVfTXTNlTregGgh1v3dEFg0emHTPWTdgbH9nG8rYz7utsb3kXT3Elxhiw4RYFvT6i29P0Q4gbOAW5THbp042kZ7UnbIQGAWwVxaDalomHvvDa12C3VICQEVcHJcZMhvfghQ2sJpWqEjUJQ3BNJTme3r9WDrRIvGOmDKYQjRdNqz29JRJq8dL6Zua/6BV50bSxHKyRrCeQUzcbNL+twDAMJcljOpCDwxlEE8nYCTTwKPT5AJ1e3F3Z+fMm1qtVmteRcjPGGQ9x/ooTy211HZCH1LkDphSYXSPBtXnjsbY7Hhf0I1Y5hvSlZHju5a51uh+QIK11L85Msv6vqwJiWsPVRmWY5+LCeYmZXtdIG00FIU4jD0XuGqFrIAd8GMa0yAO5mI3rNCQ9/YTQpNB/+YXEVSvSjGYSojMIcpae2dAZxpLKSvoCcscIFW7yVVcjmSguU7s+VDSvRmMRLnrsdiX6HnUTNQ1pcS3HcUbUbXoiym5qgutRsqvf4LkYeQf3xqbQOdPpfx+3MLO30cf1nJLh0g8lwSgO5EoJfmZPiUi+o5591h83/kC3TWXnr3HIqq4JV/lNROclQDPp7eWuNMiOVq9zaqB1wAXfodYY=;4:GbaBTOtiKd5fBsIXSfGDV1311uAKgJxMWKelHfuXzr2ASM0pLby99kEgyq+znUAj/PIpn+x4FreyuW6Xo9uLeJeC11waj48+DCaSa3Et3FM26O1E0AygdraYCGP/KlDMoSybX1RnlzGgeppbJK8bJBQqiojUI+FAh8wNONnAlCesXMM+67boxwP5pc9HKPm/9FeZaBC02FxATgX8nAc/lo3KXe8tASiDhQFuQK8mnSasX5a+xfPFsrU9Ow9eKsdLBXWOcZ5tuQERcKq8Tef8mP1+mjn2nAt4RVueXoVRT5Ou/Y8jXK+m+AmP8ONkNUmS
X-Microsoft-Antispam-PRVS: <DM5P136MB00284255755E9D8BDE050BE5E8F20@DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5P136MB0028;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0028;
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(97736004)(68736007)(26005)(5890100001)(2361001)(6116002)(3846002)(106356001)(2351001)(478600001)(53936002)(86362001)(9686003)(1076002)(2906002)(85782001)(36756003)(8656006)(50226002)(316002)(105586002)(25786009)(52116002)(7696005)(51416003)(7736002)(386003)(16586007)(50466002)(2950100002)(4326008)(48376002)(6916009)(6666003)(8936002)(81166006)(47776003)(6486002)(66066001)(39060400002)(8676002)(81156014)(76176011)(5660300001)(16526019)(186003)(8666007)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0028;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0028;23:+SSocBn8NuGFA2IMpWUBQrPKqQ2u3jvPvCQZ3Mdlv?=
 =?us-ascii?Q?2uzZMHcGnKVFB2s+2mzEnueAd8xUEIb3tTB7FXTigtv5ZlRKjL38eq9v31rP?=
 =?us-ascii?Q?8+vCwwjuU5dPQsZyQPeXHP0lQhOPdM3m1wW8c4tbrK/776ipxF6dDck535zr?=
 =?us-ascii?Q?5CIZR0wpTuTme0aM9yOaJEw4qkzFu8MQqm0Z8MnV7I1ZEaTaDuxaKyu7qfKA?=
 =?us-ascii?Q?0yT++F0pIFiFqYWyV6hifPBvQG633GeMH8Is/7mBAHghXixSMzrWpK1Uw+09?=
 =?us-ascii?Q?R23Sjbbjvx9lfL2x2+f6A3tnwfpzH/Rms4uiqJXtlsOITI9S0Gs9OWfM/ejP?=
 =?us-ascii?Q?F+6ZrEo3oYBzZ6Bj+Rpom0YYcF/zxs9QLSLluWyOWvNfDPYQCfLWdueXyxAX?=
 =?us-ascii?Q?C8hJHZ74OecU+OqNqbYoHHFqlAOb8I2Qg28MvA3af8xugxHYlEOd0vVEUqhQ?=
 =?us-ascii?Q?wShXNuuDozzmOdG/M0puwved4dERfiRPu5jDkk/sqIXohcTUAzmOWo8KtaF8?=
 =?us-ascii?Q?+1bgL77bOn62Z1zAfECcjqZtd9cWOSPmpU0pXRnok9bb27XPILURxSWbihi5?=
 =?us-ascii?Q?qudBW9WODRxay4f6DEOuDVnWegdvdmzXWZzAekxy8z1qhWYQc2FP8IlUwaqK?=
 =?us-ascii?Q?EYoa3rzZuoqug9hfS4SALcbe+QOh9MVEAM7GfHEHoRg8LEuUSb2de+u8dw/q?=
 =?us-ascii?Q?mu6ZOAy3rj5a6MsdXnVYrHs0rnRdqbd9VhlI9mBYU5A6/4jl5BWOW1kwC66Y?=
 =?us-ascii?Q?NKTA6s6hDJjwVnENoty+eNPX2VvqL29QyekfPbPnfrydogP6xtptLlxm+OQt?=
 =?us-ascii?Q?gZe13GZ2uFggv59Nt1fR/ygCyNodMZv8noBzaXogpK+7k5XJ3Hjjt9cdKUEx?=
 =?us-ascii?Q?pMGcb6dwOfRb4P6LRh5Hs1JxtgB5Lgndz6dxVgOWTOLAofI0E9ofFmYq8Egx?=
 =?us-ascii?Q?BtEl8sYJC1QZ4fAzJATAapSqZvjGEv8FYgqEwlogJiyFcJVMXRXlkfYgBrXj?=
 =?us-ascii?Q?ygAhVwjj1DEUg53Cen9PqWHPS3oxGDNlbHCZbrvARZnWEBVR+87WfaDMqgze?=
 =?us-ascii?Q?zdz6b1tBAjsFT6noHhXq0rcey/C0HYAH+G0AU9Kl8KwN9IDm2kPp1ZXP6Nip?=
 =?us-ascii?Q?ntFrg3wH+LvnZLSE+x8xEyPQQ4rz+NkRPx7kgatcIKOd+dahHi4GOwKu/Br7?=
 =?us-ascii?Q?JNT/mDLG9CbdG+3FyJhmoJHSUgxosqGK8v9Ympy7nLHebrNxmpy1KEK1QmCU?=
 =?us-ascii?Q?StSkpcV978AsHJSYFqDeglaLDp1rBdGz4j2s8GHajJQi2YMf1C/D79R+gB1w?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;6:0Y28h8VlFZHiE8SlnZSkCh2gnEqQJljbOmNaeV9lHv1HK6NEcbvw0JU/EVUAbjy2hKRBie+sQOW3KRNaMt0+OXtcm5Eb86zJHrFUDsE5N+UltO1dTBqeCeSrRnOVVaI/gktT27QeIZb5mayezlaB1vl015GqpttUEFkX9+nyIpj0DuOxejJfvTpquzsglJCgy99+isPWkgy1TP3YAUeBu+h8IpxeKGNUVmiyZq1FmD1WgdRNCHeXEtRFAbiYW5Wdog9okLAbVRMy5r1gM7B2dsQ3qR6paUFXSxbsXl4r9LUBa9pnQom04DIK7U+fNR5KLukxM0wTY93hNVtiIOlkgcQc8INof80YAYNeWjaTQ50=;5:CX5TiBeqzTG+GhwIhLheY6YJgywCRFxLd5XpL1rA7nnOpyZoUpZ/FSGdPKdPWZGiU/dLv0OCgg6xgBw/0/ss1Gu9j4KPro3LgnIZriTDvdKyiBssys3mWaE2uUSOa2Jb7JI0tQDC11vxdxkQli/t9RAIUgpz+Cmb7C9oA3fMLaU=;24:GpTR69nsOy84zlIrXsm308ryBwfTD1JOjtDDkMh75wLXNvimZKeUW3MJpGLId3ctXFBcxcuZxYICYxYFGWNHpZsGctaSo/qyyMiCVTE3csA=;7:6V3pCTVLzrIvrXkMarhdEmQ5MMwJTO7iCXE0pzZ323GvARMvgHb7gkR8FrngFWpaG1LXMfb7WiGCfz3JivfFVE6KX31a2KynA59hSOG1P9eNpew3GQvgTIIT/J/JLYOlYIuFvq7rHpPWtvISD/X3FFsOvW2+qKdC3935UbP9+LaL5DK2mFj2Ry/wsg2I7uVdRhVi7Em+hbh9v5we2Qu9549KpLp+MSS7Vbx1E8OwTzZaPe300uCvRpN62QzTzFkY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 13:29:03.4971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037458c9-6941-4bb8-0e8a-08d56fc117d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0028
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the GIT_TRACE_WORKING_TREE_ENCODING environment variable to enable
tracing for content that is reencoded with the 'working-tree-encoding'
attribute. This is useful to debug encoding issues.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 25 +++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/convert.c b/convert.c
index dc9e2db6b5..5b49416ee1 100644
--- a/convert.c
+++ b/convert.c
@@ -266,6 +266,29 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static void trace_encoding(const char *context, const char *path,
+			   const char *encoding, const char *buf, size_t len)
+{
+	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
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
@@ -325,6 +348,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			error(error_msg, path, enc->name);
 	}
 
+	trace_encoding("source", path, enc->name, src, src_len);
 	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
 				  &dst_len);
 	if (!dst) {
@@ -340,6 +364,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		else
 			error(msg, path, enc->name, default_encoding);
 	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index f9ce3e5ef5..01789ae1b8 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -4,6 +4,8 @@ test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
+
 test_expect_success 'setup test repo' '
 	git config core.eol lf &&
 
-- 
2.16.1

