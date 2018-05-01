Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402BA215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755826AbeEAMr4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:56 -0400
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:54781
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755542AbeEAMrR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NCfvQ0D9jVRZrnTHHdkBoHI4NVecTffAInnFi4n2ANg=;
 b=nRpbHYYHOsyGNI2hZpcxQPTLRzU1ypMJhFYbuks4V7HpVrNnUERd9FELPgGLIF3WzM0hqzc6pwfYFeDlgBQ2Km5PWYQnn1idKm0GtqcKeqcUwZTdX1+iDIxC25g/2Ltn7zV0fFEY9QeVnut3GP03rUnmfvS008TwQse4QpFAVzE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1042.namprd21.prod.outlook.com (52.132.24.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:16 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:15 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 06/11] ref-filter: use generation number for --contains
Thread-Topic: [PATCH v5 06/11] ref-filter: use generation number for
 --contains
Thread-Index: AQHT4UqIFlrvb59NDkWHD4dHh2YG1Q==
Date:   Tue, 1 May 2018 12:47:15 +0000
Message-ID: <20180501124652.155781-7-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1042;7:2PdCqpNyOZNS8yJBfqpTQz6X7sfcQCCkArN4Wbq/BCbZMaoGvzKwS7sNopXFItFHwL9oa95Pba320UziEBuwPdeO5Sn0Kxmt3C8bI7MN7uqtg0Itf8i/y8ySvd11MpJk/ozTZ/TSa7K4V+iqEIYRS8lONCVtzJk2ifUIcIZ10+XwLImbWtrB4X5cPdrR7IJeshDrOwgP6LI4pzFe50EtDrrXPHUuD+AWg6H+ZY5AXeNn1+UI+0kAN0eWGz6xW+JG;20:zH28B0w+Jz7yYjLuibKh036k9k3ea0QrXsT9/R3x/8A9Sb7IOC49/U87B4N5WNiLJnOpiaBYLeYHKajFnhHi575l406G5pU+4/CrivDJZOb/T3eKT5YHwuUBBBBtpn4aO5wpNf3zGj12syTEMME/DDk5ESoU0TwzRn7GT26G2JA=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1042;
x-ms-traffictypediagnostic: BL0PR2101MB1042:
x-microsoft-antispam-prvs: <BL0PR2101MB104275DD6AB8FE24C07574D3A1810@BL0PR2101MB1042.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1042;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1042;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(366004)(39860400002)(199004)(189003)(22452003)(86362001)(316002)(39060400002)(36756003)(5660300001)(8936002)(81156014)(6486002)(97736004)(68736007)(6116002)(10090500001)(11346002)(81166006)(5250100002)(2501003)(186003)(446003)(6512007)(1076002)(3660700001)(4326008)(10290500003)(3280700002)(46003)(6346003)(386003)(6506007)(478600001)(102836004)(105586002)(53936002)(25786009)(2616005)(2906002)(2900100001)(107886003)(486006)(305945005)(2351001)(54906003)(5640700003)(7736002)(86612001)(106356001)(1730700003)(14454004)(8676002)(6436002)(8656006)(476003)(99286004)(6916009)(52116002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1042;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: JWmrRQPepSTwwzKscuNFCMuxfM76GdMy/bOoG0/qoOawOiToerKLFLswTEffkWFAOuE9d4ZvAafMIIwqSfT1OCTKwzW+h8vBxY/b/v6TZAKx9wQsv1lA8BWg4PzPlx6mqcasAj49PUmVZn1KBlts4vhlW9ABRyaBnJm+H4WwkWPcchwkdM2jfEFXHGve2/zS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fb900f67-3d50-4743-5b23-08d5af61aabe
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb900f67-3d50-4743-5b23-08d5af61aabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:15.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1042
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A commit A can reach a commit B only if the generation number of A
is strictly larger than the generation number of B. This condition
allows significantly short-circuiting commit-graph walks.

Use generation number for '--contains' type queries.

On a copy of the Linux repository where HEAD is contained in v4.13
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

