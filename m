Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F8D1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 18:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeDKSiG (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 14:38:06 -0400
Received: from mail-by2nam03on0092.outbound.protection.outlook.com ([104.47.42.92]:7328
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753668AbeDKSh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 14:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=B6EoWCEz6Zj+b8I41EAAv+cCRxUCRMIdFto1CReNv68=;
 b=Dm16g+8MBpmhqzAozwAwnheSug+jsY2UxIN+eV3Gmzcs5qsyjcNT070MXS9zAOIYiVJM9n817GheGT+edkbAThCZgo5qxblT9mXKXxG+dDAi4jdPnsfZKsV4pJHObXEhS0ADEKrGg5eHOPhI6ZrLvT1GkP+iTp6M2zDjToW3zNY=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.696.0; Wed, 11 Apr 2018 18:37:54 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0696.006; Wed, 11 Apr 2018
 18:37:54 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 2/3] fast-import: introduce mem_pool type
Thread-Topic: [PATCH v4 2/3] fast-import: introduce mem_pool type
Thread-Index: AQHT0cQ0395snoIiWUaAugJmpQWRMQ==
Date:   Wed, 11 Apr 2018 18:37:54 +0000
Message-ID: <20180411183738.113809-3-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;7:wA+2FuNSt4cYd6OdDhE5yMuElC48ppQZy3Eg5U8aG0ajp7eGjFB3caBT3t0dWUdVru2obOLGqbzESqaCGK3WTbgCmj4cyp14TJlNwIrpeWHFpKKV3IQ5g1MAgM7FHH4uMIin0n1i88E2ZO+d8iNcbHL/Y0L9tr8aKL5GW+jF7CFA7/z3dvz54eG9pDnPtDG++o+A3YK3nOrcPlT1DUJwHyKFH8NPyFH76IYXVN0xc+5pp8RiHw7SI+PI0VAtOH5P;20:4UGovraERCdG/otD1NPMmDDfk4JESIQI6eya4/p9YOWcqPqqOENhs/FzFO2pG5BUG74FFhbjoTMNmugs7qC+ahKC50z7prHqJhlckaHnof6KUa3RI8sNaaBXT+moohmsV7prSblUR+GL4HmDQ84tegs0o0lfTjkMpN5gYQ69V28=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09955110261793B5D77AA57DCEBD0@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(346002)(396003)(376002)(199004)(189003)(5250100002)(5640700003)(2501003)(6436002)(107886003)(53936002)(6512007)(305945005)(7736002)(6916009)(25786009)(478600001)(10290500003)(5660300001)(4326008)(86612001)(86362001)(575784001)(3660700001)(2900100001)(1076002)(14454004)(3280700002)(2906002)(6486002)(97736004)(54906003)(106356001)(186003)(2351001)(36756003)(105586002)(22452003)(52116002)(8656006)(99286004)(316002)(68736007)(386003)(102836004)(6506007)(76176011)(486006)(2616005)(46003)(446003)(11346002)(476003)(6116002)(8936002)(1730700003)(10090500001)(8676002)(81156014)(81166006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Xw48GI1fZOAZiA03RhPRIEIFMrsRzbZUBXSBFDHdnFDAkPPseP7e4QRZZ0O+SziBMHjvsyUgdq/nRazja5z6SCZjXT+FA3UHmvE1+AnuqZ7LE+gjPNgsKiw9Vnz1oR3cO0nIC6+IN9ydrcWbhDgm0GJQpwbmS/B9MFRmj2G+4OKOzVEY+kNKc9stIVrQfUu/dgHzrM2hVe/bmJbeDDI/SjaVBxFVAhu9GpPxL923ZAv4OXGBWCBQMgrLxTAg7l1/qKXXaVaxFLCeXQqgR0hobDuJPOLbDhdsI97B+Nk/c6TeNlNsfmrvMAmb6xqrN/Y5c+vr8IihDm81ceRHwRpdVdpcyEd+eA+p5cI8ExBPBb2vJ2rUwnbo05IIQj27dLfFbMXQuD3goIjt0T4QMkz6DxqwochAJVwmJaE2ABx2GsQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 09750373-a3f7-425b-bbbf-08d59fdb5682
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09750373-a3f7-425b-bbbf-08d59fdb5682
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 18:37:54.5378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the mem_pool type which encapsulates all the information necessar=
y to
manage a pool of memory. This change moves the existing variables in
fast-import used to support the global memory pool to use this structure. I=
t
also renames variables that are no longer used by memory pools to reflect t=
heir
more scoped usage.

These changes allow for the multiple instances of a memory pool to
exist and be reused outside of fast-import. In a future commit the
mem_pool type will be moved to its own file.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c | 81 ++++++++++++++++++++++++++++++++++++++-----------------=
----
 1 file changed, 52 insertions(+), 29 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 38af0a294b..48d4797ab5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -218,6 +218,19 @@ struct mp_block {
 	uintmax_t space[FLEX_ARRAY]; /* more */
 };
=20
+struct mem_pool {
+	struct mp_block *mp_block;
+
+	/*
+	 * The amount of available memory to grow the pool by.
+	 * This size does not include the overhead for the mp_block.
+	 */
+	size_t block_alloc;
+
+	/* The total amount of memory allocated by the pool. */
+	size_t pool_alloc;
+};
+
 struct atom_str {
 	struct atom_str *next_atom;
 	unsigned short str_len;
@@ -306,9 +319,8 @@ static int global_argc;
 static const char **global_argv;
=20
 /* Memory pools */
-static size_t mem_pool_alloc =3D 2*1024*1024 - sizeof(struct mp_block);
-static size_t total_allocd;
-static struct mp_block *mp_block_head;
+static struct mem_pool fi_mem_pool =3D  {NULL, 2*1024*1024 -
+				       sizeof(struct mp_block), 0 };
=20
 /* Atom management */
 static unsigned int atom_table_sz =3D 4451;
@@ -343,6 +355,7 @@ static unsigned int tree_entry_alloc =3D 1000;
 static void *avail_tree_entry;
 static unsigned int avail_tree_table_sz =3D 100;
 static struct avail_tree_content **avail_tree_table;
+static size_t tree_entry_allocd;
 static struct strbuf old_tree =3D STRBUF_INIT;
 static struct strbuf new_tree =3D STRBUF_INIT;
=20
@@ -636,7 +649,21 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
=20
-static void *pool_alloc(size_t len)
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc)
+{
+	struct mp_block *p;
+
+	mem_pool->pool_alloc +=3D sizeof(struct mp_block) + block_alloc;
+	p =3D xmalloc(st_add(sizeof(struct mp_block), block_alloc));
+	p->next_block =3D mem_pool->mp_block;
+	p->next_free =3D (char *)p->space;
+	p->end =3D p->next_free + block_alloc;
+	mem_pool->mp_block =3D p;
+
+	return p;
+}
+
+static void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct mp_block *p;
 	void *r;
@@ -645,21 +672,17 @@ static void *pool_alloc(size_t len)
 	if (len & (sizeof(uintmax_t) - 1))
 		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
=20
-	for (p =3D mp_block_head; p; p =3D p->next_block)
-		if ((p->end - p->next_free >=3D len))
+	for (p =3D mem_pool->mp_block; p; p =3D p->next_block)
+		if (p->end - p->next_free >=3D len)
 			break;
=20
 	if (!p) {
-		if (len >=3D (mem_pool_alloc/2)) {
-			total_allocd +=3D len;
+		if (len >=3D (mem_pool->block_alloc / 2)) {
+			mem_pool->pool_alloc +=3D len;
 			return xmalloc(len);
 		}
-		total_allocd +=3D sizeof(struct mp_block) + mem_pool_alloc;
-		p =3D xmalloc(st_add(sizeof(struct mp_block), mem_pool_alloc));
-		p->next_block =3D mp_block_head;
-		p->next_free =3D (char *) p->space;
-		p->end =3D p->next_free + mem_pool_alloc;
-		mp_block_head =3D p;
+
+		p =3D mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
 	}
=20
 	r =3D p->next_free;
@@ -667,10 +690,10 @@ static void *pool_alloc(size_t len)
 	return r;
 }
=20
-static void *pool_calloc(size_t count, size_t size)
+static void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size=
_t size)
 {
-	size_t len =3D count * size;
-	void *r =3D pool_alloc(len);
+	size_t len =3D st_mult(count, size);
+	void *r =3D mem_pool_alloc(mem_pool, len);
 	memset(r, 0, len);
 	return r;
 }
@@ -678,7 +701,7 @@ static void *pool_calloc(size_t count, size_t size)
 static char *pool_strdup(const char *s)
 {
 	size_t len =3D strlen(s) + 1;
-	char *r =3D pool_alloc(len);
+	char *r =3D mem_pool_alloc(&fi_mem_pool, len);
 	memcpy(r, s, len);
 	return r;
 }
@@ -687,7 +710,7 @@ static void insert_mark(uintmax_t idnum, struct object_=
entry *oe)
 {
 	struct mark_set *s =3D marks;
 	while ((idnum >> s->shift) >=3D 1024) {
-		s =3D pool_calloc(1, sizeof(struct mark_set));
+		s =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
 		s->shift =3D marks->shift + 10;
 		s->data.sets[0] =3D marks;
 		marks =3D s;
@@ -696,7 +719,7 @@ static void insert_mark(uintmax_t idnum, struct object_=
entry *oe)
 		uintmax_t i =3D idnum >> s->shift;
 		idnum -=3D i << s->shift;
 		if (!s->data.sets[i]) {
-			s->data.sets[i] =3D pool_calloc(1, sizeof(struct mark_set));
+			s->data.sets[i] =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark=
_set));
 			s->data.sets[i]->shift =3D s->shift - 10;
 		}
 		s =3D s->data.sets[i];
@@ -734,7 +757,7 @@ static struct atom_str *to_atom(const char *s, unsigned=
 short len)
 		if (c->str_len =3D=3D len && !strncmp(s, c->str_dat, len))
 			return c;
=20
-	c =3D pool_alloc(sizeof(struct atom_str) + len + 1);
+	c =3D mem_pool_alloc(&fi_mem_pool, sizeof(struct atom_str) + len + 1);
 	c->str_len =3D len;
 	memcpy(c->str_dat, s, len);
 	c->str_dat[len] =3D 0;
@@ -765,7 +788,7 @@ static struct branch *new_branch(const char *name)
 	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
 		die("Branch name doesn't conform to GIT standards: %s", name);
=20
-	b =3D pool_calloc(1, sizeof(struct branch));
+	b =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
 	b->name =3D pool_strdup(name);
 	b->table_next_branch =3D branch_table[hc];
 	b->branch_tree.versions[0].mode =3D S_IFDIR;
@@ -801,7 +824,7 @@ static struct tree_content *new_tree_content(unsigned i=
nt cnt)
 			avail_tree_table[hc] =3D f->next_avail;
 	} else {
 		cnt =3D cnt & 7 ? ((cnt / 8) + 1) * 8 : cnt;
-		f =3D pool_alloc(sizeof(*t) + sizeof(t->entries[0]) * cnt);
+		f =3D mem_pool_alloc(&fi_mem_pool, sizeof(*t) + sizeof(t->entries[0]) * =
cnt);
 		f->entry_capacity =3D cnt;
 	}
=20
@@ -846,7 +869,7 @@ static struct tree_entry *new_tree_entry(void)
=20
 	if (!avail_tree_entry) {
 		unsigned int n =3D tree_entry_alloc;
-		total_allocd +=3D n * sizeof(struct tree_entry);
+		tree_entry_allocd +=3D n * sizeof(struct tree_entry);
 		ALLOC_ARRAY(e, n);
 		avail_tree_entry =3D e;
 		while (n-- > 1) {
@@ -2867,7 +2890,7 @@ static void parse_new_tag(const char *arg)
 	enum object_type type;
 	const char *v;
=20
-	t =3D pool_alloc(sizeof(struct tag));
+	t =3D mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
 	memset(t, 0, sizeof(struct tag));
 	t->name =3D pool_strdup(arg);
 	if (last_tag)
@@ -3466,12 +3489,12 @@ int cmd_main(int argc, const char **argv)
 	atom_table =3D xcalloc(atom_table_sz, sizeof(struct atom_str*));
 	branch_table =3D xcalloc(branch_table_sz, sizeof(struct branch*));
 	avail_tree_table =3D xcalloc(avail_tree_table_sz, sizeof(struct avail_tre=
e_content*));
-	marks =3D pool_calloc(1, sizeof(struct mark_set));
+	marks =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
=20
 	global_argc =3D argc;
 	global_argv =3D argv;
=20
-	rc_free =3D pool_alloc(cmd_save * sizeof(*rc_free));
+	rc_free =3D mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
 	for (i =3D 0; i < (cmd_save - 1); i++)
 		rc_free[i].next =3D &rc_free[i + 1];
 	rc_free[cmd_save - 1].next =3D NULL;
@@ -3545,8 +3568,8 @@ int cmd_main(int argc, const char **argv)
 		fprintf(stderr, "Total branches:  %10lu (%10lu loads     )\n", branch_co=
unt, branch_load_count);
 		fprintf(stderr, "      marks:     %10" PRIuMAX " (%10" PRIuMAX " unique =
   )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
 		fprintf(stderr, "      atoms:     %10u\n", atom_cnt);
-		fprintf(stderr, "Memory total:    %10" PRIuMAX " KiB\n", (total_allocd +=
 alloc_count*sizeof(struct object_entry))/1024);
-		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)(total_al=
locd/1024));
+		fprintf(stderr, "Memory total:    %10" PRIuMAX " KiB\n", (tree_entry_all=
ocd + fi_mem_pool.pool_alloc + alloc_count*sizeof(struct object_entry))/102=
4);
+		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)((tree_en=
try_allocd + fi_mem_pool.pool_alloc) /1024));
 		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*si=
zeof(struct object_entry))/1024);
 		fprintf(stderr, "-------------------------------------------------------=
--------------\n");
 		pack_report();
--=20
2.14.3

