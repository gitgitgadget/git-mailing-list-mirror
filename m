Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556AE1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeFHN4h (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:37 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:37792
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752680AbeFHN4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO0V/ktNWTkkauX5Yu2H9bEKQejQLKSlJfZm+ZRvVOo=;
 b=gh3RezQLP0DOsd8TtsYfyHprQUbLpGhHhgx1XceSoeeBX+o070d+nEU0Yiwy5qL2ASabL41AVQarH8zpv5DnEYFVFndK2ZFT3TZ1T9hwY+tFxHQpgOyLkUQFexvzvmMSk19DkrNihh1R695T0WP7mAFTQBkx+HvhdxOvj2AcS7o=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0963.namprd21.prod.outlook.com (52.132.20.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:27 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:27 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 17/21] fsck: verify commit-graph
Thread-Topic: [PATCH v6 17/21] fsck: verify commit-graph
Thread-Index: AQHT/zB+kjJW2dHH5k+MURRJyMmc+Q==
Date:   Fri, 8 Jun 2018 13:56:27 +0000
Message-ID: <20180608135548.216405-18-dstolee@microsoft.com>
References: <20180606113611.87822-1-dstolee@microsoft.com>
 <20180608135548.216405-1-dstolee@microsoft.com>
In-Reply-To: <20180608135548.216405-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:404:f7::33) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0963;7:9CjU31X7lEAbjyjZw4hd2laoO03WDfBDyJZuxe4whXOIhuxbUbqlIRj93gHbsibC0VKuJFdLCCY8tmge4IFBB8NG2BwRPbIouiO8rWhyZVrY8WMvH5FuwxaPhxkM0AQAP2kV1sqzuNfFmvrpRk9acJ1OWv7S4R+iwhUnfQEz8Asf3v9PIdvyJ9bBViffFN4EaXSNhMCDRHPa97t/D2ew/7/JS6SjehxpEGnk4rokQdtQ96kDLLDSfuPwx8MIJkDd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0963;
x-ms-traffictypediagnostic: BL0PR2101MB0963:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09636A16B15385D4B10366B4A17B0@BL0PR2101MB0963.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0963;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0963;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(189003)(199004)(6116002)(81166006)(1076002)(5660300001)(186003)(8936002)(478600001)(10290500003)(81156014)(1730700003)(8676002)(59450400001)(486006)(76176011)(7736002)(386003)(476003)(102836004)(446003)(6506007)(305945005)(11346002)(2616005)(6916009)(25786009)(105586002)(2900100001)(106356001)(46003)(68736007)(10090500001)(22452003)(6436002)(52116002)(15650500001)(5640700003)(36756003)(6486002)(2906002)(3660700001)(107886003)(8656006)(97736004)(99286004)(3280700002)(2351001)(4326008)(54906003)(6512007)(316002)(53936002)(86612001)(5250100002)(86362001)(2501003)(39060400002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0963;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9zytfD3y2LTCD6Jrz8FBk8nh0TLHPho9gQCkrEk/HmYBGOPKO323zi1XPqjdiXuQi2ILGltLydFP8WaCn+xmpwtOQaBXp3TjwcAEZXvhVI7EiWoSiWW2+bP/SWfVxmYgbErFgDxYCZFxvVNp48BlvzYweB9eLPc0pRDBt2zr6VNbE5Ty3WTZvKUUGPAKown2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ee582942-5b18-48f8-e9f9-08d5cd47a0e2
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee582942-5b18-48f8-e9f9-08d5cd47a0e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:27.2693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0963
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If core.commitGraph is true, verify the contents of the commit-graph
during 'git fsck' using the 'git commit-graph verify' subcommand. Run
this check on all alternates, as well.

We use a new process for two reasons:

1. The subcommand decouples the details of loading and verifying a
   commit-graph file from the other fsck details.

2. The commit-graph verification requires the commits to be loaded
   in a specific order to guarantee we parse from the commit-graph
   file for some objects and from the object database for others.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-fsck.txt |  3 +++
 builtin/fsck.c             | 21 +++++++++++++++++++++
 t/t5318-commit-graph.sh    |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index b9f060e3b2..ab9a93fb9b 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -110,6 +110,9 @@ Any corrupt objects you will have to find in backups or=
 other archives
 (i.e., you can just remove them and do an 'rsync' with some other site in
 the hopes that somebody else has the object you have corrupted).
=20
+If core.commitGraph is true, the commit-graph file will also be inspected
+using 'git commit-graph verify'. See linkgit:git-commit-graph[1].
+
 Extracted Diagnostics
 ---------------------
=20
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3ad4f160f9..9fb2edc69f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -18,6 +18,7 @@
 #include "decorate.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "run-command.h"
=20
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -47,6 +48,7 @@ static int name_objects;
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
 #define ERROR_REFS 010
+#define ERROR_COMMIT_GRAPH 020
=20
 static const char *describe_object(struct object *obj)
 {
@@ -822,5 +824,24 @@ int cmd_fsck(int argc, const char **argv, const char *=
prefix)
 	}
=20
 	check_connectivity();
+
+	if (core_commit_graph) {
+		struct child_process commit_graph_verify =3D CHILD_PROCESS_INIT;
+		const char *verify_argv[] =3D { "commit-graph", "verify", NULL, NULL, NU=
LL };
+		commit_graph_verify.argv =3D verify_argv;
+		commit_graph_verify.git_cmd =3D 1;
+
+		if (run_command(&commit_graph_verify))
+			errors_found |=3D ERROR_COMMIT_GRAPH;
+
+		prepare_alt_odb(the_repository);
+		for (alt =3D  the_repository->objects->alt_odb_list; alt; alt =3D alt->n=
ext) {
+			verify_argv[2] =3D "--object-dir";
+			verify_argv[3] =3D alt->path;
+			if (run_command(&commit_graph_verify))
+				errors_found |=3D ERROR_COMMIT_GRAPH;
+		}
+	}
+
 	return errors_found;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index bd5b8428af..0da5a51552 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -399,4 +399,12 @@ test_expect_success 'detect invalid checksum hash' '
 		"incorrect checksum"
 '
=20
+test_expect_success 'git fsck (checks commit-graph)' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git fsck &&
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum" &&
+	test_must_fail git fsck
+'
+
 test_done
--=20
2.18.0.rc1

