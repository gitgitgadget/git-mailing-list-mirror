Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A131F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeHTUIh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:37 -0400
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:59456
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbeHTUIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJYQPNVmf0fXVhdcuBo3GkLNzOQqJmqpOaABpxYvK5Y=;
 b=ZargnfVrxECiC83Yj53jqVJzt9AqcIUaWDV19v25QOODjQlf/BL2eVwZB80tPR4pDlechRPao0Z/TzlXfiEFwXYobIOBGL59Kllsd7h4wIGrXGshJX6gHju+88cf1THwl/TPbqEpwVTpEdcATFtdCoNVsE1NpT8+1SZqor5VOLw=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Mon, 20 Aug 2018 16:52:04 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:52:04 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 7/9] treewide: use get_all_packs
Thread-Topic: [PATCH 7/9] treewide: use get_all_packs
Thread-Index: AQHUOKYfH2bqfIouhEi7E6v29Q/NuQ==
Date:   Mon, 20 Aug 2018 16:52:04 +0000
Message-ID: <20180820165124.152146-8-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;6:sih0Ph+Fp6jgTly6RdnAwE37VOyiAiurOqCumLiryy7ODWD6wofU9C9UWWlbQKJ9biwetCEHQrmpzCQ1XPYKA0/EYk1I2yTYSujUYjJTxSxtem3w7Xv5378ZRnrhZz6qGiM0JhahxqJU5sy8V31ejmV3niSNSu8YMkYBEWkU1JZ9l4K5OXcc8BvHTV9JesUyYsAwBqBjimpgbDM0LDoKBpmUgp6fII1AImyvS+AhEF0LrAbGhCsd9FjXa4Lb3JwiHDUVaCMslLeqKxIjJfClD0ckVRx5Zmq5AdRFhcHe0rGvSNBFnkOszeq4p3u/ReV+nOLvkvkvnnjz1B7OmWLY59WGxPvJMrXqNnp7WXZR2IsKbvlvnAhHzJ6eX6tSelZ0h4YZ0unse9PfRtz23p1P+DgwBA/cwWAmCjKuDYFQ6Z1BS5IZYkSevEAbGxSahnQ/hXX5AsnaXZLjSau6coFBHg==;5:DK8L5kxxJ+AXXtO9SVfOyB++WeZmuAUlHgA2SbX92YT9OhFfX+Io0mW7K8k+dDtKcaAnHQjyp2FwHTRmK38vxHN3bfU/fr/tfdRyYVgdeXIfwLG9/SYJnmEc2wphlfnLT/OGxOSk0PnMsou+6zcj5B5QUzx5RWvg0Q/D2peJxlI=;7:ksfbJ9JYiBwKo5iXqjEbkmjsAs2kU77WLktvPV9wNBoNhzOOWxl8UT1Hm84eP2Wo2YZ+CHWbmLMTZtZotVGAHHDBzfKZxTcOH0OL4wnxjGp2BdzYY+0MiE7e/9Xb495fWQWjJx+G7tfo3aPv0Hu3sNB1fTbZfC4zSZyyUPDiYU6eFnuSmu8QquN7iCW3vzKfDsDttWGPo1P6/Q76TgaDReCXfS4MM1RAzZZglBfSQoXWDAcRfKbHPYdLXeRHVxRF
x-ms-office365-filtering-correlation-id: c920fde3-1b07-41fb-026b-08d606bd41a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
x-microsoft-antispam-prvs: <BL0PR2101MB09621C97D06E187AA519DC31A1320@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(8676002)(476003)(5640700003)(68736007)(2616005)(2906002)(81166006)(14454004)(81156014)(1730700003)(446003)(7736002)(2351001)(305945005)(22452003)(5660300001)(36756003)(6436002)(1076002)(6916009)(6486002)(46003)(316002)(25786009)(6116002)(53936002)(486006)(14444005)(575784001)(86362001)(76176011)(8936002)(6512007)(97736004)(256004)(86612001)(107886003)(478600001)(52116002)(10290500003)(6346003)(186003)(10090500001)(11346002)(2900100001)(386003)(102836004)(5250100002)(4326008)(99286004)(2501003)(106356001)(105586002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: jaF1jtosjgLe0txjFpsgTul3e+RK1lap/ToVQwOQQ9kO3PSE3Yrn4LYHWJ7QbRpDie9n5IwDXRoiiD5yKTJoKMC78IDnhHbOnZRyGi6ua+3+2s3a/u97KzDvSGbwb03P7aurDQ6XDTkO4oVXDXIWdX3VF46pcNlnfOUyi0L0+Hwm108hyJjnPdcMFHcJHB5GU008iTOVe5tsf8vO9MgM7aI9Sa0dZNpub5WdUuEJ+ms3SQIdFzi40kQBWka9E0d2csjpYFjfAF2AZKdXN0MrC1dmw8fecfv3ron2tsvtzxvd6OXEKU/oa4m0GZeq8n5CmieWeF2wfA+ZEN2+aof4HYivYe/oX8NYe71V9qPzR7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c920fde3-1b07-41fb-026b-08d606bd41a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:52:04.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many places in the codebase that want to iterate over
all packfiles known to Git. The purposes are wide-ranging, and
those that can take advantage of the multi-pack-index already
do. So, use get_all_packs() instead of get_packed_git() to be
sure we are iterating over all packfiles.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/count-objects.c  |  2 +-
 builtin/fsck.c           |  4 ++--
 builtin/gc.c             |  4 ++--
 builtin/pack-objects.c   | 14 +++++++-------
 builtin/pack-redundant.c |  4 ++--
 fast-import.c            |  4 ++--
 http-backend.c           |  4 ++--
 pack-bitmap.c            |  2 +-
 pack-objects.c           |  2 +-
 packfile.c               |  2 +-
 server-info.c            |  4 ++--
 11 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index d51e2ce1ec..a7cad052c6 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -123,7 +123,7 @@ int cmd_count_objects(int argc, const char **argv, cons=
t char *prefix)
 		struct strbuf pack_buf =3D STRBUF_INIT;
 		struct strbuf garbage_buf =3D STRBUF_INIT;
=20
-		for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+		for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
diff --git a/builtin/fsck.c b/builtin/fsck.c
index c96f3f4fcc..184d8e7f4e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -740,7 +740,7 @@ int cmd_fsck(int argc, const char **argv, const char *p=
refix)
 			struct progress *progress =3D NULL;
=20
 			if (show_progress) {
-				for (p =3D get_packed_git(the_repository); p;
+				for (p =3D get_all_packs(the_repository); p;
 				     p =3D p->next) {
 					if (open_pack_index(p))
 						continue;
@@ -749,7 +749,7 @@ int cmd_fsck(int argc, const char **argv, const char *p=
refix)
=20
 				progress =3D start_progress(_("Checking objects"), total);
 			}
-			for (p =3D get_packed_git(the_repository); p;
+			for (p =3D get_all_packs(the_repository); p;
 			     p =3D p->next) {
 				/* verify gives error messages itself */
 				if (verify_pack(p, fsck_obj_buffer,
diff --git a/builtin/gc.c b/builtin/gc.c
index 57069442b0..2b592260e9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -183,7 +183,7 @@ static struct packed_git *find_base_packs(struct string=
_list *packs,
 {
 	struct packed_git *p, *base =3D NULL;
=20
-	for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		if (!p->pack_local)
 			continue;
 		if (limit) {
@@ -208,7 +208,7 @@ static int too_many_packs(void)
 	if (gc_auto_pack_limit <=3D 0)
 		return 0;
=20
-	for (cnt =3D 0, p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (cnt =3D 0, p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4391504a91..1a896d7810 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2784,7 +2784,7 @@ static void add_objects_in_unpacked_packs(struct rev_=
info *revs)
=20
 	memset(&in_pack, 0, sizeof(in_pack));
=20
-	for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		struct object_id oid;
 		struct object *o;
=20
@@ -2848,7 +2848,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struc=
t object_id *oid)
 	struct packed_git *p;
=20
 	p =3D (last_found !=3D (void *)1) ? last_found :
-					get_packed_git(the_repository);
+					get_all_packs(the_repository);
=20
 	while (p) {
 		if ((!p->pack_local || p->pack_keep ||
@@ -2858,7 +2858,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struc=
t object_id *oid)
 			return 1;
 		}
 		if (p =3D=3D last_found)
-			p =3D get_packed_git(the_repository);
+			p =3D get_all_packs(the_repository);
 		else
 			p =3D p->next;
 		if (p =3D=3D last_found)
@@ -2894,7 +2894,7 @@ static void loosen_unused_packed_objects(struct rev_i=
nfo *revs)
 	uint32_t i;
 	struct object_id oid;
=20
-	for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
=20
@@ -3041,7 +3041,7 @@ static void add_extra_kept_packs(const struct string_=
list *names)
 	if (!names->nr)
 		return;
=20
-	for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		const char *name =3D basename(p->pack_name);
 		int i;
=20
@@ -3314,7 +3314,7 @@ int cmd_pack_objects(int argc, const char **argv, con=
st char *prefix)
 	add_extra_kept_packs(&keep_pack_list);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
-		for (p =3D get_packed_git(the_repository); p; p =3D p->next)
+		for (p =3D get_all_packs(the_repository); p; p =3D p->next)
 			if (p->pack_local && p->pack_keep)
 				break;
 		if (!p) /* no keep-able packs found */
@@ -3327,7 +3327,7 @@ int cmd_pack_objects(int argc, const char **argv, con=
st char *prefix)
 		 * it also covers non-local objects
 		 */
 		struct packed_git *p;
-		for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+		for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 			if (!p->pack_local) {
 				have_non_local_packs =3D 1;
 				break;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 0494dceff7..cf9a9aabd4 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -577,7 +577,7 @@ static struct pack_list * add_pack(struct packed_git *p=
)
=20
 static struct pack_list * add_pack_file(const char *filename)
 {
-	struct packed_git *p =3D get_packed_git(the_repository);
+	struct packed_git *p =3D get_all_packs(the_repository);
=20
 	if (strlen(filename) < 40)
 		die("Bad pack filename: %s", filename);
@@ -592,7 +592,7 @@ static struct pack_list * add_pack_file(const char *fil=
ename)
=20
 static void load_all(void)
 {
-	struct packed_git *p =3D get_packed_git(the_repository);
+	struct packed_git *p =3D get_all_packs(the_repository);
=20
 	while (p) {
 		add_pack(p);
diff --git a/fast-import.c b/fast-import.c
index 89bb0c9db3..f8c3acd3b5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1068,7 +1068,7 @@ static int store_object(
 		duplicate_count_by_type[type]++;
 		return 1;
 	} else if (find_sha1_pack(oid.hash,
-				  get_packed_git(the_repository))) {
+				  get_all_packs(the_repository))) {
 		e->type =3D type;
 		e->pack_id =3D MAX_PACK_ID;
 		e->idx.offset =3D 1; /* just not zero! */
@@ -1266,7 +1266,7 @@ static void stream_blob(uintmax_t len, struct object_=
id *oidout, uintmax_t mark)
 		truncate_pack(&checkpoint);
=20
 	} else if (find_sha1_pack(oid.hash,
-				  get_packed_git(the_repository))) {
+				  get_all_packs(the_repository))) {
 		e->type =3D OBJ_BLOB;
 		e->pack_id =3D MAX_PACK_ID;
 		e->idx.offset =3D 1; /* just not zero! */
diff --git a/http-backend.c b/http-backend.c
index bd0442a805..5e879177ed 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -523,13 +523,13 @@ static void get_info_packs(struct strbuf *hdr, char *=
arg)
 	size_t cnt =3D 0;
=20
 	select_getanyfile(hdr);
-	for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		if (p->pack_local)
 			cnt++;
 	}
=20
 	strbuf_grow(&buf, cnt * 53 + 2);
-	for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		if (p->pack_local)
 			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
 	}
diff --git a/pack-bitmap.c b/pack-bitmap.c
index f0a1937a1c..4e50ab391f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -335,7 +335,7 @@ static int open_pack_bitmap(struct bitmap_index *bitmap=
_git)
=20
 	assert(!bitmap_git->map && !bitmap_git->loaded);
=20
-	for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		if (open_pack_bitmap_1(bitmap_git, p) =3D=3D 0)
 			ret =3D 0;
 	}
diff --git a/pack-objects.c b/pack-objects.c
index 92708522e7..832dcf7462 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -99,7 +99,7 @@ static void prepare_in_pack_by_idx(struct packing_data *p=
data)
 	 * (i.e. in_pack_idx also zero) should return NULL.
 	 */
 	mapping[cnt++] =3D NULL;
-	for (p =3D get_packed_git(the_repository); p; p =3D p->next, cnt++) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next, cnt++) {
 		if (cnt =3D=3D nr) {
 			free(mapping);
 			return;
diff --git a/packfile.c b/packfile.c
index adcf2e12a0..cbef7033c3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2036,7 +2036,7 @@ int for_each_packed_object(each_packed_object_fn cb, =
void *data,
 	int pack_errors =3D 0;
=20
 	prepare_packed_git(the_repository);
-	for (p =3D the_repository->objects->packed_git; p; p =3D p->next) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
diff --git a/server-info.c b/server-info.c
index 41050c2449..e2b2d6a27a 100644
--- a/server-info.c
+++ b/server-info.c
@@ -199,7 +199,7 @@ static void init_pack_info(const char *infofile, int fo=
rce)
 	objdir =3D get_object_directory();
 	objdirlen =3D strlen(objdir);
=20
-	for (p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
@@ -209,7 +209,7 @@ static void init_pack_info(const char *infofile, int fo=
rce)
 	}
 	num_pack =3D i;
 	info =3D xcalloc(num_pack, sizeof(struct pack_info *));
-	for (i =3D 0, p =3D get_packed_git(the_repository); p; p =3D p->next) {
+	for (i =3D 0, p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		if (!p->pack_local)
 			continue;
 		info[i] =3D xcalloc(1, sizeof(struct pack_info));
--=20
2.18.0.118.gd4f65b8d14

