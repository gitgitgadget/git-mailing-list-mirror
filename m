Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D9B1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933189AbeFTURc (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:17:32 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:45030
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932755AbeFTUR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G3d25UdRIjoeLrx69HRREIzFzWpPeVXhWydkqmvdD4=;
 b=G4EQUPqM+8C2cY877g+u34rg9MkREnbEaNcGkCNR9kNf2W3cG2Be1En8lXVd6/EAux6wGDnOZFgvHdOpZkkjRZ/mZ7jIcrfIuB7QrBW+Eutd9JRkzDaUdFu/9l8SrNk2ySyHehIV8FYdaUJ11nDqPiiR0K5Out7yQvThap6mTcI=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0746.namprd21.prod.outlook.com (10.173.172.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.1; Wed, 20 Jun 2018 20:17:27 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 20:17:27 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 3/8] mem-pool: only search head block for available space
Thread-Topic: [PATCH v4 3/8] mem-pool: only search head block for available
 space
Thread-Index: AQHUCNO1rafalOyaE0mVB/U/f+pp4g==
Date:   Wed, 20 Jun 2018 20:17:27 +0000
Message-ID: <20180620201557.77155-4-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180620201557.77155-1-jamill@microsoft.com>
In-Reply-To: <20180620201557.77155-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:404:23::32) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0746;7:rq/50uCVOu5I9gyNwRU9Ibl9cBSIRqwNecaJaPZslkpxQDSpKrID/IE1q+UoKX7x3vb3ncHIPcpu8edPWUU5LolAbJSD5ivRXefNYGTl6h1ak46aoOPrCRPS7Q5+93jrFL4y5UF5eJCuABedTBE3olzANmpars4OuqdMfiIu7gnWKiuhDtPnKn498+vaXdLxmwqrcHWQwFb7Rb0veCb+7dlw3c8SQKVB9wwE/VC8weuidQdRHJhPcInqqlqY3NS1
x-ms-office365-filtering-correlation-id: 310e6982-6bb7-4c30-1077-08d5d6ead7bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0746;
x-ms-traffictypediagnostic: DM5PR21MB0746:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0746615582AFC88F1265092DCE770@DM5PR21MB0746.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0746;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0746;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(199004)(189003)(10290500003)(8676002)(305945005)(14454004)(76176011)(11346002)(7736002)(68736007)(4326008)(5660300001)(39060400002)(25786009)(6916009)(52116002)(53936002)(106356001)(36756003)(8936002)(8656006)(1730700003)(22452003)(81156014)(386003)(186003)(2616005)(54906003)(59450400001)(316002)(102836004)(6506007)(446003)(478600001)(99286004)(81166006)(486006)(476003)(107886003)(2351001)(3660700001)(6486002)(46003)(97736004)(6512007)(2900100001)(86612001)(6436002)(6116002)(1076002)(5640700003)(3280700002)(5250100002)(2906002)(105586002)(10090500001)(2501003)(86362001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0746;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wxmqj4tQm/rE9817Zs7V1HBzV/9V81Oli3ONOSX5nUmljVy12XKeCYrRqREShw2nAISUroqMLSJuPrWWi1qrFb9eaD8e7d5Tai3LAuBIthaPq6SLjaC9n59q7cQCeIk28YZHS3GQ8i312LOFWY5f1PceRCYO92EZOL4LAxvxBUpJbwV+fmXuWw5+cMOnHBvgkrgvecJQKrsWb0ITBn5mYmZNvEaOW7WuXjOQDrtnr93M8YT7kgkOSewlsWlxhEm74iwjYyAokklRd+vYdZOlWiHOK1Uqs90DWSMBDOhysozxbeXwyqX5pWwzb8+4UsUq792iSsumfZ9ylT9GvH8gyQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310e6982-6bb7-4c30-1077-08d5d6ead7bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 20:17:27.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0746
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

