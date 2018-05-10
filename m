Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691F31F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966769AbeEJRem (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:42 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:53659
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966691AbeEJReJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FL7mge104kk5qJmBcJLtjeh4rsXJVInFiMpk50yqz1c=;
 b=iRNLcg6nN6/BfwVvpVE1BUzTpNEmR2DeEfFFheDjq6jn3rWC8dPbdcsOPDAlLSW8afrXIOXq4hlVgW7/scuZFt/M/1eXIb6q5iF9ma/rCVXZR6AYef3NGrn5Z3QwTG2Bqky3hTvzHD+3gK3kPnyOMb+a6Wmvnmxp4rteRsIH3+8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:06 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:06 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 03/12] commit-graph: parse commit from chosen graph
Thread-Topic: [PATCH 03/12] commit-graph: parse commit from chosen graph
Thread-Index: AQHT6IUYBEH6tcE0cUu+3jxpiJy1Kw==
Date:   Thu, 10 May 2018 17:34:06 +0000
Message-ID: <20180510173345.40577-4-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com>
In-Reply-To: <20180510173345.40577-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:404:79::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:6440/3Hu0p5DyeFdkFGwOX8Fij5cJRvSDWZfLJT0yWL5Lu09XlPSTaLvj9QvHU9d8yvsxF5Y3UDT5MeesyOi9+hmxyGOFpK7O/M2gsGjuPONg2hx5HK2K4h14Kf+/Pm86VxmCK3s3/DQLx+gzhbrZiOYEq7TG7STpNZLb18IDTbbOHn+HG69EMf8t1gE9GCpjTMWRrZ4kpTl3BJbyuoWVcXkX6DD2f63jVuuwPgyZvdFwAV5FY/Q0EY6X4S3gJi1;20:Zkgf0Y2Jlka137ie0GYtFzBtVIaOH9W4d2mEl6tcyveWBVDQ6T4Lp5R29PdSYs3VEa0PnHVB3LA/ExwHu15GlulY7ZB7atNH4vw1QviaE8L0Ryos6+t07X0DEM1zLfvUJTX7B9mTGFVLjgjK0/Qy0X22nKVI55BpoUt3aipWHh8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09627529C7852076B94725E1A1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kcmNsL0b+UVzvDf2pnFK6UwNcnzo/E1QfMTMAUASJS/50gQ7M9ujJTLRwSuHq+Xcm3Gmqu/jWh9tGzbRzfn5IiaEOE5dRF85ZnEK8jvhrwseSL0nRsvsfgQQq9/DAeNlHetIk0hVvZmWB4ZJGEkuuNdBZXVx8Wv/pfh4IhnjpOL6r5fiAsrUj9kIISvTFJox
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f1ad4273-ffc1-46b3-dcb7-08d5b69c3aaa
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ad4273-ffc1-46b3-dcb7-08d5b69c3aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:06.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before verifying a commit-graph file against the object database, we
need to parse all commits from the given commit-graph file. Create
parse_commit_in_graph_one() to target a given struct commit_graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c3b8716c14..ce11af1d20 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -309,7 +309,7 @@ static int find_commit_in_graph(struct commit *item, st=
ruct commit_graph *g, uin
 	}
 }
=20
-int parse_commit_in_graph(struct commit *item)
+int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
 {
 	uint32_t pos;
=20
@@ -317,9 +317,21 @@ int parse_commit_in_graph(struct commit *item)
 		return 0;
 	if (item->object.parsed)
 		return 1;
+
+	if (find_commit_in_graph(item, g, &pos))
+		return fill_commit_in_graph(item, g, pos);
+
+	return 0;
+}
+
+int parse_commit_in_graph(struct commit *item)
+{
+	if (!core_commit_graph)
+		return 0;
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
2.16.2.329.gfb62395de6

