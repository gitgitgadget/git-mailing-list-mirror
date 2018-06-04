Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931EE1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeFDQwR (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:52:17 -0400
Received: from mail-dm3nam03on0112.outbound.protection.outlook.com ([104.47.41.112]:52790
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751042AbeFDQwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJn1H+Gb/aGxGrvDfH+XD/8hxIgPtxIMjybZiNN+JpQ=;
 b=UVrcyYABgB3PuEhyRyJ890hQKBF8quYZ12NERJYsbxrodFGNe8bsu/Yiw2p2pqzIMbnNowpmM15x2ukenVjZEDm19A+nZppcVK5EGz5onn6el2Ndes/bvtkDrGnpeFtjqgheyDKoxzs3ArZubvedl6glelHlaG2YwdEUtvJRTQQ=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1081.namprd21.prod.outlook.com (52.132.149.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.11; Mon, 4 Jun 2018 16:52:14 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:14 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 01/21] commit-graph: UNLEAK before die()
Thread-Topic: [PATCH v4 01/21] commit-graph: UNLEAK before die()
Thread-Index: AQHT/CRjn/3mVXz4J0+Wkts3OHRTKQ==
Date:   Mon, 4 Jun 2018 16:52:14 +0000
Message-ID: <20180604165200.29261-2-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1081;7:8ECA9LFrLjZZCr0Wqta7hGHhilEBz9oxaqrp/ET4om+VKTr1XZiSW3lGB6UV+0AoR9KhxLFHdg0puUbV9cIzxicNABSym9kw7oexkfpsEYh3rxJWzhjC67fVckV5OcxRnAgG8NQ46u6xfErGMARFO6bF6OU+bg1WgkpRXURD33nbgrwX5rkC3kZW+pY++7obN92MDVua0iSnoxhZQRoPfas5h4FsPOyvhnZnDGhRnaf5iqP7I71SgSGuYQqb+Us0;20:RPI3f0w+uBC8HglhY8rWE3WNIZ9zGlWrghl1FeW+cK6YBYwcuj7VoxthXKHxvzSZmQt+w5+V+8OgRfZqYU9CGlIW3E1U25KwCakI37qqxlpZUg7CWz+yRqguq0Vh0OS3nFieVACVkTZ4kD9kVV5jvyiK6cEH0stXljPHOugehO4=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1081;
x-ms-traffictypediagnostic: MW2PR2101MB1081:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1081A3751243EF6B1B2B5368A1670@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1081;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1081;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(199004)(189003)(81156014)(486006)(8656006)(102836004)(6512007)(316002)(3280700002)(14454004)(1076002)(54906003)(186003)(107886003)(6116002)(478600001)(3660700001)(39060400002)(2616005)(386003)(2900100001)(99286004)(476003)(6506007)(10290500003)(59450400001)(86612001)(68736007)(11346002)(446003)(52116002)(76176011)(86362001)(575784001)(2906002)(53936002)(22452003)(36756003)(25786009)(6916009)(5660300001)(5640700003)(2501003)(97736004)(2351001)(4326008)(46003)(105586002)(6436002)(106356001)(10090500001)(6486002)(81166006)(8676002)(305945005)(5250100002)(8936002)(7736002)(1730700003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1081;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wt1re5INsxxgDoAmL9z1quv+NrMNhJ5+o6aD8UCtZA6Nkj9pZnI8pOi94NNsYtIlmmB0WsgsQks0UeExvXQqiW63sYAmSKcFUeOb74/SBc8SS4uoQTWxd/YeqwHRWu+b2hZpU0G/nb3lzXf628HFLItc3MIJ42WxPRSIAkdUWksNc38nH6xUIkS59b4pAATw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 071c45d0-e041-4e0a-a542-08d5ca3b85c8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071c45d0-e041-4e0a-a542-08d5ca3b85c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:14.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 37420ae0fd..f0875b8bf3 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -51,8 +51,11 @@ static int graph_read(int argc, const char **argv)
 	graph_name =3D get_commit_graph_filename(opts.obj_dir);
 	graph =3D load_commit_graph_one(graph_name);
=20
-	if (!graph)
+	if (!graph) {
+		UNLEAK(graph_name);
 		die("graph file %s does not exist", graph_name);
+	}
+
 	FREE_AND_NULL(graph_name);
=20
 	printf("header: %08x %d %d %d %d\n",
--=20
2.18.0.rc1

