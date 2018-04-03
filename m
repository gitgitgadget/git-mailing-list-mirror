Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299621F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeDCQwM (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:52:12 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:45952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752582AbeDCQwL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=I7jJ7wn8OmHOTt0ctjGfXdrmSWapCv4JZ9Oaj9FTHWs=;
 b=UeeJaKGon/5vqEFJL0o7Se9rs9ZJUfmYH/MwfT7RUCTtebVBh9f9YfOCCTxQfs7yjwj+hp2HUprBD/53fTuZ6qehA+LQk7oSRI+YzN7qGwvJfNJBQSYlfxDCYpHHqMa+xrWaDxaXWIqrnm7i1cbLgU0jsuclpFe3JoAeuWf62CY=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 16:52:08 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/6] commit: add generation number to struct commmit
Date:   Tue,  3 Apr 2018 12:51:39 -0400
Message-Id: <20180403165143.80661-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e433ffd5-baca-4b61-b2af-08d599833ce4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:jcrBlwBEEBmsE3sTsJ4BNs0LDrUPrhY9RhmX+JWFWn65+v0q0q6jnPntOrLCvT5HC6ukNLjHtz8XGx7fI7ajIQq1MZjq6ZgHJ1/0A4DviF6ceaCcUF2vNTjgd1HlMC3y08KFOiNnpegmE6E39gYPhioKlNvMlxIzTa72bQZpufYkp6ICyXpAQD/A2bzGKAXGhk0gGxNMNNWWINKe+WDHIF5fg5xYfBEpsgQLQ61GH6zhnCGAbAcBmXfDegh4UDfP;25:FtDM5ylakVI9yLDLZTgOijCxHHHJdO30mD4XBfpjeyBcs+7JLmA6qhbx+fcAFN8eiFmR9peAPvCnUqz28QY/gpMELdtOb9V9gnDxmtLZLO+BRvGM9yYsPna+qXjlEQCv0R4Q+twrls4HPYt+6RgeTppZgaX9Ea+sNiTj6FrpYx92sThGO7EFlOhCcmsBZdWMSCxFBjxKGDhJAG/O225WtgmI4/cxqkY9gdaMvadNc6LwzZmsVRUIpirGN36y7xenlCK4xM3592zW6uqoCiIOI83Ztb37cLX2G/P1rOs9G1+gRiWq1tLaLVEZTdqxWzN0DRQHAswdWdSrUu+LVnmceQ==;31:SdBqmUCjrg1Uzdtq8YvxLVBW69HhLWlqhjurEdvnheNAfqtLKaaALdf/++V5vB3SpZ2DovWkgXNK11O1tXRA2Yrm8joEwqSSTIu4arUUuLbTkyelaO7FudVCqeZPCSKPHpzSWcwoiAcr9AC1iSxZ3glG92InME2QXiEykSKch4RFY70Aduv1+ZKkgGRxQg7H0TWGB9YXENQpqmHL1hbPzEtH+Q5eA4MSfZeUOvGjaco=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:3niPJGZIMRTft1WwtvbNYkikBWtgeEbiKw2nbPmDAaDCypjxXmk2NJBHHucMguTTRpytqiQ7keSr51wg2MET/kDSXvDg7SNZZ44lXTDN2g36z9ogIBjclIdgT+qHXaENAbaytsIdLB21s8O3k89kDhwBugNZpyNmCbPygWg+ES4rHufygorj9bTZa8UwK4rRh9Ngi8Z3h1BIDAb5xkYeXb2/G93J1aiIuREEvtwSKHI0Ghcw/qf91veEBHT4fhBgFEk5BnRjf2QIXUrbN3NIFJ4mrdCWQmsw+6fWTCj0abjxIntcn1Te1S59R07x2rCUllQUKqnDADwLcSa7GjS7Leb/fjnpjkumYq2NZ/6EbcxgkNbX+gL3mNoTdSadXMyfCK3LQGK+qR0WMs+BBq/GRvrFu6+QVyovuZ4t01Kh+8Dd+7/qk5wQtdc/UElQyLBQDqVnPpgE76/s4Jb1XRjXApJTkR2kx5VfLJCVQWztKtuqnLKU4OY4anws9+ISVnNK;4:95Ak+uP6uHC239Ues58H4fHNtts1C0Any9nKKRmqkHTFtrSNPJ0fRoC1FdXhiMu8aT/I9IG+3mQ3jZgJfMuM86+8IBbIkerLiEctw469d7sCsKDpg6SDhXLZhlmeH/l/Sw9Gsf56uuUd45TV3F/KB5ev3dQADz0On2750r3ci/VVg0W7zVsBQEOwNC1Z4BBw3tP5deV2iWYYbhygdoAgTa1YpURk0MQoQ9n3VYGbK3NKZDrji0mG6RWxJOO6/8aMvhh0vNz9g5iERmoVs0Ft3dbsU6GBwDxH09jZbNTxL5LT4ITduJIt2rINpOVoMiMl3KLH2jd9P4ugWy1egWOeIgGKe7o3CQ+Xjqz2xwhoBmI=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1011CEE381576C6A5F0B8B10A1A50@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(6666003)(6916009)(105586002)(53936002)(7696005)(52116002)(68736007)(51416003)(76176011)(4326008)(52396003)(1076002)(107886003)(86362001)(386003)(106356001)(39060400002)(6116002)(22452003)(478600001)(86612001)(2906002)(16586007)(316002)(50466002)(2616005)(5660300001)(25786009)(97736004)(81156014)(486005)(486005)(50226002)(186003)(476003)(16526019)(305945005)(81166006)(48376002)(11346002)(8676002)(7736002)(47776003)(46003)(6486002)(446003)(2351001)(2361001)(10290500003)(10090500001)(36756003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:1WnqK54JQzwhHIS/nOMRLnpdV/LzltkcGymDLwv?=
 =?us-ascii?Q?0rhxQh+4csmm+6Cg62Bc6HuO+7rx5GzqFJim64V+cCqwp4y7ywpY9LNyRpmr?=
 =?us-ascii?Q?7WvtLpbdfaOLe++PzmXii/qSFLen1Pu5Ld9LpqjfDuN+/2S27HLUjLRac6D3?=
 =?us-ascii?Q?ukNU81bpXh3gKJkxZB5Q1MptWdf9ZWyXnl0MIk+9BIjdw3zdHRFK620DylDf?=
 =?us-ascii?Q?IoZe5WQ/VezOX39KV16zsERYmlq1fdVUkFDFMTYiPBMxn/oj4Efd/tiTCFPM?=
 =?us-ascii?Q?vQlBgupCAf8hooAVFhNsWBPC/q1egXr6qiPrKSUPYDPe8rqDmzIqQB3qYpOu?=
 =?us-ascii?Q?J0tpXGqgiBvzXcDxrTBaRMFYGt/Zv3cvju6gNPIX9PsBvEoWm/RObA5PXSNQ?=
 =?us-ascii?Q?G6dnRUMhRJU7cyiqeiUZE7YGctH/pWXBIb2cCFB3/cvkBww8v7ycYBTYKv1p?=
 =?us-ascii?Q?qLzLGk/U7o4VqdNXx858bvS0AmFrmpyz5Dj8FLWpuZ/GdURexiJBCr02703F?=
 =?us-ascii?Q?OKIlg4aoSQPpudC9EqFwGPih3rcXm2YkWYNcyrEsXDD4Ji0Wk065E0gi/jfn?=
 =?us-ascii?Q?h8pdhIOp45dIj4t4191Ye6Cr2KTH6bH9BHKgvqk2sq2VR9SLCSaFXVJUraYc?=
 =?us-ascii?Q?4ixBBG1uKSpFGwQjq1lqLsJysyigqhuOCDq+YpqyFt/FFdJAcNgy3Tpa6cxR?=
 =?us-ascii?Q?yGidmywerqWPpzKJF3BxkxeKIm28f/KHDJt3zHpvQwm6h29K79tfxAGgDB9Y?=
 =?us-ascii?Q?TNzzFeDEhsPBFIAGUTWJf1vml3JNxtEAQQkL/vxtZdZsgwaPibrjDaFpLO/I?=
 =?us-ascii?Q?NXMM6funX6MllVc9Zop4YV342TJUBxEk9cwQAQW+VMhh+K73ocJP9WRd2Htx?=
 =?us-ascii?Q?R1L0rWJ6aE8hdBWxFKtjYFmyBBJKqveFeeeiqRhbX6FoMeRHoAJ5s6hk7jMS?=
 =?us-ascii?Q?FsOnFmskwWjfI72BzM3u6ZDQOsFAx2QXwlBEbqd4QFooM0A94OozYCgA/hHv?=
 =?us-ascii?Q?Az1w9QmtHVXV548ww2XafjaobPTmRFhla6SsQ9/8c2ifHgJJtxuH76dSGzWO?=
 =?us-ascii?Q?Ff41ecEVjcvmkUbpVeADlMohFEGayYTa0vjYMWSiuzLK3PbNLmwFbq5yjo82?=
 =?us-ascii?Q?YwtVBZ0k/pFTZBXE5FJiaqBx6qhkasYtWqPHOVNCZv2T36tJrHiRIBOQmS/f?=
 =?us-ascii?Q?UFWIc5ITSWrk+DShfzvl1dYkfZzB2uecxxpxTnmnnGl9kXzTIaGYnvN8aaWI?=
 =?us-ascii?Q?2iQGl4nsMhQ9WjgsplqBcoMNxHW5OVIryoX+xw/+/SRFQw5K4T0oFE4xveEm?=
 =?us-ascii?Q?RZUM3F4cfXulEt1v3w02YoIhMqTO3v/8hVzWrmoqbSgtW?=
X-Microsoft-Antispam-Message-Info: VtBqIsw6KCVefx/33BjXbffO71rs73zvQ1PcY786iJiQdgwu5zrFqK+TF66DuvXrpPyBUxzlfC8Int0yyo/QH6Sh+FSHp4F3y/knJaA9QC+NmL9ecMJC2G55rIhABx2qJrkrbiJuhP4f8Ofj7igm+6RU/iZ9qxXV+V++85lJIL2QWuEaUQcoMBnLWhxcgnuP
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:OyCrdJmZZTpxVS+MU4ZRG8gXRC6dB8gi683gO0JefZXcJCf5kamzmPxmiIHfsLmkMZQWekPszeDBvx1gfPtYzM7mRGZbQTPmp4gXRbCqoKIx0NOhIADdlHIjEAXym/2BhfJYwhC3fKRnGfLOMiasa5k91BCunmlP0A/dWCY1yjyOeSqusB5BrDMhxmtCoB4YqUaz8gxjm2Ne+WSVw4sx7E1/effLZxFyQwyTfirO/zNVIiDo/xJfQj62TBq41UUsqDHtTCvodzYQAS2YX2gKWraMsbkpgd+6ImXrZVgcFLsW9l47pLkCF9M9nqd8CcI+OkISvQcHWA5/N47xcFMdkbGddA4rZbYkEfLVrhYhL/5DYm527p5TLmb4+W66ANS4LpFHdvmtwr0WavogfzzRnnyae9kTx/PKUggJMhqF/Er+gpqdh17uix58dVkKggeydXuKHTE2RjCsBBzNOURJOg==;5:0YDl2keKVdAx2R2ocJJkzBfoa/qtNVyM18VdFfbQzxS+Qc0OXiaB6uEw04ifgaxRq/PZXKHf/ILI2oc8TWjTtH7ScjIj/gaUXkz99cyOA3LwCOh1ZlA0EN9wMUzqabIW1TgnWrGG9fQTBvkqNKvESg5+lS4Ii86CDEoHZ1jOV64=;24:Ponnp4iO/eKjOrNo1ij2iXxIQXAJ+la19azizjoeovbC8/ZlbJcEdQvFyTwqTSSJ6iYzqR10tfFRXII6XdW+DbjMN+imPdDFJKOBOhVtouc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;7:+8VPVKtdReVIaTT3olYf6TE6MD25DlUthL1XQPfYeZPE/QxLi/iKyo7xipPJNHzAGfQzj4MyHX38RabqEvms3qpIfIDMBrFpkHWIZMgwoGGLOkgw+oWvqpFiZYiO+AVN0oesy+35MN5ANRKY4OIZhrSwBKqvsSA18cgNpXeMErQ9TGPWKUhKJX341XayHHZY3RmKg8a9wS2rMx1n4/AEtQHvz2p8aCpP1/IaEDIsl9OnPoB17VFjCwgYN/Ef9GIi;20:JikzKG2OnGCd9E9/Ybsqxm7PxRzajJwWvIpNUos0lfbGycodhxLaTQPTIgqCy7/VQ1F/P0kTmbdcdBwxR9Ukf4cENW1nhJloPrIPjNPYkoEzne59fXTdco1HCUrzic//MYAkwZISr1sr2XgX519NzQCovfwiuyWCa3qg/Umuvuw=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 16:52:08.1679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e433ffd5-baca-4b61-b2af-08d599833ce4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The generation number of a commit is defined recursively as follows:

* If a commit A has no parents, then the generation number of A is one.
* If a commit A has parents, then the generation number of A is one
  more than the maximum generation number among the parents of A.

Add a uint32_t generation field to struct commit so we can pass this
information to revision walks. We use two special values to signal
the generation number is invalid:

GENERATION_NUMBER_UNDEF 0xFFFFFFFF
GENERATION_NUMBER_NONE 0

The first (_UNDEF) means the generation number has not been loaded or
computed. The second (_NONE) means the generation number was loaded
from a commit graph file that was stored before generation numbers
were computed.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 alloc.c        | 1 +
 commit-graph.c | 2 ++
 commit.h       | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/alloc.c b/alloc.c
index cf4f8b61e1..1a62e85ac3 100644
--- a/alloc.c
+++ b/alloc.c
@@ -94,6 +94,7 @@ void *alloc_commit_node(void)
 	c->object.type = OBJ_COMMIT;
 	c->index = alloc_commit_index();
 	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
+	c->generation = GENERATION_NUMBER_UNDEF;
 	return c;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 1fc63d541b..d24b947525 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -264,6 +264,8 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
+	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+
 	pptr = &item->parents;
 
 	edge_value = get_be32(commit_data + g->hash_len);
diff --git a/commit.h b/commit.h
index e57ae4b583..3cadd386f3 100644
--- a/commit.h
+++ b/commit.h
@@ -10,6 +10,8 @@
 #include "pretty.h"
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
+#define GENERATION_NUMBER_UNDEF 0xFFFFFFFF
+#define GENERATION_NUMBER_NONE 0
 
 struct commit_list {
 	struct commit *item;
@@ -24,6 +26,7 @@ struct commit {
 	struct commit_list *parents;
 	struct tree *tree;
 	uint32_t graph_pos;
+	uint32_t generation;
 };
 
 extern int save_commit_buffer;
-- 
2.17.0.rc0

