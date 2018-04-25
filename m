Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12041F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeDYOiV (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:38:21 -0400
Received: from mail-bn3nam01on0132.outbound.protection.outlook.com ([104.47.33.132]:40160
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754365AbeDYOiH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AV4Mx+3LzMdzAHesMmYVJv0Jvx++bSluq0ozdFZBt68=;
 b=crxKwUnu3vmpi5uEwN2XzbWuiNQvMqTgufCs5uNuSMWhipwhM2iqtEynNs4Pp9q0I4eBAh41z+DFwJQYztrE98Iw7dMq4DjH28yUvlI6GKjMFqaSaBm4Tax9D3cTGthpXedIgy7yd1FmX8pMmFsEIVBIxo9818Ue7AM4YI1Ac3Q=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.5; Wed, 25 Apr 2018 14:38:01 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0735.006; Wed, 25 Apr 2018
 14:38:00 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 08/10] commit: add short-circuit to paint_down_to_common()
Thread-Topic: [PATCH v4 08/10] commit: add short-circuit to
 paint_down_to_common()
Thread-Index: AQHT3KMCSTHbPnGgXECcgC+vQcdq9g==
Date:   Wed, 25 Apr 2018 14:38:00 +0000
Message-ID: <20180425143735.240183-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1106;7:pK5spI4YLalnZbxpQfTYijuICw/vx/nOwxsL9GQaOA1TmDtf0h2ftAtUu25UB9kZUG5OQ5+Oagy61LDgW2Oe5XWygbOxzNvC2/esRjV6k0MciFmTZFlFvMiBpPnxjvRzJode0rATxR4gYDsXaLOkfD+W3nq1OWhWYtYNYnL56B4aK5UAK4u56gssP2wQQaEVZm1b/tFztS1AjacRSovhglGsFtsUSe5e8y7XKY94oq+8QCxMjA9WWTk6UbdRD1hg;20:egk5oAwBeZ/brtvG8aCgW4SGg4mijmC4P7gx9encbhI+POqVevKo6qJxUjzbMcUdcdtQVS35RKmFx3EVnexoBaH8+K0D6b+hjmTcPBrg0sFwLtU7MJdHpIPfxoTtI/NrEwUMDwGllawbb3jwRw2ah2uwVC0jYzKBFTEVUm8t5/M=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1106;
x-ms-traffictypediagnostic: BL0PR2101MB1106:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1106973F9BCD46DA9AB99250A18F0@BL0PR2101MB1106.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1106;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1106;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(106356001)(86612001)(25786009)(105586002)(39060400002)(22452003)(486006)(316002)(6512007)(186003)(8676002)(1730700003)(81166006)(305945005)(6486002)(97736004)(8936002)(5250100002)(14454004)(76176011)(81156014)(386003)(6506007)(7736002)(99286004)(6116002)(86362001)(36756003)(102836004)(478600001)(1076002)(3280700002)(8656006)(3660700001)(52116002)(10290500003)(5660300001)(46003)(2900100001)(107886003)(5640700003)(4326008)(6436002)(6916009)(2501003)(2351001)(68736007)(10090500001)(11346002)(54906003)(2906002)(446003)(53936002)(476003)(2616005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1106;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SK4WtD0K0Wdy0wLghBx5s4IpD8px619pSpvTk/s5IalfRsHbLFj626zRcBqf7FMAbEwDNdI90ATGmfIhhEPZleI/q0LfmWD0GvC8e2YihChvC4bACp2KC2gQEfB6nWXkutqswDii7LXrLICnfuYAwuawN4AiM3SOHWWkCtCNp8wdykUmoQY328XP2ky6biMJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f73d36f2-15ad-44d2-e4dd-08d5aaba24e5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73d36f2-15ad-44d2-e4dd-08d5aaba24e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 14:38:00.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git branch --contains', the in_merge_bases_many()
method calls paint_down_to_common() to discover if a specific
commit is reachable from a set of branches. Commits with lower
generation number are not needed to correctly answer the
containment query of in_merge_bases_many().

Add a new parameter, min_generation, to paint_down_to_common() that
prevents walking commits with generation number strictly less than
min_generation. If 0 is given, then there is no functional change.

For in_merge_bases_many(), we can pass commit->generation as the
cutoff, and this saves time during 'git branch --contains' queries
that would otherwise walk "around" the commit we are inspecting.

For a copy of the Linux repository, where HEAD is checked out at
v4.13~100, we get the following performance improvement for
'git branch --contains' over the previous commit:

Before: 0.21s
After:  0.13s
Rel %: -38%

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 7bb007f56a..e2e16ea1a7 100644
--- a/commit.c
+++ b/commit.c
@@ -808,11 +808,14 @@ static int queue_has_nonstale(struct prio_queue *queu=
e)
 }
=20
 /* all input commits in one and twos[] must have been parsed! */
-static struct commit_list *paint_down_to_common(struct commit *one, int n,=
 struct commit **twos)
+static struct commit_list *paint_down_to_common(struct commit *one, int n,
+						struct commit **twos,
+						int min_generation)
 {
 	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result =3D NULL;
 	int i;
+	uint32_t last_gen =3D GENERATION_NUMBER_INFINITY;
=20
 	one->object.flags |=3D PARENT1;
 	if (!n) {
@@ -831,6 +834,13 @@ static struct commit_list *paint_down_to_common(struct=
 commit *one, int n, struc
 		struct commit_list *parents;
 		int flags;
=20
+		if (commit->generation > last_gen)
+			BUG("bad generation skip");
+		last_gen =3D commit->generation;
+
+		if (commit->generation < min_generation)
+			break;
+
 		flags =3D commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags =3D=3D (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
@@ -879,7 +889,7 @@ static struct commit_list *merge_bases_many(struct comm=
it *one, int n, struct co
 			return NULL;
 	}
=20
-	list =3D paint_down_to_common(one, n, twos);
+	list =3D paint_down_to_common(one, n, twos, 0);
=20
 	while (list) {
 		struct commit *commit =3D pop_commit(&list);
@@ -946,7 +956,7 @@ static int remove_redundant(struct commit **array, int =
cnt)
 			filled_index[filled] =3D j;
 			work[filled++] =3D array[j];
 		}
-		common =3D paint_down_to_common(array[i], filled, work);
+		common =3D paint_down_to_common(array[i], filled, work, 0);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] =3D 1;
 		for (j =3D 0; j < filled; j++)
@@ -1070,7 +1080,7 @@ int in_merge_bases_many(struct commit *commit, int nr=
_reference, struct commit *
 	if (commit->generation > min_generation)
 		return ret;
=20
-	bases =3D paint_down_to_common(commit, nr_reference, reference);
+	bases =3D paint_down_to_common(commit, nr_reference, reference, commit->g=
eneration);
 	if (commit->object.flags & PARENT2)
 		ret =3D 1;
 	clear_commit_marks(commit, all_flags);
--=20
2.17.0.39.g685157f7fb

