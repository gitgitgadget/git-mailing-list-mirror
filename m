Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F01B1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDQSLF (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:11:05 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:9760
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752719AbeDQSKp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QVLVoLAC9SqY5nxxGepc1GfvPcwYgix0vbXsj8708LE=;
 b=MQkNXCM8I09NwMWdrOlcTvh0ZnJ+C6FLPsEKNe1i7044BHPGW5jrn65GX5yNV73hDDk07980Qi7Kfu1zalWtmtV+LcX0cLcVBrfKuKLYYKEPu38SIbA6g32bykN63I61oPCq0gCr+Aej0jrlMmLf8lXo9OnujqtMxiPLUgJX/Z0=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:43 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:43 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 08/12] commit-graph: verify commit contents against odb
Thread-Topic: [RFC PATCH 08/12] commit-graph: verify commit contents against
 odb
Thread-Index: AQHT1ndmHQKv+iALNU6pWB9vGFqqow==
Date:   Tue, 17 Apr 2018 18:10:43 +0000
Message-ID: <20180417181028.198397-9-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:Z1bs9mrTw8/+1I3Y/D8F9tpVqS19GWYWW3HNkB7O1IvJR9sCLI3tD/EaHv6retecuMhmNTqfy1G5zsyctA86KavYvF5Djy+LsEeJKXN3Cl0Zm+aKSz9DgAUGKof92O2Kg9hiuexhVuRhIyfn/ywv9k+0jC98eSyv8fuHm7kko61n9j3LCTBtAA7BWKDjpFdTCdZjx2CoXAStIgpx50bqG4BeedkedPcuT1gGj7oIBAklQgsOWUuGx9KdQJ6mOfQv;20:m0OUekiEeHWw7M5Y9Gt4nap0rIe3d6xZLRdmdiWV7MZfBmju526o1N00d7Ydj8d8RQD4tPHERmKAyN8A48N7uoyYvqxUQrF0JFWmYh7ROfN1+bymrS4ndiZ3Mg/0ecr6rQyXelqod+j1eT0MPC/OCQA2teks7Q8guk9V02aMFOw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09940976304BAB1E04BD065FA1B70@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(39380400002)(376002)(396003)(199004)(189003)(59450400001)(6506007)(386003)(102836004)(486006)(52116002)(316002)(106356001)(76176011)(54906003)(68736007)(7736002)(15650500001)(22452003)(2616005)(53936002)(46003)(99286004)(11346002)(476003)(305945005)(2501003)(186003)(86612001)(5250100002)(86362001)(6436002)(446003)(6116002)(6512007)(10090500001)(5640700003)(10290500003)(14454004)(25786009)(2351001)(4326008)(97736004)(2906002)(107886003)(5660300001)(478600001)(1076002)(2900100001)(8676002)(36756003)(8936002)(6916009)(81166006)(1730700003)(81156014)(105586002)(3280700002)(3660700001)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FUN1XLVmo+qxlZpYlWMrUTjtZyGHdKdj5acNl7V2ujASIcAGPYDjnvl5dkqA2l9fpHaLcfeWx/GqFpgrUAd/Ocm8dhWZhqfSDWTj5vgvTjdBN0rMJjwZGj0Iaj8Uf5bngDmlUqjrtUI+cJMm+RBf5y5TSbjcGku7h9R4QFLj6DaienVmrJdKjIA69HzCw4cb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6b14fee9-3b26-44ec-14fa-08d5a48e88c3
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b14fee9-3b26-44ec-14fa-08d5a48e88c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:43.4184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git commit-graph check', compare the contents of the
commits that are loaded from the commit-graph file with commits that are
loaded directly from the object database. This includes checking the
root tree object ID, commit date, and parents.

In addition, verify the generation number calculation is correct for all
commits in the commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 80a2ac2a6a..b5bce2bac4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -899,5 +899,87 @@ int check_commit_graph(struct commit_graph *g)
 				     graph_commit->graph_pos, i);
 	}
=20
+	for (i =3D 0; i < g->num_commits; i++) {
+		struct commit *graph_commit, *odb_commit;
+		struct commit_list *graph_parents, *odb_parents;
+		int num_parents =3D 0;
+
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		graph_commit =3D lookup_commit(&cur_oid);
+		odb_commit =3D (struct commit *)create_object(cur_oid.hash, alloc_commit=
_node());
+		if (parse_commit_internal(odb_commit, 0, 0))
+			graph_report(_("failed to parse %s from object database"), oid_to_hex(&=
cur_oid));
+
+		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
+			   get_commit_tree_oid(odb_commit)))
+			graph_report(_("root tree object ID for commit %s in commit-graph is %s=
 !=3D %s"),
+				     oid_to_hex(&cur_oid),
+				     oid_to_hex(get_commit_tree_oid(graph_commit)),
+				     oid_to_hex(get_commit_tree_oid(odb_commit)));
+
+		if (graph_commit->date !=3D odb_commit->date)
+			graph_report(_("commit date for commit %s in commit-graph is %"PRItime"=
 !=3D %"PRItime""),
+				     oid_to_hex(&cur_oid),
+				     graph_commit->date,
+				     odb_commit->date);
+
+
+		graph_parents =3D graph_commit->parents;
+		odb_parents =3D odb_commit->parents;
+
+		while (graph_parents) {
+			num_parents++;
+
+			if (odb_parents =3D=3D NULL)
+				graph_report(_("commit-graph parent list for commit %s is too long (%d=
)"),
+					     oid_to_hex(&cur_oid),
+					     num_parents);
+
+			if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object=
.oid))
+				graph_report(_("commit-graph parent for %s is %s !=3D %s"),
+					     oid_to_hex(&cur_oid),
+					     oid_to_hex(&graph_parents->item->object.oid),
+					     oid_to_hex(&odb_parents->item->object.oid));
+
+			graph_parents =3D graph_parents->next;
+			odb_parents =3D odb_parents->next;
+		}
+
+		if (odb_parents !=3D NULL)
+			graph_report(_("commit-graph parent list for commit %s terminates early=
"),
+				     oid_to_hex(&cur_oid));
+
+		if (graph_commit->generation) {
+			uint32_t max_generation =3D 0;
+			graph_parents =3D graph_commit->parents;
+
+			while (graph_parents) {
+				if (graph_parents->item->generation =3D=3D GENERATION_NUMBER_ZERO ||
+				    graph_parents->item->generation =3D=3D GENERATION_NUMBER_INFINITY)
+					graph_report(_("commit-graph has valid generation for %s but not its =
parent, %s"),
+						     oid_to_hex(&cur_oid),
+						     oid_to_hex(&graph_parents->item->object.oid));
+				if (graph_parents->item->generation > max_generation)
+					max_generation =3D graph_parents->item->generation;
+				graph_parents =3D graph_parents->next;
+			}
+
+			if (graph_commit->generation !=3D max_generation + 1)
+				graph_report(_("commit-graph has incorrect generation for %s"),
+					     oid_to_hex(&cur_oid));
+		} else {
+			graph_parents =3D graph_commit->parents;
+
+			while (graph_parents) {
+				if (graph_parents->item->generation)
+					graph_report(_("commit-graph has generation ZERO for %s but not its p=
arent, %s"),
+						     oid_to_hex(&cur_oid),
+						     oid_to_hex(&graph_parents->item->object.oid));
+				graph_parents =3D graph_parents->next;
+			}
+		}
+	}
+
 	return check_commit_graph_error;
 }
--=20
2.17.0.39.g685157f7fb

