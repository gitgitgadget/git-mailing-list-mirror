Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D2A215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755603AbeEAMrd (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:33 -0400
Received: from mail-by2nam01on0125.outbound.protection.outlook.com ([104.47.34.125]:51343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755632AbeEAMrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FsG1R8PW9ZK9XYR9khTODLEbwOh0P8xaehppo8oaqgQ=;
 b=MKO5MdpniCDeG5twMgUiwAitqPeAA1dUlHlAX0o16Cg4xEh0V20UqwPkVmrNhP7OUniHC3yR4xPnkeaxW3gxJLzI6uV3cUY8lBkuSelbvze6mVkW0tQpHaCQYNeo+mXfTgX8ByAXnxkOFroFwBzesB6gUzK6fTvZA6yC3iS1oGw=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1042.namprd21.prod.outlook.com (52.132.24.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:21 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:21 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 09/11] commit: use generation number in remove_redundant()
Thread-Topic: [PATCH v5 09/11] commit: use generation number in
 remove_redundant()
Thread-Index: AQHT4UqLh5UsG4Un802L6tJvZM167Q==
Date:   Tue, 1 May 2018 12:47:21 +0000
Message-ID: <20180501124652.155781-10-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1042;7:kwTOVqDROhFexNIiWkBXHgpOIdvVafMpunE+3xDwBRkjxNgtuhCXSFEqIhqDwoYLNMzqYVDpw7Vc5uSa3CnttpdDQ6n5AYCr5Tj/Em1kgY6gfyhSYbvR+oEwsihPYeKtLB/Qzo1JXZEPe4GdWpg2G2zup9wce6i2n5YP1ON28Y2VgvEQTopRbkHi+0GbUANE29maJOt7OG1epn6Xly7t2bQsgWjjYUX8gtQVYBIcpEEP5SWd6EQNYkMmNz3mh8iy;20:UDwFkkZgyXgdATvAbjbLD5nsdm7WvKu6IiDKtuCKAsNh25ztx/+vqiDCRO6U3NJCoh51VePofwWHSTiqbt/VafwKzJwGqSgtx7JcZsOn0/xCjIQGVnbAumK3c5Y6k+F/XiSLnDaXzpsejLC4Wdldlr7M2+FguuZYnDdpL/0m+L0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1042;
x-ms-traffictypediagnostic: BL0PR2101MB1042:
x-microsoft-antispam-prvs: <BL0PR2101MB1042F85A7279F6ED3BB87D05A1810@BL0PR2101MB1042.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1042;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1042;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(366004)(39860400002)(199004)(189003)(22452003)(86362001)(316002)(39060400002)(36756003)(5660300001)(8936002)(81156014)(6486002)(97736004)(68736007)(6116002)(10090500001)(11346002)(81166006)(5250100002)(2501003)(186003)(446003)(6512007)(1076002)(3660700001)(4326008)(10290500003)(3280700002)(46003)(6346003)(386003)(6506007)(478600001)(102836004)(105586002)(53936002)(25786009)(2616005)(2906002)(2900100001)(107886003)(486006)(305945005)(2351001)(54906003)(5640700003)(7736002)(86612001)(106356001)(1730700003)(14454004)(8676002)(6436002)(8656006)(476003)(99286004)(6916009)(52116002)(76176011)(59450400001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1042;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: gn0lUaKqvRvFSPiHlW9cvZ0Qga3yGrb0D3FYlkt2X3+Kmg8Ix07mAzxIhLH6iHD7SPVYYDSOjs+XacynuHrokqTebnmIZiac7zDSMUPybfK4BrMhTT1U6LNnapT+0CAA9LpZtKFBC6chxMbTUiownDdvhW9wVxTJS5Rl+rbQZSLXW7qwm6f5AQIjnVgMZdY4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e4d5f78f-5f97-42c9-d0cb-08d5af61ae3e
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d5f78f-5f97-42c9-d0cb-08d5af61ae3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:21.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1042
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The static remove_redundant() method is used to filter a list
of commits by removing those that are reachable from another
commit in the list. This is used to remove all possible merge-
bases except a maximal, mutually independent set.

To determine these commits are independent, we use a number of
paint_down_to_common() walks and use the PARENT1, PARENT2 flags
to determine reachability. Since we only care about reachability
and not the full set of merge-bases between 'one' and 'twos', we
can use the 'min_generation' parameter to short-circuit the walk.

When no commit-graph exists, there is no change in behavior.

For a copy of the Linux repository, we measured the following
performance improvements:

git merge-base v3.3 v4.5

Before: 234 ms
 After: 208 ms
 Rel %: -11%

git merge-base v4.3 v4.5

Before: 102 ms
 After:  83 ms
 Rel %: -19%

The experiments above were chosen to demonstrate that we are
improving the filtering of the merge-base set. In the first
example, more time is spent walking the history to find the
set of merge bases before the remove_redundant() call. The
starting commits are closer together in the second example,
therefore more time is spent in remove_redundant(). The relative
change in performance differs as expected.

Reported-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 9875feec01..5064db4e61 100644
--- a/commit.c
+++ b/commit.c
@@ -949,6 +949,7 @@ static int remove_redundant(struct commit **array, int =
cnt)
 		parse_commit(array[i]);
 	for (i =3D 0; i < cnt; i++) {
 		struct commit_list *common;
+		uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
=20
 		if (redundant[i])
 			continue;
@@ -957,8 +958,12 @@ static int remove_redundant(struct commit **array, int=
 cnt)
 				continue;
 			filled_index[filled] =3D j;
 			work[filled++] =3D array[j];
+
+			if (array[j]->generation < min_generation)
+				min_generation =3D array[j]->generation;
 		}
-		common =3D paint_down_to_common(array[i], filled, work, 0);
+		common =3D paint_down_to_common(array[i], filled, work,
+					      min_generation);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] =3D 1;
 		for (j =3D 0; j < filled; j++)
--=20
2.17.0.39.g685157f7fb

