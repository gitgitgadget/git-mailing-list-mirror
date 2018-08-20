Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20381F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeHTVnC (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:43:02 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:36896
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbeHTVnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl00M5VJvLL26v+wIKGqKDpMinQ1eO3+fPIlRPwMOXA=;
 b=gfGd6uMm054dI5xfUi3gRcfFnBaFmcgpjcHeyLOlj+IoE+hcaLNg49oBnSAsf983IjfueMzuN1Bm5kP38ngYYoSqbRj+E4QORSqFNG5YXG+LmviI6KuWUJQYJ1lubPht8kJkn/G7zLfgEYS+0o95uVl8cIHAGKaC8vjuLu2G2r0=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.2; Mon, 20 Aug 2018 18:24:36 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 18:24:36 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 8/8] commit-graph: close_commit_graph before shallow walk
Thread-Topic: [PATCH v2 8/8] commit-graph: close_commit_graph before shallow
 walk
Thread-Index: AQHUOLMLlpdPUXYb9kCFCL2GC0ATQA==
Date:   Mon, 20 Aug 2018 18:24:34 +0000
Message-ID: <20180820182359.165929-9-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
In-Reply-To: <20180820182359.165929-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:1DM8rVmeD9lqes5WRn2nQ122Ohl5z3HVdSbL94u9lt8x1LVVTVnh/s89Mj/E2YzahpZolWqXCEA6IFbXT8Xb1GH7Ia+pWCgz8kRVVbxaj0mdkMkeG/p2C4Np8bgakEPEWLZcU4rGDCm5T6ry9MEC6JYQdDN2YoLbvLuZUXbnjOwbgt3AIllpc3wwvM/yN+qpB8CSV+3UEMvQQ0MfuPg8R7f70xZbVav64jpeOeSg3RfVPusIQDTmBmJEMf5eZVh0zWiOTza5xBX31O0Tyl1M9pT//I8bKERO4uuKk9reTBiLU8WEIBPtfRPa1ELfK9jiVRv9esHBthqTlHN3ASAxg2NN+odCFaW32LJ1d7OjnsDKkyUaPy7rhi28lrDoHDTHWOFaDybYWaaM9xCKdzn+0d8+5C4sj4hBuuWdaZ4oToUsAfeHFBcZiZUSTjxpP1PkohE/US6LdZ1ganPe/SA25g==;5:tIgnsd1g/xSIPPFFAAZVZy+OJXOtpJeC2+kbwtSYnorJ9IOXjgdlKkbbIfdRSOP75+ImHoE6mTsSwF3TR7t7UGoMe3KTQp9rnXQZfMBMODzPq+xN7hMUzNn6+heaeZUyirenEfld3X2ynbPa3IsCWcAgFQdqOvuiHN1gA6UscGY=;7:Oco8cPD94EuO1NHSqnFaAqadiLU6GImuhIrZ9iRT4emsXJyJRYkumrVXq/NbLC2duRj+x9lF2aIF2Zq9zlm5u6io6WHuMAdnsCvfkoMwR8AxxvD5mWt3bFqaHcVIaDFcYSLS3dh/ejWYjPCsPZust0drmz025VM9IKIlBDSKoJC+I9heZFHG8JR+fTlXxQDV3bi6qkQewvbaBPMJkD3lTL8QyJUs+QbHV4mE/8eaVJQpNiKSiN29KmSj9kmgYtoa
x-ms-office365-filtering-correlation-id: 8f81081e-67f0-4374-414d-08d606ca2e05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
x-microsoft-antispam-prvs: <BL0PR2101MB092949AD6FC7EDD56F62D51AA1320@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231336)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(5660300001)(2501003)(305945005)(6916009)(256004)(86612001)(6486002)(14444005)(14454004)(86362001)(4326008)(25786009)(1730700003)(8676002)(22452003)(81156014)(39060400002)(107886003)(316002)(76176011)(7736002)(99286004)(52116002)(54906003)(81166006)(5250100002)(478600001)(386003)(186003)(46003)(6506007)(102836004)(6436002)(97736004)(10290500003)(6116002)(68736007)(106356001)(53936002)(1076002)(105586002)(5640700003)(10090500001)(2906002)(2900100001)(36756003)(8936002)(2351001)(446003)(6512007)(6346003)(476003)(2616005)(486006)(11346002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: rND87D67j/yF7yP9DILmnPvEk7+rkKhsw7mdbyFArB/3UId7bS6g3+CwxYm3dMTs1kikJv0XEQ8ms4bHNBKW0nKNb1ovxXa1awTMb59vGAvGuNdmEZfY/hub5GZygRQxOpMpE8JsW3FcHDvO/fC4ITMZEFFSnUnYGzlt5gcstayqvgoOPRx4EKs325TEYIKBVlhVxLXB+irO94vXxQxyHvOcR38utusFf4cVheI5UTyZfxgC55E1BWHSYIeX5TxlHu0RB5w5VHtN5+cU36w2ZWPU7N45zp536PY/1wYsMKdB/p67J3gIMIZxGr6tvMSy3Rtw4swfX8zdHLO3lku+fprvUe5f7nzpV173eVfx/gk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f81081e-67f0-4374-414d-08d606ca2e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 18:24:34.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call close_commit_graph() when about to start a rev-list walk that
includes shallow commits. This is necessary in code paths that "fake"
shallow commits for the sake of fetch. Specifically, test 351 in
t5500-fetch-pack.sh runs

	git fetch --shallow-exclude one origin

with a file-based transfer. When the "remote" has a commit-graph, we do
not prevent the commit-graph from being loaded, but then the commits are
intended to be dynamically transferred into shallow commits during
get_shallow_commits_by_rev_list(). By closing the commit-graph before
this call, we prevent this interaction.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 8 ++++----
 commit-graph.h | 1 +
 upload-pack.c  | 2 ++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index cee2caab5c..4bd1a4abbf 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -260,10 +260,10 @@ static int prepare_commit_graph(struct repository *r)
 	return !!r->objects->commit_graph;
 }
=20
-static void close_commit_graph(void)
+void close_commit_graph(struct repository *r)
 {
-	free_commit_graph(the_repository->objects->commit_graph);
-	the_repository->objects->commit_graph =3D NULL;
+	free_commit_graph(r->objects->commit_graph);
+	r->objects->commit_graph =3D NULL;
 }
=20
 static int bsearch_graph(struct commit_graph *g, struct object_id *oid, ui=
nt32_t *pos)
@@ -875,7 +875,7 @@ void write_commit_graph(const char *obj_dir,
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_large_edges(f, commits.list, commits.nr);
=20
-	close_commit_graph();
+	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
=20
diff --git a/commit-graph.h b/commit-graph.h
index 76e098934a..13d736cdde 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -59,6 +59,7 @@ void write_commit_graph(const char *obj_dir,
=20
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
=20
+void close_commit_graph(struct repository *);
 void free_commit_graph(struct commit_graph *);
=20
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 82b393ec31..2ae9d9bb47 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -24,6 +24,7 @@
 #include "quote.h"
 #include "upload-pack.h"
 #include "serve.h"
+#include "commit-graph.h"
=20
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -740,6 +741,7 @@ static void deepen_by_rev_list(int ac, const char **av,
 {
 	struct commit_list *result;
=20
+	close_commit_graph(the_repository);
 	result =3D get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
 	send_shallow(result);
 	free_commit_list(result);
--=20
2.18.0.118.gd4f65b8d14

