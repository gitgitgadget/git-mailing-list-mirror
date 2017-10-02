Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC50320281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbdJBO5G (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:57:06 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:1204
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751193AbdJBO5F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=i+QGzLepKA5pQnwS0bR0LWzamWBUenoawYcQS7iRgLU=;
 b=FnuvU3n969D+YUbh53VFbiSWxX16rEXN2UzCHnyeDXTLuazUbnDg5ORR4RMysMDbWRX3s6GBoehYgV665/VDY/LUQG1/X4wgGBtDmxutaOfqzPQHntlLFFeXW5qZzhNEwnFXjv2n/UWNnDFLtC2rPCW2jrI3ll4Nrp/XZlkq5bY=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0731.namprd21.prod.outlook.com (2603:10b6:301:81::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.4; Mon, 2 Oct
 2017 14:57:02 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 1/5] test-list-objects: List a subset of object ids
Date:   Mon,  2 Oct 2017 10:56:47 -0400
Message-Id: <20171002145651.204984-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: MWHPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:300:115::27) To MWHPR2101MB0731.namprd21.prod.outlook.com
 (2603:10b6:301:81::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46e83d39-28c0-4cde-9330-08d509a5d7a2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0731;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;3:8GrjyNG4IZZgLriACR2Yxz2P5N+P9Su720j9V6TtchpTGOAy7th0qQ6ovpJGBlNPvg3eVyOv4xbxi1XWYX7ajI025aXRAVwUCWpxQ/QSbtweufut3M9EbwdlH8zqOTTMQEHs2hmA4BUG6B0ZG9gcVUuev7EFe1+r75Q96whDlGCjwqr61UrfVhRy072rCYqwMLh/tZy75Liobw3eLL2+Jt5ie+wMoKVDuZCxoZr77xyOKEDkCBjy7+Wa6NgQaPuL;25:9pytYj17FfbxQfPwnW0fp9k2lDlK9smqtRd2y1EByfBf+AU30XeaHndGBFT1noivIjgxkzKT7/3MpuwSgSXApubqSiCcVG4jfjix6n8J/zuyP4EB7OmV+c1QvhPl8LDpSwPRJPjkRJdZTUCPMlKgj8X0eqvB60lr/7gwclVy20VeIsJCNpBCBrgEW6qygBDwYlApoPWC8BoaYlf3W6eENlefptjsS4xPsJlRHABe09Dk/uFE76Kl8IfXiXpCh5QhRXYPMpjAI5x7LTuv82pJV/WZ3AvFwLD5cwcQVojbwYC1X0gPn+MnitCujUZMI8SGJZT6nih65afmPd9Ne1wg6w==;31:Vd+9Hm9ul0/yfqPsaAbij0I/OiIzYPJ1lBQRBZB5JnJwYAg2eNZ3zw5tu0S6v1vGxtVDMNQVcbxNLccSXdyFwXr8Hc/MDN4b8wqDVd6nXPzMELMk7I1tuSuHGwa6ilA1kKE1BTJR13NZHh9wd45zsxnFiIVMH+aT2l4Zb6oNhcHA12jwCF4bmu9exarcn5ObZggtdD+JHvn0qqwoVbOmweNf2vmJ9eUgoDV95OzAgE0=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0731:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;20:pmhHd6Pfj7UwS8cvh+y4PPFF0/GvNBuTBvqt7kvjGzGGdxmJRvcSh0alDwUOnEYW9ky9KP5m23fcVOdAngUlN6zpXgxLoLgZnhRd5rWTMTT2eQG8lLmys8tmX1f3tKQ0C72nFhR3QJSdcZZbGBLgEbnXEZqrO+8bxhxxnx5XAbEdtSFjI9sijiK3lc6fQfMsqN0qHUzwhDRYHVmNfb0kBvboq+Vw/O6Df2gjT7bAflD0gtNpNL5LvID1MEAYyO94hMk9HxYyJGtfe0CUI41gGQUX9J5Z3GRuEbFJ8D5M3Sh/l7noFums8sFcD1hN2OXeszFc59VZT2jgqpOPIT2s6GpYWDG4M5GDLOfxxGK6Sjib/6rNliDsy9+DZW0y+e4SLa6x17WcLfOmy4wnKgDTZcVR4GY1eqEwndwwxsoCP+DPX1rYVKETBeYeQGQ0NeqmIOZEu/V3uy4f+iR4yrROc/78pN7XTzklnKj1eDwUzlW9CPeUhxJXAg3wpPt31Pjn;4:NzyoI+gA0Yl91lhLeMd/u0ISeOBjizKUYz0fFThwwLMBRMLR5zZR7UV0OQRJIgJr0QBizWwvcjSgeMtcg4jJNbAQCXaCXcVp8ZDTpmWzra4KCA350CFQ5hXgZSAN9siM+a08qwa5FnPyWuY5QlBRsHsrhicH50J2/InEg2yrfQsi3OAX6OecytX4v2OmEBxFKjFYasLZKpJsi2BC0/Lh/Ms/cNUDE9PK+dGrMWOf5klumhQfQ+YxYYmZ/kg40W1ah7nw0rwx5yafNT5W9o6FQ3e57Kekj7hnDaJ8GxwERPc=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB0731BFDACA9E2FAC328BF7FCA17D0@MWHPR2101MB0731.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(12181511122)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0731;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0731;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(39860400002)(376002)(47760400005)(199003)(189002)(36756003)(68736007)(81166006)(10290500003)(50466002)(8936002)(48376002)(5003940100001)(189998001)(25786009)(8676002)(81156014)(8656003)(50986999)(76176999)(1076002)(97736004)(50226002)(2906002)(6116002)(53936002)(2950100002)(105586002)(16586007)(5660300001)(10090500001)(107886003)(106356001)(86612001)(39060400002)(6916009)(316002)(2351001)(47776003)(7736002)(478600001)(2361001)(6486002)(22452003)(86362001)(305945005)(230783001)(4326008)(33646002)(6666003)(101416001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0731;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0731;23:OdPNaYi8bgr0K6MwwFn3EOSNjNkXaS82u8898hw?=
 =?us-ascii?Q?W1MsLqhJSsPNjWXiOunziYjhWtwPIilGCxfvyhKo5TRjz8CYjqWJ1jIA1tHr?=
 =?us-ascii?Q?MvwBCbII45SPOqQdMR+dlsmSfiuo4oLRlH0+asfZwCDWbUQYitI5lhWAP+6Y?=
 =?us-ascii?Q?BJsdlh6dLzcpEL8H+tlt6CdKX3Yq5+J/6QwdI3/R6czKEme/WqRrPuQRLmWI?=
 =?us-ascii?Q?HFiCmjgFlmkng+5QAtcaQcaM8rldYurLyPRSqzj5rSeQMv30F1yNk7M1HPaI?=
 =?us-ascii?Q?qSDQ6SfHV+mDSE6xm6oN176nLXcqan4gMlnPZfacc3W24ZBrh/eOrPuEHAsK?=
 =?us-ascii?Q?bQk3zOErH2NpcQ2DGqrcWTGfMss1dRAG3gGKQduaZQbS/cD22Zg316n3APVr?=
 =?us-ascii?Q?UUlohh6aNj87UYzpqXJ9fhQ+qg7tTPTCWSCifManLJ+xWh29hdrOhVt/I6Wb?=
 =?us-ascii?Q?QRVoRnxWWbZ7HFZYYKR4fegWZhaxJ17yJEnQjOZsPb45Wiay2ePRB/Y5vo/c?=
 =?us-ascii?Q?7aHEm0zN6vp6eLydyMgeJy7qAZbrKNZoITgTiujj4IjsgozfjD//aw7x+3K3?=
 =?us-ascii?Q?8F9IEaBRr+20qu8J6a4WtMIKA+4hNyx0BSIL7D3gtW+OldQ+sMXT0xHzD46V?=
 =?us-ascii?Q?JcEB+yZapAiVJrS6A/ogfXm4TQML152DFopPrarE2COfbzT1QO4q3Ou8afeH?=
 =?us-ascii?Q?JHYn07Qb3YTKSQd1CIuoE2PJsNJTCUPpLpeQ7OcIiRvUw0T8KNig0gw5faKl?=
 =?us-ascii?Q?vN9//8wcHZXDBKZuOGEIbqK1tllbq65t8eLod54wkzABiowXukZ7SfxtEISb?=
 =?us-ascii?Q?MUenBJB8ewxgg/1ni9zH5trhSyEVUCR4ISu4MgU7H/yj9DvaQ5aW4MaKHG8t?=
 =?us-ascii?Q?4m2t6m0oXNvOSBl1N9K14fofdg7llc2CGPGvYQ5/HyqcInx7gDmTw/z0zsn4?=
 =?us-ascii?Q?0LbMcJU3pNf2l0P9/IYp7rW0pLZdIRA+CkhlarfaTOvbRERH17yQVcjBv4F9?=
 =?us-ascii?Q?70bMqVY5cT2YvXCy9ZBnC102efbgkrvV7Qxv/H2glux+ckcQH3LsV5uK/mC6?=
 =?us-ascii?Q?TgoKnGSqGFEKn8nQDebx5ydMC+4HtWGE5SdOGvmy0B6KFvLg/spKdbHQavgV?=
 =?us-ascii?Q?KDaeFlkdqpmsB57yVglzVjE5zIXsBmdOk+pHNbgsW9UJZLJVzTUiVifB11pH?=
 =?us-ascii?Q?z14UHGPU+tZK/9bTlBBLRRNNXZ7fq9zfXxrtdtY68m6J6fc77V2RizoRGHZl?=
 =?us-ascii?Q?bsMlzcer0WZi5ptfHAA0wt5/UAgh1qPct5Hh+iqEO?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;6:MCmKV5dOEAoPOg+q5g7CrSj6MVAx1Umck+i+B/g71EtfSsfHFvxp1Ko3h4qDlQ5pv7xssGApb8RhGHRJdZJiQpOJb8bfLsgsL0InrkYppzAlVofcbsD9GDRJFxyptd2l+CgAYbMFFo/HTcGInyiyxOtNlwxn0W2ETFXDJLyD+JGpfyHmnYWEfNZJ8/uQghwAsV++5DM6/tzIpmzLScXE7pYSiJCo1fXKNiCVWx/OEo9xUidYNligu19ce/VQ2KICzZlEZPDkeDQ0kFEoDuDxAjrNOvrK8spY07FxVetQ3DqWfbH+RarNN3IoZwlqb2e2VYOCGo/qipKRHEJhLGrWxg==;5:aUkuQCCYFll3c+WgfOwWj9nUaXvosfFbjG1sqxRYLGuMd2oLUgCg56FUa/Ve5NT0Y3aAfNB1lRcx+ZHWxhj9Euh6PpiKe0ORND1o5C+Mub/JO1i0F1LiOt7DTjly4AhCSn9eQf/Smt4h7kaxCxJYeg==;24:9Ck6DqL6gmOGKkysH/cIugPiHGsOJ07L7314ol8stFpBqyJ4i7Ay0SBa6TEyIdo/GGniDDIwicyVnLYg3nSGWsCdMZ26P7mwbHPq5KR3W9c=;7:M53WrPbhM+ftZ38GUjX456c+3FLpcK5huNkmsRlLCJispW64YFmFeA7UllKmWrGq03eAf2lDHeT7MdVANSysdblEiaCKg+uT99OPDEQt7mhLb3xhS7i+K5WUJLL4WQ5aDyRrGYrtp/1uOlagUe+SpgECWQdZjrdBCbd/1xCCdnk4T8epdmLQe/3NOJZs3GabhHWphLLdA8zZihE+8OeIKN6sEUKxXDNVH3ovSG/UGL4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2017 14:57:02.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0731
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create test-list-objects helper program to output a random sample of
OIDs present in the repo.

If no command line arguments are provided, all OIDs are output.

The last command line argument specifies how many samples to output.
Samples are collected across the entire set of available OIDs to avoid
clustering and therefore quite uniformly distributed.

If a command line argument "--missing" is given before the sample count,
then a list of OIDs is generated without examining the repo.

    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile                     |  1 +
 t/helper/.gitignore          |  1 +
 t/helper/test-list-objects.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 t/helper/test-list-objects.c

diff --git a/Makefile b/Makefile
index ed4ca438b..50a2eab80 100644
--- a/Makefile
+++ b/Makefile
@@ -652,6 +652,7 @@ TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
 TEST_PROGRAMS_NEED_X += test-line-buffer
+TEST_PROGRAMS_NEED_X += test-list-objects
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 7c9d28a83..9696f54bb 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -13,6 +13,7 @@
 /test-index-version
 /test-lazy-init-name-hash
 /test-line-buffer
+/test-list-objects
 /test-match-trees
 /test-mergesort
 /test-mktemp
diff --git a/t/helper/test-list-objects.c b/t/helper/test-list-objects.c
new file mode 100644
index 000000000..22bc9b4e6
--- /dev/null
+++ b/t/helper/test-list-objects.c
@@ -0,0 +1,87 @@
+#include "cache.h"
+#include "packfile.h"
+
+struct count {
+	int total;
+	int select_mod;
+};
+
+int count_loose(const struct object_id *oid,
+		const char *path,
+		void *data)
+{
+	((struct count*)data)->total++;
+	return 0;
+}
+
+int count_packed(const struct object_id *oid,
+		 struct packed_git *pack,
+		 uint32_t pos,
+		 void* data)
+{
+	((struct count*)data)->total++;
+	return 0;
+}
+
+void output(const struct object_id *oid,
+	    struct count *c)
+{
+	if (!(c->total % c->select_mod))
+		printf("%s\n", oid_to_hex(oid));
+	c->total--;
+}
+
+int output_loose(const struct object_id *oid,
+		 const char *path,
+		 void *data)
+{
+	output(oid, (struct count*)data);
+	return 0;
+}
+
+int output_packed(const struct object_id *oid,
+		  struct packed_git *pack,
+		  uint32_t pos,
+		  void* data)
+{
+	output(oid, (struct count*)data);
+	return 0;
+}
+
+int cmd_main(int ac, const char **av)
+{
+	uint32_t hash_delt = 0xFDB97531;
+	uint32_t hash_base = 0x01020304;
+	int i, n = -1;
+	struct count c;
+	const int u_per_oid = sizeof(struct object_id) / sizeof(uint32_t);
+
+	c.total = 0;
+	if (ac > 1)
+		n = atoi(av[ac - 1]);
+
+	if (ac > 2 && !strcmp(av[1], "--missing")) {
+		while (c.total++ < n) {
+			for (i = 0; i < u_per_oid; i++) {
+				printf("%08x", hash_base);
+				hash_base += hash_delt;
+			}
+			printf("\n");
+		}
+	} else {
+		setup_git_directory();
+
+		if (n > 0) {
+			for_each_loose_object(count_loose, &c, 0);
+			for_each_packed_object(count_packed, &c, 0);
+			c.select_mod = 1 + c.total / n;
+		} else {
+			c.select_mod = 1;
+		}
+
+		for_each_loose_object(output_loose, &c, 0);
+		for_each_packed_object(output_packed, &c, 0);
+	}
+
+	exit(0);
+}
-- 
2.14.1.538.g56ec8fc98.dirty

