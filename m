Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03651F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966421AbeF1OAM (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:00:12 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com ([40.107.71.132]:33152
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966353AbeF1OAK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YdNmIVTeNdQUVx2flc8OGN43DVgxJ3vOa9mYli69vs=;
 b=XzsgOBdWYtD7KNYJc0bpYEciSvWfh4D8Y/OPCWv0j4hRtZ7lEj9+p8N2YuIgqSJ3eICDyyRln9mBVYVhsjxe9quHNNp4O0X3HZQXykIs0tvJJZGqYnX1GcmhjNw+oXJpOPRTfSwJ7Aur1cksKmUNU0b7ZuK8mNzaLM4QuTAej5Y=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0172.namprd21.prod.outlook.com (10.173.173.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.4; Thu, 28 Jun 2018 14:00:08 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 14:00:08 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: [PATCH v5 2/8] read-cache: make_cache_entry should take object_id
 struct
Thread-Topic: [PATCH v5 2/8] read-cache: make_cache_entry should take
 object_id struct
Thread-Index: AQHUDuhS8mIuSxtc+EmNBc0hPvPEUQ==
Date:   Thu, 28 Jun 2018 14:00:07 +0000
Message-ID: <20180628135932.225288-3-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0172;7:ljLdlrMUIlxf2AlayYXQPGvOVBqtwKENa+q7KWeYXQ9kQV6kqOv9Jrg9G3YctpO/pq40Dgo2ewutCzTCbbZgqHWG0x3bIHh8yzB3aFmt7PfDe2YRbaI4otRmoiBpXKWDI1a6WRPOkF6xYrZ+EbZPHJ6cdcNatofB+z28I7pCF1gMeL43pEa0z2PZz35GMkWUI/FYVjMGVGkB5Km+BkZDEXv5ROKPEk4xt91iKhMRaRCwWtjyLzaJyrHEdoFkXFpo
x-ms-office365-filtering-correlation-id: 00c526b4-65d8-4af2-e2d7-08d5dcff749e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0172;
x-ms-traffictypediagnostic: DM5PR21MB0172:
x-microsoft-antispam-prvs: <DM5PR21MB0172FBFD8FBB73BB3251CA3CCE4F0@DM5PR21MB0172.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231270)(2018427008)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0172;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0172;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(199004)(22452003)(86612001)(86362001)(1076002)(6116002)(575784001)(6486002)(6436002)(6512007)(10090500001)(53936002)(4326008)(36756003)(5660300001)(39060400002)(2900100001)(97736004)(25786009)(6200100001)(6862004)(5250100002)(2906002)(8676002)(10290500003)(7736002)(305945005)(478600001)(14454004)(68736007)(52116002)(386003)(102836004)(6506007)(6346003)(76176011)(81156014)(81166006)(8936002)(46003)(11346002)(446003)(99286004)(316002)(1511001)(476003)(2616005)(105586002)(106356001)(14444005)(37006003)(486006)(54906003)(256004)(7049001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0172;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: ET2aD4BwRJGDPny0hNxtb2yhD4lY2UBHamv3k1lr/3DrOY7uLEKCHu+Lz4X94nqzbK4R00k9aCcSsmeFu7TIEQhDYkxKYebpfI2uE68QOkg/PVqHM7giHiJqqTZo3T8jxMQwayQ1S/JS0LufSrkYc86p8Ee8uRhspb38HZba0+/+xAitdEGQKcvJU7FpMHJpMvRNjZ6wYRCiAMlFfp9WKV14G08o76vDN4vhzALajkIa9HHNsAr28FZdmBv0RTdXfptIRJsRYl4TUdvDTcxkLKAjanxOHsKMhbvcbfCGL9esrOM/QGEG9k4HCur59JWFTttqV1/KJOteOgmZJmsVIVsRLnpcxRBHQ3ISSIw7q8E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c526b4-65d8-4af2-e2d7-08d5dcff749e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 14:00:07.8868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0172
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The make_cache_entry function should take an object_id struct instead
of sha.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 apply.c            | 2 +-
 builtin/checkout.c | 2 +-
 builtin/difftool.c | 4 ++--
 builtin/reset.c    | 2 +-
 cache.h            | 7 ++++++-
 merge-recursive.c  | 2 +-
 read-cache.c       | 8 +++++---
 resolve-undo.c     | 2 +-
 8 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index 959c457910..8ef975a32d 100644
--- a/apply.c
+++ b/apply.c
@@ -4092,7 +4092,7 @@ static int build_fake_ancestor(struct apply_state *st=
ate, struct patch *list)
 			return error(_("sha1 information is lacking or useless "
 				       "(%s)."), name);
=20
-		ce =3D make_cache_entry(patch->old_mode, oid.hash, name, 0, 0);
+		ce =3D make_cache_entry(patch->old_mode, &oid, name, 0, 0);
 		if (!ce)
 			return error(_("make_cache_entry failed for path '%s'"),
 				     name);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e1d2376d2..548bf40f25 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -230,7 +230,7 @@ static int checkout_merged(int pos, const struct checko=
ut *state)
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce =3D make_cache_entry(mode, oid.hash, path, 2, 0);
+	ce =3D make_cache_entry(mode, &oid, path, 2, 0);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status =3D checkout_entry(ce, state, NULL);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index bc97d4aef2..873a06f0d9 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -321,7 +321,7 @@ static int checkout_path(unsigned mode, struct object_i=
d *oid,
 	struct cache_entry *ce;
 	int ret;
=20
-	ce =3D make_cache_entry(mode, oid->hash, path, 0, 0);
+	ce =3D make_cache_entry(mode, oid, path, 0, 0);
 	ret =3D checkout_entry(ce, state, NULL);
=20
 	free(ce);
@@ -488,7 +488,7 @@ static int run_dir_diff(const char *extcmd, int symlink=
s, const char *prefix,
 				 * index.
 				 */
 				struct cache_entry *ce2 =3D
-					make_cache_entry(rmode, roid.hash,
+					make_cache_entry(rmode, &roid,
 							 dst_path, 0, 0);
=20
 				add_index_entry(&wtindex, ce2,
diff --git a/builtin/reset.c b/builtin/reset.c
index a862c70fab..00109b041f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -134,7 +134,7 @@ static void update_index_from_diff(struct diff_queue_st=
ruct *q,
 			continue;
 		}
=20
-		ce =3D make_cache_entry(one->mode, one->oid.hash, one->path,
+		ce =3D make_cache_entry(one->mode, &one->oid, one->path,
 				      0, 0);
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
diff --git a/cache.h b/cache.h
index 93af25f586..3fbf24771a 100644
--- a/cache.h
+++ b/cache.h
@@ -698,7 +698,12 @@ extern int remove_file_from_index(struct index_state *=
, const char *path);
 extern int add_to_index(struct index_state *, const char *path, struct sta=
t *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int f=
lags);
=20
-extern struct cache_entry *make_cache_entry(unsigned int mode, const unsig=
ned char *sha1, const char *path, int stage, unsigned int refresh_options);
+extern struct cache_entry *make_cache_entry(unsigned int mode,
+					    const struct object_id *oid,
+					    const char *path,
+					    int stage,
+					    unsigned int refresh_options);
+
 extern int chmod_index_entry(struct index_state *, struct cache_entry *ce,=
 char flip);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_en=
try *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce=
);
diff --git a/merge-recursive.c b/merge-recursive.c
index 8b3d6781c7..873321e5c2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -318,7 +318,7 @@ static int add_cacheinfo(struct merge_options *o,
 	struct cache_entry *ce;
 	int ret;
=20
-	ce =3D make_cache_entry(mode, oid ? oid->hash : null_sha1, path, stage, 0=
);
+	ce =3D make_cache_entry(mode, oid ? oid : &null_oid, path, stage, 0);
 	if (!ce)
 		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), =
path);
=20
diff --git a/read-cache.c b/read-cache.c
index fa8366ecab..9624ce1784 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -746,8 +746,10 @@ int add_file_to_index(struct index_state *istate, cons=
t char *path, int flags)
 }
=20
 struct cache_entry *make_cache_entry(unsigned int mode,
-		const unsigned char *sha1, const char *path, int stage,
-		unsigned int refresh_options)
+				     const struct object_id *oid,
+				     const char *path,
+				     int stage,
+				     unsigned int refresh_options)
 {
 	int size, len;
 	struct cache_entry *ce, *ret;
@@ -761,7 +763,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	size =3D cache_entry_size(len);
 	ce =3D xcalloc(1, size);
=20
-	hashcpy(ce->oid.hash, sha1);
+	hashcpy(ce->oid.hash, oid->hash);
 	memcpy(ce->name, path, len);
 	ce->ce_flags =3D create_ce_flags(stage);
 	ce->ce_namelen =3D len;
diff --git a/resolve-undo.c b/resolve-undo.c
index fc5b3b83d9..4d4e5cb6bf 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -146,7 +146,7 @@ int unmerge_index_entry_at(struct index_state *istate, =
int pos)
 		struct cache_entry *nce;
 		if (!ru->mode[i])
 			continue;
-		nce =3D make_cache_entry(ru->mode[i], ru->oid[i].hash,
+		nce =3D make_cache_entry(ru->mode[i], &ru->oid[i],
 				       name, i + 1, 0);
 		if (matched)
 			nce->ce_flags |=3D CE_MATCHED;
--=20
2.17.1

