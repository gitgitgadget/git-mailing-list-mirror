Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC211F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeFFLg3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:36:29 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:22720
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751828AbeFFLgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJn1H+Gb/aGxGrvDfH+XD/8hxIgPtxIMjybZiNN+JpQ=;
 b=ezUS1+sOmac2DmrFcmKgJno13yZ+QrcKmDG4xFLvHPd5lE/TMWn0NZHBdj4amg9SDxjvB1vfMghGj56yuCajHa+mT4kxPpJh4OoRdxGKYrHYS4s4JiujlxVCrl0FCpTwX11x/DusMYudAxysPfCD/NHgWOssNpGLSr545IfAkuk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1075.namprd21.prod.outlook.com (52.132.24.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 11:36:23 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Wed, 6 Jun 2018
 11:36:23 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 01/21] commit-graph: UNLEAK before die()
Thread-Topic: [PATCH v5 01/21] commit-graph: UNLEAK before die()
Thread-Index: AQHT/YqXjTuDzpqVc0+/bXRyn+ZP9w==
Date:   Wed, 6 Jun 2018 11:36:23 +0000
Message-ID: <20180606113611.87822-2-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
 <20180606113611.87822-1-dstolee@microsoft.com>
In-Reply-To: <20180606113611.87822-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:403:1::28) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1075;7:fI1PWgVp6N0O6A7c158JP/ham5O3t35yd0SLnU+kjugpcLNbp71WUa6OQ4tUs8+gU+4BuprldSctVv3In/G/pCcuEUkcuc6gyEuyO38ufYUo2IIsfh4CV4cbGmQmnA+xwzIGRlsBTHmrXxb/0sqQVJdgpMY9V/YT98zmMrhN82xbMiDqMNMeQ+Sv98/CTkPJr9jrwJKfl+l3Q+CQ2EhjnMoHIgC7uQqQUSQcCC0QSEoAUeaHyY6dU9FlcHm8iCCF
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1075;
x-ms-traffictypediagnostic: BL0PR2101MB1075:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB107520E0B15B642FD175EEB9A1650@BL0PR2101MB1075.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1075;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(376002)(396003)(189003)(199004)(99286004)(476003)(22452003)(14454004)(8936002)(6916009)(97736004)(2351001)(5660300001)(486006)(6116002)(81166006)(86362001)(478600001)(8656006)(1730700003)(81156014)(54906003)(6436002)(446003)(86612001)(2616005)(5640700003)(10290500003)(8676002)(1076002)(11346002)(316002)(6486002)(575784001)(186003)(4326008)(3280700002)(305945005)(25786009)(53936002)(59450400001)(105586002)(10090500001)(106356001)(2900100001)(7736002)(3660700001)(46003)(2906002)(6506007)(39060400002)(68736007)(386003)(36756003)(76176011)(102836004)(52116002)(107886003)(2501003)(6512007)(5250100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1075;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nWGgnEXDS2YHMZyepUqgpqCHEcE2ifhfQnPnRy1ofzo+ekzYcBKBridF+zS1l0QgnS6r/Vj8iw3JketAt06+Ayb+doc5SrzT2jf9aq8KG25+QD9hD6FQDVmwfgu9YNO7xeiNH0s/o44YSJMbMxfflnqmJo2R2N8OVTpHhFNIkrCshAEOgBWq2a1kRLIIV0t+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7b88f931-1d9d-487d-f970-08d5cba1b987
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b88f931-1d9d-487d-f970-08d5cba1b987
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 11:36:23.2401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1075
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

