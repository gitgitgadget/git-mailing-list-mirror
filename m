Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64DA9202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbdIVQhi (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:37:38 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:2304
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752540AbdIVQgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OsTJn4Co5DO/ryJxMQj5Crlho5x5G1O1ytGk0tMF9Eg=;
 b=SglD7AXTLJDu88OS8PYU5TZczBCUdEsgEFG1Rpgfs5M6PitxX3rc2t7Nl8xoLs+Qk91SOOv2RyfcDCYxrGfHlgDU2TVjG1qvZLxis88/k0pMNuJxwzCN3fiyYIPJ0Wg4RcAoBFdETB8w0CGGC/Q8M0TWyLJiE/0Tbzuu0jWpv5E=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:14 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 08/12] fsmonitor: add a test tool to dump the index extension
Date:   Fri, 22 Sep 2017 12:35:44 -0400
Message-Id: <20170922163548.11288-9-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-Office365-Filtering-Correlation-Id: 5e2f2feb-99a3-4205-85f8-08d501d80aae
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:yUoNMddw4kbFGhHZ111ea+samCw9OKtWGjEeWTExJ6VOg6LTZ2kOtvXtByq2GEDLpbQPaODurdBX8SRs0BlXNPjiCReZhZYKQ+D+cREIRMI6vTMGXrmvV5zYafH5cSeM4rsW0y0ggNM8ZQW7/zG4Rdba3sz0qhjytea6wQ1QscqwhPd+TbnVljt7/LQhfT+ZKvIk1tfABE2/FqiWjrXi2A4I+ZkD0DwOfLh7+pOK2fE8EWiTHGYGoPYBnCTiyJoy;25:JS9azycsUh58pA2NzZik933ollC61UGRiy63sAytkolysqmVg6+/OwKEIqNmYW598KCv+6q3cEBxd8hR7soei+7IJcsdBf6r4Ilr8bv0niCuT4RR1DjSo/AT0iaMQxQ3X3Ml5LFbzOf/I+qYW0Jo6YepL6x4+0DfizIPFujtoiqJr50c/xCwiPQ3pEFP+/4tFm06UiSFQSpGrXkollBYlFgL1Y2IgDZuUZlQPMnr7SIfLdvJ190ToAN+DJazp3z/PO46cjvUru+DwcWH2CBoeu4CkeTx+gsoiPDazfqz+yZqNySR/XkYOaGGKPVmCZEJ8GOLZ+6W2CqNuN9AlY6mtg==;31:qXO+/igv1U+bGtBluz+AMCoWz4+6QZg0LJUYiqPGcEkIEJgFpHzGt2bVduOUQrtcLnd4CXoKU+IepqJ1oiH+6Tt+nyCd7OqEpRI35wd0yfw+h6jWXdR5CpWelCnHizyoQ1vsCeYKUdSFPldnvWUoGEW1mv8OhZOM0SojOhN9HoYaRm9cyBCo4HZVxPWrpQOTiDsx3nT+CQkN2A9dwMRvkauEtG3oRDpWHgcxXvlI4ZE=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:E9jkEsJYNl/lR+RAjygcmFDcGySfOPz0zsrCaW4ZjkLASO7Vcz9LKq9lULIxtA1eMGCWdv8n/BMGkKiLG0gq7Z5N06GXiO2UXFDFSZzcIjRHDTe+DlbsZIIyeXS7nokk8WQ9b+QvKsRBH2N/4kwsyVYInm6pFBPQPWuwkx2mCqh5P5BqJ6LesJnXamCsQTB88Az3gqP0oH9CQdKtC/eEXUFN1e6zJkKEihiylHOl7DvYUFWzKVwCs5mFBdWP/OW4GpvsvyvadlsjG4/aEftHDmwSXX7HEJFnAw9lK/5dKMxqd/4m7k0lJ0B4bA/nOSP+XyUv4J3Y6rtZqEmv48yO8Cgtd+NiT2BOEVB22jPumd8lWP6p/mJOGW54ItbAbU++6YfM8GwZmMcX9dJ1Pq0aLGBPqPKZRKdQ/faD5nMb4X9N5WfywM5p2JidhUHv89umYw+p+8peosMIcIpCh7vw3KWioyBtsiyVXcu8sZoSn2PdD0KWNKIT06GPXy9tZvay;4:PJVVhjDegkyZS135CRwEIvQHjtXh8OHKvN6f28OGDp23B/jGdS6gvRML3Y5Rozal7jmS9dt7khRHwQ8FuC6NB2QIeDg0dg9vD4sMf9bGT1ZF/ugBEpmFvmzMur8pSRtGV2k9lQr5dYK7P3aG18SWLFYXCKSXzAUfQKHyIe3SvLInr2n0yuSrHzJxEZFK6kGGejrvBbhndsQsY4nIpAZ7DlEf3wiSld1hWy65ModHhyw6LZUeIOxqLtIPCzoh86aUZuM7w1CwCo9VrUQBzOF3Tw0755zPzdtODSabKLEA+54=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB0466ABA0A61C8636797967A6F4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(68736007)(76176999)(50226002)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:kOwM95UVLjGASgQtjuz8bW+P5O0xVFPXjz/lPOMEu?=
 =?us-ascii?Q?br6rm61Hmu/TjUGRGe9PT81rEZxgnF0nurNn0GSnvWV6t3s0syKCvJanB90Q?=
 =?us-ascii?Q?cCVnlW5w+TM9DyHTKw6OO3tdiAiGXHILPF2kLRqocKLCJp8MZqbN7nE/dTWf?=
 =?us-ascii?Q?qzlu2/QkcW32pLDi1miOjO5gg/6WyCuYv/bs5tkjo99qLm17CnN95MrJiEaf?=
 =?us-ascii?Q?8/1g4J6eEmHMh4QJ37ofLucttyPPk2eMuBTDIZd+xWqGci8rSvvH2TqWuTtn?=
 =?us-ascii?Q?zjOcpa9o2whh9BuacG3ORduyMuhnGf9f/OOlgGozYSIDd7dP+pXfi6B4361q?=
 =?us-ascii?Q?wjKxYeXasrDppd2mFfpaxav+ErhiuI3eW435YMizJp8TrYf0YpEL0RuUru14?=
 =?us-ascii?Q?tfTs7QHQk4Lcnq2OkXDZeb8EFg+KaQo7xUt8/I7Qf0TieyAT9crpr8pDs75g?=
 =?us-ascii?Q?w4pVbO3ezzuCU8FZ8T4w6eoZq3gYQjuERRi1RFnSOCvmdkfCVTLNWDjUxvo3?=
 =?us-ascii?Q?eFCR8g/2uEMgMFsmIp+PTSuJCDTkvCkotU4oU6db16Bj3zhPBjlKxpdHKUCk?=
 =?us-ascii?Q?FpsPX+hBOhNO9pE6F+oenNy6VjAuZc7Nv9+1KgyIFL9CAp4YJBvbrVpRH4gD?=
 =?us-ascii?Q?JOL2HmdwLHtWpH6tFLkAjxYAb0ivQ7YdgXVqam2famCglXlfWVkMWU85JO2s?=
 =?us-ascii?Q?QC1z12mLVKZmeQNIBtXGGXM/lQIbYaMY0mGMnhv/hs9e0NprtNnbs21B1OcY?=
 =?us-ascii?Q?eTH6R0bHJTlx2pMgfcmJ/NOfNqgDgNXqgS3Lr5zFcVluqJbNyHTHMaUOlyJs?=
 =?us-ascii?Q?dOxUEbfWLkRWzhHWzqyeaUQa+M1DTCpnTsCuWx5VhGSDvUTvvzHDLv/A+yCa?=
 =?us-ascii?Q?pd41BPZgSv3N7dqFjucn+Yp+TUM1bM7XgKuTwpq3KVvnByL2A9USHa7sd/Qp?=
 =?us-ascii?Q?j1iLlUDF4ZVNNaDJSzMOvoJCbDkr/llcg7GPyzaxKaNRcgjkn+QSnYRbpYaG?=
 =?us-ascii?Q?i4clMpiqghpxHzGIt/h7UNE9MHIZbcIeuw6/utpv2OH3dMEslI/V2YV6k0Xt?=
 =?us-ascii?Q?dYQh/iMrAT1D7jrlBlRspBKRoBeURxHS/bDJMKLg0sD/9nRrzlU7rGdEKikJ?=
 =?us-ascii?Q?rVe53wH8/hvO3AVF6jUXRWf2AgUg1dHFS+Baxk36XlrAfpQxRadSyAaH9rw8?=
 =?us-ascii?Q?ekEycnMiufRtGxSEqjluINZARPFJYG2nSM2F36+JAjvFB+NLjIAjk8uKYsGw?=
 =?us-ascii?Q?W4QrPNA2+0ecv6wui2sWdRMH4baveeUkD8ROlShbHavjSR9hwJGTxYhY2O1G?=
 =?us-ascii?Q?qBqZ30bQry/Plco1qxgpnPcE3UDzt+gK3BvhDRjPQwtnm7t3MEdPTfTeEpzw?=
 =?us-ascii?Q?ykWvYJNVyIDZx7SBTFvEWBAw2pxpIMp153zDiFkIlvMMtEwq9Y1ZTVWoKTcz?=
 =?us-ascii?Q?XjidlecGog3caVadRwVybPSOIl6ZWM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:U1g8OlPB2xK+gyHDdp89wx4Xujvbssle4yR/qOx9MiMheHznm/cWEXc5eOA7ahuaV68R+BVu9269R885xFANBKazAiSr58ei2u94Hna/aXktl8Yn//NV8pSfk9ctP7qf6H1UvQl9PoIcI/789lXpu7F+yYwhJ1iXVo5GJ185XOvd3cSDsEYOpVYVDtZ0NAKbl381MZb4UEgHo+T5A8zJVWdVdUKEFm1uIlPA5u3dBeGzR2THvW6oWUfAZSkTd99PBWo1sSm/bAVNC8mVvzJp9Dhgxn2ZqRQuHXh1MJSYDWzUWLx+nL85AyI2P31aXxRkP/7osXAUfMJA+CqZyrzikg==;5:sx47dQntlnVO4lOkrATiPpOekFpB+KeH1XfeOYHyIYXPbAMMWdp4KSJKXTjUsbIgQgKHP8w/RxhpSGVEQtN0yAEk/H0QAFWt3yu41M7Nqr1vRMuBACyXp80y+N+qpOXQRRdDjJSy5A3lxc3TcF0Suw==;24:4cdm4ksTUkFXR9W2A7BguAjwTarFP3TSovMgkx/2Ikbujx2XbKqhLr6NK96YHYcPJqQUGXXEJ1o7p/usCn7mKIJmxaIIhcV+0o8HYEv2DJ0=;7:3isywuLKerLkNzOZ0W0+gEx83gFcvB44CEQ7YRmSWrfCWh40+H5X0Mr1ur0NxAL9c7+zgpiq7UsmBBuIvJ2RP92+3EHUz0Xcic+ziZi/y4wBx6mlcns/kMWF5UteZiO80iym7sTqVyJ4PLIjov4Cu7gV67vgjXUUl8r37UlyMK8b9zWKRYLdKteFsWheFmBWoLyQpKF1SPknMMwry33JIuJQOn6EjB8w1Zr5MO0frEU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:14.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test utility (test-dump-fsmonitor) that will dump the fsmonitor
index extension.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Makefile                       |  1 +
 t/helper/test-dump-fsmonitor.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 t/helper/test-dump-fsmonitor.c

diff --git a/Makefile b/Makefile
index 9d6ec9c1e9..d970cd00e9 100644
--- a/Makefile
+++ b/Makefile
@@ -639,6 +639,7 @@ TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
+TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
new file mode 100644
index 0000000000..ad452707e8
--- /dev/null
+++ b/t/helper/test-dump-fsmonitor.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+
+int cmd_main(int ac, const char **av)
+{
+	struct index_state *istate = &the_index;
+	int i;
+
+	setup_git_directory();
+	if (do_read_index(istate, get_index_file(), 0) < 0)
+		die("unable to read index file");
+	if (!istate->fsmonitor_last_update) {
+		printf("no fsmonitor\n");
+		return 0;
+	}
+	printf("fsmonitor last update %"PRIuMAX"\n", (uintmax_t)istate->fsmonitor_last_update);
+
+	for (i = 0; i < istate->cache_nr; i++)
+		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
+
+	return 0;
+}
-- 
2.14.1.549.g6ff7ed0467

