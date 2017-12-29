Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A7291F404
	for <e@80x24.org>; Fri, 29 Dec 2017 15:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdL2PWs (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 10:22:48 -0500
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:32317
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750869AbdL2PWn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 10:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y5ASE4rVKoGbpS2027lpIa5HL+Drvj3pisNNl16QsPc=;
 b=a4GaKT6fPLrRtiS4r/N/+GVF2M0pM1yE6Wqn6VS9nMksc9OKOMRe7JJvfiQuMfphBT6uL23F6iyzrrVUxz7nCYvK4yaVAogD92C7V18RSMvzkBK+VIxyH4qN9Aa/tDVnB/++9r4r3BTqjnMKLDyonVdC9OxF3kkS72joXEHt17Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.84.3) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.345.17; Fri, 29 Dec 2017 15:22:39 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 2/5] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Fri, 29 Dec 2017 16:22:19 +0100
Message-Id: <20171229152222.39680-3-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2d936af-0630-4857-b133-08d54ed000b7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:SBJfx5QzhS9bHQ1DUj2aU2wnF0usVmpeIJVo8vo8EnpqAPtCJHsobWZW92BVcY8zP+biud2HAex5LK4MZS5SeSq6f3SoU3WSj8y+8cl/VZ2Gkb92bhR4yrWrJvZSTob7c1PgtvZstjQIAuJLbbj5hTQhjLvI6jqPBJoRe4chWJjekD+JumpBXGhGlFHG1BXW9m72SUiFGyprta4IvMfeYnyxIZuWsa4rMgnMj4oVa0ElS+ofwKKX/5jA1JG+ida7;25:zf/WmT7yCG8BCJCzErXcv/WbYEc+eZCL5ynG6v9fSJwZ8Sq4jrcqnDL2q0a3ShG6k4xzV+wlDaGgaNbUDD4nt95plnK8To0IHtXawg2hzw/wifla1RW0la2ztTUgDqftCZf2J/ANk6ptd3fzYb6R+yAxD+J/T28pS6NCLLlxYHDZ2uG0chuifmArzlmq1VTWf58H8xxuX38IvNu+eZr3FMMsHl/voDp+yqMp2LDG8PSHg97d5uNPqoTl4TG10EPGIVYHyte0XCLnLjb3haBInwvSov0dR8T8sgLdfSTBMY1sAysldHOEEvapzC//hZCKeHtynckWFxzVcHkOJWEeIA==;31:pQnDm5XsezvlxH1yLlhq4HDSA1N4671q7fENHLP/zJcjaLq9ngVDfhS94C34M+65qeMQMxuIfKrlFVykG/igU83JZqeZqAePC0fiwE9cmceT3Zg6c3fFbihYa7wKuHZHTu3s6hzJQTd6z54Bb/UgtVE9jX7TcwRUxcGmIaW85g2hg4NNbcdKTEvqNgiVuzBabt7/5YR3CcYCADvBsqJ9G3kzolysZuMNumUU4JjoFMo=
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:26arxcs/+8zAsUdnosw13101cs2JkP62mjq07xkxEhrMEp/VjEmHYnAdqKys0zS1U0kabpqsMIlRv3gbDjRX1zGdeOAllFsMVhf6b5hSszyhHqhlD6Yio7A92SaJmap8TdH6iHFay/Xk6PSDM8Ex3Ggg+uOovE8WpBhKXAuw2V8MEbS6BXIn9tHqNQiuIZ+kifTAjC+oqvDV1MrjY0HC9VUeN6UvarooeCcmt2St/5jlshPf0GZ2q1hZyuYEyZcBwPv7O9OA9K2Ng1uTM0AarLdBuV1FD+UcGMTwzKwj8d87xOK/w552Tt1O4YFMMsuQIHoceV4EjN1n2mshNqYFj5iz+5lwX86pFgafovrElEbpqJfRbfJ8izsg7xnz7ZFwWIWyXSZthVfXPcDseaktMl/2G7gFvcnA2HheOOkYYtDtp1TtYUyo76hq7U9ML6UACeowXfDycSmvZVFtPmYzxmCJas3y2WqDd5iSiw5XyvHNy8ZdeEylJDx8jTjgLB5iOs7ZP/nu7bG6inpxZfsjDie+aSLj6SBKdhKz6EeM+w2npUmM9mHgb0Du+qUBsRkJVV46dz09y4qQ40w0lfeVQ0x5mmyTPGRirXNZVEuQSms=;4:fuJjbb07nawVgE7+r7SMbWq395WI21T28hnUPRZ9aJibOGgi8LuL9Wj2Lnml4TO44S2A9/6Xy7BqvCzBUNgYJ3gMyqYmBefku9Md06ZP9wyij75wjB3qE5S/y0TzWvCW83mdGStmvXbD1VPvvFlOnONB1MA8yRcRLiEiMCNFN5fuKQJFeiGwteE9l3ivMHyjH5gp5cQvrCdtgtYBtOj4FwKrbZe3dHvHykwDakj9pMNl21YK1hXg7CwIP1QHpTSu84L7Tc0qCbhKgHao5YQ0qw==
X-Microsoft-Antispam-PRVS: <BN6P136MB00173CE269A1CA4F676074B6E8050@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Forefront-PRVS: 0536638EAC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(189003)(199004)(16526018)(4326008)(6666003)(2950100002)(478600001)(6916009)(9686003)(53936002)(16586007)(6306002)(6512007)(316002)(6506007)(68736007)(386003)(86362001)(8676002)(5660300001)(36756003)(81156014)(76176011)(81166006)(39060400002)(8656006)(33896004)(25786009)(51416003)(53416004)(52116002)(53376002)(6486002)(50226002)(3846002)(66066001)(7736002)(48376002)(2906002)(1076002)(105586002)(50466002)(966005)(69596002)(97736004)(85782001)(106356001)(2361001)(8936002)(47776003)(2351001)(6116002)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:+GqGOwyxtXVHENeAcmQiJ9MscJ6NYDYftJXJdIUZ/?=
 =?us-ascii?Q?cE60AsRdd9vhPHLsjddDSwtCITurYVQBjkHDHH3lBACzgPTqaMvgUJgXNjI0?=
 =?us-ascii?Q?l1et6xSYzKJpm48ymoAOExKl8NUwT1wOi6ruOJWjbgXHzAZ48lEcJ5N2nIak?=
 =?us-ascii?Q?vmyJmTl/+NDM5uU9pSz0WoP8OnCZ3rgxG0t8hwPzWjSdtwCJAGBHGYZt/Kmt?=
 =?us-ascii?Q?CZMGQ8E13q6dG4LFfR/3ZmwiwxDEvQYsY+J2Xsxp2fOrcMokTpnmcXl9sqAn?=
 =?us-ascii?Q?AAm4av2f8RLxahjuFxsNdErK0L74M7ZfWLECyi+TGJxmDJDlLzOWeN7HmL0k?=
 =?us-ascii?Q?NYAr/m3sKm75i47ZKQYl+9uk+b/XcQgHzOXErUXRZrdgIIutfcMOeUTLD8Bj?=
 =?us-ascii?Q?kdoxELdqMfVlJgnhHdEXvq55EUW6216aYjPkWsT/nbcnZYSOkR9Nnpp2Gcf5?=
 =?us-ascii?Q?HQA4CMCihJnsCNqPBxcSRPiC6gA+rPjB56fW8yAktU7tSg3cXxTRkuv07L2g?=
 =?us-ascii?Q?fL6gZnLWMzuAKL1OUxVd1U2Cu+B9IItNuz1PZ3eTwoIx1CLI5y+tuo7/YKFk?=
 =?us-ascii?Q?3qwqibxlL33Ot7m2qwyKmzELMPZPmyqAUpLw1urYhXBZeguAtrNJvkzKKecb?=
 =?us-ascii?Q?QbIVlSdz8NDjKQKG8zlBu12NsA4WnHuew6wrzXw16WDiHUsPoTwrJdsaYq8H?=
 =?us-ascii?Q?6EXoCCfz+toDIaxb+5Zyf5F0N7+zTvhLhcvtymV+c7CnINglOcplEhrT0Yz4?=
 =?us-ascii?Q?ggWjGSVC/l1HEkHDPnSPNeIzVwBPN49fqYM19F4VVSiN2IFSAxCjqcTvD7Oq?=
 =?us-ascii?Q?g3DqF1rLKTgU2b9J7paVcXQdJMbCxjuNryHFRtfg3ao+BPiJnkZOPBIqSZ7Q?=
 =?us-ascii?Q?VmTxPyjp/AQzcD3IUx7DZnO93KvoRmnnjK8QoxdsvKekldHFBoESQaEgklTU?=
 =?us-ascii?Q?OMcvomQ82njKH36bBh/znIGSKTDqnOkXqCAZgJKwMylu323nMubQ3WjcovwZ?=
 =?us-ascii?Q?vvGt6HiCwL8aVSdYFSMarLqhNHgy38AWFh0HW2cpWD0XWHr9YOKO3wb8TwUg?=
 =?us-ascii?Q?UfCuB2f6NL9m0MW349hGmAdbYHsCYzEkpOfDzlDUYDbI9K8Owmz0HzS8HllO?=
 =?us-ascii?Q?6L6uvDf0m4s3QQNgj+7TwC3dm/Hdazk5rnLd9hRxBps2Iki4kZyNNbTec+RQ?=
 =?us-ascii?Q?pV/PSzoJBITblCkYt/SarUjCdH6axRpJSfi0Qm4/E+olYjVCe81+aqXNBCqk?=
 =?us-ascii?Q?HoSVPVwk5IBGlMSr+CPrHV037rb6UWNYfagCfrAaY/2pG6ktDr+2Iud3XN0X?=
 =?us-ascii?Q?oHKtSyKT+3T64z1mIdxHcz/u2nSAKaSwNNkMZEnvsKqePz8xUg3Vf/SRltaQ?=
 =?us-ascii?Q?fE1MA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:42hi45mtaVb+08hNMFrIv/fY2uBdmkLHEg7L9RDBRa+ot0VojTU/4h0IKBlfbEfR5rYRqReeymZbyKi0tf74lT2echwYd7beO2aW0w5O87XPoUfKl6qcSJuK4JeZLZYXWb0aYZpheGra6M0xGOfcnl3hcidyuC36qQKNCiIXLtVMRbZvGrL4fBR/R5VpTlglTK3otAHTBaEQysMOXQCYhcqYOerJJ1o/m+c5yChCqsKgpDWeUuUfKRHfZwQWzLfP7dR9jPfFd0SOwXfkhhSs41/KtRfqYuKM27KX8kV3kw1xUhobIkbTkPwWqd+AhkYFHOnaOB+sMhgQLBxqKMWcA906PQpC3YAHaebtYXiNZco=;5:2GCohBhASAUaiwUSw5F4fygq/bcggnEeBPtFQIVp+JdeHM9VtFfn0/GdbKPUz5/X7GhYLQM5UddkpQ5eCN5O8mIpC7OcRKgLaT8IsSh2NhZChz2vMktty1eczSeeAvx+owf/TWxXjOsTnx5v+zZHCNBnoRc4qdpf/3IRmITJPac=;24:4GuQLHtzylw8haObfBo0EGn2uRLdo3ATbvNUAL9ASoMrTVw5Mi9fI2TaGlIvfNIlJzmsS0vDfCF2vRpJ41q89eaXUIlU55qp/ZI7wNtjgGo=;7:zhIAvaK4c5Rrbux+5Mu2fkUBvKCvJM3wfJyl5h0aZcVSaYCs1oO4tw19PSO2v5IYWWsBUrotcBYt8dtxBQZbfXdaTTlkhE26vOqH1/+Jjc2M+HO5RekdfcmAcGH42PgfYtrODRSTz0LpBWZhutZJmRXHTkBrzoFfw8UktUPtQDR1wi+5oUe8rKubdw/ctq0lG6DCsZCQMYbBMhH9hk6v/TyUVOhwOOjmWutW8Na1HIzEWsyrd3+EsWijqoHxN/fF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2017 15:22:39.9526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d936af-0630-4857-b133-08d54ed000b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
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
index 2c27ce0137..776660ee12 100644
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
+const char utf16_be_bom[] = {0xFE, 0xFF};
+const char utf16_le_bom[] = {0xFF, 0xFE};
+const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
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
2.15.1

