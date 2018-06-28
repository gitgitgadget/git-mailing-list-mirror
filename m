Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58AD81F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966445AbeF1OAW (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:00:22 -0400
Received: from mail-eopbgr730117.outbound.protection.outlook.com ([40.107.73.117]:61158
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966427AbeF1OAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUIj+1UrLMhhV43k8MN/UBwY4gj8agm9FnDM05skLVE=;
 b=YkJTAzUTgzQ+/wBYsAZlX4X/P6LDFxTtub+Kh5r2tdZk/9VLq85S17mNMMsg4Wd92/p/8xycjjA5somvfBIwChyvBhkrsYP5FLTFwH9CFQVUY2G3aWZUWIfmf6ACkR7ibgVU1cRoEQFjv+wYIBnLsf+HGYWy89EICwxy1OLCWAY=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0172.namprd21.prod.outlook.com (10.173.173.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.4; Thu, 28 Jun 2018 14:00:12 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 14:00:12 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: [PATCH v5 5/8] mem-pool: add life cycle management functions
Thread-Topic: [PATCH v5 5/8] mem-pool: add life cycle management functions
Thread-Index: AQHUDuhUmtr2+muAc0KLJ9/QfA2Vgg==
Date:   Thu, 28 Jun 2018 14:00:12 +0000
Message-ID: <20180628135932.225288-6-jamill@microsoft.com>
References: <20180620201557.77155-1-jamill@microsoft.com>
 <20180628135932.225288-1-jamill@microsoft.com>
In-Reply-To: <20180628135932.225288-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:405:6f::12) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0172;7:JbLID5dl7tMOV8L7GeUjN2ytzeA64aAFZ67tnRLobga7jAiIi6u+JHlB2iTHXYFHHQU56dNy05dN+6RD1Mayd8YaTrpxA2jLCEAh1JacR8rSZ0sMDKWPdKfBOlRySi/ifoBLAw00wmM2PcqKfTWTXI9fjPEfN+MepIR7MPlQkEy50BRUTPrcxd58tdrymK2QFyNlIiSTcmb44PU6/7te0kQFpP9/JTD1BUycaCzNBdNk72AuYWH7wSNde5U3la2s
x-ms-office365-filtering-correlation-id: 0d5d1345-428a-49ff-e32d-08d5dcff7703
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0172;
x-ms-traffictypediagnostic: DM5PR21MB0172:
x-microsoft-antispam-prvs: <DM5PR21MB0172172652E26BC1CED30321CE4F0@DM5PR21MB0172.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231270)(2018427008)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0172;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0172;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(199004)(22452003)(86612001)(86362001)(1076002)(6116002)(6486002)(6436002)(6512007)(10090500001)(53936002)(4326008)(36756003)(5660300001)(39060400002)(2900100001)(97736004)(25786009)(6200100001)(6862004)(5250100002)(2906002)(8676002)(10290500003)(7736002)(305945005)(478600001)(14454004)(68736007)(52116002)(386003)(102836004)(6506007)(6346003)(76176011)(81156014)(81166006)(8936002)(46003)(11346002)(446003)(99286004)(316002)(1511001)(476003)(2616005)(105586002)(106356001)(14444005)(37006003)(486006)(54906003)(256004)(7049001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0172;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: 7wEHlQ1GpiG9qgUhGmgJjNXcX6T/vd3fXD1T/ARqA75A/qJiCP1UIqfAfOEeO8pEZm5EPQgKbnRnv5WIVeNOGamkwPAuwk2SiQDVphrgm+2xu152DR4VJsKUyixZdAEcqppPNxVYkU/R3iNr7zqA+44sNsF+bavfLtcmUnZwoTFHDwH3JG4OW1SCicdojPgX2ioo6r82JuG+UObt0ZrhWLHIK/4I+Bh6Dh7bJw3s2feRz62G10VTYz3Aw2EHEkJVOjnRSWzj0AGFXc4m1/AimJ/xbSlpfis9H0a46n/ASCJQjQm6K21wxrAeh+wHB+BxnqV7gumnOvFWeXRFZeMe3OQQJa41O2YvcMMl2i7rElk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5d1345-428a-49ff-e32d-08d5dcff7703
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 14:00:12.0823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0172
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add initialization and discard functions to mem_pool type. As the
memory allocated by mem_pool can now be freed, we also track the large
allocations.

If the there are existing mp_blocks in the mem_poo's linked list of
mp_blocksl, then the mp_block for a large allocation is inserted
behind the head block. This is because only the head mp_block is considered
when searching for availble space. This results in the following
desirable properties:

1) The mp_block allocated for the large request will not be included
not included in the search for available in future requests, the large
mp_block is sized for the specific request and does not contain any
spare space.

2) The head mp_block will not bumped from considation for future
memory requests just because a request for a large chunk of memory
came in.

These changes are in preparation for a future commit that will utilize
creating and discarding memory pool.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++--------
 mem-pool.h | 10 +++++++++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index c80124f1fe..1769400d2d 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,20 +5,65 @@
 #include "cache.h"
 #include "mem-pool.h"
=20
-static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc)
+#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
+
+/*
+ * Allocate a new mp_block and insert it after the block specified in
+ * `insert_after`. If `insert_after` is NULL, then insert block at the
+ * head of the linked list.
+ */
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc, struct mp_block *insert_after)
 {
 	struct mp_block *p;
=20
 	mem_pool->pool_alloc +=3D sizeof(struct mp_block) + block_alloc;
 	p =3D xmalloc(st_add(sizeof(struct mp_block), block_alloc));
-	p->next_block =3D mem_pool->mp_block;
+
 	p->next_free =3D (char *)p->space;
 	p->end =3D p->next_free + block_alloc;
-	mem_pool->mp_block =3D p;
+
+	if (insert_after) {
+		p->next_block =3D insert_after->next_block;
+		insert_after->next_block =3D p;
+	} else {
+		p->next_block =3D mem_pool->mp_block;
+		mem_pool->mp_block =3D p;
+	}
=20
 	return p;
 }
=20
+void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
+{
+	struct mem_pool *pool;
+
+	if (*mem_pool)
+		return;
+
+	pool =3D xcalloc(1, sizeof(*pool));
+
+	pool->block_alloc =3D BLOCK_GROWTH_SIZE;
+
+	if (initial_size > 0)
+		mem_pool_alloc_block(pool, initial_size, NULL);
+
+	*mem_pool =3D pool;
+}
+
+void mem_pool_discard(struct mem_pool *mem_pool)
+{
+	struct mp_block *block, *block_to_free;
+
+	while ((block =3D mem_pool->mp_block))
+	{
+		block_to_free =3D block;
+		block =3D block->next_block;
+		free(block_to_free);
+	}
+
+	free(mem_pool);
+}
+
 void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct mp_block *p =3D NULL;
@@ -33,12 +78,10 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t =
len)
 		p =3D mem_pool->mp_block;
=20
 	if (!p) {
-		if (len >=3D (mem_pool->block_alloc / 2)) {
-			mem_pool->pool_alloc +=3D len;
-			return xmalloc(len);
-		}
+		if (len >=3D (mem_pool->block_alloc / 2))
+			return mem_pool_alloc_block(mem_pool, len, mem_pool->mp_block);
=20
-		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
+		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc, NULL);
 	}
=20
 	r =3D p->next_free;
diff --git a/mem-pool.h b/mem-pool.h
index 829ad58ecf..f75b3365d5 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -21,6 +21,16 @@ struct mem_pool {
 	size_t pool_alloc;
 };
=20
+/*
+ * Initialize mem_pool with specified initial size.
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
--=20
2.17.1

