Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D621F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbeDQRAl (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:41 -0400
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:22125
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754175AbeDQRAf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=v8743fTmDcaXpvUOwE9/99PAzAr1Mu04kMu/rIcwWJU=;
 b=LqhoR7m7EJBOZ1uKZEL3H32dRVX80YKJO5/peP+jBQCuiLyQRAuVVn/ivlJ7gruKvVvcH/slAs+5Furzd3jRy8sR9sxYh2gy6jNy2Xp5cP4PomZCkzdJriMf361NMolllRtjWIdXCZBYkfOx3VINsR+WPPANWFrOfaIbr8FheSQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:33 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:33 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 7/9] commit: add short-circuit to paint_down_to_common()
Thread-Topic: [PATCH v3 7/9] commit: add short-circuit to
 paint_down_to_common()
Thread-Index: AQHT1m2Y78diXoqY1UKgiQFj9253tg==
Date:   Tue, 17 Apr 2018 17:00:32 +0000
Message-ID: <20180417170001.138464-8-dstolee@microsoft.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
In-Reply-To: <20180417170001.138464-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:B6RkqEY7vw+PPyws+lZiRZITJgJjx/LD6Aja9HMvL9vkoRfBRPe99ONNI4Q2P4lkH+NBC0nGJ9ip1Pp3Y/suiPmYfRSteO9tvQ03c0XSuRv4RcqPwpYeVthP0XQ+dhwYh2mMgnX0T81G9C7nHUupxQBfH2cixcfrSn7S5wLBjPMYDZcltxiVGgveoKWb8aLquqQXDedDCL0y2/d7RJPZUOcn8/TqjEBe5c5o74qKVh1Kul4ByxRWHgKw3RhhSn9w;20:5+8B1yZJ+8341AtYi/tbU35NrT0TisquFRxb/y2KY2xA/9x0KSTGcu7+lbQ6H6d/c41TTOJsPPTOW1zl+OeOSOlrbePCOPdi7QCuq9LLcxodWrlULiwMKXG0TYOXxXk4biJ0h/h5YlkqlERt7MOg0ryk7dtQMtQakwJu8i6s8ns=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10749D7BA1E2D03284680DD6A1B70@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(102836004)(10090500001)(7416002)(6916009)(2906002)(99286004)(10290500003)(386003)(186003)(6506007)(86612001)(5640700003)(14454004)(5660300001)(8676002)(97736004)(3280700002)(105586002)(4326008)(52116002)(86362001)(486006)(8656006)(6116002)(2351001)(11346002)(476003)(106356001)(46003)(2616005)(2900100001)(316002)(36756003)(446003)(54906003)(2501003)(22452003)(478600001)(68736007)(25786009)(3660700001)(107886003)(39060400002)(6486002)(53936002)(305945005)(1730700003)(1076002)(6436002)(81156014)(8936002)(81166006)(6512007)(5250100002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qQnZGy314s+meS9ZxwnpNyztzkeXviAxCA1wcLjtrU5H9WrGZwbu621Nw8Wcsg+CnEeUnYN+/Mc3DzHYnfRh0Xwb1cumGDH47APh3O9UqxTWCgKezU1lA03N3p97zvrbQA9qfsaRop2fbT9UM2aO0YgvYk7oWe4eCPw44LnmNILwsmgL4qHtsQQOzBi568aT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 376a9562-5c4e-4b94-592b-08d5a484bb17
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376a9562-5c4e-4b94-592b-08d5a484bb17
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:32.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
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
index bceb79c419..a70f120878 100644
--- a/commit.c
+++ b/commit.c
@@ -805,11 +805,14 @@ static int queue_has_nonstale(struct prio_queue *queu=
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
@@ -828,6 +831,13 @@ static struct commit_list *paint_down_to_common(struct=
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
@@ -876,7 +886,7 @@ static struct commit_list *merge_bases_many(struct comm=
it *one, int n, struct co
 			return NULL;
 	}
=20
-	list =3D paint_down_to_common(one, n, twos);
+	list =3D paint_down_to_common(one, n, twos, 0);
=20
 	while (list) {
 		struct commit *commit =3D pop_commit(&list);
@@ -943,7 +953,7 @@ static int remove_redundant(struct commit **array, int =
cnt)
 			filled_index[filled] =3D j;
 			work[filled++] =3D array[j];
 		}
-		common =3D paint_down_to_common(array[i], filled, work);
+		common =3D paint_down_to_common(array[i], filled, work, 0);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] =3D 1;
 		for (j =3D 0; j < filled; j++)
@@ -1067,7 +1077,7 @@ int in_merge_bases_many(struct commit *commit, int nr=
_reference, struct commit *
 	if (commit->generation > min_generation)
 		return 0;
=20
-	bases =3D paint_down_to_common(commit, nr_reference, reference);
+	bases =3D paint_down_to_common(commit, nr_reference, reference, commit->g=
eneration);
 	if (commit->object.flags & PARENT2)
 		ret =3D 1;
 	clear_commit_marks(commit, all_flags);
--=20
2.17.0.39.g685157f7fb

