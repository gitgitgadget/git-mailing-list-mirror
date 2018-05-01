Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8E9215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755667AbeEAMr0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:26 -0400
Received: from mail-by2nam01on0137.outbound.protection.outlook.com ([104.47.34.137]:56576
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755580AbeEAMrW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7VhGK/ALMs0Y07uLEBYkZJNX0mGqW54yintVyEtzvNg=;
 b=YP9/1pHUhsdABGdYoCmSmeIdt8aX5pRXRlnJunHAeHYVAXkSCic+mOH4KjTVrEa7r3trxdig5oYXahda/w/SEwm22uRVjYZvnQ8XOCSN8I1tjOaCOJCT5OgFET7jxTbiPv2FTZ6kDTva5xMR8CEBuN/Pq/FGGqqvUR8ReL4NUEM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1042.namprd21.prod.outlook.com (52.132.24.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:20 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:20 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 08/11] commit: add short-circuit to paint_down_to_common()
Thread-Topic: [PATCH v5 08/11] commit: add short-circuit to
 paint_down_to_common()
Thread-Index: AQHT4UqK4qrpGhgJ70qbVFZQW9KT1g==
Date:   Tue, 1 May 2018 12:47:19 +0000
Message-ID: <20180501124652.155781-9-dstolee@microsoft.com>
References: <20180425143735.240183-1-dstolee@microsoft.com>
 <20180501124652.155781-1-dstolee@microsoft.com>
In-Reply-To: <20180501124652.155781-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:403:2::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1042;7:3+2Mxfpzeg0XLUtIJIIGXbJNXCtXrveyAHw3R7BmtlIeiWGEyKScr00GM29/JMh5fpyeSvgvopFzCaFBqV4CTL+5FqFH+k4n4eRyjssDCW+4t4zAeJ+9+fLEMzpFSB2IUOIqbO2hZ0Jvhw5n88U7j/ziMGOVBBHDL0h8ktoFqX5Uo7kqSTXxiNWedgpKos2VC+vjfEmOu5vh9XDvRTVLQ4rCe7CNWv7UeUCBbJ2En9zNqzY1MML+N6tYRxtPzuTs;20:lSitSeTsp1B3ryEPLol2jQ1zwBBHrW4B7HFwJUH9rF0PQ123nqJLFrtITh/cZNqFgM4y0jjHsbAYSTaDHqSNJm6fZ5IsE4XxvNm2Qa28e5HF5WHQcx6+0wHeoWtepEAYqdb46b3QMJzubQ4kYZRyZN4vMAmTPgovChq7uotEMv4=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1042;
x-ms-traffictypediagnostic: BL0PR2101MB1042:
x-microsoft-antispam-prvs: <BL0PR2101MB104277E17F8D1F0AF9F72D6FA1810@BL0PR2101MB1042.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1042;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1042;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(366004)(39860400002)(199004)(189003)(22452003)(86362001)(316002)(39060400002)(36756003)(5660300001)(8936002)(81156014)(6486002)(97736004)(68736007)(6116002)(10090500001)(11346002)(81166006)(5250100002)(2501003)(186003)(446003)(6512007)(1076002)(3660700001)(4326008)(10290500003)(3280700002)(46003)(6346003)(386003)(6506007)(478600001)(102836004)(105586002)(53936002)(25786009)(2616005)(2906002)(2900100001)(107886003)(486006)(305945005)(2351001)(54906003)(5640700003)(7736002)(86612001)(106356001)(1730700003)(14454004)(8676002)(6436002)(8656006)(476003)(99286004)(6916009)(52116002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1042;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: x/XOaP8sdB4yI4RF6RrZjF19vIWHqcBky4VQNnN9wv3qvwQWF0uwQRmP90RPBRJzfxLxS4tAxNWK0dK1UdvutSWVAJPd9xyGUOV0zS+mcfITNBBkQeMHzgcBP5/+/SPgf4rbicRiBUbqau6IrdxRZ6qW+L4JdMHilDc0Kl09l3vg5eYwBGDSBWbiGrhiq169
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e33c798a-eb9d-455a-a1e3-08d5af61ad2c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33c798a-eb9d-455a-a1e3-08d5af61ad2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:19.8615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1042
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
 commit.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 3ecdc13356..9875feec01 100644
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
@@ -831,6 +834,15 @@ static struct commit_list *paint_down_to_common(struct=
 commit *one, int n, struc
 		struct commit_list *parents;
 		int flags;
=20
+		if (commit->generation > last_gen)
+			BUG("bad generation skip %8x > %8x at %s",
+			    commit->generation, last_gen,
+			    oid_to_hex(&commit->object.oid));
+		last_gen =3D commit->generation;
+
+		if (commit->generation < min_generation)
+			break;
+
 		flags =3D commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags =3D=3D (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
@@ -879,7 +891,7 @@ static struct commit_list *merge_bases_many(struct comm=
it *one, int n, struct co
 			return NULL;
 	}
=20
-	list =3D paint_down_to_common(one, n, twos);
+	list =3D paint_down_to_common(one, n, twos, 0);
=20
 	while (list) {
 		struct commit *commit =3D pop_commit(&list);
@@ -946,7 +958,7 @@ static int remove_redundant(struct commit **array, int =
cnt)
 			filled_index[filled] =3D j;
 			work[filled++] =3D array[j];
 		}
-		common =3D paint_down_to_common(array[i], filled, work);
+		common =3D paint_down_to_common(array[i], filled, work, 0);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] =3D 1;
 		for (j =3D 0; j < filled; j++)
@@ -1070,7 +1082,7 @@ int in_merge_bases_many(struct commit *commit, int nr=
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

