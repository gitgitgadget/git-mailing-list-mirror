Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4401215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755631AbeEAMrW (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:22 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:36448
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755480AbeEAMrU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=K55Mts1Y8GMqXnbCDbqnBVbr9NYmJW4HLLJENLiXGu4=;
 b=CVLeVrmCdJrgKNcBAsssW0HOEcJ5weIfmFmxczU6riSSKx2O/Xtqr5oCziaXhm56BgJ1uHmg4tWdIMV9heRYMc7iKdf7b+kmKOwvtkgu52CwbifUc2yVhVdwPcfQAeagOdYCt47ZHcakv3+k+BOaUCWJgrhPULGFzcg4OASKLjA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1042.namprd21.prod.outlook.com (52.132.24.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:17 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:17 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 07/11] commit: use generation numbers for in_merge_bases()
Thread-Topic: [PATCH v5 07/11] commit: use generation numbers for
 in_merge_bases()
Thread-Index: AQHT4UqJO15nGb5MIkiCFUcyT6aNbA==
Date:   Tue, 1 May 2018 12:47:17 +0000
Message-ID: <20180501124652.155781-8-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1042;7:KtWGqDMFNJpzHdxvvfMk+OHaclCwwuWheP8QPc31G3Mqhxlhr8SairK6imZRJqMDpyVIJBn5LWFL+JH1eRAvUrqWpkywExXaia+6AOZcNSYKytM173h7RE0VBuDUXf+uEHRRNu6tzEJHoNZmNogxxeTH61MYwe/kxOLpv1l2nrlpRJ5v+zhzLoYUoWMF1ova9SpOMaty/zc42GOkWGg0JV0YqXanPK4ynvPYq0LyQOHONA6RMkrH0JPQcWOiHo99;20:Oe6+ByRRUrNb80Xp1Ip8gHUM4qB/inQxeIZKiiCP0AxPS82xHI5untfWwGItfmQiHu0587TdbwwjmUKH0CsOKzdc+b/N9SbnEMjLsr17nypFJ9/7aJ/4fgXxuxfIMGNtRs4gx+2zHIOY95L0p8AS99uPKi1mP6Au6bjreTJwS/U=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1042;
x-ms-traffictypediagnostic: BL0PR2101MB1042:
x-microsoft-antispam-prvs: <BL0PR2101MB1042B06ADB553F61D497C8A2A1810@BL0PR2101MB1042.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1042;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1042;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(366004)(39860400002)(199004)(189003)(22452003)(86362001)(316002)(39060400002)(36756003)(5660300001)(8936002)(81156014)(6486002)(97736004)(68736007)(6116002)(10090500001)(11346002)(81166006)(5250100002)(2501003)(186003)(446003)(6512007)(1076002)(3660700001)(4326008)(10290500003)(3280700002)(46003)(6346003)(386003)(6506007)(478600001)(102836004)(105586002)(53936002)(25786009)(2616005)(2906002)(2900100001)(107886003)(486006)(305945005)(2351001)(54906003)(5640700003)(7736002)(86612001)(106356001)(1730700003)(14454004)(8676002)(6436002)(8656006)(476003)(99286004)(6916009)(52116002)(76176011)(59450400001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1042;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: J3JfQjBopUO3xKADrrHf52lMjVmM50PPvTvpnYgUMEuYMbmGjeaduW1OFEwHLRrUucyahSd7lLZUFmZWqzinKtfn1yGdSkd/7j30Nj7FmspWsDYqNhgsFF+S//k3iB/sC3oD5rmTBupCeAVHhC5J0KN8VrAD7yyAZpydU6K359qeX95eVP7w/LHdF0517inf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f8a0bdf5-6e9f-4b28-88a0-08d5af61abef
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a0bdf5-6e9f-4b28-88a0-08d5af61abef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:17.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1042
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
index 39a3749abd..3ecdc13356 100644
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
+		if (reference[i]->generation < min_generation)
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

