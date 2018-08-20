Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE411F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeHTUIl (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:41 -0400
Received: from mail-co1nam03on0132.outbound.protection.outlook.com ([104.47.40.132]:30047
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbeHTUIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/OBFjfkbe6SeQ2uVy3Ypq5Qyo22PzvrYGrcRGpX+f4=;
 b=kTuYZq/8AR8vKjmlcm5tFB/NUP2e2ESQfaIwfzJzvcPiqm38Se1420Ww6lsjOORylpyHKz5z1mQlzgYrC5SOVufoe1V6DRjcbqG6vJk6gX+b6A43Q1BH0aG2ljPS2/rEGMnXuDCLG8SMdfRYeqOijlkQZw6/0ZqBFtJsnd9yAQ8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Mon, 20 Aug 2018 16:52:08 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:52:08 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 9/9] pack-objects: consider packs in multi-pack-index
Thread-Topic: [PATCH 9/9] pack-objects: consider packs in multi-pack-index
Thread-Index: AQHUOKYhnK7jzuKmJEGiJBbZ5EjvOw==
Date:   Mon, 20 Aug 2018 16:52:08 +0000
Message-ID: <20180820165124.152146-10-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;6:nqO0KywK3JKTcJ6RwaZGf4zXz4U/5ptBlk92vAaTv9Slggv2n02PQ6l5IrsFKn3j/IztkaJhUaJM8Kyhopz1x8L6LT/uHV7yfWpXnKWa3yK/HxLXOuYni8LEoys1vSatCmp8krSmBBUURxu2H8qjdvr704O2SjbvXJtKvfRX0vBMo6GlII91OsuEv6wjP2iemVikQTucGby9aRL00hOgvAcyLJIkMLTG7ElC2BFA0VVFO4Mhq3hqBTO+y59Tl0Pkq4qrm7TNYZQD8d/Izvv6KKa4j9Xu8msKjafyqnorJKLSaRiPzOOkVl3Yj32k4i7A3lTtYFjJcLwy49bHwwjdxMHgKmW6iyNUWkOeW6ShF8d39Ue60VGMWmOoYBeqHeI/QKbPfA+9UcGLuqO6wVwfUuFdEbhg5MtX9Qq0fDxfRQmxUuVBdCv6UQia4yFpDMz9tvA471y1khAou6Rlj3W4HA==;5:XsMMYJanIiMHIz7wyppwPs6Z22CPluLVPbj7LtPlqjjz1o9Ycr5vucQOMKPYW1wKAf6KipZ5aiByb6nAaCWCpkkhYN36fenGRFGHlSteuSaU8rwmeuiiijQ/bRNqDQLAhNY6a0ynl7Hr0UEFdUeL2BIQDJhbLxg25QKq1945/kE=;7:GvE8BvmcKIPrZyfXzjy+fDPhH8sf52baOz/T27ap/KMizRojAi41TjZVskeSSWjfLLjDeQN4R2yijNIgYYTYjiRWaKxHXlVM37Cxchjg9lCdHOhzMtV0J/o/Z/AINB+gjScdavAVsOKoODwf8MKoVqjtt8YmUSkBaJrxQJbkSAGFl8d8dTHbIhlwIKYmxIZNQ41BZpDWW0zg526HpHN1IfFlz/QMCRBPmq7dXBHy5FU5CBHtD9dEUVIxy9BM9bXm
x-ms-office365-filtering-correlation-id: 6eb51e6a-100e-482d-5dc7-08d606bd43e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
x-microsoft-antispam-prvs: <BL0PR2101MB09621C5C956905C652C3EFD3A1320@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(8676002)(476003)(5640700003)(68736007)(2616005)(2906002)(81166006)(14454004)(81156014)(1730700003)(446003)(7736002)(2351001)(305945005)(22452003)(5660300001)(36756003)(6436002)(1076002)(6916009)(6486002)(46003)(316002)(25786009)(6116002)(53936002)(486006)(14444005)(575784001)(86362001)(76176011)(8936002)(6512007)(97736004)(256004)(86612001)(107886003)(478600001)(52116002)(10290500003)(6346003)(186003)(10090500001)(11346002)(2900100001)(386003)(102836004)(5250100002)(4326008)(99286004)(2501003)(106356001)(105586002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: ycacxZtpI6SAL6M0rb2sEiyWYm7RTAqvrBhggUgoMF4KukXaLw4MyCGkLx5NXmssWee07zrcH2MuzSqO3AbEMKcKlSTYD4u2XUjuNVifimYc6UwERICu/y2dkGrnFl3bStnrPxALRzMRrbmhQbsLaf7FjIl6FAc6epeyw07O1UZYOssnV3RXCqrX29Ri6R96yO4+jQWinycacg7VRmQAHD8ry6FBl7xQhhCnRkBTjhIRmSBLhkYP7qpY26WfM5DayREyWOuF8PVlJTpzk1iPhXz4JPyWVDMyLy5TwIPufR/Dt0fS/UCZMB5KJAetl1QYsfuEgy07OPtmtBb/Utx2ifamkbXlBLEjH65/S8fLYnQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb51e6a-100e-482d-5dc7-08d606bd43e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:52:08.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git pack-objects --local', we want to avoid packing
objects that are in an alternate. Currently, we check for these
objects using the packed_git_mru list, which excludes the pack-files
covered by a multi-pack-index.

Add a new iteration over the multi-pack-indexes to find these
copies and mark them as unwanted.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/pack-objects.c      | 28 ++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh |  8 +++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a896d7810..4a9a42d29a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -31,6 +31,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "dir.h"
+#include "midx.h"
=20
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -1034,6 +1035,7 @@ static int want_object_in_pack(const struct object_id=
 *oid,
 {
 	int want;
 	struct list_head *pos;
+	struct multi_pack_index *m;
=20
 	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
@@ -1048,6 +1050,32 @@ static int want_object_in_pack(const struct object_i=
d *oid,
 		if (want !=3D -1)
 			return want;
 	}
+
+	for (m =3D get_multi_pack_index(the_repository); m; m =3D m->next) {
+		struct pack_entry e;
+		if (fill_midx_entry(oid, &e, m)) {
+			struct packed_git *p =3D e.p;
+			off_t offset;
+		=09
+			if (p =3D=3D *found_pack)
+				offset =3D *found_offset;
+			else
+				offset =3D find_pack_entry_one(oid->hash, p);
+
+			if (offset) {
+				if (!*found_pack) {
+					if (!is_pack_valid(p))
+						continue;
+					*found_offset =3D offset;
+					*found_pack =3D p;
+				}
+				want =3D want_found_object(exclude, p);
+				if (want !=3D -1)
+					return want;
+			}
+		}
+	}
+
 	list_for_each(pos, get_packed_git_mru(the_repository)) {
 		struct packed_git *p =3D list_entry(pos, struct packed_git, mru);
 		off_t offset;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 424d0c640f..6f56b38674 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -176,7 +176,13 @@ test_expect_success 'multi-pack-index and alternates' =
'
 compare_results_with_midx "with alternate (local midx)"
=20
 test_expect_success 'multi-pack-index in an alternate' '
-	mv .git/objects/pack/* alt.git/objects/pack
+	mv .git/objects/pack/* alt.git/objects/pack &&
+	test_commit add_local_objects &&
+	git repack --local &&
+	git multi-pack-index write &&
+	midx_read_expect 1 3 4 $objdir &&
+	git reset --hard HEAD~1 &&
+	rm -f .git/objects/pack/*
 '
=20
 compare_results_with_midx "with alternate (remote midx)"
--=20
2.18.0.118.gd4f65b8d14

