Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882E81F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeHTUIj (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:39 -0400
Received: from mail-co1nam03on0132.outbound.protection.outlook.com ([104.47.40.132]:30047
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbeHTUIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVt6Z05JiNRcxPXB5ZJVXoFb73T6gl4q492eVH5qmg8=;
 b=XCMounHhog0k6EWz6WciTaVN3KKZN5OjsRCNAjU1m1JplwDIulGIF1j6JEH2PVFgDIg/L3MT4C988g8LQNCYtwFXHVqZURClarCNqOWr2U6SYk/L6W6PonhmPLpvQe6Zk1N9FqFY4rrul28v+rCyYaF7fHQeD3QwtN1nQ6BAY2A=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Mon, 20 Aug 2018 16:51:55 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:51:55 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/9] multi-pack-index: store local property
Thread-Topic: [PATCH 2/9] multi-pack-index: store local property
Thread-Index: AQHUOKYaE1OSXLTUo0qI7RfChs6Qvw==
Date:   Mon, 20 Aug 2018 16:51:55 +0000
Message-ID: <20180820165124.152146-3-dstolee@microsoft.com>
References: <20180820165124.152146-1-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:903:103::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;6:C/pgj+/BDvsU2SMpFZmYSi3zw3fUzW5xbPcQO9S1P9SEN1NTBfM3m4SCNzHuyI9wjcUu5i43BYQsFuv+4AOMeQDbRqezhWdCsuBrepIK7t5+26cQ3zCsPXgTzN/XmnxIP5YzdFHZxIUt7MW1nFPw7hVAiVqX6kvKH8zLUDprikoxIMsxLa5NdDWy04dVplYXtENtWLKx5uclrUfdeGFrjoTpotauDEJUbwPyVNmsyoDtPmuWeftLkf6tyKuOM3HtBqxSjsOcMqRGqH+e1uJMueFBD4WrLgNpufnb1XxnF2g+2m0blxLeCLuOhQHVqnzGPXt+GB8ZHxUihStMY6eUyIv3o6zzy718orQsjVyDsDXoA1OZGqxTPp5nxnYINGsjFpyVbssaihUQaQGYhEVfkoLgTDRO9Dyn8srzctwM6ehEMt6XI8ihXNc8KM/ilsg9PQz/YmqNQy92kg4/SMoZ2A==;5:xwMR0eJESYSp9i/Oo8xd8s8zxFX8P/wHDCiWUXuLWNNApzm4oPxVY4CiqWzSFag0ZY0EZyf5+WyFXd9U01xMWaaq/ea7NGmORfun6WfRNvWvqbQcQbqo96qpzdZm4STaKFTu0D5L6GqQKZjA3s5VwZFhe1OSo4kRGrTJyyu7LC0=;7:XKx2D3FVId1pfARseanWJL8oJ+Etf2IpoQCSwcCy0aM+FoLc67uvaSzNLo0LrIHN/ix9ZYpeF0THvOHvopzEyIQWCV9E9fSMmC2ZOB1CQUi6k/m8izOEWbqQiSWLxtpKmnz298q/35kHC6qBF2golmRs+TI74NwS4qJUodVaifvpHlv1Hpsu65+blnGFw4sOKIJwrbFwAHXufoYWwS4M6r4NW/V0S3lKAAUPY2Y7dfd/PFCLixnD3oCO23U7rAwq
x-ms-office365-filtering-correlation-id: 86c3bdbd-5b78-4f87-eace-08d606bd3c42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
x-microsoft-antispam-prvs: <BL0PR2101MB09629A047751E70D5BD0AE5BA1320@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(8676002)(476003)(5640700003)(68736007)(2616005)(2906002)(81166006)(14454004)(81156014)(1730700003)(446003)(7736002)(2351001)(305945005)(22452003)(5660300001)(36756003)(6436002)(1076002)(6916009)(6486002)(46003)(316002)(25786009)(6116002)(53936002)(486006)(86362001)(76176011)(8936002)(6512007)(97736004)(256004)(86612001)(107886003)(478600001)(52116002)(10290500003)(6346003)(186003)(10090500001)(11346002)(2900100001)(386003)(102836004)(5250100002)(4326008)(99286004)(2501003)(106356001)(105586002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 4i5z4iwcFlgqla8jNyA0mkc6BxZlDkGUByB/hdHyaNWvbJbsmiqMRLr4+BvrMpw1UjOo94IU7jqUBImDucqOiJ4zsPQmOAcDaoha4jP4lhHYBH78sEG/Ko9R8PihTtrnTqpymX7TKDNvz0zdYUf/mNL8OL1AXqTje/XIBW1SZHqOrC/79s4w3fAnLX/4LfnmgZbfVjM/PxnbXMGfePDKo7CLjOoQ856wteBW1FnukaVjAbsRUNWmB/mPAzKDhLs0C99vX/J5j8/l2J86l0CCwuuNjOL3V4lbwhV+fnAmpA9koleQLjH0iZs8ic++LNgwwz84o2a+vhDUmcmcKn9zHiEeVLyDiOIFzXSKeAdVBOs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c3bdbd-5b78-4f87-eace-08d606bd3c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:51:55.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A pack-file is 'local' if it is stored within the usual object
directory. If it is stored in an alternate, it is non-local.

Pack-files are stored using a 'pack_local' member in the packed_git
struct. Add a similar 'local' member to the multi_pack_index struct
and 'local' parameters to the methods that load and prepare multi-
pack-indexes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                    | 11 ++++++-----
 midx.h                    |  6 ++++--
 packfile.c                |  4 ++--
 t/helper/test-read-midx.c |  2 +-
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index 19b7df338e..6824acf5f8 100644
--- a/midx.c
+++ b/midx.c
@@ -37,7 +37,7 @@ static char *get_midx_filename(const char *object_dir)
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
=20
-struct multi_pack_index *load_multi_pack_index(const char *object_dir)
+struct multi_pack_index *load_multi_pack_index(const char *object_dir, int=
 local)
 {
 	struct multi_pack_index *m =3D NULL;
 	int fd;
@@ -73,6 +73,7 @@ struct multi_pack_index *load_multi_pack_index(const char=
 *object_dir)
 	m->fd =3D fd;
 	m->data =3D midx_map;
 	m->data_len =3D midx_size;
+	m->local =3D local;
=20
 	m->signature =3D get_be32(m->data);
 	if (m->signature !=3D MIDX_SIGNATURE) {
@@ -209,7 +210,7 @@ static int prepare_midx_pack(struct multi_pack_index *m=
, uint32_t pack_int_id)
 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
 		    m->pack_names[pack_int_id]);
=20
-	m->packs[pack_int_id] =3D add_packed_git(pack_name.buf, pack_name.len, 1)=
;
+	m->packs[pack_int_id] =3D add_packed_git(pack_name.buf, pack_name.len, m-=
>local);
 	strbuf_release(&pack_name);
 	return !m->packs[pack_int_id];
 }
@@ -318,7 +319,7 @@ int midx_contains_pack(struct multi_pack_index *m, cons=
t char *idx_name)
 	return 0;
 }
=20
-int prepare_multi_pack_index_one(struct repository *r, const char *object_=
dir)
+int prepare_multi_pack_index_one(struct repository *r, const char *object_=
dir, int local)
 {
 	struct multi_pack_index *m =3D r->objects->multi_pack_index;
 	struct multi_pack_index *m_search;
@@ -332,7 +333,7 @@ int prepare_multi_pack_index_one(struct repository *r, =
const char *object_dir)
 		if (!strcmp(object_dir, m_search->object_dir))
 			return 1;
=20
-	r->objects->multi_pack_index =3D load_multi_pack_index(object_dir);
+	r->objects->multi_pack_index =3D load_multi_pack_index(object_dir, local)=
;
=20
 	if (r->objects->multi_pack_index) {
 		r->objects->multi_pack_index->next =3D m;
@@ -746,7 +747,7 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
=20
-	packs.m =3D load_multi_pack_index(object_dir);
+	packs.m =3D load_multi_pack_index(object_dir, 1);
=20
 	packs.nr =3D 0;
 	packs.alloc_list =3D packs.m ? packs.m->num_packs : 16;
diff --git a/midx.h b/midx.h
index e3b07f1586..8aa79f4b62 100644
--- a/midx.h
+++ b/midx.h
@@ -18,6 +18,8 @@ struct multi_pack_index {
 	uint32_t num_packs;
 	uint32_t num_objects;
=20
+	int local;
+
 	const unsigned char *chunk_pack_names;
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
@@ -29,14 +31,14 @@ struct multi_pack_index {
 	char object_dir[FLEX_ARRAY];
 };
=20
-struct multi_pack_index *load_multi_pack_index(const char *object_dir);
+struct multi_pack_index *load_multi_pack_index(const char *object_dir, int=
 local);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, =
uint32_t *result);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
 int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, str=
uct multi_pack_index *m);
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_name);
-int prepare_multi_pack_index_one(struct repository *r, const char *object_=
dir);
+int prepare_multi_pack_index_one(struct repository *r, const char *object_=
dir, int local);
=20
 int write_midx_file(const char *object_dir);
 void clear_midx_file(const char *object_dir);
diff --git a/packfile.c b/packfile.c
index 12db1a9d7d..896da460ac 100644
--- a/packfile.c
+++ b/packfile.c
@@ -963,11 +963,11 @@ static void prepare_packed_git(struct repository *r)
=20
 	if (r->objects->packed_git_initialized)
 		return;
-	prepare_multi_pack_index_one(r, r->objects->objectdir);
+	prepare_multi_pack_index_one(r, r->objects->objectdir, 1);
 	prepare_packed_git_one(r, r->objects->objectdir, 1);
 	prepare_alt_odb(r);
 	for (alt =3D r->objects->alt_odb_list; alt; alt =3D alt->next) {
-		prepare_multi_pack_index_one(r, alt->path);
+		prepare_multi_pack_index_one(r, alt->path, 0);
 		prepare_packed_git_one(r, alt->path, 0);
 	}
 	rearrange_packed_git(r);
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 8e19972e89..831b586d02 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -7,7 +7,7 @@
 static int read_midx_file(const char *object_dir)
 {
 	uint32_t i;
-	struct multi_pack_index *m =3D load_multi_pack_index(object_dir);
+	struct multi_pack_index *m =3D load_multi_pack_index(object_dir, 1);
=20
 	if (!m)
 		return 1;
--=20
2.18.0.118.gd4f65b8d14

