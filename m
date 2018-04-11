Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97691F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756396AbeDKUBk (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:01:40 -0400
Received: from mail-sn1nam02on0128.outbound.protection.outlook.com ([104.47.36.128]:3132
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756328AbeDKUBh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xKKVJMucs+sa4x9+e4iN/WI4sjhfQvPIVxkt60vH5XQ=;
 b=HzbMtjQo+NyW2NdFNSzsJZRz8HGun2dAfcIlcfplbzAQeRXNvn9qIKcF66xM/c0Ixc9HP/hRv0hKpcQZ7DXWCJ9qYWK3XE5dE8sgAeGnxIcCKQzZasLBbKfIJlQCR4e4IM0Z4wmPS18689n4l6mAttjNLLffo0V5l2TymCtQm6s=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0984.namprd21.prod.outlook.com (52.132.133.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Wed, 11 Apr 2018 20:01:35 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0696.006; Wed, 11 Apr 2018
 20:01:35 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2 1/2] fsexcludes: add a programmatic way to exclude files
 from git's working directory traversal logic
Thread-Topic: [PATCH v2 1/2] fsexcludes: add a programmatic way to exclude
 files from git's working directory traversal logic
Thread-Index: AQHT0c/k/+Kgr038wkuoJmH75wVz6w==
Date:   Wed, 11 Apr 2018 20:01:34 +0000
Message-ID: <20180411200007.8612-2-benpeart@microsoft.com>
References: <20180410210408.13788-1-benpeart@microsoft.com>
 <20180411200007.8612-1-benpeart@microsoft.com>
In-Reply-To: <20180411200007.8612-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0062.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::22) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:hsrCjwh78xUNLa5kABzPb3j4FphUemuqb8K2Is7XH/8FyP8y0NljMQJ/65HD9BFch5jEaIUzezwHZocBR6PvrEsnl6nMh2EkxEAGLg6l5QamttHWNgqhPoBZ9kZ2A8V/oPq+UW1iPPTRQ+CRk+QZ4G6YOnufElf83u98nbIcFV2nZh7C9xgCqmv6xcf+B127NQQpsSsUSPvJPN8dDiOC0/s8IPZOACvh0kz3URQlSeVIcZfHQP5uqQiEw4u5AV5Y;20:ZT7kY6lRzf75dv+JPwSLTstMmYrBbVbTGGXA0H+wwxQXHd4UEb6+6yNgnd/dmsG8mROQTHwKdwLpkoKzYZfrMrl4oJZqpoFRvH8p6Vl5u3J9QxvohMZBDFhXFnR2IfB7LX2eVogqwi7HqCXwGCXCJasdBsw0yNxky809xK1ddVw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB09841709D129AEB82BDA01BCF4BD0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(60795455431006)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501337)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6916009)(5250100002)(8666007)(105586002)(5640700003)(2900100001)(25786009)(39060400002)(1076002)(6116002)(3846002)(36756003)(6486002)(6436002)(4326008)(97736004)(7736002)(305945005)(5660300001)(10090500001)(2351001)(81166006)(81156014)(8676002)(8936002)(50226002)(106356001)(66066001)(478600001)(59450400001)(72206003)(52116002)(76176011)(10290500003)(3280700002)(107886003)(1730700003)(186003)(3660700001)(386003)(53936002)(14454004)(54906003)(2906002)(99286004)(26005)(6506007)(8656006)(102836004)(2616005)(476003)(486006)(446003)(11346002)(86612001)(68736007)(22452003)(316002)(6512007)(22906009)(43043002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZLViJcQNJq1grnYRCrliaE7RmyzQ25v4IQrrlTCXftU8T95ec7H6/Sz8XEtsa3mM6mjx/RwhEQnAFgCiBsFHNSp8nRuDE2ei362gqQVAIIxQ8b9n9hfu2Qc3hhAHFZ7WjWjZFArCYifRywuFpx8cEBD90FciIMyqbKszNdRIY466d2FiFzfd0DMrfOZmINVtgEjke3lkPhXiwXAJdTgpRXNOjtDADguMHJMiTGFhgAvoyOOsbwFI6QTsShwgi6yS69tqY6XzCUqZ9SuERE+okvC80XWHkKQlXKaDeGhwSIeAUEA53Z3+bN+D+xXxPjqiEm997PaBJmt2JcYadtS8NovS3jdYyO6/gvSAo7xB538/b4xZMsk2tdeX4SEwkflRHMGWnQxzxa3xTl16YZeimJIvfuE7k8gsXUt+SxaQQcw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 45b2fdd0-53d1-47de-c068-08d59fe706e8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b2fdd0-53d1-47de-c068-08d59fe706e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 20:01:34.9575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
 dir.c        |  23 +++++-
 fsexcludes.c | 211 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fsexcludes.h |  29 +++++++
 4 files changed, 262 insertions(+), 2 deletions(-)
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
diff --git a/dir.c b/dir.c
index 63a917be45..1aa639b9f4 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,7 @@
 #include "utf8.h"
 #include "varint.h"
 #include "ewah/ewok.h"
+#include "fsexcludes.h"
 #include "fsmonitor.h"
=20
 /*
@@ -1102,6 +1103,12 @@ int is_excluded_from_list(const char *pathname,
 			  struct exclude_list *el, struct index_state *istate)
 {
 	struct exclude *exclude;
+
+	if (*dtype =3D=3D DT_UNKNOWN)
+		*dtype =3D get_dtype(NULL, istate, pathname, pathlen);
+	if (fsexcludes_is_excluded_from(istate, pathname, pathlen, *dtype) > 0)
+		return 1;
+
 	exclude =3D last_exclude_matching_from_list(pathname, pathlen, basename,
 						  dtype, el, istate);
 	if (exclude)
@@ -1317,8 +1324,15 @@ struct exclude *last_exclude_matching(struct dir_str=
uct *dir,
 int is_excluded(struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int *dtype_p)
 {
-	struct exclude *exclude =3D
-		last_exclude_matching(dir, istate, pathname, dtype_p);
+	struct exclude *exclude;
+	int pathlen =3D strlen(pathname);
+
+	if (*dtype_p =3D=3D DT_UNKNOWN)
+		*dtype_p =3D get_dtype(NULL, istate, pathname, pathlen);
+	if (fsexcludes_is_excluded_from(istate, pathname, pathlen, *dtype_p) > 0)
+		return 1;
+
+	exclude =3D last_exclude_matching(dir, istate, pathname, dtype_p);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
@@ -1671,6 +1685,9 @@ static enum path_treatment treat_one_path(struct dir_=
struct *dir,
 	if (dtype !=3D DT_DIR && has_path_in_index)
 		return path_none;
=20
+	if (fsexcludes_is_excluded_from(istate, path->buf, path->len, dtype) > 0)
+		return path_excluded;
+
 	/*
 	 * When we are looking at a directory P in the working tree,
 	 * there are three cases:
@@ -2011,6 +2028,8 @@ static enum path_treatment read_directory_recursive(s=
truct dir_struct *dir,
 		/* add the path to the appropriate result list */
 		switch (state) {
 		case path_excluded:
+			if (fsexcludes_is_excluded_from(istate, path.buf, path.len, DTYPE(cdir.=
de)) > 0)
+				break;
 			if (dir->flags & DIR_SHOW_IGNORED)
 				dir_add_name(dir, istate, path.buf, path.len);
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
diff --git a/fsexcludes.c b/fsexcludes.c
new file mode 100644
index 0000000000..0ef57f107b
--- /dev/null
+++ b/fsexcludes.c
@@ -0,0 +1,211 @@
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
+void fsexcludes_init(struct strbuf *sb)
+{
+	fsexcludes_initialized =3D 1;
+	fsexcludes_data =3D *sb;
+	strbuf_detach(sb, NULL);
+}
+
+void fsexcludes_free(void) {
+	strbuf_release(&fsexcludes_data);
+	hashmap_free(&fsexcludes_hashmap, 1);
+	hashmap_free(&parent_directory_hashmap, 1);
+	fsexcludes_initialized =3D 0;
+}
diff --git a/fsexcludes.h b/fsexcludes.h
new file mode 100644
index 0000000000..10246daa02
--- /dev/null
+++ b/fsexcludes.h
@@ -0,0 +1,29 @@
+#ifndef FSEXCLUDES_H
+#define FSEXCLUDES_H
+
+/*
+ * The file system excludes functions provides a way to programatically li=
mit
+ * where git will scan for untracked files.  This is used to speed up the
+ * scan by avoiding scanning parts of the work directory that do not have
+ * any new files.
+ */
+
+/*
+ * sb should contain a NUL separated list of path names of the files
+ * and/or directories that should be checked.  Any path not listed will
+ * be excluded from the scan.
+ *
+ * NOTE: fsexcludes_init() will take ownership of the storage passed in
+ * sb and will reset sb to `STRBUF_INIT`
+ */
+void fsexcludes_init(struct strbuf *sb);
+void fsexcludes_free(void);
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

