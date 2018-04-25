Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DF81F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754594AbeDYOiI (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:38:08 -0400
Received: from mail-dm3nam03on0131.outbound.protection.outlook.com ([104.47.41.131]:31697
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754074AbeDYOh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FPs2jcL38QbZ+3nMUJjujkUopMPt0GFefCxh6Stfu7I=;
 b=CoT/Xg3dJFqc+RbSr+t7K5HqOhDp9Vic9NRkS9j9H4y6rJKiw+zgU1KiKF+qynoFbSmvO/+G9qk/JL914x9ytkBHHz6f3sVn8Q49EPYRDZG3ZJojGEJl7S1O02HKMk752aPqpW/z2pE32n1PnByxN/w1FLw/4YQ/IafB9R9aBss=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0899.namprd21.prod.outlook.com (52.132.23.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.3; Wed, 25 Apr 2018 14:37:56 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0735.006; Wed, 25 Apr 2018
 14:37:56 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 03/10] commit-graph: compute generation numbers
Thread-Topic: [PATCH v4 03/10] commit-graph: compute generation numbers
Thread-Index: AQHT3KMApLXJ/saaPkGdTK8w6bSnqQ==
Date:   Wed, 25 Apr 2018 14:37:56 +0000
Message-ID: <20180425143735.240183-4-dstolee@microsoft.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
In-Reply-To: <20180425143735.240183-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR12CA0040.namprd12.prod.outlook.com
 (2603:10b6:405:70::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0899;7:HuI+3pXqddI8iKNO2rKltylIq73Ajsz4k8159E/6CCnFK2PvfnQZoN29GaICZh9ZwwkMzarUe4kfLeXkGsL+wgwXj52Dw7GAUqhnYJzB2Fwy2EkFMquhb36ntNosgNpkf6O2rD3gMii0WQz9fexKQIPw9WRi5fM64GU6E0IiJiw7FUWwR813w4Hi/muJxpqQaJRzW/1EZCsJBtX1EbkqrHoGDTKlXe/pE4I9BA5hHojRrQQY8rsmuUD/L56AKtx/;20:FBOHAT+O6eTEg7cVEj9QNUSaq1WI+V3yWmiDWa0vNcTqisfb7uMrh6NeYET0vmRVssVSa1eSTMubqfOk5adwRt0ujuoRUJyTmebFOo8UPxhj9/ehaXpk91Izs6u59INyP6DjTkRpeCV2tsqLocMteVgrZJUkFFv2QBVEUmIyggs=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0899;
x-ms-traffictypediagnostic: BL0PR2101MB0899:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0899D51491AAFB90437AA617A18F0@BL0PR2101MB0899.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0899;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0899;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(39380400002)(376002)(366004)(396003)(189003)(199004)(6116002)(54906003)(1076002)(7736002)(22452003)(6512007)(25786009)(186003)(316002)(52116002)(478600001)(53936002)(99286004)(8656006)(5640700003)(46003)(107886003)(39060400002)(5250100002)(2501003)(305945005)(68736007)(14454004)(4326008)(5660300001)(10090500001)(2900100001)(10290500003)(36756003)(86362001)(97736004)(8936002)(6486002)(86612001)(6436002)(3280700002)(2351001)(6916009)(105586002)(11346002)(81166006)(8676002)(1730700003)(2616005)(102836004)(486006)(476003)(6506007)(59450400001)(76176011)(446003)(386003)(81156014)(2906002)(106356001)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0899;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D7Wss/uTPTvKJSTeEdPjLDC4z5MJ5KGljX8FDErvo0fkKM6DW2qhS5v7I97UocprC3BOD4+Vrhle83IU5pC0+hoSgWBxwkq6MoliKYLaHORq4Oev3DtcdO//lrwKOQHIkP0qxgudnxDC2K2SsnpteLYkDIECtJsANDhfvBVTNsJjas7cYu+lfjR+cNcOQGeB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: acd7f2fe-b56b-4f5f-ef4c-08d5aaba225c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd7f2fe-b56b-4f5f-ef4c-08d5aaba225c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 14:37:56.4981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0899
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While preparing commits to be written into a commit-graph file, compute
the generation numbers using a depth-first strategy.

The only commits that are walked in this depth-first search are those
without a precomputed generation number. Thus, computation time will be
relative to the number of new commits to the commit-graph file.

If a computed generation number would exceed GENERATION_NUMBER_MAX, then
use GENERATION_NUMBER_MAX instead.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 9ad21c3ffb..047fa9fca5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -439,6 +439,9 @@ static void write_graph_chunk_data(struct hashfile *f, =
int hash_len,
 		else
 			packedDate[0] =3D 0;
=20
+		if ((*list)->generation !=3D GENERATION_NUMBER_INFINITY)
+			packedDate[0] |=3D htonl((*list)->generation << 2);
+
 		packedDate[1] =3D htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
=20
@@ -571,6 +574,46 @@ static void close_reachable(struct packed_oid_list *oi=
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
+
+			if (current->generation > GENERATION_NUMBER_MAX)
+				current->generation =3D GENERATION_NUMBER_MAX;
+		}
+	}
+}
+
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
@@ -694,6 +737,8 @@ void write_commit_graph(const char *obj_dir,
 	if (commits.nr >=3D GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
=20
+	compute_generation_numbers(commits.list, commits.nr);
+
 	graph_name =3D get_commit_graph_filename(obj_dir);
 	fd =3D hold_lock_file_for_update(&lk, graph_name, 0);
=20
--=20
2.17.0.39.g685157f7fb

