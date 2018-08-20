Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B3F1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHTUId (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:33 -0400
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:59456
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbeHTUId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtWVuG/VsIN2eOzUWAh0WQqW7ONE/5i99OUVJoLxlmw=;
 b=mfqgaIxPBWYx7eotM+wW0m36MQAZoXRWV4zgCvTyXUSxZfFR9HIODReEpt6u/syCoXs8jKcaV/ljzxhHQ/jx5eL0YNlKHsGAhdmJulodFRdYKNp99lAt2584zif/KzCxjJK06t2dpLaSfjwdj7oBtDgldgw4NtVGwDJGjH+SZHM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Mon, 20 Aug 2018 16:51:59 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:51:59 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 4/9] midx: stop reporting garbage
Thread-Topic: [PATCH 4/9] midx: stop reporting garbage
Thread-Index: AQHUOKYccDss1F/c0kuYp/0y78qmqQ==
Date:   Mon, 20 Aug 2018 16:51:59 +0000
Message-ID: <20180820165124.152146-5-dstolee@microsoft.com>
References: <20180820165124.152146-1-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:903:103::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;6:CkKJ3olsVupOnur+piycRojfqAuJE5bxy+tVkISmklrERXPG2wNF8Jbstn0m3lm5rPqDFHlOSM5/qCjzdzk3GgXQ3GnXLAn78HDtPx3Gupi9V9Gk50ltMbM9b1v95dd8e94s8orX93Y2kobwFtsQS/KFwrCQ3sAOORuBVcxbBDjIDkqnt2ml8N4W7PQJJaOV2rGiJrfU00Y820Z83ceNJRrwkCkYxBCsS7uzbq9LWFyvtqOnypdfUKluXgsFLBK+mRjFxWMBrI423TY232o9kCTlBNVnitXYMQnLxYLflMAThCVaDJdNh4RGiVDO6qUfb9LCxd695lN+tHRZ/Zg62Epu8UtA6/22m1jkf13WA+LcaA3xasxYb1b9PeK+JA2T/UUE/LewGNzoojj0oq+A8d0kKwMuHGQYexR6EsA5/Mi9KIfrEtknOV6dCLG5HVpu6r2sF9N4SgECme959DITwA==;5:b7xQ/1Iz12dTqWq09/GyZlCXhDk+/NMcDkDvBLe9e/RhTFUFtybzw+SbZnYMzv2XmIrGcyPSLjaSSklTPDUYT88JZ4O9kxdK3jXUxR4VCG+yG2aesdmgJcdduj71GdabMSe7MECAP4iUgtKVKTIidkZB3Nh0fShfnAcTX6t3tZE=;7:ygYuqG38RD+dltmu17xujZ4DoR84dqMKMFxvRvOYK8mQhOHT1DUalUhZ4IP79zANLcYjB8UcgWVmeuI+NFGB5Ry27gqPU+s+xl2+rjYnbRyekWtQRbZOoeJsa2r9D5VPr96TpSdHzKjfyYXqGOJW6tBkU8Vp3TFq9i5nkF7fqCofN8gu7DOVw5oqPoBrI6qbXtgLAtQPVXbiLkW4hNyoYp8JKutyXKsECLSH99SZ8cMw8aSsztHzud1boWov2ibm
x-ms-office365-filtering-correlation-id: 9eb1742a-07b8-4348-d3e7-08d606bd3e6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
x-microsoft-antispam-prvs: <BL0PR2101MB096276AE375235601AEEBBA7A1320@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(8676002)(476003)(5640700003)(68736007)(2616005)(2906002)(81166006)(14454004)(81156014)(1730700003)(446003)(7736002)(2351001)(305945005)(22452003)(5660300001)(36756003)(6436002)(1076002)(6916009)(6486002)(46003)(316002)(25786009)(6116002)(53936002)(486006)(86362001)(76176011)(8936002)(6512007)(97736004)(256004)(86612001)(107886003)(478600001)(52116002)(10290500003)(6346003)(186003)(10090500001)(11346002)(2900100001)(386003)(102836004)(5250100002)(4326008)(99286004)(2501003)(106356001)(105586002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: FeOpan4qmxR9lq+M+mey/IT8Rxh9uvQMEWkpOSSy/4+kNR8Splt5ZFLiy0O16HNFVmWkkQr+PbL8Y7fCbco/aXYZglmHzSWzlOnSMxNGBjStrF2M6yIXgAuJuhfXgucukFLaZJz9D/U5KWSbka3/06Ly34dZbVNW/Z9rU3KqBBdsMU3pvmpAnbbhDJ0tP5/Tr7eSZ95l6miYtfzIUr0DUM7+qeqcAsJVhctBMqLG5nfTc3iXIBh+tGPYWkOiXt5v9WicmR/a2N60ZBj3RbvApqReehh4IhRaE4/Vq4ok/j3GtMQ0bCrybq2n8jpSaYA0To85EheZJOTcor0lqpnTE+NftYkmpdF0pQZhf8AQDWY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb1742a-07b8-4348-d3e7-08d606bd3e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:51:59.0507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When prepare_packed_git is called with the report_garbage method
initialized, we report unexpected files in the objects directory
as garbage. Stop reporting the multi-pack-index and the pack-files
it covers as garbage.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 896da460ac..fe713a0242 100644
--- a/packfile.c
+++ b/packfile.c
@@ -820,9 +820,8 @@ static void prepare_pack(const char *full_name, size_t =
full_name_len,
 	struct packed_git *p;
 	size_t base_len =3D full_name_len;
=20
-	if (strip_suffix_mem(full_name, &base_len, ".idx")) {
-		if (data->m && midx_contains_pack(data->m, file_name))
-			return;
+	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
+	    !(data->m && midx_contains_pack(data->m, file_name))) {
 		/* Don't reopen a pack we already have. */
 		for (p =3D data->r->objects->packed_git; p; p =3D p->next) {
 			size_t len;
@@ -842,6 +841,8 @@ static void prepare_pack(const char *full_name, size_t =
full_name_len,
 	if (!report_garbage)
 		return;
=20
+	if (!strcmp(file_name, "multi-pack-index"))
+		return;
 	if (ends_with(file_name, ".idx") ||
 	    ends_with(file_name, ".pack") ||
 	    ends_with(file_name, ".bitmap") ||
--=20
2.18.0.118.gd4f65b8d14

