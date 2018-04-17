Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC671F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754994AbeDQQfK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:35:10 -0400
Received: from mail-dm3nam03on0122.outbound.protection.outlook.com ([104.47.41.122]:13033
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754462AbeDQQew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zeKbLvcTKFPn7JngdauC5XSTBHflS0GDjZzYyCqc70s=;
 b=mMEQzKYGHkjTJ6nZyRM3Nd+KNYSHzaErq3Xof8ickzgztA1VBW0wYRjSm8IyFvTq9LXPjsJhzqZTN67kzuE1oupPhJoIe5DsgnSJkzHPv82TWBr4eDmRsk4ZTHLFqj7hPMHBnefUX8QBHFWMUEv4LTPstswlbKLJPxkFF66ipbc=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0899.namprd21.prod.outlook.com (52.132.23.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 16:34:45 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 16:34:45 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v1 4/5] Allocate cache entries from memory pools
Thread-Topic: [PATCH v1 4/5] Allocate cache entries from memory pools
Thread-Index: AQHT1mn88wR5R/tP0Eipgfn0WF/P/Q==
Date:   Tue, 17 Apr 2018 16:34:42 +0000
Message-ID: <20180417163400.3875-6-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0899;7:vm7yKA415zOIUN7VEI9f5mor6crDzbTa6rbs8068OSH2pKbCoYXwon6C1lcJzXZPKzs6GPskVqmnualDCQSrS8TiLygw2XwFbqiOtU8BrfQVXC8y78QfQ4xYFWe3Km4ULi+HUaYez3ET8pmIVaH5dmXMItTfObSbvhht7odM/b4sLOsiF+UFRhnoAyy/ECAiYN8v4qakZgY39OcmWMUK5Zw9Uev8D6dfjACjxZNbpSs7xmLAoMQtn8czmpmCCDuW;20:f11Zq/zfuZRjD2ja2NcJU8/UU2WIJE7j4FMb2Vpz79yl4Pe+AvXWfiN3oAidt1OKqj4pPZ/an7wz/C89qBjc8nc/5pe4NC4Uibj2JuO5rGmgLq5OtfsYRVjw68RcCwLUMQBYHKfL5AoovxOD2iJIGj/bRiL860r9ykWSA0mx4bE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0899;
x-ms-traffictypediagnostic: BL0PR2101MB0899:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB08991F24E59FBD4975CF5E79CEB70@BL0PR2101MB0899.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0899;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0899;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(7736002)(6116002)(5640700003)(2351001)(14454004)(6512007)(97736004)(8656006)(6486002)(53936002)(2906002)(4326008)(5660300001)(106356001)(39060400002)(6436002)(36756003)(107886003)(6666003)(6916009)(305945005)(1076002)(3280700002)(99286004)(22452003)(478600001)(59450400001)(316002)(476003)(446003)(2616005)(486006)(54906003)(6506007)(5250100002)(386003)(11346002)(10290500003)(575784001)(2900100001)(3660700001)(81166006)(81156014)(1730700003)(86362001)(8676002)(8936002)(10090500001)(186003)(68736007)(25786009)(46003)(86612001)(52116002)(76176011)(102836004)(105586002)(2501003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0899;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MtW852HaFjwfoS7wo75SJ+TzxOpPzJaKptsYrPS+jbqtEIHaJcBki1ftjW5FW32p7JRSPPkWmIOa5/bjHQ7cO8yfUyu+5OgVvPoSEk1prpn12aQcmBeFfmUbgaejano07czPNydGTTUO1m0BWPS6phuFU5uAPFPGAEhQEG9BEJu2mTzQ08fjy8w/h0O7CjRs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 06ba669f-8e33-47de-68d5-08d5a4811f43
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ba669f-8e33-47de-68d5-08d5a4811f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 16:34:42.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0899
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve performance of reading a large index by reducing the number of
malloc() calls. When reading an index with a large number of entries,
a portion of the time is dominated in malloc() calls. This can be
mitigated by allocating a single large block of memory up front into a
memory pool and have git hand out chunks of time.

This change moves the cache entry allocation to be on top of memory
pools.

Design:

The index_state struct will gain a notion of an associated memory_pool
from which cache_entry structs will be allocated from. When reading in
the index from disk, we have information on the number of entries and
their size, which can guide us in deciding how large our initial
memory allocation should be. When an index is discarded, the
associated memory_pool and cache entries from the memory pool will be
discarded as well. This means the lifetime of cache_entry structs are
tied to the lifetime of the index_state they were allocated for.

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
the entries from the `split_index`'s memory pool. This allows us to
follow the pattern that `the_index` can reference cache_entries from
the `split_index`, and that the cache_entries will not be freed while
they are still being referenced.
---
 cache.h       |  2 ++
 read-cache.c  | 95 +++++++++++++++++++++++++++++++++++++++++++++----------=
----
 split-index.c | 23 +++++++++++++--
 3 files changed, 95 insertions(+), 25 deletions(-)

diff --git a/cache.h b/cache.h
index eedf154815..7c0d2343c3 100644
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
index 04fa7e1bd0..67438bf375 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -46,6 +46,42 @@
 		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
 		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | FSMONITOR_CHANGED)
=20
+
+/*
+ * This is an estimate of the average pathname length in the index.  We us=
e
+ * this for V4 index files to guess the un-deltafied size of the index in
+ * memory because of pathname deltafication.  This is not required for V2/=
V3
+ * index formats because their pathnames are not compressed.  If the initi=
al
+ * amount of memory set aside is not sufficient, the mem pool will allocat=
e
+ * extra memory.
+ */
+#define CACHE_ENTRY_AVG_PATH_LENGTH_ESTIMATE 80
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
+	return entries * (sizeof(struct cache_entry) + CACHE_ENTRY_AVG_PATH_LENGT=
H_ESTIMATE);
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
-		index_cache_entry_discard(istate->cache[i]);
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
 void index_cache_entry_discard(struct cache_entry *ce)
 {
-	free(ce);
 }
=20
 void transient_cache_entry_discard(struct cache_entry *ce)
diff --git a/split-index.c b/split-index.c
index 361c821096..a920c0ad07 100644
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

