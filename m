Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA751F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbeFTURj (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:17:39 -0400
Received: from mail-by2nam01on0139.outbound.protection.outlook.com ([104.47.34.139]:24175
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932755AbeFTURg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RR17SXTZvtXYMRVuOi6YNq9ks5m/XTHWlu09u8RA+M=;
 b=OqcUWEbL3XJ3qBApiI/7dGO8Hz+mshDBXXGfdydbfAu/bJp9BV0XlgX6ug5+0FrDOrTgk2bUZEdLDZtQFNNcl9xyiZlW8WdCYtzwyHD+SyPLkXL+wgi/H809GYkVcNlXgGpxOvUspdWEciWejSwDjb2dNRUPDhWFqA/Ua3hLOdA=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0746.namprd21.prod.outlook.com (10.173.172.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.1; Wed, 20 Jun 2018 20:17:34 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 20:17:34 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 8/8] block alloc: add validations around cache_entry
 lifecyle
Thread-Topic: [PATCH v4 8/8] block alloc: add validations around cache_entry
 lifecyle
Thread-Index: AQHUCNO5Bdh2A/8xTU+PcahBLee9GA==
Date:   Wed, 20 Jun 2018 20:17:34 +0000
Message-ID: <20180620201557.77155-9-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180620201557.77155-1-jamill@microsoft.com>
In-Reply-To: <20180620201557.77155-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:404:23::32) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0746;7:ZJiLanyjMuTEaE3/CihuYgXORYPSTLoNhRrzD3wZOgadhTL6cUZXRsVaZXFYuugvxrKQhA0qboq9Fy1za8xMjG506SjnmORymoplyvrVHm9n89CqSUrREaIrCdWQ65q0NhBqV4zUq3rVtT5Oy/HeircP28bQFWATtMUC2ef4fhQklVB+snY9EWS+9DILkhUxlqWMvfd/M8V/YrksyDjzYJcpzQTiv9y3mcWEc3Vfp8XHPesRtPNk3ZmuULTJ0oNc
x-ms-office365-filtering-correlation-id: f84afd4c-b63d-4c0f-7336-08d5d6eadba2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0746;
x-ms-traffictypediagnostic: DM5PR21MB0746:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB07460840D249B255A8102E6ACE770@DM5PR21MB0746.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0746;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0746;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(199004)(189003)(10290500003)(8676002)(305945005)(14454004)(76176011)(11346002)(7736002)(68736007)(4326008)(5660300001)(39060400002)(25786009)(6916009)(52116002)(53936002)(106356001)(36756003)(8936002)(8656006)(1730700003)(22452003)(81156014)(386003)(186003)(2616005)(54906003)(59450400001)(316002)(102836004)(6506007)(446003)(478600001)(99286004)(81166006)(486006)(476003)(107886003)(2351001)(3660700001)(6486002)(46003)(97736004)(6512007)(2900100001)(86612001)(6436002)(6116002)(1076002)(5640700003)(3280700002)(5250100002)(2906002)(105586002)(575784001)(10090500001)(2501003)(86362001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0746;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bRGb/TujuWD36yrrgCatwJHjEGUJvGUc2VeZEm3OJEgJAHh/0+az8/Cj22Adorux3UNrLCDpFYIc/q0bVxPrIJvZcfFSHV6aWpwFmc1gsJAKABdF5+v4Ld9xXW99MHW1549t6wsBk066PpmqJ6Ck5eO0LU/wlv9QNjQGM+Le2slcNLg4L3bEEU3E5dd5kWC+AXFsyoE9Wkd6Vl8bK6yTmT+hAtOWGdLt/69ibTlyeDD2V3ceD+52TTM2HkolhwgUIOJ86SavjuV1oFSsFH3626wp+gv+Tg7Qy7MDEYk5rcnDV6I6LSO18xRyw5r60baLxsNG8locnn/BbdsIUdga9w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84afd4c-b63d-4c0f-7336-08d5d6eadba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 20:17:34.2594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0746
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
 read-cache.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 74d3ebebc2..c0d6b976f5 100644
--- a/cache.h
+++ b/cache.h
@@ -369,6 +369,12 @@ extern struct cache_entry *make_empty_transient_cache_=
entry(size_t name_len);
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
index c2f48d53dd..010898ba6d 100644
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
index 0f19cc01a9..92d106a637 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -51,7 +51,7 @@ void mem_pool_init(struct mem_pool **mem_pool, size_t ini=
tial_size)
 	*mem_pool =3D pool;
 }
=20
-void mem_pool_discard(struct mem_pool *mem_pool)
+void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
 {
 	struct mp_block *block, *block_to_free;
=20
@@ -60,6 +60,10 @@ void mem_pool_discard(struct mem_pool *mem_pool)
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
index a8932ce2a6..2652f2aeb0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2047,8 +2047,10 @@ int discard_index(struct index_state *istate)
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
@@ -2065,13 +2067,45 @@ int discard_index(struct index_state *istate)
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
@@ -2875,8 +2909,25 @@ struct cache_entry *dup_cache_entry(const struct cac=
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
2.14.3

