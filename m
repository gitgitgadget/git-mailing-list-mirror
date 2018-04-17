Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40A51F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeDQSKo (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:10:44 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:53856
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752719AbeDQSKm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=anRotZHpXnSMgp8bhNADwfeCssX4Hw+XdDaS2ohcog4=;
 b=iPA2EgcX+uXxjSUzfYD8n6GV3b4k0rJVa9+TcrkEJ8TrNBf+vR1S7sXsUsqtyKYNmuY9NetThcLoDlMLFRygnsJ7PGG8ivB6PHyCfIiWvYkLtQSwx7icIlEiuxkLy6nDvlieVV4/4fkIMrJTM3ADWX5c+jzbdw0T6gACHYwv40U=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1027.namprd21.prod.outlook.com (52.132.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:41 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:41 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 04/12] commit-graph: parse commit from chosen graph
Thread-Topic: [RFC PATCH 04/12] commit-graph: parse commit from chosen graph
Thread-Index: AQHT1ndkr8bfaiKuykSqIEvwegyh+A==
Date:   Tue, 17 Apr 2018 18:10:40 +0000
Message-ID: <20180417181028.198397-5-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1027;7:TnjWmML1f2/7GtebvR6eTjunzLznBh3szYGz2GO/QP7AbFlX8VMGEXZ5pXDrSIJNtwuW6enObrY2+KtlNz3S4qgUohDrySjP7WD3E85/ZKOw3xHP2Qk4jsDJaIkw0L/nTXt+moZLgt/+lmYS9MOmaMd9wIWMCTYNdA3I2xPM3p17+vHMZkjOwVQ2z02+NcXYTzWnHCaqCt52qEnzwD+kxTeTYKsfksIy3doVWdli3C9pm9oMzCSHW8bvXaA030W8;20:WAId1CxJxJDb/N4yFaJ8wi2HJV5aNGOWMfLikrPWYFC+r7jdGRpv3WhMx4+hgNVSkNCQ4xW1xD3VdtKrArUxWtsFdg3X8YiZ+a7STRP3e8uyR9WUjwDJpNQtmXutKSLFfwbPeUUCiGkn1hAokJ+Zca6Tj8GLlN2dpCiC7G99B9s=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1027EBFF05977E3D773DBB28A1B70@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1027;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1027;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(6512007)(5660300001)(186003)(107886003)(6916009)(2900100001)(478600001)(10290500003)(105586002)(106356001)(2906002)(86612001)(86362001)(99286004)(53936002)(25786009)(22452003)(575784001)(54906003)(316002)(5250100002)(6486002)(6506007)(97736004)(4326008)(8936002)(14454004)(102836004)(3660700001)(6436002)(36756003)(5640700003)(3280700002)(305945005)(10090500001)(81156014)(68736007)(446003)(76176011)(2501003)(52116002)(2351001)(11346002)(8676002)(476003)(1076002)(386003)(81166006)(2616005)(7736002)(486006)(46003)(6116002)(1730700003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1027;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SZoOKHU7PmswUL3vnljzZFpFfeUlm80Q26hSshCyPbTVdLLe+ClnMFNFT4T+8ldpUkU/+rozj+d9cq89tTLN29ekJ9zf+C3ls4VOvaKD7pWO/3GvUMS3kCX3aAMMuSGZkoLfJi/Pgtr/k0mjpgzAx/KMhGS1PGcEDRy+RrGBGKCD6Cvxvi+eG1YQaZe9d3A6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f874d117-9eae-4eae-4294-08d5a48e8727
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f874d117-9eae-4eae-4294-08d5a48e8727
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:40.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before checking a commit-graph file against the object database, we
need to parse all commits from the given commit-graph file. Create
parse_commit_in_graph_one() to target a given struct commit_graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c5e5a0f860..6d0d303a7a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -308,17 +308,27 @@ static int find_commit_in_graph(struct commit *item, =
struct commit_graph *g, uin
 	}
 }
=20
-int parse_commit_in_graph(struct commit *item)
+int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
 {
 	uint32_t pos;
=20
 	if (item->object.parsed)
-		return 0;
+		return 1;
+
+	if (find_commit_in_graph(item, g, &pos))
+		return fill_commit_in_graph(item, g, pos);
+
+	return 0;
+}
+
+int parse_commit_in_graph(struct commit *item)
+{
 	if (!core_commit_graph)
 		return 0;
+
 	prepare_commit_graph();
-	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
-		return fill_commit_in_graph(item, commit_graph, pos);
+	if (commit_graph)
+		return parse_commit_in_graph_one(commit_graph, item);
 	return 0;
 }
=20
--=20
2.17.0.39.g685157f7fb

