Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397A4202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbdIVQgS (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:18 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:49189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752506AbdIVQgO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C8cIlkLlBpG52f/M4Dutix9OaXWLkVh0eOIzk7h9Xfw=;
 b=CMgWacLO92nzE+1s4BqLBJEfiP3ETuWHHj6yYbQQZcLCAcNtmW705sWoRvvNardCFC3MMokB7GWKt4JXID99H1wE+RLlcB2NQVriNXH6Mk05quZ/kUOJ/KZwNe4sL1njP6znqvPBU//UpD/b6fekwppbyPEjGxjuFHdaslx0imE=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:09 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 02/12] preload-index: add override to enable testing preload-index
Date:   Fri, 22 Sep 2017 12:35:38 -0400
Message-Id: <20170922163548.11288-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-Office365-Filtering-Correlation-Id: e71197c5-20e7-419e-44b5-08d501d80786
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:feenLbQAdFJ7u66AnNV568b2Nb3myfot13b2rzhjcDnjDRGcbWdQdQFmX71uzeGEjYxV4tMOveyGMdtQY+UjD3v/jitBom+crg6Vh7xAa0PtVdRkqxA27MXBXFULgQHOpkqKsq5zglo1y9QS3zqb5Ouu29KJs/VIPKTT+7UdpahNMasCeOm4qbwMRbcGKkaqH9fGQRRMZY7yVqOfmX6dAFJW960Nb4axU5o7NqZhouULZA6thJplFCxNQTReDb91;25:cbaQY7JVXycmiEIJa1MOOIfCC80X9Vt9vnNFpGvkcRTMwt/S4iZTddJ7/BHikowAQZENtPrN7bDnEyquMtPj1uu31N6ma2JA1l+c9xckWKmxxOwc6QxjTpdZytGngBXx3jAZYZ5YebyrsqRjXmGR1bGxJk2Wxsxu4Rp1wEUpY0ScfzOmJKkhfyZ3gTsnFyrClz7GCQBTYp6AcCUiMWM7LJc+NapfiDvCB6SEtzZO0H118C+e7+ozLMtCRIjvHEKySQyC78uFVuvYJblqyBO96qt1TKnhFG2ZwgCO+RrAyojDkzLZLYlpXuJwyIW7vBts3cYPc8KlkopOLxCLZESZPQ==;31:oJUtd1Yb4yM/JMArf2YxUjuQdNZEtDRFOfjBeYy0uAg8ao/SVv9lxxOohQ1hxnHII82gOWtueXYvR9CWILMrtA2tN3MjtotcgUHK4JLzz4I6Ntx1uJ58EAqBK61r8gbHZrvmBJHXyPQB9bNrMpGMXm7emGJt2mZb2YxS9o3ER8wrO5iVVjOT5x35y4RciIC+VAPx8rmL0IBy27BPTndhZnHGPwPPjVwi90QrK19AmRI=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:XlVUgOPPhSIUubJUvWvi4CnT52DCudV/tOQtDqhURHSveINzpMeIEjWnazMD7omH4/ZQYfTa7kNX+tXxidXeJerG9qiv3H7aSnzMhqkmO5K/TOsQkf0cViFoMhIcdpF4Dkau28lykk2catRTjq5XnX+S2oAa+QH14jO3Pr3rcF5HAFshwwHj+nPs+CqixFtauOfCBqkvlGmI7bskLdfoXXrrrh4NRqu95JhjYYpsCc+ND88kFFH5fHtEr7gcANA2sb5vmTgkiwvufom+oYg2vLLr0jQIJAuifPOA/xlsRHzX4h1ZLtsv9G90yPI0L/8di6kKOQM7GQZuhNVBCKbNbMNscSn5NcHxC2REVYiP56pFKE46rdFGBOCEBI5r5H8rvox44q4Yflh/v5dwZW/NrXMm1qbz5lqJ7KkqILheR3YPDCt4gK99QYxa/58r44H2//vucKa2oxZlcoI1KSGLscrnJ+xdU+hzukZkARn/Qwfy8NugW9u3n/VTLTr94Ttp;4:cjMDfIGGWehP6hTfowshu8gm1Aeur8KYinPttXunBc7s9dZvgLjNeNICR3KjJlkLX7KZ866jkNKo5L3oa2lY9oPCK5B2lZfAVZd/9QXbWkym6e8M6YMw9/EDZefMOmZPimimVqaQZS3jP63pLzhWarftfg9/MbMHVHK60igoZIfKE6c4/c7rmPftQ+K+FPsrHcCrRpht2Fn+eYvtl1e33MlmwIAF8CTZiKoZ6Wv5x6ZEs6eVd9M6BdayZlakLA4knG3egVngAuMEy6OdOsgt/BJiQY7PQXw//SS/eDeIO4M=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB04662A1B8B4F582092548A5EF4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(68736007)(76176999)(50226002)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:R3USuRKtJYbR+w//2wkGKZ3oztHQf1Puf2nMH/Ap6?=
 =?us-ascii?Q?5ZEgVPMnMHDWIIkTIayo/5T0fBVd5e4SQ8nUpOClJsarJewLYmmf2BhkZtty?=
 =?us-ascii?Q?QVsko0uS/KcVs0pQxkwY2DKGNzaORGMcV1HQmmf/ardNOgBd+MkR0B+tLGFA?=
 =?us-ascii?Q?DqnMD81oib6O+4EkDwWMszoH0+Afv+FfNpNR8+l+/xzaKxiwiYG9hnJEls5k?=
 =?us-ascii?Q?j+EvVJDRzExaRBdGiGQ5X5QoIte8TFXxJEdD1bUd9iHIePAuJ7LLkuLiwMY6?=
 =?us-ascii?Q?wQ7+Q7HdnfldKwxgpTwNzVjqNvdRb3i3P2nl14ACR9mHciPf/ZpLLBV+X7ic?=
 =?us-ascii?Q?+qPNW6UMsfb9q3s52JREN/Jn4gJaB1aOCZxRNusMhGBjhM7z01IVxiYGX4SO?=
 =?us-ascii?Q?y356QFrZ55MYmiXoX5HOg/HVeMjr+iuuYPLNEMdgX8YnKu5yTbynzwKWL4PD?=
 =?us-ascii?Q?RiwmM2GBtFZV4j9ffdTa81EN0RwPUKowTj2rtiIjsaQ8w6s8iSgx3890G65+?=
 =?us-ascii?Q?eaKok3Hp3LFCkuz4tCRiEbHtr6GIBhMGKkQQ/vYoiW9RwcnwOorg9ZKlS1i7?=
 =?us-ascii?Q?Q4LXedmlVqLT9ZtQhBDhDHTmJWZ0D1u7+TOoAgaFVYNjzQEmDa0mcwBugLc1?=
 =?us-ascii?Q?T4zo2TGzJ8/g1yjbY81zcmB7NjUS3wfuHgbqH5P2cfgDD5MToOF7Zob9fJog?=
 =?us-ascii?Q?Tyv91R1nn37ALn9Be3ikrIPDt2XNaShpCFYwvVucncDpF0ubBIRhnV+5FiTO?=
 =?us-ascii?Q?38ZXIXInky3dB2czpcwcghX08AdoepVkqeCUdvbaQMK9D83hPHtflKFm8+Dz?=
 =?us-ascii?Q?Cs35JAKPs2x9Ux4UN5IloeCVsaMRU6l2uR2RWuy1CXrx4yVLeEz19QN6psGM?=
 =?us-ascii?Q?JTReABrNjXKqijnlbNZvkoSbArKv+nclxcxzWt19qSiz5mGoi4Sh+YC/3v+l?=
 =?us-ascii?Q?woUOfHLnJSsiOifG//Fi1GSuo8b450U4ESOeRvY2iFwwIGGOl+gdYIdIFRCs?=
 =?us-ascii?Q?GKavBJlDaE3k9oYJu8YeaoEoMUYaO47S1Zoy4UEPbEeO3jZVRqMfLmoNXOz6?=
 =?us-ascii?Q?ajRzf+NGFPgZYY82x8bcNZCvGA+xXFButPjyhbFM6dt3KavosDCHD80sfFQb?=
 =?us-ascii?Q?3xjIgdESTUwo2AVRqSYoU18odCG2PBdXyk2cAwnsPydRMZ8aOQQ+1qF96l0L?=
 =?us-ascii?Q?FmIFs/MhnDodqonM9PSBOcLwvIQD0BYD6TxEKT7P1nLOinqSakigyJLCnAfY?=
 =?us-ascii?Q?yjVjP8FOB59rSNM2FI6c6HAc3sazuQr6wkBgYDe0p79AGpSd8xsKywqwXUut?=
 =?us-ascii?Q?7JYp4j79sUZPIGjA/IGGzlwAO3DLWoQE0gYkiv/NYjpOk/2kuxnHzbcJvIZb?=
 =?us-ascii?Q?r7y5sVa4u2feyt+WBNCqZREJCYBEbwI4xi79yYS8SxwYFsEvzLoehHrw9kGu?=
 =?us-ascii?Q?bllSovRy1H2cNjKPVLK5CdsW0EKycg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:51nozz9YfiM7AGSFzX+5CTXI9iNUtcrdTGAFvFArDQA5mcVwxE4t+4Mc2zx9aZOxs3eR5EuUGeCVVFGpl7jDNAjJMJGumHo5H/s92zA30S6gmGs/Ol43GkPMbTQ6Yife6n8aBUMdnMgKonI/zFlIWbjWdKhKSXBnr/7gb4MoC2HF9JwQSXZXj/ML3ncLjunAZdKRN3npgiFbt9UOyp7O9Ir6gkVi8IDGtpPPkQaApwpSrghwMSfcnn6n4XeQ4GyzTqgkpOMXsC02Kla1LMJZYz4wWMDvbBIykBWp2plRAosgBeZwK0pCRJMTa6l+Rzkpn1dopvOID6u2kscosmn/Mw==;5:7/7weV/2mGXwAmp27ixI4elanu8dlkSKpyWqZ0ey/U/aKD9SUr24QYZPVDD3MhcMuQ8iEZIMTyQ8q/PqCDiu8l49k2jdMwve0ZIyKDQ1GuzbQIen2w5MMQ0B5J5aWCO7NqqLYBynB3UbQHvuSOliyA==;24:5FbPVFibwPgtYtlhYe/IG/x8cm5myYDwR68k6ahP19luXWDuupr22MvXjuGJjWOb3rjiEBv6LZHoDzwIIYPIJs7dx6IRoFEG1WQ7nHLJIZA=;7:XL8TOeXFm1XUfsLB6oZbN5i/PVySR2xWDp1XzTKOgrB6I2+TSnnHMyw8fw91QGBcqR2sK1fZoZlg/E5Mfj8pa7DJ4z5fjbFuuQcTsu+S7hYkBphdai0lUKLIP47ZOGLbRitgUH5UPopAbx8KRoNZtOiMesLMWcuwnplQi3u+zReUYhCjN4xPvh+GChSUIzrE1p+GUi3+dlF4sL6ntDxw2e38X+LX8nD+6TzhXYydAwA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:09.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, the preload index code path doesn't run unless there is a
minimum of 1000 files. To enable running the test suite and having it
execute the preload-index path, add an environment variable
(GIT_FORCE_PRELOAD_TEST) which will override that minimum and set it to 2.

This enables you run existing tests and have the core.preloadindex code
path execute as long as the test has at least 2 files by setting
GIT_FORCE_PRELOAD_TEXT=1 before running the test.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 preload-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/preload-index.c b/preload-index.c
index 70a4c80878..75564c497a 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -79,6 +79,8 @@ static void preload_index(struct index_state *index,
 		return;
 
 	threads = index->cache_nr / THREAD_COST;
+	if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_TEST"))
+		threads = 2;
 	if (threads < 2)
 		return;
 	if (threads > MAX_PARALLEL)
-- 
2.14.1.549.g6ff7ed0467

