Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70901F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeDYOiM (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:38:12 -0400
Received: from mail-sn1nam02on0136.outbound.protection.outlook.com ([104.47.36.136]:41056
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754534AbeDYOiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eqlX6S+Zi3aVLHWgVdl5biD51ZNcd4VSGsHfKUjIa4M=;
 b=OqG+XtXlGGcXZ5zKlIP5DNj0XMhaBQlGbsuTKJ49I5AS6tKzECAoGCaWhiq7tkk1UPOoSpa2NXB0V1q4MHfRljdcGhjYucT4LWGYQPbyOalbYehTE5P+3e+qVrMz+vZbicyHMft9D3vtZ2P4kHN1zd35bKWgaWaNmsEsO8QeMXw=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0899.namprd21.prod.outlook.com (52.132.23.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.3; Wed, 25 Apr 2018 14:38:00 +0000
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
Subject: [PATCH v4 07/10] commit: use generation numbers for in_merge_bases()
Thread-Topic: [PATCH v4 07/10] commit: use generation numbers for
 in_merge_bases()
Thread-Index: AQHT3KMC3kWy6826iUC8b+SdMiE6Xw==
Date:   Wed, 25 Apr 2018 14:37:59 +0000
Message-ID: <20180425143735.240183-8-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0899;7:l84ETdgX6lJyFBKaUdw5s7GqOtvJwJqN77H2jL022H4DS1Rmy16VMHcH8CPp6zaOazqLt02j1ijacwN90jD2SbzoKpK005VPjJM4noe6OhHN+9RUzVu2UO/YNk8IEheA/j+XL9z2kdhZqiwt5fHMh5NItEUTeOSudGFbIPSF1dwN5rEJxNtrRwS21FWiei7ztnhwhOAk+Ub9Lu3AvVW0/VqK6dTSTWSph0vKspYwQBBQqeH7id6qMJ0xlgod303c;20:VmA8MI/N5q/PDJLQ/UTmHhoDTvf09DouS6xpaSlfIXmz7UZet0naJg7kJSpmBdE17i1rITCAPDWGlUftuqz9l0IfafdwUR1RFtHqFSRZaTrT23V2VtLOlu9w1o2ymmNgmGxg24yVeZxnPYKDDaHKpDR7BGAPFolXDP3UEFbxkWI=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0899;
x-ms-traffictypediagnostic: BL0PR2101MB0899:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0899373561CA42A7D616DFF3A18F0@BL0PR2101MB0899.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0899;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0899;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(39380400002)(376002)(366004)(396003)(189003)(199004)(6116002)(54906003)(1076002)(7736002)(22452003)(6512007)(25786009)(186003)(316002)(52116002)(478600001)(53936002)(99286004)(8656006)(5640700003)(46003)(107886003)(39060400002)(5250100002)(2501003)(305945005)(68736007)(14454004)(4326008)(5660300001)(10090500001)(2900100001)(10290500003)(36756003)(86362001)(97736004)(8936002)(6486002)(86612001)(6436002)(3280700002)(2351001)(6916009)(105586002)(11346002)(81166006)(8676002)(1730700003)(2616005)(102836004)(486006)(476003)(6506007)(59450400001)(76176011)(446003)(386003)(81156014)(2906002)(106356001)(3660700001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0899;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qN4xY90VhPHVyZZWddlgNHo6gvFBOTGZ7eFvDH0af1O4ik+gLX+KDr93t8d1qJA3cWUkgb0Hwe1+EUlDENWyBr9Mk2tN2t0YxMQXp8kmHVIT9Kh/1nkq79Q25e1Va2uP3hbIAkTHRfm1orBJYrYv8Xi/TLgAiH0YifVTH8N2us/+ZjqIatA0ETiHiDiuuEfE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a4481d17-0969-4f78-6ff8-08d5aaba2460
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4481d17-0969-4f78-6ff8-08d5aaba2460
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 14:37:59.8745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0899
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The containment algorithm for 'git branch --contains' is different
from that for 'git tag --contains' in that it uses is_descendant_of()
instead of contains_tag_algo(). The expensive portion of the branch
algorithm is computing merge bases.

When a commit-graph file exists with generation numbers computed,
we can avoid this merge-base calculation when the target commit has
a larger generation number than the initial commits.

Performance tests were run on a copy of the Linux repository where
HEAD is contained in v4.13 but no earlier tag. Also, all tags were
copied to branches and 'git branch --contains' was tested:

Before: 60.0s
After:   0.4s
Rel %: -99.3%

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 39a3749abd..7bb007f56a 100644
--- a/commit.c
+++ b/commit.c
@@ -1056,12 +1056,19 @@ int in_merge_bases_many(struct commit *commit, int =
nr_reference, struct commit *
 {
 	struct commit_list *bases;
 	int ret =3D 0, i;
+	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
=20
 	if (parse_commit(commit))
 		return ret;
-	for (i =3D 0; i < nr_reference; i++)
+	for (i =3D 0; i < nr_reference; i++) {
 		if (parse_commit(reference[i]))
 			return ret;
+		if (min_generation > reference[i]->generation)
+			min_generation =3D reference[i]->generation;
+	}
+
+	if (commit->generation > min_generation)
+		return ret;
=20
 	bases =3D paint_down_to_common(commit, nr_reference, reference);
 	if (commit->object.flags & PARENT2)
--=20
2.17.0.39.g685157f7fb

