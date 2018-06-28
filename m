Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0997C1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966450AbeF1OAY (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:00:24 -0400
Received: from mail-eopbgr730117.outbound.protection.outlook.com ([40.107.73.117]:61158
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966353AbeF1OAO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrbmicIcATax5RYVcr2Zh72sK5t/qlpMRAf93Y6yk50=;
 b=NSvOLhkA+1Cm2FjlRYhsls1PXFHSTSz/CVICOkawKKvtxA/DEasuw/femATaEUxVePczmNTLEZ27rAUqVmLPPSXXbkMNgFfTDJvBub3VNX4y1kmW5KBkLPIUbIKtTnglxtZwUaQDXaRgpQdpNp28WSTLequjfp2XwTFoXfbh/PM=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0172.namprd21.prod.outlook.com (10.173.173.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.4; Thu, 28 Jun 2018 14:00:10 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 14:00:10 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: [PATCH v5 4/8] mem-pool: only search head block for available space
Thread-Topic: [PATCH v5 4/8] mem-pool: only search head block for available
 space
Thread-Index: AQHUDuhTKnuU61uktUalNUfJp8VTVw==
Date:   Thu, 28 Jun 2018 14:00:10 +0000
Message-ID: <20180628135932.225288-5-jamill@microsoft.com>
References: <20180620201557.77155-1-jamill@microsoft.com>
 <20180628135932.225288-1-jamill@microsoft.com>
In-Reply-To: <20180628135932.225288-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:405:6f::12) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0172;7:FWe3qskeooRN09HoykBhalZrva2/5YlwUvkiddezWijnpV4DTOCiWv5beNYx+p2aASpWCuvJCWMmwTQbweQFO1foaqeA59GXcuPV5vDyPRWJQZ5ZlWQKhqWQCCPrBtur5Aq+Bi99mcIKqX9zaHwesSAO86eXAuV7hHFVdq/Le7FBFReTzh99NhA9+CELBmCkFzhjZPhYi3NgqDyGL6llPIwEGgXvr0IU1duJyJ3vwR6TtEz7Qd6HQbZIBWuY04V/
x-ms-office365-filtering-correlation-id: 2374295a-c799-4456-a989-08d5dcff763d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0172;
x-ms-traffictypediagnostic: DM5PR21MB0172:
x-microsoft-antispam-prvs: <DM5PR21MB017245620E837F9C07A8753ACE4F0@DM5PR21MB0172.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231270)(2018427008)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0172;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0172;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(199004)(22452003)(86612001)(86362001)(1076002)(6116002)(6486002)(6436002)(6512007)(10090500001)(53936002)(4326008)(36756003)(5660300001)(39060400002)(2900100001)(97736004)(25786009)(6200100001)(6862004)(5250100002)(2906002)(8676002)(10290500003)(7736002)(305945005)(478600001)(14454004)(68736007)(52116002)(386003)(102836004)(6506007)(6346003)(76176011)(81156014)(81166006)(8936002)(46003)(11346002)(446003)(99286004)(316002)(1511001)(476003)(2616005)(105586002)(106356001)(14444005)(37006003)(486006)(54906003)(256004)(7049001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0172;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: 1m+u0eIONaXKxxyjPyOkX0Mmwrngoz2Fcn31md5KsJRiceAXqwRONRwIlbYB+zpCAEIKfE+oX9xpkJO8n0sp/rSYS6emOFqbuVG5BT8Dg9qPAFKgSpVUlYocH8Ltjgh6jbQ1Qu4y4eFQAicsMq/d/brGkJUAhdbqKA7tqdLqVyfWwTw+bwcm7p8DwmINldISNStKhJt9G4sBkvpdTMs2Lwrz8Jzk31MVoU+crxrDp5OoB0BsaOPYnNM8fRPPtgciVr++5NymkODnuRy1d7+4BrUvoU8wVicvBLyyZiazWz5oYU/lSZRD0UaL+8bdDydrvCN1JJMbQYOvRPMZKd1ffoDIqnF2W1+3UKxWHaaTY/4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2374295a-c799-4456-a989-08d5dcff763d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 14:00:10.6301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0172
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

The impact of this change on memory was tested by running fast-import on
the git.git and linux.git repositories. The total amount of memory
allocated to the mem-pools did not change with this approach, indicating
that there is not much memory benefit to searching all nodes in the
linked list.

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

