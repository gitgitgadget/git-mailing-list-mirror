Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C34C1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDJVEj (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:04:39 -0400
Received: from mail-sn1nam01on0128.outbound.protection.outlook.com ([104.47.32.128]:58880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752214AbeDJVE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=usyvbP+UDwSv6ZV4tEsqqx/4kr9D3dHQ08UcUh2cAK8=;
 b=kT5oE2BfBt4Zf36ZrvWB/1A7ZExWL5mhPfxH6DOrlK5UlVaEPebenVi7KF9F0CeF2pOoqBjqB/LfWIOvxBDVahHzgCSdZ1lbSPF95qqZHQPf8V6KirB064ddIzcXnxUGrB902IcyTIDoiqve0giq35TJwI3RNZ1i8CIbiur7BZY=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0982.namprd21.prod.outlook.com (52.132.133.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Tue, 10 Apr 2018 21:04:25 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0696.003; Tue, 10 Apr 2018
 21:04:25 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 1/2] fsexcludes: add a programmatic way to exclude files
 from git's working directory traversal logic
Thread-Topic: [PATCH v1 1/2] fsexcludes: add a programmatic way to exclude
 files from git's working directory traversal logic
Thread-Index: AQHT0Q+AOcK1hnY73kaXsr8L3f9kKw==
Date:   Tue, 10 Apr 2018 21:04:24 +0000
Message-ID: <20180410210408.13788-2-benpeart@microsoft.com>
References: <20180410210408.13788-1-benpeart@microsoft.com>
In-Reply-To: <20180410210408.13788-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.16.2.windows.1
x-clientproxiedby: BN3PR03CA0082.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::42) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:QIP2EqsTsjx2Dhs4qA9GdUdqUJnMnK1GiHVk9X4JsIQRLfYs91xMiwLYZnVUWpQlvoGLGOoMjIFoLdPa7QHqILlyFcAhWb57Eavfb+DfuwywUSviHowjRssNJVDSV7wkA5qxHVGKc3KyYPT+ntNW9GCIYCml1rj4+bfjULQiWV9sHp0Yi2fk5l7OdPDTQVa/VDNdu2dVXPr/jSM8HeNZ9wxOcSNJYvmDPdUDDHWkEypOkwRB676npK1pa0Q0tVpg;20:6FNxzYYwhS6GJFC9ZfoW1Ziv2QvPogadhu7lzhGHCqzzPKlMqStz+Izc5+Fa15zDurNwjwULJ10uwxWRdTVz7ZnT3R4tPFCwbJ9+405f/4YWpJNCh5HGDkWtfiG4O2BoJI+YBIsbq8X10YCagycmpvzdrgGmMD4b91gyfpbaRSs=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB098233BDBA8D9ACA5D45B559F4BE0@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(189003)(199004)(81166006)(8936002)(105586002)(106356001)(59450400001)(81156014)(8676002)(1076002)(1730700003)(99286004)(3280700002)(76176011)(8656006)(52116002)(2906002)(50226002)(86612001)(2501003)(6916009)(5250100002)(6116002)(107886003)(3846002)(97736004)(54906003)(26005)(5660300001)(22452003)(316002)(39060400002)(4326008)(186003)(68736007)(66066001)(102836004)(6506007)(386003)(478600001)(11346002)(446003)(486006)(476003)(72206003)(25786009)(10290500003)(8666007)(3660700001)(6512007)(2351001)(6436002)(10090500001)(5640700003)(53936002)(2616005)(36756003)(2900100001)(14454004)(305945005)(6486002)(7736002)(22906009)(43043002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 93UiHbCes/SgPIrxmkLWUrN0ve4EvD8bjtwfpVzFNd7Tepj4w5QnarAZgt4/7tsWuBr3HSRJ7f+HDs/j3PQEwGKZdrVsSr5apv4F8uqqyFCd+OjLixe1RAEcHWguosDiAaClJ4FRgqqgTRHdbDKep8FWaNk6trU90kNu+wEBBBZ0kr9K7ImPKq1YmroOOfkRDoCtx3jQXdCjbK2KTEHduP1OTT6msFW6eVP2n1oknwGrjSLfoFTMdGdRCnOgFsRjU34MNYQ7tsprfQvFAXHSik16R58oqKPdbaGFEPJG6pq5aIN0cmCGhC20dz8C8Plp6m+/uNpP+4EFznzI74p150z2zvvK29ZMLForiOpk1HzOztr/SItv6WNRR9LI9R9bU78zvEzHfz8OxAklMSf5Jo8tTQ/ZPUy1Zr42uxMHd8c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5ed6a9a1-d1d3-454e-a23c-08d59f26a346
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed6a9a1-d1d3-454e-a23c-08d59f26a346
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 21:04:24.4355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The File System Excludes module is a new programmatic way to exclude files =
and
folders from git's traversal of the working directory.  fsexcludes_init() s=
hould
be called with a string buffer that contains a NUL separated list of path n=
ames
of the files and/or directories that should be included.  Any path not list=
ed
will be excluded. The paths should be relative to the root of the working
directory and be separated by a single NUL.

The excludes logic in dir.c has been updated to honor the results of
fsexcludes_is_excluded_from().  If fsexcludes does not exclude the file, th=
e
normal excludes logic is also checked as it could further reduce the set of
files that should be included.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Makefile     |   1 +
 fsexcludes.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fsexcludes.h |  27 +++++++
 3 files changed, 238 insertions(+)
 create mode 100644 fsexcludes.c
 create mode 100644 fsexcludes.h

diff --git a/Makefile b/Makefile
index 96f6138f63..c102d2f75a 100644
--- a/Makefile
+++ b/Makefile
@@ -819,6 +819,7 @@ LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fetch-object.o
 LIB_OBJS +=3D fetch-pack.o
 LIB_OBJS +=3D fsck.o
+LIB_OBJS +=3D fsexcludes.o
 LIB_OBJS +=3D fsmonitor.o
 LIB_OBJS +=3D gettext.o
 LIB_OBJS +=3D gpg-interface.o
diff --git a/fsexcludes.c b/fsexcludes.c
new file mode 100644
index 0000000000..07bfe376a0
--- /dev/null
+++ b/fsexcludes.c
@@ -0,0 +1,210 @@
+#include "cache.h"
+#include "fsexcludes.h"
+#include "hashmap.h"
+#include "strbuf.h"
+
+static int fsexcludes_initialized =3D 0;
+static struct strbuf fsexcludes_data =3D STRBUF_INIT;
+static struct hashmap fsexcludes_hashmap;
+static struct hashmap parent_directory_hashmap;
+
+struct fsexcludes {
+	struct hashmap_entry ent; /* must be the first member! */
+	const char *pattern;
+	int patternlen;
+};
+
+static unsigned int(*fsexcludeshash)(const void *buf, size_t len);
+static int(*fsexcludescmp)(const char *a, const char *b, size_t len);
+
+static int fsexcludes_hashmap_cmp(const void *unused_cmp_data,
+	const void *a, const void *b, const void *key)
+{
+	const struct fsexcludes *fse1 =3D a;
+	const struct fsexcludes *fse2 =3D b;
+
+	return fsexcludescmp(fse1->pattern, fse2->pattern, fse1->patternlen);
+}
+
+static int check_fsexcludes_hashmap(struct hashmap *map, const char *patte=
rn, int patternlen)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct fsexcludes fse;
+	char *slash;
+
+	/* Check straight mapping */
+	strbuf_reset(&sb);
+	strbuf_add(&sb, pattern, patternlen);
+	fse.pattern =3D sb.buf;
+	fse.patternlen =3D sb.len;
+	hashmap_entry_init(&fse, fsexcludeshash(fse.pattern, fse.patternlen));
+	if (hashmap_get(map, &fse, NULL)) {
+		strbuf_release(&sb);
+		return 0;
+	}
+
+	/*
+	 * Check to see if it matches a directory or any path
+	 * underneath it.  In other words, 'a/b/foo.txt' will match
+	 * '/', 'a/', and 'a/b/'.
+	 */
+	slash =3D strchr(sb.buf, '/');
+	while (slash) {
+		fse.pattern =3D sb.buf;
+		fse.patternlen =3D slash - sb.buf + 1;
+		hashmap_entry_init(&fse, fsexcludeshash(fse.pattern, fse.patternlen));
+		if (hashmap_get(map, &fse, NULL)) {
+			strbuf_release(&sb);
+			return 0;
+		}
+		slash =3D strchr(slash + 1, '/');
+	}
+
+	strbuf_release(&sb);
+	return 1;
+}
+
+static void fsexcludes_hashmap_add(struct hashmap *map, const char *patter=
n, const int patternlen)
+{
+	struct fsexcludes *fse;
+
+	fse =3D xmalloc(sizeof(struct fsexcludes));
+	fse->pattern =3D pattern;
+	fse->patternlen =3D patternlen;
+	hashmap_entry_init(fse, fsexcludeshash(fse->pattern, fse->patternlen));
+	hashmap_add(map, fse);
+}
+
+static void initialize_fsexcludes_hashmap(struct hashmap *map, struct strb=
uf *fsexcludes_data)
+{
+	char *buf, *entry;
+	size_t len;
+	int i;
+
+	/*
+	 * Build a hashmap of the fsexcludes data we can use to look
+	 * for cache entry matches quickly
+	 */
+	fsexcludeshash =3D ignore_case ? memihash : memhash;
+	fsexcludescmp =3D ignore_case ? strncasecmp : strncmp;
+	hashmap_init(map, fsexcludes_hashmap_cmp, NULL, 0);
+
+	entry =3D buf =3D fsexcludes_data->buf;
+	len =3D fsexcludes_data->len;
+	for (i =3D 0; i < len; i++) {
+		if (buf[i] =3D=3D '\0') {
+			fsexcludes_hashmap_add(map, entry, buf + i - entry);
+			entry =3D buf + i + 1;
+		}
+	}
+}
+
+static void parent_directory_hashmap_add(struct hashmap *map, const char *=
pattern, const int patternlen)
+{
+	char *slash;
+	struct fsexcludes *fse;
+
+	/*
+	 * Add any directories leading up to the file as the excludes logic
+	 * needs to match directories leading up to the files as well. Detect
+	 * and prevent unnecessary duplicate entries which will be common.
+	 */
+	if (patternlen > 1) {
+		slash =3D strchr(pattern + 1, '/');
+		while (slash) {
+			fse =3D xmalloc(sizeof(struct fsexcludes));
+			fse->pattern =3D pattern;
+			fse->patternlen =3D slash - pattern + 1;
+			hashmap_entry_init(fse, fsexcludeshash(fse->pattern, fse->patternlen));
+			if (hashmap_get(map, fse, NULL))
+				free(fse);
+			else
+				hashmap_add(map, fse);
+			slash =3D strchr(slash + 1, '/');
+		}
+	}
+}
+
+static void initialize_parent_directory_hashmap(struct hashmap *map, struc=
t strbuf *vfs_data)
+{
+	char *buf, *entry;
+	size_t len;
+	int i;
+
+	/*
+	 * Build a hashmap of the parent directories contained in the virtual
+	 * file system data we can use to look for matches quickly
+	 */
+	fsexcludeshash =3D ignore_case ? memihash : memhash;
+	fsexcludescmp =3D ignore_case ? strncasecmp : strncmp;
+	hashmap_init(map, fsexcludes_hashmap_cmp, NULL, 0);
+
+	entry =3D buf =3D vfs_data->buf;
+	len =3D vfs_data->len;
+	for (i =3D 0; i < len; i++) {
+		if (buf[i] =3D=3D '\0') {
+			parent_directory_hashmap_add(map, entry, buf + i - entry);
+			entry =3D buf + i + 1;
+		}
+	}
+}
+
+static int check_directory_hashmap(struct hashmap *map, const char *pathna=
me, int pathlen)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct fsexcludes fse;
+
+	/* Check for directory */
+	strbuf_reset(&sb);
+	strbuf_add(&sb, pathname, pathlen);
+	strbuf_addch(&sb, '/');
+	fse.pattern =3D sb.buf;
+	fse.patternlen =3D sb.len;
+	hashmap_entry_init(&fse, fsexcludeshash(fse.pattern, fse.patternlen));
+	if (hashmap_get(map, &fse, NULL)) {
+		strbuf_release(&sb);
+		return 0;
+	}
+
+	strbuf_release(&sb);
+	return 1;
+}
+
+/*
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+int fsexcludes_is_excluded_from(struct index_state *istate,
+	const char *pathname, int pathlen, int dtype)
+{
+	if (!fsexcludes_initialized)
+		return -1;
+
+	if (dtype =3D=3D DT_REG) {
+		/* lazily init the hashmap */
+		if (!fsexcludes_hashmap.cmpfn_data)
+			initialize_fsexcludes_hashmap(&fsexcludes_hashmap, &fsexcludes_data);
+
+		return check_fsexcludes_hashmap(&fsexcludes_hashmap, pathname, pathlen);
+	}
+
+	if (dtype =3D=3D DT_DIR || dtype =3D=3D DT_LNK) {
+		/* lazily init the hashmap */
+		if (!parent_directory_hashmap.cmpfn_data)
+			initialize_parent_directory_hashmap(&parent_directory_hashmap, &fsexclu=
des_data);
+
+		return check_directory_hashmap(&parent_directory_hashmap, pathname, path=
len);
+	}
+
+	return -1;
+}
+
+void fsexcludes_init(struct strbuf *sb) {
+	fsexcludes_initialized =3D 1;
+	fsexcludes_data =3D *sb;
+}
+
+void fsexcludes_free() {
+	strbuf_release(&fsexcludes_data);
+	hashmap_free(&fsexcludes_hashmap, 1);
+	hashmap_free(&parent_directory_hashmap, 1);
+}
diff --git a/fsexcludes.h b/fsexcludes.h
new file mode 100644
index 0000000000..1c4101343c
--- /dev/null
+++ b/fsexcludes.h
@@ -0,0 +1,27 @@
+#ifndef FSEXCLUDES_H
+#define FSEXCLUDES_H
+
+/*
+ * The file system excludes functions provides a way to programatically li=
mit
+ * where git will scan for untracked files.  This is used to speed up the
+ * scan by avoiding scanning parts of the work directory that do not have
+ * any new files.
+ *
+ */
+
+/*
+ * sb should contain a NUL separated list of path names of the files
+ * and/or directories that should be checked.  Any path not listed will
+ * be excluded from the scan.
+ */
+void fsexcludes_init(struct strbuf *sb);
+void fsexcludes_free();
+
+/*
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+int fsexcludes_is_excluded_from(struct index_state *istate,
+	const char *pathname, int pathlen, int dtype_p);
+
+
+#endif
--=20
2.17.0.windows.1

