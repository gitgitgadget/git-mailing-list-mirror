Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699751F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeHTUIg (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:36 -0400
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:59456
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbeHTUIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QxIZyWieCW78gUMqtsW0tAvXGJ1/2sttiV+H73N4Ao=;
 b=iEo+2krZMzHnTkO4NcNCH7lCLX5QNsXd1WDy3PfNVpblQkylVyYxDeA1ZUhmAqCc6zTyYuTBnEgusD4DVLsmAmSb5AS5uKPcbzarPgTB+oZFm4iNIg0tG94xQQKRBzOnN3ujx40Nji1p8ozxtCtxrPj0QdPVRrYefjNgdPnKjuk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Mon, 20 Aug 2018 16:52:02 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:52:02 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 6/9] packfile: add all_packs list
Thread-Topic: [PATCH 6/9] packfile: add all_packs list
Thread-Index: AQHUOKYeT7Oh9CUhaEeNl3dzJc2s+w==
Date:   Mon, 20 Aug 2018 16:52:02 +0000
Message-ID: <20180820165124.152146-7-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;6:AXA5mXQtcVbeoT/HA1YygWQR3azGu+gmXEt+r8dOzAw5REW20TCf4+94X34gdx42HriskTfTgNfyglYbuQIgvEKtR0Gy2tEXyPTD07UByLMJDsyAlOdQKeKgniHdxQPDkiNrALrLhoeVqHKCaT/5EcOzrFU7nhxfDy2BKHP7ymxJ8boZXx56GJwRvIN6dgZ90UV1MrjiaPnUkHS7sZUgLHgIT0Y5dkOi3Jiy01TdZPtKPYIWKYKVH8uhP5RTMDNTu5gFEO1MTH6V/tv7XoYSEUMQzJkX2C2e51CYGA8WDc4zGLlYv2r+/bRYdfIEO5a82DJ7NyRxf61DbN2SEVioNkGwQ1yug09jfYBt9rrNTo/adJSb96bALGb8CGK7iq/J2AJxGh9twCw5mlNza7ULFRLh6bUfXgpS16K9iOI4zp1eZT15DxLzkKCufV1F/PDJGAvQaxsM1dZrYiZ/mWxauQ==;5:RPkabv/j/isOh52DEobUdsSGXQ/q5mbn4hmeb3GUKs4IWeyNrVFZU500TkIFiq8Iet4BDpNhVAxEj56t7/ORTXoCV91h1BaRLd3kwX9uy20/sRM3Aer8b9Py9tznQSFb7h5mOEnmjXnfP+edUD8xjRfTpMPrnnfyYYDITuNegqQ=;7:xl2w1QPHpg7JiMyVVaZ2eH+SVtGsEVZo53buYvYmoLSMt783YGlXB4OW+DrkB1BSkSF59X+7pVrLPmoexx6K45O8ZB2VjpxLqe2+Y9Gh4IG+zsndVtkqqD5y3fwDWMZOXEVrSR7c4ftGsjORlE9+LuEiMzRZP6PLWyBJymHmimkPMXWcDw423OOGfu9uwbR13TiIGyGsPkGRkItwKRbEbwVT38EDfHuYCbzzPyE2VNe+2dFv7aYcvmBCEkXv6Cuh
x-ms-office365-filtering-correlation-id: cc4d08f1-3588-4e72-cdd4-08d606bd4081
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
x-microsoft-antispam-prvs: <BL0PR2101MB0962F74865ADC35F23A7F5C4A1320@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(8676002)(476003)(5640700003)(68736007)(2616005)(2906002)(81166006)(14454004)(81156014)(1730700003)(446003)(7736002)(2351001)(305945005)(22452003)(5660300001)(36756003)(6436002)(1076002)(6916009)(6486002)(46003)(316002)(25786009)(6116002)(53936002)(486006)(14444005)(86362001)(76176011)(8936002)(6512007)(97736004)(256004)(86612001)(107886003)(478600001)(52116002)(10290500003)(6346003)(186003)(10090500001)(11346002)(2900100001)(386003)(102836004)(5250100002)(4326008)(99286004)(2501003)(106356001)(105586002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 1Ll9xr06ZSCyUiojD57FumQy57K4XPdHD6Y+bw9wlZ9rwTtzD1acJt4GmDYnugeLpC43CH5SHxtJbFZ1ypjT7cSHkx3XGlg/G9omCCXBls8ZcD4rJ4W//qwbiArBYiJuec8gW9oN6VBxCusNin42SYRYc0Zo366oGTbGa/qTOb2d9kYStcljfhCwQw0/r7OmMhJf2Ry4XNSlGuwpp5mOsArrpyUIFIP5nx0RGG9aeMMzZY+KMbvktNIio0r8m1BgGJ5YsqvB03Ix7cl/36+fJ9xNY5TXStRhuqiKBaXsLe8yxClei06ZJuAP3GjioM/UmGotrpX9fD+Ze98ivuI2hfGsvkEpywhOQ9B9shTj9zU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4d08f1-3588-4e72-cdd4-08d606bd4081
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:52:02.5992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a repo contains a multi-pack-index, then the packed_git list
does not contain the packfiles that are covered by the multi-pack-index.
This is important for doing object lookups, abbreviations, and
approximating object count. However, there are many operations that
really want to iterate over all packfiles.

Create a new 'all_packs' linked list that contains this list, starting
with the packfiles in the multi-pack-index and then continuing along
the packed_git linked list.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c         |  2 +-
 midx.h         |  1 +
 object-store.h |  6 ++++++
 packfile.c     | 27 +++++++++++++++++++++++++++
 packfile.h     |  1 +
 5 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 0710c4c175..f3e8dbc108 100644
--- a/midx.c
+++ b/midx.c
@@ -197,7 +197,7 @@ static void close_midx(struct multi_pack_index *m)
 	FREE_AND_NULL(m->pack_names);
 }
=20
-static int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int=
_id)
+int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
 {
 	struct strbuf pack_name =3D STRBUF_INIT;
=20
diff --git a/midx.h b/midx.h
index 8aa79f4b62..a210f1af2a 100644
--- a/midx.h
+++ b/midx.h
@@ -32,6 +32,7 @@ struct multi_pack_index {
 };
=20
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int=
 local);
+int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, =
uint32_t *result);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
diff --git a/object-store.h b/object-store.h
index f9c57e2c26..c69d546392 100644
--- a/object-store.h
+++ b/object-store.h
@@ -128,6 +128,12 @@ struct raw_object_store {
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
=20
+	/*
+	 * A linked list containing all packfiles, starting with those
+	 * contained in the multi_pack_index.
+	 */
+	struct packed_git *all_packs;
+
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
diff --git a/packfile.c b/packfile.c
index fe713a0242..adcf2e12a0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -972,6 +972,9 @@ static void prepare_packed_git(struct repository *r)
 		prepare_packed_git_one(r, alt->path, 0);
 	}
 	rearrange_packed_git(r);
+
+	r->objects->all_packs =3D NULL;
+
 	prepare_packed_git_mru(r);
 	r->objects->packed_git_initialized =3D 1;
 }
@@ -995,6 +998,30 @@ struct multi_pack_index *get_multi_pack_index(struct r=
epository *r)
 	return r->objects->multi_pack_index;
 }
=20
+struct packed_git *get_all_packs(struct repository *r)
+{
+	prepare_packed_git(r);
+
+	if (!r->objects->all_packs) {
+		struct packed_git *p =3D r->objects->packed_git;
+		struct multi_pack_index *m;
+
+		for (m =3D r->objects->multi_pack_index; m; m =3D m->next) {
+			uint32_t i;
+			for (i =3D 0; i < m->num_packs; i++) {
+				if (!prepare_midx_pack(m, i)) {
+					m->packs[i]->next =3D p;
+					p =3D m->packs[i];
+				}
+			}
+		}
+
+		r->objects->all_packs =3D p;
+	}
+
+	return r->objects->all_packs;
+}
+
 struct list_head *get_packed_git_mru(struct repository *r)
 {
 	prepare_packed_git(r);
diff --git a/packfile.h b/packfile.h
index 7855556686..3b90e2864c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -51,6 +51,7 @@ extern void install_packed_git(struct repository *r, stru=
ct packed_git *pack);
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct multi_pack_index *get_multi_pack_index(struct repository *r);
+struct packed_git *get_all_packs(struct repository *r);
=20
 /*
  * Give a rough count of objects in the repository. This sacrifices accura=
cy
--=20
2.18.0.118.gd4f65b8d14

