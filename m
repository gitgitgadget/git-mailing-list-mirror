Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A621F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966438AbeF1OAT (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:00:19 -0400
Received: from mail-eopbgr730117.outbound.protection.outlook.com ([40.107.73.117]:61158
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966350AbeF1OAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeEDKhL+6/YE6H2a/gaSYRWZpfy6OSCJJ5MYMdu50Tk=;
 b=eX6LX8WQ5iW+YOSPd9BOMFLmjnX+YSYjeSp2rCt63Ovr+xpmg/seVGhWzwEFgK+iDqEK7akepxuIk/jAr0hOG2HkmRE2oXCkMoSMInSjUo/DXiArCMog3Y33umzVENoau7LODkz0x8FTyOqCzJxqVqBGqUuK9XWNO6TYSzqLSkw=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0172.namprd21.prod.outlook.com (10.173.173.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.4; Thu, 28 Jun 2018 14:00:13 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 14:00:13 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: [PATCH v5 6/8] mem-pool: fill out functionality
Thread-Topic: [PATCH v5 6/8] mem-pool: fill out functionality
Thread-Index: AQHUDuhVdd0dsCLiMkOrFCaPeXTvyA==
Date:   Thu, 28 Jun 2018 14:00:13 +0000
Message-ID: <20180628135932.225288-7-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0172;7:CBmk5mNAf6+7rdrm8nb3cVpcNz3I6fP96aAmGtImyevu2Fnm3UugPuYgxRWFQLuV+NscfRuS71//pjsDJ1Q0GJUSwxPEjWitYLErOYjsNtzWaop+5H1sskEcC30/KhzWurRzShgxVAy4U+I68hicGMWoKBk5MtvFtu5n1c0jFVEDEYkZj3H1j0XBDA862gQRHZ0CKjwdtA4P9hpQ3XJYJfie9UItMY7p1VVfUPicy7oSMbZqhL8mBHCiH0qCrQGE
x-ms-office365-filtering-correlation-id: 5193f289-8ffe-4068-74b2-08d5dcff7818
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0172;
x-ms-traffictypediagnostic: DM5PR21MB0172:
x-microsoft-antispam-prvs: <DM5PR21MB0172E52B034C30F990608EB8CE4F0@DM5PR21MB0172.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231270)(2018427008)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0172;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0172;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(199004)(22452003)(86612001)(86362001)(1076002)(6116002)(6486002)(6436002)(6512007)(10090500001)(53936002)(4326008)(36756003)(5660300001)(39060400002)(2900100001)(97736004)(25786009)(6200100001)(6862004)(5250100002)(2906002)(8676002)(10290500003)(7736002)(305945005)(478600001)(14454004)(68736007)(52116002)(386003)(102836004)(6506007)(6346003)(76176011)(81156014)(81166006)(8936002)(46003)(11346002)(446003)(99286004)(316002)(1511001)(476003)(2616005)(105586002)(106356001)(37006003)(486006)(54906003)(256004)(7049001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0172;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: XF931P44OYqpWzTru4ajjQfiSgN3bbtZ0hJ206H91L/nR0QSaYAhebdRhNjVhf5dE8NxTc6RqoJXXpljYKSnYdIGQDJcznNNTL50Udal8hlEgXJ8/5qP2hlCmZnKakeS2wkhKpv2/qZpQawaLK/Z5pMCfRqhO6yO5P1XjubFK6MNXHm4ExPCbiKYftTcgOYh5+6dr9wcG/7WLcBKxUCRGyWW4df9rkReH0331TPb4KA6KIB2lYFk4jy/ubq6Q6RH6/i1l8Rd7RniAFwKwk9e4vzWSLb0xrdLhPuffhY4zT8mxy+8O2yNoVrg7NsvAZ8FKbdgMWksH1DUUhmCwULiZ0On4bE6+wFancauUtfsBiE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5193f289-8ffe-4068-74b2-08d5dcff7818
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 14:00:13.7927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0172
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add functions for:

    - combining two memory pools

    - determining if a memory address is within the range managed by a
      memory pool

These functions will be used by future commits.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h | 13 +++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/mem-pool.c b/mem-pool.c
index 1769400d2d..b250a5fe40 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -96,3 +96,45 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t =
count, size_t size)
 	memset(r, 0, len);
 	return r;
 }
+
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
+{
+	struct mp_block *p;
+
+	/* Check if memory is allocated in a block */
+	for (p =3D mem_pool->mp_block; p; p =3D p->next_block)
+		if ((mem >=3D ((void *)p->space)) &&
+		    (mem < ((void *)p->end)))
+			return 1;
+
+	return 0;
+}
+
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src)
+{
+	struct mp_block *p;
+
+	/* Append the blocks from src to dst */
+	if (dst->mp_block && src->mp_block) {
+		/*
+		 * src and dst have blocks, append
+		 * blocks from src to dst.
+		 */
+		p =3D dst->mp_block;
+		while (p->next_block)
+			p =3D p->next_block;
+
+		p->next_block =3D src->mp_block;
+	} else if (src->mp_block) {
+		/*
+		 * src has blocks, dst is empty.
+		 */
+		dst->mp_block =3D src->mp_block;
+	} else {
+		/* src is empty, nothing to do. */
+	}
+
+	dst->pool_alloc +=3D src->pool_alloc;
+	src->pool_alloc =3D 0;
+	src->mp_block =3D NULL;
+}
diff --git a/mem-pool.h b/mem-pool.h
index f75b3365d5..adeefdcb28 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -41,4 +41,17 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len);
  */
 void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
=20
+/*
+ * Move the memory associated with the 'src' pool to the 'dst' pool. The '=
src'
+ * pool will be empty and not contain any memory. It still needs to be fre=
e'd
+ * with a call to `mem_pool_discard`.
+ */
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
+
+/*
+ * Check if a memory pointed at by 'mem' is part of the range of
+ * memory managed by the specified mem_pool.
+ */
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
+
 #endif
--=20
2.17.1

