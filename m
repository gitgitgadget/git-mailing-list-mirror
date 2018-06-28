Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D608F1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966429AbeF1OAQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:00:16 -0400
Received: from mail-eopbgr730117.outbound.protection.outlook.com ([40.107.73.117]:61158
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966350AbeF1OAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJx+FSwy2lvFRJ52JcUmcN5f8AHULczEYHEWFPTWnDk=;
 b=N0Z514kZ4mXGl5Qk73ljj1IQM5O8z7u+iPKIAS1NFT/YgXzVLOUhEJ+BSX0427RRZXyi5U54XYTmyTunqGjdNUwoARYTlTjhHiKflegK1lIbmrfQuVNUUYvAR55mXkqDb1/1EA5aH+gm78/8Xw9qdEKvFu7TiQt0ZeUc0jngpMA=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0172.namprd21.prod.outlook.com (10.173.173.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.4; Thu, 28 Jun 2018 14:00:09 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 14:00:09 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: [PATCH v5 3/8] block alloc: add lifecycle APIs for cache_entry
 structs
Thread-Topic: [PATCH v5 3/8] block alloc: add lifecycle APIs for cache_entry
 structs
Thread-Index: AQHUDuhTWrkBTZznkU+u0hyZ3dIEIA==
Date:   Thu, 28 Jun 2018 14:00:09 +0000
Message-ID: <20180628135932.225288-4-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0172;7:PfPyOWlFLej/IhnwxEpZIDCgPCkWQvtO7HK+NRUyQw2YNSBY0/iTNnW8Ibda3U6C2ufHYFJMVT82R+0akAZ/nNJ57KqZhueqF+bUo9Ml5Ud1Z1I98+8pZh+1URT6ckt19GTfzJ44E3vDWQzrpu159KFDcnF7DL6BjqYza2t1bClL8NBbzTQD6LZA5x+dOZAzXMGX93GM1gRsZ1CY9j26L4BPiLsge/oeu4xWyeD5O49XUM7R4oRyGL5/B00n7W0+
x-ms-office365-filtering-correlation-id: 227b5e1d-4f8b-4b69-27c8-08d5dcff755f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0172;
x-ms-traffictypediagnostic: DM5PR21MB0172:
x-microsoft-antispam-prvs: <DM5PR21MB01729D6566C1CD8D8FE176B7CE4F0@DM5PR21MB0172.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231270)(2018427008)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0172;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0172;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(199004)(22452003)(53946003)(86612001)(86362001)(1076002)(6116002)(575784001)(6486002)(6436002)(6512007)(10090500001)(53936002)(4326008)(36756003)(5660300001)(39060400002)(2900100001)(97736004)(25786009)(6200100001)(6862004)(5250100002)(2906002)(8676002)(10290500003)(7736002)(305945005)(478600001)(14454004)(68736007)(52116002)(386003)(102836004)(6506007)(6346003)(76176011)(81156014)(81166006)(8936002)(46003)(11346002)(446003)(99286004)(316002)(1511001)(476003)(2616005)(105586002)(106356001)(14444005)(37006003)(486006)(54906003)(256004)(7049001)(22906009)(559001)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0172;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: 230WK9SmqmpRkTCWgvb/lNroXgWIcTt6AOzPx2T6y+zjBTzlNTwtyeNXQASMm0JtLWbZYkhx3Qh7jbJzrFNq2MCk4Amc4SqNaCS5vpYN23KxAxjhjbplYVU3xrrh2ei6LBFvhck7H2UP7wWDXfPGYzLngYnqTJk28j0XOm1KM+NU1dszTP6I49TCKT8u9MIXJqxqmNHCYSzZrDluyGS9597UYO4nkVhXjkbJduSx48Bc80vE4AVaiQ0fyZQiytQ4ObbsIVbwvyIZGLrwXV7PpNmngZM8Y12C99Sq5IJLL9Q5GXQJEc5UjhAJJ2QcZ7PGc9TiwwYN4lPmzlxOeC+Kq92QFQUUmSiR4fUAn735bl0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227b5e1d-4f8b-4b69-27c8-08d5dcff755f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 14:00:09.3060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0172
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an API around managing the lifetime of cache_entry
structs. Abstracting memory management details behind this API will
allow for alternative memory management strategies without affecting
all the call sites.  This commit does not change how memory is
allocated or freed. A later commit in this series will allocate cache
entries from memory pools as appropriate.

Motivation:
It has been observed that the time spent loading an index with a large
number of entries is partly dominated by malloc() calls. This change
is in preparation for using memory pools to reduce the number of
malloc() calls made when loading an index.

This API makes a distinction between cache entries that are intended
for use with a particular index and cache entries that are not. This
enables us to use the knowledge about how a cache entry will be used
to make informed decisions about how to handle the corresponding
memory.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 apply.c                | 24 +++++------
 blame.c                |  5 +--
 builtin/checkout.c     |  8 ++--
 builtin/difftool.c     |  6 +--
 builtin/reset.c        |  2 +-
 builtin/update-index.c | 26 +++++-------
 cache.h                | 40 +++++++++++++++---
 merge-recursive.c      |  2 +-
 read-cache.c           | 93 +++++++++++++++++++++++++++++-------------
 resolve-undo.c         |  4 +-
 split-index.c          |  8 ++--
 tree.c                 |  4 +-
 unpack-trees.c         | 35 +++++++++++-----
 13 files changed, 165 insertions(+), 92 deletions(-)

diff --git a/apply.c b/apply.c
index 8ef975a32d..8a4a4439bc 100644
--- a/apply.c
+++ b/apply.c
@@ -4092,12 +4092,12 @@ static int build_fake_ancestor(struct apply_state *=
state, struct patch *list)
 			return error(_("sha1 information is lacking or useless "
 				       "(%s)."), name);
=20
-		ce =3D make_cache_entry(patch->old_mode, &oid, name, 0, 0);
+		ce =3D make_cache_entry(&result, patch->old_mode, &oid, name, 0, 0);
 		if (!ce)
 			return error(_("make_cache_entry failed for path '%s'"),
 				     name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD)) {
-			free(ce);
+			discard_cache_entry(ce);
 			return error(_("could not add %s to temporary index"),
 				     name);
 		}
@@ -4265,9 +4265,8 @@ static int add_index_file(struct apply_state *state,
 	struct stat st;
 	struct cache_entry *ce;
 	int namelen =3D strlen(path);
-	unsigned ce_size =3D cache_entry_size(namelen);
=20
-	ce =3D xcalloc(1, ce_size);
+	ce =3D make_empty_cache_entry(&the_index, namelen);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode =3D create_ce_mode(mode);
 	ce->ce_flags =3D create_ce_flags(0);
@@ -4280,13 +4279,13 @@ static int add_index_file(struct apply_state *state=
,
=20
 		if (!skip_prefix(buf, "Subproject commit ", &s) ||
 		    get_oid_hex(s, &ce->oid)) {
-			free(ce);
-		       return error(_("corrupt patch for submodule %s"), path);
+			discard_cache_entry(ce);
+			return error(_("corrupt patch for submodule %s"), path);
 		}
 	} else {
 		if (!state->cached) {
 			if (lstat(path, &st) < 0) {
-				free(ce);
+				discard_cache_entry(ce);
 				return error_errno(_("unable to stat newly "
 						     "created file '%s'"),
 						   path);
@@ -4294,13 +4293,13 @@ static int add_index_file(struct apply_state *state=
,
 			fill_stat_cache_info(ce, &st);
 		}
 		if (write_object_file(buf, size, blob_type, &ce->oid) < 0) {
-			free(ce);
+			discard_cache_entry(ce);
 			return error(_("unable to create backing store "
 				       "for newly created file %s"), path);
 		}
 	}
 	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
-		free(ce);
+		discard_cache_entry(ce);
 		return error(_("unable to add cache entry for %s"), path);
 	}
=20
@@ -4424,27 +4423,26 @@ static int add_conflicted_stages_file(struct apply_=
state *state,
 				       struct patch *patch)
 {
 	int stage, namelen;
-	unsigned ce_size, mode;
+	unsigned mode;
 	struct cache_entry *ce;
=20
 	if (!state->update_index)
 		return 0;
 	namelen =3D strlen(patch->new_name);
-	ce_size =3D cache_entry_size(namelen);
 	mode =3D patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
=20
 	remove_file_from_cache(patch->new_name);
 	for (stage =3D 1; stage < 4; stage++) {
 		if (is_null_oid(&patch->threeway_stage[stage - 1]))
 			continue;
-		ce =3D xcalloc(1, ce_size);
+		ce =3D make_empty_cache_entry(&the_index, namelen);
 		memcpy(ce->name, patch->new_name, namelen);
 		ce->ce_mode =3D create_ce_mode(mode);
 		ce->ce_flags =3D create_ce_flags(stage);
 		ce->ce_namelen =3D namelen;
 		oidcpy(&ce->oid, &patch->threeway_stage[stage - 1]);
 		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
-			free(ce);
+			discard_cache_entry(ce);
 			return error(_("unable to add cache entry for %s"),
 				     patch->new_name);
 		}
diff --git a/blame.c b/blame.c
index a5c9bd78ab..87dade745c 100644
--- a/blame.c
+++ b/blame.c
@@ -173,7 +173,7 @@ static struct commit *fake_working_tree_commit(struct d=
iff_options *opt,
 	struct strbuf buf =3D STRBUF_INIT;
 	const char *ident;
 	time_t now;
-	int size, len;
+	int len;
 	struct cache_entry *ce;
 	unsigned mode;
 	struct strbuf msg =3D STRBUF_INIT;
@@ -271,8 +271,7 @@ static struct commit *fake_working_tree_commit(struct d=
iff_options *opt,
 			/* Let's not bother reading from HEAD tree */
 			mode =3D S_IFREG | 0644;
 	}
-	size =3D cache_entry_size(len);
-	ce =3D xcalloc(1, size);
+	ce =3D make_empty_cache_entry(&the_index, len);
 	oidcpy(&ce->oid, &origin->blob_oid);
 	memcpy(ce->name, path, len);
 	ce->ce_flags =3D create_ce_flags(0);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 548bf40f25..56d1e1a28d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -77,7 +77,7 @@ static int update_some(const struct object_id *oid, struc=
t strbuf *base,
 		return READ_TREE_RECURSIVE;
=20
 	len =3D base->len + strlen(pathname);
-	ce =3D xcalloc(1, cache_entry_size(len));
+	ce =3D make_empty_cache_entry(&the_index, len);
 	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, base->buf, base->len);
 	memcpy(ce->name + base->len, pathname, len - base->len);
@@ -96,7 +96,7 @@ static int update_some(const struct object_id *oid, struc=
t strbuf *base,
 		if (ce->ce_mode =3D=3D old->ce_mode &&
 		    !oidcmp(&ce->oid, &old->oid)) {
 			old->ce_flags |=3D CE_UPDATE;
-			free(ce);
+			discard_cache_entry(ce);
 			return 0;
 		}
 	}
@@ -230,11 +230,11 @@ static int checkout_merged(int pos, const struct chec=
kout *state)
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce =3D make_cache_entry(mode, &oid, path, 2, 0);
+	ce =3D make_transient_cache_entry(mode, &oid, path, 2);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status =3D checkout_entry(ce, state, NULL);
-	free(ce);
+	discard_cache_entry(ce);
 	return status;
 }
=20
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 873a06f0d9..4593f0c2cd 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -321,10 +321,10 @@ static int checkout_path(unsigned mode, struct object=
_id *oid,
 	struct cache_entry *ce;
 	int ret;
=20
-	ce =3D make_cache_entry(mode, oid, path, 0, 0);
+	ce =3D make_transient_cache_entry(mode, oid, path, 0);
 	ret =3D checkout_entry(ce, state, NULL);
=20
-	free(ce);
+	discard_cache_entry(ce);
 	return ret;
 }
=20
@@ -488,7 +488,7 @@ static int run_dir_diff(const char *extcmd, int symlink=
s, const char *prefix,
 				 * index.
 				 */
 				struct cache_entry *ce2 =3D
-					make_cache_entry(rmode, &roid,
+					make_cache_entry(&wtindex, rmode, &roid,
 							 dst_path, 0, 0);
=20
 				add_index_entry(&wtindex, ce2,
diff --git a/builtin/reset.c b/builtin/reset.c
index 00109b041f..c3f0cfa1e8 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -134,7 +134,7 @@ static void update_index_from_diff(struct diff_queue_st=
ruct *q,
 			continue;
 		}
=20
-		ce =3D make_cache_entry(one->mode, &one->oid, one->path,
+		ce =3D make_cache_entry(&the_index, one->mode, &one->oid, one->path,
 				      0, 0);
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
diff --git a/builtin/update-index.c b/builtin/update-index.c
index a8709a26ec..ea2f2a476c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -268,15 +268,14 @@ static int process_lstat_error(const char *path, int =
err)
=20
 static int add_one_path(const struct cache_entry *old, const char *path, i=
nt len, struct stat *st)
 {
-	int option, size;
+	int option;
 	struct cache_entry *ce;
=20
 	/* Was the old index entry already up-to-date? */
 	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
 		return 0;
=20
-	size =3D cache_entry_size(len);
-	ce =3D xcalloc(1, size);
+	ce =3D make_empty_cache_entry(&the_index, len);
 	memcpy(ce->name, path, len);
 	ce->ce_flags =3D create_ce_flags(0);
 	ce->ce_namelen =3D len;
@@ -285,13 +284,13 @@ static int add_one_path(const struct cache_entry *old=
, const char *path, int len
=20
 	if (index_path(&ce->oid, path, st,
 		       info_only ? 0 : HASH_WRITE_OBJECT)) {
-		free(ce);
+		discard_cache_entry(ce);
 		return -1;
 	}
 	option =3D allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |=3D allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option)) {
-		free(ce);
+		discard_cache_entry(ce);
 		return error("%s: cannot add to the index - missing --add option?", path=
);
 	}
 	return 0;
@@ -402,15 +401,14 @@ static int process_path(const char *path, struct stat=
 *st, int stat_errno)
 static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 			 const char *path, int stage)
 {
-	int size, len, option;
+	int len, option;
 	struct cache_entry *ce;
=20
 	if (!verify_path(path, mode))
 		return error("Invalid path '%s'", path);
=20
 	len =3D strlen(path);
-	size =3D cache_entry_size(len);
-	ce =3D xcalloc(1, size);
+	ce =3D make_empty_cache_entry(&the_index, len);
=20
 	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, path, len);
@@ -599,7 +597,6 @@ static struct cache_entry *read_one_ent(const char *whi=
ch,
 {
 	unsigned mode;
 	struct object_id oid;
-	int size;
 	struct cache_entry *ce;
=20
 	if (get_tree_entry(ent, path, &oid, &mode)) {
@@ -612,8 +609,7 @@ static struct cache_entry *read_one_ent(const char *whi=
ch,
 			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
 	}
-	size =3D cache_entry_size(namelen);
-	ce =3D xcalloc(1, size);
+	ce =3D make_empty_cache_entry(&the_index, namelen);
=20
 	oidcpy(&ce->oid, &oid);
 	memcpy(ce->name, path, namelen);
@@ -690,8 +686,8 @@ static int unresolve_one(const char *path)
 	error("%s: cannot add their version to the index.", path);
 	ret =3D -1;
  free_return:
-	free(ce_2);
-	free(ce_3);
+	discard_cache_entry(ce_2);
+	discard_cache_entry(ce_3);
 	return ret;
 }
=20
@@ -758,7 +754,7 @@ static int do_reupdate(int ac, const char **av,
 					   ce->name, ce_namelen(ce), 0);
 		if (old && ce->ce_mode =3D=3D old->ce_mode &&
 		    !oidcmp(&ce->oid, &old->oid)) {
-			free(old);
+			discard_cache_entry(old);
 			continue; /* unchanged */
 		}
 		/* Be careful.  The working tree may not have the
@@ -769,7 +765,7 @@ static int do_reupdate(int ac, const char **av,
 		path =3D xstrdup(ce->name);
 		update_one(path);
 		free(path);
-		free(old);
+		discard_cache_entry(old);
 		if (save_nr !=3D active_nr)
 			goto redo;
 	}
diff --git a/cache.h b/cache.h
index 3fbf24771a..035a627bea 100644
--- a/cache.h
+++ b/cache.h
@@ -339,6 +339,40 @@ extern void remove_name_hash(struct index_state *istat=
e, struct cache_entry *ce)
 extern void free_name_hash(struct index_state *istate);
=20
=20
+/* Cache entry creation and cleanup */
+
+/*
+ * Create cache_entry intended for use in the specified index. Caller
+ * is responsible for discarding the cache_entry with
+ * `discard_cache_entry`.
+ */
+struct cache_entry *make_cache_entry(struct index_state *istate,
+				     unsigned int mode,
+				     const struct object_id *oid,
+				     const char *path,
+				     int stage,
+				     unsigned int refresh_options);
+
+struct cache_entry *make_empty_cache_entry(struct index_state *istate,
+					   size_t name_len);
+
+/*
+ * Create a cache_entry that is not intended to be added to an index.
+ * Caller is responsible for discarding the cache_entry
+ * with `discard_cache_entry`.
+ */
+struct cache_entry *make_transient_cache_entry(unsigned int mode,
+					       const struct object_id *oid,
+					       const char *path,
+					       int stage);
+
+struct cache_entry *make_empty_transient_cache_entry(size_t name_len);
+
+/*
+ * Discard cache entry.
+ */
+void discard_cache_entry(struct cache_entry *ce);
+
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
 #define active_cache (the_index.cache)
 #define active_nr (the_index.cache_nr)
@@ -698,12 +732,6 @@ extern int remove_file_from_index(struct index_state *=
, const char *path);
 extern int add_to_index(struct index_state *, const char *path, struct sta=
t *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int f=
lags);
=20
-extern struct cache_entry *make_cache_entry(unsigned int mode,
-					    const struct object_id *oid,
-					    const char *path,
-					    int stage,
-					    unsigned int refresh_options);
-
 extern int chmod_index_entry(struct index_state *, struct cache_entry *ce,=
 char flip);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_en=
try *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce=
);
diff --git a/merge-recursive.c b/merge-recursive.c
index 873321e5c2..06d77afbeb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -318,7 +318,7 @@ static int add_cacheinfo(struct merge_options *o,
 	struct cache_entry *ce;
 	int ret;
=20
-	ce =3D make_cache_entry(mode, oid ? oid : &null_oid, path, stage, 0);
+	ce =3D make_cache_entry(&the_index, mode, oid ? oid : &null_oid, path, st=
age, 0);
 	if (!ce)
 		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), =
path);
=20
diff --git a/read-cache.c b/read-cache.c
index 9624ce1784..116fd51680 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -61,7 +61,7 @@ static void replace_index_entry(struct index_state *istat=
e, int nr, struct cache
=20
 	replace_index_entry_in_base(istate, old, ce);
 	remove_name_hash(istate, old);
-	free(old);
+	discard_cache_entry(old);
 	ce->ce_flags &=3D ~CE_HASHED;
 	set_index_entry(istate, nr, ce);
 	ce->ce_flags |=3D CE_UPDATE_IN_BASE;
@@ -74,7 +74,7 @@ void rename_index_entry_at(struct index_state *istate, in=
t nr, const char *new_n
 	struct cache_entry *old_entry =3D istate->cache[nr], *new_entry;
 	int namelen =3D strlen(new_name);
=20
-	new_entry =3D xmalloc(cache_entry_size(namelen));
+	new_entry =3D make_empty_cache_entry(istate, namelen);
 	copy_cache_entry(new_entry, old_entry);
 	new_entry->ce_flags &=3D ~CE_HASHED;
 	new_entry->ce_namelen =3D namelen;
@@ -623,7 +623,7 @@ static struct cache_entry *create_alias_ce(struct index=
_state *istate,
=20
 	/* Ok, create the new entry using the name of the existing alias */
 	len =3D ce_namelen(alias);
-	new_entry =3D xcalloc(1, cache_entry_size(len));
+	new_entry =3D make_empty_cache_entry(istate, len);
 	memcpy(new_entry->name, alias->name, len);
 	copy_cache_entry(new_entry, ce);
 	save_or_free_index_entry(istate, ce);
@@ -640,7 +640,7 @@ void set_object_name_for_intent_to_add_entry(struct cac=
he_entry *ce)
=20
 int add_to_index(struct index_state *istate, const char *path, struct stat=
 *st, int flags)
 {
-	int size, namelen, was_same;
+	int namelen, was_same;
 	mode_t st_mode =3D st->st_mode;
 	struct cache_entry *ce, *alias =3D NULL;
 	unsigned ce_option =3D CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTRE=
E|CE_MATCH_RACY_IS_DIRTY;
@@ -662,8 +662,7 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 		while (namelen && path[namelen-1] =3D=3D '/')
 			namelen--;
 	}
-	size =3D cache_entry_size(namelen);
-	ce =3D xcalloc(1, size);
+	ce =3D make_empty_cache_entry(istate, namelen);
 	memcpy(ce->name, path, namelen);
 	ce->ce_namelen =3D namelen;
 	if (!intent_only)
@@ -704,13 +703,13 @@ int add_to_index(struct index_state *istate, const ch=
ar *path, struct stat *st,
 				ce_mark_uptodate(alias);
 			alias->ce_flags |=3D CE_ADDED;
=20
-			free(ce);
+			discard_cache_entry(ce);
 			return 0;
 		}
 	}
 	if (!intent_only) {
 		if (index_path(&ce->oid, path, st, newflags)) {
-			free(ce);
+			discard_cache_entry(ce);
 			return error("unable to index file %s", path);
 		}
 	} else
@@ -727,9 +726,9 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 		    ce->ce_mode =3D=3D alias->ce_mode);
=20
 	if (pretend)
-		free(ce);
+		discard_cache_entry(ce);
 	else if (add_index_entry(istate, ce, add_option)) {
-		free(ce);
+		discard_cache_entry(ce);
 		return error("unable to add %s to index", path);
 	}
 	if (verbose && !was_same)
@@ -745,14 +744,25 @@ int add_file_to_index(struct index_state *istate, con=
st char *path, int flags)
 	return add_to_index(istate, path, &st, flags);
 }
=20
-struct cache_entry *make_cache_entry(unsigned int mode,
+struct cache_entry *make_empty_cache_entry(struct index_state *istate, siz=
e_t len)
+{
+	return xcalloc(1, cache_entry_size(len));
+}
+
+struct cache_entry *make_empty_transient_cache_entry(size_t len)
+{
+	return xcalloc(1, cache_entry_size(len));
+}
+
+struct cache_entry *make_cache_entry(struct index_state *istate,
+				     unsigned int mode,
 				     const struct object_id *oid,
 				     const char *path,
 				     int stage,
 				     unsigned int refresh_options)
 {
-	int size, len;
 	struct cache_entry *ce, *ret;
+	int len;
=20
 	if (!verify_path(path, mode)) {
 		error("Invalid path '%s'", path);
@@ -760,8 +770,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	}
=20
 	len =3D strlen(path);
-	size =3D cache_entry_size(len);
-	ce =3D xcalloc(1, size);
+	ce =3D make_empty_cache_entry(istate, len);
=20
 	hashcpy(ce->oid.hash, oid->hash);
 	memcpy(ce->name, path, len);
@@ -771,10 +780,33 @@ struct cache_entry *make_cache_entry(unsigned int mod=
e,
=20
 	ret =3D refresh_cache_entry(&the_index, ce, refresh_options);
 	if (ret !=3D ce)
-		free(ce);
+		discard_cache_entry(ce);
 	return ret;
 }
=20
+struct cache_entry *make_transient_cache_entry(unsigned int mode, const st=
ruct object_id *oid,
+					       const char *path, int stage)
+{
+	struct cache_entry *ce;
+	int len;
+
+	if (!verify_path(path, mode)) {
+		error("Invalid path '%s'", path);
+		return NULL;
+	}
+
+	len =3D strlen(path);
+	ce =3D make_empty_transient_cache_entry(len);
+
+	hashcpy(ce->oid.hash, oid->hash);
+	memcpy(ce->name, path, len);
+	ce->ce_flags =3D create_ce_flags(stage);
+	ce->ce_namelen =3D len;
+	ce->ce_mode =3D create_ce_mode(mode);
+
+	return ce;
+}
+
 /*
  * Chmod an index entry with either +x or -x.
  *
@@ -1270,7 +1302,7 @@ static struct cache_entry *refresh_cache_ent(struct i=
ndex_state *istate,
 {
 	struct stat st;
 	struct cache_entry *updated;
-	int changed, size;
+	int changed;
 	int refresh =3D options & CE_MATCH_REFRESH;
 	int ignore_valid =3D options & CE_MATCH_IGNORE_VALID;
 	int ignore_skip_worktree =3D options & CE_MATCH_IGNORE_SKIP_WORKTREE;
@@ -1350,8 +1382,7 @@ static struct cache_entry *refresh_cache_ent(struct i=
ndex_state *istate,
 		return NULL;
 	}
=20
-	size =3D ce_size(ce);
-	updated =3D xmalloc(size);
+	updated =3D make_empty_cache_entry(istate, ce_namelen(ce));
 	copy_cache_entry(updated, ce);
 	memcpy(updated->name, ce->name, ce->ce_namelen + 1);
 	fill_stat_cache_info(updated, &st);
@@ -1637,12 +1668,13 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file(), get_git_dir());
 }
=20
-static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_ent=
ry *ondisk,
+static struct cache_entry *cache_entry_from_ondisk(struct index_state *ist=
ate,
+						   struct ondisk_cache_entry *ondisk,
 						   unsigned int flags,
 						   const char *name,
 						   size_t len)
 {
-	struct cache_entry *ce =3D xmalloc(cache_entry_size(len));
+	struct cache_entry *ce =3D make_empty_cache_entry(istate, len);
=20
 	ce->ce_stat_data.sd_ctime.sec =3D get_be32(&ondisk->ctime.sec);
 	ce->ce_stat_data.sd_mtime.sec =3D get_be32(&ondisk->mtime.sec);
@@ -1684,7 +1716,8 @@ static unsigned long expand_name_field(struct strbuf =
*name, const char *cp_)
 	return (const char *)ep + 1 - cp_;
 }
=20
-static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ond=
isk,
+static struct cache_entry *create_from_disk(struct index_state *istate,
+					    struct ondisk_cache_entry *ondisk,
 					    unsigned long *ent_size,
 					    struct strbuf *previous_name)
 {
@@ -1715,13 +1748,13 @@ static struct cache_entry *create_from_disk(struct =
ondisk_cache_entry *ondisk,
 		/* v3 and earlier */
 		if (len =3D=3D CE_NAMEMASK)
 			len =3D strlen(name);
-		ce =3D cache_entry_from_ondisk(ondisk, flags, name, len);
+		ce =3D cache_entry_from_ondisk(istate, ondisk, flags, name, len);
=20
 		*ent_size =3D ondisk_ce_size(ce);
 	} else {
 		unsigned long consumed;
 		consumed =3D expand_name_field(previous_name, name);
-		ce =3D cache_entry_from_ondisk(ondisk, flags,
+		ce =3D cache_entry_from_ondisk(istate, ondisk, flags,
 					     previous_name->buf,
 					     previous_name->len);
=20
@@ -1853,7 +1886,7 @@ int do_read_index(struct index_state *istate, const c=
har *path, int must_exist)
 		unsigned long consumed;
=20
 		disk_ce =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce =3D create_from_disk(disk_ce, &consumed, previous_name);
+		ce =3D create_from_disk(istate, disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
=20
 		src_offset +=3D consumed;
@@ -1959,7 +1992,7 @@ int discard_index(struct index_state *istate)
 		    istate->cache[i]->index <=3D istate->split_index->base->cache_nr &&
 		    istate->cache[i] =3D=3D istate->split_index->base->cache[istate->cac=
he[i]->index - 1])
 			continue;
-		free(istate->cache[i]);
+		discard_cache_entry(istate->cache[i]);
 	}
 	resolve_undo_clear_index(istate);
 	istate->cache_nr =3D 0;
@@ -2649,14 +2682,13 @@ int read_index_unmerged(struct index_state *istate)
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce =3D istate->cache[i];
 		struct cache_entry *new_ce;
-		int size, len;
+		int len;
=20
 		if (!ce_stage(ce))
 			continue;
 		unmerged =3D 1;
 		len =3D ce_namelen(ce);
-		size =3D cache_entry_size(len);
-		new_ce =3D xcalloc(1, size);
+		new_ce =3D make_empty_cache_entry(istate, len);
 		memcpy(new_ce->name, ce->name, len);
 		new_ce->ce_flags =3D create_ce_flags(0) | CE_CONFLICTED;
 		new_ce->ce_namelen =3D len;
@@ -2765,3 +2797,8 @@ void move_index_extensions(struct index_state *dst, s=
truct index_state *src)
 	dst->untracked =3D src->untracked;
 	src->untracked =3D NULL;
 }
+
+void discard_cache_entry(struct cache_entry *ce)
+{
+	free(ce);
+}
diff --git a/resolve-undo.c b/resolve-undo.c
index 4d4e5cb6bf..c30ae5cf49 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -146,7 +146,9 @@ int unmerge_index_entry_at(struct index_state *istate, =
int pos)
 		struct cache_entry *nce;
 		if (!ru->mode[i])
 			continue;
-		nce =3D make_cache_entry(ru->mode[i], &ru->oid[i],
+		nce =3D make_cache_entry(istate,
+				       ru->mode[i],
+				       &ru->oid[i],
 				       name, i + 1, 0);
 		if (matched)
 			nce->ce_flags |=3D CE_MATCHED;
diff --git a/split-index.c b/split-index.c
index 660c75f31f..317900db8b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -123,7 +123,7 @@ static void replace_entry(size_t pos, void *data)
 	src->ce_flags |=3D CE_UPDATE_IN_BASE;
 	src->ce_namelen =3D dst->ce_namelen;
 	copy_cache_entry(dst, src);
-	free(src);
+	discard_cache_entry(src);
 	si->nr_replacements++;
 }
=20
@@ -224,7 +224,7 @@ void prepare_to_write_split_index(struct index_state *i=
state)
 			base->ce_flags =3D base_flags;
 			if (ret)
 				ce->ce_flags |=3D CE_UPDATE_IN_BASE;
-			free(base);
+			discard_cache_entry(base);
 			si->base->cache[ce->index - 1] =3D ce;
 		}
 		for (i =3D 0; i < si->base->cache_nr; i++) {
@@ -301,7 +301,7 @@ void save_or_free_index_entry(struct index_state *istat=
e, struct cache_entry *ce
 	    ce =3D=3D istate->split_index->base->cache[ce->index - 1])
 		ce->ce_flags |=3D CE_REMOVE;
 	else
-		free(ce);
+		discard_cache_entry(ce);
 }
=20
 void replace_index_entry_in_base(struct index_state *istate,
@@ -314,7 +314,7 @@ void replace_index_entry_in_base(struct index_state *is=
tate,
 	    old_entry->index <=3D istate->split_index->base->cache_nr) {
 		new_entry->index =3D old_entry->index;
 		if (old_entry !=3D istate->split_index->base->cache[new_entry->index - 1=
])
-			free(istate->split_index->base->cache[new_entry->index - 1]);
+			discard_cache_entry(istate->split_index->base->cache[new_entry->index -=
 1]);
 		istate->split_index->base->cache[new_entry->index - 1] =3D new_entry;
 	}
 }
diff --git a/tree.c b/tree.c
index 2c9c49725c..7bbf304f9f 100644
--- a/tree.c
+++ b/tree.c
@@ -17,15 +17,13 @@ static int read_one_entry_opt(struct index_state *istat=
e,
 			      unsigned mode, int stage, int opt)
 {
 	int len;
-	unsigned int size;
 	struct cache_entry *ce;
=20
 	if (S_ISDIR(mode))
 		return READ_TREE_RECURSIVE;
=20
 	len =3D strlen(pathname);
-	size =3D cache_entry_size(baselen + len);
-	ce =3D xcalloc(1, size);
+	ce =3D make_empty_cache_entry(istate, baselen + len);
=20
 	ce->ce_mode =3D create_ce_mode(mode);
 	ce->ce_flags =3D create_ce_flags(stage);
diff --git a/unpack-trees.c b/unpack-trees.c
index 3a85a02a77..33cba550b0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -203,10 +203,10 @@ static int do_add_entry(struct unpack_trees_options *=
o, struct cache_entry *ce,
 			       ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 }
=20
-static struct cache_entry *dup_entry(const struct cache_entry *ce)
+static struct cache_entry *dup_entry(const struct cache_entry *ce, struct =
index_state *istate)
 {
 	unsigned int size =3D ce_size(ce);
-	struct cache_entry *new_entry =3D xmalloc(size);
+	struct cache_entry *new_entry =3D make_empty_cache_entry(istate, ce_namel=
en(ce));
=20
 	memcpy(new_entry, ce, size);
 	return new_entry;
@@ -216,7 +216,7 @@ static void add_entry(struct unpack_trees_options *o,
 		      const struct cache_entry *ce,
 		      unsigned int set, unsigned int clear)
 {
-	do_add_entry(o, dup_entry(ce), set, clear);
+	do_add_entry(o, dup_entry(ce, &o->result), set, clear);
 }
=20
 /*
@@ -797,10 +797,17 @@ static int ce_in_traverse_path(const struct cache_ent=
ry *ce,
 	return (info->pathlen < ce_namelen(ce));
 }
=20
-static struct cache_entry *create_ce_entry(const struct traverse_info *inf=
o, const struct name_entry *n, int stage)
+static struct cache_entry *create_ce_entry(const struct traverse_info *inf=
o,
+	const struct name_entry *n,
+	int stage,
+	struct index_state *istate,
+	int is_transient)
 {
 	int len =3D traverse_path_len(info, n);
-	struct cache_entry *ce =3D xcalloc(1, cache_entry_size(len));
+	struct cache_entry *ce =3D
+		is_transient ?
+		make_empty_transient_cache_entry(len) :
+		make_empty_cache_entry(istate, len);
=20
 	ce->ce_mode =3D create_ce_mode(n->mode);
 	ce->ce_flags =3D create_ce_flags(stage);
@@ -846,7 +853,15 @@ static int unpack_nondirectories(int n, unsigned long =
mask,
 			stage =3D 3;
 		else
 			stage =3D 2;
-		src[i + o->merge] =3D create_ce_entry(info, names + i, stage);
+
+		/*
+		 * If the merge bit is set, then the cache entries are
+		 * discarded in the following block.  In this case,
+		 * construct "transient" cache_entries, as they are
+		 * not stored in the index.  otherwise construct the
+		 * cache entry from the index aware logic.
+		 */
+		src[i + o->merge] =3D create_ce_entry(info, names + i, stage, &o->result=
, o->merge);
 	}
=20
 	if (o->merge) {
@@ -855,7 +870,7 @@ static int unpack_nondirectories(int n, unsigned long m=
ask,
 		for (i =3D 0; i < n; i++) {
 			struct cache_entry *ce =3D src[i + o->merge];
 			if (ce !=3D o->df_conflict_entry)
-				free(ce);
+				discard_cache_entry(ce);
 		}
 		return rc;
 	}
@@ -1787,7 +1802,7 @@ static int merged_entry(const struct cache_entry *ce,
 			struct unpack_trees_options *o)
 {
 	int update =3D CE_UPDATE;
-	struct cache_entry *merge =3D dup_entry(ce);
+	struct cache_entry *merge =3D dup_entry(ce, &o->result);
=20
 	if (!old) {
 		/*
@@ -1807,7 +1822,7 @@ static int merged_entry(const struct cache_entry *ce,
=20
 		if (verify_absent(merge,
 				  ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o)) {
-			free(merge);
+			discard_cache_entry(merge);
 			return -1;
 		}
 		invalidate_ce_path(merge, o);
@@ -1833,7 +1848,7 @@ static int merged_entry(const struct cache_entry *ce,
 			update =3D 0;
 		} else {
 			if (verify_uptodate(old, o)) {
-				free(merge);
+				discard_cache_entry(merge);
 				return -1;
 			}
 			/* Migrate old flags over */
--=20
2.17.1

