Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8C61F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbeFTURr (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:17:47 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:20363
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933153AbeFTURb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppqzISIlbHexucyiAJxiQTGXLgZ6vH3nNCh5xrRt3Uo=;
 b=lymyRHAZn00HyqBaHAWEBtyGD0tac0U7aAE2uARhNN+GPrhEA0HduGVvme/lmrKOaRZemo0/25xlTxHfemPHyLthVVVIkZAdqNROycGuO3MrfSZjg8Bz1UxfzbDIDttN/TCUTXuUcEMbO73BEFHqMpGMj4EhOEMbWZKKL6dbkUM=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0139.namprd21.prod.outlook.com (10.173.173.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.3; Wed, 20 Jun 2018 20:17:29 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 20:17:29 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 4/8] mem-pool: tweak math on mp_block allocation size
Thread-Topic: [PATCH v4 4/8] mem-pool: tweak math on mp_block allocation size
Thread-Index: AQHUCNO2QFbsLrk8WU6f9llBrj4PPg==
Date:   Wed, 20 Jun 2018 20:17:28 +0000
Message-ID: <20180620201557.77155-5-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0139;7:9Te7RKcmvtE0MrRb+etIscUXae9NV+UD7oi2kaFtSb6AoxiQp/Dxi5obimcbQ120YbpEE4fmbeanXTnZpF8AZTVzE3JSCr4obJkq+W5r+6+tIgn04NQGSu32Ys9p2Soz6smyQNuhQBiYY62hTX/VF89AIFgoYXCqiFG3qYsbllRJbwfV9oCTNwemTsXyLhO4oFSDPaqA4GOUyeoAvvOsV2hNvmHQXj5ncZQq/OMK+9b9DZ7jhjh2yG3zf4YB+U8h
x-ms-office365-filtering-correlation-id: 3c976840-ec85-4bc0-4777-08d5d6ead87a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0139;
x-ms-traffictypediagnostic: DM5PR21MB0139:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0139CED79C4684223219E6A1CE770@DM5PR21MB0139.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0139;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39860400002)(346002)(199004)(189003)(6436002)(6486002)(36756003)(97736004)(68736007)(53936002)(105586002)(107886003)(106356001)(5640700003)(386003)(8656006)(76176011)(6506007)(102836004)(54906003)(59450400001)(186003)(6512007)(2351001)(2906002)(3280700002)(99286004)(52116002)(486006)(81166006)(3660700001)(46003)(22452003)(316002)(446003)(476003)(2616005)(6116002)(6916009)(4326008)(25786009)(81156014)(11346002)(1730700003)(8676002)(8936002)(5250100002)(5660300001)(2501003)(86362001)(2900100001)(305945005)(478600001)(1076002)(10290500003)(10090500001)(7736002)(39060400002)(14454004)(86612001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0139;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QFhIFp0/kNc8hDX6Y1Me7p9Jt5BdfhcpE1a6Sc3rq6MVbpyZ3/YI7c1b3Pt+jtoHpN5XKCm/lcueTqvcdYT/Ih86zPplEf7Rt940BcwaTvw7JRFtfc1VdRzFnSKwNOKh++iXisDIAi0zzByFj+W6RKtiAhqawS47AunCZW3WdYj+kZ481fZD2b+9CSDsDLR/iPcW6eWq0OQ6QXeToTXKBKVIwcZwUaL95JNzzFqLxbol2NCPRlwBjHKg5+kvQx9cqCw9H2eYlO6SCHF/FY88ccXIT9uUb+GELKn+T/YiaX/ES1zCJ7LP0IAyn2yqYX+fxO4EZymMls+Rz5+/3/1Mxw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c976840-ec85-4bc0-4777-08d5d6ead87a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 20:17:29.0501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0139
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The amount of memory to allocate for mp_blocks was off by a
sizeof(uintmax_t) on platforms that do not support flexible arrays. To
account for this, use the offset of the space field when calculating
the total amount of memory to allocate for a mp_block.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index c80124f1fe..a5d5eed923 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -8,9 +8,11 @@
 static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, si=
ze_t block_alloc)
 {
 	struct mp_block *p;
+	size_t total_alloc =3D st_add(offsetof(struct mp_block, space), block_all=
oc);
+
+	mem_pool->pool_alloc =3D st_add(mem_pool->pool_alloc, total_alloc);
+	p =3D xmalloc(total_alloc);
=20
-	mem_pool->pool_alloc +=3D sizeof(struct mp_block) + block_alloc;
-	p =3D xmalloc(st_add(sizeof(struct mp_block), block_alloc));
 	p->next_block =3D mem_pool->mp_block;
 	p->next_free =3D (char *)p->space;
 	p->end =3D p->next_free + block_alloc;
--=20
2.14.3

