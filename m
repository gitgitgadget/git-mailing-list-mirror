Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2411F42D
	for <e@80x24.org>; Wed, 23 May 2018 14:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933460AbeEWOr4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 10:47:56 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:26688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933338AbeEWOrr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 10:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRWwfCA+pg1NnA6LbnaHSXStqIWUFkdamM+9byjm+uQ=;
 b=SqbFfmQhLWGrAcsC0xrHnHqcBGKSlZ1+LdWHQQiHPZR4o3EbQMZRNJWS1DXENErIXmQniAgltxqLrEFaWCtaNWsBoGHMICFD44anaZZkBEJNQQZuqwDHFTzkW5u/RJj3AbXU1lA0I/z1dYa1PVA+tx6X0d+GpTrj/LUfpUFpu+I=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Wed, 23 May 2018 14:47:41 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0797.007; Wed, 23 May 2018
 14:47:41 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 6/7] block alloc: allocate cache entries from mem_pool
Thread-Topic: [PATCH v3 6/7] block alloc: allocate cache entries from mem_pool
Thread-Index: AQHT8qUAZvD5xh4lB0eeDQalohuEAg==
Date:   Wed, 23 May 2018 14:47:41 +0000
Message-ID: <20180523144637.153551-7-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180523144637.153551-1-jamill@microsoft.com>
In-Reply-To: <20180523144637.153551-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR1801CA0033.namprd18.prod.outlook.com
 (2603:10b6:405:5f::46) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:JRV9vqR0Fa5OPct7qXDv23uhuq8SKQOYfmiwtCD5kCJ8qNJzF4PVJYIY7F+83T0kwD1wbP5pT+AJ3NYXZYIlIsP6wF3WvQwA77dcxc9LqxunaCnuUv4iQ/ODGkYPDSxMVS978ojc1fXtWYSad8dLEOxkJBewyVDBGyMVc2v0444j9Ya0jWqFhiox9yQrZpBT1kNCh7axZLKNmVQK7G33tjLpgTmAsnIW7CvRGaxLs0GF7UvEuQdiRezpvrmRQ3cE;20:uAiN1vTygILkgpOMiKPLAMofBFb4/8BevcIsyeyBsRQeWX+g3wGkDjLQ4EPC6dDlq0mZdD0Wy4MJ2NWkF1fRYeyvhH0cNocBlP88UC0owz/kYLIlg71w+330u51fyKyijuxPFrSwLMCKImWZ4cKTcSYj3omuo4jTIhtRYTFYM8g=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0977790E4EF70E68DD25A310CE6B0@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(60795455431006)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(76176011)(102836004)(99286004)(59450400001)(6506007)(386003)(2501003)(5250100002)(81166006)(81156014)(1730700003)(8676002)(105586002)(8936002)(305945005)(106356001)(97736004)(7736002)(86362001)(476003)(25786009)(2906002)(3660700001)(1076002)(14454004)(486006)(3280700002)(6116002)(446003)(11346002)(186003)(52116002)(2616005)(86612001)(46003)(10090500001)(6512007)(53936002)(2351001)(478600001)(36756003)(5660300001)(4326008)(6916009)(68736007)(6436002)(5640700003)(2900100001)(22452003)(316002)(54906003)(8656006)(39060400002)(10290500003)(53946003)(107886003)(6486002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: btGdPNuUg8z5e2e95sJGou+9sKvkqrHNzHiT51TQp0bat5zQZMRVko4ESSAihZQFeGZKA1MbFxBADZoo746RihktPC4IwmSwhWtJoImPaOeiGymaFUFljtYvwQENXvFCmUDa3/hybdBmXAfJ21fYtmjlWqH9dZ4bmbMminoxhVX8UCaki6sLPzsuy59dS1re
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 41dabf55-c2e4-4f4d-a8a1-08d5c0bc2280
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dabf55-c2e4-4f4d-a8a1-08d5c0bc2280
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 14:47:41.5430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
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

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 cache.h        |  21 ++++++++++
 read-cache.c   | 119 ++++++++++++++++++++++++++++++++++++++++++++++++-----=
----
 split-index.c  |  50 ++++++++++++++++++++----
 unpack-trees.c |  13 +------
 4 files changed, 165 insertions(+), 38 deletions(-)

diff --git a/cache.h b/cache.h
index 204f788438..7aae9c8db0 100644
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
@@ -156,6 +157,7 @@ struct cache_entry {
 	struct stat_data ce_stat_data;
 	unsigned int ce_mode;
 	unsigned int ce_flags;
+	unsigned int mem_pool_allocated;
 	unsigned int ce_namelen;
 	unsigned int index;	/* for link extension */
 	struct object_id oid;
@@ -227,6 +229,7 @@ static inline void copy_cache_entry(struct cache_entry =
*dst,
 				    const struct cache_entry *src)
 {
 	unsigned int state =3D dst->ce_flags & CE_HASHED;
+	int mem_pool_allocated =3D dst->mem_pool_allocated;
=20
 	/* Don't copy hash chain and name */
 	memcpy(&dst->ce_stat_data, &src->ce_stat_data,
@@ -235,6 +238,9 @@ static inline void copy_cache_entry(struct cache_entry =
*dst,
=20
 	/* Restore the hash state */
 	dst->ce_flags =3D (dst->ce_flags & ~CE_HASHED) | state;
+
+	/* Restore the mem_pool_allocated flag */
+	dst->mem_pool_allocated =3D mem_pool_allocated;
 }
=20
 static inline unsigned create_ce_flags(unsigned stage)
@@ -328,6 +334,7 @@ struct index_state {
 	struct untracked_cache *untracked;
 	uint64_t fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
+	struct mem_pool *ce_mem_pool;
 };
=20
 extern struct index_state the_index;
@@ -362,6 +369,20 @@ extern struct cache_entry *make_empty_transient_cache_=
entry(size_t name_len);
  */
 void discard_cache_entry(struct cache_entry *ce);
=20
+/*
+ * Duplicate a cache_entry. Allocate memory for the new entry from a
+ * memory_pool. Takes into account cache_entry fields that are meant
+ * for managing the underlying memory allocation of the cache_entry.
+ */
+struct cache_entry *dup_cache_entry(const struct cache_entry *ce, struct i=
ndex_state *istate);
+
+/*
+ * Validate the cache entries in the index.  This is an internal
+ * consistency check that the cache_entry structs are allocated from
+ * the expected memory pool.
+ */
+void validate_cache_entries(const struct index_state *istate);
+
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
 #define active_cache (the_index.cache)
 #define active_nr (the_index.cache_nr)
diff --git a/read-cache.c b/read-cache.c
index d51cc83312..02fe5d333c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -46,6 +46,48 @@
 		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
 		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | FSMONITOR_CHANGED)
=20
+
+/*
+ * This is an estimate of the pathname length in the index.  We use
+ * this for V4 index files to guess the un-deltafied size of the index
+ * in memory because of pathname deltafication.  This is not required
+ * for V2/V3 index formats because their pathnames are not compressed.
+ * If the initial amount of memory set aside is not sufficient, the
+ * mem pool will allocate extra memory.
+ */
+#define CACHE_ENTRY_PATH_LENGTH 80
+
+static inline struct cache_entry *mem_pool__ce_alloc(struct mem_pool *mem_=
pool, size_t len)
+{
+	struct cache_entry *ce;
+	ce =3D mem_pool_alloc(mem_pool, cache_entry_size(len));
+	ce->mem_pool_allocated =3D 1;
+	return ce;
+}
+
+static inline struct cache_entry *mem_pool__ce_calloc(struct mem_pool *mem=
_pool, size_t len)
+{
+	struct cache_entry * ce;
+	ce =3D mem_pool_calloc(mem_pool, 1, cache_entry_size(len));
+	ce->mem_pool_allocated =3D 1;
+	return ce;
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
@@ -746,7 +788,7 @@ int add_file_to_index(struct index_state *istate, const=
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
@@ -1641,13 +1683,13 @@ int read_index(struct index_state *istate)
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
@@ -1689,7 +1731,7 @@ static unsigned long expand_name_field(struct strbuf =
*name, const char *cp_)
 	return (const char *)ep + 1 - cp_;
 }
=20
-static struct cache_entry *create_from_disk(struct index_state *istate,
+static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
 					    struct ondisk_cache_entry *ondisk,
 					    unsigned long *ent_size,
 					    struct strbuf *previous_name)
@@ -1721,13 +1763,13 @@ static struct cache_entry *create_from_disk(struct =
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
@@ -1801,6 +1843,22 @@ static void post_read_index_from(struct index_state =
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
@@ -1847,10 +1905,15 @@ int do_read_index(struct index_state *istate, const=
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
@@ -1859,7 +1922,7 @@ int do_read_index(struct index_state *istate, const c=
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
@@ -1956,17 +2019,13 @@ int is_index_unborn(struct index_state *istate)
=20
 int discard_index(struct index_state *istate)
 {
-	int i;
+	/*
+	 * Cache entries in istate->cache[] should have been allocated
+	 * from the memory pool associated with this index, or from an
+	 * associated split_index. There is no need to free individual
+	 * cache entries.
+	 */
=20
-	for (i =3D 0; i < istate->cache_nr; i++) {
-		if (istate->cache[i]->index &&
-		    istate->split_index &&
-		    istate->split_index->base &&
-		    istate->cache[i]->index <=3D istate->split_index->base->cache_nr &&
-		    istate->cache[i] =3D=3D istate->split_index->base->cache[istate->cac=
he[i]->index - 1])
-			continue;
-		discard_cache_entry(istate->cache[i]);
-	}
 	resolve_undo_clear_index(istate);
 	istate->cache_nr =3D 0;
 	istate->cache_changed =3D 0;
@@ -1980,6 +2039,12 @@ int discard_index(struct index_state *istate)
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
@@ -2771,10 +2836,26 @@ void move_index_extensions(struct index_state *dst,=
 struct index_state *src)
 	src->untracked =3D NULL;
 }
=20
+struct cache_entry *dup_cache_entry(const struct cache_entry *ce,
+		     struct index_state *istate)
+{
+	unsigned int size =3D ce_size(ce);
+	int mem_pool_allocated;
+	struct cache_entry *new_entry =3D make_empty_index_cache_entry(istate, ce=
_namelen(ce));
+	mem_pool_allocated =3D new_entry->mem_pool_allocated;
+
+	memcpy(new_entry, ce, size);
+	new_entry->mem_pool_allocated =3D mem_pool_allocated;
+	return new_entry;
+}
+
 /*
  * Free cache entry.
  */
 void discard_cache_entry(struct cache_entry *ce)
 {
+	if (ce && ce->mem_pool_allocated)
+		return;
+
 	free(ce);
 }
diff --git a/split-index.c b/split-index.c
index ab638b844d..004d785d2f 100644
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
@@ -331,12 +346,31 @@ void remove_split_index(struct index_state *istate)
 {
 	if (istate->split_index) {
 		/*
-		 * can't discard_split_index(&the_index); because that
-		 * will destroy split_index->base->cache[], which may
-		 * be shared with the_index.cache[]. So yeah we're
-		 * leaking a bit here.
+		 * When removing the split index, we need to move
+		 * ownership of the mem_pool associated with the
+		 * base index to the main index. There may be cache entries
+		 * allocated from the base's memory pool that are shared with
+		 * the_index.cache[].
 		 */
-		istate->split_index =3D NULL;
+		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_=
pool);
+
+		/*
+		 * The split index no longer owns the mem_pool backing
+		 * its cache array. As we are discarding this index,
+		 * mark the index as having no cache entries, so it
+		 * will not attempt to clean up the cache entries or
+		 * validate them.
+		 */
+		if (istate->split_index->base)
+			istate->split_index->base->cache_nr =3D 0;
+
+		/*
+		 * We can discard the split index because its
+		 * memory pool has been incorporated into the
+		 * memory pool associated with the the_index.
+		 */
+		discard_split_index(istate);
+
 		istate->cache_changed |=3D SOMETHING_CHANGED;
 	}
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index dd4d12ba45..dc53f811ae 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -192,20 +192,11 @@ static int do_add_entry(struct unpack_trees_options *=
o, struct cache_entry *ce,
 			       ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 }
=20
-static struct cache_entry *dup_entry(const struct cache_entry *ce, struct =
index_state *istate)
-{
-	unsigned int size =3D ce_size(ce);
-	struct cache_entry *new_entry =3D make_empty_index_cache_entry(istate, ce=
_namelen(ce));
-
-	memcpy(new_entry, ce, size);
-	return new_entry;
-}
-
 static void add_entry(struct unpack_trees_options *o,
 		      const struct cache_entry *ce,
 		      unsigned int set, unsigned int clear)
 {
-	do_add_entry(o, dup_entry(ce, &o->result), set, clear);
+	do_add_entry(o, dup_cache_entry(ce, &o->result), set, clear);
 }
=20
 /*
@@ -1778,7 +1769,7 @@ static int merged_entry(const struct cache_entry *ce,
 			struct unpack_trees_options *o)
 {
 	int update =3D CE_UPDATE;
-	struct cache_entry *merge =3D dup_entry(ce, &o->result);
+	struct cache_entry *merge =3D dup_cache_entry(ce, &o->result);
=20
 	if (!old) {
 		/*
--=20
2.14.3

