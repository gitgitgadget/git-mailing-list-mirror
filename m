Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9461F516
	for <e@80x24.org>; Mon,  2 Jul 2018 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeGBTtb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 15:49:31 -0400
Received: from mail-by2nam03on0132.outbound.protection.outlook.com ([104.47.42.132]:33952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752702AbeGBTta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 15:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT3ooC90anHlcwMZEFavLcMrhe2MrLu1pdn1OJNv+wg=;
 b=k+OqSMgo3hypgmGXr7AX9BoNhQlqxtyoR6QLo0CUDUheapXYTqa5zMrVguLWNRl1A2Zdq+McjCYcjOhBxpouo3m94HVNs3eC/eHJ0zRKIrGcXTOp+mh0awUdQ/cye4Jje4f3o0jtljrR1PHqaWZktf/ckB5A/tjn9Qi1fIVPbd8=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0284.namprd21.prod.outlook.com (10.173.174.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 19:49:27 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989%4]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 19:49:27 +0000
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
Subject: [PATCH v6 0/8] Allocate cache entries from mem_pool
Thread-Topic: [PATCH v6 0/8] Allocate cache entries from mem_pool
Thread-Index: AQHUEj3JBeRB0qDVekego1gxkFg8Bg==
Date:   Mon, 2 Jul 2018 19:49:27 +0000
Message-ID: <20180702193745.8940-1-jamill@microsoft.com>
References: <20180628135932.225288-1-jamill@microsoft.com>
In-Reply-To: <20180628135932.225288-1-jamill@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0284;7:eTQ8QCAOHK6tq7nDiDkCIf8tys7paE4XHPb9bqNZHPh+RoqRT//XBPQhpsRJ6EwoWI5pqN+ZTuD+GwEITtrXj8oAniX+QThBlPTeU32n3tF3EY/mxr1A1vOJw07rw1ZWrX1fAKkrVvPw+PYKg6K6+YQ4W5lEG0zD+12QEoQzAoRHoojyonXf3kpKWdUQEKaqvH5V0KCSF7zyuOSh3wBqApyt9eyWwQ5BafeJyyBJy4cVOpuvVxOvjDKZnSwe8hFJ
x-ms-office365-filtering-correlation-id: cff15865-af9d-40c8-7266-08d5e054eb56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0284;
x-ms-traffictypediagnostic: DM5PR21MB0284:
x-microsoft-antispam-prvs: <DM5PR21MB0284F6EDA1D769D2A4DCC851CE430@DM5PR21MB0284.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0284;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0284;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(36756003)(316002)(22452003)(86612001)(37006003)(86362001)(54906003)(14444005)(256004)(99286004)(446003)(11346002)(476003)(575784001)(2906002)(2616005)(10290500003)(4326008)(14454004)(25786009)(39060400002)(6862004)(486006)(10090500001)(53936002)(478600001)(5660300001)(76176011)(5250100002)(102836004)(6200100001)(386003)(6506007)(6436002)(6512007)(8936002)(305945005)(52116002)(68736007)(1076002)(2900100001)(105586002)(8676002)(81156014)(81166006)(6116002)(7049001)(1511001)(97736004)(46003)(6486002)(106356001)(7736002)(6346003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0284;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: q0z9n2pCUWs2Keq8jprxreRCz+LCR26aUYSizlOVj/6e8jxJC7q+VB597/fS5D2UEYxTH7nap4hHxgV/ggB+geq9GxlhSNTYAAcC9gRysNysZeMl+9TQmJQLgMDGDVbtqGTvTRKcBcUHj2vux2oCEWWrhjFjY8/usWmZCZgriPte8RrFTE42m0RBfute5z0jfGxnGBXMn8GN8/K62Ly6iePjKN+YEym7DEt0FTdWJQqjcILxyPKgOMPlFk62b+6AeYGLp39n67xz/4NODYN31VNmqXmIBD8mOXlSwOfk7qwjfQ7Wa+LqsX5gpqiOOAEfAAqFS45oa96a1UaP5/E2yAUFgk4fb4e28q2UZuf/IAg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff15865-af9d-40c8-7266-08d5e054eb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 19:49:27.8135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0284
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v5:
  - Updated commit messages for:
    7581156e8a read-cache: teach refresh_cache_entry to take istate
    2c962aa0cd block alloc: add lifecycle APIs for cache_entry structs

  - Use oidcpy function instead of hashcpy function

### Interdiff (v5..v6):

diff --git a/read-cache.c b/read-cache.c
index ba31e929e8..fd67e2e8a4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -814,7 +814,7 @@ struct cache_entry *make_cache_entry(struct index_state=
 *istate,
 	len =3D strlen(path);
 	ce =3D make_empty_cache_entry(istate, len);
=20
-	hashcpy(ce->oid.hash, oid->hash);
+	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, path, len);
 	ce->ce_flags =3D create_ce_flags(stage);
 	ce->ce_namelen =3D len;
@@ -840,7 +840,7 @@ struct cache_entry *make_transient_cache_entry(unsigned=
 int mode, const struct o
 	len =3D strlen(path);
 	ce =3D make_empty_transient_cache_entry(len);
=20
-	hashcpy(ce->oid.hash, oid->hash);
+	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, path, len);
 	ce->ce_flags =3D create_ce_flags(stage);
 	ce->ce_namelen =3D len;


### Patches

Jameson Miller (8):
  read-cache: teach refresh_cache_entry to take istate
  read-cache: teach make_cache_entry to take object_id
  block alloc: add lifecycle APIs for cache_entry structs
  mem-pool: only search head block for available space
  mem-pool: add life cycle management functions
  mem-pool: fill out functionality
  block alloc: allocate cache entries from mem_pool
  block alloc: add validations around cache_entry lifecyle

 apply.c                |  24 ++--
 blame.c                |   5 +-
 builtin/checkout.c     |   8 +-
 builtin/difftool.c     |   6 +-
 builtin/reset.c        |   2 +-
 builtin/update-index.c |  26 ++--
 cache.h                |  64 +++++++++-
 git.c                  |   3 +
 mem-pool.c             | 114 ++++++++++++++++--
 mem-pool.h             |  23 ++++
 merge-recursive.c      |   4 +-
 read-cache.c           | 264 ++++++++++++++++++++++++++++++++++-------
 resolve-undo.c         |   4 +-
 split-index.c          |  58 +++++++--
 tree.c                 |   4 +-
 unpack-trees.c         |  40 ++++---
 16 files changed, 515 insertions(+), 134 deletions(-)


base-commit: ed843436dd4924c10669820cc73daf50f0b4dabd
--=20
2.17.1


