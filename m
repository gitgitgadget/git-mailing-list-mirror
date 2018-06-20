Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1231F403
	for <e@80x24.org>; Wed, 20 Jun 2018 16:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeFTQdr (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 12:33:47 -0400
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:42257
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754374AbeFTQdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 12:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AFAyya9A2HAzk+nGLrEZ9pPiK4DwXtLTRGfBD2L09g=;
 b=GZTYZ2sDLnX5T5lBKaf0LjCbBmZwgyhLi6/ISxfYBJmVX38Ybsup038OXGI9Ch7Tytip/1nqVGgihKKZkJOod3n7Lpu+FNuLpnbWzcxgeQ07WjZSB8cXvSHHOYg0EnTrMZZOW/3rQ5c5hjNXTcEZqr3h46QTBa+OmiGUg8pgQVM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1060.namprd21.prod.outlook.com (52.132.24.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.3; Wed, 20 Jun 2018 16:33:44 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 16:33:44 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] packfile: generalize pack directory list
Thread-Topic: [PATCH] packfile: generalize pack directory list
Thread-Index: AQHUCLR0e8ix0yLgv0u+jTSt+WbY7A==
Date:   Wed, 20 Jun 2018 16:33:44 +0000
Message-ID: <20180620163325.10393-1-dstolee@microsoft.com>
References: <CACsJy8BS1x2yqzongv7iPsBbQxxZ5fO4ZbwdX5BPrzePvpJB=Q@mail.gmail.com>
In-Reply-To: <CACsJy8BS1x2yqzongv7iPsBbQxxZ5fO4ZbwdX5BPrzePvpJB=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:404:65::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1060;7:3tTz7TeyzR1Jj9b3MLbVYagZMGWlomiTglw5nlYNvwu/TH89s+l3uiKuWISFNDAX5Qb1I/H1db0n6buNSEyjqHG+OZNQxXPAABp1JBK9+m2a0Y6LxuETpb+Z0ORZ1bp2izMYcTiivUITnadDQL3xcgZC9IJauHg4nNvvDFC7fJtMrWEjYu1WclGtdDi38oWLcRxDGpCiueHMIZX+7hwT4I+oJSCa6iysU5tktzBDo/oiWXynwJsamT4H/vC9DmPc
x-ms-office365-filtering-correlation-id: 96166be1-314d-41cc-f255-08d5d6cb969f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1060;
x-ms-traffictypediagnostic: BL0PR2101MB1060:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1060A13FAD5D0EFEAFED7145A1770@BL0PR2101MB1060.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1060;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1060;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(39380400002)(189003)(199004)(99286004)(107886003)(46003)(478600001)(76176011)(39060400002)(186003)(11346002)(446003)(10290500003)(316002)(25786009)(22452003)(14454004)(6486002)(4326008)(102836004)(6116002)(1857600001)(2900100001)(10090500001)(54906003)(386003)(6506007)(1076002)(53936002)(7736002)(36756003)(1730700003)(68736007)(305945005)(6916009)(6436002)(81166006)(81156014)(6512007)(5250100002)(106356001)(105586002)(2906002)(5640700003)(52116002)(8676002)(3660700001)(5660300001)(86612001)(86362001)(575784001)(486006)(97736004)(2616005)(8936002)(2351001)(3280700002)(476003)(2501003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1060;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KHd9hbclrg5/MLVtFmqRuf1j7+f8njFZhY0BB1K4lENRJhlq2LwbHH2n6lmCbif+6AFJMIiOUb83rQfbSewZBOMQ71DfosqD/XfGOWFWDJWUMAj7XG3ZhorycuyVK2YoL/kG4d0KUQ88DYugl40x7+WVllbgQL3W/W8snxJr97CHiqFLQqd2RqPiDW+xtqL54mBoyT8EkIWw9EeBkqc4B+nkJhLGvRidFku+vB+Ck697tAdVMwDehgcPhz9JuQf1dHZY42DSL63KF4TUfhXIOGEF8fNew5KUkz3kMxHqdFTfCd6/WnIz5VpHTJ/LOpJSnLZYD2miD23Mjwo889ZuVA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96166be1-314d-41cc-f255-08d5d6cb969f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 16:33:44.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1060
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of sharing the pack directory listing with the
multi-pack-index, generalize prepare_packed_git_one() into
for_each_file_in_pack_dir().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

Duy,

I think this is what you mean by sharing code between packfile.c and
midx.c for reading the packfiles from a pack directory. This does make
the code in midx.c much simpler. Is this change worth it?

This patch could stand on its own, or can be incorporated into the next
version of the MIDX series.

Thanks,
-Stolee

 packfile.c | 103 +++++++++++++++++++++++++++++++++--------------------
 packfile.h |   6 ++++
 2 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7cd45aa4b2..db61c8813b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -738,13 +738,14 @@ static void report_pack_garbage(struct string_list *l=
ist)
 	report_helper(list, seen_bits, first, list->nr);
 }
=20
-static void prepare_packed_git_one(struct repository *r, char *objdir, int=
 local)
+void for_each_file_in_pack_dir(const char *objdir,
+			       each_file_in_pack_dir_fn fn,
+			       void *data)
 {
 	struct strbuf path =3D STRBUF_INIT;
 	size_t dirnamelen;
 	DIR *dir;
 	struct dirent *de;
-	struct string_list garbage =3D STRING_LIST_INIT_DUP;
=20
 	strbuf_addstr(&path, objdir);
 	strbuf_addstr(&path, "/pack");
@@ -759,53 +760,79 @@ static void prepare_packed_git_one(struct repository =
*r, char *objdir, int local
 	strbuf_addch(&path, '/');
 	dirnamelen =3D path.len;
 	while ((de =3D readdir(dir)) !=3D NULL) {
-		struct packed_git *p;
-		size_t base_len;
-
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
=20
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
=20
-		base_len =3D path.len;
-		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
-			/* Don't reopen a pack we already have. */
-			for (p =3D r->objects->packed_git; p;
-			     p =3D p->next) {
-				size_t len;
-				if (strip_suffix(p->pack_name, ".pack", &len) &&
-				    len =3D=3D base_len &&
-				    !memcmp(p->pack_name, path.buf, len))
-					break;
-			}
-			if (p =3D=3D NULL &&
-			    /*
-			     * See if it really is a valid .idx file with
-			     * corresponding .pack file that we can map.
-			     */
-			    (p =3D add_packed_git(path.buf, path.len, local)) !=3D NULL)
-				install_packed_git(r, p);
-		}
-
-		if (!report_garbage)
-			continue;
-
-		if (ends_with(de->d_name, ".idx") ||
-		    ends_with(de->d_name, ".pack") ||
-		    ends_with(de->d_name, ".bitmap") ||
-		    ends_with(de->d_name, ".keep") ||
-		    ends_with(de->d_name, ".promisor"))
-			string_list_append(&garbage, path.buf);
-		else
-			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
+		fn(path.buf, path.len, de->d_name, data);
 	}
+
 	closedir(dir);
-	report_pack_garbage(&garbage);
-	string_list_clear(&garbage, 0);
 	strbuf_release(&path);
 }
=20
+struct prepare_pack_data
+{
+	struct repository *r;
+	struct string_list *garbage;
+	int local;
+};
+
+static void prepare_pack(const char *full_name, size_t full_name_len, cons=
t char *file_name, void *_data)
+{
+	struct prepare_pack_data *data =3D (struct prepare_pack_data *)_data;
+	struct packed_git *p;
+	size_t base_len =3D full_name_len;
+
+	if (strip_suffix_mem(full_name, &base_len, ".idx")) {
+		/* Don't reopen a pack we already have. */
+		for (p =3D data->r->objects->packed_git; p; p =3D p->next) {
+			size_t len;
+			if (strip_suffix(p->pack_name, ".pack", &len) &&
+			    len =3D=3D base_len &&
+			    !memcmp(p->pack_name, full_name, len))
+				break;
+		}
+
+		if (p =3D=3D NULL &&
+		    /*
+		     * See if it really is a valid .idx file with
+		     * corresponding .pack file that we can map.
+		     */
+		    (p =3D add_packed_git(full_name, full_name_len, data->local)) !=3D N=
ULL)
+			install_packed_git(data->r, p);
+	}
+
+	if (!report_garbage)
+	       return;
+
+	if (ends_with(file_name, ".idx") ||
+	    ends_with(file_name, ".pack") ||
+	    ends_with(file_name, ".bitmap") ||
+	    ends_with(file_name, ".keep") ||
+	    ends_with(file_name, ".promisor"))
+		string_list_append(data->garbage, full_name);
+	else
+		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
+}
+
+static void prepare_packed_git_one(struct repository *r, char *objdir, int=
 local)
+{
+	struct prepare_pack_data data;
+	struct string_list garbage =3D STRING_LIST_INIT_DUP;
+
+	data.r =3D r;
+	data.garbage =3D &garbage;
+	data.local =3D local;
+
+	for_each_file_in_pack_dir(objdir, prepare_pack, &data);
+
+	report_pack_garbage(data.garbage);
+	string_list_clear(data.garbage, 0);
+}
+
 static void prepare_packed_git(struct repository *r);
 /*
  * Give a fast, rough count of the number of objects in the repository. Th=
is
diff --git a/packfile.h b/packfile.h
index e0a38aba93..d2ad30300a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -28,6 +28,12 @@ extern char *sha1_pack_index_name(const unsigned char *s=
ha1);
=20
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char=
 *idx_path);
=20
+typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_p=
ath_len,
+				      const char *file_pach, void *data);
+void for_each_file_in_pack_dir(const char *objdir,
+			       each_file_in_pack_dir_fn fn,
+			       void *data);
+
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
--=20
2.18.0.rc1

