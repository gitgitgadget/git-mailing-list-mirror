Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE9920A26
	for <e@80x24.org>; Mon, 25 Sep 2017 09:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934484AbdIYJzY (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 05:55:24 -0400
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:37136
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934475AbdIYJzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 05:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bHG4b4Q+oSSWCPJ8tzM5bCN5TTSV/x38RX18lwsdOAI=;
 b=gIhcWnaFCvYboLWwusn0CuIyGzHP+XtXaV+f6Tvw7oeMfLDTS/i8feXXwJj/Yv5tDwK+4yMzxHHzRnPMzjLnx6MoSIh1sR/y3RxW/57ATFBM+TJakCs7dXI1I292VV+V+XLDmL24N2yW0rj+/8VBGLJDbMQFLCQZJCYD+LkcI5o=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 DM2PR21MB0092.namprd21.prod.outlook.com (2a01:111:e400:50c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.98.3; Mon, 25 Sep
 2017 09:55:17 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 1/5] test-list-objects: List a subset of object ids
Date:   Mon, 25 Sep 2017 05:54:48 -0400
Message-Id: <20170925095452.66833-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:404:b9::17) To DM2PR21MB0092.namprd21.prod.outlook.com
 (2a01:111:e400:50c7::12)
X-MS-Office365-Filtering-Correlation-Id: f7b91504-0d49-4dfa-348f-08d503fb8735
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:DM2PR21MB0092;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;3:+hUR0rBKQ9odL6o9R29WzpNqI1MoRvFSh/4ql7MiWGCQVaORMN7d2nr4ecpV9+330U1euthTVqQqxVXuYlUWysYMRIALv3zON8tnT9GHBw2mS9P8Mi6cloVSHwz414cZIJp19EPztufigrWeL6oobNAhPmWtDVcdwH5VUhVwFo1ND/rkS+/7FEPWHJCxu17sjeH/Yks3vdSg1DNaonv8TUV7+20im4uGWyNZZ2hIB8dt6KhdBXW770gOzd9+Ut61;25:1YurERSCwFi4NOvf2Rye09pXoZb0QVbbcv3FPmNPgX63ZapjmuJxKycQF24eKnoGFjtJg71VzncEIUC7pTsViwspg+18ENl0wDFc/uV8v9efON/8MWvee24FrutYHFI7WaLrxYO2+TwcDZYYECvIhGd10RCVgpZN1ZU7E+GyBsAQKzMjif4SnlrPhwHKgZ3sx8RybR8NySp/5WXeSuxoCjcXz4sdxhPWAHLbxzAmmbz8b/AbitOnNiaY2pA2kKSuAQNqa99U0eSzW9IuGLXIy5/4z16VKu3QIFKYQSZzjkjt9uZvPtUdcIykCE7jvQpH2goKEGDHFo5pJUtQoMpUew==;31:TrozpKVWrNPKqCDZYIyW6vFBoLK50KmBhLpGb+GW2XIbP4lT+iw/tTYgU39Bx39KTtJLzPGVEvY7peT8A36zVinnr117ksvs0ozi0SJHdTaYxQ96/qnhaIGzC0ISuj4MTkIzBSoQP+Dl5XPNLu/BR8WxYaxDlfNse0MMPYUfvtia+bZaIej4rKcMCOurrYiYFs14QhrQJUriwGje9zlotCTUHwN/N0GrTF+UocXePN0=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0092:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;20:LZOeAyryWhC3wp1ZPCqWLCKTji8PcmNwehVOU8bw189GavB7JjRuEaRY15XDDx+WjueM+7ju/Vrsq6qqqkCgXuoXGVPMHSNN4nyRIYcyx/1lgPnqcrZYS1XwTqPBcQwql6+CRYjIMT9/PrbY194hKDhGrPxh7EVKfh7ZzgUhzVoiVgNVbSvzbHZdMisIw89rgz29M+bv7Flf9kPDVHgUKDk+TM+eXK+fcyGgIeUjstYqeQSMuXYaQHgvPrLLICOBst0pB+AFixdOMmDi0Vk3Zb6GGDeznfnrdta9SLznZXQ3hss2RNlwzRCxKZD1OblDNXzhzcIlb8RokZhSC96SL1RKgXl9170fE/OwGT0LFsMW2DJtWftQxp5hpEz3PhZTOkL5LiOWMwH9X9OhT4ls2sew0ub5fRhK4up8clxjTI019ytgtOklQJ8YXFXGls1bgOLoFHT0yc78g8BpopMfUhBgbFgrRdhNiQxQ7P3fBgmjWwFJKQXY1Fc74CiG9EBC;4:BoPhF74qlhhYqpbJMJ1VVkN4Blp7mX0+myo9Bys/PiloXkHYBSS1JQYCO8cPKV44XezNmDaBiz91C5GWzrYrirv8UoXxIUt0DpdEFtayAjGj5a1tULPydwHEQy84014OGuxId8jKGDefWjrYSML0Mm03gMuPbfIimHnXsopsV3N8eh0da0CIM0G76ANSF37z2mrGTO/DzicDtr4gLX2coaCByvWsD3aPcs9Jtr0Nu3aHSluZQihUPeZ5Wj8ykOK6niGNpA/sbdWWw93TT85kcDce7P4lKN+7Albx2PYsnA8=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <DM2PR21MB0092CBA0FC9F79128C4BACCEA17A0@DM2PR21MB0092.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123555025)(20161123562025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0092;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0092;
X-Forefront-PRVS: 04410E544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(189002)(199003)(316002)(305945005)(68736007)(86362001)(10290500003)(101416001)(6666003)(7736002)(478600001)(2950100002)(105586002)(53936002)(6916009)(2351001)(86612001)(4326008)(2361001)(1076002)(48376002)(10090500001)(6116002)(189998001)(81166006)(5660300001)(25786009)(230783001)(8676002)(97736004)(106356001)(39060400002)(107886003)(81156014)(36756003)(50986999)(22452003)(6486002)(8936002)(2906002)(47776003)(5003940100001)(50466002)(16586007)(33646002)(76176999)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0092;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0092;23:jsTTGw5wzaHHNC0XWA9j6XkShUb4IumGT4XfKFHCW?=
 =?us-ascii?Q?2kwC+v7z5XdQRJcbxulU0s4tqIlLzfbr15Eer+AOHl9TZxyKXY91yRYfhN+I?=
 =?us-ascii?Q?4TS6P4BF61RUA/y64p3Qdt18YzVMWbb87bdY/LAl05wSfG/aGfGLVRuhcMie?=
 =?us-ascii?Q?zdW+B2AKD0WlRqdvjvqL0+XDwkWRl0QXFXWvcDsDYsyqDu+eDX0OyTjYTo4S?=
 =?us-ascii?Q?Go70xwPaCWPLvUP6OuVRHGOYOs/BA5Z8ZFPDLXr64lPGXyt/yifX5fEL8KhB?=
 =?us-ascii?Q?52qs9i3HAWSKAZ8mZm52xqG02ox6bc7MP2WDnsmto5xVNUnbmLTc0tBWV4Bq?=
 =?us-ascii?Q?OXmvGnJKqvntZv5QgoFEy6TnVGsHZ5yEj84NE9fvA2+rTu302+jL50dZGYeQ?=
 =?us-ascii?Q?JBCH9jJHLk5LNW2bhAQyyFDcEKg2/vpRixQjFtmuolNT471xpF6hs6UhCi3N?=
 =?us-ascii?Q?lpHhyFvuLCF8vfc4GJEJlfy4UGlJhyouZKG8PwBEFOFiN3zeJ8RHB2qC7nDK?=
 =?us-ascii?Q?5yEpJT/EZGSLci3vbct3ttWxJF6c1vn0+l0Oust3mFPq5cMlsT/tLu0nVWHb?=
 =?us-ascii?Q?HfHWs0OAuKxPFO6IxpQ1XIYs03QIF4pUFyWtMrg0h7JBy9fCJlT2OKimJGO+?=
 =?us-ascii?Q?q773WYXLVZLXV8Q+1qTLcIpQIRu1bZpCwCiVe11V2+AWyBpgL9Aka5GgMps6?=
 =?us-ascii?Q?9Czt0nGpEUOw4zbwIOIheK7kmvI8Ut3mB8hPhHPlLpdaKSNdluScKWzxpZ/2?=
 =?us-ascii?Q?ljMsz6zbvuyfhvXK1lotXd1v7/7QbBVjrGLWJXXRlrUo5XEHnYVUFkI5pAaf?=
 =?us-ascii?Q?rlXWORRGrHbwbjsTP0YhNXNv1i87PVlLO4oFcURF2tOhHfzeL6VZ+gS0/yuy?=
 =?us-ascii?Q?PP7sdNPAhXt5bXqPMHH6eB6vAifVZcM+iEsP3/lhtARBVT7wD8MreXNfDxzj?=
 =?us-ascii?Q?dj6rikMaojIU0a+wsHQQ87WvSGNO58j/jQBd4lFQ4BIbAZYVD5Lajrrmir86?=
 =?us-ascii?Q?F7hx0xB7zEaV/slVp7yRcS75FRkgkHWQgBE2CInhkmQqtpdhMxLTJyyeo/bC?=
 =?us-ascii?Q?F7KiYYU1uJehHEfUzIgYCTp8UoK25tqD/8XXXpCa/pPjo2aszHNB0C1CBtLE?=
 =?us-ascii?Q?ipKp5obPUkvWveskziJTXdS5xWyPwGAHt/7YvSSHkNUx/FiBkV3BBBh9aejC?=
 =?us-ascii?Q?91q8kfkjlZ8hazPP9kOTHtWJP1TtunmLtZzmIFr1DVDMJI9ruMqS0WGMagGN?=
 =?us-ascii?Q?mU0ArNl8UIQnY3KJ3M=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;6:uqjq/VaeYsEAVukLV0AlL7AeLhGFVQKVh3S53PzWQq7B7u+K2scV7gwPs9ZVyDhFpAH6GhN+c9ROL1LOHnTi7BMZ4+PsOUISBSYLT2vO5p1Z19UV9WVYF95mT1dVzyj1ynXeNtEMtQNUEeHQqebrEDyuB4e3feh3tkc0qSw6bookxYLbJOsWuljBivnqfffNE86g+RLj1p5zQh1n+3JeNGi7LDk3PRSUjv/9y65v3J8J1/WLlFcks4grCO/O3DF1xV43+yZ3Ulz6sQ7Du/JxWN0fbFr43lB1mPIJ5mrOSuPTwvXFMJv3eBY6BwC+EUK/UW7ghpJsnOwJirLLlbqdsw==;5:09eGaqEwJjmp837Bk6wI1u3Rd4NF318CGbPLdSSCk+2F0XcOwPVcZIqpM6rM8J/2etuoD/6UwrBvF2GoOSEjlT78wumvCZANebNomm+kyru+g6gjDXk5cXShucp+U4HFTxkGuxfn2qYHCkVccE9jzw==;24:OovnqNWFvmF/zqfALRtVFWwR1XFcQaRcqxeft2okSVzUoRy/5bMFP4H6YOc1PZiNifLRtPQmj4TwwjfuQH+W761JRHx1JZd8iWAvIaLk/PI=;7:Ag7qf7A74T0Ylly0nGT/M4EjVvgklBWeATRzNdtzgIJRcuOSNTgfJkDQ1a8J3o7gMqHMWUPUW6eMtdhacySoazeSPCFEAcbQjTqOIlG3plO+cHmxjlM1ZrVsh6Jj3WS/ENB3KwCqwhRvy+Pd02x3hJAqN+mHyIc7IxirGpOfp/x607p1RW3QICChSdPyZZoEavKFcRbhaZG5zcNQ/lez9Wma2LlJVJTvh1mIVQMIRAI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2017 09:55:17.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0092
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create test-list-objects helper program to output a random sample of
OIDs present in the repo.

If no command line arguments are provided, all OIDs are output.

The first command line argument specifies how many samples to output.
Samples are collected across the entire set of available OIDs to avoid
clustering and therefore quite uniformly distributed.

If a second command line argument "--missing" is given, then a list of
OIDs is generated without examining the repo.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile                     |  1 +
 t/helper/.gitignore          |  1 +
 t/helper/test-list-objects.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 t/helper/test-list-objects.c

diff --git a/Makefile b/Makefile
index f2bb7f2f6..af94b655a 100644
--- a/Makefile
+++ b/Makefile
@@ -647,6 +647,7 @@ TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
 TEST_PROGRAMS_NEED_X += test-line-buffer
+TEST_PROGRAMS_NEED_X += test-list-objects
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 721650256..9dd1c9f3c 100644
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
index 000000000..83b1250fe
--- /dev/null
+++ b/t/helper/test-list-objects.c
@@ -0,0 +1,85 @@
+#include "cache.h"
+#include "packfile.h"
+#include <stdio.h>
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
+	unsigned int hash_delt = 0xFDB97531;
+	unsigned int hash_base = 0x01020304;
+	int i, n = 0;
+	struct count c;
+	const int u_per_oid = sizeof(struct object_id) / sizeof(unsigned int);
+
+	c.total = 0;
+	if (ac > 1)
+		n = atoi(av[1]);
+
+	if (ac > 2 && !strcmp(av[2], "--missing")) {
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
+		for_each_loose_object(count_loose, &c, 0);
+		for_each_packed_object(count_packed, &c, 0);
+
+		c.select_mod = 1 + c.total / n;
+
+		for_each_loose_object(output_loose, &c, 0);
+		for_each_packed_object(output_packed, &c, 0);
+	}
+
+	exit(0);
+}
-- 
2.14.1.538.g56ec8fc98.dirty

