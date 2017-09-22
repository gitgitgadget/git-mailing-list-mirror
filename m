Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1819A202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbdIVQgo (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:44 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:49189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752385AbdIVQg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=grQ2+EprCArANJBW5KehNt7FZWRQ+Mey3c+8nOqavIU=;
 b=LZyaU4p23WpqJ1ueXAobVC5B8uERzZpi/EK7BCpLG1LLJw2qNSCgd8RLDm4aekt8EWqMRKC/uuFaEAbj/rHTmnS2YBuUttukqkK718OOXQmRkhMEEABSoCYxmks1nRg1OCHfJhNEoPuxzA0NQXpgzkcgLc571Ba2P4vucadVe04=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:15 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 09/12] split-index: disable the fsmonitor extension when running the split index test
Date:   Fri, 22 Sep 2017 12:35:45 -0400
Message-Id: <20170922163548.11288-10-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-Office365-Filtering-Correlation-Id: 7ed51fb9-2761-4abb-badb-08d501d80b44
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:PPziG5Ra4WFixosAlvBpt3lSuL+gz5uQv214LjomcFlhOkLXLno0DHxE6EsK4kPkanmhrSLKUObE6M7iM+6cBlKMaHB00WfgB2N+7MYG3IvFqpSxkjuRKVJLvIvGspt6HLsqMFMQuN6wylcCWF+NQ7wKwnHD/4GVP9lxUt3nupGF//vNSFOD/WJiU9c47I0zN03zvoRJ5LflNxpV4UOIx3ZEOchjQ2MNgtkqrvBlG3hosTzgEAMtY8PE+2wGdKeS;25:d4ognKx+pbjELj4219P7BkzY2C1IJSmaER4ED8OAiZLTNZrvPANpZc3OiL0RN532yM2BGE9NfSPjfyQz++Ho9XJ9v2ONAqrsIrA+6GDQHXNBZTWK7l2YL/c/+NpupsgZUm+0yHSIHWx6wD4UCRCr6oyrZyxmNTR3yI41uySxMEbII8mTt2k/HtQUR4LP/l4MJJy9FXsANqTwUgKR5DJieF8bVbsanLcgIXEpQK6K4UDmFhBE+9+VaEx+OlThnj6HDxFOfV/UowVlCY4WRhAITF/U3DjCQ5eaBY7s8w38buQyd5frDNk+xZsU7bpOHyeFkR9ZJMoef7QOvWCnhM/f+g==;31:Ce/EVnlmJXMafiNC4QAkPY/d0nzubbpT1QDpu3fTYcZPKCUOaXS4KzQo6BbyksnsvF/K4q5eVMETm2EaZZoZVREplOLdUIz7io23y2C0C27MjqJh8Y2zrZtGWPXL0M+zJA2ZnVKd357rWgJ4FZycAUC/h6kpgTWA8eTzeiViW3TG5IoKJjyNOFoKmIaJrlHd2iIlaVAh13di9XZBGlNtOSZE0DkhghWYxbG2YhF3fUo=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:7J4h/gfgpLUHnVwhpje6+0qI7gHJFqThUHf20xFZCxXx2gMb/1EeX5TcTb8fpLVe1O6rr5HTTYsTRtMeK5t+FSEq333/5JavsKDqdKnoQ237N6vOhrWvV35g3bmPZe4iQpKnZ2EPpjGE/cLPbijICU4aBupd0epIgQw0UpGBRSJwDPXybF8FYWQKwwffWvCoJSJ+6uLuQuqft48ot87/5NY6BZf7Bg3pWuTKkhAM1tSxVtHlnrwNtELx7+B+YNiOrDK+WzuZpK58+/4a3+nwi9LaPDFih+0YPkPa3prWmoWVIHe0IaOeuO5jjkQuKudokWC2RykhiTIOZdSxxtosBx8kF0apPAtDfeRtZgTKF2mAtOvuljyZ0wpL9e0ZcBO/gG11C3vOIgeb8TOG1AtEMrQ3UGTsbET142yH+0NQ7xGq35yEpe1eiWxbVW/7SpFEwXFcvfoMdrjtdb6tE1zCVvxl7EvzfJHS4sqxu+ePLBhCD0KRD6AL3nryvS5FaHug;4:MUadOLTe2/7EU9isrjs3OWcsL7BeXTBgmY+DHYC9azfPKsqrR+SdeNQQa8YL9/s4BZpBu9x3gWbdQ/Ud63lUlNWmADDf++yjD3po9Z4mMYwsZGYCAMo/5G/9j5Lkki/rqj/ELdMQRTd4gGlQoQaxi3gpthG5gR8g1CqRuzUi75etJ34in+7dZFCXXmYmzPx6RJIVQxwfI2/hKQqCrYGs3nGVyZEy4TsKmnl+nFZp1MZ95nH+H0H6R60LxseVWWJkB04qA6Q3qwXfnwp4krBVSpsJc2KeH2CVICLekD8kntc=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB04665DA013C96357C6ACD1DDF4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(68736007)(76176999)(50226002)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:V6kDvUEyYTtot9pdyEr8SP4PdobOp93TsV2Hxps5N?=
 =?us-ascii?Q?tyEbW1YihhDyhQhn6htxg178AhrVpcDgrRrIu3ZA/nOtjWXCCdyg9Ksh3Qxl?=
 =?us-ascii?Q?469vOddSL/F7FYTq7kNfZAErDK3kVDiCLERdvLaJlNI8Fwxvm7h8nCGfn28P?=
 =?us-ascii?Q?hklSyBsPbWOduPtpTH7pXDEZabmTZv5Ldv2cCGnSWc6xggbmSmibLXx7slbN?=
 =?us-ascii?Q?uYHSO/ciUVPf1uChpzaNrJAzey+GINOGVFKAEuxDXb8WmVLu9CXB+rBpNSqX?=
 =?us-ascii?Q?ViTpx8r90MzibSKeA5URcpj22+gZlopn3BiWTHmgHD1McxVG/sj+knWf2zy4?=
 =?us-ascii?Q?jBnIcbFZQ/y5dE9gqvnAWi8brX6ftYbW2tS/p42dcDXR8DFiDeRH7W/qMfig?=
 =?us-ascii?Q?OxPopUpQ078GpBmCYdNi1RT68lbpio7iKrS+CEZcgzaJTK0lCePShAlJYbaq?=
 =?us-ascii?Q?YWUic4E092A+bgjuyNpcJAcPEUr9ToReJSe3DxY2tdMtfuJVqUE3Hj1ey8ee?=
 =?us-ascii?Q?9dcEZ3zx3F0ttBEbgsmeHankHZbP5vft3ZJJX6hPRisdk4T3bFBhBSPQ+Q4B?=
 =?us-ascii?Q?dpTBypIsG/wLOHkQf+RjSyL/Ck3uiDZSIKviZlJNiyuNg3J9UdivUmHwP2NU?=
 =?us-ascii?Q?5CTKbF7HAm7bKCXmgV5DKCN8ZMtIbrSllC4UmSuj9GjdGq1gHT8YZ8g+e69w?=
 =?us-ascii?Q?UKkb81CMmhIIJM6fUoWdjZ35iaGW+YbU17FPWM0W2MW+rAr38lQ3S8p8wJqT?=
 =?us-ascii?Q?qPqvE61YFgxkyNSVChWTRgp5C0kpkQoMtz8qVUiQByPnrjViXYiC3hF6Kn71?=
 =?us-ascii?Q?OjDkyuy6/PeAkv2bsiqA+0sk0jiiKe2ZJVma7tx6D9Tu+MWiVi/Z5b3i+YmO?=
 =?us-ascii?Q?YWmQoGms2/DyMhIYopqXiEky/ONRF74hWHUkG7UChQ/cJxLCWYKYoSAos32s?=
 =?us-ascii?Q?WcnhrI6lR8SJaSvkp3cXyoYuUd7J6j7h2xZkn7ZyMAb6+j7LVMh/yes++mvE?=
 =?us-ascii?Q?jSMCVeRyvHr+gHZzhhruQSqSsAcN1SAT5zZSbUktmDhiM9uS/khAZnZAIUh3?=
 =?us-ascii?Q?1+AtxeEKDaZ2bOusKFEv+Ul+2qHRY+7w8N9dyVIn1cFusjrBzFODylSozq+k?=
 =?us-ascii?Q?y6qOw7JVE3sz7YrRcoWJsXGcO5vWwS3VdQYqDUvvfIMZKMjPNQK7nhLSQjnY?=
 =?us-ascii?Q?pV8M62Sgaqv5ZOtvSweqzqM/ILzLwtj8YMpETMPHOymZlV56e8nU5Mdf+PVR?=
 =?us-ascii?Q?D5Vddw4jzeWdjLwqq2T9ueqyqC7E+JEmHfaCATX5QGma/+tO78kAqX9TXWyX?=
 =?us-ascii?Q?a8sCqnVUSvBPL070JSoc+Nf/ltDdLa4yImCdpUftYz01CYFh0bN+Svrc6zEh?=
 =?us-ascii?Q?RU346PLKO46DPtpc8p2yddUpItH/Va+f2ozvKVEVWLEZZsM4u+01VwDlaxE9?=
 =?us-ascii?Q?ADAXrp2KQ356LOtF4RiWIwhEqgWx+8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:rPvn8WUM98wIqORhPTQh+wQCpuGPT9/CPEVanCg+h6Xw8xiLscm0hlNcOA9J94Sq0RW6PCD2eyLDaOhxluVWQp0+ToKo6rAA3YHQuTEnNOPZO5DJ1+0yO1hhUJoXN1CfsnTkJGEmqxl/E9/dEBBzbxcmLNSTbcgFPGotb8Mzg0Od2bnlGp87d+WtjvbJC52MT+QnPSqwnaM46Kqc/Ci9ZiFwDiymTBMqk8/jVjxGNQTERfkDCNblEjhfdmY7YXXcZS/w1Clm02Ht6sKGS+LNPB99m4u+ngnXom4AvnF0ck+4q7tZiLEPRHjdkMhWMiGEmAxR+q9FAEtkRfzlsDXdSQ==;5:IhvmLGZtbVSY7XXxxPY/dbdiRm79l4hIb2Fpqmd0NuIJxthEpQB7af4BkBddiPBGSxnti0s/LDnh/UcC6H7S7T/jQ0od1fQmzQjnDFGjlIF03PFSk30q4YcQ44LVmtxYUIGlEzDRL/49DHfE0ehytQ==;24:LuI38grbHp/bN136He2rIS8SoYPKN34Gd+qyaMsClrrPEhwsU2lpsiS6xCi3ruJQDb9HbCWzuVGpI9kzV/ZZQs1ZCGq9AJcljjTsBRDgmGM=;7:4yIZuA9OfbWh+KuYBfHhB93u7IlShYJI1l5KTYeplR+dCJzBr8SzUNKD5RMNk7zl9qIZxGcctI3ZgdIrdoIOtyVS83kVyGrpzmoOaeAQM2PCL1Hn9wAiDnNpn2wqG6WoX6Gag7qLjr8rKO0NeXDv8qsXgeGxELJbI4EGZZCOIi4+cF+hxz7FUgx4X++6m/Mze8eg1dCHq2Ctg7uTcjwCuird5Oeqr0ga+XFZFu1p+lM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:15.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The split index test t1700-split-index.sh has hard coded SHA values for
the index.  Currently it supports index V4 and V3 but assumes there are
no index extensions loaded.

When manually forcing the fsmonitor extension to be turned on when
running the test suite, the SHA values no longer match which causes the
test to fail.

The potential matrix of index extensions and index versions can is quite
large so instead temporarily disable the extension before attempting to
run the test until the underlying problem of hard coded SHA values is fixed.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t1700-split-index.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 22f69a410b..af9b847761 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -6,6 +6,7 @@ test_description='split index mode tests'
 
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
+sane_unset GIT_FSMONITOR_TEST
 
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
-- 
2.14.1.549.g6ff7ed0467

