Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188201F404
	for <e@80x24.org>; Wed, 12 Sep 2018 16:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeILVY5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 17:24:57 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:65110
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727749AbeILVY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 17:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilnHYqNk9N5ET0vw2T9ptQtkRKe+M6GSW5YXnyEjLr8=;
 b=Rn6Xj666Be8OLKpl+0A/GJmSERqVKPU1XJzIrw5okcRVtF/yMZxsSj3e7QeB0NDIwLRXfE0cHYroaOLL2WO2HFvsj/V5Y0JRtIb/c2UCFxD1TJtnk8RK5/K5OaZ6U68kjncfDalJTuW4ScLJw/gAi+UQUXNQNkUW6BJXAR8PSXQ=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1100.namprd21.prod.outlook.com (52.132.149.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Wed, 12 Sep 2018 16:18:59 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.006; Wed, 12 Sep 2018
 16:18:59 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v5 5/5] read-cache: clean up casting and byte decoding
Thread-Topic: [PATCH v5 5/5] read-cache: clean up casting and byte decoding
Thread-Index: AQHUSrRPJ9oC9Tyf90yZYIIEtKD2Fw==
Date:   Wed, 12 Sep 2018 16:18:59 +0000
Message-ID: <20180912161832.55324-6-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com>
In-Reply-To: <20180912161832.55324-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: DM5PR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:4:4a::21) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;6:cBgrGKBrDFY84SS5TndCi/5w2r268EjysvcBSAlCLLxWK5xxmwoh3EN4q8VVcdjEDHnqwzai9vfrwR5CDhpJlo6y7p3XXaFmarqt/2sm50/KoJFpELc3hAYrPyZNzkD04mDlH9ZT78KA3oP7Lt/bJyGRPBHA7hwyVNdHk8LpQLK3YGjxZB+v4IbJFD+K4/fex1X8l1jK4ZmaYJbKkSgHRPsVQyKEZicCnfaBvxLfFA+z1bi030i3jIjiI2HoacJ+O2j3RQZDai25XW/zhRgdENB33h/tDqCiMvM4+pf2cXNKLYgiE4vLtVbSH4sRuNg+E0Zm5lHAqGP3BgpBm00xIkoeK8oaasjvNaFuJs4R4O1y8yAAm9y4ZN2LZXgYX5J8t2O0cfCnSKZAXYHw5pZtNBUyXytlHKYwS6t17KPiXN3wO1LlEd0Xt/i+06v6FQvQIWyWvwiAPRXfQNpWmmCZGw==;5:3ALVMutQ8TLldQJ6Z+FrqDSUbP5Bq8TqNCzB4qk/qnEsYQna9Isc4z1aUIae2g5u0tQ+R++JKw+oVT6/0ilJ8ZOeZwA7AYEHMWrtBQbKiVIZAgqoH9Pr3HFnyzXbKusFfKlZJd2Q1brthuQFEl947ZY0Ej2AM9yRlNRTtGuYX6I=;7:YbG0V13e4rGGbU5clZ2scwto2ECtvKbfmvBTAw5ISHQCShJNJ3eTGdMr3jueMD0Ul229KLSM1uOyOL/sfK+kZPEMBzMSTjSG2eh9O86wVCYQNppUTFUTd9w29/r+J+snH+tSD4nZpTORTEbMhNOUSx4CLRWbm77Z8HgpOS3p2JR+FnlnkEITdqmvCAqHpYPDHDiOEKg4Li763uGZeBrnzfkM72qDHfkRkDrCoRV72EwNSBvQUAiHO4efZF8ChoFM
x-ms-office365-filtering-correlation-id: 061883d8-79c8-4c9d-0df8-08d618cb71c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1100FBF97218D0D6C7BCDD03F41B0@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(14444005)(14454004)(5250100002)(4326008)(107886003)(1730700003)(6916009)(102836004)(53936002)(8936002)(446003)(10090500001)(76176011)(99286004)(186003)(256004)(8676002)(1076002)(2501003)(2616005)(97736004)(39060400002)(36756003)(7736002)(305945005)(52116002)(5660300001)(26005)(81166006)(81156014)(50226002)(476003)(316002)(25786009)(6506007)(478600001)(3846002)(54906003)(86612001)(6116002)(6486002)(6436002)(386003)(11346002)(2906002)(72206003)(10290500003)(66066001)(5640700003)(106356001)(486006)(22452003)(105586002)(6512007)(2351001)(68736007)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RLXbBVoC55NliiCfKiCMRez2eGhw9nr3Q8fLESRbdmcUMfN7HPRzbqGULK3X/rhurojNjUgV+wgVwt+/EAPLDCsH28o6esSZYk7GOcuno2RbKeKy/U7GrouG6nPT+l/QBaKr2qLlyKsugTCR86+43kl7daMzu1RkwSKqdvSi3SJU3z1bV18PMyK3eIB3yAEig/xgIA/1e5Hbj7dsIKuZ5c84Ku1YX7r+875yuVpXF0CzOIjY99jW87BFKXos3cfu0Lk5qcV1anUjIG6qR6j/tc37v6ya87jsBs7yf62Okj6eUICesu1Hsax3Zf/R4c3xk/TudxwGtaCbZQUC23g76SPCHTmCtyt9rKB/M3pgvX8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061883d8-79c8-4c9d-0df8-08d618cb71c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 16:18:59.1805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch does a clean up pass to minimize the casting required to work
with the memory mapped index (mmap).

It also makes the decoding of network byte order more consistent by using
get_be32() where possible.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 read-cache.c | 49 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 40dc4723b2..c05e887fc9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1655,7 +1655,7 @@ int verify_index_checksum;
 /* Allow fsck to force verification of the cache entry order. */
 int verify_ce_order;
=20
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 {
 	git_hash_ctx c;
 	unsigned char hash[GIT_MAX_RAWSZ];
@@ -1679,7 +1679,7 @@ static int verify_hdr(struct cache_header *hdr, unsig=
ned long size)
 }
=20
 static int read_index_extension(struct index_state *istate,
-				const char *ext, void *data, unsigned long sz)
+				const char *ext, const char *data, unsigned long sz)
 {
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
@@ -1902,7 +1902,7 @@ static size_t estimate_cache_size(size_t ondisk_size,=
 unsigned int entries)
 }
=20
 #ifndef NO_PTHREADS
-static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size);
+static unsigned long read_eoie_extension(const char *mmap, size_t mmap_siz=
e);
 #endif
 static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_con=
text, unsigned long offset);
=20
@@ -1912,14 +1912,14 @@ struct load_index_extensions
 	pthread_t pthread;
 #endif
 	struct index_state *istate;
-	void *mmap;
+	const char *mmap;
 	size_t mmap_size;
 	unsigned long src_offset;
 };
=20
-static void *load_index_extensions(void *_data)
+static void *load_index_extensions(void *data)
 {
-	struct load_index_extensions *p =3D _data;
+	struct load_index_extensions *p =3D data;
 	unsigned long src_offset =3D p->src_offset;
=20
 	while (src_offset <=3D p->mmap_size - the_hash_algo->rawsz - 8) {
@@ -1930,13 +1930,12 @@ static void *load_index_extensions(void *_data)
 		 * in 4-byte network byte order.
 		 */
 		uint32_t extsize;
-		memcpy(&extsize, (char *)p->mmap + src_offset + 4, 4);
-		extsize =3D ntohl(extsize);
+		extsize =3D get_be32(p->mmap + src_offset + 4);
 		if (read_index_extension(p->istate,
-			(const char *)p->mmap + src_offset,
-			(char *)p->mmap + src_offset + 8,
+			p->mmap + src_offset,
+			p->mmap + src_offset + 8,
 			extsize) < 0) {
-			munmap(p->mmap, p->mmap_size);
+			munmap((void *)p->mmap, p->mmap_size);
 			die("index file corrupt");
 		}
 		src_offset +=3D 8;
@@ -1951,7 +1950,7 @@ static void *load_index_extensions(void *_data)
  * from the memory mapped file and add them to the given index.
  */
 static unsigned long load_cache_entry_block(struct index_state *istate,
-			struct mem_pool *ce_mem_pool, int offset, int nr, void *mmap,
+			struct mem_pool *ce_mem_pool, int offset, int nr, const char *mmap,
 			unsigned long start_offset, const struct cache_entry *previous_ce)
 {
 	int i;
@@ -1962,7 +1961,7 @@ static unsigned long load_cache_entry_block(struct in=
dex_state *istate,
 		struct cache_entry *ce;
 		unsigned long consumed;
=20
-		disk_ce =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		disk_ce =3D (struct ondisk_cache_entry *)(mmap + src_offset);
 		ce =3D create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed=
, previous_ce);
 		set_index_entry(istate, i, ce);
=20
@@ -1973,7 +1972,7 @@ static unsigned long load_cache_entry_block(struct in=
dex_state *istate,
 }
=20
 static unsigned long load_all_cache_entries(struct index_state *istate,
-			void *mmap, size_t mmap_size, unsigned long src_offset)
+			const char *mmap, size_t mmap_size, unsigned long src_offset)
 {
 	unsigned long consumed;
=20
@@ -2006,7 +2005,7 @@ struct load_cache_entries_thread_data
 	struct index_state *istate;
 	struct mem_pool *ce_mem_pool;
 	int offset, nr;
-	void *mmap;
+	const char *mmap;
 	unsigned long start_offset;
 	struct cache_entry *previous_ce;
 	unsigned long consumed;	/* return # of bytes in index file processed */
@@ -2026,7 +2025,7 @@ static void *load_cache_entries_thread(void *_data)
 }
=20
 static unsigned long load_cache_entries_threaded(int nr_threads, struct in=
dex_state *istate,
-			void *mmap, size_t mmap_size, unsigned long src_offset)
+			const char *mmap, size_t mmap_size, unsigned long src_offset)
 {
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
 	struct load_cache_entries_thread_data *data;
@@ -2095,7 +2094,7 @@ static unsigned long load_cache_entries_threaded(int =
nr_threads, struct index_st
 				break;
 		}
=20
-		ondisk =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		ondisk =3D (struct ondisk_cache_entry *)(mmap + src_offset);
=20
 		/* On-disk flags are just 16 bits */
 		flags =3D get_be16(&ondisk->flags);
@@ -2143,8 +2142,8 @@ int do_read_index(struct index_state *istate, const c=
har *path, int must_exist)
 	int fd;
 	struct stat st;
 	unsigned long src_offset;
-	struct cache_header *hdr;
-	void *mmap;
+	const struct cache_header *hdr;
+	const char *mmap;
 	size_t mmap_size;
 	struct load_index_extensions p =3D { 0 };
 	unsigned long extension_offset =3D 0;
@@ -2176,7 +2175,7 @@ int do_read_index(struct index_state *istate, const c=
har *path, int must_exist)
 		die_errno("unable to map index file");
 	close(fd);
=20
-	hdr =3D mmap;
+	hdr =3D (const struct cache_header *)mmap;
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
=20
@@ -2236,11 +2235,11 @@ int do_read_index(struct index_state *istate, const=
 char *path, int must_exist)
 		p.src_offset =3D src_offset;
 		load_index_extensions(&p);
 	}
-	munmap(mmap, mmap_size);
+	munmap((void *)mmap, mmap_size);
 	return istate->cache_nr;
=20
 unmap:
-	munmap(mmap, mmap_size);
+	munmap((void *)mmap, mmap_size);
 	die("index file corrupt");
 }
=20
@@ -3263,7 +3262,7 @@ int should_validate_cache_entries(void)
 #define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + =
<4-byte length> + EOIE_SIZE */
=20
 #ifndef NO_PTHREADS
-static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size)
+static unsigned long read_eoie_extension(const char *mmap, size_t mmap_siz=
e)
 {
 	/*
 	 * The end of index entries (EOIE) extension is guaranteed to be last
@@ -3274,7 +3273,6 @@ static unsigned long read_eoie_extension(void *mmap_,=
 size_t mmap_size)
 	 * <4-byte offset>
 	 * <20-byte hash>
 	 */
-	const char *mmap =3D mmap_;
 	const char *index, *eoie;
 	uint32_t extsize;
 	unsigned long offset, src_offset;
@@ -3327,8 +3325,7 @@ static unsigned long read_eoie_extension(void *mmap_,=
 size_t mmap_size)
 		 * in 4-byte network byte order.
 		 */
 		uint32_t extsize;
-		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
-		extsize =3D ntohl(extsize);
+		extsize =3D get_be32(mmap + src_offset + 4);
=20
 		/* verify the extension size isn't so large it will wrap around */
 		if (src_offset + 8 + extsize < src_offset)
--=20
2.18.0.windows.1

