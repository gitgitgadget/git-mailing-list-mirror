Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B741F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeDIQmM (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:42:12 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:41888
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753413AbeDIQmK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZLUb98U4oVJ45kQ9cmtmcd45ZBPgEKOTC0d+1+btbnI=;
 b=KfHU870bNGFDg6zH27hB1Gu445lb2WJ5p1x6wRO8ElDwbwD7I7c27l+sLpNvsVTKqOLQXOjDJCSgRZicCh2Ocs5Ie0tBibo75batakj3uNteyLQg3dtI/nTdKmlphFSlgYKQJCF34LDanzPlcktmhnwZnMzsSG+gk7A9vvozc0o=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:42:09 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:42:09 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 08/10] ref-filter: use generation number for --contains
Thread-Topic: [PATCH v2 08/10] ref-filter: use generation number for
 --contains
Thread-Index: AQHT0CGz35Kq9d9AV0+iqum9e7gAwg==
Date:   Mon, 9 Apr 2018 16:42:08 +0000
Message-ID: <20180409164131.37312-9-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:2tKyu3Bh9Kos6i7FS1ZK5IQHsmz8bdE53JA72P23676UQD/+1fydAQ8xDybM0FuSphoqDI/8+9Usg0IF+LBmMHSiqdrNnxApzz+kQpf0liVNyWGAVFwRKsjCUx/EVQNYvLEPbteMiXEF9vZZEo+m88t2KtH3NniREcLTSWpoWpzp2UNexokLYQ1AuFmAaCp2cDrhafCl/7zGrjj5h1xbScsiQWh60pf1aOKKyyy0/4Mimi54b/dtoNTjs45p8TKr;20:EAWWc3qlZuzi+Gd3RUJICx0Lu5iuCq4b+sPdQvXOpHl7xfq+ntRxgE+EmXd+7Wp9KWEhDr5rEFJRu1xSSbJBS+rMQ+8fi0OXdavRFtt4Irqb2B9U+9V3LYz1RhqdnosEQxiEZit1BFUHQ5da5ypgVNl4m3L2xweW/DKc5LuiVd8=
X-MS-Office365-Filtering-Correlation-Id: 94cda8ad-a664-4f67-2a39-08d59e38d5d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09621E6DF571C8231051A853A1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vaOGQEwOMfd2lwYZyezNRvuY5LjHAH4bX/VzBexAdAYPCGAeeh8eNuPy8zYVEq+wD7wCKUH1l65OL8xYrEGV50KPeihSLA55PUj/+U4jy1j3nKDJOyZQVEeL5MX0IgA9KPrkAT2f/lhBfAN2eH8QSh0+gfpLfhH4s/VFh+w1AP6MfrqdMFZM/fEdfstLkRA3zIoVo5IQDfUCktFMszAj6bwzEa9gtIY2fheKFJ3g4ttC/2sXUr2Z1Nrl0aK0JqMWOzjDKpL3fI7Wiksklp9/N9ZQ3td1l80j6V3DcIhivHVoqT2i2uLtEULTkDPgGLc3YFZ2u0adUVxH1dFQAxdpZPWDzMogqmIfhMVEZvDoqPesdYZ+IsqfMYGIYyUoEYrYGJfc9oyrmy8nYD7e6UZ1iUVdpVSmLvYlQCsG0vc7mQI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cda8ad-a664-4f67-2a39-08d59e38d5d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:42:08.9913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
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
 ref-filter.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216a..2f5e79b5de 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1584,7 +1584,8 @@ static int in_commit_list(const struct commit_list *w=
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
@@ -1598,8 +1599,11 @@ static enum contains_result contains_test(struct com=
mit *candidate,
 		return CONTAINS_YES;
 	}
=20
-	/* Otherwise, we don't know; prepare to recurse */
 	parse_commit_or_die(candidate);
+
+	if (candidate->generation < cutoff)
+		return CONTAINS_NO;
+
 	return CONTAINS_UNKNOWN;
 }
=20
@@ -1615,8 +1619,18 @@ static enum contains_result contains_tag_algo(struct=
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
@@ -1634,7 +1648,7 @@ static enum contains_result contains_tag_algo(struct =
commit *candidate,
 		 * If we just popped the stack, parents->item has been marked,
 		 * therefore contains_test will return a meaningful yes/no.
 		 */
-		else switch (contains_test(parents->item, want, cache)) {
+		else switch (contains_test(parents->item, want, cache, cutoff)) {
 		case CONTAINS_YES:
 			*contains_cache_at(cache, commit) =3D CONTAINS_YES;
 			contains_stack.nr--;
@@ -1648,7 +1662,7 @@ static enum contains_result contains_tag_algo(struct =
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
2.17.0

