Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6311F424
	for <e@80x24.org>; Wed,  9 May 2018 14:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbeEIOPo (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 10:15:44 -0400
Received: from mail-dm3nam03on0100.outbound.protection.outlook.com ([104.47.41.100]:12227
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756542AbeEIOPl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 10:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Rxq0svbIOkEDHoKcSniAEV5yDyTGNQ3rnmhdv4NSiu8=;
 b=QNtEN2H/uyc4rd7dj2fTzHTwzLwbssCVxaMdA1QcxgvH9ksWKdezPAPfjeQX0iwgZ35Zk3do5A92hdpPwe8AkU2BNvv2KnJAAfx7EStRT0iafr8M2csk2GLq/vTbuIgTBkO02a/skRm9ETwe9xQACsiFi88JGu18GJ9xA2LIkDE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Wed, 9 May 2018 14:15:39 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Wed, 9 May 2018
 14:15:39 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/1] commit-graph: fix UX issue when .lock file exists
Thread-Topic: [PATCH 1/1] commit-graph: fix UX issue when .lock file exists
Thread-Index: AQHT56A0I8H+/UwDGEWuTO26eX58uA==
Date:   Wed, 9 May 2018 14:15:38 +0000
Message-ID: <20180509141523.89896-2-dstolee@microsoft.com>
References: <20180509141523.89896-1-dstolee@microsoft.com>
In-Reply-To: <20180509141523.89896-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:405:1::24) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:uDnJEBuFrMonIz8JgtDeDUT29LanBrY5hJ94gXyhL8NDIENe2YA9LEdVZI7ditbosTJfi1f3HcNg0GWCU9OVTbraWaBGXLklJhCm2Hr3emTKE+XJ5cXhjGx4U97IS/v4LJ2i5idGWpTk92xQlGj0EbkFegiceKxp2Jzfcjes4s0zlG/YJj+qzEi7DT5KAOBpumMAhkxRlklKWAl17brAQUKm06w58ydl8r7AqCpELD+KONlmqxsH1uO7nLdICf8z;20:O5zvu46s5gJ6SyYvdEcvF25GDyNoqeUXqN72v+jEK1nJfXS9PClnvkICvRFdRmNI8m6AuWLg4cqdrFn/sxskuUayVFAaerOzoky1me/0FD4aVl+BvropIFryVx3JQj/adqqhBg+R/M6Pm4itHTqrlv1pJezN5m7lvss3ddsSWyk=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB1044B667417EEC027330A563A1990@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(6436002)(305945005)(1730700003)(81156014)(4326008)(52116002)(5250100002)(99286004)(8676002)(59450400001)(14454004)(10090500001)(7736002)(76176011)(6506007)(386003)(2501003)(2906002)(2900100001)(86612001)(81166006)(39060400002)(8656006)(6346003)(107886003)(1076002)(8936002)(3280700002)(6512007)(6916009)(6116002)(53936002)(102836004)(186003)(3660700001)(97736004)(68736007)(10290500003)(5640700003)(22452003)(86362001)(54906003)(36756003)(2351001)(46003)(486006)(5660300001)(478600001)(6486002)(105586002)(476003)(316002)(446003)(2616005)(11346002)(25786009)(106356001)(22906009)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: o79q/Ci1nqtjtyDIzk2jhcURbJRyuOBSK56Sx+jpxZDKwZAlpkV5OzKESjSunH/dGtRe4bbiVtpCcj3vdhDNJObylOYbqB7ovJFgOOM9fomh9y/Hng73qwmg5F1Fj1GZq61ynoQMEXLforODRKzjFWcvrVhG/AcdT3JikZ20BT+gDf2MH2Forsw5OD6qsuIs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: de1b007f-50c6-4306-14d6-08d5b5b756d4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1b007f-50c6-4306-14d6-08d5b5b756d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 14:15:38.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file lives in the .git/objects/info directory.
Previously, a failure to acquire the commit-graph.lock file was
assumed to be due to the lack of the info directory, so a mkdir()
was called. This gave incorrect messaging if instead the lockfile
was open by another process:

  "fatal: cannot mkdir .git/objects/info: File exists"

Rearrange the expectations of this directory existing to avoid
this error, and instead show the typical message when a lockfile
already exists.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a8c337dd77..8399194da1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "dir.h"
 #include "git-compat-util.h"
 #include "lockfile.h"
 #include "pack.h"
@@ -640,13 +641,13 @@ void write_commit_graph(const char *obj_dir,
 	struct hashfile *f;
 	uint32_t i, count_distinct =3D 0;
 	char *graph_name;
-	int fd;
 	struct lock_file lk =3D LOCK_INIT;
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
 	int num_chunks;
 	int num_extra_edges;
 	struct commit_list *parent;
+	struct strbuf folder =3D STRBUF_INIT;
=20
 	oids.nr =3D 0;
 	oids.alloc =3D approximate_object_count() / 4;
@@ -754,23 +755,14 @@ void write_commit_graph(const char *obj_dir,
 	compute_generation_numbers(&commits);
=20
 	graph_name =3D get_commit_graph_filename(obj_dir);
-	fd =3D hold_lock_file_for_update(&lk, graph_name, 0);
=20
-	if (fd < 0) {
-		struct strbuf folder =3D STRBUF_INIT;
-		strbuf_addstr(&folder, graph_name);
-		strbuf_setlen(&folder, strrchr(folder.buf, '/') - folder.buf);
-
-		if (mkdir(folder.buf, 0777) < 0)
-			die_errno(_("cannot mkdir %s"), folder.buf);
-		strbuf_release(&folder);
-
-		fd =3D hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
-
-		if (fd < 0)
-			die_errno("unable to create '%s'", graph_name);
-	}
+	strbuf_addstr(&folder, graph_name);
+	strbuf_setlen(&folder, strrchr(folder.buf, '/') - folder.buf);
+	if (!file_exists(folder.buf) && mkdir(folder.buf, 0777) < 0)
+		die_errno(_("cannot mkdir %s"), folder.buf);
+	strbuf_release(&folder);
=20
+	hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
 	f =3D hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
=20
 	hashwrite_be32(f, GRAPH_SIGNATURE);
--=20
2.17.0.39.g685157f7fb

