Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288001F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbeDIQlz (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:41:55 -0400
Received: from mail-sn1nam02on0136.outbound.protection.outlook.com ([104.47.36.136]:39712
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753370AbeDIQlx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rJiAgM/+pewyGcZOXkoUzv5NcB66Jy2zFaz6YSqqsr4=;
 b=i2oUXsLAZisub5H3cyOnjR9E+D6wOkADnhiFebcUQFektHnaD/wXkS7YkpH/5ZkyiGx5c2tseOYJQ2bCnlLVk07TZG6R4sX75n2fs8ShrWNxXRfaGUfCkxkRxMO8JC0h0k5DwQHrwWgyXBLUo14C0Npu2tqdICCZV346yVkmlcc=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:41:51 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:41:51 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 01/10] object.c: parse commit in graph first
Thread-Topic: [PATCH v2 01/10] object.c: parse commit in graph first
Thread-Index: AQHT0CGp8lDWZ9fhOEKLhRDTrEg9qQ==
Date:   Mon, 9 Apr 2018 16:41:51 +0000
Message-ID: <20180409164131.37312-2-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:Kj7hJ6quXs/AQPthzDF/4fKV7S7v3zne3onIkXlW/+Ir0HT2IiTR5YHZOEVKeHc32rImeJMah1eAIX4HxXhNOoVSdey6Lt5HcR7aNjMcvZ6W/nFfmKs+rXolKKTjaIujffkm7QaBxvHyh5hBgUtefsKthSCfx+lCRbIJhi3vIb0LjiDfmeRcD4wGZO+cW62DmAgq8opCcLJwDnrOXcZiw+gwonXltUByy47ARs7gaXIWsiYuDM+FAOlRCIduN731;20:lh4cSrjUZZxHdJmZyepyk0gPPCgUFhH4TGghYPP2M0NVBPydKy1gCFqKZPM9fo5vZjVrv1VgwoYkVjtQgl6aLUIYnj4l3NA9Prgv5DWXoadZkEG1IqVYv2dgsvC355DJP50kjzpYziyx2+4d5a9858eLK7G1Dirlp7zx1G775AQ=
X-MS-Office365-Filtering-Correlation-Id: 7c314200-dbb1-4c01-1489-08d59e38cb77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB096299E8A283A3784BBCE148A1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(59450400001)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PGn1GdUDwre74NjbZvW/r8TxzfMtSXCswUZM/ZoeUe9GiFxKUzvdRohhRKDMM5EpjQ2cG6iPF/QAxS/IgVUr+aFsktxFqFCVrCC1hHIh6x0BTQlIav6x81GfNZsW4gq5ZHY6Ll0D/s/Pqiqu9GlPEl+hHtQg6sJO4R8uRwtr9myrmrksXGTKNfZWC8uaSf/6K7+F5iUMBCtQbMFQzC4OTrEi7r9+XbU/oxevF7jgc7nf0wTlaE8iWebXLOeFrPDsZ+3qZhsNLRA28qVAFfQA5y4BDwMRljkgN0I0vi1xlkSbbjR+2iOgDkYGCAXtjUpbb7aMPB0mevbQ9MIhodhzYUxkqwvP8VJdaWakBljpttPn/i3+vEh78O/WThBkm+K0SKbWopbEEFK2PK7d6DKYI53UMmqI+tNKG9IxQZ9R2r0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c314200-dbb1-4c01-1489-08d59e38cb77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:41:51.5181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most code paths load commits using lookup_commit() and then
parse_commit(). In some cases, including some branch lookups, the commit
is parsed using parse_object_buffer() which side-steps parse_commit() in
favor of parse_commit_buffer().

Before adding generation numbers to the commit-graph, we need to ensure
that any commit that exists in the graph is loaded from the graph, so
check parse_commit_in_graph() before calling parse_commit_buffer().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 object.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/object.c b/object.c
index e6ad3f61f0..4cd3e98e04 100644
--- a/object.c
+++ b/object.c
@@ -3,6 +3,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
+#include "commit-graph.h"
 #include "tag.h"
=20
 static struct object **obj_hash;
@@ -207,7 +208,8 @@ struct object *parse_object_buffer(const struct object_=
id *oid, enum object_type
 	} else if (type =3D=3D OBJ_COMMIT) {
 		struct commit *commit =3D lookup_commit(oid);
 		if (commit) {
-			if (parse_commit_buffer(commit, buffer, size))
+			if (!parse_commit_in_graph(commit) &&
+			    parse_commit_buffer(commit, buffer, size))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
 				set_commit_buffer(commit, buffer, size);
--=20
2.17.0

