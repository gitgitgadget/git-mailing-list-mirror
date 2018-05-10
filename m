Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61D5A1F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966720AbeEJReO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:14 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:53659
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966615AbeEJReM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VeIH37FWknRPcBugfgOBUQPncGjpeV3aPUtYI3IklS0=;
 b=WKZjFly/YJcT0cYIpQv8l93zalE3v89NdsI1t08kyv/OdRaDre7cIlBo2CyXQQTk6IwcBUJae5zcQ0ox7IVpcfWdydFuOSMs/eAik9lvbEEGscrDCYd/XJ1Hc7Q/BjP+m7U1daqJ8qKOYkmxkROUmLCKeNf909ahwIPZcccuSvI=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:07 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:07 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 04/12] commit-graph: verify fanout and lookup table
Thread-Topic: [PATCH 04/12] commit-graph: verify fanout and lookup table
Thread-Index: AQHT6IUZns9mMGE0QkGxsDCA06TAaw==
Date:   Thu, 10 May 2018 17:34:07 +0000
Message-ID: <20180510173345.40577-5-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:s1kBcpMXzprTH8awCtvj++UoOqGc+vO1x5fd58O3N/pS8UE74vy/dr4/6IItuM4GzT3JbybHAgRN8pLADCyPWvNPlNCaRnsc+kUpXKIAgIYHaIUD2qzE1IamrlB2A70DSxqdNH8e9FA5LBQq734rfVnf+eg9bPJuO2PLT8MPwd0j0wbxnRX5qkrqhvc2wsXxQ/+uN0mQ5y97a5vbKK5wwDMS/HUjio2zUqM0QCEQ6gzU5xIGbbtwbE4+HzjYoTyX;20:uACQy0PIKW6Kl89sarIgPv5VKKcNb3po3vQbvBrRllu0dnqt+cyrzFoaaOu4Rouhbgk/cTYv/CwvIV7IcrE8wGOAEWBloi8shvjggj7dg9J3FqSjLNs9ZBGzTEyMLA2mIoD2GLHEzaomV5Q+z8aNVoPxNk/frehSm2Y64bqMZ5U=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962D10D39117543A7836BE7A1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(15650500001)(59450400001)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7ofbQS6NM4ir2m9lvREGl2m8KjEeVSK9oP8V/fKAzf1w/4MRWMOkwI5h9njF5AKs8/CfEYWYygB4v/VjnDda9b/Gi1ixXA3BKPcE39GZdQN1wwTqUSXMMLvpW1JOdAZBNUssYVxB+b5pgNP3uATtgbnIvkpKCTT8XtVp/i1YByUR5PurnjyMIuwfJ+81C4VK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 102dca99-58f9-4543-1a7b-08d5b69c3b57
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102dca99-58f9-4543-1a7b-08d5b69c3b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:07.4764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While running 'git commit-graph verify', verify that the object IDs
are listed in lexicographic order and that the fanout table correctly
navigates into that list of object IDs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index ce11af1d20..b4c146c423 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -839,6 +839,9 @@ static int verify_commit_graph_error;
=20
 int verify_commit_graph(struct commit_graph *g)
 {
+	uint32_t i, cur_fanout_pos =3D 0;
+	struct object_id prev_oid, cur_oid;
+
 	if (!g) {
 		graph_report(_("no commit-graph file loaded"));
 		return 1;
@@ -853,5 +856,35 @@ int verify_commit_graph(struct commit_graph *g)
 	if (!g->chunk_commit_data)
 		graph_report(_("commit-graph is missing the Commit Data chunk"));
=20
+	for (i =3D 0; i < g->num_commits; i++) {
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		if (i > 0 && oidcmp(&prev_oid, &cur_oid) >=3D 0)
+			graph_report(_("commit-graph has incorrect oid order: %s then %s"),
+
+		oid_to_hex(&prev_oid),
+		oid_to_hex(&cur_oid));
+		oidcpy(&prev_oid, &cur_oid);
+
+		while (cur_oid.hash[0] > cur_fanout_pos) {
+			uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_pos=
);
+			if (i !=3D fanout_value)
+				graph_report(_("commit-graph has incorrect fanout value: fanout[%d] =
=3D %u !=3D %u"),
+					     cur_fanout_pos, fanout_value, i);
+
+			cur_fanout_pos++;
+		}
+	}
+
+	while (cur_fanout_pos < 256) {
+		uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_pos)=
;
+
+		if (g->num_commits !=3D fanout_value)
+			graph_report(_("commit-graph has incorrect fanout value: fanout[%d] =3D=
 %u !=3D %u"),
+				     cur_fanout_pos, fanout_value, i);
+
+		cur_fanout_pos++;
+	}
+
 	return verify_commit_graph_error;
 }
--=20
2.16.2.329.gfb62395de6

