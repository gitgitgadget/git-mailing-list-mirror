Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A3F8215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeD3Pbx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:31:53 -0400
Received: from mail-bn3nam01on0103.outbound.protection.outlook.com ([104.47.33.103]:2570
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754665AbeD3Pbp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AvDhWwF8kIJYXnigbeARt6Em8AiVfZMqDVLp6bpIfO0=;
 b=ZslJn80zKhH67mD4DoUvPzE/8cgaEcJDA6GMr7TD7fE84E2G9/NgStcEVF0InrwRA6LIW3mPh7UOYqGFEUMNChPcuu7WLH7HgI1R0KlEigtJRqMr2ASHoHpRTDdHu2zcvofp56f0xlhW4n9dLqHaLMjvuGO9trhO7eXxjaU3+FQ=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0914.namprd21.prod.outlook.com (52.132.23.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Mon, 30 Apr 2018 15:31:44 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0755.002; Mon, 30 Apr 2018
 15:31:44 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 4/5] block alloc: allocate cache entries from mem_pool
Thread-Topic: [PATCH v2 4/5] block alloc: allocate cache entries from mem_pool
Thread-Index: AQHT4JhXG2pMMtvih0a2ktHIz4XnXA==
Date:   Mon, 30 Apr 2018 15:31:44 +0000
Message-ID: <20180430153122.243976-5-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180430153122.243976-1-jamill@microsoft.com>
In-Reply-To: <20180430153122.243976-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN4PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:403:3::17) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0914;7:kG02wrEE/ZBABv+mb7njxIo5Chl2KIZdWKJr30UnvHGWY/U8fWyEbBGW9tGuqc6HngdtkmEcF/08MPd4YeK+shzTM5Otpa7W+HsT3S5vDRdJlM7pS1ApYEsMFWyraqlyKi3AMe5On1lh39xB75tBoeoe4Y7cMy08M+VOpL8XH5yE9gyvbBs4W3fof8sHHWoKI/qmU2/kJiVJFIf2RYNmLMI8S5CdfWq+iAiZ4BZeTQ3UKyo4BIiUDxJTdklfwCIY;20:7jUYuB6oFhCHOVwpF1UEB1IdOa6l+ZF7cvVLKoZ77RKfCeCUb+/wMRJ5TbbRbZSMhQ5kTZKLLWHKNolrsnsiUDrLBfWqIEQTvKJMf0qXs51e5anz797/wp4+TjX+K8+Apb1zR1G5QjnD1t+lNzbrMsXV71JdUWUEvUoWFDzCm6s=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0914;
x-ms-traffictypediagnostic: BL0PR2101MB0914:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0914B20C75F2E309D0DEC531CE820@BL0PR2101MB0914.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(60795455431006)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0914;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0914;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(396003)(376002)(39860400002)(189003)(199004)(4326008)(36756003)(97736004)(8936002)(1730700003)(81156014)(81166006)(46003)(14454004)(22452003)(8676002)(86612001)(8656006)(186003)(6436002)(54906003)(6116002)(3660700001)(1076002)(105586002)(6512007)(53936002)(476003)(2906002)(107886003)(2616005)(316002)(6486002)(3280700002)(68736007)(2351001)(39060400002)(11346002)(5640700003)(446003)(2501003)(99286004)(486006)(6916009)(2900100001)(102836004)(5660300001)(59450400001)(7736002)(52116002)(6506007)(106356001)(386003)(305945005)(86362001)(10290500003)(25786009)(5250100002)(10090500001)(478600001)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0914;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hNEw6mQbJRK8H02YNb/eqSnEd0LqZF7CRGpuVrl/LBRW0+hoClrjSk1uYkhr9xDzRm/HpgzgosC4h7yJ8zjoxUPghgjDAfk4z13KXdMlbwb+D9poZIgpH6kmRZTl0iG5bidsn9PoqjF2nOSaO7svqBUoAxaZcVvyKS/mwoYRNy390XJmxYTA+AOIlOQvZs+s
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a4fc5898-96bf-41e2-761b-08d5aeaf7a47
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fc5898-96bf-41e2-761b-08d5aeaf7a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 15:31:44.2280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0914
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading large indexes from disk, a portion of the time is
dominated in malloc() calls. This can be mitigated by allocating a
large block of memory and manage it ourselves via memory pools.

This change moves the cache entry allocation to be on top of memory
pools.

Design:
The index_state struct will gain a notion of an associated memory_pool
from which cache_entries will be allocated from. When reading in the
index from disk, we have information on the number of entries and
their size, which can guide us in deciding how large our initial
memory allocation should be. When an index is discarded, the
associated memory_pool will be discarded as well - so the lifetime of
a cache_entry is tied to the lifetime of the index_state that it was
allocated for.

In the case of a Split Index, the following rules are followed. 1st,
some terminology is defined:

Terminology:
  - 'the_index': represents the logical view of the index

  - 'split_index': represents the "base" cache entries. Read from the
    split index file.

'the_index' can reference a single split_index, as well as
cache_entries from the split_index. `the_index` will be discarded
before the `split_index` is.  This means that when we are allocating
cache_entries in the presence of a split index, we need to allocate
the entries from the `split_index`'s memory pool.  This allows us to
follow the pattern that `the_index` can reference cache_entries from
the `split_index`, and that the cache_entries will not be freed while
they are still being referenced.

Alternatives:
The current design does not track whether a cache_entry is allocated
from a pool or not. Instead, it relies on the caller to know how the
cache_entry will be used and to handle its lifecyle appropriately,
including calling the correct free() method. Instead, we could include
a bit of information in the cache_entry (either a bit indicating
whether cache_entry was allocated from a pool or not, or possibly even
a pointer back to the allocating pool), which can then be used to make
informed decisions about these objects. The downside of this approach
is that the cache_entry type would need to grow to incorporate this
information.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 cache.h       |  2 ++
 read-cache.c  | 95 +++++++++++++++++++++++++++++++++++++++++++++----------=
----
 split-index.c | 23 +++++++++++++--
 3 files changed, 95 insertions(+), 25 deletions(-)

diff --git a/cache.h b/cache.h
index 3760adbe25..7ed68f28e0 100644
--- a/cache.h
+++ b/cache.h
@@ -15,6 +15,7 @@
 #include "path.h"
 #include "sha1-array.h"
 #include "repository.h"
+#include "mem-pool.h"
=20
 #include <zlib.h>
 typedef struct git_zstream {
@@ -328,6 +329,7 @@ struct index_state {
 	struct untracked_cache *untracked;
 	uint64_t fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
+	struct mem_pool *ce_mem_pool;
 };
=20
 extern struct index_state the_index;
diff --git a/read-cache.c b/read-cache.c
index 2a61cee130..01cd7fea41 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -46,6 +46,42 @@
 		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
 		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | FSMONITOR_CHANGED)
=20
+
+/*
+ * This is a guess of an pathname in the index.  We use this for V4
+ * index files to guess the un-deltafied size of the index in memory
+ * because of pathname deltafication.  This is not required for V2/V3
+ * index formats because their pathnames are not compressed.  If the
+ * initial amount of memory set aside is not sufficient, the mem pool
+ * will allocate extra memory.
+ */
+#define CACHE_ENTRY_PATH_LENGTH 80
+
+static inline struct cache_entry *mem_pool__ce_alloc(struct mem_pool *mem_=
pool, size_t len)
+{
+	return mem_pool_alloc(mem_pool, cache_entry_size(len));
+}
+
+static inline struct cache_entry *mem_pool__ce_calloc(struct mem_pool *mem=
_pool, size_t len)
+{
+	return mem_pool_calloc(mem_pool, 1, cache_entry_size(len));
+}
+
+static struct mem_pool *find_mem_pool(struct index_state *istate)
+{
+	struct mem_pool **pool_ptr;
+
+	if (istate->split_index && istate->split_index->base)
+		pool_ptr =3D &istate->split_index->base->ce_mem_pool;
+	else
+		pool_ptr =3D &istate->ce_mem_pool;
+
+	if (!*pool_ptr)
+		mem_pool_init(pool_ptr, 0);
+
+	return *pool_ptr;
+}
+
 struct index_state the_index;
 static const char *alternate_index_output;
=20
@@ -746,7 +782,7 @@ int add_file_to_index(struct index_state *istate, const=
 char *path, int flags)
=20
 struct cache_entry *make_empty_index_cache_entry(struct index_state *istat=
e, size_t len)
 {
-	return xcalloc(1, cache_entry_size(len));
+	return mem_pool__ce_calloc(find_mem_pool(istate), len);
 }
=20
 struct cache_entry *make_empty_transient_cache_entry(size_t len)
@@ -1641,13 +1677,13 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file(), get_git_dir());
 }
=20
-static struct cache_entry *cache_entry_from_ondisk(struct index_state *ist=
ate,
+static struct cache_entry *cache_entry_from_ondisk(struct mem_pool *mem_po=
ol,
 						   struct ondisk_cache_entry *ondisk,
 						   unsigned int flags,
 						   const char *name,
 						   size_t len)
 {
-	struct cache_entry *ce =3D make_empty_index_cache_entry(istate, len);
+	struct cache_entry *ce =3D mem_pool__ce_alloc(mem_pool, len);
=20
 	ce->ce_stat_data.sd_ctime.sec =3D get_be32(&ondisk->ctime.sec);
 	ce->ce_stat_data.sd_mtime.sec =3D get_be32(&ondisk->mtime.sec);
@@ -1689,7 +1725,7 @@ static unsigned long expand_name_field(struct strbuf =
*name, const char *cp_)
 	return (const char *)ep + 1 - cp_;
 }
=20
-static struct cache_entry *create_from_disk(struct index_state *istate,
+static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
 					    struct ondisk_cache_entry *ondisk,
 					    unsigned long *ent_size,
 					    struct strbuf *previous_name)
@@ -1721,13 +1757,13 @@ static struct cache_entry *create_from_disk(struct =
index_state *istate,
 		/* v3 and earlier */
 		if (len =3D=3D CE_NAMEMASK)
 			len =3D strlen(name);
-		ce =3D cache_entry_from_ondisk(istate, ondisk, flags, name, len);
+		ce =3D cache_entry_from_ondisk(mem_pool, ondisk, flags, name, len);
=20
 		*ent_size =3D ondisk_ce_size(ce);
 	} else {
 		unsigned long consumed;
 		consumed =3D expand_name_field(previous_name, name);
-		ce =3D cache_entry_from_ondisk(istate, ondisk, flags,
+		ce =3D cache_entry_from_ondisk(mem_pool, ondisk, flags,
 					     previous_name->buf,
 					     previous_name->len);
=20
@@ -1801,6 +1837,22 @@ static void post_read_index_from(struct index_state =
*istate)
 	tweak_fsmonitor(istate);
 }
=20
+static size_t estimate_cache_size_from_compressed(unsigned int entries)
+{
+	return entries * (sizeof(struct cache_entry) + CACHE_ENTRY_PATH_LENGTH);
+}
+
+static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries=
)
+{
+	long per_entry =3D sizeof(struct cache_entry) - sizeof(struct ondisk_cach=
e_entry);
+
+	/*
+	 * Account for potential alignment differences.
+	 */
+	per_entry +=3D align_padding_size(sizeof(struct cache_entry), -sizeof(str=
uct ondisk_cache_entry));
+	return ondisk_size + entries * per_entry;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_e=
xist)
 {
@@ -1847,10 +1899,15 @@ int do_read_index(struct index_state *istate, const=
 char *path, int must_exist)
 	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(*istate->cache));
 	istate->initialized =3D 1;
=20
-	if (istate->version =3D=3D 4)
+	if (istate->version =3D=3D 4) {
 		previous_name =3D &previous_name_buf;
-	else
+		mem_pool_init(&istate->ce_mem_pool,
+			      estimate_cache_size_from_compressed(istate->cache_nr));
+	} else {
 		previous_name =3D NULL;
+		mem_pool_init(&istate->ce_mem_pool,
+			      estimate_cache_size(mmap_size, istate->cache_nr));
+	}
=20
 	src_offset =3D sizeof(*hdr);
 	for (i =3D 0; i < istate->cache_nr; i++) {
@@ -1859,7 +1916,7 @@ int do_read_index(struct index_state *istate, const c=
har *path, int must_exist)
 		unsigned long consumed;
=20
 		disk_ce =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce =3D create_from_disk(istate, disk_ce, &consumed, previous_name);
+		ce =3D create_from_disk(istate->ce_mem_pool, disk_ce, &consumed, previou=
s_name);
 		set_index_entry(istate, i, ce);
=20
 		src_offset +=3D consumed;
@@ -1956,17 +2013,6 @@ int is_index_unborn(struct index_state *istate)
=20
 int discard_index(struct index_state *istate)
 {
-	int i;
-
-	for (i =3D 0; i < istate->cache_nr; i++) {
-		if (istate->cache[i]->index &&
-		    istate->split_index &&
-		    istate->split_index->base &&
-		    istate->cache[i]->index <=3D istate->split_index->base->cache_nr &&
-		    istate->cache[i] =3D=3D istate->split_index->base->cache[istate->cac=
he[i]->index - 1])
-			continue;
-		discard_index_cache_entry(istate->cache[i]);
-	}
 	resolve_undo_clear_index(istate);
 	istate->cache_nr =3D 0;
 	istate->cache_changed =3D 0;
@@ -1980,6 +2026,12 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked =3D NULL;
+
+	if (istate->ce_mem_pool) {
+		mem_pool_discard(istate->ce_mem_pool);
+		istate->ce_mem_pool =3D NULL;
+	}
+
 	return 0;
 }
=20
@@ -2772,11 +2824,10 @@ void move_index_extensions(struct index_state *dst,=
 struct index_state *src)
 }
=20
 /*
- * Free cache entry allocated for an index.
+ * Indicate that a cache entry is no longer is use
  */
 void discard_index_cache_entry(struct cache_entry *ce)
 {
-	free(ce);
 }
=20
 void discard_transient_cache_entry(struct cache_entry *ce)
diff --git a/split-index.c b/split-index.c
index d3326d2645..6d82c4e148 100644
--- a/split-index.c
+++ b/split-index.c
@@ -73,16 +73,31 @@ void move_cache_to_base_index(struct index_state *istat=
e)
 	int i;
=20
 	/*
-	 * do not delete old si->base, its index entries may be shared
-	 * with istate->cache[]. Accept a bit of leaking here because
-	 * this code is only used by short-lived update-index.
+	 * If there was a previous base index, then transfer ownership of allocat=
ed
+	 * entries to the parent index.
 	 */
+	if (si->base &&
+		si->base->ce_mem_pool) {
+
+		if (!istate->ce_mem_pool)
+			mem_pool_init(&istate->ce_mem_pool, 0);
+
+		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_=
pool);
+	}
+
 	si->base =3D xcalloc(1, sizeof(*si->base));
 	si->base->version =3D istate->version;
 	/* zero timestamp disables racy test in ce_write_index() */
 	si->base->timestamp =3D istate->timestamp;
 	ALLOC_GROW(si->base->cache, istate->cache_nr, si->base->cache_alloc);
 	si->base->cache_nr =3D istate->cache_nr;
+
+	/*
+	 * The mem_pool needs to move with the allocated entries.
+	 */
+	si->base->ce_mem_pool =3D istate->ce_mem_pool;
+	istate->ce_mem_pool =3D NULL;
+
 	COPY_ARRAY(si->base->cache, istate->cache, istate->cache_nr);
 	mark_base_index_entries(si->base);
 	for (i =3D 0; i < si->base->cache_nr; i++)
@@ -330,6 +345,8 @@ void add_split_index(struct index_state *istate)
 void remove_split_index(struct index_state *istate)
 {
 	if (istate->split_index) {
+		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_=
pool);
+
 		/*
 		 * can't discard_split_index(&the_index); because that
 		 * will destroy split_index->base->cache[], which may
--=20
2.14.3

