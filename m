Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE6B1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbeDQRA6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:58 -0400
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:18464
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753800AbeDQRAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+/V7+ouoQLtpgoYmQHEfDl5/8xw47tVo2b02osqT9Sc=;
 b=L8mGuIavOVAU2f7kPWPXU4AAW0Z7LoHMYcaQpxs72TrBykO0PmYypn3Azu3AtUfjrDeKC9FXA9G3J/Jcesq4xaiNdecrmjRywnrmJRV40pYKOzHEgDl1s//Scwb0I7mrFwFsoR+X+gIKhEKPHbfRcaaw1byUEPSSyKAR5GwDlMc=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:27 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:27 +0000
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
Subject: [PATCH v3 5/9] ref-filter: use generation number for --contains
Thread-Topic: [PATCH v3 5/9] ref-filter: use generation number for --contains
Thread-Index: AQHT1m2V+SOIzNEhHU2uCWzvQ/WnAw==
Date:   Tue, 17 Apr 2018 17:00:27 +0000
Message-ID: <20180417170001.138464-6-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:FChfrvT2oM2TiXmAd9SoVJ3DPfyquN8GBYxq/jUKJzymi8j9NVYuHCvXiUAmS3L/AIqTIzP1TRI3mOS+icdUcTS4DSVOvxNm9k2GhD1kt/VEgC0e9anm9mOb17NZO6T7Flyx7cQ96scCZT1fczajPhgSGh6//SIt88tTEmFYF/LnJf/JsorG43sEBxyJxklI4DurIYXNnr0MOm8b0DrxxrF7oobX5sfkcq6SBh7Az0t50q0Qjn3Zua1AAsP+KXrl;20:isnrXNnE2M6w5kF3fT4d1quY8ZzrqiYrhQvP4EzIaJdzXIjLjic849OVVLOrbQe9F+uNZzMfshm5GMNQsqIIkbv0iCTGsZqSgmLaM9Dc0RBBcbyox8PWo9dPDRc0g0vPxQTl9Nv7zABzrpcqr9x70guaEBBk+esRuV9bAUcrkTI=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1074FA404C1B938318A2E452A1B70@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(102836004)(10090500001)(7416002)(6916009)(2906002)(99286004)(10290500003)(386003)(186003)(6506007)(86612001)(5640700003)(14454004)(5660300001)(8676002)(97736004)(3280700002)(105586002)(4326008)(52116002)(86362001)(486006)(8656006)(6116002)(2351001)(11346002)(476003)(106356001)(46003)(2616005)(2900100001)(316002)(36756003)(446003)(54906003)(2501003)(22452003)(478600001)(68736007)(25786009)(3660700001)(107886003)(39060400002)(6486002)(53936002)(305945005)(1730700003)(1076002)(6436002)(81156014)(8936002)(81166006)(6512007)(5250100002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZHvVhNpWAxHROaQfQ5ESZd4DxEmI1ndliA5aaCOyrsVuYajuBSjDd4K1/2LkT3EVWRp+L6hZhVI4GKDkpEfj+p/wOYdsoF6FrNAteoH0r094cgCHO7LBcaiBRyxPtfOpfJXCN04/fO+zMIykiKSzyBGlJDoBguti3BIWF8J5t+9/gWcSZPhz2I51goLba9y0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 38e1840d-fe7c-4334-5aed-08d5a484b7da
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e1840d-fe7c-4334-5aed-08d5a484b7da
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:27.3354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A commit A can reach a commit B only if the generation number of A
is larger than the generation number of B. This condition allows
significantly short-circuiting commit-graph walks.

Use generation number for 'git tag --contains' queries.

On a copy of the Linux repository where HEAD is containd in v4.13
but no earlier tag, the command 'git tag --contains HEAD' had the
following peformance improvement:

Before: 0.81s
After:  0.04s
Rel %:  -95%

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 ref-filter.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index cffd8bf3ce..e2fea6d635 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1587,7 +1587,8 @@ static int in_commit_list(const struct commit_list *w=
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
@@ -1603,6 +1604,10 @@ static enum contains_result contains_test(struct com=
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
@@ -1618,8 +1623,18 @@ static enum contains_result contains_tag_algo(struct=
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
+		parse_commit_or_die(c);
+		if (c->generation < cutoff)
+			cutoff =3D c->generation;
+	}
=20
+	result =3D contains_test(candidate, want, cache, cutoff);
 	if (result !=3D CONTAINS_UNKNOWN)
 		return result;
=20
@@ -1637,7 +1652,7 @@ static enum contains_result contains_tag_algo(struct =
commit *candidate,
 		 * If we just popped the stack, parents->item has been marked,
 		 * therefore contains_test will return a meaningful yes/no.
 		 */
-		else switch (contains_test(parents->item, want, cache)) {
+		else switch (contains_test(parents->item, want, cache, cutoff)) {
 		case CONTAINS_YES:
 			*contains_cache_at(cache, commit) =3D CONTAINS_YES;
 			contains_stack.nr--;
@@ -1651,7 +1666,7 @@ static enum contains_result contains_tag_algo(struct =
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

