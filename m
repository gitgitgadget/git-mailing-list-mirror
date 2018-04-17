Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCE91F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeDQSLJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:11:09 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:53856
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752714AbeDQSKm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QZs2pZgUAVCAgfCZOip6J0nbD6U+R0Zt3YW5Qm+wpfQ=;
 b=lpSk648GAwz8xw2Gj8pVpPWrz3BwqfgAbo2zPS6kZA24ol4pMANmUGqpYCznn56FTOTBN4iqXCi5jvYV0rHGuIKo9tV7ZSuBKOEv5mDpbQv8uWTHcm1CB7RMl5cgRXvPxvBqQAZLckhdEc/7T71MywDSDbdJgSh/TC4l6JLVZyQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1027.namprd21.prod.outlook.com (52.132.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 18:10:40 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 18:10:40 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 03/12] commit-graph: check file header information
Thread-Topic: [RFC PATCH 03/12] commit-graph: check file header information
Thread-Index: AQHT1ndkYOEJu0+LpkOmBYCRqTbkvQ==
Date:   Tue, 17 Apr 2018 18:10:39 +0000
Message-ID: <20180417181028.198397-4-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1027;7:7DOm0Rge3MkNB3ZJCKUxfDpbgL6qRKTaBDu2rQmhhH3Shfwfwf/k1yq9De1Zo6Q7gafKxhsCwIKU7jJjScSSRnPn0CC9JWxi2qnF3eNpZ/KiL9mgu7XFYYQgjLtxx6M+bUFXewgd3VdNK8v7UNNa1QaUNhjocOTqVBK/z0X5s3asVY8sNwxWYJ7+gPGq7n+4mWUAtu7LHl/e8z3L6iXDETcE/O7GN6zfrVFOgFocH9xkQ686/w/lBrhQUC27mhY7;20:doX5MXOjHvF9L2ZD+Eug3GjlFMVKMzlRViA6REhVymn5FRdMbaNPAf78TlFFrJtTIww3MFKG9tLJICbQbRIZEjegqG+H/TARoC744vgUKTkMYNJ69ZKNn8GGytr4WHAMeIWD6eG6itc5nQc8bbjSjG6PP3ThyMzruqkTbbpsE6U=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1027643C6461F079C4F85CEDA1B70@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1027;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1027;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(6512007)(5660300001)(186003)(107886003)(6916009)(2900100001)(478600001)(10290500003)(105586002)(106356001)(2906002)(86612001)(86362001)(99286004)(53936002)(25786009)(22452003)(575784001)(54906003)(316002)(5250100002)(6486002)(6506007)(97736004)(4326008)(8936002)(14454004)(102836004)(3660700001)(6436002)(36756003)(5640700003)(3280700002)(305945005)(10090500001)(81156014)(59450400001)(68736007)(446003)(76176011)(2501003)(52116002)(2351001)(11346002)(8676002)(476003)(1076002)(386003)(81166006)(2616005)(7736002)(486006)(46003)(6116002)(1730700003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1027;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SkHqmb3UYNYYRq4Bsj3TgHJbwSnJMLXP3Bcg9hhzzOTHqJEzhjjp5VAgwIkblLy9Sle8H4lG6W6C9EzpPM4zpSBcU7M31dZ2NFxwmRY0MF+DGpZDsvXMMkAPZ5Othxks6uGiZ7gRtU2w2cB/YxV0/5/E/Uc4z8zsgDwChqbKDsfV59c32irGMdPziyaZE3XP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 49df1496-9e16-4432-5195-08d5a48e86b9
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49df1496-9e16-4432-5195-08d5a48e86b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:10:39.9929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During a run of 'git commit-graph check', list the issues with the
header information in the commit-graph file. Some of this information
is inferred from the loaded 'struct commit_graph'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index cd0634bba0..c5e5a0f860 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -820,7 +820,34 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr =3D 0;
 }
=20
+static int check_commit_graph_error;
+#define graph_report(...) { check_commit_graph_error =3D 1; printf(__VA_AR=
GS__); }
+
 int check_commit_graph(struct commit_graph *g)
 {
-	return !g;
+	if (!g) {
+		graph_report(_("no commit-graph file loaded"));
+		return 1;
+	}
+
+	check_commit_graph_error =3D 0;
+
+	if (get_be32(g->data) !=3D GRAPH_SIGNATURE)
+		graph_report(_("commit-graph file has incorrect header"));
+
+	if (*(g->data + 4) !=3D 1)
+		graph_report(_("commit-graph file version is not 1"));
+	if (*(g->data + 5) !=3D GRAPH_OID_VERSION)
+		graph_report(_("commit-graph OID version is not 1 (SHA1)"));
+
+	if (!g->chunk_oid_fanout)
+		graph_report(_("commit-graph is missing the OID Fanout chunk"));
+	if (!g->chunk_oid_lookup)
+		graph_report(_("commit-graph is missing the OID Lookup chunk"));
+	if (!g->chunk_commit_data)
+		graph_report(_("commit-graph is missing the Commit Data chunk"));
+	if (g->hash_len !=3D GRAPH_OID_LEN)
+		graph_report(_("commit-graph has incorrect hash length: %d"), g->hash_le=
n);
+
+	return check_commit_graph_error;
 }
--=20
2.17.0.39.g685157f7fb

