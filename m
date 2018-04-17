Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D9A1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755194AbeDQQe4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:34:56 -0400
Received: from mail-dm3nam03on0122.outbound.protection.outlook.com ([104.47.41.122]:13033
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754127AbeDQQev (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WjNqR3xgPpXNoNPL2/95sVbzToxPP0SSQCigQUlch34=;
 b=LqWwPWgmfk+XtbqeVZtgaKidFLHdtWTPB2HYXbRRYyJrl1WVCCOXmkW9KmeT8mYjzw2sZmijT278jMJAeZGxNYiuv0XLUu2KJf6N6SrhdBgHXxahycNWXaKcbQWUC+iXlG1LZqulC6VAFSfNe+7bSDgHaP5yvVtY1Z0KV8XYGRE=
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
Subject: [PATCH v1 3/5] mem-pool: fill out functionality
Thread-Topic: [PATCH v1 3/5] mem-pool: fill out functionality
Thread-Index: AQHT1mn8Z3VlEmIbzEK4nsLxdPRtdw==
Date:   Tue, 17 Apr 2018 16:34:42 +0000
Message-ID: <20180417163400.3875-5-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0899;7:jyd8hoqBvfxL5x6OJwyIb1SnAFhJNAHSuqOG0CtMXxBfq28mCWq+D1g53EWe2yLv1auo8TENo1kCcP5icZYAk6s0saIs6gv3ggdIXF8J8nCj1ihz0LGlgCcphr++6Q60aDnNKiisIglJO+EQ1gnpEdX2ptWfoMHlHq53f/yo0cvR39Ay1IYfRqy6XrGR4clgdWy54L94QJ8s+GkGDqkGP5jRjIh4zsEiacB+ailsaeSSzADXqQyG9JX6XnAG1kjC;20:GX5a1m2WL6Ohh7OIh55i7KCcbG/3ZsnLS94C76mmedLXMpx1S63YO217xYNZ1rI/kEwtA8s36l+TKyKw2bQxy877Fd8Ad5YrQpVBvYmkIoIS0qcT7Z+MwK2oCGDVmT6LY4O1WQh6nxm/6kbPcKhEIjq2CknB+zCTK+zwYXLYwoA=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0899;
x-ms-traffictypediagnostic: BL0PR2101MB0899:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB089935534CD72333E9A46BF5CEB70@BL0PR2101MB0899.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0899;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0899;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(7736002)(6116002)(5640700003)(2351001)(14454004)(6512007)(97736004)(8656006)(6486002)(53936002)(2906002)(4326008)(5660300001)(106356001)(39060400002)(6436002)(36756003)(107886003)(6666003)(6916009)(305945005)(1076002)(3280700002)(99286004)(22452003)(478600001)(316002)(476003)(446003)(2616005)(486006)(54906003)(6506007)(5250100002)(386003)(11346002)(10290500003)(2900100001)(3660700001)(81166006)(81156014)(1730700003)(86362001)(8676002)(8936002)(10090500001)(186003)(68736007)(25786009)(46003)(86612001)(52116002)(76176011)(102836004)(105586002)(2501003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0899;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R0gMv4mRzDSqNVngpkVhXff2GrvcBrdLfTFr/xUevOF1hfvgxXYWPhZVMJP0REGMtE8LqzGiledZP0Ni67Fi6Txhg3Yl1333DDV4UqW1s9mU0Klt8Dd/9fpxGva4mACbH+YfVOhFDmB32yRW/3cPHMnHJv14JctJ0tYLeNCo+YxKkX4VENFLuLDgwpJm4BPc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 02b107ea-0771-40a8-4acd-08d5a4811ece
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b107ea-0771-40a8-4acd-08d5a4811ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 16:34:42.2379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0899
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds the following functionality to memory pools:

 - Lifecycle management functions (init, discard)

 - Test whether a memory location is part of the managed pool

 - Function to combine 2 pools

This also adds logic to track all memory allocations made by a memory
pool.

These functions will be used in a future commit in this commit series.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 mem-pool.h |  32 +++++++++++++++++++
 2 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 389d7af447..09fb78d093 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,6 +5,8 @@
 #include "cache.h"
 #include "mem-pool.h"
=20
+#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
+
 static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc)
 {
 	struct mp_block *p;
@@ -19,6 +21,59 @@ static struct mp_block *mem_pool_alloc_block(struct mem_=
pool *mem_pool, size_t b
 	return p;
 }
=20
+static void *mem_pool_alloc_custom(struct mem_pool *mem_pool, size_t block=
_alloc)
+{
+	char *p;
+	ALLOC_GROW(mem_pool->custom, mem_pool->nr + 1, mem_pool->alloc);
+	ALLOC_GROW(mem_pool->custom_end, mem_pool->nr_end + 1, mem_pool->alloc_en=
d);
+
+	p =3D xmalloc(block_alloc);
+	mem_pool->custom[mem_pool->nr++] =3D p;
+	mem_pool->custom_end[mem_pool->nr_end++] =3D p + block_alloc;
+
+	mem_pool->pool_alloc +=3D block_alloc;
+
+	return mem_pool->custom[mem_pool->nr - 1];
+}
+
+void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
+{
+	if (!(*mem_pool))
+	{
+		*mem_pool =3D xmalloc(sizeof(struct mem_pool));
+		(*mem_pool)->pool_alloc =3D 0;
+		(*mem_pool)->mp_block =3D NULL;
+		(*mem_pool)->block_alloc =3D BLOCK_GROWTH_SIZE;
+		(*mem_pool)->custom =3D NULL;
+		(*mem_pool)->nr =3D 0;
+		(*mem_pool)->alloc =3D 0;
+		(*mem_pool)->custom_end =3D NULL;
+		(*mem_pool)->nr_end =3D 0;
+		(*mem_pool)->alloc_end =3D 0;
+
+		if (initial_size > 0)
+			mem_pool_alloc_block(*mem_pool, initial_size);
+	}
+}
+
+void mem_pool_discard(struct mem_pool *mem_pool)
+{
+	int i;
+	struct mp_block *block, *block_to_free;
+	for (block =3D mem_pool->mp_block; block;) {
+		block_to_free =3D block;
+		block =3D block->next_block;
+		free(block_to_free);
+	}
+
+	for (i =3D 0; i < mem_pool->nr; i++)
+		free(mem_pool->custom[i]);
+
+	free(mem_pool->custom);
+	free(mem_pool->custom_end);
+	free(mem_pool);
+}
+
 void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct mp_block *p;
@@ -33,10 +88,8 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t l=
en)
 			break;
=20
 	if (!p) {
-		if (len >=3D (mem_pool->block_alloc / 2)) {
-			mem_pool->pool_alloc +=3D len;
-			return xmalloc(len);
-		}
+		if (len >=3D (mem_pool->block_alloc / 2))
+			return mem_pool_alloc_custom(mem_pool, len);
=20
 		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
 	}
@@ -53,3 +106,45 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t=
 count, size_t size)
 	memset(r, 0, len);
 	return r;
 }
+
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
+{
+	struct mp_block *p;
+	for (p =3D mem_pool->mp_block; p; p =3D p->next_block)
+		if ((mem >=3D ((void *)p->space)) &&
+		    (mem < ((void *)p->end)))
+			return 1;
+
+	return 0;
+}
+
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src)
+{
+	int i;
+	struct mp_block **tail =3D &dst->mp_block;
+
+	/* Find pointer of dst's last block (if any) */
+	while (*tail)
+		tail =3D &(*tail)->next_block;
+
+	/* Append the blocks from src to dst */
+	*tail =3D src->mp_block;
+
+	ALLOC_GROW(dst->custom, dst->nr + src->nr, dst->alloc);
+	ALLOC_GROW(dst->custom_end, dst->nr_end + src->nr_end, dst->alloc_end);
+
+	for (i =3D 0; i < src->nr; i++) {
+		dst->custom[dst->nr++] =3D src->custom[i];
+		dst->custom_end[dst->nr_end++] =3D src->custom_end[i];
+	}
+
+	dst->pool_alloc +=3D src->pool_alloc;
+	src->pool_alloc =3D 0;
+	src->mp_block =3D NULL;
+	src->custom =3D NULL;
+	src->nr =3D 0;
+	src->alloc =3D 0;
+	src->custom_end =3D NULL;
+	src->nr_end =3D 0;
+	src->alloc_end =3D 0;
+}
diff --git a/mem-pool.h b/mem-pool.h
index 829ad58ecf..34df4fa709 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -19,8 +19,27 @@ struct mem_pool {
=20
 	/* The total amount of memory allocated by the pool. */
 	size_t pool_alloc;
+
+	/*
+	 * Array of pointers to "custom size" memory allocations.
+	 * This is used for "large" memory allocations.
+	 * The *_end variables are used to track the range of memory
+	 * allocated.
+	 */
+	void **custom, **custom_end;
+	int nr, nr_end, alloc, alloc_end;
 };
=20
+/*
+ * Initialize mem_pool specified initial.
+ */
+void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size);
+
+/*
+ * Discard a memory pool and free all the memory it is responsible for.
+ */
+void mem_pool_discard(struct mem_pool *mem_pool);
+
 /*
  * Alloc memory from the mem_pool.
  */
@@ -31,4 +50,17 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len);
  */
 void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
=20
+/*
+ * Move the memory associated with the 'src' pool to the 'dst' pool. The '=
src'
+ * pool will be empty and not contain any memory. It still needs to be fre=
e'd
+ * with a call to `mem_pool_discard`.
+ */
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
+
+/*
+ * Check if a memory pointed at by 'mem' is part of the range of
+ * memory managed by the specified mem_pool.
+ */
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
+
 #endif
--=20
2.14.3

