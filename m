Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A531FD4F
	for <e@80x24.org>; Thu, 31 May 2018 17:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755847AbeEaRlT (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:41:19 -0400
Received: from mail-bn3nam01on0126.outbound.protection.outlook.com ([104.47.33.126]:26772
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755784AbeEaRlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTnS1sdKVyGcvkb+Bh+fLC6KT1oJcLzKJSqMcaO9ck8=;
 b=e5HH406WVBgtOZCcacip5pACxvEik4fVdm7Pj//RXpERikTosJROgzmrFIgV3Q5ny/lRlHQvLFMfS0HZG+mAx4yM+VgJaOUHVle0FVOYgeO0PxiYijAdl0hipHUI4iKkH8nFmnDJTnNv8Hyb0f0QOhsnkFETA305mLKNWT690i8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.6; Thu, 31 May 2018 17:41:08 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1%5]) with mapi id 15.20.0841.006; Thu, 31 May 2018
 17:41:08 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 1/6] DO NOT MERGE: compute commit-graph on every commit
Thread-Topic: [RFC PATCH 1/6] DO NOT MERGE: compute commit-graph on every
 commit
Thread-Index: AQHT+QaOQ8EEsZyydE25FB8YvECT/Q==
Date:   Thu, 31 May 2018 17:41:08 +0000
Message-ID: <20180531174024.124488-2-dstolee@microsoft.com>
References: <20180531174024.124488-1-dstolee@microsoft.com>
In-Reply-To: <20180531174024.124488-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:wI4gQlpzBlOopGabewsGzjaS3HXwCsIZwdzpNJmQWipxQvQWU7BDr9X7oc9Z+eCO1Xy++bdXieXvC3r2o6C7F28tgLD15+fHGlGHAAfKHWP7x1qpuoI55z/Yepf+WSY8GeKLjEq6mLMdjpAcZA6pla2Tq/raK4+BaWxCJZbcMls1fLvc5MkPGp5aZXZJNbOtHMkmSP0rueLPeIGm95vK0K3YVG+OrWXRGMmBqoRuqq+Ni95fAypSS8by23WJnRrA;20:WeL7rGGOLQ/Rg8FtZN3X8WiryI3Vitkz/d1OlplttoGwhG0CZR1G1wRGvDcxK2pcaVP1AdeLDG36CYLUEPJ+QzNvayyprTqRHkb4l0wJJg0eFKUsA7L5+40Gc5Q89V17mZ5UcUSbBve5z1MD1Jf5R+7BU3NnCNTg6QSbnFXjapU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09776428C76730F1110EF37CA1630@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(346002)(39380400002)(376002)(189003)(199004)(5250100002)(2351001)(6512007)(10090500001)(97736004)(186003)(3660700001)(54906003)(68736007)(3280700002)(2900100001)(46003)(575784001)(53936002)(86612001)(86362001)(6486002)(36756003)(6116002)(1076002)(478600001)(99286004)(14454004)(102836004)(316002)(2616005)(6506007)(25786009)(11346002)(8936002)(305945005)(386003)(6916009)(6436002)(5660300001)(2906002)(81156014)(81166006)(476003)(76176011)(5640700003)(8676002)(446003)(59450400001)(107886003)(22452003)(2501003)(1730700003)(486006)(52116002)(106356001)(7736002)(10290500003)(105586002)(39060400002)(4326008)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M4gKoegv0WusbBYwkap9szbvW1fsptUU4F47q/md/FhdwGluwJXufe4lNdNjF1JqXns3yGLy0WNMmWOT8bb4ykIT/pMPsFDF5cBsqiQGFTh1mzN+8yx/LHtg1nTuQ/xOpoZ1iwh8iQbS+bKtHr8V9JckR5HjZj/AmXCJg10PWcmbL8bYpNylVAja01CsI5oC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 574a0457-7746-4867-15f2-08d5c71db087
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574a0457-7746-4867-15f2-08d5c71db087
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 17:41:08.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also enable core.commitGraph and gc.commitGraph. Helps to test the
commit-graph feature with the rest of the test infrastructure.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c | 5 +++++
 builtin/gc.c     | 2 +-
 environment.c    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e8e8d13be4..8751b816c1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -32,6 +32,7 @@
 #include "column.h"
 #include "sequencer.h"
 #include "mailmap.h"
+#include "commit-graph.h"
=20
 static const char * const builtin_commit_usage[] =3D {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -1623,5 +1624,9 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
=20
 	UNLEAK(err);
 	UNLEAK(sb);
+
+	if (core_commit_graph)
+		write_commit_graph_reachable(get_object_directory(), 1);
+
 	return 0;
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index efd214a59f..999c09d8e2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -35,7 +35,7 @@ static int aggressive_depth =3D 50;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
-static int gc_commit_graph =3D 0;
+static int gc_commit_graph =3D 1;
 static int detach_auto =3D 1;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire =3D "1.day.ago";
diff --git a/environment.c b/environment.c
index 8853e2f0dd..fdb2d56d90 100644
--- a/environment.c
+++ b/environment.c
@@ -62,7 +62,7 @@ enum push_default_type push_default =3D PUSH_DEFAULT_UNSP=
ECIFIED;
 enum object_creation_mode object_creation_mode =3D OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
-int core_commit_graph;
+int core_commit_graph =3D 1;
 int core_apply_sparse_checkout;
 int merge_log_config =3D -1;
 int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition() *=
/
--=20
2.16.2.338.gcfe06ae955

