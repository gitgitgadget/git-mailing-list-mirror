Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B871F516
	for <e@80x24.org>; Mon,  2 Jul 2018 19:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeGBTtk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 15:49:40 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:42044
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753018AbeGBTtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 15:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/WMniRoZ5CpPbSvswAKtv4axhTpoaJxz17wihiX6cg=;
 b=UIcESwHiZLrT8oWcFo57ii+SjOEbOmrg4oFrpXhXtov4p6EN7QThTAzh3Z/T/rlAdR9gXl9BUbDGU5KDgf2mfOUTOELzSkZrb/Hgoml95cUvT8K1hdj5TWvBH5GoXO9FS80YP1tJsNeha8yy0gqUcVvPM6vW3dJV21d+rAyTeps=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0284.namprd21.prod.outlook.com (10.173.174.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 19:49:33 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989%4]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 19:49:33 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>
Subject: [PATCH v6 4/8] mem-pool: only search head block for available space
Thread-Topic: [PATCH v6 4/8] mem-pool: only search head block for available
 space
Thread-Index: AQHUEj3Mmh7XpMk+tEWs1pHDizWKVw==
Date:   Mon, 2 Jul 2018 19:49:33 +0000
Message-ID: <20180702193745.8940-5-jamill@microsoft.com>
References: <20180628135932.225288-1-jamill@microsoft.com>
 <20180702193745.8940-1-jamill@microsoft.com>
In-Reply-To: <20180702193745.8940-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN3PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:400:4::25) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0284;7:z5naOiYA5GY9vjKWuMfGkrGT6kbFrQYe8OK5Q7wdyNDxvo3SOkfG1VK5rjXMCRgSDbPvJSLRcdToUPfoA8XqkYmDfSaZ30K57szQQSVQHQBoo8kgz5z5vxnpTINwoVXa++R8MyidYBohln4zHSEt61NhtzyZZArFgDJVbgFNvGZgMWKlnOznHJe07/nZpFgk907OfrKNeVq9gxq9E7WacurFyaACviqx/63nq7Dmd9kyNpLQVFN/wk6u8qZvo7oR
x-ms-office365-filtering-correlation-id: 72f00200-a2cd-441e-337d-08d5e054eea7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0284;
x-ms-traffictypediagnostic: DM5PR21MB0284:
x-microsoft-antispam-prvs: <DM5PR21MB02848EC9373413A3ED0BCC9FCE430@DM5PR21MB0284.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0284;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0284;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(36756003)(316002)(22452003)(86612001)(37006003)(86362001)(54906003)(14444005)(256004)(99286004)(446003)(11346002)(476003)(2906002)(2616005)(10290500003)(4326008)(14454004)(25786009)(39060400002)(6862004)(486006)(10090500001)(53936002)(478600001)(5660300001)(76176011)(5250100002)(102836004)(6200100001)(386003)(6506007)(6436002)(6512007)(8936002)(305945005)(52116002)(68736007)(1076002)(2900100001)(105586002)(8676002)(81156014)(81166006)(6116002)(7049001)(1511001)(97736004)(46003)(6486002)(106356001)(7736002)(6346003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0284;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: GEj5XW1hbIJrd6MIXn5RTQhzLccWUjbf32b5Pap1b2vhs+4cLWnm1sDkp9iU105Ek5+STC6XdWBG5UeAT9QvlQmhJywbvuywfOgnp0e5AF7anLtW0+rF0e0KgEhQyZuN5b8II0b0+2wXEvT2TNamb31pxRC6rke0Olu20mDnJ/cZV0Udr3PsZfKrKXrg58E+gRtxuolTmFDSfqaUsZDC4ccBLhMMfnc6ABzEJrfWOZ8OR0a0T+dRILfAAcSwqSqEuiOEZzQ4UgewsExKrJPL9hRyFqmsjGauLea2u9p/fl/LlsMkLgxI9YXJvZGlVJcJ2LbdzdCDpolQ5dvqvSWiSKmu1gNiHBDE0YfGv+lkGpA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f00200-a2cd-441e-337d-08d5e054eea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 19:49:33.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0284
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of searching all memory blocks for available space to fulfill
a memory request, only search the head block. If the head block does
not have space, assume that previous block would most likely not be
able to fulfill request either. This could potentially lead to more
memory fragmentation, but also avoids searching memory blocks that
probably will not be able to fulfill request.

This pattern will benefit consumers that are able to generate a good
estimate for how much memory will be needed, or if they are performing
fixed sized allocations, so that once a block is exhausted it will
never be able to fulfill a future request.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 389d7af447..c80124f1fe 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -21,16 +21,16 @@ static struct mp_block *mem_pool_alloc_block(struct mem=
_pool *mem_pool, size_t b
=20
 void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
-	struct mp_block *p;
+	struct mp_block *p =3D NULL;
 	void *r;
=20
 	/* round up to a 'uintmax_t' alignment */
 	if (len & (sizeof(uintmax_t) - 1))
 		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
=20
-	for (p =3D mem_pool->mp_block; p; p =3D p->next_block)
-		if (p->end - p->next_free >=3D len)
-			break;
+	if (mem_pool->mp_block &&
+	    mem_pool->mp_block->end - mem_pool->mp_block->next_free >=3D len)
+		p =3D mem_pool->mp_block;
=20
 	if (!p) {
 		if (len >=3D (mem_pool->block_alloc / 2)) {
--=20
2.17.1

