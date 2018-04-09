Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE4A1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbeDIQmO (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:42:14 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:16112
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753394AbeDIQmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mdQHB2V1gYpuQx3BrsKlR6phPFZ+4VGDtRJd/oG5zHQ=;
 b=htxut3QGCqIYOFaWBjbYS6CTqHAs8icJlONHs3/vOiVK8Pb1lxSOtNCy17XS6llG1GwIhw6TcqMooWLqziRo2RKvFijONbpALgIbxhfrR+NW7sCKZyFgBxsm+wXcg8qcl7QmdIs8vBbbgkZrxDgLioyn1XLlKiDEkm0XZvTlsXs=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:42:05 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:42:05 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 06/10] commit.c: use generation to halt paint walk
Thread-Topic: [PATCH v2 06/10] commit.c: use generation to halt paint walk
Thread-Index: AQHT0CGxULeHZ2xufk+jwQYF3eHu6w==
Date:   Mon, 9 Apr 2018 16:42:05 +0000
Message-ID: <20180409164131.37312-7-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:e59p7ary/7zC24VEzp/mchi16XArDNJ4vW0H6pfkDVcw17FUZMMF64UBe0AhxpLcioK4VFy/GjsNcM6TSkt84kADNj8T9FaQl799oss+9bUmpjA11qhcnauszXADVQspgZtcPun7Elv7F8J0c4fm6b3DpKVT3dHCcQQEUkl3iiRA6a0wpV8LicSXzasD6hF35RZu+bSpQttB+GQZmB8DweTY5ZVcGyb8dg5NsZ8gZkKOnOQsL/QLOBdSwTxy0WF2;20:FQ5AZhaJtqfqJ0KqomJ3B86Wxc+6Sk+l672s/QtqRVk/WO08ntuvJjMDRJGEQivvZTP/h/lcfyyV90Yr3Rjrg40bQGoht13pb8bgsnWpnNPMjcNxC50RRolYJoivEkO7blVHvhEsROyZFpvYJsADnxZZU+cavAOeMi8c03Z23DE=
X-MS-Office365-Filtering-Correlation-Id: cca9799b-6801-4f07-194d-08d59e38d3b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962D22920F10FEB79160086A1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(59450400001)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L46vE/5wor/Sw4OLCptoihS27+hxacanNmZWKgmDMh+QJAPjqCX9OHt5ID2PxwyRfDDMg/ahUXSckEbIKTRMfcl1Y9nE9Eh8x+84ajNNgkOP7ru/v1tIjFXbVRTkDATLI31aSfHZuPjnUgTYNzQy5hti6sFLB+03mtYGVRID/pXkKXFKM5viTaZRQ7QhLCV1reb+2E7zyV2ZpUpyMQkO7GejxuB6PI+kzSCA7HRbT6kSIrmqTc/fssn8DJ38qbFp3cj3+lyZwZ2gH3KIEmLlbONo5J4+HRGgk9QPKrOl6FAHTEHpI1QL3RH7YXmlWl1eSvcNqRy0y7C1FvzmM7wjN0H4C8dngJr0+cX2Mn0rQ2EeX93BE5rwdpDGYMGdPxgh9Pv8fF7mIyAEt9g2+h4gQevGI5KTx8fXXAVXYonevsk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca9799b-6801-4f07-194d-08d59e38d3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:42:05.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In paint_down_to_common(), the walk is halted when the queue contains
only stale commits. The queue_has_nonstale() method iterates over the
entire queue looking for a nonstale commit. In a wide commit graph where
the two sides share many commits in common, but have deep sets of
different commits, this method may inspect many elements before finding
a nonstale commit. In the worst case, this can give quadratic
performance in paint_down_to_common().

Convert queue_has_nonstale() to use generation numbers for an O(1)
termination condition. To properly take advantage of this condition,
track the minimum generation number of a commit that enters the queue
with nonstale status.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 95ae7e13a3..00bdc2ab21 100644
--- a/commit.c
+++ b/commit.c
@@ -776,14 +776,22 @@ void sort_in_topological_order(struct commit_list **l=
ist, enum rev_sort_order so
=20
 static const unsigned all_flags =3D (PARENT1 | PARENT2 | STALE | RESULT);
=20
-static int queue_has_nonstale(struct prio_queue *queue)
+static int queue_has_nonstale(struct prio_queue *queue, uint32_t min_gen)
 {
-	int i;
-	for (i =3D 0; i < queue->nr; i++) {
-		struct commit *commit =3D queue->array[i].data;
-		if (!(commit->object.flags & STALE))
-			return 1;
+	if (min_gen !=3D GENERATION_NUMBER_INFINITY) {
+		if (queue->nr > 0) {
+			struct commit *commit =3D queue->array[0].data;
+			return commit->generation >=3D min_gen;
+		}
+	} else {
+		int i;
+		for (i =3D 0; i < queue->nr; i++) {
+			struct commit *commit =3D queue->array[i].data;
+			if (!(commit->object.flags & STALE))
+				return 1;
+		}
 	}
+
 	return 0;
 }
=20
@@ -793,6 +801,8 @@ static struct commit_list *paint_down_to_common(struct =
commit *one, int n, struc
 	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result =3D NULL;
 	int i;
+	uint32_t last_gen =3D GENERATION_NUMBER_INFINITY;
+	uint32_t min_nonstale_gen =3D GENERATION_NUMBER_INFINITY;
=20
 	one->object.flags |=3D PARENT1;
 	if (!n) {
@@ -800,17 +810,26 @@ static struct commit_list *paint_down_to_common(struc=
t commit *one, int n, struc
 		return result;
 	}
 	prio_queue_put(&queue, one);
+	if (one->generation < min_nonstale_gen)
+		min_nonstale_gen =3D one->generation;
=20
 	for (i =3D 0; i < n; i++) {
 		twos[i]->object.flags |=3D PARENT2;
 		prio_queue_put(&queue, twos[i]);
+		if (twos[i]->generation < min_nonstale_gen)
+			min_nonstale_gen =3D twos[i]->generation;
 	}
=20
-	while (queue_has_nonstale(&queue)) {
+	while (queue_has_nonstale(&queue, min_nonstale_gen)) {
 		struct commit *commit =3D prio_queue_get(&queue);
 		struct commit_list *parents;
 		int flags;
=20
+		if (commit->generation > last_gen)
+			BUG("bad generation skip");
+
+		last_gen =3D commit->generation;
+
 		flags =3D commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags =3D=3D (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
@@ -830,6 +849,10 @@ static struct commit_list *paint_down_to_common(struct=
 commit *one, int n, struc
 				return NULL;
 			p->object.flags |=3D flags;
 			prio_queue_put(&queue, p);
+
+			if (!(flags & STALE) &&
+			    p->generation < min_nonstale_gen)
+				min_nonstale_gen =3D p->generation;
 		}
 	}
=20
--=20
2.17.0

