Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A57F1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754614AbeDYOiN (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:38:13 -0400
Received: from mail-bn3nam01on0132.outbound.protection.outlook.com ([104.47.33.132]:40160
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754562AbeDYOiC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3Zh9XfoGqpVW4Hdmo2E9qAPsfxxj7zwlz+5pbNry9rY=;
 b=dZPMwMf+PAuX3XT9HHcyprPPC6NEIuNBAD1B2r294wvoXfy7dlmxt3skBhyG/Aih9hw2qU2ZKYj2GVq7oAKxyTPbHPc5N+0/vHn/RGEShsQnwfzLP5Mb/sDpP95SI8JOybC/IY3Rgck0V7nrJlr2KuCnVm0L1v8g9iaqjErvS44=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.5; Wed, 25 Apr 2018 14:37:59 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0735.006; Wed, 25 Apr 2018
 14:37:59 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 06/10] ref-filter: use generation number for --contains
Thread-Topic: [PATCH v4 06/10] ref-filter: use generation number for
 --contains
Thread-Index: AQHT3KMBc2PYYwL9WEeZR+njYi4qnQ==
Date:   Wed, 25 Apr 2018 14:37:58 +0000
Message-ID: <20180425143735.240183-7-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1106;7:FolfWXHv/zdgd3R48aTKioXHt99gn1CjYQXqDP/twtKxnrLZlvJUUDJAOPvDp/aPERXJ8TIvcf3i8a6Cz2R8NKR6cpCNgQ33zAWnKqndQUKNkvpRcUpnAzkxnubCzZseW/LFYV/dn7CiONrl7HminTmM0Cy9pCZevJ6qx0sqAQtR4DyF4CQ8utS5BO/cVjhmTLO4RyA0fqwoTtDbF0IinvG2oFH73TjUoT7PmKJY9Y8dTtxCknMW+uC4PJqzGF+1;20:Cx6S7hbW4Riy2SN76thn2HRLr1AUz6dsON/nRZzBw7Dam4qHzo8R2/O6mgZ0Ww3Vdy/122BN0cBtNCPysKRf2H5bsk8u97GbHI2Qzx+Byy3rnTCrJZ/RP9/ksg5djP0Kou+CfGD3CSyZTCvaBfkZPeQtsyEoq98RNdz9FQAkfRo=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1106;
x-ms-traffictypediagnostic: BL0PR2101MB1106:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1106983136A619482498681FA18F0@BL0PR2101MB1106.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1106;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1106;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(106356001)(86612001)(25786009)(105586002)(39060400002)(22452003)(486006)(316002)(6512007)(186003)(8676002)(1730700003)(81166006)(305945005)(6486002)(97736004)(8936002)(5250100002)(14454004)(76176011)(81156014)(386003)(6506007)(7736002)(99286004)(6116002)(86362001)(36756003)(102836004)(478600001)(1076002)(3280700002)(8656006)(3660700001)(52116002)(10290500003)(5660300001)(46003)(2900100001)(107886003)(5640700003)(4326008)(6436002)(6916009)(2501003)(2351001)(68736007)(10090500001)(11346002)(54906003)(2906002)(446003)(53936002)(476003)(2616005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1106;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fJw1SZJUgn92KfZ0aOsDfeRl0RJgFtJgSoJOE1ZHTUGpSYdmD2BhJTvQhw7xzhebVA6Jp0jmZ8w7w2funh19KOWsVrCF8XSFTsA55yJ2WfZSGhDpy5o1zCp4qPnkeis/k9WuOIw8Il4LIMpWJ2SnLKVLPpOtVo0BFOwG3NYUP+Q0/aQUt0ZItAlT1DTxLGuJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3d4359f6-41fb-44cb-4b9f-08d5aaba23e4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4359f6-41fb-44cb-4b9f-08d5aaba23e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 14:37:59.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A commit A can reach a commit B only if the generation number of A
is strictly larger than the generation number of B. This condition
allows significantly short-circuiting commit-graph walks.

Use generation number for '--contains' type queries.

On a copy of the Linux repository where HEAD is containd in v4.13
but no earlier tag, the command 'git tag --contains HEAD' had the
following peformance improvement:

Before: 0.81s
After:  0.04s
Rel %:  -95%

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 ref-filter.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index aff24d93be..fb35067fc9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,6 +16,7 @@
 #include "trailer.h"
 #include "wt-status.h"
 #include "commit-slab.h"
+#include "commit-graph.h"
=20
 static struct ref_msg {
 	const char *gone;
@@ -1587,7 +1588,8 @@ static int in_commit_list(const struct commit_list *w=
ant, struct commit *c)
  */
 static enum contains_result contains_test(struct commit *candidate,
 					  const struct commit_list *want,
-					  struct contains_cache *cache)
+					  struct contains_cache *cache,
+					  uint32_t cutoff)
 {
 	enum contains_result *cached =3D contains_cache_at(cache, candidate);
=20
@@ -1603,6 +1605,10 @@ static enum contains_result contains_test(struct com=
mit *candidate,
=20
 	/* Otherwise, we don't know; prepare to recurse */
 	parse_commit_or_die(candidate);
+
+	if (candidate->generation < cutoff)
+		return CONTAINS_NO;
+
 	return CONTAINS_UNKNOWN;
 }
=20
@@ -1618,8 +1624,18 @@ static enum contains_result contains_tag_algo(struct=
 commit *candidate,
 					      struct contains_cache *cache)
 {
 	struct contains_stack contains_stack =3D { 0, 0, NULL };
-	enum contains_result result =3D contains_test(candidate, want, cache);
+	enum contains_result result;
+	uint32_t cutoff =3D GENERATION_NUMBER_INFINITY;
+	const struct commit_list *p;
+
+	for (p =3D want; p; p =3D p->next) {
+		struct commit *c =3D p->item;
+		load_commit_graph_info(c);
+		if (c->generation < cutoff)
+			cutoff =3D c->generation;
+	}
=20
+	result =3D contains_test(candidate, want, cache, cutoff);
 	if (result !=3D CONTAINS_UNKNOWN)
 		return result;
=20
@@ -1637,7 +1653,7 @@ static enum contains_result contains_tag_algo(struct =
commit *candidate,
 		 * If we just popped the stack, parents->item has been marked,
 		 * therefore contains_test will return a meaningful yes/no.
 		 */
-		else switch (contains_test(parents->item, want, cache)) {
+		else switch (contains_test(parents->item, want, cache, cutoff)) {
 		case CONTAINS_YES:
 			*contains_cache_at(cache, commit) =3D CONTAINS_YES;
 			contains_stack.nr--;
@@ -1651,7 +1667,7 @@ static enum contains_result contains_tag_algo(struct =
commit *candidate,
 		}
 	}
 	free(contains_stack.contains_stack);
-	return contains_test(candidate, want, cache);
+	return contains_test(candidate, want, cache, cutoff);
 }
=20
 static int commit_contains(struct ref_filter *filter, struct commit *commi=
t,
--=20
2.17.0.39.g685157f7fb

