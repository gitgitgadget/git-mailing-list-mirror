Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8611F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeFDQxX (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:53:23 -0400
Received: from mail-sn1nam02on0116.outbound.protection.outlook.com ([104.47.36.116]:8650
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751599AbeFDQwz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMT/qr8T+WJ0dlG3vqd7bKwBDKeXH0VgF/IuuhGm/+A=;
 b=AhiYe5qGk9UklLSrIQZWhTLVkkGxDYwwcSQfG5Rei3mqsYtwy6/TRtc0A3Ku2OwB1bTsy6ESYL3/Dl/9PeboZYn2BuhwxqT9gsIfHvwAswHxYiQsxPl2uldtOJCNYq+JgX5OxVYQ1oNCdAscTFlnYKBajpoy/1YmCHqgVG81ohU=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1081.namprd21.prod.outlook.com (52.132.149.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.11; Mon, 4 Jun 2018 16:52:53 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:52:53 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 17/21] fsck: verify commit-graph
Thread-Topic: [PATCH v4 17/21] fsck: verify commit-graph
Thread-Index: AQHT/CR6TUxuO8tGq0GNy3j0EiQD4Q==
Date:   Mon, 4 Jun 2018 16:52:53 +0000
Message-ID: <20180604165200.29261-18-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1081;7:cvgEX23lrbyRggsTRullxVgJby6nHAzzlrJjO2abdJ81LQ47/AgQ1Ie7OWJJLwVF90PJBq+0lBtnaYhUoU6TvaYTQE5FS9m6/SP2jvbUinmaKkqq47LjKNwoTcmvTy/ozOCfTc7Wh/xIkA7qYyzTV0mXCvUDF72t2X2TSkjeFGxXMS+RyeKiO2FUYFBKescFItDlzu/F22z6n4JA+McMGLNmPCJ9zqIxU55G2KRY4zt1tXP3UD6Mil1QDnkbRtjG;20:isn+Vo9/UjFfyrR7WEJEHKPJ+FWSJlf52UGxtvdBAS/HabJJSeUDKkqIDcbzXnsExsrl1EjIeC4iSbnUeWPcCBGRfhMA1DLITdDDmbtOtBrDl1iWgRmSEoCteHSXJrGNmcx4AsDivL3fSGy5Iuoi5z5yddEgsZU3NRINCMt/Eu8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1081;
x-ms-traffictypediagnostic: MW2PR2101MB1081:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB10819C66193AB1F66064F054A1670@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1081;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1081;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(199004)(189003)(81156014)(486006)(8656006)(102836004)(6512007)(316002)(3280700002)(14454004)(1076002)(54906003)(186003)(107886003)(6116002)(478600001)(3660700001)(39060400002)(2616005)(386003)(2900100001)(99286004)(476003)(6506007)(10290500003)(59450400001)(86612001)(68736007)(11346002)(446003)(52116002)(76176011)(86362001)(575784001)(2906002)(53936002)(22452003)(36756003)(25786009)(6916009)(5660300001)(5640700003)(2501003)(97736004)(2351001)(4326008)(46003)(105586002)(6436002)(106356001)(10090500001)(15650500001)(6486002)(81166006)(8676002)(305945005)(5250100002)(8936002)(7736002)(1730700003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1081;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9RNQK6MFm/I0BjexIhpiIpO2YIxFZXAzGuqBhUFAa44fpeMgtvaafnLP2JxvJKM3RRDcpFXTe3BwVA4/1EOG8nrRrDql/b4y5/T9JLt9WZfGkMwEy9mpd3WsL2XUQNr+zjxgplYm4Rx9xecy2ucEUE0Rs1kRBPoc8yFefqil3JjNnLB6/Vc4m3OJDnmvzJlV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f1affc2f-1b64-45e7-a430-08d5ca3b9cc9
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1affc2f-1b64-45e7-a430-08d5ca3b9cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:52:53.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
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
index ef78c6c00c..a6d5045b77 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -16,6 +16,7 @@
 #include "streaming.h"
 #include "decorate.h"
 #include "packfile.h"
+#include "run-command.h"
=20
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -45,6 +46,7 @@ static int name_objects;
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
 #define ERROR_REFS 010
+#define ERROR_COMMIT_GRAPH 020
=20
 static const char *describe_object(struct object *obj)
 {
@@ -815,5 +817,24 @@ int cmd_fsck(int argc, const char **argv, const char *=
prefix)
 	}
=20
 	check_connectivity();
+
+	if (core_commit_graph) {
+		struct child_process commit_graph_verify =3D CHILD_PROCESS_INIT;
+		const char *verify_argv[] =3D { "commit-graph", "verify", NULL, NULL, NU=
LL, NULL };
+		commit_graph_verify.argv =3D verify_argv;
+		commit_graph_verify.git_cmd =3D 1;
+
+		if (run_command(&commit_graph_verify))
+			errors_found |=3D ERROR_COMMIT_GRAPH;
+
+		prepare_alt_odb();
+		for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
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
index 2297a44e7d..44d4c71f0b 100755
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

