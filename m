Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E571F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeCZREf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:04:35 -0400
Received: from mail-by2nam03on0104.outbound.protection.outlook.com ([104.47.42.104]:63106
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752687AbeCZRE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Puhk4OZ8qa+38sG6Sn698ZVLKWAYYj67Diz7Kz+iis0=;
 b=WB53WtQY6FWwhTqdeK5k3taAVJ3UGAXzulsMbYaTCR3R0R9TsAQMDVzpms65viSUqGbErRAZd22nJpcu8r/4NRaewLrSa6MO0TCPe377g8qVnN7IWhkYS8J7zC3tociPx3E/HG9w1B8fQZDf/pgDT6Ubru8sPbTBRRt+bKZbUWw=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 MW2PR2101MB1115.namprd21.prod.outlook.com (2603:10b6:302:a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.653.0; Mon, 26 Mar
 2018 17:04:27 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 1/3] fast-import: rename mem_pool type to mp_block
Date:   Mon, 26 Mar 2018 13:03:49 -0400
Message-Id: <20180326170351.197793-2-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1:1060:bd2c:4297:50e]
X-ClientProxiedBy: SN4PR0401CA0030.namprd04.prod.outlook.com
 (2603:10b6:803:2a::16) To MW2PR2101MB1115.namprd21.prod.outlook.com
 (2603:10b6:302:a::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ed738b9-ddc0-4909-97bc-08d5933ba24f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1115;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;3:+V02u5EPpEGln1CkZzaVDsHIRdWcCUDS+yXWMSotsWMCNx3IQWPFRBhQTziDcCK2VDWU7KX/ykBZ0/743O/o0bSUUoSfGFtgQMbCfAarrRi9FzNgP5+MfGtESknEYFO1rhDlzwjVUbnTdAaCluUb9bVyu+sFym3KmTAJlNZ2z9NuBo0rlE9zadTH4srTBvEUSERfQ+dA+Xjd4QHFmmpSXhiGPuebnmLUZ/bRCz95IxgPbWIYqxP9+IPdMCkyg2Lj;25:U9Mgc4pNVpvWLPCpMEcTUoZBA1lATOmtKfGEclXTnN9g6mOL++p78sYJZpFYGQPiV21s3AW7C1DoEbUhrm69R+7sQTEwcxROihEcAfPMkdrp3quhAwXr30PzPOHsA4wNx9IxbdR2rb1QMuEcVJXn9VADgIEDxW4rgUj+nOWsWoHzIT1r31m8TeC2pYFf3EPtjS/JVAXg0hukE+g1XJ+RGfE1DUM2NrDGof2BFu/kOInf8k5+Baqx7apjXl0mr9xRLKMXCTjl8ercVI1Zdw/17Noqw4DGmgj9b28RLyv7Wjh0upT+tAwoAmEZCA6Gdlzt1jyrwMFATpy44Ld4aV6Y+g==;31:rd+bHiRTEufspvWkUkeMsQzfFBVvR4EshjQp/GugkMiZM1s/FZ4ZP2KHzIZBaGbEAH+6ei0c18ETs8Gt1iMTRX15WVlmwPrKlbxBRz9HFP/0Per3J3ezpF/pXNIhwZBVcPTijXmYPe71zXVDAzl1DumCfptHSxfhmfPk7MzHTPF4qhAU+1LN72oLpUx/FXccFHb5RpEkk2ACl2aJW2e8uF/xZf1JPIUmhxVN05VhfZ8=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1115:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;20:Tf8tczyWsOqklPYH2xEeqyOapQwrGMC485f3MSd/NXvmyZ6nIR3f6hJD7UXzQ4Bxqs24VMxpV9xT5RMB4mmc5emoCOh6+sd8D+xrF2vhYIw6ug3OG3HqEn5WpE5cJEVGsVkffEXjy1BufDk0mhpNtO6iLpqwtEujPuvPf0NBNVZffM3KfKCfyfOdjXtNOo1TVn+V6AO/bh3gMaEAkqDiKeiar+DftNjM1dJ6R0wHQKML2T25ot1Cvnfr79vkPp/Ub7qBsifKvL5N1q1fHreXIRvEAvPzug18g1hluaqK+bwdI13iIN52hTNiBrdO28XiOLbttMMzpwBWVkSeP4UVJso86WfMH5IxUcreSbhXZduzMFdbYsW6xduJJU3xxQExccqvsIh1k3M9TL2BrRsxy9wNUSf9iREH4TR+fw7STj/EtrfThtfXBeigS0NpUM7Ro8gs+2N0IWgEjeZKed+sDtC4PGUddys+bSw1oE9dYqScnN/yPV5At3ZryrS9PezO;4:NYqw1X70RYy/XhJXG5MpO8lbkQnIgNISVbQSkgh/j7HU8E+OKWDPrETHS6cCPeuU4RbT4kT2jUR2M0Jaoh0689appLWx+920chMMqwSbj4Yw8CI68A4s2aHY4ysHn6CUMC0lQ+TbbUTwGp+8h5wudrEEw5vTm4fb9VuGzfWxzJCnYIdQc7ginJfiaSYgjqnjFjPuTcaVPgKhuhTal3xlsjYuyGR3OFOH13AllM7+qPxVsqv7484SPYqiLSwMJpZ3aq3PXWE6c73TBMy9RoGx9TSzbMoYggWk8oVvntvA9OVc1aO2Lpg5toqEVm4j1oTXutPf1X/B2696s7w20R0sSGHxo/o4hSzichSj7MZxLJE=
X-Microsoft-Antispam-PRVS: <MW2PR2101MB11159CB111BECA5B3498DD0ACEAD0@MW2PR2101MB1115.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(316002)(81166006)(52116002)(4326008)(8936002)(50226002)(1076002)(52396003)(6116002)(48376002)(51416003)(7696005)(81156014)(386003)(16586007)(2616005)(446003)(11346002)(8676002)(22452003)(36756003)(6666003)(486005)(486005)(2361001)(25786009)(6916009)(5660300001)(2351001)(106356001)(8656006)(6346003)(68736007)(76176011)(86362001)(53936002)(107886003)(10290500003)(105586002)(186003)(6486002)(16526019)(478600001)(46003)(97736004)(2906002)(10090500001)(305945005)(86612001)(47776003)(76506005)(50466002)(7736002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1115;23:I/MIL8PSQGi3vKaFFNSQs+E3gFYU43csfn0Hz5q?=
 =?us-ascii?Q?w1NgGr+09KJNNY0s46FP6c6H+vhiQKcn/8s/2kvX5QSqhIyKeg1axwT2Nk9p?=
 =?us-ascii?Q?NCJAS2hQVTvb6ExhN+IBysA2E1JSsf8EONG6x+5N/xpy4vWpax2pTYuJSNzR?=
 =?us-ascii?Q?GrdR4YvWYBqmiCXlKNTQ60L+eMFS/qsAys1pXGUdyvSVb7HnS0CVOGgZco3J?=
 =?us-ascii?Q?Xzzjlvih8KaXKDBHiBoWEgT/2efNyGXr14nY6Prx7EIhvMG0IGHqqeTsVfuT?=
 =?us-ascii?Q?NLratUU17oZ4bkQxP6b0VSl0ji31Ii9ACHnvbiUXj53SKaUbBfnUCELeEYUG?=
 =?us-ascii?Q?P5Jy4jAuUk+gzTXD8WZQG39CoXwaVmTzor4363mkBLGvuDQv987qWPe8omEe?=
 =?us-ascii?Q?8gooQyPt1bEsH2nhy4gy/gShmtOpJyOm4CFmgrKgCWl0uJMFBPm+NNGZbRnT?=
 =?us-ascii?Q?z/tJ0H7B0x2pyzEMmHXEabH+xWiylnvCMmWaONCHtXPr2KA2Ck/BQeQpHbby?=
 =?us-ascii?Q?bnV5Dd6+1ds5kM4pC3F6yiSFNyCMnw/8KWvrBPHfUXoM8ne/5wRZCWBIOeCB?=
 =?us-ascii?Q?HmcKyq23OuxfV/L8Dr2ihyL0lAoMJRtapPRIoF8XjqPa4llYiL9Ec+E0jLK0?=
 =?us-ascii?Q?0veCbThHlPWs+/BVWFzvThpxSo/X3FB8A5Y/T+7XbelS+CovkwdHSvamcuFh?=
 =?us-ascii?Q?tOCvqCZPBMeuXVh9oZ6URC9eu1sWFaxC2kGaLgn8rPZddi3zGbvw3P8uEP2p?=
 =?us-ascii?Q?/GmcY5r6Cv70IFPLSNS1sstT0V2YK88ESV+dUm30BPxRg6IA3tFoLeKb7X3E?=
 =?us-ascii?Q?puVV0kNbHpC4W49pEr4Qk31DrYvCc7dKMrRRyL1HcWwQvcjD00I8x5EzF569?=
 =?us-ascii?Q?CEjBye4rDqYl8zCDq7ufZftagL/fdKrbb8s8i2wT6x4s7/Dgi/KB0CPQ5R/k?=
 =?us-ascii?Q?WyGnjMizvdTg03FRlgg8e4Hf2iln4GOiZgRmMYg/cZvebo9QOm4hrDaBU1FP?=
 =?us-ascii?Q?h7UpjKDdnwkuP+nSOrgVacT12dG1CAxMbUUYWOIjaDf+pDEI6GB2UD1kUAIB?=
 =?us-ascii?Q?ccFOGFHQb9N08R3Bfeb/yjnwVY+7s9PEfOj6APdfpf4TzXJ0RqgGspJaU6BJ?=
 =?us-ascii?Q?E3L3ap+DQwTW+qcJzvRYlvLxJkkFQmgLobZgnvW62Y6cAfNTuFbj7U6DQGzh?=
 =?us-ascii?Q?qHPlniPeMyWj6HnfaVwUs+gR0CjeXC59DGbSx8nlZa1G3ZtUu1kdY4n1UlwV?=
 =?us-ascii?Q?NsEGSKVuVlioFip9X1Mm4CSfVDV1/T69Bcw4YfkUBwK9cZJ9BZXw+bBW7+cT?=
 =?us-ascii?Q?XJP3+F3psjbf2gWeGU++oggVN/YfCXcHFDOY+0IOoAbMnuB0mz9hLfgE9anY?=
 =?us-ascii?Q?8pVolQgWapEckMfI+xqqxT9lh4guBG0T71iYBtox69+uZ9N3C?=
X-Microsoft-Antispam-Message-Info: B4R+k659wlC6y9UfxX+xriOM7q8RFRXWvvV3n5Hf6VLnMbgC9TYUvpmfYRUdVJbAqdOpiIWgvL7XZBt8Z6l7DTOm44X387w9nWDpcaDLiyCgxKQzqfoD3R98WuTFGLMHuvaEEtxihsJ7xqjFDqnRdbBGkDXlPOlMZRToLBSmnXwOwfp/A/xdhw6q1sxXb2xu
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;6:l3zPEQVv15FCLpmRA4kZTYDP9ttIMVZUa9sn/Dpqe0zCdtPROTFpptjYsqsnvqfZKeYLVjnxLCJK3r+bI5lLok00j0WLTqCRKhvIcdilw/Ab9x6g2cUTnVVr9wIvwW5gXDhe8rBpt/E3205TudO4jgOxcKdN+3jXtHaVc/HwL9hfbgu7mKIyNE0Lnwbcij1aHuWxUJRoLAaXechG0kN65DsfYffW3j0Yc/XUOT9WUtUophbSWIg8sEDW6Y6QFyAn5gn/l8rLl+ucnNZj0lsYvnqCwtE1Q6MYnCjLLPf3nHXmyVM0mEOQj8ht0UHyU7tKgkkkrgfU1FL7axnwtHE26mQ/QGBmhN7q/tJTZPkr6EcOLwXrH/ABEGf+3VvEkKSTeeg/NfRiukMfyVa2PtMOovkZYUcklRCxlJ8HIGoo+DwxwqESuYLabRKZuWpOTMn/cZd6pC4ry8zU9zXttJVPJQ==;5:hJw9qKK0BGxjMn9L/DmDb/z7Vq6K/TxgvrCuZyYj80TgWhKuSvCoUBMptd5+U5TqKhP1+J4eBzjh/fImtx7whOh+h5Z2NxdOXrHc23IenBkT9I67W+o3raGFpK45s0QU9xVFXkfFfn0dTiD2trhD/+3QYAaFNGsJTlTUoLiTs6k=;24:SXpbT+zsbC3P5M3ZGRCFUz1btDV0JA3ptVkoRbvNdjHWa9ol3RBEL4hSvvJmGBqp9s/SinmFtDdhIPuTC13ht8LiMMdbiHTJhsGQ7H+YOys=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;7:e2LUIcLHIM6U9yAgo7AGEHuTykIY1o4B+fARXu8B4WUKD+ZeZLPBwsN4l/Ce3l7P0Uk27EyKR3IgGEK2Xnv/RqI7YVQNOCxiZSIYRDhJeFSeCPkT49IZoJifXCeRVqoqPyO6eTeolxa7qEifxlrTw8Vu/lXD9UW37ZXUnmAPW97iINGJxAOewlLCQlmVmKC69rKgN7OQcvz2fWEaTTsYxPXQYocR3qw3amS8tOPkkulgMONAn7YACPqZ6UmH12g5;20:+TFJUaboHN46d7KEq0R5hGpNqxz/XmWHH8/o0gW6xtoljXHkmu24oPPQeT7h0BeUnJT5sBJTmeelbEj1qHJt2s/65MAVOIG2TT4EW63k40Sjhj9WH0LBvoniWMNrLkIHZrnkUOF6LZKOUzl+QJd6dS/r4GU930FgPneMEVBLpU8=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:04:27.2207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed738b9-ddc0-4909-97bc-08d5933ba24f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part of a patch series to extract the memory pool logic in
fast-import into a more generalized version. The existing mem_pool type
maps more closely to a "block of memory" (mp_block) in the more
generalized memory pool. This commit renames the mem_pool to mp_block to
reduce churn in future patches.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 58ef360da4..6c3215d7c3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -209,8 +209,8 @@ struct last_object {
 	unsigned no_swap : 1;
 };
 
-struct mem_pool {
-	struct mem_pool *next_pool;
+struct mp_block {
+	struct mp_block *next_block;
 	char *next_free;
 	char *end;
 	uintmax_t space[FLEX_ARRAY]; /* more */
@@ -304,9 +304,9 @@ static int global_argc;
 static const char **global_argv;
 
 /* Memory pools */
-static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mem_pool);
+static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mp_block);
 static size_t total_allocd;
-static struct mem_pool *mem_pool;
+static struct mp_block *mp_block_head;
 
 /* Atom management */
 static unsigned int atom_table_sz = 4451;
@@ -636,14 +636,14 @@ static unsigned int hc_str(const char *s, size_t len)
 
 static void *pool_alloc(size_t len)
 {
-	struct mem_pool *p;
+	struct mp_block *p;
 	void *r;
 
 	/* round up to a 'uintmax_t' alignment */
 	if (len & (sizeof(uintmax_t) - 1))
 		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 
-	for (p = mem_pool; p; p = p->next_pool)
+	for (p = mp_block_head; p; p = p->next_block)
 		if ((p->end - p->next_free >= len))
 			break;
 
@@ -652,12 +652,12 @@ static void *pool_alloc(size_t len)
 			total_allocd += len;
 			return xmalloc(len);
 		}
-		total_allocd += sizeof(struct mem_pool) + mem_pool_alloc;
-		p = xmalloc(st_add(sizeof(struct mem_pool), mem_pool_alloc));
-		p->next_pool = mem_pool;
+		total_allocd += sizeof(struct mp_block) + mem_pool_alloc;
+		p = xmalloc(st_add(sizeof(struct mp_block), mem_pool_alloc));
+		p->next_block = mp_block_head;
 		p->next_free = (char *) p->space;
 		p->end = p->next_free + mem_pool_alloc;
-		mem_pool = p;
+		mp_block_head = p;
 	}
 
 	r = p->next_free;
-- 
2.14.3

