Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2546C1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbeDQRAY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:24 -0400
Received: from mail-co1nam03on0093.outbound.protection.outlook.com ([104.47.40.93]:4424
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753800AbeDQRAS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=isdWRk+Va/kvkrmDIM5UCuNd3FFK6Jzdleq0fEyBtnQ=;
 b=XiWU3LlS9ONKfm4k6dlui+DQBeXcKUXxTQ3f6Mir5ui6PPRu1IK3rMs6cxafMxo6lH1R6UREtzyoV3qCKvRiU8fOff2bswWZ7g4dEOt1OFDCVv3UsSXfzGP45M1MgDESaKPZ4aS1e7NpuGuJTpmrQhPwPBOCUS0rxHsr8JSXrGE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:16 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:16 +0000
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
Subject: [PATCH v3 1/9] commit: add generation number to struct commmit
Thread-Topic: [PATCH v3 1/9] commit: add generation number to struct commmit
Thread-Index: AQHT1m2O3Hx+wXRgm0ajJIA2wIu5DA==
Date:   Tue, 17 Apr 2018 17:00:15 +0000
Message-ID: <20180417170001.138464-2-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:6Uo5BDorQRDLZe5HJsOpvv9M7Bu3krGPUfcNWlOu6+1O2VqXcsKInhPx/4Je4YyH9FSb79qs33lBAUTpUmuLDuolGmRLtn7ehLitPOiQTjmpfpTlx4A8ZtFJLlm1Z+a43XALHVm+kf3ZcUmr731RnhnDiPuaN5hEdmwO4AFmxodpXAkjOAvNjRF/zpiOfh9Ta2jB1C2Ir5PRiMHl2ynxLpHGMEsIhwfOGd6X4NWebJZly3fK31uXHVN+n8jBvB0K;20:g/UEh+6I6mL5mHlLUbv/O5/R2ps4qTULGsgVBLx+wO12uqm70SU2Alidmuxc/zZ2YByVRn5RUnc/pAngBTBCXw2NUj2gcze1yXuJ4YGMCxo5JzjgzKFq4RuXBwc2uux4Y9WIjBWGC3GX1+Uv8ITGTTcmfDyzl7KTkhwIX3C/z5I=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1074867280D1842DA3B49C9BA1B70@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(102836004)(10090500001)(7416002)(6916009)(2906002)(99286004)(10290500003)(386003)(186003)(6506007)(86612001)(5640700003)(14454004)(5660300001)(8676002)(97736004)(3280700002)(105586002)(4326008)(52116002)(86362001)(486006)(8656006)(6116002)(2351001)(11346002)(476003)(106356001)(46003)(2616005)(2900100001)(316002)(36756003)(446003)(54906003)(2501003)(22452003)(478600001)(68736007)(25786009)(3660700001)(107886003)(39060400002)(6486002)(53936002)(305945005)(1730700003)(1076002)(6436002)(81156014)(8936002)(81166006)(6512007)(5250100002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D7TSr7q1q7LhXoJD0T3NODTt+pIZ+wYjbZL62AHpoQZq+dJOs4S7XrOMlYwnTcF7zheakPrDLc+rSIkfaJWKvDrFacHyZf5c+tiOioSultMonEl2Uap/WoeFUub4lq+Y2zUHzNxpNsN9GfmAvfM3WhYVlah0ECPtA5B8zckxnZ2j6Z/nYIpxWMPwH6RAsDGV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 23390855-a42a-41c2-7ac7-08d5a484b0f5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23390855-a42a-41c2-7ac7-08d5a484b0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:15.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The generation number of a commit is defined recursively as follows:

* If a commit A has no parents, then the generation number of A is one.
* If a commit A has parents, then the generation number of A is one
  more than the maximum generation number among the parents of A.

Add a uint32_t generation field to struct commit so we can pass this
information to revision walks. We use three special values to signal
the generation number is invalid:

GENERATION_NUMBER_INFINITY 0xFFFFFFFF
GENERATION_NUMBER_MAX 0x3FFFFFFF
GENERATION_NUMBER_ZERO 0

The first (_INFINITY) means the generation number has not been loaded or
computed. The second (_MAX) means the generation number is too large to
store in the commit-graph file. The third (_ZERO) means the generation
number was loaded from a commit graph file that was written by a version
of git that did not support generation numbers.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 alloc.c        | 1 +
 commit-graph.c | 2 ++
 commit.h       | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/alloc.c b/alloc.c
index cf4f8b61e1..e8ab14f4a1 100644
--- a/alloc.c
+++ b/alloc.c
@@ -94,6 +94,7 @@ void *alloc_commit_node(void)
 	c->object.type =3D OBJ_COMMIT;
 	c->index =3D alloc_commit_index();
 	c->graph_pos =3D COMMIT_NOT_FROM_GRAPH;
+	c->generation =3D GENERATION_NUMBER_INFINITY;
 	return c;
 }
=20
diff --git a/commit-graph.c b/commit-graph.c
index 70fa1b25fd..9ad21c3ffb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -262,6 +262,8 @@ static int fill_commit_in_graph(struct commit *item, st=
ruct commit_graph *g, uin
 	date_low =3D get_be32(commit_data + g->hash_len + 12);
 	item->date =3D (timestamp_t)((date_high << 32) | date_low);
=20
+	item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
+
 	pptr =3D &item->parents;
=20
 	edge_value =3D get_be32(commit_data + g->hash_len);
diff --git a/commit.h b/commit.h
index 23a3f364ed..aac3b8c56f 100644
--- a/commit.h
+++ b/commit.h
@@ -10,6 +10,9 @@
 #include "pretty.h"
=20
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
+#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
+#define GENERATION_NUMBER_MAX 0x3FFFFFFF
+#define GENERATION_NUMBER_ZERO 0
=20
 struct commit_list {
 	struct commit *item;
@@ -30,6 +33,7 @@ struct commit {
 	 */
 	struct tree *maybe_tree;
 	uint32_t graph_pos;
+	uint32_t generation;
 };
=20
 extern int save_commit_buffer;
--=20
2.17.0.39.g685157f7fb

