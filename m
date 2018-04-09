Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130AA1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeDIQmF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:42:05 -0400
Received: from mail-sn1nam02on0116.outbound.protection.outlook.com ([104.47.36.116]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753394AbeDIQmD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=86gB3X9UiohGW9g+RvLp1UWLwmSrqQJAw+830sb/U08=;
 b=QOFzBB4v4McmsJ9EiiwIth7csVGgIzbtQgOuIvFZ/ZSeZO+L/bJzRxFmDWs87XiLgMnQYxlTMNrEhZmsaUM+VTi5yjS+KS1lY9Ck/kGUx0lSdQa/YncU184tVglGEeHO7q0mPxK0cAOit9f0JuxSYrKFyKrMlr9lEP6EPe5ZYz8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:42:02 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:42:02 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 04/10] commit-graph: compute generation numbers
Thread-Topic: [PATCH v2 04/10] commit-graph: compute generation numbers
Thread-Index: AQHT0CGv321vDHPT4UGOPWs2TLOnow==
Date:   Mon, 9 Apr 2018 16:42:01 +0000
Message-ID: <20180409164131.37312-5-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
In-Reply-To: <20180409164131.37312-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:903:99::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:gYWiD3DQYLfjnVnJ3reId0EaUwJCVbvbscNa/alvdgkQkrIB5VGw6xNzgCCWsb72K8/R3UgujSB5pWU9zQH8Wrnjz3CNW52oH/qK/PmUDX+KKHNQRkV1KRS+LxTT7TAh2ID9a/onz4PWi6tGR7WWQBAAoHFzhWbm7ZScgZKi7ORk9e0yzrsXfBPbOO5rvgXQFBlIjSpdwu5F7CmF3c2n2iWoX6iYHtkNbvRzuNlEh3jSK9dSCE6DDVBaQjza3VTQ;20:5cSSJ+iXQb83NQ3Fz5xJ6gB1RiMgpsQUOttqUs2WpxBFYC7XcGN/8kpFCwrupWwNDFVnwp5AudYe+CwJiaJ90zGbF/utuaHBNl/eT8qznOVzM1vjlj1eo/8YG4PchYVYkuraEnaLFphkx248qierqiqiIIRXzI7X0kgfW59uTp0=
X-MS-Office365-Filtering-Correlation-Id: 03ae0644-65c7-449b-575a-08d59e38d1aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962EA37B8FE9CE81619A341A1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(59450400001)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lcWvM8CK+oz7Y8wLo9u/atwK3yN/Tw8HW7TOy/KXjiC7Hv6cPrKmtWv6XhsT3+MckgfBXsrRs4Imrr0vMRdyurdHbGRZOfaP1/U+8w1ui+bCsqHR5XsCPn03VqtXJMIY0fkXxcwFYisE5oWLcJV+SiTgdJncvVKoQ7MMQT72XnzrravN+bIhunsYJl+FUbzyJ8riLnAFVWAx3kjjfZWOP2jE8wkEIJmPSUCNC49Ecy2EbP+XhSWDTZNUIeEu6UiwluVo4HhpGdYHvAZCQZH5UYBUNiEuJPE7ETLD7ATwYp+t9PFJQZOsi64dV8Y9jJHxeq6amT7fd+Alt0/fQhhnB4Ml/wgBeARQi8aD1Wz48qeqFixKicHt6jXGX8e+SSijPvFb6vlbtvdu4og2aXDGw5sMEuQYOu/2QHhtB1v+hBw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ae0644-65c7-449b-575a-08d59e38d1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:42:01.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While preparing commits to be written into a commit-graph file, compute
the generation numbers using a depth-first strategy.

The only commits that are walked in this depth-first search are those
without a precomputed generation number. Thus, computation time will be
relative to the number of new commits to the commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index d24b947525..5fd63acc31 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -419,6 +419,13 @@ static void write_graph_chunk_data(struct hashfile *f,=
 int hash_len,
 		else
 			packedDate[0] =3D 0;
=20
+		if ((*list)->generation !=3D GENERATION_NUMBER_INFINITY) {
+			if ((*list)->generation > GENERATION_NUMBER_MAX)
+				die("generation number %u is too large to store in commit-graph",
+				    (*list)->generation);
+			packedDate[0] |=3D htonl((*list)->generation << 2);
+		}
+
 		packedDate[1] =3D htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
=20
@@ -551,6 +558,43 @@ static void close_reachable(struct packed_oid_list *oi=
ds)
 	}
 }
=20
+static void compute_generation_numbers(struct commit** commits,
+				       int nr_commits)
+{
+	int i;
+	struct commit_list *list =3D NULL;
+
+	for (i =3D 0; i < nr_commits; i++) {
+		if (commits[i]->generation !=3D GENERATION_NUMBER_INFINITY &&
+		    commits[i]->generation !=3D GENERATION_NUMBER_ZERO)
+			continue;
+
+		commit_list_insert(commits[i], &list);
+		while (list) {
+			struct commit *current =3D list->item;
+			struct commit_list *parent;
+			int all_parents_computed =3D 1;
+			uint32_t max_generation =3D 0;
+
+			for (parent =3D current->parents; parent; parent =3D parent->next) {
+				if (parent->item->generation =3D=3D GENERATION_NUMBER_INFINITY ||
+				    parent->item->generation =3D=3D GENERATION_NUMBER_ZERO) {
+					all_parents_computed =3D 0;
+					commit_list_insert(parent->item, &list);
+					break;
+				} else if (parent->item->generation > max_generation) {
+					max_generation =3D parent->item->generation;
+				}
+			}
+
+			if (all_parents_computed) {
+				current->generation =3D max_generation + 1;
+				pop_commit(&list);
+			}
+		}
+	}
+}
+
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
@@ -674,6 +718,8 @@ void write_commit_graph(const char *obj_dir,
 	if (commits.nr >=3D GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
=20
+	compute_generation_numbers(commits.list, commits.nr);
+
 	graph_name =3D get_commit_graph_filename(obj_dir);
 	fd =3D hold_lock_file_for_update(&lk, graph_name, 0);
=20
--=20
2.17.0

