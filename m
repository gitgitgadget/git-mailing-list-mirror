Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961B91F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbeGTRWS (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:18 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731000AbeGTRWS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6Qt3j//VoUbEsjIrCsLMCtvX5GsHyghxd9OcqmJG1o=;
 b=gEtp1e4FSHUqKUAuDKFrrJnMm7PqMvFIci5rwdCE0CLJ71Rc9SEsEGfL6+X2iHXtPimmTf+Cqxg6NZzUuy5XQn3ci3+XG/y5LELXWTJ2ODI56/gQnRmfqJFXoyoR5Hc3d1N+R4cmZ7JuAGvG9KoRgU5YmvY8o8yMKyShjKgXtXU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:09 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:09 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 05/18] upload-pack: make reachable() more generic
Thread-Topic: [PATCH v2 05/18] upload-pack: make reachable() more generic
Thread-Index: AQHUIEdYxm9rfcsRqUasx8jIBrI3Rg==
Date:   Fri, 20 Jul 2018 16:33:09 +0000
Message-ID: <20180720163227.105950-6-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:QYE/ogLZjyx4A7Yff6Wum5U8TFWdgCRD13VDx4pEHtoH3k+8EFWuEFNC8WxyO2lBT8nwp6uA/+DAxptSNz4vQ5jmcmsSuoeXgaTG0+TYED9PSYkrQELFpNMAoCOapXJdPHG6r85d681gFHRub5Zva+9LPqp+Qb5VcupYQpVoqVFmEYOrI/LI7O3M/gOqkJgb037F9l5fdzkTbsR2JF/ZwfC3Cqgkkkqco5J8Ag2PE3ADQ6Lj8TLnHvUeKpxb0XHLX4g62easB17veH3gYH/XWEr2X2Ccd2B7wasW6c2yXe3XF3Yg66ij84KNX3LDglaMZ+TW4tLJbXDQwQ8Y9s89lBnOZpSes2ISFNd10XZ9sarWmOm8MlBLCi/KtjltHOOGAW42Re2GPr9+v/MzdKsAoqP3ZUQHYxo5gMnUGENJJEi37+VxGMN4CkFpRe5pPGdaPHmpJFm9fZ+Pu6pPHIYLpw==;5:8S7+tXXxencxpogMmR0FR3UbqYC6zeHonCzZk9mPWK2hbHa3Qv2ANjkOm7ze6kuBGI5MVR4Hje+n4pio0WNWPgUQf9L8pP5yQFXp/ybVL/QxDaA9UcvP5hfxjXZwW1U4s9KKeyj8XHJlhMDp7uohXkvoaoyedNnIa0qyHuUtGEw=;7:x7Y/SMfiUhuSa0XC8614JDcQrKuy2CBSRJqm4b5RAhqAhsQnw4Xauq3R4ERXdAulLACkES245H6xApN+lx2qBI+ZB+AXcUDCd8Svf2n5dnXroqcvE9lp9ppzCXObxDWtMDoFqmp3epW0RpbJPi1gfM5nJabM1SqHeC1WiZMQhD8ZLWwG442Vms5k7AQEmJDiqiFZBpXzwEj0RRE6QafVc+K1I21vUeGvj85+nxMmsW0k8Yd5sc9r0EQqrPDQ7Ptm
x-ms-office365-filtering-correlation-id: 75253dbc-be71-4332-741a-08d5ee5e7a7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09292CB3D7D63CD7484179ABA1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(575784001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m9H9dTityuaAM/nGyvYo44xleotMjJQFHK3+WXWSmt28xtGNAqhLWZYzE8cou4ABsYQnaFPmYo7yzOAH05rltMZHOCgW+ya3UiQh1uo8gfm7h6j47uXh7TmeiuzHtS6SxTVxiKBTPsdxtMnftbdQgs7M9nxTb4AD1xnrMhL3Byt44iglwHy09RXbAOxGgyQkcCofdVHRGqCj2qdG48EtAhl/XyqBjx6sxQHLAylPuUKrRE9SKyPm+2TgySuvx/1t20dN+Uj2FNxIeUakII7SZwEItXCJ4Fn6GrlAFB6CaDZ9iHtE5OOKOiyyulDNdoFYuIyrNP8NlkkDZ1osojltrtXDkijFQ2cSP+lWRVCJ8qg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75253dbc-be71-4332-741a-08d5ee5e7a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:09.7140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of moving the reachable() method to commit-reach.c,
modify the prototype to be more generic to flags known outside of
upload-pack.c. Also rename 'want' to 'from' to make the statement
more clear outside of the context of haves/wants negotiation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 upload-pack.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4ca052d0b6..5a639cb47b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -336,17 +336,18 @@ static int got_oid(const char *hex, struct object_id =
*oid)
 	return 0;
 }
=20
-static int reachable(struct commit *want)
+static int reachable(struct commit *from, unsigned int with_flag,
+		     unsigned int assign_flag)
 {
 	struct prio_queue work =3D { compare_commits_by_commit_date };
=20
-	prio_queue_put(&work, want);
+	prio_queue_put(&work, from);
 	while (work.nr) {
 		struct commit_list *list;
 		struct commit *commit =3D prio_queue_get(&work);
=20
-		if (commit->object.flags & THEY_HAVE) {
-			want->object.flags |=3D COMMON_KNOWN;
+		if (commit->object.flags & with_flag) {
+			from->object.flags |=3D assign_flag;
 			break;
 		}
 		if (!commit->object.parsed)
@@ -362,10 +363,10 @@ static int reachable(struct commit *want)
 				prio_queue_put(&work, parent);
 		}
 	}
-	want->object.flags |=3D REACHABLE;
-	clear_commit_marks(want, REACHABLE);
+	from->object.flags |=3D REACHABLE;
+	clear_commit_marks(from, REACHABLE);
 	clear_prio_queue(&work);
-	return (want->object.flags & COMMON_KNOWN);
+	return (from->object.flags & assign_flag);
 }
=20
 static int ok_to_give_up(void)
@@ -390,7 +391,7 @@ static int ok_to_give_up(void)
 			want_obj.objects[i].item->flags |=3D COMMON_KNOWN;
 			continue;
 		}
-		if (!reachable((struct commit *)want))
+		if (!reachable((struct commit *)want, THEY_HAVE, COMMON_KNOWN))
 			return 0;
 	}
 	return 1;
--=20
2.18.0.118.gd4f65b8d14

