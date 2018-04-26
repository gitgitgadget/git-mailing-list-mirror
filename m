Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298DC1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 20:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756394AbeDZUwd (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 16:52:33 -0400
Received: from mail-cys01nam02on0128.outbound.protection.outlook.com ([104.47.37.128]:23432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756644AbeDZUw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 16:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HQiMuxa/9z582Eg18/jfk8cFIlUsK2oeVkuCoH7PbO8=;
 b=R3f1aRncLK3lwAs6v+F6MKwmYIG3J0CY75w0MLchwNuj+SPjAxeHWiR/BiND1fwmbPzO5ZNAfUx/0eOgXUAjmADXPk09oxMFxiuerEIJh4N9Rzk9DR4PcFAthjM5maHcpzyPQMkUDkJX+DqFt1N3Tp22uTjntAoN1QaYsks/iUQ=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0997.namprd21.prod.outlook.com (52.132.133.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.5; Thu, 26 Apr 2018 20:52:22 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0735.006; Thu, 26 Apr 2018
 20:52:22 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: [PATCH v3 3/3] merge: pass aggressive when rename detection is turned
 off
Thread-Topic: [PATCH v3 3/3] merge: pass aggressive when rename detection is
 turned off
Thread-Index: AQHT3aB55TzZjGiJr0aIEZy5xhNnHg==
Date:   Thu, 26 Apr 2018 20:52:22 +0000
Message-ID: <20180426205202.23056-4-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com>
In-Reply-To: <20180426205202.23056-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0084.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::44) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:S1E3fdSlvnA4N7NkYizJ/BisIrofyDoJ3EQ4HKIktSZkYoyULnqpYSrQTmj+gNcyiDuoNsa4HQP84TWYejTEtpKCRS3sRX4jCs2hNaXYm4MhcCLW1zn5147t+DoJSWFzxgT0PVu+yIixY66pIvpjpG4OAFvaPSTU4xSjiIbit0FLr4wawZnH8Ya/ckMuZAb80FNFZsoJtOTTuPXtQpKmVqo/6YI+tfjmewr1h+3pjBS9VCZQzhvLYfA6R/QHl2Oq;20:R6q2zHQIdKvr/yGjQWEcdeBOs3OyMk5P7Jnr8DdCr12JPy5bIDyd6t2lquSfxe/FsktGmCHnGrg1Z8Ze61cGbbA2ScbCt1ZQ3J32Yim3OoK/Cu6KE+cl7qa8yGnLwXg054JW+URld9EoTGMTYGgo6Ft9yP9uGnvqf4rVzU7npik=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB099730F84014F1896863B281F48E0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(39380400002)(199004)(189003)(3846002)(39060400002)(106356001)(6116002)(97736004)(6916009)(81166006)(66066001)(2616005)(14454004)(53936002)(50226002)(6486002)(1730700003)(5640700003)(8676002)(6512007)(5250100002)(81156014)(1076002)(26005)(10090500001)(305945005)(8936002)(10290500003)(105586002)(25786009)(4326008)(68736007)(54906003)(2906002)(52116002)(7736002)(86612001)(22452003)(5660300001)(478600001)(102836004)(186003)(72206003)(6436002)(446003)(2351001)(11346002)(386003)(8666007)(8656006)(76176011)(99286004)(486006)(316002)(6506007)(3280700002)(36756003)(3660700001)(59450400001)(2501003)(2900100001)(476003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p3WXQloPhDeunyJespVK9g1PxpSDE1FYHbn2NC87GVtv8mENz2IBAAqvneyZS391EjLUyBJq4a86qOH5EgMGpKajJAHWImpjVASDLGLjue1qRcvYgKYfVfKOMOcYrZHubvRWT5//UDwdfkzQYxKe9tJNABWADuhQeLqDac2zGeqJpwkecI30DLEMofPkUf4W
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4b616b8a-7c03-4309-1c4b-08d5abb79b9f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b616b8a-7c03-4309-1c4b-08d5abb79b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 20:52:22.4896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set aggressive flag in git_merge_trees() when rename detection is turned of=
f.
This allows read_tree() to auto resolve more cases that would have otherwis=
e
been handled by the rename detection.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 merge-recursive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2637d34d87..6cc4404144 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -276,6 +276,7 @@ static void init_tree_desc_from_tree(struct tree_desc *=
desc, struct tree *tree)
 }
=20
 static int git_merge_trees(int index_only,
+			   int aggressive,
 			   struct tree *common,
 			   struct tree *head,
 			   struct tree *merge)
@@ -294,6 +295,7 @@ static int git_merge_trees(int index_only,
 	opts.fn =3D threeway_merge;
 	opts.src_index =3D &the_index;
 	opts.dst_index =3D &the_index;
+	opts.aggressive =3D aggressive;
 	setup_unpack_trees_porcelain(&opts, "merge");
=20
 	init_tree_desc_from_tree(t+0, common);
@@ -1993,7 +1995,7 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
=20
-	code =3D git_merge_trees(o->call_depth, common, head, merge);
+	code =3D git_merge_trees(o->call_depth, !merge_detect_rename(o), common, =
head, merge);
=20
 	if (code !=3D 0) {
 		if (show(o, 4) || o->call_depth)
--=20
2.17.0.windows.1

