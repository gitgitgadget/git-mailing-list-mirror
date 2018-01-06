Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD7B1F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeAFAss (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:48:48 -0500
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:4514
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753447AbeAFAso (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HR2zlY3WQgd5IP3YXAIZ8DmuZFrE6AcUpWOAkeSe2w8=;
 b=U4C1dUINyqm1fNgMnDY8xMXVONCAaXKmqyYBsKHwkAS/GYNziPevh82UbbBc5aNNBz0FNaf26bRO4jum7Nst2z7iiRr1JZ2zSxcRbPHFPisZ3onBRgap2PY6rf+443rQ+J4k5eKZLv1B/5Baqg3fHluHSUFJOOFh7t4Z2PWx8HE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.88.245) by
 CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.386.7; Sat, 6 Jan 2018 00:48:39 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 2/7] strbuf: add xstrdup_toupper()
Date:   Sat,  6 Jan 2018 01:48:03 +0100
Message-Id: <20180106004808.77513-3-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18ac370d-e06f-43f5-1126-08d5549f3c56
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY4P136MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;3:Ai78HD3FgZImebgmDUCVZbI25xFQNkQuDoZ+2jHdFcPKK7xWalzTbdiORN04GXn40kgBkXNQjZcLvkyciMQv5AU1kBoAO8o7vZ2PSWNjl1s9o/68ONUAk4PodTxXlWkZ7E7pSLMpj4VdmxQZo98Op8pwf84torGZNlhjffOb78FtoqakqaT88LMeuuU3ve60N8uy2TsK09wu1FZEGKy9DxEpMzcjXW1OYOwmaTSNv/g4I8kLy1w7Z2HqRnhZVZ32;25:9h+vTLmZTHg+SCsWDaB7l2sGT4WkrCTo2QDmPxSVsF/K7yLNaiVLlj7RYoPt/wfjfklDcO9RHwMtcpZEEnA2YaPG9/lewHr6WutNV8rR3IwfZXkhC8ectOIGlemCPjQlTzaAVyUfHZwy5NsDL+31+F7pwMh7Pg++SU6D4cBk2YU3ZsnBxqcOzMDA2pdowTVPqOUtlzyyYDe01MR6VIjVpji7Dg9FsnF9wjoYyKhyFaLGw9NpHbu7lAeXjC9RUHvPnOdUIfuI9Dh0EV8/VdMiAqNQOegqb/mtMsGP4TRiWqGTnfs11/VYFlni9MmfuLESu/C6KyWY6TGdhuMksSC3mQ==;31:EzTi442KqzeKlXsJb/PrVyDliJiPrDqgGeFJ80iUTDaXfoLog9jDCEBrEbDshJ1D0pdjL1gF9WRLgp7DwKtxtA6tB2tf0mOq1UV8nCTv43GkUNvUU0uGvaVeNOeddvU4sqpnAgZKQoFu31/MibfjiuFxQM3Ub5shPuiDWtnY6BVFRAjzCQ4pZ4D5ATvh7APprCJqbMHOP6fWvFmP+t/87oFkYAWOg21RcBL/gdsYujI=
X-MS-TrafficTypeDiagnostic: CY4P136MB0021:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;20:fQdHqJPnw+kL2kaV14K6NbeenmZc4cge11ojh+EVZNxnz5r5MOYgoLB5vm5REAmqnyE8lgXuEXSjm/KJORrfP7fzqVqD4jFqb7+acbBOWGcInNv2qm4VRpiLDh2ihjIMjMqhgOYfTCEgjlxtKlUyhg7HVPKeW7qyr44hm3YNVeQSFaMYwlbolfrKOYZ8BDoiIkw2fiU2vNOYZLr22Ssy9lk3rByYsAP+nzSgttsiVDne8pU1SnmZlMIqE2zgL8g5FGJeJnRYAlHAb3JeVwOTXSK54j8XmYLi3VAXEf1ZDq1SlWTjpEQJOq9Wt6RIyKkb1dAFEaH/ZDz9kw5wz60JaX63u5xn1XbpPZIdlFmp+CJFulNZcb2NREyySE4rT1fOpCyqt49NF4YueM2xuZNLRhQKRfCyFU0vWq749SDIDQsyfP2DtGp4V0ErwgT/nTwH4nnzqObCzhUl61N/Kd8v5/4vA0XKJuuVTwruMMalAmEhfw01u5g8UgZ/XLd/HdA7LFcRakAme84pNUXIwV7QJTtXfi5sqNQv6m4+hX1QMbyHuuFapQNz1RQNq25O3jb84zS7/7H34bs+c3GMAGicpCMmECwDtsFZiSbhmir+Efo=;4:OwiqQfPLxRlzis9UIWSLV8xO5M23/185pGNTgmbkC1zHgF1Vn2ZKzlqp+kba56gLKkZKSL+oJ4gqAQNgjp+ea4cNx0t7PgmWwFksUQam8x+5lWRmBXYr8kSry48y0ZdfDQmOCwR1Gs9026Gym88Dgm7F7gBZGzyWXT1VfAuWpwj7Tg2jNbtOI7bLSRqSJ2TJU6RJ4Bj6sBS8LLjSyuZWM7YpEKLOzNLdIDs9il2ApngIsArxDcEDE54D1nKsQoRuDwgZAMYZL+JYVpv5jcAbug==
X-Microsoft-Antispam-PRVS: <CY4P136MB002199A427FF201E660BED27E81D0@CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4P136MB0021;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0021;
X-Forefront-PRVS: 0544D934E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(189003)(199004)(5660300001)(2950100002)(6916009)(86362001)(478600001)(6666003)(50466002)(97736004)(106356001)(52116002)(2351001)(6512007)(53936002)(7736002)(50226002)(2361001)(6116002)(3846002)(305945005)(105586002)(1076002)(85782001)(9686003)(4326008)(8656006)(66066001)(33896004)(16586007)(316002)(6506007)(68736007)(2906002)(51416003)(69596002)(39060400002)(76176011)(8666007)(386003)(6486002)(53416004)(8936002)(48376002)(25786009)(16526018)(81166006)(81156014)(36756003)(8676002)(47776003)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0021;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0021;23:cKDGUvX1WfS1T1371RxJHGzfFl7VT09oM2JmTyBTw?=
 =?us-ascii?Q?uaxxyKNeNEd9jl71ctBuAjhJAAFZZoFW7eZLxEhW5Dsz7N6nLmYDrj4Ce0yh?=
 =?us-ascii?Q?Koz4EWy4EHD8uwdpkeSXkDOpEjHz1GlN6Qx0hG4zrOFKqE4MdcuAjym+HS74?=
 =?us-ascii?Q?bXpP5Rav5hwwRZ0b1nT8zXF+kNl2mkNWwzzjTVsR69cjt+k5QDqjeNdNMbwq?=
 =?us-ascii?Q?Z8yJzjMIYvhS9XpJ3DG75jMAg4oZs6OJL+DKiFsDpZcZBZueH/2IWiYRCfMz?=
 =?us-ascii?Q?P9OsxNmig9Tgr7yQbKUaFoMD/hqi0u0HPFA82jZ5IcyL8thBYT/bXSHtPXDU?=
 =?us-ascii?Q?Ujjk1koLxQ26auyFvydBk8RMmJSlpFwbydRM6qAJInhMy4kBE9Gn/stNw0rg?=
 =?us-ascii?Q?TLQOcCarkyOWDYtYLCC9ZtH0IQaKUuxIExvx3wGOhoXYULX1JPMgjHgJQn+g?=
 =?us-ascii?Q?jFDwUFvNeVVSJUHoeMOdnjRKyEX1bWOzV4+JStYEkpsDi38/w2bQ/6X47I8i?=
 =?us-ascii?Q?w3fI5wT4fAFJ5rcxOTwnDAndaN0jyeCPnD1OOLR2FX5Itx5RLRRFtW6LnZrv?=
 =?us-ascii?Q?7haWhBxkSqszpRxtOSyJn2Mxd5j/Z7PUjt9aC2CqZIY+TT/YjAYAB10faZUR?=
 =?us-ascii?Q?U47ffArUCeeKMpYbK+wM5SOuy7uh21XTedKIAs2xwuLIZBdIbo7vd1ER9t0B?=
 =?us-ascii?Q?kEhSQMiw/WLwEXdchDocSsrpffrv9vgiq9LLAlCjQWDNMtxp1TMu83Xkhq/e?=
 =?us-ascii?Q?7Qlj8lXrT7YXRyyI9XWFwNnE59YFG31VDRIpIuq0PtKhyAPCa5QYPIdBMFKq?=
 =?us-ascii?Q?s+2nHleENhbuLjjNr48MvVKL0UZa99yMzw07NVdWV3GDmeZViGfZw0Y2bDhm?=
 =?us-ascii?Q?8RjReoq4YlLOq70M0JLgSJn6daSIVWU6rCvrFpyechsPi1TOtUOL8FouzkZZ?=
 =?us-ascii?Q?TccL4Qw46OmeHDOvFNFrF1fenO8W0FYGsltDFFjM2YhCiLQYQ8ImQHl+m5Vz?=
 =?us-ascii?Q?hcAO+egtR/WJ9kd7ThaIEPf23EkzxdMHyhjqggOTDKmjM8pJXufS7o+eexuY?=
 =?us-ascii?Q?Z9iD3hRBgry14CMAaD8SzTOshYQrT8HMWKs1NvJGdI2IQEaT0IvrfXVYEaOO?=
 =?us-ascii?Q?WCefjp0T40nypTJCTDbc+a1fi0xKIP6O7GRo1p3qkYYRfDUTxpD6uOxhAJOg?=
 =?us-ascii?Q?CFbTxzVGkeHDYBzOXelLLg5lE4mBJNZG40feedBlsuLzwmTvPuSfCfh2Jui3?=
 =?us-ascii?Q?ENvWDocq6QA6EhWDr8LfSFCpKMzFlZN6jIIJy5Tu40fwcTWvljHlpCgQMsAv?=
 =?us-ascii?Q?MbDS1ZQO+UVM3WYO0dCt40=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;6:hAAwRpor+8K1Cts427zbMjsyUrWOyah8lnT4IATpDh/C/KDbSicKI4zlRvRMJynk0yYIrsi9SjyKJ1intL+AtJB0mJ0iqq5TeSd6fOyuFLxLaZLJEIYCocPSs05mueOajaCT8uilt6sxA8rBrGfcbAjnz4yPBAJmODORN+FuCQYu5Ixwr3KoazTgOECAqWwyxh7I5zB28qSQfzKL7VOy6udcFT5c3iza2cTxAvULZvt9cH+fO0ccBiOVUqs+L19JoETP2pnKxGw7HTlkOChbHQ0JSU9UdpJSlx7hNN4eNuQri5o6GG8bfdpSPDDkyc3U1EPDUA7KJIgO5LCJDUAucp0c1PZrmq1jJ4Ni+GJzJbc=;5:dqy+DIlMZ6YP1/KDIQlnmalaGHHAvUvXX83i1fcljhsKWH+yYMEnZa163Mj2ie/EthDzSkny2cSmU4PXdmfKh84RzNK5Y/c3jdhYqm+B+rKs/MzcjFsdsS6NmAKQOvWw4ixzPxgnYhcU57idqe/Y3tpLeATUSnWvGfwa2QTl5Gk=;24:JQ69b9JiSiJOOyRHKZFlYGI3kmXhaP3VVNrvVKgimx+mR3goTon+IbVVaxxI9jII9zQAyTDVoSktlV8upR/hx+UT0/unGeo+eiGG6Cx77Ew=;7:/7GVxGzJBj04IdZ0fS1VJSYxH+USXCSano9SavCYVIb6RDPdlac6XaLXY6DnBSdK0N9zRG8AJSdObfHfsXDsB9eEUW9dY0ge2oJLJDpOPJ5bJtqBk9BuCXAROpo8UdmWHAwVroBsrUCWn2nMu2BWisHbso17ElO3IFQ3a7P10KUxhxoOj/jv5zVODvNg/xCc0LmGtyguErjgGdMeQqWvW4nI6AuqBPzFVMKji7KnUgo6PjTRU4L3KtoVjFTMSutz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2018 00:48:39.3318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ac370d-e06f-43f5-1126-08d5549f3c56
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Create a copy of an existing string and make all characters upper case.
Similar xstrdup_tolower().

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 12 ++++++++++++
 strbuf.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index b5d03a5029..703a1556cb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -759,6 +759,18 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }
 
+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 0a74acb236..2bc148526f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -616,6 +616,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.15.1

