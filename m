Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BCE71F516
	for <e@80x24.org>; Mon,  2 Jul 2018 19:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeGBTts (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 15:49:48 -0400
Received: from mail-eopbgr680125.outbound.protection.outlook.com ([40.107.68.125]:46256
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753105AbeGBTtl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 15:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo2MsagG7kWZ0c4o+cPfhmUFVjte/Oru8R/pHhZPzjo=;
 b=m6SKGJXCuRYqKfKFDPwAPsVg632wqOqaQyRkqpcxLv2xFRFVLfNJstOHw4cryBf/g8piT4TcF5WP7aRPSB9uqyWz4uwd/oSnLsxEWDb6q6dIbuUAGPVFfK0tutPUn2ClM76gw7octV6UF6/oUFHWByRZyFFJBptIz3Qpdl+vars=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0283.namprd21.prod.outlook.com (10.173.174.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 19:49:39 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989%4]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 19:49:39 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>
Subject: [PATCH v6 8/8] block alloc: add validations around cache_entry
 lifecyle
Thread-Topic: [PATCH v6 8/8] block alloc: add validations around cache_entry
 lifecyle
Thread-Index: AQHUEj3PPjZGIIH4y06/peUwWDOTpA==
Date:   Mon, 2 Jul 2018 19:49:39 +0000
Message-ID: <20180702193745.8940-9-jamill@microsoft.com>
References: <20180628135932.225288-1-jamill@microsoft.com>
 <20180702193745.8940-1-jamill@microsoft.com>
In-Reply-To: <20180702193745.8940-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN3PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:400:4::25) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0283;7:4kt0WLoENM4sdh86+5S28brS0hjSG9REwe09uHwe0Uc+WM5RXWi+9nVhGG+xo4jJgr1lvEM+X5ZcyEOKuDRl89Wz4nB/1vdT704VJFvQYO1ppgAFgdBMliE4SHA7mW2l5y3OJozLwobR4i/nbG5ax+f73wpBM9zH8J4OyVMTgnzZikR1kvC8ZFAH0ycS1U2cYuHcEceQy+fr81URkk0bR+My0a1hjdsJ0pBH1YM7/wfhASaoIQUMG4SwvvPn/bqA
x-ms-office365-filtering-correlation-id: 46de13e9-696d-4897-442a-08d5e054f1e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0283;
x-ms-traffictypediagnostic: DM5PR21MB0283:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB028348314EF7097740062947CE430@DM5PR21MB0283.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0283;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0283;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(5250100002)(7736002)(53936002)(8936002)(305945005)(81166006)(8676002)(81156014)(6200100001)(36756003)(1076002)(6436002)(6486002)(14454004)(97736004)(6512007)(106356001)(6116002)(478600001)(68736007)(10290500003)(2900100001)(2906002)(25786009)(76176011)(39060400002)(256004)(7049001)(14444005)(4326008)(86612001)(1511001)(6506007)(102836004)(46003)(86362001)(54906003)(386003)(6862004)(99286004)(37006003)(105586002)(52116002)(22452003)(11346002)(2616005)(446003)(486006)(10090500001)(316002)(476003)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0283;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Lfce4iwIUYlNVx6Ds/JVMOWfcy5JLeC7sLCaE3TP01Sc/MY6IJo1LRyqwqgQTAT0WbcNg1b+bPgC8qAfBBeIllrsk7YL9Lih9zmrRzg+2gCPssnY+sVQnOuzB+iiGMPiCr6W40YVoU78sraQPGvqbEOQZZLxVJ48E8crC+EL5KOVbQW+uRjUwtNIna2T5CC6WMDkZeTOI5k9XNuFGiYq+PMBR+sPLuHMaERdskrY5TwoYyGWLzqGFyrWmAVCE9PqelG4VV2Jg/oFJBJRaSwvnq9zWXvt6OhsytF9a80f+FeNIWrhLHRqdOvkF1JRoA2/t/YPzQBlSmE2kJ13hp4B9AAgiUU5ghoLzy/xMQNGyFk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46de13e9-696d-4897-442a-08d5e054f1e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 19:49:39.1101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0283
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option (controlled by an environment variable) perform extra
validations on mem_pool allocated cache entries. When set:

  1) Invalidate cache_entry memory when discarding cache_entry.

  2) When discarding index_state struct, verify that all cache_entries
     were allocated from expected mem_pool.

  3) When discarding mem_pools, invalidate mem_pool memory.

This should provide extra checks that mem_pools and their allocated
cache_entries are being used as expected.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 cache.h      |  6 ++++++
 git.c        |  3 +++
 mem-pool.c   |  6 +++++-
 mem-pool.h   |  2 +-
 read-cache.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 8fd89ae51f..b3faef3efc 100644
--- a/cache.h
+++ b/cache.h
@@ -380,6 +380,12 @@ struct cache_entry *make_empty_transient_cache_entry(s=
ize_t name_len);
  */
 void discard_cache_entry(struct cache_entry *ce);
=20
+/*
+ * Check configuration if we should perform extra validation on cache
+ * entries.
+ */
+int should_validate_cache_entries(void);
+
 /*
  * Duplicate a cache_entry. Allocate memory for the new entry from a
  * memory_pool. Takes into account cache_entry fields that are meant
diff --git a/git.c b/git.c
index 9dbe6ffaa7..c7e4f0351a 100644
--- a/git.c
+++ b/git.c
@@ -414,7 +414,10 @@ static int run_builtin(struct cmd_struct *p, int argc,=
 const char **argv)
=20
 	trace_argv_printf(argv, "trace: built-in: git");
=20
+	validate_cache_entries(&the_index);
 	status =3D p->fn(argc, argv, prefix);
+	validate_cache_entries(&the_index);
+
 	if (status)
 		return status;
=20
diff --git a/mem-pool.c b/mem-pool.c
index 139617cb23..a2841a4a9a 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -50,7 +50,7 @@ void mem_pool_init(struct mem_pool **mem_pool, size_t ini=
tial_size)
 	*mem_pool =3D pool;
 }
=20
-void mem_pool_discard(struct mem_pool *mem_pool)
+void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
 {
 	struct mp_block *block, *block_to_free;
=20
@@ -59,6 +59,10 @@ void mem_pool_discard(struct mem_pool *mem_pool)
 	{
 		block_to_free =3D block;
 		block =3D block->next_block;
+
+		if (invalidate_memory)
+			memset(block_to_free->space, 0xDD, ((char *)block_to_free->end) - ((cha=
r *)block_to_free->space));
+
 		free(block_to_free);
 	}
=20
diff --git a/mem-pool.h b/mem-pool.h
index adeefdcb28..999d3c3a52 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -29,7 +29,7 @@ void mem_pool_init(struct mem_pool **mem_pool, size_t ini=
tial_size);
 /*
  * Discard a memory pool and free all the memory it is responsible for.
  */
-void mem_pool_discard(struct mem_pool *mem_pool);
+void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory);
=20
 /*
  * Alloc memory from the mem_pool.
diff --git a/read-cache.c b/read-cache.c
index b07369660b..fd67e2e8a4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2050,8 +2050,10 @@ int discard_index(struct index_state *istate)
 	 * Cache entries in istate->cache[] should have been allocated
 	 * from the memory pool associated with this index, or from an
 	 * associated split_index. There is no need to free individual
-	 * cache entries.
+	 * cache entries. validate_cache_entries can detect when this
+	 * assertion does not hold.
 	 */
+	validate_cache_entries(istate);
=20
 	resolve_undo_clear_index(istate);
 	istate->cache_nr =3D 0;
@@ -2068,13 +2070,45 @@ int discard_index(struct index_state *istate)
 	istate->untracked =3D NULL;
=20
 	if (istate->ce_mem_pool) {
-		mem_pool_discard(istate->ce_mem_pool);
+		mem_pool_discard(istate->ce_mem_pool, should_validate_cache_entries());
 		istate->ce_mem_pool =3D NULL;
 	}
=20
 	return 0;
 }
=20
+/*
+ * Validate the cache entries of this index.
+ * All cache entries associated with this index
+ * should have been allocated by the memory pool
+ * associated with this index, or by a referenced
+ * split index.
+ */
+void validate_cache_entries(const struct index_state *istate)
+{
+	int i;
+
+	if (!should_validate_cache_entries() ||!istate || !istate->initialized)
+		return;
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		if (!istate) {
+			die("internal error: cache entry is not allocated from expected memory =
pool");
+		} else if (!istate->ce_mem_pool ||
+			!mem_pool_contains(istate->ce_mem_pool, istate->cache[i])) {
+			if (!istate->split_index ||
+				!istate->split_index->base ||
+				!istate->split_index->base->ce_mem_pool ||
+				!mem_pool_contains(istate->split_index->base->ce_mem_pool, istate->cac=
he[i])) {
+				die("internal error: cache entry is not allocated from expected memory=
 pool");
+			}
+		}
+	}
+
+	if (istate->split_index)
+		validate_cache_entries(istate->split_index->base);
+}
+
 int unmerged_index(const struct index_state *istate)
 {
 	int i;
@@ -2878,8 +2912,25 @@ struct cache_entry *dup_cache_entry(const struct cac=
he_entry *ce,
=20
 void discard_cache_entry(struct cache_entry *ce)
 {
+	if (ce && should_validate_cache_entries())
+		memset(ce, 0xCD, cache_entry_size(ce->ce_namelen));
+
 	if (ce && ce->mem_pool_allocated)
 		return;
=20
 	free(ce);
 }
+
+int should_validate_cache_entries(void)
+{
+	static int validate_index_cache_entries =3D -1;
+
+	if (validate_index_cache_entries < 0) {
+		if (getenv("GIT_TEST_VALIDATE_INDEX_CACHE_ENTRIES"))
+			validate_index_cache_entries =3D 1;
+		else
+			validate_index_cache_entries =3D 0;
+	}
+
+	return validate_index_cache_entries;
+}
--=20
2.17.1

