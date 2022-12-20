Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC686C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiLTMcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLTMcE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:32:04 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343431010
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:32:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir18xXdN5GObJHloxXiS/TGCPhBOutY83XCiq6dcK0oVT/n5JlBzFDcxcQtsQeUXRnqgE1ZodkTh1xG5mQSA/S144wdYAETDL4t/dcoMXyqWsbQStqvplkNnyY1eruRUubiz//+uvLf189uAKHuoHjCma7rAVZfNHji4OZeL9ZdfX40zSrQ7KMU1VF8ekIHFkhrLhMsKNcpqOGSCv6qYv+Z92VkNPSIpbzdbFVeMReSHAbKWVr9BxO8XsW5zKXCQTBKyWKpvB+45MDUOPgIYrKsiMgagTxT+d1poxoyQf8XnQ9+6Sc9rFEC0vzALFzaiW5d0cRligLjz2jvSjTeWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5AaST38KANDVYHc7FJUjij/q6EPmOCg+PIt4F03RFs=;
 b=QjIb//YxOUdLegDZ/zL45wKJs16VJTlS176gETlyMmd0r4EfgQFjljec7cD2zEsDjWX2lrbhkXfcx7XCQFEAbFgFcQnh2ibirFP90LcBFJC5LBsxaOs7s1AR7PiHTv0rXu5p6omIZyQNN2eGh2yK07TWuKQcHaRRlRAj+dqqoDB0Tg7/h77M0S/yAjnCP8ixsZePVWLLM2tjPSUC30CDbqSxiyxi4bpHnws6dXpT7xu8Agb5R5GgBIt6vBf3ydsY+vSIWKSEoaDO48zIrH6iWkaN9by+xbYdLVXLosYNawrUZjvn/plEkIbSQLazDWUPEjX1siVSu2cl+krZcsIOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stmcyber.pl; dmarc=pass action=none header.from=stmcyber.pl;
 dkim=pass header.d=stmcyber.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmsolutionss.onmicrosoft.com; s=selector2-stmsolutionss-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5AaST38KANDVYHc7FJUjij/q6EPmOCg+PIt4F03RFs=;
 b=AILz55ByXmaqR5qJ6HSU/XPFAatSLutIK1MY/yRf5ta6TfxzuyOqTLVv0itJbTpG86exFiDMZolP7zA/dvapdOR/slMYxzUUkDldSXJWMMDmuE7mwuTC2L+pWy7MQIG7IKrfA0YKU6XQmSWRi7q2mb+5L78gjX//1G5SoEPEung=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=stmcyber.pl;
Received: from DB8PR09MB3225.eurprd09.prod.outlook.com (2603:10a6:10:3e::25)
 by AS8PR09MB6067.eurprd09.prod.outlook.com (2603:10a6:20b:567::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 12:31:58 +0000
Received: from DB8PR09MB3225.eurprd09.prod.outlook.com
 ([fe80::4ed2:b653:4240:5e36]) by DB8PR09MB3225.eurprd09.prod.outlook.com
 ([fe80::4ed2:b653:4240:5e36%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 12:31:58 +0000
From:   Hubert Jasudowicz <hubertj@stmcyber.pl>
To:     git@vger.kernel.org
Cc:     Hubert Jasudowicz <hubertj@stmcyber.pl>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] Revert "builtin/bundle.c: let parse-options parse subcommands"
Date:   Tue, 20 Dec 2022 13:31:42 +0100
Message-Id: <20221220123142.812965-1-hubertj@stmcyber.pl>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::18) To DB8PR09MB3225.eurprd09.prod.outlook.com
 (2603:10a6:10:3e::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR09MB3225:EE_|AS8PR09MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 94232905-2647-40ef-f826-08dae2862f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRGG/WBwq0W7qq0VU7C9YWjRJUyHWUoixzqUl4PwQ9utHou1+0iG9Ste0dwUEJzl1X2C4ziPWQAXww/Zr4o+gw68HhOeANhVvSVtCa/FVlVgBH9y7IRXGWKxgWuy0GZt6xx93Q2qLtwh29UpbqYitja5NljMHLSF6i57VWBLTnam+iI+gHC6Xskgb44nuRD9T7J3DXyeQpG60DaUoJBbg9r5L1ST65AHsUkE5jVzSHqMURavxV2b+jwzASPPUHt4NwFXKEat7a+Um9CnJG1NQzlU0d6lrJmCN5mSAVUNHp6+CvnVw6egp2xBBQDkY0lVjEf9F94klkn5H5CyJutv9zGVCEsQUTH5ReztXIgsEFY4PI7HPCUxglkvZMpg0g4BdYjbcrAyocrDTWUfBztG0eF9/CIBW+42u3AI+FI72dTWGokLI7nr0QCed2d6sApBmzN8o47JCSXv894Hc1lQ/efAtHz6ElsoMo/EsBAOz8jmrVuK9MKB/deLMqlXL8XJgDA/8Bnn9ckbDMIj3P7IHqXNUgWd7JTouto4cghNxT3zvkKxoK5FfPICydcwhXYK5S0OlTI+rV/t8KYCd4nXZl09dBH7gQrNBKl6ZDi0LVUouEZpjZEGhAwF14xdlpcOPqly4EV68DhjRfiorzflmdoLFMFMw9jLRqLWSyid6gdTqwscQ5nDn7L1HnzI/gHWs9+mmHyFsl5svjjzV5gYyx6/hoKg2OeJgVYZgkeYtUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR09MB3225.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39840400004)(451199015)(6916009)(38350700002)(38100700002)(478600001)(6486002)(2906002)(54906003)(316002)(36756003)(8936002)(5660300002)(66476007)(86362001)(66946007)(66556008)(8676002)(4326008)(83380400001)(52116002)(41300700001)(26005)(2616005)(186003)(6506007)(6512007)(6666004)(1076003)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R2QZe89hxPoPfK2gGeEUAAF+6R+sVdcLVh8keoVP6P36kAEriUIh0J3sEr3A?=
 =?us-ascii?Q?65tRKt05mVBLGvC/0NzHvotLZCSmgVBAGcCBT8GAGCYGrwfk1oQcOpSSv5yP?=
 =?us-ascii?Q?8NzxZm9b113Wzd4GzE0BR9CBE22oz8scnkabGpKyWtbk2JcZq/hKl0VS/X8M?=
 =?us-ascii?Q?jBBtkJcpNKfBJgzllmRKdtCqz4UUNfkFotvPwniGRrViiVFGtKvvWA6OoQ9j?=
 =?us-ascii?Q?sqbK51kM7fzGJfXUQQkUCGo0SH9zH5xjn7FYT4nk+7oilsGXELN7DCTrd5XC?=
 =?us-ascii?Q?Ux/2NurcHNVixmFdVCeWyC4s1IN5IyKE8ygqeARzhXppKAseGJ7zYhx6Un5y?=
 =?us-ascii?Q?ovcrwNtwNyS7Mu3ZXqzyOuvqPzSR9wfPg4EjdzEYqGinig+YJzFSED0TRB7/?=
 =?us-ascii?Q?CEV6VdAC+XlS3wtxRbTUZ9zVHV3dImHL45HJVqIX+WmV/M6uNrgRrf4bYu0b?=
 =?us-ascii?Q?7NCKDRHXLRmlJrFjb/ZE2oLBs2AZ5pLYte2l/EWHpkt095y33LCEzUmSFP22?=
 =?us-ascii?Q?Qydc+3/5GFVjmyrL5KSSdot+ZCQTm0ag+9pAJ0b7mbPWiI7/1N3fyC3uII7c?=
 =?us-ascii?Q?7q3ysvwf2kpqRQwnQMkgCCiab0DVat549hW469wBmdQOiqeljCGieMU5Oqxj?=
 =?us-ascii?Q?QrkcZ+p+LFCwe89aU/eIX7LZiffn3whuNvZFOx7Bt4+0I4yJeX1LSmctWGxS?=
 =?us-ascii?Q?osjRW2jmJz+z9pvyaZuJO3C+THDvZZ7RmfkP9WmxMGb7ShNTGs97KB1Jsi8Q?=
 =?us-ascii?Q?xVYCfd7WQ25IxI5LS7IoW+HmNb6aekvi4uj5F000zBPp2I/qs6KHuk963t4E?=
 =?us-ascii?Q?COU8iq2cqPQLutX1UE4cTTbhb2DpjDiSUmvpF75uTYGFFkTC9Wlrg/vbBxi2?=
 =?us-ascii?Q?Q0QZQZfNUToitHnT52adggEsGMi18HTwzDsFMaHjlJgj5qerMsUyN/AsR/4v?=
 =?us-ascii?Q?JziXt/JrKvjr2jyG8Uov/U1aOtzyLMMCLTVHhNDESYWs6wLFtRZFjQX7FgKc?=
 =?us-ascii?Q?z7sSbqI99bnL+2WxEmCHrzOlHKojnjS7XfYEIQF6s7MfqZ3ElCOHf2SMc7YE?=
 =?us-ascii?Q?TeYp0ubkiPpgrRP+a7SJhXtlsQ6xzL4T9yXlgoOl6oB35KW/3P0gqrnE5zlH?=
 =?us-ascii?Q?HDqYlABgHhx6yfA0DKMt4Z63mK7gA50U9EC2raaWTnRFrA+74drFzioaqD9R?=
 =?us-ascii?Q?an3nm1tiy+WHPIcglGQW5Sy3z/sPBubre2dj0bz+34++AxGhM65epb6BCqwR?=
 =?us-ascii?Q?0PUyfTp3fcyAVL9J4BOBUWnnPDB/ytMTqxWNZGMZ6d6/EIiexf0CmJyYh2lC?=
 =?us-ascii?Q?v2sNutPVe8IejGpXxjKgpqg6O3qz6lxsnNLor8Rf6hmpTE38I/IZVOfnxF8Z?=
 =?us-ascii?Q?wTW5asZ8LtJqKqihv/2OHFUu+E4GB3lp667ZxJhxw5Psc9CMhaYWWmfgJNGb?=
 =?us-ascii?Q?dg4/PSDVDoviix6zqrkMihNoBnDMlooZ+4yEuAnhrNvgWEuZey3hIpX+LKmJ?=
 =?us-ascii?Q?h/jqruLa0p3cIdDHRlgxu/2lE7SL9FT+zWqIT+P+V5JORNqNMDBCQzPU/QXi?=
 =?us-ascii?Q?lziCMapZmF7qy37cM9tKyZsHqIaQy0OZN05N4p5U?=
X-OriginatorOrg: stmcyber.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: 94232905-2647-40ef-f826-08dae2862f5f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB3225.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 12:31:57.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62c20329-7415-4bf0-95a1-601ddd24eeea
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jNmJ4BK/V03MxFrKOHdM24FuJH3CDSFgEejPGCHvktTw+wP+Cm6zcbu+46xwFN+6u/lAO+CoPYW1J/sLrfJRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6067
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit aef7d75e5809eda765bbe407c7f8e0f8617f0fd0.

The change breaks git bundle command. Running any subcommand
results with:

$ git bundle create
Segmentation fault (core dumped)

After reverting the change, everything works correctly.
---
 builtin/bundle.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index c12c09f854..d9b46f8e03 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -206,19 +206,30 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
-	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_SUBCOMMAND("create", &fn, cmd_bundle_create),
-		OPT_SUBCOMMAND("verify", &fn, cmd_bundle_verify),
-		OPT_SUBCOMMAND("list-heads", &fn, cmd_bundle_list_heads),
-		OPT_SUBCOMMAND("unbundle", &fn, cmd_bundle_unbundle),
 		OPT_END()
 	};
+	int result;
 
 	argc = parse_options(argc, argv, prefix, options, builtin_bundle_usage,
-			     0);
+		PARSE_OPT_STOP_AT_NON_OPTION);
 
 	packet_trace_identity("bundle");
 
-	return !!fn(argc, argv, prefix);
+	if (argc < 2)
+		usage_with_options(builtin_bundle_usage, options);
+
+	else if (!strcmp(argv[0], "create"))
+		result = cmd_bundle_create(argc, argv, prefix);
+	else if (!strcmp(argv[0], "verify"))
+		result = cmd_bundle_verify(argc, argv, prefix);
+	else if (!strcmp(argv[0], "list-heads"))
+		result = cmd_bundle_list_heads(argc, argv, prefix);
+	else if (!strcmp(argv[0], "unbundle"))
+		result = cmd_bundle_unbundle(argc, argv, prefix);
+	else {
+		error(_("Unknown subcommand: %s"), argv[0]);
+		usage_with_options(builtin_bundle_usage, options);
+	}
+	return result ? 1 : 0;
 }
-- 
2.38.1

