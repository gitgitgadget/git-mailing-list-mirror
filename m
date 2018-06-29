Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4EE1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966879AbeF2QM7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:12:59 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:34752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966868AbeF2QM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NwhYRD4QF1pa9jmbMBBltC6y4lha15ynRwc+aUQXbo=;
 b=lQcLcQCCOn0oOn7LArgC+eeIrP90q0K8hDCzTmZef+6QWptIHPh5fnfD564lhYx68nnBS6+scZQqPbhC/LpD1N9oY6pngiBpHeBWf16LS2c3PX+lNxJtkgoo6rcWn1w5d18QxNgKZZGfLoepWmhM/hYnMY+VjsaQc6eV1a8wMo8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:53 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:53 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 06/13] commit-reach: move can_all_from_reach_with_flag()
Thread-Topic: [RFC PATCH 06/13] commit-reach: move
 can_all_from_reach_with_flag()
Thread-Index: AQHUD8QIzfT8FLRM0EePHCVZf9QZ/A==
Date:   Fri, 29 Jun 2018 16:12:53 +0000
Message-ID: <20180629161223.229661-7-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:Rw8/WdfAIaqzZqtlK2PmZnNM/eIqWoElH4jGjO1jmuIFLQdWGZvpvpPc+PTZFxWgOasUmzuQ8FZby0zMbLejs4Brz6ZM4cNd8iA69N+gBKwE994HqAQKnKJi8vJIXBg7EFbMhPmipU+0KylBGn3kdbkUEQaPyRG2o2KWNe2IH1GXNxH86GQQJ6B1XWNk9WsNloAum61iiBKBUapmnx5TJ9RGLd9yyK8MzHRb7i4WwjZ56ThkhOdsbZETKcw1DRJA
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 887d9751-a61b-4abc-0792-08d5dddb2b18
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB10441647E36C7946396A4BF8A14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(14444005)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(76176011)(1076002)(52116002)(11346002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(446003)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 0G2dEBTRxRsymYhNnY3MODxaXDZMFqOczYT5c4IiHURvGs+r4C/mRvisAlSo6JpSWOi2i5DuInPO9F0EozoOuWFMfxnYMC1AhCEZIsTtTB0c/Ma8WzpiPpGXuF1GN/CfWwyEmxTz+N7f9vwzI8Gwc9UfZWs+bS69j4IL8GEQd1hKSA6IUGutyZKVm8WcldDW2RrhY0Iad+EA07tcFOf3Ll53VedJcoJ8EE/OUAmmcSzKhlPXBseL66cTrXkpOQ+Ji92xHWRiyjlUIABuSvBcZ74oA2WxLSbBc5aalFsRG9Hsgrwc21oH2K//ttzimXgw6eqR2uoIPPu7sLcMnObqTgDtYF01gG7e5hiMtpTNdsA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887d9751-a61b-4abc-0792-08d5dddb2b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:53.6406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h |  8 +++++++
 upload-pack.c  | 62 +++-----------------------------------------------
 3 files changed, 72 insertions(+), 59 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 6cfd7379ce..44c09669ec 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "commit-graph.h"
 #include "decorate.h"
 #include "prio-queue.h"
 #include "tree.h"
@@ -528,3 +529,63 @@ int commit_contains(struct ref_filter *filter, struct =
commit *commit,
 		return contains_tag_algo(commit, list, cache) =3D=3D CONTAINS_YES;
 	return is_descendant_of(commit, list);
 }
+
+static int reachable(struct commit *from, int with_flag, int assign_flag, =
time_t min_commit_date)
+{
+	struct prio_queue work =3D { compare_commits_by_commit_date };
+
+	prio_queue_put(&work, from);
+	while (work.nr) {
+		struct commit_list *list;
+		struct commit *commit =3D prio_queue_get(&work);
+
+		if (commit->object.flags & with_flag) {
+			from->object.flags |=3D assign_flag;
+			break;
+		}
+		if (!commit->object.parsed)
+			parse_object(&commit->object.oid);
+		if (commit->object.flags & TMP_MARK)
+			continue;
+		commit->object.flags |=3D TMP_MARK;
+		if (commit->date < min_commit_date)
+			continue;
+		for (list =3D commit->parents; list; list =3D list->next) {
+			struct commit *parent =3D list->item;
+			if (!(parent->object.flags & TMP_MARK))
+				prio_queue_put(&work, parent);
+		}
+	}
+	from->object.flags |=3D TMP_MARK;
+	clear_commit_marks(from, TMP_MARK);
+	clear_prio_queue(&work);
+	return (from->object.flags & assign_flag);
+}
+
+int can_all_from_reach_with_flag(struct object_array from,
+				 int with_flag, int assign_flag,
+				 time_t min_commit_date)
+{
+	int i;
+
+	for (i =3D 0; i < from.nr; i++) {
+		struct object *from_one =3D from.objects[i].item;
+
+		if (from_one->flags & assign_flag)
+			continue;
+		from_one =3D deref_tag(from_one, "a from object", 0);
+		if (!from_one || from_one->type !=3D OBJ_COMMIT) {
+			/* no way to tell if this is reachable by
+			 * looking at the ancestry chain alone, so
+			 * leave a note to ourselves not to worry about
+			 * this object anymore.
+			 */
+			from.objects[i].item->flags |=3D assign_flag;
+			continue;
+		}
+		if (!reachable((struct commit *)from_one, with_flag,
+			       assign_flag, min_commit_date))
+			return 0;
+	}
+	return 1;
+}
diff --git a/commit-reach.h b/commit-reach.h
index 986fb388d5..c3da8488eb 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -22,4 +22,12 @@ define_commit_slab(contains_cache, enum contains_result)=
;
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache);
=20
+/*
+ * Can every commit or tag in the 'from' array reach a commit that has
+ * the 'with_flag' bit on? Mark the commits in 'from' that can reach
+ * such commits with 'assign_flag'.
+ */
+int can_all_from_reach_with_flag(struct object_array from, int with_flag,
+				 int assign_flag, time_t min_commit_date);
+
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 2f09cadbc0..7c58cb8f5e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -22,6 +22,7 @@
 #include "quote.h"
 #include "upload-pack.h"
 #include "serve.h"
+#include "commit-reach.h"
=20
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -333,70 +334,13 @@ static int got_oid(const char *hex, struct object_id =
*oid)
 	return 0;
 }
=20
-static int reachable(struct commit *from, int with_flag, int assign_flag)
-{
-	struct prio_queue work =3D { compare_commits_by_commit_date };
-
-	prio_queue_put(&work, from);
-	while (work.nr) {
-		struct commit_list *list;
-		struct commit *commit =3D prio_queue_get(&work);
-
-		if (commit->object.flags & with_flag) {
-			from->object.flags |=3D assign_flag;
-			break;
-		}
-		if (!commit->object.parsed)
-			parse_object(&commit->object.oid);
-		if (commit->object.flags & TMP_MARK)
-			continue;
-		commit->object.flags |=3D TMP_MARK;
-		if (commit->date < oldest_have)
-			continue;
-		for (list =3D commit->parents; list; list =3D list->next) {
-			struct commit *parent =3D list->item;
-			if (!(parent->object.flags & TMP_MARK))
-				prio_queue_put(&work, parent);
-		}
-	}
-	from->object.flags |=3D TMP_MARK;
-	clear_commit_marks(from, TMP_MARK);
-	clear_prio_queue(&work);
-	return (from->object.flags & assign_flag);
-}
-
-static int can_all_from_reach_with_flag(struct object_array from,
-					int with_flag, int assign_flag)
-{
-	int i;
-
-	for (i =3D 0; i < from.nr; i++) {
-		struct object *from_one =3D from.objects[i].item;
-
-		if (from_one->flags & assign_flag)
-			continue;
-		from_one =3D deref_tag(from_one, "a from object", 0);
-		if (!from_one || from_one->type !=3D OBJ_COMMIT) {
-			/* no way to tell if this is reachable by
-			 * looking at the ancestry chain alone, so
-			 * leave a note to ourselves not to worry about
-			 * this object anymore.
-			 */
-			from.objects[i].item->flags |=3D assign_flag;
-			continue;
-		}
-		if (!reachable((struct commit *)from_one, with_flag, assign_flag))
-			return 0;
-	}
-	return 1;
-}
-
 static int ok_to_give_up(void)
 {
 	if (!have_obj.nr)
 		return 0;
=20
-	return can_all_from_reach_with_flag(want_obj, THEY_HAVE, COMMON_KNOWN);
+	return can_all_from_reach_with_flag(want_obj, THEY_HAVE,
+					    COMMON_KNOWN, oldest_have);
 }
=20
 static int get_common_commits(void)
--=20
2.18.0.118.gd4f65b8d14

