Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5269D1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966856AbeF2QMp (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:12:45 -0400
Received: from mail-cys01nam02on0130.outbound.protection.outlook.com ([104.47.37.130]:7270
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936867AbeF2QMm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVnz4hLg7swEVM/uWtm3STDnaSrcvlFqxEm+46DLzxc=;
 b=Zo7YusA0ZCx0J7rLnVlXZrFUxNWTdDiMTo03k2xopZUahNh8pCCrPGAQfTvCUu+vFs2v/AHUgNoSlpXOW8zLQR2htg/3oPll2GTtyK3ct6VVX5hEkYClu+EAd6eNcOpXabw3cdslNlwe3w3mr4cFvTbI59Y083lMyjBUwLx18K8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:40 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:40 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 02/13] commit-reach: move ref_newer from remote.c
Thread-Topic: [RFC PATCH 02/13] commit-reach: move ref_newer from remote.c
Thread-Index: AQHUD8QAwLbfOJFs5E2tAHaDhM+7Sg==
Date:   Fri, 29 Jun 2018 16:12:39 +0000
Message-ID: <20180629161223.229661-3-dstolee@microsoft.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:406:80::39) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:3RzDeE3rot7LNP/7WZbqE1KhlTzZjNvCnNJ6Gkp+xBdhMna81KNtX5kYpNAcTEV5HTSUpBNqZVf2vbysQNvtvTNNBYjRpD027+m9+MO9by1TH2VOBy2DBiMp7k31OQMV9vkxqGKPTsTBbzLiD3uy+QdQKsslSs7RmJWKtLZphWYpS8qlvz9B7dnVa2wtm5obw9wVLYg7tZ3LLNiU0ZiP26DOTmMRxC5nL1gcaixzKy9Kq1KAxZ7bG/pX5Xg/gnjr
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc3b9e88-f377-4177-3d75-08d5dddb22f3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
x-microsoft-antispam-prvs: <BL0PR2101MB0994765FA9C5129BF2916BE4A14E0@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(6346003)(486006)(476003)(97736004)(46003)(107886003)(575784001)(6506007)(386003)(186003)(446003)(86362001)(11346002)(86612001)(102836004)(6916009)(25786009)(6512007)(39060400002)(4326008)(2351001)(8936002)(1730700003)(14454004)(99286004)(81166006)(76176011)(81156014)(8676002)(5250100002)(14444005)(256004)(10290500003)(305945005)(7736002)(2501003)(52116002)(478600001)(2616005)(53936002)(5660300001)(36756003)(54906003)(106356001)(105586002)(68736007)(1076002)(316002)(2906002)(6116002)(22452003)(10090500001)(6436002)(2900100001)(5640700003)(6486002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: s3Qg5naReB52t6EoLtwWwymzxj16ZGLQa0xBJAtgcD1xZe9a8xoW2iUCr49rBxifyKqBFAfe8Vx5o8+6fdOiTR04Hgy2vzbmaETF4x6xEIxabYWykvXhbcW9HhTt5OXn5tWeu0qiVFxQoEymL3or62VEv6FiZZ6r8G9V4Ela3fWacAuNd6eE/qyKlGlg8XlAVLiYUYm5V9AG64CQS42RfW3D2YwDrR6V4KlFPe/Ye4smgamTPFqDzBYudyh3O+axGdkzvLFm+Nd0d6V8aDtRVj67cGELyUGze8sX8CdD0NW6nV80Z1VYWKk8aVRqpts9gYpwYCZqQuTb6TM1ds97PfzEcSqBvgvuMuoQn0AOUDk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3b9e88-f377-4177-3d75-08d5dddb22f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:39.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/remote.c |  1 +
 commit-reach.c   | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h   |  2 ++
 http-push.c      |  1 +
 remote.c         | 48 +-------------------------------------------
 remote.h         |  1 -
 6 files changed, 57 insertions(+), 48 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1a82d850a2..341f704ada 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "argv-array.h"
+#include "commit-reach.h"
=20
 static const char * const builtin_remote_usage[] =3D {
 	N_("git remote [-v | --verbose]"),
diff --git a/commit-reach.c b/commit-reach.c
index 1438393165..80cdb738f6 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,5 +1,10 @@
 #include "cache.h"
+#include "commit.h"
+#include "decorate.h"
 #include "prio-queue.h"
+#include "tree.h"
+#include "revision.h"
+#include "tag.h"
 #include "commit-reach.h"
=20
 /* Remember to update object flag allocation in object.h */
@@ -357,3 +362,50 @@ void reduce_heads_replace(struct commit_list **heads)
 	free_commit_list(*heads);
 	*heads =3D result;
 }
+
+static void unmark_and_free(struct commit_list *list, unsigned int mark)
+{
+	while (list) {
+		struct commit *commit =3D pop_commit(&list);
+		commit->object.flags &=3D ~mark;
+	}
+}
+
+int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid)
+{
+	struct object *o;
+	struct commit *old_commit, *new_commit;
+	struct commit_list *list, *used;
+	int found =3D 0;
+
+	/*
+	 * Both new_commit and old_commit must be commit-ish and new_commit is de=
scendant of
+	 * old_commit.  Otherwise we require --force.
+	 */
+	o =3D deref_tag(parse_object(old_oid), NULL, 0);
+	if (!o || o->type !=3D OBJ_COMMIT)
+		return 0;
+	old_commit =3D (struct commit *) o;
+
+	o =3D deref_tag(parse_object(new_oid), NULL, 0);
+	if (!o || o->type !=3D OBJ_COMMIT)
+		return 0;
+	new_commit =3D (struct commit *) o;
+
+	if (parse_commit(new_commit) < 0)
+		return 0;
+
+	used =3D list =3D NULL;
+	commit_list_insert(new_commit, &list);
+	while (list) {
+		new_commit =3D pop_most_recent_commit(&list, TMP_MARK);
+		commit_list_insert(new_commit, &used);
+		if (new_commit =3D=3D old_commit) {
+			found =3D 1;
+			break;
+		}
+	}
+	unmark_and_free(list, TMP_MARK);
+	unmark_and_free(used, TMP_MARK);
+	return found;
+}
diff --git a/commit-reach.h b/commit-reach.h
index 244f48c5f2..35ec9f0ddb 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -38,4 +38,6 @@ struct commit_list *reduce_heads(struct commit_list *head=
s);
  */
 void reduce_heads_replace(struct commit_list **heads);
=20
+int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid);
+
 #endif
diff --git a/http-push.c b/http-push.c
index 7e38522098..218315b00b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -13,6 +13,7 @@
 #include "argv-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "commit-reach.h"
=20
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
diff --git a/remote.c b/remote.c
index abe80c1397..dcb5a33fac 100644
--- a/remote.c
+++ b/remote.c
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "mergesort.h"
 #include "argv-array.h"
+#include "commit-reach.h"
=20
 enum map_direction { FROM_SRC, FROM_DST };
=20
@@ -1781,53 +1782,6 @@ int resolve_remote_symref(struct ref *ref, struct re=
f *list)
 	return 1;
 }
=20
-static void unmark_and_free(struct commit_list *list, unsigned int mark)
-{
-	while (list) {
-		struct commit *commit =3D pop_commit(&list);
-		commit->object.flags &=3D ~mark;
-	}
-}
-
-int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid)
-{
-	struct object *o;
-	struct commit *old_commit, *new_commit;
-	struct commit_list *list, *used;
-	int found =3D 0;
-
-	/*
-	 * Both new_commit and old_commit must be commit-ish and new_commit is de=
scendant of
-	 * old_commit.  Otherwise we require --force.
-	 */
-	o =3D deref_tag(parse_object(old_oid), NULL, 0);
-	if (!o || o->type !=3D OBJ_COMMIT)
-		return 0;
-	old_commit =3D (struct commit *) o;
-
-	o =3D deref_tag(parse_object(new_oid), NULL, 0);
-	if (!o || o->type !=3D OBJ_COMMIT)
-		return 0;
-	new_commit =3D (struct commit *) o;
-
-	if (parse_commit(new_commit) < 0)
-		return 0;
-
-	used =3D list =3D NULL;
-	commit_list_insert(new_commit, &list);
-	while (list) {
-		new_commit =3D pop_most_recent_commit(&list, TMP_MARK);
-		commit_list_insert(new_commit, &used);
-		if (new_commit =3D=3D old_commit) {
-			found =3D 1;
-			break;
-		}
-	}
-	unmark_and_free(list, TMP_MARK);
-	unmark_and_free(used, TMP_MARK);
-	return found;
-}
-
 /*
  * Lookup the upstream branch for the given branch and if present, optiona=
lly
  * compute the commit ahead/behind values for the pair.
diff --git a/remote.h b/remote.h
index 45ecc6cefa..56fb9cbb27 100644
--- a/remote.h
+++ b/remote.h
@@ -149,7 +149,6 @@ extern struct ref **get_remote_refs(int fd_out, struct =
packet_reader *reader,
 				    const struct string_list *server_options);
=20
 int resolve_remote_symref(struct ref *ref, struct ref *list);
-int ref_newer(const struct object_id *new_oid, const struct object_id *old=
_oid);
=20
 /*
  * Remove and free all but the first of any entries in the input list
--=20
2.18.0.118.gd4f65b8d14

