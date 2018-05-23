Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5591F42D
	for <e@80x24.org>; Wed, 23 May 2018 14:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeEWOrn (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 10:47:43 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:26688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933341AbeEWOrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 10:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G3d25UdRIjoeLrx69HRREIzFzWpPeVXhWydkqmvdD4=;
 b=M8kZUuSB3KhVPrXTYN7Hl2NHe3Sy/d27erKsEv/T8reZS9qv4LeyucfZNIY0jZAmX1BIGfGwUiuBe4NzTnGL4yBH/556HlO8rf7TOVa7aqygGbrf2AbPFihtFLTuBOorasy64gU+9U+hj5/y8k4R7XnDeOWwdlKj56ZfwupsS5E=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Wed, 23 May 2018 14:47:37 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0797.007; Wed, 23 May 2018
 14:47:37 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 3/7] mem-pool: only search head block for available space
Thread-Topic: [PATCH v3 3/7] mem-pool: only search head block for available
 space
Thread-Index: AQHT8qT9GAqHksGwWU6rs4TKBMsQGA==
Date:   Wed, 23 May 2018 14:47:37 +0000
Message-ID: <20180523144637.153551-4-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180523144637.153551-1-jamill@microsoft.com>
In-Reply-To: <20180523144637.153551-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR1801CA0033.namprd18.prod.outlook.com
 (2603:10b6:405:5f::46) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:EbSyTAk+KHTjBW9MHX2wxIn2/MT8kQaRiIBMpXC2/G5uWhWDoL1RRiZD9naf1NeCP3+h4hQY/1YYG6J81GMMniPylhnymsBngiKMGsPb0sDkjlp9jp8U+wcFrY6DWQWIXtbM7s6vK0CPTIRrhTuexgOLcfpBOWG41sdx+CB1oPtT+slTRVCFnQOUxxKjSosvm0jGf6faoI1zqHbi1hAomyqzBZO+w8/zwoyqyiAw0sr98BxmglUMmsW+eg0BH9dr;20:swkgWZfDWcafW12iEDYq7HWHtJd54UVSrqRJCXj4cVbFjNaY685lwmzPFTK1PGyHKhboz9br8g39P+djf0ox5ydtWR/66vFqY7YnTufk45S8SqMcrZM0OtmqHpDkznovpyDhsMsuaLwZo7uSaWIC0GF9bn7tXcN8rds52qDbbUU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09777ED7A43CBA01F1BEAFB9CE6B0@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(76176011)(102836004)(99286004)(59450400001)(6506007)(386003)(2501003)(5250100002)(81166006)(81156014)(1730700003)(8676002)(105586002)(8936002)(305945005)(106356001)(97736004)(7736002)(86362001)(476003)(25786009)(2906002)(3660700001)(1076002)(14454004)(486006)(3280700002)(6116002)(446003)(11346002)(186003)(52116002)(2616005)(86612001)(46003)(10090500001)(6512007)(53936002)(2351001)(478600001)(36756003)(5660300001)(4326008)(6916009)(68736007)(6436002)(5640700003)(2900100001)(22452003)(316002)(54906003)(8656006)(39060400002)(10290500003)(107886003)(6486002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9ZxkPO4bIn1nZ9Dbvw4jj7NGAk0uvjVu+JxsZz40d1ObrpkCQMOnV33fyVcRBWRf0aEgmQUEsHXt7b/hOcxiP4o3MWHHoQ42Cix2yZ0ESvPphUukY58Zm0GuvkN8m3GXS6nvFx0V5RjMdm3EtvdIMP6BfhbiVGAJHqS6uiKZ7i5YNcJMKwYAExb7q0fLBwQH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: eeeeae50-87ca-49e8-b892-08d5c0bc203c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeeeae50-87ca-49e8-b892-08d5c0bc203c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 14:47:37.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
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
2.14.3

