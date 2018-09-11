Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45271F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeILE21 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:28:27 -0400
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:1880
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbeILE20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r5f0vkZDuhDVIIbzSPDfQ2rTo6TRVnw6K/Xf8Su/K8=;
 b=PyY31D93MT2/gKbS/1I29ne9TosengJpFjIAky9aJ2qAlH9Vgdstzi/DXx8M0lSweI8LhwTLkJNnvw5EXQoCaIcIZVX6iy7OXCbwmdMTLPZgr6jQczgZFveFinnjRNIHGhOp5nzvA0XX58jdYjsfW2elAnSfx/JmsJd3XWRDS1Q=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Tue, 11 Sep 2018 23:26:41 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.006; Tue, 11 Sep 2018
 23:26:41 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v4 5/5] read-cache: clean up casting and byte decoding
Thread-Topic: [PATCH v4 5/5] read-cache: clean up casting and byte decoding
Thread-Index: AQHUSiblICdDTlYPXUiLOR1c/SPCVw==
Date:   Tue, 11 Sep 2018 23:26:41 +0000
Message-ID: <20180911232615.35904-6-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180911232615.35904-1-benpeart@microsoft.com>
In-Reply-To: <20180911232615.35904-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY4PR1601CA0021.namprd16.prod.outlook.com
 (2603:10b6:910:72::34) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:2jRC5oAny6NqhD7mCSekWiTTnmZQWc5z0Z19HaMIfgqO7X2issBGCD1wKNEDIUtz1+tL0eHyoxvLcxS3tZ8xI7dJLi72SEbjvo/oxead55h7DzR3EQ/7FqZg1W5gdhezZ8VK52qWnG55kj5a74/w55WmYKMTnOxbP0fSZCZ0HuL9JTQLRqu6ukfrrwEkY77qMvuVFakx27Ima4jEH7hswV4iwyxr0vg1lBk8S0V0eAAi6dEa62CWhKdCMQjuMXOjsorahypTIPms13ONIU6kjUga7EcuDKLcPZLgsMSv0Xe/XQs4NiRGysRjivf8So/7I1rqLOJI37yWAtptNjmLID0OH8gVK8sG+JkaYtYbIFlfjACX4UyEnIUaHWAx/qkpiY/e6I9qgwGYxggFS1D1j+Kw6KlOgVUIPdpJtVOJukZypNYK7NBki/UfPWeZr3JCGyAb07cXjT97+AcZ9q8R+A==;5:LDaO7IJ7fxonSQwhzNOSpQKpppX6uL2Z1HxXycgq7OybhAdvUKrCB1/+HtDq/GKpAq1DFt1fcMnR2RBazWo96wMucYRm1NBuTk8FNJMZGxBqBgxZkz8Sg3WuVGgy6IwzdZLViXCRxVn+7eW97HeHK/Evt0zI7TXu41AzKxSE//E=;7:tM0SkCePNyn7QKuxrhjid4JBfFuw4Wl7JYP1DsQslN+nYRtNeBGotCwc7Ee69qOocuKMFVG5SDaMAFVNP2c38Xu/e/iDiUy86Lu4hakb+Ot+/4vePGJ3MQgAYESVfVZAr3YOmW8CuGPgD1DFY8bFxSxuixR2+vFV2UI658BN28v+f0SZYWbpgyxRsySr65VTXF5sDLgSq9OZU6U0d1Fty2zjgZ4xFY5Lr7JNcFX3XYykhl6fJ9nUiy4NKwC0h8yG
x-ms-office365-filtering-correlation-id: 8326c598-3f50-4aa4-6f81-08d6183e0763
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB11137B8C9C4DC115B9665E7AF4040@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699050)(76991037);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(386003)(6116002)(97736004)(6506007)(86612001)(7736002)(5640700003)(81156014)(81166006)(26005)(2900100001)(102836004)(6436002)(1730700003)(6346003)(305945005)(11346002)(14444005)(446003)(2616005)(476003)(486006)(3846002)(256004)(36756003)(10090500001)(66066001)(186003)(53936002)(1076002)(106356001)(105586002)(2351001)(6512007)(316002)(4326008)(54906003)(2906002)(52116002)(25786009)(5660300001)(107886003)(68736007)(22452003)(76176011)(39060400002)(6916009)(50226002)(478600001)(2501003)(99286004)(72206003)(14454004)(5250100002)(8936002)(8676002)(10290500003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: GfkApA4PW8FiFvkiSG9SsrZCyPBP95iUD6z8v5sVbbMs+exgFpi4NxwVIMza2qFDMoDuz6Bw2hQ6B1Edy2OoWxZUXLYMyUR9OI81co9nxmsWLIaExSvdOkUJN4uPE1iCkd5AG8pVatsi5EKPUHNF/qaPtRzdrFDo138lEqxUaOAI2j6y+hgGasMMQcmpQfYvCIlq3iFs+JoejVL1ZoITL6mkot/KHfy88BWNoRHCFmUtrduCMhMMlbRXVM0UC2PD5Vd41cO7eU+hd6YQTuAJXOW3xjsvaWkN7smn6Nu+FRUx+J28ZIcW8SalZB0b4zgnKc5DdwZGG/ycGJKuEIv/Eh6Xc5nuwUibSr8/4o1UdYs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8326c598-3f50-4aa4-6f81-08d6183e0763
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 23:26:41.4718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
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
index d21ccb5e67..6220abc491 100644
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
@@ -1906,7 +1906,7 @@ static size_t estimate_cache_size(size_t ondisk_size,=
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
@@ -1916,14 +1916,14 @@ struct load_index_extensions
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
@@ -1934,13 +1934,12 @@ static void *load_index_extensions(void *_data)
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
@@ -1955,7 +1954,7 @@ static void *load_index_extensions(void *_data)
  * from the memory mapped file and add them to the given index.
  */
 static unsigned long load_cache_entry_block(struct index_state *istate,
-			struct mem_pool *ce_mem_pool, int offset, int nr, void *mmap,
+			struct mem_pool *ce_mem_pool, int offset, int nr, const char *mmap,
 			unsigned long start_offset, const struct cache_entry *previous_ce)
 {
 	int i;
@@ -1966,7 +1965,7 @@ static unsigned long load_cache_entry_block(struct in=
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
@@ -1977,7 +1976,7 @@ static unsigned long load_cache_entry_block(struct in=
dex_state *istate,
 }
=20
 static unsigned long load_all_cache_entries(struct index_state *istate,
-			void *mmap, size_t mmap_size, unsigned long src_offset)
+			const char *mmap, size_t mmap_size, unsigned long src_offset)
 {
 	unsigned long consumed;
=20
@@ -2008,7 +2007,7 @@ struct load_cache_entries_thread_data
 	struct index_state *istate;
 	struct mem_pool *ce_mem_pool;
 	int offset, nr;
-	void *mmap;
+	const char *mmap;
 	unsigned long start_offset;
 	struct cache_entry *previous_ce;
 	unsigned long consumed;	/* return # of bytes in index file processed */
@@ -2028,7 +2027,7 @@ static void *load_cache_entries_thread(void *_data)
 }
=20
 static unsigned long load_cache_entries_threaded(int nr_threads, struct in=
dex_state *istate,
-			void *mmap, size_t mmap_size, unsigned long src_offset)
+			const char *mmap, size_t mmap_size, unsigned long src_offset)
 {
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
 	struct load_cache_entries_thread_data *data;
@@ -2097,7 +2096,7 @@ static unsigned long load_cache_entries_threaded(int =
nr_threads, struct index_st
 				break;
 		}
=20
-		ondisk =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		ondisk =3D (struct ondisk_cache_entry *)(mmap + src_offset);
=20
 		/* On-disk flags are just 16 bits */
 		flags =3D get_be16(&ondisk->flags);
@@ -2145,8 +2144,8 @@ int do_read_index(struct index_state *istate, const c=
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
@@ -2178,7 +2177,7 @@ int do_read_index(struct index_state *istate, const c=
har *path, int must_exist)
 		die_errno("unable to map index file");
 	close(fd);
=20
-	hdr =3D mmap;
+	hdr =3D (const struct cache_header *)mmap;
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
=20
@@ -2238,11 +2237,11 @@ int do_read_index(struct index_state *istate, const=
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
@@ -3265,7 +3264,7 @@ int should_validate_cache_entries(void)
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
@@ -3276,7 +3275,6 @@ static unsigned long read_eoie_extension(void *mmap_,=
 size_t mmap_size)
 	 * <4-byte offset>
 	 * <20-byte hash>
 	 */
-	const char *mmap =3D mmap_;
 	const char *index, *eoie;
 	uint32_t extsize;
 	unsigned long offset, src_offset;
@@ -3329,8 +3327,7 @@ static unsigned long read_eoie_extension(void *mmap_,=
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

