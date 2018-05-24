Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80F91F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030912AbeEXQZj (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:25:39 -0400
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:37856
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030874AbeEXQZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkebanje6Po0ryjHEDAJ3M0n+CnQkCphOgU3Dawu/vg=;
 b=CT5YHIjUdtaR1KuR0aP49UA9/sj4nIz+dkWEF/Cw5+9+FgjsrH9J/Wpq8JalhUYj/rRnY8jc0wdC2V6ezc4vIIENg1Oi7uKK+X3GoGrzkHpT/q1t3y5BlzfZRX+z17sn7BIJZoP3cw1wuQm3H5z2E//dv48YETRzJ/1R2kPkyQQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:29 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:29 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 01/20] commit-graph: UNLEAK before die()
Thread-Topic: [PATCH v3 01/20] commit-graph: UNLEAK before die()
Thread-Index: AQHT83vSIwvPDbFmKkOZhbhBmeEEyQ==
Date:   Thu, 24 May 2018 16:25:27 +0000
Message-ID: <20180524162504.158394-2-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:OpCihCJn+oROI8bAj7DEnPphhM7le6SCvwabgiPWCzQRpo81Nh4g16hBsZL0g9xGZHtAt3eh5XX0F7qlUBJGhMFnW1D+7epqrvUYd20MPF6xbUvFTj67CR8YrC1MKAIh3kRSpZdUDbrU89fZ5Btz8ptxR40vka3CepBt+RLtiEeKJeaHsZAD0uFs7x3AKIXo3/P4PUBYEDv8WlrE8C3j18v7revglLFfOd5326nu+dL+BWmBCmrQTIZm4f31BF9+;20:jlqrAReoT3anO7bs2HrFl1iY3mpDPbmBc+FfF6lSm5aUqPFo0lFUo7S/SnqpvzuKfOPWtTtM5lvXMgO5efxr+yfhnsvvV4BS0Cu9w2HRA0WLKtbPRYsdmh+rD1rQ9twelTCXK7ogbxhwgROrPj4M3x4nummRs/m4wQJ6ef6h3zE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10913B5C35A844E65D260D48A16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(575784001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(6436002)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lqFcft8lc5J2jJEqREeDjGK+yRuD52r+Qg68mPP8F68zq+Yzx0W/4k8T1t+4A+w9sScnuRxjDpQx/1lRDrHFFVBtZgXNXxZPB9qEXdFetiPBhYmwNIcMz/khPeraulWjIjDLRhpX00p3L2IczHBc7a6+v6zSHoaz2bqQbdp77kSpzP81B7/l+zjeUcRgC5yt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ea889a74-b3a1-4565-938c-08d5c192f520
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea889a74-b3a1-4565-938c-08d5c192f520
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:27.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
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
2.16.2.329.gfb62395de6

