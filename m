Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2D9C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbhLAI4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 03:56:51 -0500
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:46724
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242245AbhLAI4q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 03:56:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiDcx9oDPLm2hVD70un2Zthj4cMdki+QCKBDxuVS9PIDeLGo4kHqmASILe1CARpJqm5+Ef+cWFipgWyvulxO1NXo+Sd7s6Go905CITx7GIyCa+5bMzAALnlnAi7j4UAEs/ZcM4XSgb+uBeSDz89/vw404WzFhXRq6NDlgUIxeQATe2b6yJPki9D9mt4v04X/yV5JilsjNHf/TmyYzg1qrihXnTNtiI/zNR5ZELHfK9zjBwDQ5l08NimRKKCJekK0YUV9Zv/SW788RONj/K53L7+NaYKb+LkpoTmmINuuAty4uW6L8L9hPjRBP/19UZk4Oe2nfwDSs8ClVM5fNx09ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoYbcHTJMs/Z2Pj7a5kOtbEFUkRsB/gEZQs4ZiDKjD8=;
 b=jSWMQRPpib1WQ7m0wqP55NI9/03N0hQyKUDaLcQ7nEDu7ofqbmztoB/E9Uw7reLOfCfXb0UMZYZG2BZOzLScqF84woI6gAJWaS59UVkK2LosHRkNhSwHOGxiGa7v91byzqgr+aspVIiiK/7oqc7jLWmyZeSc3MqjK6sx8yQWP9ltRgp8u5aAxk8FgNZCZqLUSuIK4basV0V9nK3bppJbrX+v4LhOchJ5iFeXaZn5nUgTlY41vwRNSmpsnckNJy+xzC91Nv3kJmA4nQlWyyD2Ujxs4juoZXnUdjJRBr9S7t9l3cR5p8YSEvn9zKtcBH+xYj4Dp1bXzZ9u99Fb42enSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoYbcHTJMs/Z2Pj7a5kOtbEFUkRsB/gEZQs4ZiDKjD8=;
 b=M4Y5IzUxuRrVwVvL+CThLycsTTX/a82driqWMfvpiUMv6Yym+TlUbuKvInbcCvp/JHrMaFwbjr8zO7CRQPtdsCjuHj2GpT6/TM/9I1wPzrOzZzkA/gS2hck0roP8NTN1A2Y2X2Q3Fhipc0jBNYmOEOHgrHevaHOnwg2gIBYlVmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Wed, 1 Dec
 2021 08:53:21 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 08:53:21 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 3/3] test-lib: make BAIL_OUT() work in tests and prereq
Date:   Wed,  1 Dec 2021 09:53:15 +0100
Message-Id: <20211201085315.576865-4-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201085315.576865-1-fs@gigacodes.de>
References: <20211120150401.254408-1-fs@gigacodes.de>
 <20211201085315.576865-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0217.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR06CA0217.eurprd06.prod.outlook.com (2603:10a6:20b:45e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 08:53:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecdaad62-efaf-4bc5-a7a9-08d9b4a806f9
X-MS-TrafficTypeDiagnostic: PR3PR10MB4029:
X-Microsoft-Antispam-PRVS: <PR3PR10MB40291A8BA58B506644D403AAB6689@PR3PR10MB4029.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzQ6/9GEM3eO1ulS9iIIfujmzBncxD8hp+LN9glMU51BzDo3LzIqEXWWj3+rzP/ItLN60GjgGMrPf3d8oU0nRt5Sy9kC3VYyD0lYxGRCF0KKqVHFoNkndr7wzML5EIeF9Q/PkZoE+Ub4m5H0y69IWdg/iScdGNPG9Rmo8swLROWWgXpqXnrUv+YHVyQFM3JuFHbBwzrcWdjHzJQjhbeKqhw05cTLt3SUm68YZ6wqq9ZALFfdx15Hl/4iD32vJRsrpXJH0WOuR8efZjiUJkM+5+FNALgTs+e4Ne5+y93VUzDXoYC4k0gmsDAmYOuTQkEG1IJEC8VKf+s+7GobmF7F0g1yBl128QNOEjYn+S8SzediZJdBo/e9NQG3zp+iA/YhxYlnkll52ktMgsDaZGcKfJRBwAe2U2VqZCyzzC+4rf9wa3ixTRUhpM6Hx1IKrjhtZSfI6ertrLdEn5MHjqOAtZf7GnfXHrCNHLGsf0gZuWbbo6fkXDtjS/zYzdppncARrNmgxxLOuU/TvvD6q9kqUlAd1b77x4bNuOoTXzHfLCeZXyfHOq3y5ppOVhTaBoollivjpZszZTpMrr6Hpi9qGfCL826fYx8nL4CnLGhxxkxh6IDsuK1zJ4haz+nY4xDFwPCpd1yOdJzPtCq9qc/i7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(366004)(346002)(66476007)(66556008)(6496006)(8936002)(508600001)(8676002)(5660300002)(6486002)(6666004)(2616005)(38100700002)(2906002)(316002)(54906003)(36756003)(1076003)(186003)(83380400001)(86362001)(6916009)(66946007)(107886003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ze4uZBW4BD7u5DsPRJ3j1bHGW/r2tGYqShELb0zc3/t5XeEpU8iUi48FAUV/?=
 =?us-ascii?Q?BhtmgJbsLf5xU+/UQ+JghxtuaeyOckAKYuv85Rlteictf+P6dF+6TzBs1PBK?=
 =?us-ascii?Q?RVN0rKWgaRVIJK7s0RcW2bS4J8KfFDyWsH0W/2TYnTOobcjG6o0Y4Fxvy2f1?=
 =?us-ascii?Q?L7XXdrYTE1cTAl4svdRiL41+W46ahRl/slkj6ZA5zt52IRLjWMrAjQ49Q/cK?=
 =?us-ascii?Q?FC3cq9pNM2AMAU8Je7SEtMtkJtXDm8+FjJkewZbd4pbFNnQVySrjui7067Lo?=
 =?us-ascii?Q?JE0BSWxKxp0Rtav6GlSuOUyd3lIab1CxTr0cEsQoXF//ULSXdin0VETZDqxz?=
 =?us-ascii?Q?MjWuury4dWeEyT2nODuWOw2/3pKCLzkgOu/VHRBEnN+OCVL7jQ1qDKpIHNDQ?=
 =?us-ascii?Q?nLkSPwG+USEEkdvq74lZ042bUZLYJRJJbjYeTXmbgl40hoXWZ14ZQ+iu0Q1h?=
 =?us-ascii?Q?QIlo1TS5QiQNO9uJtBVeJebVFka5Z4ADyQ4Lf7CocCbKqu45/I9mcqh7XjgZ?=
 =?us-ascii?Q?yQHsUOFQTVqzTbfHwD5RMmX0+vD3yWqk2OVsoSLBJFDoYcml10/XqpxyUjZ8?=
 =?us-ascii?Q?Nm6gW/JIvK5HtkoJ/T81dm7cEBueV3iY52ZfnpU+tcc4L3NKrS7expAnYoBD?=
 =?us-ascii?Q?yQFlsWu871zO56LFlG+f+v3IjBBZCH7SI6iGTpEy0FzgOTTis+OzvlZQ/Ov0?=
 =?us-ascii?Q?eZ6MbqfQKRJfGfOuz4dmeFmIFPZwBd/iT57l58NOkWS7EKwyh3NvufQl5mL/?=
 =?us-ascii?Q?ALxdNQZ8a/c371npDf6kLEDSwrcqD9ajl7FAm7EjyY13GonNkDRfdBMnprrv?=
 =?us-ascii?Q?wIzU5sJvIgCvZ8knJR5Sa5POsGsDJSvRGBxKZBX9DZ7+f5MbngIuGjwVAGEq?=
 =?us-ascii?Q?O5Eiq+ldV6jGsXErksmfEgeyQ+ICqB55A1IzVc0D15HCvDAcA3uLUYYeB1a5?=
 =?us-ascii?Q?ZV4BQiuYs5Yi2TK4U+dGX8JaP5b2kdi9A0Ht4IvFiEYKn1zljxbBuK5pqDKr?=
 =?us-ascii?Q?RSt1uvrpUlZc7yXMg8V71KpESZrkZ3KDt41NbuxuppOoJsRKGA66cjm8kHlW?=
 =?us-ascii?Q?yISQ+4l5UcfguxfOxQgvmQE4hNNg/MMJHu0CtTyhzYdh4tmTRgiXkk9mydbY?=
 =?us-ascii?Q?rc2ykFvEN8IGIwU79jov/dFYJNHvqnhCjFiQUYCOpEDP4IL70z9KVgC72S5A?=
 =?us-ascii?Q?poC38KCmXIIC+RpsYBSlQeq/YhXixJr5d2PgGucVMSpO/CglAYahLRfwekuC?=
 =?us-ascii?Q?UZJgTYPcWMiYr1IcSFMPLbbprhX0SAxlBR8YaBetTIfF32sIipxkh8qY4Sgc?=
 =?us-ascii?Q?ArEVPwcWvlsySs1KbpMM0eOvlXDHByf9qSxmeBm54IV9tUBAEn3bFpRnB9HO?=
 =?us-ascii?Q?fFOAMwWdrM1sWMcyiO47lfFOLPBwuBR37dxn2i19r+zBQCAzIfNsqByiKNcu?=
 =?us-ascii?Q?DWP6EinYWoUkMLXvnRw/gM+VQL4nOk19/Dzfqwgri9QHuHv1AR9uwf0K+XGN?=
 =?us-ascii?Q?qHyEafro+Fih7i+G/IKorijTbLrieF1zdC/49nEnX29QrZ9mOxGnen8XgL+v?=
 =?us-ascii?Q?MGhwTPTrMjbzrZxr7HDpS4iZ/ybiXevkzrL7Ocbmh8ZZz5KlmJe9U5o92+2r?=
 =?us-ascii?Q?F9Pd1RD8m4D3yi0gJbXJgHMcUWMrIFxB/lg9eEEvsGqLcrsNQJp6ASAri5Ns?=
 =?us-ascii?Q?BYw+1rVRhgBGBP0D3jQ7DlvsBmZu70SRX2WSeCM337h6EzlxBgYU2dqP17H5?=
 =?us-ascii?Q?xQy4qiQ4B9zUwqPxdvTJs2a5UNBT5O4=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdaad62-efaf-4bc5-a7a9-08d9b4a806f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:53:21.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7oMEwCZEM+/Vd7V9Vmh++/bjiK8P8FnZpiJcRX2GjSU4ICKG22e8QxmeqHlrjd/CUmfSTWVJc949fVAQPVHePsAu5DyhBZbE56n1QSOBDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4029
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BAIL_OUT() is meant to abort the whole test run and print a message with
a standard prefix that can be parsed to stdout. Since for every test the
normal fd`s are redirected in test_eval_ this output would not be seen
when used within the context of a test or prereq like we do in
test_have_prereq(). To make this function work in these contexts we move
the setup of the fd aliases a few lines up before the first use of
BAIL_OUT() and then have this function always print to the alias.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/test-lib.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9090ce1225..14a7aeae0f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -589,6 +589,15 @@ USER_TERM="$TERM"
 TERM=dumb
 export TERM USER_TERM
 
+# What is written by tests to stdout and stderr is sent so different places
+# depending on the test mode (e.g. /dev/null in non-verbose mode, piped to tee
+# with --tee option, etc.). We save the original stdin to FD #6 and stdout and
+# stderr to #5 and #7, so that the test framework can use them (e.g. for
+# printing errors within the test framework) independently of the test mode.
+exec 5>&1
+exec 6<&0
+exec 7>&2
+
 _error_exit () {
 	finalize_junit_xml
 	GIT_EXIT_OK=t
@@ -612,7 +621,7 @@ BAIL_OUT () {
 	local bail_out="Bail out! "
 	local message="$1"
 
-	say_color error $bail_out "$message"
+	say_color error $bail_out "$message" >&5
 	_error_exit
 }
 
@@ -637,9 +646,6 @@ then
 	exit 0
 fi
 
-exec 5>&1
-exec 6<&0
-exec 7>&2
 if test "$verbose_log" = "t"
 then
 	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
-- 
2.31.1

