Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6901F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeDIQmS (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:42:18 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:18944
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753394AbeDIQmO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QiTACQ5t2ZHKcjNvBpzWvLHXslZ/mkzJgBTq0Gb1zq4=;
 b=CNy+UzU/Z6SrDHvB1oDD3vBmZWz9+w+UfxAyr+IrJCojU2+QgKJAe8++N79Lzb5GsFbvHOgkvxhuEySz1bLV0f8A4vTi1Uorx5KcyPzkXuiSW5N8MO2n7RWI4PgxvdVcHD8vRfqywwjbhh+xFJWUDkXive1oK5o5jgDDhYrs58w=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:42:12 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:42:12 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 10/10] commit: add short-circuit to paint_down_to_common()
Thread-Topic: [PATCH v2 10/10] commit: add short-circuit to
 paint_down_to_common()
Thread-Index: AQHT0CG1lcEaUyDstEeQI4o9ChewGA==
Date:   Mon, 9 Apr 2018 16:42:12 +0000
Message-ID: <20180409164131.37312-11-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:nz9iFvFiue1T2R56eS9K4PvBZ87HjrzfiuQd2vQG38EzUcPGflpj10a4dkb30HykhoUH/iVWBo2u7eEenPnbwSWXL6uFdOgEf9uKjsWaKj7xXM+THu4Sq/JJzyLM5Dv07NxNy4Zdde38cL7HXLP+FAMXKbINv79wz5KGjyPsUPMqDG8KUxO5bTkrtxoa067mHH8Na7fjQB23OeRmVGeYNU2+A2nPr3LVKh7Hg1YMNIJMZTd6YjTi57b0X5nEMVuM;20:T9A7MTyPyPVQEOJjnfiLBlQLM1Ig0eRHrzZklzRW15VSm757wXETUjquJZZTQKJqHT7+G4NMasIHnwzrJlPKtfetVmKYV0KD2bjskvOc4yTTspWXAGwqfVsGyMe+JpPvDttyJayl/g8vL3HfIBxVerZ3Mcnu6TW/7uUVqaP+htA=
X-MS-Office365-Filtering-Correlation-Id: b5711100-d5e6-4494-7930-08d59e38d817
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962E80F5E381B378E5BF570A1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VCp2GVcMYA9uBjIanc6OzAvKMj/6dvtxk1bpPEqSobIk7Rnyu7K1UBMFG0oB64Kb7Q9n1vr0/BtZNz8z5wGdUWmk8Ra5yMKB3thswCcnBdWtGgyA3l/s6qlDPQ6Aluy8Qa0BZRvOE3OrrodPtwAbaoWcPUfYn/tl6GGb48MQ8q26zvhvecuf5AyZbti2BrAclanMfz4ldXMT56WQgcJj9vxOpfmb+zSlzHeRUsl0NAyP623aV3kaxilJ9D0K/MXolsytyqtO8pB4pgjC3RMEDCLeXivzuU1M0oTSqonfEu7iIQvNMNcniMNRf35pBBwtx53YFAxMPKSGRky/AgFPLrfXx+6cBYdbjggLcDUNLvqm3nlKA4YUhd2CrWszZKlFurnEFn7l6HcZoB5xfbOjWnUIDe0EW/o/aPbR8J0GOTQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5711100-d5e6-4494-7930-08d59e38d817
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:42:12.7039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
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
 commit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 0b155dece8..7348075e38 100644
--- a/commit.c
+++ b/commit.c
@@ -796,7 +796,9 @@ static int queue_has_nonstale(struct prio_queue *queue,=
 uint32_t min_gen)
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
@@ -830,6 +832,9 @@ static struct commit_list *paint_down_to_common(struct =
commit *one, int n, struc
=20
 		last_gen =3D commit->generation;
=20
+		if (commit->generation < min_generation)
+			break;
+
 		flags =3D commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags =3D=3D (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
@@ -882,7 +887,7 @@ static struct commit_list *merge_bases_many(struct comm=
it *one, int n, struct co
 			return NULL;
 	}
=20
-	list =3D paint_down_to_common(one, n, twos);
+	list =3D paint_down_to_common(one, n, twos, 0);
=20
 	while (list) {
 		struct commit *commit =3D pop_commit(&list);
@@ -949,7 +954,7 @@ static int remove_redundant(struct commit **array, int =
cnt)
 			filled_index[filled] =3D j;
 			work[filled++] =3D array[j];
 		}
-		common =3D paint_down_to_common(array[i], filled, work);
+		common =3D paint_down_to_common(array[i], filled, work, 0);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] =3D 1;
 		for (j =3D 0; j < filled; j++)
@@ -1073,7 +1078,7 @@ int in_merge_bases_many(struct commit *commit, int nr=
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
2.17.0

